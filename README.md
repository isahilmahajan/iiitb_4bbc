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


### Gate Level Simulation GLS
GLS stands for gate level simulation. When we write the RTL code, we test it by giving it some stimulus through the testbench and check it for the desired specifications. Similarly, we run the netlist as the design under test (dut) with the same testbench. Gate level simulation is done to verify the logical correctness of the design after synthesis. Also, it ensures the timing of the design. <br>
Commands to run the GLS are given below.
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 iiitb_4bbc_synth.v iiitb_4bbc_tb.v iiitb_4bbc/verilog_model/primitives.v /iiitb_4bbc/verilog_model/sky130_fd_sc_hd.v -iiitb_4bbc 
./iiitb_4bbc
gtkwave iiitb_4bbc.vcd
```

![post](https://user-images.githubusercontent.com/34582183/185283470-eec5908c-9a4a-44ee-b628-af5ad37390a7.png)

# Layout

## Preparation
The layout is generated using OpenLane. To run a custom design on openlane, Navigate to the openlane folder and run the following commands:<br>
```
$ cd designs

$ mkdir iiitb_4bbc

$ cd iiitb_4bbc

$ mkdir src

$ touch config.json

$ cd src

$ touch iiitb_4bbc.v
```

The iiitb_freqdiv.v file should contain the verilog RTL code you have used and got the post synthesis simulation for. <br>

Copy  `sky130_fd_sc_hd__fast.lib`, `sky130_fd_sc_hd__slow.lib`, `sky130_fd_sc_hd__typical.lib` and `sky130_vsdinv.lef` files to `src` folder in your design. <br>

The final src folder should look like this: <br>


<br>

The contents of the config.json are as follows. this can be modified specifically for your design as and when required. <br>

As mentioned by kunal sir dont use defined `DIE_AREA` and `FP_SIZING : absolute`, use `FP_SIZING : relative`
```
{
    "DESIGN_NAME": "iiitb_4bbc",
    "VERILOG_FILES": "dir::src/iiitb_4bbc.v",
    "CLOCK_PORT": "clkin",
    "CLOCK_NET": "clkin",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 10,
    "PL_TARGET_DENSITY": 0.7,
    "FP_SIZING" : "relative",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 30,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 20
        }
    },
    
    "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
    "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
    "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
    "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",  
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_4bbc/src/*"


}
```



Save all the changes made above and Navigate to the openlane folder in terminal and give the following command :<br>

```
$ make mount (if this command doesnot go through prefix it with sudo)
```
![sm-make mount](https://user-images.githubusercontent.com/34582183/187881647-d856b78b-f4cc-4ef6-8c0f-33fc80be857c.png)


After entering the openlane container give the following command:<br>
```
$ ./flow.tcl -interactive
```
![tcl](https://user-images.githubusercontent.com/34582183/187881816-c1577234-597b-4231-8d20-8201357022ad.png)


This command will take you into the tcl console. In the tcl console type the following commands:<br>

```
% package require openlane 0.9
```
![openlane 0 9](https://user-images.githubusercontent.com/34582183/187881881-aabd0933-83e1-42d2-9887-ad7d854bcec3.png)
<br>
```
% prep -design iiitb_freqdiv
```
![design prep](https://user-images.githubusercontent.com/34582183/187881960-eed36cd7-9fbd-4e0b-8103-ebaed97f8f06.png)
<br>

The following commands are to merge external the lef files to the merged.nom.lef. In our case sky130_vsdiat is getting merged to the lef file <br>
```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
![set_lfs](https://user-images.githubusercontent.com/34582183/187882058-80e20ea5-4d7f-49de-bed6-1566a65bffac.png)
<br>
<br>

## Synthesis
```
% run_synthesis
```
![run_synthesis](https://user-images.githubusercontent.com/34582183/187882250-33c4c6a6-303a-4978-9fed-0e9b70242d1e.png)
<br>

## Floorplan
```

% run_floorplan
```

![floorplan](https://user-images.githubusercontent.com/34582183/187887789-3451d254-b083-4496-bbab-f9a70f4d0461.png)
<br>

### Floorplan Reports

Navigate to results->floorplan and type the Magic command in terminal to open the floorplan <br>
```
$ magic -T /home/himanshu/Sahil/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read iiitb_4bbc.def &
```
<br>
Floorplan view

![Screenshot from 2022-09-01 14-44-12](https://user-images.githubusercontent.com/34582183/187887088-3403cd57-80ad-47e0-b2d8-c227c8e14864.png)
<br>

## Placement
```
% run_placement
```
![placement](https://user-images.githubusercontent.com/34582183/187883674-ff4d2cfb-90e6-4416-8955-37845de00c92.png)

### Placement Reports
Navigate to results->placement and type the Magic command in terminal to open the placement view <br>
```
$ magic -T /home/himanshu/Sahil/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.max.lef def read iiitb_4bbc.def &
```
<br>
Placement View <br>
<br>

![Screenshot from 2022-09-01 14-43-39](https://user-images.githubusercontent.com/34582183/187886869-54a092e3-5496-4f35-8edf-5a377ee9200c.png)

<br>
<b>sky130_vsdinv</b> in the placement view :<br>
<br>

![vsdinv](https://user-images.githubusercontent.com/34582183/187886929-d25bd7e4-bf4b-45ae-adad-59820216ff4c.png)

<br>
<br>


## Clock Tree Synthesis
```
% run_cts
```
![21](https://user-images.githubusercontent.com/62461290/187060069-447e33ad-952c-4303-92ac-cfbd45dd91b1.png)<br>

## Routing
```
% run_routing
```
![22](https://user-images.githubusercontent.com/62461290/187060096-ad41aab7-6435-45c8-a266-e6ebb955d691.png)<br>

### Routing Reports
Navigate to results->routing and type the Magic command in terminal to open the routing view <br>
```
$ magic -T /home/himanshu/Sahil/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read iiitb_4bbc.def &
```

Routing View<br>
<br>
![Screenshot from 2022-09-01 14-42-58](https://user-images.githubusercontent.com/34582183/187885465-81e2751d-2477-4aa9-bd73-a4c723aa577e.png)
<br>
<br>

## Viewing Layout in KLayout

![klayout](https://user-images.githubusercontent.com/34582183/187886654-8caed303-803e-4540-a803-6643f717bc64.png)
<br>


### NOTE
We can also run the whole flow at once instead of step by step process by giving the following command in openlane container<br>
```
$ ./flow.tcl -design iiitb_4bbc
```
<br>![non-interactive command](https://user-images.githubusercontent.com/34582183/187885803-ca195cac-b0aa-4416-921e-26031b77a9de.png)
<br>
All the steps will be automated and all the files will be generated.<br>


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
