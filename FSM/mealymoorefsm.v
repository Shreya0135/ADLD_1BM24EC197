// Mealy Machine (Detects sequence "101")
module fsm_mealy (
    input clk,
    input rst,
    input in,
    output reg out
);
    parameter S0 = 1'b0, S1 = 1'b1;
    reg state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= S0;
        else state <= next_state;
    end

    always @(*) begin
        out = 0;
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: begin
                if (in) next_state = S1;
                else begin next_state = S0; out = 1; end
            end
        endcase
    end
endmodule

// Moore Machine (Detects sequence "101")
module fsm_moore (
    input clk,
    input rst,
    input in,
    output reg out
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) state <= S0;
        else state <= next_state;
    end

    always @(*) begin
        out = 0;
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S1 : S2;
            S2: begin
                out = 1;
                next_state = in ? S1 : S0;
            end
        endcase
    end
endmodule


module fsm_tb;
    reg clk, rst, in;
    wire out_mealy, out_moore;

    fsm_mealy m1 (.clk(clk), .rst(rst), .in(in), .out(out_mealy));
    fsm_moore m2 (.clk(clk), .rst(rst), .in(in), .out(out_moore));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; in = 0; #12;
        rst = 0; in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 0; #10;
        $finish;
    end
endmodule
