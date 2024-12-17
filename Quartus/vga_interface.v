module vga_interface (
    input wire clk,                // 50 MHz clock from the board
    input wire reset_n,            // Reset (active low)
    input wire [6143:0] grid_flat, // Flattened 64x48 grid of 2-bit color values as a single wire bus
    output reg [3:0] vga_r,        // VGA Red output (4 bits)
    output reg [3:0] vga_g,        // VGA Green output (4 bits)
    output reg [3:0] vga_b,        // VGA Blue output (4 bits)
    output reg vga_hs,             // VGA Horizontal Sync
    output reg vga_vs              // VGA Vertical Sync
);

    // VGA timing parameters for 640x480 @ 60 Hz
    localparam H_DISPLAY = 640;  // Horizontal display area
    localparam H_FRONT   = 16;   // Horizontal front porch
    localparam H_SYNC    = 96;   // Horizontal sync pulse
    localparam H_BACK    = 48;   // Horizontal back porch
    localparam H_TOTAL   = 800;  // Total horizontal time

    localparam V_DISPLAY = 480;  // Vertical display area
    localparam V_FRONT   = 10;   // Vertical front porch
    localparam V_SYNC    = 2;    // Vertical sync pulse
    localparam V_BACK    = 33;   // Vertical back porch
    localparam V_TOTAL   = 525;  // Total vertical time

    // Grid parameters
    localparam GRID_WIDTH  = 64;
    localparam GRID_HEIGHT = 48;
    localparam SCALE_X     = 10; // Horizontal scale factor (10x10 blocks)
    localparam SCALE_Y     = 10; // Vertical scale factor (10x10 blocks)
    
    // Registers for VGA timing
    reg [10:0] h_count = 0;
    reg [9:0] v_count = 0;

    // Active video signal
    wire h_active = (h_count < H_DISPLAY);
    wire v_active = (v_count < V_DISPLAY);
    wire active_video = h_active && v_active;

    // Horizontal and vertical sync signals
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            h_count <= 0;
            v_count <= 0;
        end else begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= 0;
                if (v_count == V_TOTAL - 1) begin
                    v_count <= 0;
                end else begin
                    v_count <= v_count + 1;
                end
            end else begin
                h_count <= h_count + 1;
            end
        end
    end

    // Sync signal generation
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            vga_hs <= 1;
            vga_vs <= 1;
        end else begin
            vga_hs <= (h_count >= H_DISPLAY + H_FRONT) && (h_count < H_DISPLAY + H_FRONT + H_SYNC) ? 0 : 1;
            vga_vs <= (v_count >= V_DISPLAY + V_FRONT) && (v_count < V_DISPLAY + V_FRONT + V_SYNC) ? 0 : 1;
        end
    end
    
    // Map grid values to screen pixels
    wire [5:0] grid_x = h_count / SCALE_X; // Grid X index
    wire [5:0] grid_y = v_count / SCALE_Y; // Grid Y index

    // Extract 2-bit grid value from the flattened grid
    wire [11:0] grid_index = grid_x + grid_y * GRID_WIDTH;
    wire [1:0] grid_value = (grid_x < GRID_WIDTH && grid_y < GRID_HEIGHT) ? grid_flat[grid_index * 2 +: 2] : 2'b00;

    // Define 4 colors based on grid_value
    reg [3:0] color_r, color_g, color_b;
    always @(*) begin
        case (grid_value)
            2'b00: {color_r, color_g, color_b} = {4'h0, 4'h0, 4'h0}; // Black
            2'b01: {color_r, color_g, color_b} = {4'hF, 4'h0, 4'h0}; // Red
            2'b10: {color_r, color_g, color_b} = {4'h0, 4'hF, 4'h0}; // Green
            2'b11: {color_r, color_g, color_b} = {4'h0, 4'h0, 4'hF}; // Blue
            default: {color_r, color_g, color_b} = {4'h0, 4'h0, 4'h0}; // Default to Black
        endcase
    end

    // Assign VGA signals
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            vga_r <= 0;
            vga_g <= 0;
            vga_b <= 0;
        end else if (active_video) begin
            vga_r <= color_r;
            vga_g <= color_g;
            vga_b <= color_b;
        end else begin
            vga_r <= 0;
            vga_g <= 0;
            vga_b <= 0;
        end
    end
endmodule
