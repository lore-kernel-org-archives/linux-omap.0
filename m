From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 23/30] ARM: dts: am33xx: add hwmod module clocks
Date: Mon, 11 Apr 2016 11:19:14 +0300
Message-ID: <1460362761-4842-24-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clock nodes for the SoC hwmods. This is done in preparation to remove
hwmod data from kernel, hwmod will use the clock nodes instead for
module level enable / disable logic.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi |  592 +++++++++++++++++++++++++++++++---
 1 file changed, 550 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 8d83195..1e76147 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -276,6 +276,63 @@
 		ti,index-starts-at-one;
 	};
 
+	wkup_m3_mod_ck: wkup_m3_mod_ck@4b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-no-idlest-mod-clock";
+		reg = <0x04b0>;
+		clocks = <&dpll_core_m4_div2_ck>;
+	};
+
+	uart1_mod_ck: uart1_mod_ck@4b4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04b4>;
+		clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck@4b8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04b8>;
+		clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+	};
+
+	adc_tsc_mod_ck: adc_tsc_mod_ck@4bc {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04bc>;
+		clocks = <&adc_tsc_fck>;
+	};
+
+	smartreflex0_mod_ck: smartreflex0_mod_ck@4c0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04c0>;
+		clocks = <&smartreflex0_fck>;
+	};
+
+	timer1_mod_ck: timer1_mod_ck@4c4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x04c4>, <0x0528>;
+		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>,
+			 <&clk_rc32k_ck>, <&clk_32768_ck>;
+	};
+
+	smartreflex1_mod_ck: smartreflex1_mod_ck@4c8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04c8>;
+		clocks = <&smartreflex1_fck>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck@4d4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x04d4>;
+		clocks = <&wdt1_fck>;
+	};
+
 	dpll_per_m2_div4_wkupdm_ck: dpll_per_m2_div4_wkupdm_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -300,6 +357,13 @@
 		reg = <0x0a20>;
 	};
 
+	cefuse_mod_ck: cefuse_mod_ck@a20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0a20>;
+		clocks = <&cefuse_fck>;
+	};
+
 	clk_24mhz: clk_24mhz {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -324,6 +388,20 @@
 		reg = <0x014c>;
 	};
 
+	clkdiv32k_mod_ck: clkdiv32k_mod_ck@14c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x014c>;
+		clocks = <&clkdiv32k_ick>;
+	};
+
+	control_mod_ck: control_mod_ck@404 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0404>;
+		clocks = <&dpll_core_m4_div2_ck>;
+	};
+
 	l3_gclk: l3_gclk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -347,77 +425,105 @@
 		reg = <0x0914>;
 	};
 
