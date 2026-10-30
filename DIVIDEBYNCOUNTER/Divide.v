module divide_by_n #(parameter N = 5, parameter WIDTH = 3) (
    input clk,
    input rst,
    output reg clk_out
);
    reg [WIDTH-1:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_out <= 0;
        end else if (count == N - 1) begin
            count <= 0;
            clk_out <= ~clk_out;
        end else begin
            count <= count + 1;
        end
    end
endmodule


module divide_by_n_tb;
    reg clk, rst;
    wire clk_out;

    divide_by_n #(.N(5), .WIDTH(3)) uut (.clk(clk), .rst(rst), .clk_out(clk_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; #12;
        rst = 0; #100;
        $finish;
    end
endmodule
