module oneHz_gen (
    input wire clk,     //74.25MHz
    input wire rst_n,   //Active LOW
    output wire clk_1Hz
    );

    reg clk_1Hz_reg = 1'b0;
    reg [25:0] counter_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_reg <= 26'd0;
        end
        else if (counter_reg == 26'd37124999) begin
            counter_reg <= 26'd0;
            clk_1Hz_reg <= ~clk_1Hz_reg;
        end
        else begin
            counter_reg <= counter_reg + 26'd1;
        end
    end
    assign clk_1Hz = clk_1Hz_reg;

endmodule