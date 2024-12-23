module game_controller (
    input wire clk,                   // 50 MHz clock
    output reg [6143:0] grid_flat     // Flattened 64x48 grid output as a single wire bus
);

    // Internal 2D representation of the grid
    reg [1:0] grid[63:0][47:0];

    integer x, y;

    always @(posedge clk) begin
        // Dynamic pattern: alternate green and blue based on position
        for (x = 0; x < 64; x = x + 1) begin
            for (y = 0; y < 48; y = y + 1) begin
                if ((x + y) % 2 == 0) begin
                    grid[x][y] <= 2'b10; // Green
                end else begin
                    grid[x][y] <= 2'b11; // Blue
                end
            end
        end

        // Flatten the 2D array into the single wire bus output
        for (x = 0; x < 64; x = x + 1) begin
            for (y = 0; y < 48; y = y + 1) begin
                grid_flat[(y * 64 + x) * 2 +: 2] <= grid[x][y];
            end
        end
    end
endmodule
