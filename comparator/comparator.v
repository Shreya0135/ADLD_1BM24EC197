module comparator (
    input [3:0] A,
    input [3:0] B,
    output reg A_gt_B,
    output reg A_lt_B,
    output reg A_eq_B
);

    always @(*) begin

        A_gt_B = 0;
        A_lt_B = 0;
        A_eq_B = 0;

        if (A > B)
            A_gt_B = 1;

        else if (A < B)
            A_lt_B = 1;

        else
            A_eq_B = 1;

    end

endmodule



module comparator_TB;

    reg [3:0] A, B;

    wire A_gt_B;
    wire A_lt_B;
    wire A_eq_B;

    // Instantiate the comparator
    comparator uut (
        .A(A),
        .B(B),
        .A_gt_B(A_gt_B),
        .A_lt_B(A_lt_B),
        .A_eq_B(A_eq_B)
    );

    initial begin

        $monitor("Time=%0t A=%d B=%d A_gt_B=%b A_lt_B=%b A_eq_B=%b",
                 $time, A, B, A_gt_B, A_lt_B, A_eq_B);

        // Test 1: A > B
        A = 4'd10; B = 4'd5;
        #10;

        // Test 2: A < B
        A = 4'd3; B = 4'd8;
        #10;

        // Test 3: A = B
        A = 4'd7; B = 4'd7;
        #10;

        // Test 4: A > B
        A = 4'd15; B = 4'd2;
        #10;

        // Test 5: A < B
        A = 4'd1; B = 4'd12;
        #10;

        $finish;

    end

endmodule
