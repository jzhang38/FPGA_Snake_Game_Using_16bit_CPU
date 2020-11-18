set projDir "C:/Users/23945/Documents/AlchitryProjects/Snake/work/vivado"
set projName "Snake"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/au_top_0.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/button_conditioner_1.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/edge_detector_2.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/beta_cpu_3.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/counter_4.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/edge_detector_5.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/memoryunit_6.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/reset_conditioner_7.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/matrix_writer_8.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/pipeline_9.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/pn_gen_10.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/control_unit_11.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/alu_12.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/regfile_13.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/simple_dual_ram_14.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/adder_15.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/boolean_16.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/shifter_17.v" "C:/Users/23945/Documents/AlchitryProjects/Snake/work/verilog/compare_18.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/23945/Documents/AlchitryProjects/Snake/work/constraint/custom.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
