# uvm_code_gen
Simple template-based UVM code generator.

## Rationale
The [UVM](https://en.wikipedia.org/wiki/Universal_Verification_Methodology) verification methodology is great for reuse and standardization of RTL verification.  
It is however very verbose.

The goal of **uvm_code_gen** is to generate a full UVM testbench skeleton based on simple configuration files.  
Once generated, we only have to write a couple of lines to finish it.

## Features
**uvm_code_gen** generates the following code:
  - VIPs (agent, interface, sequence, coverage)
  - top-level environment
    - testbench
    - env (scoreboard, VIP, coverage)
    - virtual sequence
  - run script

## Usage
### Basic
```sh
# top-level environment default name is "top"
./main.py examples/fifo/fifo_in.conf examples/fifo/fifo_out.conf

# top-level environment name is "fifo"
./main.py examples/fifo/fifo_in.conf examples/fifo/fifo_out.conf -t fifo
```

Generated files are in `./output`.

#### run simulation
  - create `bin/dut_files.f`
  - edit dut instantiation in `top/tb/top_th.sv`
  - `cd bin` and `./run`

#### edit to your liking
  - VIP
    - clocking blocks in `vip/*/*_if.sv`
    -  `do_drive()` in `vip/*/*_driver.sv`
    -  `do_mon()` in `vip/*/*_monitor.sv`
  - TOP
    - `write_from_*()` in `top/top_scoreboard.sv`
    - `top/top_seq_lib.sv`

### Advanced
#### --top_map
By default:
  - each VIP is instiated once
  - instance name is the name of the VIP

This can be changed using the `--top_map` option.
```sh
# multiple instances of the VIPs
./main.py examples/noc/*.conf --top_map examples/noc/top.map

# you can also refer to VIPs that are not defined by a config file:
#  - the top-level env/scoreboard/etc will be correctly generated
#  - the VIP directory won't be generated
./main.py --top_map examples/noc/top.map
```

## TODO
  - pass coverage in top_config's new()
  - support master + slave VIP
  - change seq name to something less generic ?
  - change convert2string() formatting ?
  - code formatting ?
  - when to prefix members by m_ ?

## Credits
The UVM code generation and coding guidelines are heavily inspired by [Doulos' easier_uvm](https://www.doulos.com/knowhow/systemverilog/uvm/easier-uvm/). Thanks a lot to all the contributors.
