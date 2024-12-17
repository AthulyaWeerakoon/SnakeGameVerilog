module master_controller (
    input wire clk,                // 50 MHz clock
    input wire reset_n,            // Reset (active low)
    output wire [3:0] vga_r,       // VGA Red output (4 bits)
    output wire [3:0] vga_g,       // VGA Green output (4 bits)
    output wire [3:0] vga_b,       // VGA Blue output (4 bits)
    output wire vga_hs,            // VGA Horizontal Sync
    output wire vga_vs             // VGA Vertical Sync
);

    // Declare the 64x48 grid wire
    wire [1:6143] grid_flat;

    // Instantiate the game controller
    game_controller game_ctrl (
        .clk(clk),
        .reset_n(reset_n),
        .grid_flat(grid_flat)
    );

    // Instantiate the VGA interface
    vga_interface vga_ctrl (
        .clk(clk),
        .reset_n(reset_n),
        .grid_flat(grid_flat),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs)
    );
endmodule
