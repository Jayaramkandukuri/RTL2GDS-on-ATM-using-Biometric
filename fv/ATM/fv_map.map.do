
//input ports
add mapped point clk clk -type PI PI
add mapped point reset reset -type PI PI
add mapped point pin_input[3] pin_input[3] -type PI PI
add mapped point pin_input[2] pin_input[2] -type PI PI
add mapped point pin_input[1] pin_input[1] -type PI PI
add mapped point pin_input[0] pin_input[0] -type PI PI
add mapped point amount_input[7] amount_input[7] -type PI PI
add mapped point amount_input[6] amount_input[6] -type PI PI
add mapped point amount_input[5] amount_input[5] -type PI PI
add mapped point amount_input[4] amount_input[4] -type PI PI
add mapped point amount_input[3] amount_input[3] -type PI PI
add mapped point amount_input[2] amount_input[2] -type PI PI
add mapped point amount_input[1] amount_input[1] -type PI PI
add mapped point amount_input[0] amount_input[0] -type PI PI
add mapped point biometric_authenticated biometric_authenticated -type PI PI
add mapped point change_pin_request change_pin_request -type PI PI
add mapped point new_pin[3] new_pin[3] -type PI PI
add mapped point new_pin[2] new_pin[2] -type PI PI
add mapped point new_pin[1] new_pin[1] -type PI PI
add mapped point new_pin[0] new_pin[0] -type PI PI
add mapped point inactivity_timeout inactivity_timeout -type PI PI

//output ports
add mapped point transaction_success transaction_success -type PO PO
add mapped point transaction_error transaction_error -type PO PO
add mapped point pin_change_success pin_change_success -type PO PO
add mapped point account_locked account_locked -type PO PO
add mapped point timeout_error timeout_error -type PO PO

//inout ports




//Sequential Pins
add mapped point transaction_success/q transaction_success_reg/Q  -type DFF DFF
add mapped point login_attempts[3]/q login_attempts_reg[3]/Q  -type DFF DFF
add mapped point pin_change_success/q pin_change_success_reg/Q  -type DFF DFF
add mapped point transaction_error/q transaction_error_reg/Q  -type DFF DFF
add mapped point current_pin[1]/q current_pin_reg[1]/Q  -type DFF DFF
add mapped point current_pin[3]/q current_pin_reg[3]/Q  -type DFF DFF
add mapped point current_pin[0]/q current_pin_reg[0]/Q  -type DFF DFF
add mapped point current_pin[2]/q current_pin_reg[2]/Q  -type DFF DFF
add mapped point login_attempts[2]/q login_attempts_reg[2]/Q  -type DFF DFF
add mapped point login_attempts[1]/q login_attempts_reg[1]/Q  -type DFF DFF
add mapped point account_locked/q account_locked_reg/Q  -type DFF DFF
add mapped point login_attempts[0]/q login_attempts_reg[0]/Q  -type DFF DFF
add mapped point timeout_error/q timeout_error_reg/Q  -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