-	timer1_fck: timer1_fck@528 {
+	usbotg_fck: usbotg_fck@47c {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>;
-		reg = <0x0528>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_per_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x047c>;
 	};
 
-	timer2_fck: timer2_fck@508 {
+	dpll_core_m4_div2_ck: dpll_core_m4_div2_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x0508>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
 	};
 
-	timer3_fck: timer3_fck@50c {
+	ieee5000_fck: ieee5000_fck@e4 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x050c>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_core_m4_div2_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x00e4>;
 	};
 
-	timer4_fck: timer4_fck@510 {
+	pruss_mod_ck: pruss_mod_ck@e8 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x0510>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00e8>;
+		clocks = <&pruss_ocp_gclk>;
 	};
 
-	timer5_fck: timer5_fck@518 {
+	timer5_mod_ck: timer5_mod_ck@ec {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x00ec>, <0x0518>;
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x0518>;
 	};
 
-	timer6_fck: timer6_fck@51c {
+	timer6_mod_ck: timer6_mod_ck@f0 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x00f0>, <0x051c>;
 		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x051c>;
 	};
 
-	timer7_fck: timer7_fck@504 {
+	mmc2_mod_ck: mmc2_mod_ck@f4 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x0504>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00f4>;
+		clocks = <&mmc_clk>;
 	};
 
-	usbotg_fck: usbotg_fck@47c {
+	mmc3_mod_ck: mmc3_mod_ck@f8 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x047c>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00f8>;
+		clocks = <&mmc_clk>;
 	};
 
-	dpll_core_m4_div2_ck: dpll_core_m4_div2_ck {
+	tptc1_mod_ck: tptc1_mod_ck@fc {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&dpll_core_m4_ck>;
-		clock-mult = <1>;
-		clock-div = <2>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00fc>;
+		clocks = <&l3_gclk>;
 	};
 
-	ieee5000_fck: ieee5000_fck@e4 {
+	tptc2_mod_ck: tptc2_mod_ck@100 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_core_m4_div2_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x00e4>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0100>;
+		clocks = <&l3_gclk>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck@10c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x010c>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	mailbox_mod_ck: mailbox_mod_ck@110 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0110>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	l4_hs_mod_ck: l4_hs_mod_ck@120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0120>;
+		clocks = <&l4hs_gclk>;
+	};
+
+	ocpwp_mod_ck: ocpwp_mod_ck@130 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0130>;
+		clocks = <&l4ls_gclk>;
 	};
 
 	wdt1_fck: wdt1_fck@538 {
@@ -443,6 +549,202 @@
 		clock-div = <1>;
 	};
 
+	cpgmac0_mod_ck: cpgmac0_mod_ck@14 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0014>;
+		clocks = <&cpsw_125mhz_gclk>;
+	};
+
+	lcdc_mod_ck: lcdc_mod_ck@18 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0018>;
+		clocks = <&lcd_gclk>;
+	};
+
+	usb_otg_hs_mod_ck: usb_otg_hs_mod_ck@1c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x001c>;
+		clocks = <&usbotg_fck>;
+	};
+
+	tptc0_mod_ck: tptc0_mod_ck@24 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0024>;
+		clocks = <&l3_gclk>;
+	};
+
+	emif_mod_ck: emif_mod_ck@28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0028>;
+		clocks = <&dpll_ddr_m2_div2_ck>;
+	};
+
+	ocmcram_mod_ck: ocmcram_mod_ck@2c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x002c>;
+		clocks = <&l3_gclk>;
+	};
+
+	gpmc_mod_ck: gpmc_mod_ck@30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0030>;
+		clocks = <&l3s_gclk>;
+	};
+
+	mcasp0_mod_ck: mcasp0_mod_ck@34 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0034>;
+		clocks = <&mcasp0_fck>;
+	};
+
+	uart6_mod_ck: uart6_mod_ck@38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0038>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	mmc1_mod_ck: mmc1_mod_ck@3c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x003c>;
+		clocks = <&mmc_clk>;
+	};
+
+	elm_mod_ck: elm_mod_ck@40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0040>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck@44 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0044>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck@48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0048>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi0_mod_ck: spi0_mod_ck@4c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x004c>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi1_mod_ck: spi1_mod_ck@50 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0050>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	l4_ls_mod_ck: l4_ls_mod_ck@60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0060>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	mcasp1_mod_ck: mcasp1_mod_ck@68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0068>;
+		clocks = <&mcasp1_fck>;
+	};
+
+	uart2_mod_ck: uart2_mod_ck@6c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x006c>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart3_mod_ck: uart3_mod_ck@70 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0070>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart4_mod_ck: uart4_mod_ck@74 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0074>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart5_mod_ck: uart5_mod_ck@78 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0078>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	timer7_mod_ck: timer7_mod_ck@7c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x007c>, <0x0504>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck@80 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0080>, <0x0508>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck@84 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0084>, <0x050c>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck@88 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0088>, <0x0510>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	rng_mod_ck: rng_mod_ck@90 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0090>;
+		clocks = <&rng_fck>;
+	};
+
+	aes_mod_ck: aes_mod_ck@94 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0094>;
+		clocks = <&aes0_fck>;
+	};
+
+	sham_mod_ck: sham_mod_ck@a0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00a0>;
+		clocks = <&l3_gclk>;
+	};
+
 	l3s_gclk: l3s_gclk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -497,6 +799,13 @@
 		reg = <0x053c>;
 	};
 
+	mpu_mod_ck: mpu_mod_ck@604 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0604>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
 	gpio0_dbclk: gpio0_dbclk@408 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -505,6 +814,20 @@
 		reg = <0x0408>;
 	};
 
+	gpio1_mod_ck: gpio1_mod_ck@408 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0408>;
+		clocks = <&dpll_core_m4_div2_ck>;
+	};
+
+	l4_wkup_mod_ck: l4_wkup_mod_ck@40c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x040c>;
+		clocks = <&dpll_core_m4_div2_ck>;
+	};
+
 	gpio1_dbclk: gpio1_dbclk@ac {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -513,6 +836,13 @@
 		reg = <0x00ac>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck@ac {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00ac>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk@b0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -521,6 +851,13 @@
 		reg = <0x00b0>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck@b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00b0>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk@b4 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -529,6 +866,69 @@
 		reg = <0x00b4>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck@b4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00b4>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	tpcc_mod_ck: tpcc_mod_ck@bc {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00bc>;
+		clocks = <&l3_gclk>;
+	};
+
+	d_can0_mod_ck: d_can0_mod_ck@c0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00c0>;
+		clocks = <&dcan0_fck>;
+	};
+
+	d_can1_mod_ck: d_can1_mod_ck@c4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00c4>;
+		clocks = <&dcan1_fck>;
+	};
+
+	epwmss1_mod_ck: epwmss1_mod_ck@cc {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00cc>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss0_mod_ck: epwmss0_mod_ck@d4 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00d4>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss2_mod_ck: epwmss2_mod_ck@d8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00d8>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	l3_instr_mod_ck: l3_instr_mod_ck@dc {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00dc>;
+		clocks = <&l3_gclk>;
+	};
+
+	l3_main_mod_ck: l3_main_mod_ck@e0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x00e0>;
+		clocks = <&l3_gclk>;
+	};
+
 	lcd_gclk: lcd_gclk@534 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -577,6 +977,20 @@
 		reg = <0x0700>;
 	};
 
