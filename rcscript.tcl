# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/installs/FOUNDRY/digital/90nm/dig/lib  
set_db hdl_search_path /home/cadence/Documents/Project_05

set_db library slow.lib
read_hdl ATM.v
elaborate
read_sdc /home/cadence/Documents/Project_05/constraints_sdc.sdc
set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt


write_hdl > ATM_netlist.v
write_sdc > ATM_block.sdc
report_area > ATM_area.rep
report_gates > ATM_gate.rep
report_power > ATM_power.rep
report_timing > ATM_timing.rep
gui_show
