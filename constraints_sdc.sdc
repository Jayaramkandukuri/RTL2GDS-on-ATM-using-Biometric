# Define the primary clock
create_clock -name "clk" -period 10.0 [get_ports "clk"]
set_clock_uncertainty 0.05 [get_clocks "clk"]

# Add clock transition time
set_clock_transition 0.1 [get_clocks "clk"]

# Input ports: Constrain delays and transitions for each input
set_input_delay -clock "clk" 2.0 [get_ports "reset"] -max
set_input_delay -clock "clk" 1.0 [get_ports "reset"] -min
set_input_transition 0.1 [get_ports "reset"]

# Constrain all bits of "pin_input"
foreach port_name {"pin_input[0]" "pin_input[1]" "pin_input[2]" "pin_input[3]"} {
    set_input_delay -clock "clk" 2.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 1.0 [get_ports $port_name] -min
    set_input_transition 0.1 [get_ports $port_name]
}

# Constrain all bits of "amount_input"
foreach port_name {"amount_input[0]" "amount_input[1]" "amount_input[2]" "amount_input[3]" \
                   "amount_input[4]" "amount_input[5]" "amount_input[6]" "amount_input[7]"} {
    set_input_delay -clock "clk" 2.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 1.0 [get_ports $port_name] -min
    set_input_transition 0.1 [get_ports $port_name]
}

# Constrain other inputs
set_input_delay -clock "clk" 2.0 [get_ports "biometric_authenticated"] -max
set_input_delay -clock "clk" 1.0 [get_ports "biometric_authenticated"] -min
set_input_transition 0.1 [get_ports "biometric_authenticated"]

set_input_delay -clock "clk" 2.0 [get_ports "change_pin_request"] -max
set_input_delay -clock "clk" 1.0 [get_ports "change_pin_request"] -min
set_input_transition 0.1 [get_ports "change_pin_request"]

# Constrain all bits of "new_pin"
foreach port_name {"new_pin[0]" "new_pin[1]" "new_pin[2]" "new_pin[3]"} {
    set_input_delay -clock "clk" 2.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 1.0 [get_ports $port_name] -min
    set_input_transition 0.1 [get_ports $port_name]
}

# Fallback for any other unconstrained input ports
foreach port_name [all_inputs] {
    set_input_delay -clock "clk" 2.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 1.0 [get_ports $port_name] -min
    set_input_transition 0.1 [get_ports $port_name]
}

# Inputs without clocked external delays
foreach port_name {"manual_override" "system_reset"} {
    set_input_delay -clock "clk" 0.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 0.0 [get_ports $port_name] -min
    set_input_transition 0.0 [get_ports $port_name]  # No transition delay
}

# Inputs without external driver or transition
foreach port_name {"emergency_shutdown" "test_mode"} {
    set_input_delay -clock "clk" 0.0 [get_ports $port_name] -max
    set_input_delay -clock "clk" 0.0 [get_ports $port_name] -min
    set_input_transition 0.0 [get_ports $port_name]  # No transition delay

    # Remove any external driver
    set_driving_cell -library [get_lib_cells -lib_cell_name "NONE"] [get_ports $port_name]
}

# Output ports: Constrain delays, transitions, and loads
foreach port_name {"transaction_success" "transaction_error" "pin_change_success" \
                   "account_locked" "timeout_error"} {
    set_output_delay -clock "clk" 2.5 [get_ports $port_name]
    set_output_transition 0.1 [get_ports $port_name]
    set_load 0.01 [get_ports $port_name]
}

