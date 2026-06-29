# source /home/vlsi/vlsi059/A_script/run_synthesis.tcl

set search_path "/home/vlsi/vlsi059/B_code /home/admin/lib/lec25"
# set LIB_DIR "/home/admin/lib/lec25/lec25dscc25_SS.db"
set DESIGN_NAME "DCT_TOP"
set TOP_MODULE "DCT_TOP"
set target_library "lec25dscc25_SS.db"
set link_library "* $target_library dw_foundation.sldb"

# Clean Design
remove_design -all

# Read Verilog (Use analyze instead of read_file to check for syntax mistakes)
analyze -format verilog {DCT1.v DCT2.v DCT_TOP_SYNTH.v DCTControl.v TPMEM1.v TPMEM2.v}

# Create hierarchical structure with the top module
elaborate ${TOP_MODULE}
link

# Set Current Design
current_design ${DESIGN_NAME}
check_design

# Show Schematic


# SDC
read_sdc /home/vlsi/vlsi059/A_script/constraint.sdc

# Synthesize
compile -exact_map

# Report
report_area -hierarchy
report_timing -nworst 1
report_power

# Write post-synthesis netlist
write -format verilog -hierarchy -output /home/vlsi/vlsi059/B_code/post_synth.v

# Quit
# quit
