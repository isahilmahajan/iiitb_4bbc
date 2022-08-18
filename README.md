# iiitb_4bbc --> 4 Bit Bidirectional Counter


## Description

Bidirectional counters, also known as Up/Down counters, are capable of counting in either direction through any given count sequence and they can be reversed at any point within their count sequence by using an additional control input as shown in Fig 1.

*Note: Circuit requires further optimization to improve performance. Design yet to be modified.*

## Block Diagram of Bidirectional Counter

![IMG_20220811_135442](https://user-images.githubusercontent.com/34582183/184093729-d134353f-1a48-41e4-b0da-d7ddbbefc29c.jpg)
-Fig. 1

## Truth Table of Bidirectional Counter
![IMG_20220811_135338](https://user-images.githubusercontent.com/34582183/184093786-9a4ebfd7-73fd-4841-9102-b3db0f8da19f.jpg)

![IMG_20220811_135412](https://user-images.githubusercontent.com/34582183/184093761-fd305f83-74d3-45a4-b068-bb21029ecc5e.jpg)


## Application of Bidirectional Counter

Bidirectional counter has various applications
- *Up Counter*
- *Down Counter*
- *Analog to Digital converter*
- *Self-reversing counter*
- *Clock Divider circuit*
- *Counting the time allotted for special process or event by the scheduler*

## Bidirectional Counter - Verilog Implementation 
The digital circuit takes clock, UporDown and reset as input. It operates as 4-bit up counter when UporDown=1 and as 4-bit down counter when UporDown=0. The port description of the Bidirectional counter is shown in Table below. 


| PORT NAME | PORT TYPE | DESCRIPTION |
|-----------|-----------|-------------|
| clk       | input     | Clock Input |
| UporDown | input | Specifies the mode of operation (Up / Down) |
| reset | input | Resets the counter to 0 |
| count[3:0] | output | 4-bit counter output |

## About iverilog 
Icarus Verilog is an implementation of the Verilog hardware description language.
## About GTKWave
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing

### Installing iverilog and GTKWave

#### For Ubuntu

Open your terminal and type the following to install iverilog and GTKWave:
```
$   sudo apt-get install git 
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```


### Functional Simulation
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
$   sudo apt install -y git
$   git clone https://github.com/isahilmahajan/iiitb_4bbc
$   cd iiitb_4bbc
$   iverilog iiitb_4bbc.v iiitb_4bbc_tb.v
$   ./a.out
$   gtkwave updown.vcd
```
### Functional Simulation

![pre](https://user-images.githubusercontent.com/34582183/185283568-e24ff700-ce17-47e1-8736-df344b21dc70.png)



### Synthesis
The software used to run gate level synthesis is Yosys. Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Yosys can be adapted to perform any synthesis job by combining the existing passes (algorithms) using synthesis scripts and adding additional passes as needed by extending the Yosys C++ code base. [^5]

```
git clone https://github.com/YosysHQ/yosys.git
make
sudo make install make test
```

The commands to run synthesis in yosys are given below. First create an yosys script `yosys_run.sh` and paste the below commands.
```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_4bbc.v
synth -top iiitb_4bbc	
dfflibmap -liberty /home/sahil/iiitb_4bbc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/sahil/iiitb_4bbc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
write_verilog iiitb_4bbc_synth.v
stat
show
```
Then, open terminal in the folder iiitb_gc and type the below command.
```
yosys -s yosys_run.sh
```
On running the yosys script, we get the following output:
![Screenshot from 2022-08-16 19-43-49](https://user-images.githubusercontent.com/34582183/185283063-2681ac5d-b794-4b26-947f-725f044beaf4.png)

![Screenshot from 2022-08-17 23-48-09](https://user-images.githubusercontent.com/34582183/185283153-819cbcd2-6ef3-453a-a9a1-8c46b4e86e12.png)


```
### Gate Level Simulation GLS
GLS stands for gate level simulation. When we write the RTL code, we test it by giving it some stimulus through the testbench and check it for the desired specifications. Similarly, we run the netlist as the design under test (dut) with the same testbench. Gate level simulation is done to verify the logical correctness of the design after synthesis. Also, it ensures the timing of the design. <br>
Commands to run the GLS are given below.
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 iiitb_4bbc_synth.v iiitb_4bbc_tb.v iiitb_4bbc/verilog_model/primitives.v /iiitb_4bbc/verilog_model/sky130_fd_sc_hd.v -iiitb_4bbc 
./iiitb_4bbc
gtkwave iiitb_4bbc.vcd

![post](https://user-images.githubusercontent.com/34582183/185283470-eec5908c-9a4a-44ee-b628-af5ad37390a7.png)


## Author

- **Sahil Mahajan**

## Contributors

- **Kunal Ghosh**
- **Siddhant Nayak**

## Acknowledgments


- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.


## Contact Information

- Sahil Mahajan, Postgraduate Student, International Institute of Information Technology, Bangalore  sahil.mahajan@iiitb.ac.in
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

## *References*
- Verilogcodes : https://verilogcodes.blogspot.com/2015/10/verilog-code-for-updown-counter-using.html

- FGPA4Student: https://www.fpga4student.com/2017/03/verilog-code-for-counter-with-testbench.html

- Icarus Verilog - [iverilog](http://iverilog.icarus.com/)

- GTK Wave [documentation](http://gtkwave.sourceforge.net/gtkwave.pdf)
