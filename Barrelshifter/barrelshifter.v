module barrel_shifter (
    input [3:0] data_in,
    input [1:0] shift,
    input direction,
    output reg [3:0] data_out
);

    always @(*) begin

        case (direction)

            1'b0: begin
                case (shift)
                    2'b00: data_out = data_in;
                    2'b01: data_out = data_in << 1;
                    2'b10: data_out = data_in << 2;
                    2'b11: data_out = data_in << 3;
                endcase
            end

            1'b1: begin
                case (shift)
                    2'b00: data_out = data_in;
                    2'b01: data_out = data_in >> 1;
                    2'b10: data_out = data_in >> 2;
                    2'b11: data_out = data_in >> 3;
                endcase
            end

        endcase

    end

endmodule


`timescale 1ns/1ps

module barrel_shifter_TB;

    reg [3:0] data_in;
    reg [1:0] shift;
    reg direction;

    wire [3:0] data_out;

    // Instantiate the design
    barrel_shifter uut (
        .data_in(data_in),
        .shift(shift),
        .direction(direction),
        .data_out(data_out)
    );

    initial begin

        $monitor(
            "Time=%0t Data=%b Direction=%b Shift=%b Output=%b",
            $time, data_in, direction, shift, data_out
        );

        // Test 1: No shift
        data_in = 4'b1011;
        direction = 0;
        shift = 2'b00;
        #10;

        // Test 2: Left shift by 1
        data_in = 4'b1011;
        direction = 0;
        shift = 2'b01;
        #10;

        // Test 3: Left shift by 2
        data_in = 4'b1011;
        direction = 0;
        shift = 2'b10;
        #10;

  



    

        $finish;

    end

endmodule
