From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 33/43] ARM: dts: am43xx clock data
Date: Fri, 25 Oct 2013 18:57:27 +0300
Message-ID: <1382716658-6964-34-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53448 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911Ab3JYQAa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:00:30 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch creates a unique node for each clock in the AM43xx power,
reset and clock manager (PRCM).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |    2 +
 arch/arm/boot/dts/am43xx-clocks.dtsi |  666 ++++++++++++++++++++++++++++++++++
 2 files changed, 668 insertions(+)
 create mode 100644 arch/arm/boot/dts/am43xx-clocks.dtsi

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 974d103..1fb3ac2 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -67,6 +67,8 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		/include/ "am43xx-clocks.dtsi"
+
 		edma: edma@49000000 {
 			compatible = "ti,edma3";
 			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
new file mode 100644
index 0000000..1cc5071
--- /dev/null
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -0,0 +1,666 @@
+/*
+ * Device Tree Source for AM43xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+scrm: scrm@44e10000 {
+	compatible = "ti,scrm";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x44e10000 0x2000>;
+
+	sys_clkin_ck: sys_clkin_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&virt_19200000_ck>, <&virt_24000000_ck>, <&virt_25000000_ck>, <&virt_26000000_ck>;
+		ti,bit-shift = <22>;
+		reg = <0x0040>;
+	};
+
+	adc_tsc_fck: adc_tsc_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	dcan0_fck: dcan0_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	dcan1_fck: dcan1_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	mcasp0_fck: mcasp0_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	mcasp1_fck: mcasp1_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	smartreflex0_fck: smartreflex0_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	smartreflex1_fck: smartreflex1_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	sha0_fck: sha0_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	aes0_fck: aes0_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+};
+prcm: prcm@44df0000 {
+	compatible = "ti,prcm";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x44df0000 0x11000>;
+
+	clk_32768_ck: clk_32768_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	clk_rc32k_ck: clk_rc32k_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	virt_19200000_ck: virt_19200000_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <19200000>;
+	};
+
+	virt_24000000_ck: virt_24000000_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	virt_25000000_ck: virt_25000000_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+	};
+
+	virt_26000000_ck: virt_26000000_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
+	tclkin_ck: tclkin_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
+	dpll_core_ck: dpll_core_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-core-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2d20>, <0x2d24>, <0x2d2c>;
+	};
+
+	dpll_core_x2_ck: dpll_core_x2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-x2-clock";
+		clocks = <&dpll_core_ck>;
+	};
+
+	dpll_core_m4_ck: dpll_core_m4_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_core_x2_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2d38>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_core_m5_ck: dpll_core_m5_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_core_x2_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2d3c>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_core_m6_ck: dpll_core_m6_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_core_x2_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2d40>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_mpu_ck: dpll_mpu_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2d60>, <0x2d64>, <0x2d6c>;
+	};
+
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_mpu_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2d70>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_ddr_ck: dpll_ddr_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2da0>, <0x2da4>, <0x2dac>;
+	};
+
+	dpll_ddr_m2_ck: dpll_ddr_m2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_ddr_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2db0>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_disp_ck: dpll_disp_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2e20>, <0x2e24>, <0x2e2c>;
+	};
+
+	dpll_disp_m2_ck: dpll_disp_m2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_disp_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2e30>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_per_ck: dpll_per_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-j-type-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2de0>, <0x2de4>, <0x2dec>;
+	};
+
+	dpll_per_m2_ck: dpll_per_m2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_per_ck>;
+		ti,max-div = <127>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2df0>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_per_m2_div4_wkupdm_ck: dpll_per_m2_div4_wkupdm_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <4>;
+	};
+
+	dpll_per_m2_div4_ck: dpll_per_m2_div4_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <4>;
+	};
+
+	clk_24mhz: clk_24mhz {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <8>;
+	};
+
+	clkdiv32k_ck: clkdiv32k_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&clk_24mhz>;
+		clock-mult = <1>;
+		clock-div = <732>;
+	};
+
+	clkdiv32k_ick: clkdiv32k_ick {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x2a38>;
+	};
+
+	sysclk_div: sysclk_div {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	pruss_ocp_gclk: pruss_ocp_gclk {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk_div>, <&dpll_disp_m2_ck>;
+		reg = <0x4248>;
+	};
+
+	clk_32k_tpm_ck: clk_32k_tpm_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	timer1_fck: timer1_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>, <&clk_32k_tpm_ck>;
+		reg = <0x4200>;
+	};
+
+	timer2_fck: timer2_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x4204>;
+	};
+
+	timer3_fck: timer3_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x4208>;
+	};
+
+	timer4_fck: timer4_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x420c>;
+	};
+
+	timer5_fck: timer5_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x4210>;
+	};
+
+	timer6_fck: timer6_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x4214>;
+	};
+
+	timer7_fck: timer7_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+		reg = <0x4218>;
+	};
+
+	wdt1_fck: wdt1_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_rc32k_ck>, <&clkdiv32k_ick>;
+		reg = <0x422c>;
+	};
+
+	l3_gclk: l3_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	dpll_core_m4_div2_ck: dpll_core_m4_div2_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sysclk_div>;
+		clock-mult = <1>;
+		clock-div = <2>;
+	};
+
+	l4hs_gclk: l4hs_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	l3s_gclk: l3s_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_div2_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	l4ls_gclk: l4ls_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m4_div2_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	cpsw_125mhz_gclk: cpsw_125mhz_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m5_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
+	};
+
+	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk_div>, <&dpll_core_m5_ck>, <&dpll_disp_m2_ck>;
+		reg = <0x4238>;
+	};
+
+	clk_32k_mosc_ck: clk_32k_mosc_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	gpio0_dbclk_mux_ck: gpio0_dbclk_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_rc32k_ck>, <&clk_32768_ck>, <&clkdiv32k_ick>, <&clk_32k_mosc_ck>, <&clk_32k_tpm_ck>;
+		reg = <0x4240>;
+	};
+
+	gpio0_dbclk: gpio0_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&gpio0_dbclk_mux_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x2b68>;
+	};
+
+	gpio1_dbclk: gpio1_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ick>;
+		ti,bit-shift = <8>;
+		reg = <0x8c78>;
+	};
+
+	gpio2_dbclk: gpio2_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ick>;
+		ti,bit-shift = <8>;
+		reg = <0x8c80>;
+	};
+
+	gpio3_dbclk: gpio3_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ick>;
+		ti,bit-shift = <8>;
+		reg = <0x8c88>;
+	};
+
+	gpio4_dbclk: gpio4_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ick>;
+		ti,bit-shift = <8>;
+		reg = <0x8c90>;
+	};
+
+	gpio5_dbclk: gpio5_dbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkdiv32k_ick>;
+		ti,bit-shift = <8>;
+		reg = <0x8c98>;
+	};
+
+	mmc_clk: mmc_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
+	};
+
+	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk_div>, <&dpll_per_m2_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x423c>;
+	};
+
+	gfx_fck_div_ck: gfx_fck_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&gfx_fclk_clksel_ck>;
+		reg = <0x423c>;
+		ti,max-div = <2>;
+	};
+
+	disp_clk: disp_clk {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
+		reg = <0x4244>;
+	};
+
+	dpll_extdev_ck: dpll_extdev_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x2e60>, <0x2e64>, <0x2e6c>;
+	};
+
+	dpll_extdev_m2_ck: dpll_extdev_m2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_extdev_ck>;
+		ti,max-div = <127>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2e70>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	mux_synctimer32k_ck: mux_synctimer32k_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>, <&clkdiv32k_ick>;
+		reg = <0x4230>;
+	};
+
+	synctimer_32kclk: synctimer_32kclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&mux_synctimer32k_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x2a30>;
+	};
+
+	timer8_fck: timer8_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
+		reg = <0x421c>;
+	};
+
+	timer9_fck: timer9_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
+		reg = <0x4220>;
+	};
+
+	timer10_fck: timer10_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
+		reg = <0x4224>;
+	};
+
+	timer11_fck: timer11_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
+		reg = <0x4228>;
+	};
+
+	cpsw_50m_clkdiv: cpsw_50m_clkdiv {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m5_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	cpsw_5m_clkdiv: cpsw_5m_clkdiv {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&cpsw_50m_clkdiv>;
+		clock-mult = <1>;
+		clock-div = <10>;
+	};
+
+	dpll_ddr_x2_ck: dpll_ddr_x2_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-x2-clock";
+		clocks = <&dpll_ddr_ck>;
+	};
+
+	dpll_ddr_m4_ck: dpll_ddr_m4_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_ddr_x2_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2db8>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_per_clkdcoldo: dpll_per_clkdcoldo {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	dll_aging_clk_div: dll_aging_clk_div {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&sys_clkin_ck>;
+		reg = <0x4250>;
+		ti,dividers = <8>, <16>, <32>;
+	};
+
+	div_core_25m_ck: div_core_25m_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sysclk_div>;
+		clock-mult = <1>;
+		clock-div = <8>;
+	};
+
+	func_12m_clk: func_12m_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_per_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <16>;
+	};
+
+	vtp_clk_div: vtp_clk_div {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
+	};
+
+	usbphy_32khz_clkmux: usbphy_32khz_clkmux {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>;
+		reg = <0x4260>;
+	};
+};
-- 
1.7.9.5

