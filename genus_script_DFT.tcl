# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/installs/FOUNDRY/digital/90nm/dig/lib   

set_db library slow.lib
read_hdl ATM.v
elaborate 
read_sdc constraints_sdc.sdc

set_db dft_scan_style muxed_scan 
set_db dft_prefix dft_
define_dft shift_enable -name SE -active high -create_port SE
check_dft_rules

set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt

check_dft_rules
#set_db dft_min_number_of_scan_chains 2 
set_db design:ATM .dft_min_number_of_scan_chains 1
define_dft scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports 
connect_scan_chains -auto_create_chains -preview
connect_scan_chains -auto_create_chains
syn_opt -incr	

report_scan_chains
write_dft_atpg -library slow.v
#write_dft_atpg -library ../lib/slow_vdd1v0_basiccells.v
write_hdl > ATM_netlist_dft.v
write_sdc > ATM_dft.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split > delays_dft.sdf
write_scandef > ATM_scanDEF.scandef
report_timing > ATM_timing.rep
report_area > ATM_area.rep
report_gates > ATM_GateCount.rep
report_power > ATM_power.rep
report_timing_summary > ATM_timing_summary.rep
gui_show
