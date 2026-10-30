module johnson_counter (
    input clk,
    input rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else
            q <= {q[2:0], ~q[3]};
    end
endmodule


module johnson_counter_tb;
    reg clk, rst;
    wire [3:0] q;

    johnson_counter uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; #10;
        rst = 0; #100;
        $finish;
    end
endmodule
