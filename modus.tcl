build_model -designsource ATM_netlist_dft.v -techlib /home/cadence/Documents/Project_05/slow.v -designtop ATM
build_testmode -testmode FULLSCAN -assignfile /home/cadence/Documents/Project_05/test_scripts/ATM.FULLSCAN.pinassign
verify_test_structures -testmode FULLSCAN
report_test_structures -testmode FULLSCAN
build_faultmodel -fullfault yes
create_scanchain_tests -testmode FULLSCAN -experiment scan
create_logic_tests -testmode FULLSCAN -experiment logic
write_vectors -testmode FULLSCAN -inexperiment logic -language verilog -scanformat serial -outputfilename test_results
gui_open
