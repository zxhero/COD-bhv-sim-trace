`timescale 1ns / 1ns
//`define TRACE_REF_FILE "/home/cod/zhangxu/prj3/prj3-teacher/hardware/sources/testbench/advanced/17-golden_trace.txt"
`define MEM_DUMP_FILE   "/home/cod/zhangxu/prj3/prj3-teacher/hardware/sources/testbench/mem_dump/basic/mem_dump.txt"
`define HALT_PC 32'h0000005c
module mips_cpu_test
();

	reg				mips_cpu_clk;
    reg				mips_cpu_reset;

    wire            mips_cpu_pc_sig;
		integer trace_ref;
		reg				flag;
	initial begin
	trace_ref = $fopen(`MEM_DUMP_FILE, "w");
    flag = 1;
		mips_cpu_clk = 1'b0;
		mips_cpu_reset = 1'b1;
		# 30
		mips_cpu_reset = 1'b0;

		//# 2000000
		//$finish;
	end

	always begin
		# 5 mips_cpu_clk = ~mips_cpu_clk;
	end

    mips_cpu_fpga    u_mips_cpu (
        .mips_cpu_clk       (mips_cpu_clk),
        .mips_cpu_reset     (mips_cpu_reset),

        .mips_cpu_pc_sig    (mips_cpu_pc_sig)
    );
	
	/*always @(posedge mips_cpu_clk)
	begin
		if(u_mips_cpu.u_mips_cpu_top.u_mips_cpu.rf_instance.wen == 1'b1 && u_mips_cpu.u_mips_cpu_top.u_mips_cpu.rf_instance.waddr != 5'd0 && u_mips_cpu.u_mips_cpu_top.mips_cpu_reset == 1'b0)
		begin
			$fdisplay(trace_ref, "%h %h %h", 
					u_mips_cpu.u_mips_cpu_top.u_mips_cpu.PC, u_mips_cpu.u_mips_cpu_top.u_mips_cpu.rf_instance.waddr, u_mips_cpu.u_mips_cpu_top.u_mips_cpu.rf_instance.wdata);
		end
	end

	always @(posedge mips_cpu_clk)
	begin
		if(u_mips_cpu.u_mips_cpu_top.u_mips_cpu.MemWrite == 1'b1 && u_mips_cpu.u_mips_cpu_top.u_mips_cpu.Write_data == 'd0 && flag == 1'b1 && u_mips_cpu.u_mips_cpu_top.u_mips_cpu.Address == 'd12)
		begin
			//$fdisplay(trace_ref, "%h", trace_ref);
			$fclose(trace_ref);
			$display("I close");
			flag = 1'b0;
		end
	end*/
	integer j;
	always @(posedge mips_cpu_clk)
	begin
	   //if(u_mips_cpu.u_mips_cpu_top.u_mips_cpu.PC == `HALT_PC && flag == 1)
	if(u_mips_cpu.u_mips_cpu_top.u_mips_cpu.MemWrite == 1'b1 && flag == 1'b1 && u_mips_cpu.u_mips_cpu_top.u_mips_cpu.Address == 'd12)
	   begin
	       flag = 0;
		$fdisplay(trace_ref, "%h %h %h %h", 
                               u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[0],u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[1],u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[2],u_mips_cpu.u_mips_cpu_top.u_mips_cpu.Write_data);
	       for(j = 4; j < 4096;j = j+4)
	       begin
	           $fdisplay(trace_ref, "%h %h %h %h", 
                               u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[j],u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[j+1],u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[j+2],u_mips_cpu.u_mips_bram.inst.native_mem_mapped_module.blk_mem_gen_v8_3_6_inst.memory[j+3]);
	       end
	       $fclose(trace_ref);
           $display("I close");
	   end
	end

endmodule
