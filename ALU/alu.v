module ALU(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] opcode,
    output reg [3:0] result,
    output reg carry
);

    always @(*) begin

        result = 4'b0000;
        carry  = 1'b0;

        case (opcode)

            3'b000: {carry, result} = A + B;    // Addition

            3'b001: result = A - B;             // Subtraction

            3'b010: result = A & B;             // AND

            3'b011: result = A | B;             // OR

            3'b100: result = A ^ B;             // XOR

            3'b101: result = ~A;                // NOT

            3'b110: result = A << 1;            // Left shift

            3'b111: result = A >> 1;             // Right shift

            default: begin
                result = 4'b0000;
                carry  = 1'b0;
            end

        endcase

    end

endmodule




module ALU_TB;

    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] opcode;

    wire [3:0] result;
    wire carry;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry(carry)
    );

    initial begin

       

        // Addition
        A = 4'b0101; B = 4'b0011; opcode = 3'b000;
        #10;

        // Subtraction
        A = 4'b1000; B = 4'b0010; opcode = 3'b001;
        #10;
        //and
        A = 4'b1100; B = 4'b1010; opcode = 3'b010;
                #10;

    // OR
        A = 4'b1100; B = 4'b1010; opcode = 3'b011;
        #10;

        // XOR
        A = 4'b1100; B = 4'b1010; opcode = 3'b100;
        #10;

        // NOT
        A = 4'b1010; B = 4'b0000; opcode = 3'b101;
        #10;

        // Left shift
        A = 4'b0101; B = 4'b0000; opcode = 3'b110;
        #10;

        // Right shift
        A = 4'b1010; B = 4'b0000; opcode = 3'b111;
        #10;

     

        $finish;

    end

endmodule
