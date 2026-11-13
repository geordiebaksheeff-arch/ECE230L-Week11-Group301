module dff (
    input clock,
    input D,
    input reset,
    output reg Q,
    output notQ
);
    initial begin
        Q <= 0;
    end
    always @(posedge clock) begin
        if(reset)
        Q <= 0;
        else
        Q <= D;
        
    end
    assign notQ = ~Q;

endmodule