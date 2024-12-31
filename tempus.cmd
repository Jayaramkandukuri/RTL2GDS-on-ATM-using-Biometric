#######################################################
#                                                     
#  Tempus Timing Signoff Solution Command Logging File                     
#  Created on Wed Jul 24 15:07:45 2024                
#                                                     
#######################################################

#@(#)CDS: Tempus Timing Signoff Solution v20.20-p001_1 (64bit) 12/02/2020 16:07 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.20-p001_1 NR200917-0125/MT (database version 18.20.530) {superthreading v2.11}
#@(#)CDS: AAE 20.20-p005 (64bit) 12/02/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.20-p010_1 () Dec  2 2020 14:35:30 ( )
#@(#)CDS: SYNTECH 20.20-p001_1 () Nov 24 2020 02:28:20 ( )
#@(#)CDS: CPE v20.20-p009

read_design -physical_data ATM.enc.dat/ ATM
all_setup_analysis_views
all_hold_analysis_views
all_setup_analysis_views
all_hold_analysis_views
all_setup_analysis_views
all_hold_analysis_views
all_setup_analysis_views
all_hold_analysis_views
read_spef ATM.spef
selectWire 0.9950 0.9950 25.6850 2.7950 9 VSS
read_sdf ATM.sdf
deselectAll
selectWire 0.9950 0.9950 25.6850 2.7950 9 VSS
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -late > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
deselectAll
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
zoomSelected
zoomSelected
all_analysis_views
all_setup_analysis_views
all_hold_analysis_views
get_analysis_view $view -delay_corner
get_delay_corner $dc -rc_corner
add_repeater -cell BUFX2 -net rst
redraw
add_repeater -cell BUFX2 -net rst
redraw
add_repeater -cell BUFX2 -net rst
redraw
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
zoomSelected
zoomSelected
all_analysis_views
all_setup_analysis_views
all_hold_analysis_views
get_analysis_view $view -delay_corner
get_delay_corner $dc -rc_corner
add_repeater -cell BUFX4 -net m
redraw
add_repeater -cell BUFX4 -net m
redraw
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
fit
deselectAll
write_eco -format innovus -output hold-optimized.tcl
