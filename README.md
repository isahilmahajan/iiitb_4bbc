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

$ mkdir iiitb_freqdiv

$ cd iiitb_freqdiv

$ mkdir src

$ touch config.json

$ cd src

$ touch iiitb_freqdiv.v
```

The iiitb_freqdiv.v file should contain the verilog RTL code you have used and got the post synthesis simulation for. <br>

Copy  `sky130_fd_sc_hd__fast.lib`, `sky130_fd_sc_hd__slow.lib`, `sky130_fd_sc_hd__typical.lib` and `sky130_vsdinv.lef` files to `src` folder in your design. <br>

The final src folder should look like this: <br>

![f2](https://user-images.githubusercontent.com/62461290/187058789-46914626-3965-41c8-8336-cff2ed949889.png) <br>

The contents of the config.json are as follows. this can be modified specifically for your design as and when required. <br>

As mentioned by kunal sir dont use defined `DIE_AREA` and `FP_SIZING : absolute`, use `FP_SIZING : relative`
```
{
    "DESIGN_NAME": "iiitb_freqdiv",
    "VERILOG_FILES": "dir::src/iiitb_freqdiv.v",
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
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_freqdiv/src/*"


}
```



Save all the changes made above and Navigate to the openlane folder in terminal and give the following command :<br>

```
$ make mount (if this command doesnot go through prefix it with sudo)
```
![1](https://user-images.githubusercontent.com/62461290/186196147-6c8d37a3-9769-428c-93e2-aefb4c897cf0.png)

After entering the openlane container give the following command:<br>
```
$ ./flow.tcl -interactive
```
![2](https://user-images.githubusercontent.com/62461290/186196149-b595f203-a711-46cc-8949-39bee6de552e.png)

This command will take you into the tcl console. In the tcl console type the following commands:<br>

```
% package require openlane 0.9
```
![3](https://user-images.githubusercontent.com/62461290/186196154-c3caa53a-1199-45d1-8903-ba7a1f626c96.png)<br>
```
% prep -design iiitb_freqdiv
```
![4](https://user-images.githubusercontent.com/62461290/186196159-9444df4e-9580-4a04-ba68-c79190d78863.png)<br>

The following commands are to merge external the lef files to the merged.nom.lef. In our case sky130_vsdiat is getting merged to the lef file <br>
```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
![f1](https://user-images.githubusercontent.com/62461290/187058441-e4b64b62-d99d-49b6-8ea5-086afed01b75.png) <br>
<br>
The contents of the merged.nom.lef file should contain the Macro definition of sky130_vsdinv <br>
<br>
![f3](https://user-images.githubusercontent.com/62461290/187058907-0105481f-b632-4d0c-8d13-40a7f702a10d.png)

## Synthesis
```
% run_synthesis
```
![5](https://user-images.githubusercontent.com/62461290/186196161-f33eab28-90e1-4697-acf1-cb7f527e00f3.png)<br>

### Synthesis Reports
Details of the gates used <br>
<br>
![5](https://user-images.githubusercontent.com/62461290/187059146-d8875af6-8feb-4d1a-b908-3fb5c40af428.png)<br>
<br>
Setup and Hold Slack after synthesis<br>
<br>
![7](https://user-images.githubusercontent.com/62461290/187059191-bc94260c-1867-4167-a6d3-4a2397416b7f.png)<br>
<br>
```
Flop Ratio = Ratio of total number of flip flops / Total number of cells present in the design = 8/71 = 0.1125
```
<br>
The sky130_vsdinv should also reflect in your netlist after synthesis <br>
<br>

![9](https://user-images.githubusercontent.com/62461290/187059397-9d745276-f506-45cb-a62f-c369a165e8e9.png)


## Floorplan
```
% run_floorplan
```
![10](https://user-images.githubusercontent.com/62461290/187059432-528152fe-2ec3-4aea-9045-1a5187dc7266.png)<br>

### Floorplan Reports
Die Area <br>
<br>
![12 die](https://user-images.githubusercontent.com/62461290/187059493-d33c91d9-d238-4e9c-8a53-0f4a0b6fa40b.png)<br>
<br>
Core Area <br>
<br>
![11 core](https://user-images.githubusercontent.com/62461290/187059503-233981d6-baf2-46c5-b8e6-979e18baf189.png)<br>

Navigate to results->floorplan and type the Magic command in terminal to open the floorplan <br>
```
$ magic -T /home/nandu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read iiitb_freqdiv.def &
```
![14](https://user-images.githubusercontent.com/62461290/187059593-bdf6b441-9cb8-4838-a2a0-5638af1c7c02.png)<br>
<br>
Floorplan view <br>
<br>
![13](https://user-images.githubusercontent.com/62461290/187059569-1b8184d1-47e1-4ec3-9539-17e317aedacb.png)<br>
<br>
All the cells are placed in the left corner of the floorplan<br>
<br>
![15](https://user-images.githubusercontent.com/62461290/187059629-b135d6dd-dd77-4a0d-a322-6c8864a6210c.png)

## Placement
```
% run_placement
```
![16](https://user-images.githubusercontent.com/62461290/187059712-d8940d40-04f7-4eac-acf6-24ee71c79103.png)<br>

### Placement Reports
Navigate to results->placement and type the Magic command in terminal to open the placement view <br>
```
$ magic -T /home/nandu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.max.lef def read iiitb_freqdiv.def &
```
![19](https://user-images.githubusercontent.com/62461290/187059871-7f4746b1-87ec-40fb-827b-e76df64e3e3d.png)<br>
<br>
Placement View <br>
<br>
![17](https://user-images.githubusercontent.com/62461290/187059887-35c59d00-b959-4983-97f7-f229db63ca4b.png)<br>
<br>
![Screenshot 2022-08-28 112324](https://user-images.githubusercontent.com/62461290/187059896-3cd7613c-abdd-4838-81dc-0291a7a63241.png)<br>
<br>
<b>sky130_vsdinv</b> in the placement view :<br>
<br>
![18](https://user-images.githubusercontent.com/62461290/187059910-27dc9f35-9a5c-4518-8dc5-7c8238747b57.png)<br>
<br>
The sky130_vsdinv should also reflect in your netlist after placement <br>
<br>
![20](https://user-images.githubusercontent.com/62461290/187060017-d9e3eb1b-2cf6-4056-b7e8-4f9afd9daa5b.png)<br>

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
$ magic -T /home/nandu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read iiitb_freqdiv.def &
```
![23](https://user-images.githubusercontent.com/62461290/187060186-ec8a606b-9f79-4bb4-b0fe-5088fed426bb.png)<br>
<br>
Routing View<br>
<br>
![24](https://user-images.githubusercontent.com/62461290/187060219-d3194c75-d7b6-44c8-b760-19688209ca30.png)<br>
<br>
![25](https://user-images.githubusercontent.com/62461290/187060241-5e1341a4-0293-4957-aded-f30660d226e2.png)<br>
<br>
<b>sky130_vsdinv</b> in the routing view :<br>
<br>
![26](https://user-images.githubusercontent.com/62461290/187060280-5f093b87-366e-4355-a506-aa140022c78a.png)<br>
<br>
Area report by magic :<br>
<br>
![27](https://user-images.githubusercontent.com/62461290/187060331-cb12a7ce-963a-420e-9b38-12f137c11e9c.png)<br>
<br>
The sky130_vsdinv should also reflect in your netlist after routing <br>
<br>
![28](https://user-images.githubusercontent.com/62461290/187060367-db21b544-21b1-4447-9756-bc7aa947d23d.png)<br>

## Viewing Layout in KLayout

![klayou1](https://user-images.githubusercontent.com/62461290/187060556-280c7dc4-0f2f-4c0b-aac3-eec6d542ee06.png) <br>

![klayout2](https://user-images.githubusercontent.com/62461290/187060558-73bbc257-a068-4a11-9cf8-f91d2556b72f.png)<br>

![klayout3](https://user-images.githubusercontent.com/62461290/187060560-52d90a53-e509-4319-ae06-3781c246f384.png)<br>


### NOTE
We can also run the whole flow at once instead of step by step process by giving the following command in openlane container<br>
```
$ ./flow.tcl -design iiitb_freqdiv
```
![100](https://user-images.githubusercontent.com/62461290/186196145-6850e928-d54a-404d-ad30-1fdb124a883b.png)<br>
<br>
All the steps will be automated and all the files will be generated.<br>

we can open the mag file and view the layout after the whole process by the following command, you can follow the path as per the image.<br>

```
$ magic -T /home/nandu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech iiitb_freqdiv.mag &
```
<br>

![30](https://user-images.githubusercontent.com/62461290/186206184-3f146947-84d9-4178-9dd2-c54330067168.png)<br>
![31](https://user-images.githubusercontent.com/62461290/186206194-4ea81f2f-ab7f-4d34-840d-7aabff547774.png)<br>
![32](https://user-images.githubusercontent.com/62461290/186206196-526af125-b092-4bfc-9025-33dad27a3e6e.png)<br>


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
