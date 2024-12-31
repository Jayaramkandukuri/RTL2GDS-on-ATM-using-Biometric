# RTL2GDS-on-ATM-using-Biometric

Background and Context
Automated Teller Machines (ATMs) have become indispensable in modern banking, offering unparalleled convenience for financial transactions. However, traditional security measures, such as PIN-based authentication, have increasingly become targets for malicious activities like phishing, skimming, and brute-force attacks. These vulnerabilities pose significant risks to user identity and financial security, necessitating the adoption of advanced technologies to mitigate such threats.
To address these challenges, this project introduces an ATM system that integrates dual-layer authentication. By combining biometric verification, which leverages unique physiological traits, and PIN validation, which serves as an additional security measure, the system ensures that only legitimate users can access services. This dual-layered approach provides robust security while maintaining a user-friendly experience.

Objectives of the Project
Enhance Security: Implement dual-layer authentication using biometric verification and PIN validation to prevent unauthorized access.
Design an FSM Architecture: Manage ATM operations efficiently with well-defined states like IDLE, AUTHENTICATION, TRANSACTION, and EXIT.
Ensure Real-Time Performance: Minimize latency during authentication and transaction processes for a smooth user experience.
Secure Data Handling: Protect sensitive biometric and PIN data through robust encryption and secure processing.
Comprehensive Testing: Validate system reliability and functionality through extensive simulations and stress testing.

Importance of Dual-Layer Authentication
Single-factor authentication, such as PIN-based systems, has limitations in ensuring the security of ATM transactions. A biometric system addresses these gaps by utilizing unique user traits, such as fingerprints, which are nearly impossible to replicate or steal. However, biometrics alone might still face issues such as spoofing attempts. To further enhance security, the integration of a PIN validation step provides an additional layer of protection. This combination leverages both something you have (fingerprint) and something you know (PIN), significantly reducing the risk of unauthorized access.


Design Overview
The ATM system operates using an FSM-based architecture, which is both modular and scalable. The FSM manages the entire transaction process, ensuring seamless state transitions and robust error handling. The major states include:
1.	IDLE: Monitors for user interaction and initializes the system.
2.	AUTHENTICATION: Validates the user’s fingerprint and PIN. Both must be successful for the system to proceed.
3.	TRANSACTION SELECTION: Allows the user to select an operation such as cash withdrawal, balance inquiry, or deposits.
4.	PROCESSING: Executes the selected transaction and updates the user’s account securely.
5.	EXIT: Finalizes the process, displays a confirmation message, and resets for the next user.
Developed using Register Transfer Level (RTL) design principles in Verilog, the system is built to be efficient, secure, and adaptable. Comprehensive simulations ensure that the FSM design performs reliably under various scenarios, including edge cases.

Significance of the Project
This project not only addresses the immediate security concerns of ATM systems but also sets a precedent for future advancements in financial security. By integrating biometrics and PINs, the system provides a holistic approach to secure banking transactions, ensuring user trust and satisfaction. Furthermore, its modular design and scalable architecture make it adaptable to future enhancements, such as the integration of facial recognition or mobile authentication methods.
This report details the architecture, design methodology, implementation, and verification of the system, providing a comprehensive understanding of how dual-layer authentication can revolutionize ATM security.
