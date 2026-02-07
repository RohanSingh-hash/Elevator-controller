`timescale 1ns / 1ps

module Elevator_control(
    input clk, reset,
    input [3:0] floor_req,
    input emergency_stop,
    output reg move_up,
    output reg move_down,
    output reg motor_stop,
    output reg [1:0] current_floor
);

parameter S_IDLE = 2'b00;
parameter S_UP   = 2'b01;
parameter S_DOWN = 2'b10;
parameter S_EMER = 2'b11;

reg [1:0] current_state, next_state;
reg [1:0] target_floor;

// target floor selection //
always @(*) begin
    target_floor = current_floor;
    if (floor_req[0]) target_floor = 2'd0;
    else if (floor_req[1]) target_floor = 2'd1;
    else if (floor_req[2]) target_floor = 2'd2;
    else if (floor_req[3]) target_floor = 2'd3;
end

// state register //
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= S_IDLE;
    else
        current_state <= next_state;
end

// Floor counter //
always @(posedge clk or posedge reset) begin
    if (reset)
        current_floor <= 2'd0;
    else if (current_state == S_UP)
        current_floor <= current_floor + 1'b1;
    else if (current_state == S_DOWN)
        current_floor <= current_floor - 1'b1;
end

// next-state logic //
always @(*) begin
    next_state = current_state;
    if (emergency_stop)
        next_state = S_EMER;
    else begin
        case (current_state)
            S_IDLE:
                if (target_floor > current_floor)
                    next_state = S_UP;
                else if (target_floor < current_floor)
                    next_state = S_DOWN;

            S_UP:
                if (current_floor == target_floor)
                    next_state = S_IDLE;

            S_DOWN:
                if (current_floor == target_floor)
                    next_state = S_IDLE;

            S_EMER:
                if (!emergency_stop)
                    next_state = S_IDLE;
        endcase
    end
end

// output//
always @(*) begin
    move_up = 0;
    move_down = 0;
    motor_stop = 0;

    case (current_state)
        S_UP:   move_up = 1;
        S_DOWN: move_down = 1;
        default: motor_stop = 1;
    endcase
end

endmodule
