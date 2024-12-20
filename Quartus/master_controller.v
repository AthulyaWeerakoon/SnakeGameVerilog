module master_controller (
    input wire clk,                // 50 MHz clock
    output wire [7:0] vga_r,       // VGA Red output (8 bits)
    output wire [7:0] vga_g,       // VGA Green output (8 bits)
    output wire [7:0] vga_b,       // VGA Blue output (8 bits)
    output wire vga_hs,            // VGA Horizontal Sync
    output wire vga_vs,            // VGA Vertical Sync
    output wire vga_clk,           // VGA Clock for the DAC
    output wire vga_sync_n,        // VGA Sync (active low)
    output wire vga_blank_n        // VGA Blanking (active low)
);

    // Declare the 64x48 grid wire
    wire [6143:0] grid_flat;

    // Instantiate the game controller
    game_controller game_ctrl (
        .clk(clk),
        .grid_flat(grid_flat)
    );

    // Instantiate the VGA interface
    vga_interface vga_ctrl (
        .clk(clk),
        .grid_flat(grid_flat),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs),
        .vga_clk(vga_clk),
        .vga_sync_n(vga_sync_n),
        .vga_blank_n(vga_blank_n)
    );
endmodule
