# read design

read_verilog iiitb_4bbc.v

# generic synthesis
synth -top iiitb_4bbc

# mapping to mycells.lib
dfflibmap -liberty /home/sahil/iiitb_4bbc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

abc -liberty /home/sahil/iiitb_4bbc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

flatten
clean

# write synthesized design
write_verilog iiitb_4bbc_synth.v
stat
show
