module random_seq_generator (
    input clk,
    input rst,
    output reg [3:0] rand_out
);
    wire feedback;
    assign feedback = rand_out[3] ^ rand_out[2];

    always @(posedge clk or posedge rst) begin
        if (rst)
            rand_out <= 4'b1111; // Non-zero seed
        else
            rand_out <= {rand_out[2:0], feedback};
    end
endmodule



module random_seq_generator_tb;
    reg clk, rst;
    wire [3:0] rand_out;

    random_seq_generator uut (.clk(clk), .rst(rst), .rand_out(rand_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; #10;
        rst = 0; #150;
        $finish;
    end
endmodule
