module simple_led_test (
    input wire clk,               // Clock signal (from the board)
    input wire [3:0] sw,         // 4 switches (SW[3:0])
    input wire btn,              // 1 button (BTN)
    output reg [3:0] led         // 4 LEDs (LED[3:0])
);

// Internal signal for debouncing the button press
reg btn_d, btn_d2;
reg [23:0] counter;            // 24-bit counter for timing

// Simple debouncing of button
always @(posedge clk) begin
    btn_d <= btn;
    btn_d2 <= btn_d;
end

// Toggle LEDs on button press
always @(posedge clk) begin
    if (btn_d && ~btn_d2) begin
        led <= sw;  // On button press, output switch states to LEDs
    end
end

endmodule