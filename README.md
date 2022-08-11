# iiitb_4bit_bidirectional_counter


## Description

Bidirectional counters, also known as Up/Down counters, are capable of counting in either direction through any given count sequence and they can be reversed at any point within their count sequence by using an additional control input as shown in Fig 1.

*Note: Circuit requires further optimization to improve performance. Design yet to be modified.*

## Block Diagram of Bidirectional Counter

![IMG_20220811_135442](https://user-images.githubusercontent.com/34582183/184093729-d134353f-1a48-41e4-b0da-d7ddbbefc29c.jpg)

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
$   git clone https://github.com/isahilmahajan/iiitb_6bit_bidirectional_counter
$   cd iiitb_6bit_bidirectional_counter
$   iverilog iiitb_6bit_bidirectional_counter.v iiitb_6bit_bidirectional_counter_tb.v
$   ./a.out
$   gtkwave updown.vcd
```
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
