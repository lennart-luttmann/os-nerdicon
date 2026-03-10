const std = @import("std");

/// Path of text file containing default icon.
const DEFAULT_ICON_PATH = "icons/default.txt";

/// Path of csv file containing id-icon map.
const ICON_CSV_PATH = "icons/kvps.csv";

/// Path of files containing the os release information.
const OS_RELEASE_PATHS = [_][]const u8{ "/etc/os-release", "/usr/lib/os-release" };

/// Stores the default icon that should be returned incase the provided id does not have a match.
pub const default_icon: [*:0]const u8 = _fn: {
    break :_fn @embedFile(DEFAULT_ICON_PATH);
};

/// Stores a comptime map of distro ids and their corresponding icons.
pub const icon_map = _fn: {

    // Embed csv.
    @setEvalBranchQuota(std.math.maxInt(u32));
    const csv_icon_data = @embedFile(ICON_CSV_PATH);

    // Tokenize lines.
    var temp_lines = std.mem.tokenizeScalar(u8, csv_icon_data, '\n');
    var actual_line_count: u32 = 0;
    while (temp_lines.next()) |line| {
        if (line.len > 0) actual_line_count += 1;
    }
    var lines = std.mem.tokenizeScalar(u8, csv_icon_data, '\n');
    var entries: [actual_line_count]struct { []const u8, [*:0]const u8 } = undefined;

    // Parse lines into KVPs.
    var index: usize = 0;
    while (index < actual_line_count) {
        const line = lines.next() orelse break;
        if (line.len == 0) continue;
        var parts = std.mem.tokenizeScalar(u8, line, ',');
        const id = parts.next() orelse continue;
        const icon: [*:0]const u8 = (parts.next() orelse continue) ++ "";
        entries[index] = .{ id, icon };
        index += 1;
    }

    // Construct map.
    break :_fn std.StaticStringMap([*:0]const u8).initComptime(entries[0..index]);
};

/// Returns the corresponding icon for the used distribution.
pub fn getIcon() [*:0]const u8 {

    // Init file reader.
    const file = _fn: {
        for (OS_RELEASE_PATHS) |release_path| {
            const f = std.fs.cwd().openFile(release_path, .{ .mode = .read_only }) catch {
                std.log.debug("Could not find release file at [{s}]", .{release_path});
                continue;
            };
            break :_fn f;
        }
        break :_fn null;
    } orelse {
        std.log.warn("Could not find any os release file. Using default.", .{});
        return default_icon;
    };
    defer file.close();
    var reader_scratch_buffer: [4096]u8 = undefined;
    var reader = file.reader(&reader_scratch_buffer);

    // Retrieve id from os release.
    var icon_buffer: ?[*:0]const u8 = null;
    while (reader.interface.takeDelimiter('\n') catch |err| switch (err) {
        error.StreamTooLong => null,
        else => {
            std.log.warn("Unexpected error during read stream: [{any}].", .{err});
            return icon_buffer orelse default_icon;
        },
    }) |line| {

        // Find concrete id.
        if (std.mem.startsWith(u8, line, "ID=")) {
            const name = std.mem.trim(u8, line[3..], "\n =\"");
            if (icon_map.get(name)) |icon| {
                icon_buffer = icon;
                break;
            } else {
                std.log.debug("No icon found specific distribution [{s}]", .{name});
            }
        }

        // Find like id.
        else if (std.mem.startsWith(u8, line, "ID_LIKE=")) {
            const like_names = std.mem.trim(u8, line[8..], "\n =\"");
            var like_names_tokens = std.mem.tokenizeScalar(u8, like_names, ' ');
            while (like_names_tokens.next()) |like_name| {
                if (icon_map.get(like_name)) |icon| {
                    icon_buffer = icon;
                    break;
                } else {
                    std.log.debug("No icon found for similar distribution [{s}]", .{like_name});
                }
            }
        }
    }

    // Fall back to default.
    return icon_buffer orelse {
        std.log.warn("No valid distribution icon found. Using default.", .{});
        return default_icon;
    };
}