+	rtc_mod_ck: rtc_mod_ck@800 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0800>;
+		clocks = <&clk_32768_ck>;
+	};
+
+	gfx_mod_ck: gfx_mod_ck@904 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0904>;
+		clocks = <&gfx_fck_div_ck>;
+	};
+
 	dbg_sysclk_ck: dbg_sysclk_ck@414 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -629,6 +1043,13 @@
 		ti,index-power-of-two;
 	};
 
+	debugss_mod_ck: debugss_mod_ck@414 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0414>;
+		clocks = <&trace_clk_div_ck>;
+	};
+
 	clkout2_ck: clkout2_ck@700 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -641,6 +1062,93 @@
 &prcm_clockdomains {
 	clk_24mhz_clkdm: clk_24mhz_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&clkdiv32k_ick>;
+		clocks = <&clkdiv32k_mod_ck>, <&clkdiv32k_ick>;
+	};
+
+	pruss_ocp_clkdm: pruss_ocp_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&pruss_mod_ck>;
+	};
+
+	cpsw_125mhz_clkdm: cpsw_125mhz_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&cpgmac0_mod_ck>;
+	};
+
+	mpu_clkdm: mpu_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mpu_mod_ck>;
+	};
+
+	l4_rtc_clkdm: l4_rtc_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&rtc_mod_ck>;
+	};
+
+	l3_aon_clkdm: l3_aon_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&debugss_mod_ck>;
+	};
+
+	lcdc_clkdm: lcdc_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&lcdc_mod_ck>;
+	};
+
+	l4ls_clkdm: l4ls_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gpio2_mod_ck>, <&d_can1_mod_ck>, <&d_can0_mod_ck>,
+			 <&uart2_mod_ck>, <&gpio4_mod_ck>, <&spi0_mod_ck>,
+			 <&i2c3_mod_ck>, <&timer5_mod_ck>, <&timer2_mod_ck>,
+			 <&uart4_mod_ck>, <&mailbox_mod_ck>, <&rng_mod_ck>,
+			 <&uart6_mod_ck>, <&elm_mod_ck>, <&spi1_mod_ck>,
+			 <&epwmss1_mod_ck>, <&l4_ls_mod_ck>, <&uart5_mod_ck>,
+			 <&mmc1_mod_ck>, <&timer6_mod_ck>, <&timer3_mod_ck>,
+			 <&timer4_mod_ck>, <&i2c2_mod_ck>, <&mmc2_mod_ck>,
+			 <&gpio3_mod_ck>, <&uart3_mod_ck>, <&timer7_mod_ck>,
+			 <&epwmss0_mod_ck>, <&epwmss2_mod_ck>,
+			 <&spinlock_mod_ck>, <&ocpwp_mod_ck>;
+	};
+
+	gfx_l3_clkdm: gfx_l3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gfx_mod_ck>;
+	};
+
+	l3s_clkdm: l3s_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&usb_otg_hs_mod_ck>, <&gpmc_mod_ck>, <&mcasp0_mod_ck>,
+			 <&mmc3_mod_ck>, <&mcasp1_mod_ck>;
+	};
+
+	l4_wkup_aon_clkdm: l4_wkup_aon_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&wkup_m3_mod_ck>;
+	};
+
+	l4_wkup_clkdm: l4_wkup_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&control_mod_ck>, <&adc_tsc_mod_ck>, <&uart1_mod_ck>,
+			 <&smartreflex0_mod_ck>, <&smartreflex1_mod_ck>,
+			 <&l4_wkup_mod_ck>, <&gpio1_mod_ck>, <&timer1_mod_ck>,
+			 <&wd_timer2_mod_ck>, <&i2c1_mod_ck>;
+	};
+
+	l4hs_clkdm: l4hs_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l4_hs_mod_ck>;
+	};
+
+	l3_clkdm: l3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_mod_ck>, <&ocmcram_mod_ck>, <&aes_mod_ck>,
+			 <&sham_mod_ck>, <&emif_mod_ck>, <&tpcc_mod_ck>,
+			 <&tptc0_mod_ck>, <&l3_instr_mod_ck>, <&tptc2_mod_ck>,
+			 <&tptc1_mod_ck>;
+	};
+
+	l4_cefuse_clkdm: l4_cefuse_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&cefuse_mod_ck>;
 	};
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
