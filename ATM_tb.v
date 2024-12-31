module testbench();

    reg clk;
    reg reset;
    reg [3:0] pin_input;
    reg [7:0] amount_input;
    reg biometric_authenticated;
    reg change_pin_request;
    reg [3:0] new_pin;
    reg inactivity_timeout;

    wire transaction_success;
    wire transaction_error;
    wire pin_change_success;
    wire account_locked;
    wire timeout_error;

    // Instantiate the DUT (ATM module)
    ATM dut (
        .clk(clk),
        .reset(reset),
        .pin_input(pin_input),
        .amount_input(amount_input),
        .biometric_authenticated(biometric_authenticated),
        .change_pin_request(change_pin_request),
        .new_pin(new_pin),
        .inactivity_timeout(inactivity_timeout),
        .transaction_success(transaction_success),
        .transaction_error(transaction_error),
        .pin_change_success(pin_change_success),
        .account_locked(account_locked),
        .timeout_error(timeout_error)
    );

    // Clock generation (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initial conditions
        clk = 0;
        reset = 1;
        pin_input = 4'b0000;
        amount_input = 8'd0;
        biometric_authenticated = 0;
        change_pin_request = 0;
        new_pin = 4'b0000;
        inactivity_timeout = 0;

        // Deassert reset after 10 time units
        #10 reset = 0;

        // Test Case 1: Valid PIN, valid biometric, valid transaction amount
        #10 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd20;
        #10;
        $display("Test 1: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 2: Account lockout after 3 failed PIN attempts
        #20 pin_input = 4'b0000; // Incorrect PIN
        #10;
        pin_input = 4'b0000; // Incorrect PIN again
        #10;
        pin_input = 4'b0000; // Incorrect PIN third time
        #10;
        $display("Test 2: Account Locked = %b, Error = %b", account_locked, transaction_error);

        // Test Case 3: Try transaction after account lockout
        #20 pin_input = 4'b1010; // Correct PIN (but account locked)
        #10;
        $display("Test 3: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 4: Valid PIN, invalid biometric authentication
        #20 pin_input = 4'b1010;
        biometric_authenticated = 0; // Biometric failed
        amount_input = 8'd50;
        #10;
        $display("Test 4: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 5: Timeout handling
        #20 inactivity_timeout = 1; // Simulate inactivity
        #10;
        $display("Test 5: Timeout Error = %b, Success = %b", timeout_error, transaction_success);

        // Test Case 6: Change PIN request
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        new_pin = 4'b1100; // Change PIN to a new value
        #10;
        $display("Test 6: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        // Test Case 7: Exceed transaction amount
        #20 pin_input = 4'b1100; // Correct PIN after change
        biometric_authenticated = 1;
        amount_input = 8'd200; // Exceeds max limit
        #10;
        $display("Test 7: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 8: Invalid amount input (zero amount)
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd0; // Invalid amount (zero)
        #10;
        $display("Test 8: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 9: Multiple PIN changes
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        new_pin = 4'b1111; // First change
        #10;
        $display("Test 9: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        #20 pin_input = 4'b1111;
        change_pin_request = 1;
        new_pin = 4'b1001; // Second change
        #10;
        $display("Test 9: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        // Test Case 10: Timeout during transaction
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd10;
        inactivity_timeout = 1; // Simulate timeout during transaction
        #10;
        $display("Test 10: Timeout Error = %b, Success = %b", timeout_error, transaction_success);

        // Test Case 11: Account lockout after change PIN and invalid login attempt
        #20 pin_input = 4'b1010; // Correct PIN
        change_pin_request = 1;
        new_pin = 4'b1011; // Change PIN to a new value
        #10;
        $display("Test 11: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        #20 pin_input = 4'b1111; // Incorrect PIN after change
        #10;
        pin_input = 4'b1111; // Incorrect PIN again
        #10;
        pin_input = 4'b1111; // Incorrect PIN third time
        #10;
        $display("Test 11: Account Locked = %b, Error = %b", account_locked, transaction_error);

        // Test Case 12: Change PIN request with the same new PIN
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        new_pin = 4'b1010; // New PIN is the same as the old PIN
        #10;
        $display("Test 12: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        // Test Case 13: Valid transaction after timeout condition cleared
        #20 inactivity_timeout = 0;
        pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd15;
        #10;
        $display("Test 13: Success = %b, Error = %b", transaction_success, transaction_error);

	        // Test Case 14: Reset during valid transaction
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd30;
        #5 reset = 1; // Reset mid-operation
        #5 reset = 0;
        #10;
        $display("Test 14: Success = %b, Error = %b", transaction_success, transaction_error);

	        // Test Case 15: Minimum valid transaction amount
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd1; // Minimum valid amount
        #10;
        $display("Test 15: Success = %b, Error = %b", transaction_success, transaction_error);

        // Test Case 16: Maximum valid transaction amount
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd255; // Max amount if supported
        #10;
        $display("Test 16: Success = %b, Error = %b", transaction_success, transaction_error);

	        // Test Case 17: Biometric authentication fails during PIN change
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        biometric_authenticated = 0; // Biometric failure
        new_pin = 4'b1011;
        #10;
        $display("Test 17: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

	        // Test Case 18: Invalid PIN, timeout, and biometric failure
        #20 pin_input = 4'b0000; // Invalid PIN
        biometric_authenticated = 0; // Biometric failure
        inactivity_timeout = 1; // Timeout occurs
        #10;
        $display("Test 18: Timeout Error = %b, Success = %b, Error = %b", timeout_error, transaction_success, transaction_error);

	        // Test Case 19: Change PIN to boundary values
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        new_pin = 4'b0000; // Lowest PIN
        #10;
        $display("Test 19a: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

        #20 pin_input = 4'b1010;
        new_pin = 4'b1111; // Highest PIN
        #10;
        $display("Test 19b: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

	        // Test PIN Input Edge Cases
        #20 pin_input = 4'b0000; // Lowest PIN
        biometric_authenticated = 1;
        amount_input = 8'd10;
        #10;
        pin_input = 4'b1111; // Highest PIN
        #10;

        // Test Invalid Combinations
        #20 pin_input = 4'b1010;
        biometric_authenticated = 0; // Biometric failure
        amount_input = 8'd0; // Invalid transaction amount
        #10;
	
	        // Simultaneous Biometric Failure and Timeout
        #20 biometric_authenticated = 0;
        inactivity_timeout = 1;
        #10;

        // PIN Change During Transaction
        #20 pin_input = 4'b1010;
        biometric_authenticated = 1;
        amount_input = 8'd10;
        change_pin_request = 1;
        new_pin = 4'b1100;
        #10;

	        // Reset During PIN Change
        #20 pin_input = 4'b1010;
        change_pin_request = 1;
        new_pin = 4'b1111;
        #5 reset = 1;
        #5 reset = 0;
        #10;
	// Test Case 21: Reset during PIN change
	#20 pin_input = 4'b1010;
	change_pin_request = 1;
	new_pin = 4'b1101;	
	#5 reset = 1; // Assert reset mid-operation
	#5 reset = 0;
	#10;	
	$display("Test 21: PIN Change Success = %b, Error = %b", pin_change_success, transaction_error);

	// Test Case 22: Max transaction with timeout
	#20 pin_input = 4'b1010;
	biometric_authenticated = 1;
	amount_input = 8'd255; // Max transaction amount
	inactivity_timeout = 1; // Simulate timeout
	#10;
	$display("Test 22: Timeout Error = %b, Success = %b", timeout_error, transaction_success);


	// Test Case 23: Repeated timeouts
	#20 inactivity_timeout = 1;
	#10 inactivity_timeout = 0; // Reset timeout
	#10 inactivity_timeout = 1; // Trigger timeout again
	#10;
	$display("Test 23: Timeout Error = %b", timeout_error);

	        
	// Test Case 24: Old PIN after PIN change
	#20 pin_input = 4'b1010;
	change_pin_request = 1;
	new_pin = 4'b1101;
	#10;

	#20 pin_input = 4'b1010; // Try old PIN
	biometric_authenticated = 1;
	amount_input = 8'd50;
	#10;
	$display("Test 24: Success = %b, Error = %b", transaction_success, transaction_error);

	// Test Case 25: Timeout and incorrect PIN
	#20 pin_input = 4'b0001; // Incorrect PIN
	inactivity_timeout = 1; // Simulate timeout
	#10;
	$display("Test 25: Timeout Error = %b, Account Locked = %b", timeout_error, account_locked);

	// Test Case 26: Smallest transaction after reset
	#20 reset = 1; // Assert reset
	#10 reset = 0; // Deassert reset
	pin_input = 4'b1010;
	biometric_authenticated = 1;
	amount_input = 8'd1; // Smallest valid transaction
	#10;
	$display("Test 26: Success = %b, Error = %b", transaction_success, transaction_error);



        $finish;
    end
endmodule

