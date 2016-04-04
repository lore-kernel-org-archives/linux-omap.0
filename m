From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/8] ARM: dts: am43xx: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:10 +0300
Message-ID: <1459782973-21201-6-git-send-email-t-kristo@ti.com>
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
name. This patch fixes following type of warnings for AM43xx clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi |  116 +++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index a38af2b..34fecf2 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &scm_clocks {
-	sys_clkin_ck: sys_clkin_ck {
+	sys_clkin_ck: sys_clkin_ck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysboot_freq_sel_ck>, <&crystal_freq_sel_ck>;
@@ -16,7 +16,7 @@
 		reg = <0x0040>;
 	};
 
-	crystal_freq_sel_ck: crystal_freq_sel_ck {
+	crystal_freq_sel_ck: crystal_freq_sel_ck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_19200000_ck>, <&virt_24000000_ck>, <&virt_25000000_ck>, <&virt_26000000_ck>;
@@ -104,7 +104,7 @@
 		clock-div = <1>;
 	};
 
-	ehrpwm0_tbclk: ehrpwm0_tbclk {
+	ehrpwm0_tbclk: ehrpwm0_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -112,7 +112,7 @@
 		reg = <0x0664>;
 	};
 
-	ehrpwm1_tbclk: ehrpwm1_tbclk {
+	ehrpwm1_tbclk: ehrpwm1_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -120,7 +120,7 @@
 		reg = <0x0664>;
 	};
 
-	ehrpwm2_tbclk: ehrpwm2_tbclk {
+	ehrpwm2_tbclk: ehrpwm2_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -128,7 +128,7 @@
 		reg = <0x0664>;
 	};
 
-	ehrpwm3_tbclk: ehrpwm3_tbclk {
+	ehrpwm3_tbclk: ehrpwm3_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -136,7 +136,7 @@
 		reg = <0x0664>;
 	};
 
-	ehrpwm4_tbclk: ehrpwm4_tbclk {
+	ehrpwm4_tbclk: ehrpwm4_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -144,7 +144,7 @@
 		reg = <0x0664>;
 	};
 
-	ehrpwm5_tbclk: ehrpwm5_tbclk {
+	ehrpwm5_tbclk: ehrpwm5_tbclk@664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4ls_gclk>;
@@ -195,7 +195,7 @@
 		clock-frequency = <26000000>;
 	};
 
-	dpll_core_ck: dpll_core_ck {
+	dpll_core_ck: dpll_core_ck@2d20 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-core-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
@@ -208,7 +208,7 @@
 		clocks = <&dpll_core_ck>;
 	};
 
-	dpll_core_m4_ck: dpll_core_m4_ck {
+	dpll_core_m4_ck: dpll_core_m4_ck@2d38 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -219,7 +219,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_m5_ck: dpll_core_m5_ck {
+	dpll_core_m5_ck: dpll_core_m5_ck@2d3c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -230,7 +230,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_m6_ck: dpll_core_m6_ck {
+	dpll_core_m6_ck: dpll_core_m6_ck@2d40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -241,14 +241,14 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_mpu_ck: dpll_mpu_ck {
+	dpll_mpu_ck: dpll_mpu_ck@2d60 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2d60>, <0x2d64>, <0x2d6c>;
 	};
 
-	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck@2d70 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_mpu_ck>;
@@ -267,14 +267,14 @@
 		clock-div = <2>;
 	};
 
-	dpll_ddr_ck: dpll_ddr_ck {
+	dpll_ddr_ck: dpll_ddr_ck@2da0 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2da0>, <0x2da4>, <0x2dac>;
 	};
 
-	dpll_ddr_m2_ck: dpll_ddr_m2_ck {
+	dpll_ddr_m2_ck: dpll_ddr_m2_ck@2db0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_ck>;
@@ -285,14 +285,14 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_disp_ck: dpll_disp_ck {
+	dpll_disp_ck: dpll_disp_ck@2e20 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2e20>, <0x2e24>, <0x2e2c>;
 	};
 
-	dpll_disp_m2_ck: dpll_disp_m2_ck {
+	dpll_disp_m2_ck: dpll_disp_m2_ck@2e30 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_disp_ck>;
@@ -304,14 +304,14 @@
 		ti,set-rate-parent;
 	};
 
-	dpll_per_ck: dpll_per_ck {
+	dpll_per_ck: dpll_per_ck@2de0 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-j-type-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2de0>, <0x2de4>, <0x2dec>;
 	};
 
-	dpll_per_m2_ck: dpll_per_m2_ck {
+	dpll_per_m2_ck: dpll_per_m2_ck@2df0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_ck>;
@@ -354,7 +354,7 @@
 		clock-div = <732>;
 	};
 
-	clkdiv32k_ick: clkdiv32k_ick {
+	clkdiv32k_ick: clkdiv32k_ick@2a38 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ck>;
@@ -370,7 +370,7 @@
 		clock-div = <1>;
 	};
 
-	pruss_ocp_gclk: pruss_ocp_gclk {
+	pruss_ocp_gclk: pruss_ocp_gclk@4248 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysclk_div>, <&dpll_disp_m2_ck>;
@@ -383,56 +383,56 @@
 		clock-frequency = <32768>;
 	};
 
-	timer1_fck: timer1_fck {
+	timer1_fck: timer1_fck@4200 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>, <&clk_32k_tpm_ck>;
 		reg = <0x4200>;
 	};
 
-	timer2_fck: timer2_fck {
+	timer2_fck: timer2_fck@4204 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x4204>;
 	};
 
-	timer3_fck: timer3_fck {
+	timer3_fck: timer3_fck@4208 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x4208>;
 	};
 
-	timer4_fck: timer4_fck {
+	timer4_fck: timer4_fck@420c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x420c>;
 	};
 
-	timer5_fck: timer5_fck {
+	timer5_fck: timer5_fck@4210 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x4210>;
 	};
 
-	timer6_fck: timer6_fck {
+	timer6_fck: timer6_fck@4214 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x4214>;
 	};
 
-	timer7_fck: timer7_fck {
+	timer7_fck: timer7_fck@4218 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
 		reg = <0x4218>;
 	};
 
-	wdt1_fck: wdt1_fck {
+	wdt1_fck: wdt1_fck@422c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_rc32k_ck>, <&clkdiv32k_ick>;
@@ -487,14 +487,14 @@
 		clock-div = <2>;
 	};
 
-	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
+	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk@4238 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysclk_div>, <&dpll_core_m5_ck>, <&dpll_disp_m2_ck>;
 		reg = <0x4238>;
 	};
 
-	dpll_clksel_mac_clk: dpll_clksel_mac_clk {
+	dpll_clksel_mac_clk: dpll_clksel_mac_clk@4234 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_m5_ck>;
@@ -509,14 +509,14 @@
 		clock-frequency = <32768>;
 	};
 
-	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck {
+	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck@4240 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_rc32k_ck>, <&clk_32768_ck>, <&clkdiv32k_ick>, <&clk_32k_mosc_ck>, <&clk_32k_tpm_ck>;
 		reg = <0x4240>;
 	};
 
-	gpio0_dbclk: gpio0_dbclk {
+	gpio0_dbclk: gpio0_dbclk@2b68 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&gpio0_dbclk_mux_ck>;
@@ -524,7 +524,7 @@
 		reg = <0x2b68>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk {
+	gpio1_dbclk: gpio1_dbclk@8c78 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -532,7 +532,7 @@
 		reg = <0x8c78>;
 	};
 
-	gpio2_dbclk: gpio2_dbclk {
+	gpio2_dbclk: gpio2_dbclk@8c80 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -540,7 +540,7 @@
 		reg = <0x8c80>;
 	};
 
-	gpio3_dbclk: gpio3_dbclk {
+	gpio3_dbclk: gpio3_dbclk@8c88 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -548,7 +548,7 @@
 		reg = <0x8c88>;
 	};
 
-	gpio4_dbclk: gpio4_dbclk {
+	gpio4_dbclk: gpio4_dbclk@8c90 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -556,7 +556,7 @@
 		reg = <0x8c90>;
 	};
 
-	gpio5_dbclk: gpio5_dbclk {
+	gpio5_dbclk: gpio5_dbclk@8c98 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkdiv32k_ick>;
@@ -572,7 +572,7 @@
 		clock-div = <2>;
 	};
 
-	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck {
+	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck@423c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sysclk_div>, <&dpll_per_m2_ck>;
@@ -580,7 +580,7 @@
 		reg = <0x423c>;
 	};
 
-	gfx_fck_div_ck: gfx_fck_div_ck {
+	gfx_fck_div_ck: gfx_fck_div_ck@423c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&gfx_fclk_clksel_ck>;
@@ -588,7 +588,7 @@
 		ti,max-div = <2>;
 	};
 
-	disp_clk: disp_clk {
+	disp_clk: disp_clk@4244 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
@@ -596,14 +596,14 @@
 		ti,set-rate-parent;
 	};
 
-	dpll_extdev_ck: dpll_extdev_ck {
+	dpll_extdev_ck: dpll_extdev_ck@2e60 {
 		#clock-cells = <0>;
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2e60>, <0x2e64>, <0x2e6c>;
 	};
 
-	dpll_extdev_m2_ck: dpll_extdev_m2_ck {
+	dpll_extdev_m2_ck: dpll_extdev_m2_ck@2e70 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_extdev_ck>;
@@ -614,14 +614,14 @@
 		ti,invert-autoidle-bit;
 	};
 
-	mux_synctimer32k_ck: mux_synctimer32k_ck {
+	mux_synctimer32k_ck: mux_synctimer32k_ck@4230 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>, <&clkdiv32k_ick>;
 		reg = <0x4230>;
 	};
 
-	synctimer_32kclk: synctimer_32kclk {
+	synctimer_32kclk: synctimer_32kclk@2a30 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&mux_synctimer32k_ck>;
@@ -629,28 +629,28 @@
 		reg = <0x2a30>;
 	};
 
-	timer8_fck: timer8_fck {
+	timer8_fck: timer8_fck@421c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
 		reg = <0x421c>;
 	};
 
-	timer9_fck: timer9_fck {
+	timer9_fck: timer9_fck@4220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
 		reg = <0x4220>;
 	};
 
-	timer10_fck: timer10_fck {
+	timer10_fck: timer10_fck@4224 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
 		reg = <0x4224>;
 	};
 
-	timer11_fck: timer11_fck {
+	timer11_fck: timer11_fck@4228 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
@@ -679,7 +679,7 @@
 		clocks = <&dpll_ddr_ck>;
 	};
 
-	dpll_ddr_m4_ck: dpll_ddr_m4_ck {
+	dpll_ddr_m4_ck: dpll_ddr_m4_ck@2db8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_x2_ck>;
@@ -690,7 +690,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_clkdcoldo: dpll_per_clkdcoldo {
+	dpll_per_clkdcoldo: dpll_per_clkdcoldo@2e14 {
 		#clock-cells = <0>;
 		compatible = "ti,fixed-factor-clock";
 		clocks = <&dpll_per_ck>;
@@ -701,7 +701,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dll_aging_clk_div: dll_aging_clk_div {
+	dll_aging_clk_div: dll_aging_clk_div@4250 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin_ck>;
@@ -733,14 +733,14 @@
 		clock-div = <2>;
 	};
 
-	usbphy_32khz_clkmux: usbphy_32khz_clkmux {
+	usbphy_32khz_clkmux: usbphy_32khz_clkmux@4260 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>;
 		reg = <0x4260>;
 	};
 
-	usb_phy0_always_on_clk32k: usb_phy0_always_on_clk32k {
+	usb_phy0_always_on_clk32k: usb_phy0_always_on_clk32k@2a40 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&usbphy_32khz_clkmux>;
@@ -748,7 +748,7 @@
 		reg = <0x2a40>;
 	};
 
-	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k {
+	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k@2a48 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&usbphy_32khz_clkmux>;
@@ -756,7 +756,7 @@
 		reg = <0x2a48>;
 	};
 
-	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m {
+	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m@8a60 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_clkdcoldo>;
@@ -764,7 +764,7 @@
 		reg = <0x8a60>;
 	};
 
-	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
+	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@8a68 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_clkdcoldo>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
