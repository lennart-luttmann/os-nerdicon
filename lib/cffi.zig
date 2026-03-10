const nerdicon = @import("osnerdicon.zig");

/// Returns nerdcon for os distribution.
export fn osnerdicon_getIcon() callconv(.c) [*:0]const u8 {
    return nerdicon.getIcon();
}
