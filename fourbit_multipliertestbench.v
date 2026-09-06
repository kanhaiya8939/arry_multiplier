`timescale 1ns / 1ps
`include "fourbit_multiplier.v"
module tb_multiplierfour_bit_random;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg clk; // Testbench ke pacing ke liye clock

    // Outputs
    wire [7:0] p;

    // Verification variables
    integer i;
    reg [7:0] expected;

    // Instantiate the Unit Under Test (UUT)
    fourbit_multiplier uut (
        .a(a), 
        .b(b), 
        .p(p)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
initial begin
       $fsdbDumpfile("fourbitmultiplier.fsdb");
        $fsdbDumpvars(0,tb_multiplierfour_bit_random);
    end
  
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        expected = 0;

        // Reset time
        #10;
        
        // Aapka add kiya hua Random + Self-Checking Logic
        for (i = 0; i < 10; i = i + 1) begin
            
            // 3-bit random values (0 se 7 ke beech) generate karna
            a = $random % 16;
            b = $random % 16;
            
            // Multiplier ke liye expected value calculate karna
            expected = a * b;

            // Clock edge ka wait karna (jaise aapne likha tha)
            @(posedge clk);
            #1; // Combinational logic output update hone ke liye chhota delay
            
            $display("------------------------------------------");
            $display("Expected result = %0d", expected);
            $display("Actual result   = %0d", p);
            $display("A= %b, B= %b", a, b);
            
            // Check condition
            if (expected == p) begin
                $display("true value;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
            end
            else begin
                $display("result failssssssssssssssssssss");
            end
            $display("------------------------------------------");

        end
        
        // Simulation finish
        $finish;
    end
      
endmodule
