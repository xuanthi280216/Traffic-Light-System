module traffic_light_system (
    input clk,                  //74.25MHz
    input rst_n,                //Active LOW
    output [2:0] traf_light,    //3 bits traffic light
    output [1:0] ped_light      //2 bits pedestrian light
    );

    //wire clk, rst_n;
    //reg [2:0] traf_light;
    //reg [1:0] ped_light;
    wire w_1Hz;

    oneHz_gen og (.clk(clk), .rst_n(rst_n),
                  .clk_1Hz(w_1Hz)
                 );
    state_machine sm (.clk_1Hz(w_1Hz), .rst_n(rst_n),
                      .traf_state(traf_light), .ped_state(ped_light)
                     );

endmodule