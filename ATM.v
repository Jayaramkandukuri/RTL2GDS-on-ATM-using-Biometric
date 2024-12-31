module ATM (
    input wire clk,
    input wire reset,
    input wire [3:0] pin_input,
    input wire [7:0] amount_input,
    input wire biometric_authenticated,
    input wire change_pin_request, // Request to change PIN
    input wire [3:0] new_pin,      // New PIN for change request
    input wire inactivity_timeout, // Inactivity timeout signal
    output reg transaction_success,
    output reg transaction_error,
    output reg pin_change_success,
    output reg account_locked,
    output reg timeout_error
);

    // Parameters for clarity and maintainability
    parameter DEFAULT_PIN = 4'b1010;        // Default PIN
    parameter MAX_PIN_ATTEMPTS = 3;        // Max PIN attempts before lock
    parameter MAX_TRANSACTION_AMOUNT = 8'd100;  // Max transaction amount
    parameter ZERO_AMOUNT = 8'd0;          // Zero amount for comparison

    // Internal registers
    reg [3:0] current_pin;                 // Stores the current PIN
    reg [3:0] login_attempts;              // Track consecutive invalid attempts
    reg [7:0] last_amount_input;           // To track last transaction amount

    // Initialize all variables
    initial begin
        current_pin = DEFAULT_PIN;
        login_attempts = 0;
        transaction_success = 0;
        transaction_error = 0;
        pin_change_success = 0;
        account_locked = 0;
        timeout_error = 0;
        last_amount_input = ZERO_AMOUNT;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all outputs and variables
            current_pin <= DEFAULT_PIN;
            login_attempts <= 0;
            transaction_success <= 0;
            transaction_error <= 0;
            pin_change_success <= 0;
            account_locked <= 0;
            timeout_error <= 0;
            last_amount_input <= ZERO_AMOUNT;
        end else if (account_locked) begin
            // Handle account lock scenario
            transaction_success <= 0;
            transaction_error <= 1;
        end else if (inactivity_timeout) begin
            // Handle inactivity timeout
            timeout_error <= 1;
            transaction_success <= 0;
            transaction_error <= 1;
        end else begin
            // Clear timeout error for subsequent operations
            timeout_error <= 0;

            // Handle PIN validation
            if (pin_input == current_pin) begin
                login_attempts <= 0; // Reset login attempts

                // Handle PIN change request
                if (change_pin_request) begin
                    if (new_pin != current_pin) begin
                        current_pin <= new_pin;
                        pin_change_success <= 1;
                        transaction_error <= 0;
                    end else begin
                        pin_change_success <= 0;
                        transaction_error <= 1; // New PIN matches old PIN
                    end
                end else if (biometric_authenticated) begin
                    // Handle transaction
                    if (amount_input > ZERO_AMOUNT) begin
                        if (amount_input <= MAX_TRANSACTION_AMOUNT) begin
                            transaction_success <= 1;
                            transaction_error <= 0;
                            last_amount_input <= amount_input;
                        end else begin
                            transaction_success <= 0;
                            transaction_error <= 1; // Amount exceeds limit
                        end
                    end else begin
                        transaction_success <= 0;
                        transaction_error <= 1; // Zero amount input
                    end
                end else begin
                    transaction_success <= 0;
                    transaction_error <= 1; // Biometric authentication failed
                end
            end else begin
                // Increment failed attempts and handle lock condition
                login_attempts <= login_attempts + 1;
                transaction_success <= 0;
                transaction_error <= 1;

                if (login_attempts >= MAX_PIN_ATTEMPTS) begin
                    account_locked <= 1;
                end
            end
        end
    end
endmodule
