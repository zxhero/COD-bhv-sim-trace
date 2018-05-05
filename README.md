# COD-bhv-sim-trace
## A few efforts to help students find their bugs
### 我们会在实验三中更新环境，注意：这是测试版本！！！！
使用说明：<br>
	1.	将mips_cpu_test.v覆盖原工程hardward/source/testbench下的mips_cpu_test.v <br> <br>
	2.	将希望测试的 golden_trace 放在相同目录下。修改 mips_cpu_test.v 中 TRACE_REF_FILE 的值为 golden_trace 的绝对地址（pwd命令可查看绝对地址） <br> <br>
	![image](https://github.com/zxhero/COD-bhv-sim-trace/blob/master/addr.PNG) <br> <br> <br>
	3.	将您CPU代码中的reg_file实例化的名字改为rf_i（在mips_cpu.v中) 或者将mips_cpu_test.v中的关键字"rf_i"
		全部改为您reg_file实例化的名字。 <br> <br> 
	4.	执行 make HW_ACT=bhv_sim HW_VAL=xxx:xx vivado_prj 命令 <br> <br>
	5.	在terminal界面中会出现比对信息。当CPU写寄存器堆时，会比对此时的PC值、写地址、写数据。<br> <br>
	![image](https://github.com/zxhero/COD-bhv-sim-trace/blob/master/reference.PNG) <br> <br> <br>
	6.	当出现错误时，会产生如下信息：上面一行是：[报错时间(ns)] 报错位置。下面一行是：正确值 <br> <br>
	![image](https://github.com/zxhero/COD-bhv-sim-trace/blob/master/wrong.PNG)  <br> <br> <br>
	7.	感谢熊可欣和吴瑜萍同学提供的错误的CPU <br>
	
		
