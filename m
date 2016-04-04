From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8] ARM: dts: am33xx: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:09 +0300
Message-ID: <1459782973-21201-5-git-send-email-t-kristo@ti.com>
References: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459782973-21201-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Upcoming change to DT compiler is going to complain about nodes
which have a reg property, but have not defined the address in their
name. This patch fixes following type of warnings for AM33xx clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi |   90 +++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index afb4b3a..8d83195 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &scm_clocks {
-	sys_clkin_ck: sys_clkin_ck {
+	sys_clkin_ck: sys_clkin_ck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_19200000_ck>, <&virt_24000000_ck>, <&virt_25000000_ck>, <&virt_26000000_ck>;
@@ -163,7 +163,7 @@
 		clock-frequency = <12000000>;
 	};
 
-	dpll_core_ck: dpll_core_ck {
+	dpll_core_ck: dpll_core_ck@490 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-core-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
@@ -176,7 +176,7 @@
 		clocks = <&dpll_core_ck>;
 	};
 
-	dpll_core_m4_ck: dpll_core_m4_ck {
+	dpll_core_m4_ck: dpll_core_m4_ck@480 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -185,7 +185,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_m5_ck: dpll_core_m5_ck {
+	dpll_core_m5_ck: dpll_core_m5_ck@484 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -194,7 +194,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_m6_ck: dpll_core_m6_ck {
+	dpll_core_m6_ck: dpll_core_m6_ck@4d8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -203,14 +203,14 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_mpu_ck: dpll_mpu_ck {
+	dpll_mpu_ck: dpll_mpu_ck@488 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x0488>, <0x0420>, <0x042c>;
 	};
 
-	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck@4a8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_mpu_ck>;
@@ -219,14 +219,14 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_ddr_ck: dpll_ddr_ck {
+	dpll_ddr_ck: dpll_ddr_ck@494 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-no-gate-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x0494>, <0x0434>, <0x0440>;
 	};
 
-	dpll_ddr_m2_ck: dpll_ddr_m2_ck {
+	dpll_ddr_m2_ck: dpll_ddr_m2_ck@4a0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_ck>;
@@ -243,14 +243,14 @@
 		clock-div = <2>;
 	};
 
-	dpll_disp_ck: dpll_disp_ck {
+	dpll_disp_ck: dpll_disp_ck@498 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-no-gate-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x0498>, <0x0448>, <0x0454>;
 	};
 
-	dpll_disp_m2_ck: dpll_disp_m2_ck {
+	dpll_disp_m2_ck: dpll_disp_m2_ck@4a4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_disp_ck>;
@@ -260,14 +260,14 @@
 		ti,set-rate-parent;
 	};
 
-	dpll_per_ck: dpll_per_ck {
+	dpll_per_ck: dpll_per_ck@48c {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-no-gate-j-type-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x048c>, <0x0470>, <0x049c>;
 	};
 
-	dpll_per_m2_ck: dpll_per_m2_ck {
+	dpll_per_m2_ck: dpll_per_m2_ck@4ac {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_ck>;
@@ -292,7 +292,7 @@
 		clock-div = <4>;
 	};
 
-	cefuse_fck: cefuse_fck {
+	cefuse_fck: cefuse_fck@a20 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_clkin_ck>;
@@ -316,7 +316,7 @@
 		clock-div = <732>;
 	};
 
-	clkdiv32k_ick: clkdiv32k_ick {
+	clkdiv32k_ick: clkdiv32k_ick@14c {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ck>;
@@ -332,14 +332,14 @@
 		clock-div = <1>;
 	};
 
-	pruss_ocp_gclk: pruss_ocp_gclk {
+	pruss_ocp_gclk: pruss_ocp_gclk@530 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3_gclk>, <&dpll_disp_m2_ck>;
 		reg = <0x0530>;
 	};
 
-	mmu_fck: mmu_fck {
+	mmu_fck: mmu_fck@914 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_core_m4_ck>;
@@ -347,56 +347,56 @@
 		reg = <0x0914>;
 	};
 
-	timer1_fck: timer1_fck {
+	timer1_fck: timer1_fck@528 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>;
 		reg = <0x0528>;
 	};
 
-	timer2_fck: timer2_fck {
+	timer2_fck: timer2_fck@508 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x0508>;
 	};
 
-	timer3_fck: timer3_fck {
+	timer3_fck: timer3_fck@50c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x050c>;
 	};
 
-	timer4_fck: timer4_fck {
+	timer4_fck: timer4_fck@510 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x0510>;
 	};
 
-	timer5_fck: timer5_fck {
+	timer5_fck: timer5_fck@518 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x0518>;
 	};
 
-	timer6_fck: timer6_fck {
+	timer6_fck: timer6_fck@51c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x051c>;
 	};
 
-	timer7_fck: timer7_fck {
+	timer7_fck: timer7_fck@504 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x0504>;
 	};
 
-	usbotg_fck: usbotg_fck {
+	usbotg_fck: usbotg_fck@47c {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_ck>;
@@ -412,7 +412,7 @@
 		clock-div = <2>;
 	};
 
-	ieee5000_fck: ieee5000_fck {
+	ieee5000_fck: ieee5000_fck@e4 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_core_m4_div2_ck>;
@@ -420,7 +420,7 @@
 		reg = <0x00e4>;
 	};
 
-	wdt1_fck: wdt1_fck {
+	wdt1_fck: wdt1_fck@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_rc32k_ck>, <&clkdiv32k_ick>;
@@ -483,21 +483,21 @@
 		clock-div = <2>;
 	};
 
-	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
+	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk@520 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_m5_ck>, <&dpll_core_m4_ck>;
 		reg = <0x0520>;
 	};
 
-	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck {
+	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck@53c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_rc32k_ck>, <&clk_32768_ck>, <&clkdiv32k_ick>;
 		reg = <0x053c>;
 	};
 
-	gpio0_dbclk: gpio0_dbclk {
+	gpio0_dbclk: gpio0_dbclk@408 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&gpio0_dbclk_mux_ck>;
@@ -505,7 +505,7 @@
 		reg = <0x0408>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk {
+	gpio1_dbclk: gpio1_dbclk@ac {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -513,7 +513,7 @@
 		reg = <0x00ac>;
 	};
 
-	gpio2_dbclk: gpio2_dbclk {
+	gpio2_dbclk: gpio2_dbclk@b0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -521,7 +521,7 @@
 		reg = <0x00b0>;
 	};
 
-	gpio3_dbclk: gpio3_dbclk {
+	gpio3_dbclk: gpio3_dbclk@b4 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -529,7 +529,7 @@
 		reg = <0x00b4>;
 	};
 
-	lcd_gclk: lcd_gclk {
+	lcd_gclk: lcd_gclk@534 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
@@ -545,7 +545,7 @@
 		clock-div = <2>;
 	};
 
-	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck {
+	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck@52c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
@@ -553,7 +553,7 @@
 		reg = <0x052c>;
 	};
 
-	gfx_fck_div_ck: gfx_fck_div_ck {
+	gfx_fck_div_ck: gfx_fck_div_ck@52c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&gfx_fclk_clksel_ck>;
@@ -561,14 +561,14 @@
 		ti,max-div = <2>;
 	};
 
-	sysclkout_pre_ck: sysclkout_pre_ck {
+	sysclkout_pre_ck: sysclkout_pre_ck@700 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_32768_ck>, <&l3_gclk>, <&dpll_ddr_m2_ck>, <&dpll_per_m2_ck>, <&lcd_gclk>;
 		reg = <0x0700>;
 	};
 
-	clkout2_div_ck: clkout2_div_ck {
+	clkout2_div_ck: clkout2_div_ck@700 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sysclkout_pre_ck>;
@@ -577,7 +577,7 @@
 		reg = <0x0700>;
 	};
 
-	dbg_sysclk_ck: dbg_sysclk_ck {
+	dbg_sysclk_ck: dbg_sysclk_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_clkin_ck>;
@@ -585,7 +585,7 @@
 		reg = <0x0414>;
 	};
 
-	dbg_clka_ck: dbg_clka_ck {
+	dbg_clka_ck: dbg_clka_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_core_m4_ck>;
@@ -593,7 +593,7 @@
 		reg = <0x0414>;
 	};
 
-	stm_pmd_clock_mux_ck: stm_pmd_clock_mux_ck {
+	stm_pmd_clock_mux_ck: stm_pmd_clock_mux_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dbg_sysclk_ck>, <&dbg_clka_ck>;
@@ -601,7 +601,7 @@
 		reg = <0x0414>;
 	};
 
-	trace_pmd_clk_mux_ck: trace_pmd_clk_mux_ck {
+	trace_pmd_clk_mux_ck: trace_pmd_clk_mux_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dbg_sysclk_ck>, <&dbg_clka_ck>;
@@ -609,7 +609,7 @@
 		reg = <0x0414>;
 	};
 
-	stm_clk_div_ck: stm_clk_div_ck {
+	stm_clk_div_ck: stm_clk_div_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&stm_pmd_clock_mux_ck>;
@@ -619,7 +619,7 @@
 		ti,index-power-of-two;
 	};
 
-	trace_clk_div_ck: trace_clk_div_ck {
+	trace_clk_div_ck: trace_clk_div_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&trace_pmd_clk_mux_ck>;
@@ -629,7 +629,7 @@
 		ti,index-power-of-two;
 	};
 
-	clkout2_ck: clkout2_ck {
+	clkout2_ck: clkout2_ck@700 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkout2_div_ck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
