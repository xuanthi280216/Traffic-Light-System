module state_machine (
    input wire clk_1Hz,
    input wire rst_n,               //Active LOW
    output reg [2:0] traf_state,   //3 bits traffic state
    output reg [1:0] ped_state     //2 bits pedestrian state
    );

    //Define states
    parameter traf_red_ped_green    = 2'b00;
    parameter traf_yellow_ped_red   = 2'b01;
    parameter traf_green_ped_red    = 2'b10;

    //The state register
    reg [1:0] state_reg;            //3 states = 2 bits

    // Timer for light changes
    reg [4:0] light_counter = 5'd0; //traf red = 10s
                                    //traf yellow = 1s
                                    //traf green = 10s
                                    //ped red = 11s
                                    //ped green = 10s
                                    //total = 21s
    
    //Light Counter control
    always @(posedge clk_1Hz or negedge rst_n) begin
        if (!rst_n) begin
            light_counter <= 0;
        end
        else if (light_counter == 5'd21) begin
            light_counter <= 0;
        end
        else begin
            light_counter <= light_counter + 5'd1;
        end
    end
    
    //Next state logic
    always @(posedge clk_1Hz or negedge rst_n) begin
        if (!rst_n) begin
            state_reg <= traf_red_ped_green;    //reset state
        end
        else begin
            case (state_reg)
                traf_red_ped_green  : 
                    if (light_counter == 5'd10) begin
                        state_reg <= traf_yellow_ped_red;
                    end 
                traf_yellow_ped_red :
                    if (light_counter == 5'd11) begin
                        state_reg <= traf_green_ped_red;
                    end
                traf_green_ped_red :
                    if (light_counter == 5'd21) begin
                        state_reg <= traf_red_ped_green;
                    end
                default: state_reg <= traf_red_ped_green;
            endcase
        end
    end

    //Combination output logic
    always @(*) begin
        case (state_reg) 
            traf_red_ped_green  : begin
                traf_state  = 3'b001;   //red
                ped_state   = 2'b01;    //green      
            end
            traf_yellow_ped_red  : begin
                traf_state  = 3'b010;   //yellow
                ped_state   = 2'b10;    //red     
            end
            traf_green_ped_red  : begin
                traf_state  = 3'b100;   //green
                ped_state   = 2'b10;    //red     
            end
            default: begin
                traf_state  = 3'b001;   //red
                ped_state   = 2'b01;    //green   
            end
        endcase
    end
endmodule