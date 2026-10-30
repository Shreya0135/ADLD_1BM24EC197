// Synchronous 4-bit Up Counter
module sync_counter (
    input clk,
    input rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) q <= 4'b0;
        else q <= q + 1'b1;
    end
endmodule

// Asynchronous 4-bit Up Counter
module async_counter (
    input clk,
    input rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) q <= 4'b0;
        else q[0] <= ~q[0];
    end
    always @(posedge q[0] or posedge rst) begin
        if (rst) q[1] <= 1'b0; else q[1] <= ~q[1];
    end
    always @(posedge q[1] or posedge rst) begin
        if (rst) q[2] <= 1'b0; else q[2] <= ~q[2];
    end
    always @(posedge q[2] or posedge rst) begin
        if (rst) q[3] <= 1'b0; else q[3] <= ~q[3];
    end
endmodule



module counters_tb;
    reg clk, rst;
    wire [3:0] q_sync, q_async;

    sync_counter sync_inst (.clk(clk), .rst(rst), .q(q_sync));
    async_counter async_inst (.clk(clk), .rst(rst), .q(q_async));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; #12;
        rst = 0; #100;
        $finish;
    end
endmodule
