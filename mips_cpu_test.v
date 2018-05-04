`timescale 10ns / 1ns
`define TRACE_REF_FILE "/home/cod/zhangxu/prj2-teacher/hardware/sources/testbench/golden_trace.txt"
//`define TRACE_LOG_FILE "/home/cod/zhangxu/prj2-teacher/hardware/sources/testbench/golden_log.txt"

module mips_cpu_test
();

	reg				mips_cpu_clk;
    reg				mips_cpu_reset;
	reg				flag;

    wire            mips_cpu_pc_sig;
	integer trace_ref;
	//integer trace_log;
	initial begin
		trace_ref = $fopen(`TRACE_REF_FILE, "r");
		//trace_log = $fopen(`TRACE_LOG_FILE, "w");
		mips_cpu_clk = 1'b0;
		mips_cpu_reset = 1'b1;
		
		flag = 1'b1;
		# 3
		mips_cpu_reset = 1'b0;

		# 2000000
		$finish;
	end

	always begin
		# 1 mips_cpu_clk = ~mips_cpu_clk;
	end

    mips_cpu_top    u_mips_cpu (
        .mips_cpu_clk       (mips_cpu_clk),
        .mips_cpu_reset     (mips_cpu_reset),

        .mips_cpu_pc_sig    (mips_cpu_pc_sig)
    );
	
	reg [31:0] ref_wb_pc;
	reg [4 :0] ref_wb_rf_wnum;
	reg [31:0] ref_wb_rf_wdata;
	
	always @(posedge mips_cpu_clk)
	begin
		if(u_mips_cpu.u_mips_cpu.rf_i.wen == 1'b1 && u_mips_cpu.u_mips_cpu.rf_i.waddr != 5'd0 && u_mips_cpu.mips_cpu_rst == 1'b0)
		begin
			
			if(flag == 1'b1)
			begin 
				$fscanf(trace_ref, "%h %h %h", 
					ref_wb_pc, ref_wb_rf_wnum, ref_wb_rf_wdata);
				if(u_mips_cpu.u_mips_cpu.PC != ref_wb_pc || u_mips_cpu.u_mips_cpu.rf_i.waddr != ref_wb_rf_wnum || u_mips_cpu.u_mips_cpu.rf_i.wdata != ref_wb_rf_wdata)
				begin
					flag = 1'b0;
					$display("[%t] Wrong : PC: %h WADDR : %h WDATA : %h", $time,
						u_mips_cpu.u_mips_cpu.PC, u_mips_cpu.u_mips_cpu.rf_i.waddr, u_mips_cpu.u_mips_cpu.rf_i.wdata);
					$display(" reference : PC: %h WADDR : %h WDATA : %h",
						ref_wb_pc, ref_wb_rf_wnum, ref_wb_rf_wdata);
					$fclose(trace_ref);
					//$fclose(trace_log);
				end
				else
				begin
					$display(" reference : PC: %h WADDR : %h WDATA : %h",
						ref_wb_pc, ref_wb_rf_wnum, ref_wb_rf_wdata);
				end
			end
		end
	end

	always @(posedge mips_cpu_clk)
	begin
		if(u_mips_cpu.u_mips_cpu.MemWrite == 1'b1 && u_mips_cpu.u_mips_cpu.Write_data == 'd0 && flag == 1'b1 && u_mips_cpu.u_mips_cpu.Address == 'd12)
		begin
			//$fdisplay(trace_ref, "%h", trace_ref);
			$fclose(trace_ref);
			
			flag = 1'b0;
		end
	end
	
endmodule

