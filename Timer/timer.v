module timer (
    input clk,
    input reset,
    input enable,
    output reg [3:0] count,
    output done
);

    // Timer terminal count
    assign done = (count == 4'd9);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'd0;

        else if (enable) begin
            if (count == 4'd9)
                count <= 4'd0;
            else
                count <= count + 1'b1;
        end
    end

endmodule



module timer_TB;

    reg clk;
    reg reset;
    reg enable;

    wire [3:0] count;
    wire done;

    // Instantiate the timer
    timer uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .done(done)
    );

    // Generate clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;
        enable = 0;

        $monitor(
            "Time=%0t Reset=%b Enable=%b Count=%d Done=%b",
            $time, reset, enable, count, done
        );

        // Apply reset
        #10;
        reset = 0;

        // Enable the timer
        enable = 1;

        // Allow the timer to count
        #110;

        // Disable the timer
        enable = 0;

        #20;

        // Reset the timer again
        reset = 1;
        #10;
        reset = 0;

        #10;
        $finish;

    end

endmodule
