module shift_register (
    input clk,
    input rst,
    input si,
    output reg [3:0] po
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            po <= 4'b0000;
        else
            po <= {po[2:0], si};
    end
endmodule



module shift_register_tb;
    reg clk, rst, si;
    wire [3:0] po;

    shift_register uut (.clk(clk), .rst(rst), .si(si), .po(po));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; si = 0; #10;
        rst = 0; si = 1; #10;
        si = 0; #10;
        si = 1; #10;
        si = 1; #10;
        $finish;
    end
endmodule
