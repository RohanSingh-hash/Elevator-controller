`timescale 1ns / 1ps

module tb_Elevator_control;

    reg clk;
    reg reset;
    reg [3:0] floor_req;
    reg emergency_stop;
    wire move_up;
    wire move_down;
    wire motor_stop;
    wire [1:0] current_floor;


    Elevator_control dut (
        .clk(clk),
        .reset(reset),
        .floor_req(floor_req),
        .emergency_stop(emergency_stop),
        .move_up(move_up),
        .move_down(move_down),
        .motor_stop(motor_stop),
        .current_floor(current_floor)
    );

    
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        floor_req = 4'b0000;
        emergency_stop = 0;

        // reset
        #20;
        reset = 0;

        // Request Floor 3
        #10;
        floor_req = 4'b1000;

        // Let elevator move
        #60;
        floor_req = 4'b0000;

        // Request Floor 1 
        #20;
        floor_req = 4'b0010;

        #40;
        floor_req = 4'b0000;

        // Trigger emergency stop
        #20;
        emergency_stop = 1;

        #30;
        emergency_stop = 0;

        // Request Floor 2 after emergency
        #20;
        floor_req = 4'b0100;

        #50;
        floor_req = 4'b0000;
        
        #50;
        $finish;
    end

endmodule
