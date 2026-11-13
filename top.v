module top (
    input btnU, //reset
    input btnC, //clock
    output [6:0]led //0:2 Ripple out 3:5 mod counter stage 6 mod out
);
wire [1:0] wireRipple; //ripple counter wires

wire [2:0] wireQMod; //Q outputs on modulo counter

wire [2:0] adderD; //Adder Y output to Modulo D input

wire [1:0] adderCarry; //Adder carry wire

wire atCount; //at Count AND
wire modReset; //Reset wire for modReset
wire outXOR; //output DFF XOR gate
wire outLoop; //Loopback for output DFF

//ripple clock divide
tff rippleLSB(
    .clock(btnC),
    .T(1'b1),
    .Q(wireRipple[0])
);

assign led[0] = wireRipple[0];

tff rippleInter(
    .clock(wireRipple[0]),
    .T(1'b1),
    .Q(wireRipple[1])
);

assign led[1] = wireRipple[1];

tff rippleMSB(
    .clock(wireRipple[1]),
    .T(1'b1),
    .Q(led[2])
);

//Modulo Counter part

assign atCount = wireQMod[0] & ~wireQMod[1] & wireQMod[2];
assign modReset = atCount | btnU;

dff moduloLSB(
    .clock(btnC),
    .D(adderD[0]),
    .reset(modReset),
    .Q(wireQMod[0])
);

assign led[3] = wireQMod[0];

dff moduloStg1(
    .clock(btnC),
    .D(adderD[1]),
    .reset(modReset),
    .Q(wireQMod[1])
);

assign led[4] = wireQMod[1];

dff moduloMSB(
    .clock(btnC),
    .D(adderD[2]),
    .reset(modReset),
    .Q(wireQMod[2])
);

assign led[5] = wireQMod[2];

full_adder adderLSB(
    .A(wireQMod[0]),
    .B(1'b0),
    .Cin(1'b1),
    .Y(adderD[0]),
    .Cout(adderCarry[0])
);

full_adder adderStg1(
    .A(wireQMod[1]),
    .B(1'b0),
    .Cin(adderCarry[0]),
    .Y(adderD[1]),
    .Cout(adderCarry[1])
);

full_adder adderMSB(
    .A(wireQMod[2]),
    .B(1'b0),
    .Cin(adderCarry[1]),
    .Y(adderD[2])
);

assign outXOR = outLoop ^ atCount;

dff moduloOutput(
    .clock(btnC),
    .D(outXOR),
    .Q(outLoop)
);

assign led[6] = outLoop;

endmodule