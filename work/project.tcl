set projDir "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/vivado"
set projName "16bit_ALU"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/au_top_0.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/cpu_1.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/counter_2.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/edge_detector_3.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/memoryunit_4.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/reset_conditioner_5.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/control_unit_6.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/alu_7.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/regfile_8.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/simple_dual_ram_9.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/boolean_unit_10.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/compare_unit_11.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/shifter_12.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/sixteen_bit_adder_13.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/shift_left_14.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/shift_right_15.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/shift_right_arithmetic_16.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/sixteen_bit_adder_ripple_carry_17.v" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/verilog/full_adder_18.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/constraint/alchitry.xdc" "C:/Users/23945/Documents/AlchitryProjects/16bit_ALU/work/constraint/io.xdc" "C:/Program\ Files/Alchitry/Alchitry\ Labs/library/components/au.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
