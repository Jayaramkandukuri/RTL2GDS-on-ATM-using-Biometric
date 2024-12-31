# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.11-s111_1 on Fri Nov 22 19:31:24 IST 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design ATM

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_load -pin_load 0.01 [get_ports transaction_success]
set_load -pin_load 0.01 [get_ports transaction_error]
set_load -pin_load 0.01 [get_ports pin_change_success]
set_load -pin_load 0.01 [get_ports account_locked]
set_load -pin_load 0.01 [get_ports timeout_error]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {pin_input[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {pin_input[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {pin_input[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {pin_input[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {pin_input[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {pin_input[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {pin_input[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {pin_input[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {amount_input[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {amount_input[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports biometric_authenticated]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports biometric_authenticated]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports change_pin_request]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports change_pin_request]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {new_pin[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {new_pin[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {new_pin[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {new_pin[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {new_pin[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {new_pin[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 2.0 [get_ports {new_pin[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 1.0 [get_ports {new_pin[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports transaction_success]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports transaction_error]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports pin_change_success]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports account_locked]
set_output_delay -clock [get_clocks clk] -add_delay 2.5 [get_ports timeout_error]
set_input_transition 0.1 [get_ports reset]
set_input_transition 0.1 [get_ports {pin_input[3]}]
set_input_transition 0.1 [get_ports {pin_input[2]}]
set_input_transition 0.1 [get_ports {pin_input[1]}]
set_input_transition 0.1 [get_ports {pin_input[0]}]
set_input_transition 0.1 [get_ports {amount_input[7]}]
set_input_transition 0.1 [get_ports {amount_input[6]}]
set_input_transition 0.1 [get_ports {amount_input[5]}]
set_input_transition 0.1 [get_ports {amount_input[4]}]
set_input_transition 0.1 [get_ports {amount_input[3]}]
set_input_transition 0.1 [get_ports {amount_input[2]}]
set_input_transition 0.1 [get_ports {amount_input[1]}]
set_input_transition 0.1 [get_ports {amount_input[0]}]
set_input_transition 0.1 [get_ports biometric_authenticated]
set_input_transition 0.1 [get_ports change_pin_request]
set_input_transition 0.1 [get_ports {new_pin[3]}]
set_input_transition 0.1 [get_ports {new_pin[2]}]
set_input_transition 0.1 [get_ports {new_pin[1]}]
set_input_transition 0.1 [get_ports {new_pin[0]}]
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.05 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]