module parity_generator_checker (
    input [3:0] data,
    input parity_in,
    input parity_type,
    output even_parity,
    output odd_parity,
    output error
);

    // Parity Generator
    assign even_parity = ^data;
    assign odd_parity  = ~(^data);

    // Parity Checker
    // parity_type = 0: Even parity
    // parity_type = 1: Odd parity

    assign error = (parity_type == 1'b0)
                   ? ^{data, parity_in}
                   : ~^{data, parity_in};

endmodule


`timescale 1ns/1ps

module parity_TB;

    reg [3:0] data;
    reg parity_in;
    reg parity_type;

    wire even_parity;
    wire odd_parity;
    wire error;

    // Instantiate the design
    parity_generator_checker uut (
        .data(data),
        .parity_in(parity_in),
        .parity_type(parity_type),
        .even_parity(even_parity),
        .odd_parity(odd_parity),
        .error(error)
    );

    initial begin

        $monitor(
            "Time=%0t Data=%b Even=%b Odd=%b Type=%b Parity_in=%b Error=%b",
            $time, data, even_parity, odd_parity,
            parity_type, parity_in, error
        );

        // Test 1: Even parity, no error
        data = 4'b1010;
        parity_type = 1'b0;
        parity_in = 1'b0;
        #10;

        // Test 2: Even parity, error
        data = 4'b1010;
        parity_type = 1'b0;
        parity_in = 1'b1;
        #10;

        // Test 3: Odd parity, no error
        data = 4'b1010;
        parity_type = 1'b1;
        parity_in = 1'b1;
        #10;

        // Test 4: Odd parity, error
        data = 4'b1010;
        parity_type = 1'b1;
        parity_in = 1'b0;
        #10;

        // Test 5: All zeros, even parity
        data = 4'b0000;
        parity_type = 1'b0;
        parity_in = 1'b0;
        #10;

        $finish;

    end

endmodule
