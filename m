From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/8] ARM: dts: omap2: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:07 +0300
Message-ID: <1459782973-21201-3-git-send-email-t-kristo@ti.com>
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
name. This patch fixes following type of warnings for OMAP2 clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap2420-clocks.dtsi |   38 +++---
 arch/arm/boot/dts/omap2430-clocks.dtsi |   58 ++++----
 arch/arm/boot/dts/omap24xx-clocks.dtsi |  228 ++++++++++++++++----------------
 3 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-clocks.dtsi b/arch/arm/boot/dts/omap2420-clocks.dtsi
index ce8c742..f8e5bd3 100644
--- a/arch/arm/boot/dts/omap2420-clocks.dtsi
+++ b/arch/arm/boot/dts/omap2420-clocks.dtsi
@@ -9,7 +9,7 @@
  */
 
 &prcm_clocks {
-	sys_clkout2_src_gate: sys_clkout2_src_gate {
+	sys_clkout2_src_gate: sys_clkout2_src_gate@70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&core_ck>;
@@ -17,7 +17,7 @@
 		reg = <0x0070>;
 	};
 
-	sys_clkout2_src_mux: sys_clkout2_src_mux {
+	sys_clkout2_src_mux: sys_clkout2_src_mux@70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_ck>, <&sys_ck>, <&func_96m_ck>, <&func_54m_ck>;
@@ -31,7 +31,7 @@
 		clocks = <&sys_clkout2_src_gate>, <&sys_clkout2_src_mux>;
 	};
 
-	sys_clkout2: sys_clkout2 {
+	sys_clkout2: sys_clkout2@70 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkout2_src>;
@@ -41,7 +41,7 @@
 		ti,index-power-of-two;
 	};
 
-	dsp_gate_ick: dsp_gate_ick {
+	dsp_gate_ick: dsp_gate_ick@810 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-interface-clock";
 		clocks = <&dsp_fck>;
@@ -49,7 +49,7 @@
 		reg = <0x0810>;
 	};
 
-	dsp_div_ick: dsp_div_ick {
+	dsp_div_ick: dsp_div_ick@840 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&dsp_fck>;
@@ -65,7 +65,7 @@
 		clocks = <&dsp_gate_ick>, <&dsp_div_ick>;
 	};
 
-	iva1_gate_ifck: iva1_gate_ifck {
+	iva1_gate_ifck: iva1_gate_ifck@800 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_ck>;
@@ -73,7 +73,7 @@
 		reg = <0x0800>;
 	};
 
-	iva1_div_ifck: iva1_div_ifck {
+	iva1_div_ifck: iva1_div_ifck@840 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_ck>;
@@ -96,7 +96,7 @@
 		clock-div = <2>;
 	};
 
-	iva1_mpu_int_ifck: iva1_mpu_int_ifck {
+	iva1_mpu_int_ifck: iva1_mpu_int_ifck@800 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&iva1_ifck_div>;
@@ -104,7 +104,7 @@
 		reg = <0x0800>;
 	};
 
-	wdt3_ick: wdt3_ick {
+	wdt3_ick: wdt3_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -112,7 +112,7 @@
 		reg = <0x0210>;
 	};
 
-	wdt3_fck: wdt3_fck {
+	wdt3_fck: wdt3_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -120,7 +120,7 @@
 		reg = <0x0200>;
 	};
 
-	mmc_ick: mmc_ick {
+	mmc_ick: mmc_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -128,7 +128,7 @@
 		reg = <0x0210>;
 	};
 
-	mmc_fck: mmc_fck {
+	mmc_fck: mmc_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_96m_ck>;
@@ -136,7 +136,7 @@
 		reg = <0x0200>;
 	};
 
-	eac_ick: eac_ick {
+	eac_ick: eac_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -144,7 +144,7 @@
 		reg = <0x0210>;
 	};
 
-	eac_fck: eac_fck {
+	eac_fck: eac_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_96m_ck>;
@@ -152,7 +152,7 @@
 		reg = <0x0200>;
 	};
 
-	i2c1_fck: i2c1_fck {
+	i2c1_fck: i2c1_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_12m_ck>;
@@ -160,7 +160,7 @@
 		reg = <0x0200>;
 	};
 
-	i2c2_fck: i2c2_fck {
+	i2c2_fck: i2c2_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_12m_ck>;
@@ -168,7 +168,7 @@
 		reg = <0x0200>;
 	};
 
-	vlynq_ick: vlynq_ick {
+	vlynq_ick: vlynq_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l3_ck>;
@@ -176,7 +176,7 @@
 		reg = <0x0210>;
 	};
 
-	vlynq_gate_fck: vlynq_gate_fck {
+	vlynq_gate_fck: vlynq_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_ck>;
@@ -192,7 +192,7 @@
 		clock-div = <18>;
 	};
 
-	vlynq_mux_fck: vlynq_mux_fck {
+	vlynq_mux_fck: vlynq_mux_fck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&core_ck>, <&core_d2_ck>, <&core_d3_ck>, <&core_d4_ck>, <&dummy_ck>, <&core_d6_ck>, <&dummy_ck>, <&core_d8_ck>, <&core_d9_ck>, <&dummy_ck>, <&dummy_ck>, <&core_d12_ck>, <&dummy_ck>, <&dummy_ck>, <&dummy_ck>, <&core_d16_ck>, <&dummy_ck>, <&core_d18_ck>;
diff --git a/arch/arm/boot/dts/omap2430-clocks.dtsi b/arch/arm/boot/dts/omap2430-clocks.dtsi
index 93fed68..a5aa7d6 100644
--- a/arch/arm/boot/dts/omap2430-clocks.dtsi
+++ b/arch/arm/boot/dts/omap2430-clocks.dtsi
@@ -9,7 +9,7 @@
  */
 
 &scm_clocks {
-	mcbsp3_mux_fck: mcbsp3_mux_fck {
+	mcbsp3_mux_fck: mcbsp3_mux_fck@78 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
@@ -22,7 +22,7 @@
 		clocks = <&mcbsp3_gate_fck>, <&mcbsp3_mux_fck>;
 	};
 
-	mcbsp4_mux_fck: mcbsp4_mux_fck {
+	mcbsp4_mux_fck: mcbsp4_mux_fck@78 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
@@ -36,7 +36,7 @@
 		clocks = <&mcbsp4_gate_fck>, <&mcbsp4_mux_fck>;
 	};
 
-	mcbsp5_mux_fck: mcbsp5_mux_fck {
+	mcbsp5_mux_fck: mcbsp5_mux_fck@78 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
@@ -52,7 +52,7 @@
 };
 
 &prcm_clocks {
-	iva2_1_gate_ick: iva2_1_gate_ick {
+	iva2_1_gate_ick: iva2_1_gate_ick@800 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&dsp_fck>;
@@ -60,7 +60,7 @@
 		reg = <0x0800>;
 	};
 
-	iva2_1_div_ick: iva2_1_div_ick {
+	iva2_1_div_ick: iva2_1_div_ick@840 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&dsp_fck>;
@@ -76,7 +76,7 @@
 		clocks = <&iva2_1_gate_ick>, <&iva2_1_div_ick>;
 	};
 
-	mdm_gate_ick: mdm_gate_ick {
+	mdm_gate_ick: mdm_gate_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-interface-clock";
 		clocks = <&core_ck>;
@@ -84,7 +84,7 @@
 		reg = <0x0c10>;
 	};
 
-	mdm_div_ick: mdm_div_ick {
+	mdm_div_ick: mdm_div_ick@c40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_ck>;
@@ -98,7 +98,7 @@
 		clocks = <&mdm_gate_ick>, <&mdm_div_ick>;
 	};
 
-	mdm_osc_ck: mdm_osc_ck {
+	mdm_osc_ck: mdm_osc_ck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&osc_ck>;
@@ -106,7 +106,7 @@
 		reg = <0x0c00>;
 	};
 
-	mcbsp3_ick: mcbsp3_ick {
+	mcbsp3_ick: mcbsp3_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -114,7 +114,7 @@
 		reg = <0x0214>;
 	};
 
-	mcbsp3_gate_fck: mcbsp3_gate_fck {
+	mcbsp3_gate_fck: mcbsp3_gate_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -122,7 +122,7 @@
 		reg = <0x0204>;
 	};
 
-	mcbsp4_ick: mcbsp4_ick {
+	mcbsp4_ick: mcbsp4_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -130,7 +130,7 @@
 		reg = <0x0214>;
 	};
 
-	mcbsp4_gate_fck: mcbsp4_gate_fck {
+	mcbsp4_gate_fck: mcbsp4_gate_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -138,7 +138,7 @@
 		reg = <0x0204>;
 	};
 
-	mcbsp5_ick: mcbsp5_ick {
+	mcbsp5_ick: mcbsp5_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -146,7 +146,7 @@
 		reg = <0x0214>;
 	};
 
-	mcbsp5_gate_fck: mcbsp5_gate_fck {
+	mcbsp5_gate_fck: mcbsp5_gate_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -154,7 +154,7 @@
 		reg = <0x0204>;
 	};
 
-	mcspi3_ick: mcspi3_ick {
+	mcspi3_ick: mcspi3_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -162,7 +162,7 @@
 		reg = <0x0214>;
 	};
 
-	mcspi3_fck: mcspi3_fck {
+	mcspi3_fck: mcspi3_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -170,7 +170,7 @@
 		reg = <0x0204>;
 	};
 
-	icr_ick: icr_ick {
+	icr_ick: icr_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -178,7 +178,7 @@
 		reg = <0x0410>;
 	};
 
-	i2chs1_fck: i2chs1_fck {
+	i2chs1_fck: i2chs1_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,omap2430-interface-clock";
 		clocks = <&func_96m_ck>;
@@ -186,7 +186,7 @@
 		reg = <0x0204>;
 	};
 
-	i2chs2_fck: i2chs2_fck {
+	i2chs2_fck: i2chs2_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,omap2430-interface-clock";
 		clocks = <&func_96m_ck>;
@@ -194,7 +194,7 @@
 		reg = <0x0204>;
 	};
 
-	usbhs_ick: usbhs_ick {
+	usbhs_ick: usbhs_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l3_ck>;
@@ -202,7 +202,7 @@
 		reg = <0x0214>;
 	};
 
-	mmchs1_ick: mmchs1_ick {
+	mmchs1_ick: mmchs1_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -210,7 +210,7 @@
 		reg = <0x0214>;
 	};
 
-	mmchs1_fck: mmchs1_fck {
+	mmchs1_fck: mmchs1_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_96m_ck>;
@@ -218,7 +218,7 @@
 		reg = <0x0204>;
 	};
 
-	mmchs2_ick: mmchs2_ick {
+	mmchs2_ick: mmchs2_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -226,7 +226,7 @@
 		reg = <0x0214>;
 	};
 
-	mmchs2_fck: mmchs2_fck {
+	mmchs2_fck: mmchs2_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_96m_ck>;
@@ -234,7 +234,7 @@
 		reg = <0x0204>;
 	};
 
-	gpio5_ick: gpio5_ick {
+	gpio5_ick: gpio5_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -242,7 +242,7 @@
 		reg = <0x0214>;
 	};
 
-	gpio5_fck: gpio5_fck {
+	gpio5_fck: gpio5_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -250,7 +250,7 @@
 		reg = <0x0204>;
 	};
 
-	mdm_intc_ick: mdm_intc_ick {
+	mdm_intc_ick: mdm_intc_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -258,7 +258,7 @@
 		reg = <0x0214>;
 	};
 
-	mmchsdb1_fck: mmchsdb1_fck {
+	mmchsdb1_fck: mmchsdb1_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -266,7 +266,7 @@
 		reg = <0x0204>;
 	};
 
-	mmchsdb2_fck: mmchsdb2_fck {
+	mmchsdb2_fck: mmchsdb2_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
diff --git a/arch/arm/boot/dts/omap24xx-clocks.dtsi b/arch/arm/boot/dts/omap24xx-clocks.dtsi
index 63965b8..ca73722 100644
--- a/arch/arm/boot/dts/omap24xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap24xx-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &scm_clocks {
-	mcbsp1_mux_fck: mcbsp1_mux_fck {
+	mcbsp1_mux_fck: mcbsp1_mux_fck@4 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
@@ -22,7 +22,7 @@
 		clocks = <&mcbsp1_gate_fck>, <&mcbsp1_mux_fck>;
 	};
 
-	mcbsp2_mux_fck: mcbsp2_mux_fck {
+	mcbsp2_mux_fck: mcbsp2_mux_fck@4 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
@@ -74,7 +74,7 @@
 		clock-frequency = <26000000>;
 	};
 
-	aplls_clkin_ck: aplls_clkin_ck {
+	aplls_clkin_ck: aplls_clkin_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_19200000_ck>, <&virt_26m_ck>, <&virt_13m_ck>, <&virt_12m_ck>;
@@ -90,7 +90,7 @@
 		clock-div = <1>;
 	};
 
-	osc_ck: osc_ck {
+	osc_ck: osc_ck@60 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&aplls_clkin_ck>, <&aplls_clkin_x2_ck>;
@@ -99,7 +99,7 @@
 		ti,index-starts-at-one;
 	};
 
-	sys_ck: sys_ck {
+	sys_ck: sys_ck@60 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&osc_ck>;
@@ -121,14 +121,14 @@
 		clock-frequency = <0x0>;
 	};
 
-	dpll_ck: dpll_ck {
+	dpll_ck: dpll_ck@500 {
 		#clock-cells = <0>;
 		compatible = "ti,omap2-dpll-core-clock";
 		clocks = <&sys_ck>, <&sys_ck>;
 		reg = <0x0500>, <0x0540>;
 	};
 
-	apll96_ck: apll96_ck {
+	apll96_ck: apll96_ck@500 {
 		#clock-cells = <0>;
 		compatible = "ti,omap2-apll-clock";
 		clocks = <&sys_ck>;
@@ -138,7 +138,7 @@
 		reg = <0x0500>, <0x0530>, <0x0520>;
 	};
 
-	apll54_ck: apll54_ck {
+	apll54_ck: apll54_ck@500 {
 		#clock-cells = <0>;
 		compatible = "ti,omap2-apll-clock";
 		clocks = <&sys_ck>;
@@ -148,7 +148,7 @@
 		reg = <0x0500>, <0x0530>, <0x0520>;
 	};
 
-	func_54m_ck: func_54m_ck {
+	func_54m_ck: func_54m_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&apll54_ck>, <&alt_ck>;
@@ -176,7 +176,7 @@
 		clock-div = <2>;
 	};
 
-	func_48m_ck: func_48m_ck {
+	func_48m_ck: func_48m_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&apll96_d2_ck>, <&alt_ck>;
@@ -192,7 +192,7 @@
 		clock-div = <4>;
 	};
 
-	sys_clkout_src_gate: sys_clkout_src_gate {
+	sys_clkout_src_gate: sys_clkout_src_gate@70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&core_ck>;
@@ -200,7 +200,7 @@
 		reg = <0x0070>;
 	};
 
-	sys_clkout_src_mux: sys_clkout_src_mux {
+	sys_clkout_src_mux: sys_clkout_src_mux@70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_ck>, <&sys_ck>, <&func_96m_ck>, <&func_54m_ck>;
@@ -213,7 +213,7 @@
 		clocks = <&sys_clkout_src_gate>, <&sys_clkout_src_mux>;
 	};
 
-	sys_clkout: sys_clkout {
+	sys_clkout: sys_clkout@70 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkout_src>;
@@ -223,7 +223,7 @@
 		ti,index-power-of-two;
 	};
 
-	emul_ck: emul_ck {
+	emul_ck: emul_ck@78 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_54m_ck>;
@@ -231,7 +231,7 @@
 		reg = <0x0078>;
 	};
 
-	mpu_ck: mpu_ck {
+	mpu_ck: mpu_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_ck>;
@@ -240,7 +240,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dsp_gate_fck: dsp_gate_fck {
+	dsp_gate_fck: dsp_gate_fck@800 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_ck>;
@@ -248,7 +248,7 @@
 		reg = <0x0800>;
 	};
 
-	dsp_div_fck: dsp_div_fck {
+	dsp_div_fck: dsp_div_fck@840 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_ck>;
@@ -261,7 +261,7 @@
 		clocks = <&dsp_gate_fck>, <&dsp_div_fck>;
 	};
 
-	core_l3_ck: core_l3_ck {
+	core_l3_ck: core_l3_ck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_ck>;
@@ -270,7 +270,7 @@
 		ti,index-starts-at-one;
 	};
 
-	gfx_3d_gate_fck: gfx_3d_gate_fck {
+	gfx_3d_gate_fck: gfx_3d_gate_fck@300 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_l3_ck>;
@@ -278,7 +278,7 @@
 		reg = <0x0300>;
 	};
 
-	gfx_3d_div_fck: gfx_3d_div_fck {
+	gfx_3d_div_fck: gfx_3d_div_fck@340 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_l3_ck>;
@@ -293,7 +293,7 @@
 		clocks = <&gfx_3d_gate_fck>, <&gfx_3d_div_fck>;
 	};
 
-	gfx_2d_gate_fck: gfx_2d_gate_fck {
+	gfx_2d_gate_fck: gfx_2d_gate_fck@300 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_l3_ck>;
@@ -301,7 +301,7 @@
 		reg = <0x0300>;
 	};
 
-	gfx_2d_div_fck: gfx_2d_div_fck {
+	gfx_2d_div_fck: gfx_2d_div_fck@340 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_l3_ck>;
@@ -316,7 +316,7 @@
 		clocks = <&gfx_2d_gate_fck>, <&gfx_2d_div_fck>;
 	};
 
-	gfx_ick: gfx_ick {
+	gfx_ick: gfx_ick@310 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_l3_ck>;
@@ -324,7 +324,7 @@
 		reg = <0x0310>;
 	};
 
-	l4_ck: l4_ck {
+	l4_ck: l4_ck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_l3_ck>;
@@ -334,7 +334,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dss_ick: dss_ick {
+	dss_ick: dss_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&l4_ck>;
@@ -342,7 +342,7 @@
 		reg = <0x0210>;
 	};
 
-	dss1_gate_fck: dss1_gate_fck {
+	dss1_gate_fck: dss1_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&core_ck>;
@@ -428,7 +428,7 @@
 		clock-div = <16>;
 	};
 
-	dss1_mux_fck: dss1_mux_fck {
+	dss1_mux_fck: dss1_mux_fck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_ck>, <&core_ck>, <&core_d2_ck>, <&core_d3_ck>, <&core_d4_ck>, <&core_d5_ck>, <&core_d6_ck>, <&core_d8_ck>, <&core_d9_ck>, <&core_d12_ck>, <&core_d16_ck>;
@@ -442,7 +442,7 @@
 		clocks = <&dss1_gate_fck>, <&dss1_mux_fck>;
 	};
 
-	dss2_gate_fck: dss2_gate_fck {
+	dss2_gate_fck: dss2_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -450,7 +450,7 @@
 		reg = <0x0200>;
 	};
 
-	dss2_mux_fck: dss2_mux_fck {
+	dss2_mux_fck: dss2_mux_fck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_ck>, <&func_48m_ck>;
@@ -464,7 +464,7 @@
 		clocks = <&dss2_gate_fck>, <&dss2_mux_fck>;
 	};
 
-	dss_54m_fck: dss_54m_fck {
+	dss_54m_fck: dss_54m_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_54m_ck>;
@@ -472,7 +472,7 @@
 		reg = <0x0200>;
 	};
 
-	ssi_ssr_sst_gate_fck: ssi_ssr_sst_gate_fck {
+	ssi_ssr_sst_gate_fck: ssi_ssr_sst_gate_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_ck>;
@@ -480,7 +480,7 @@
 		reg = <0x0204>;
 	};
 
-	ssi_ssr_sst_div_fck: ssi_ssr_sst_div_fck {
+	ssi_ssr_sst_div_fck: ssi_ssr_sst_div_fck@240 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_ck>;
@@ -494,7 +494,7 @@
 		clocks = <&ssi_ssr_sst_gate_fck>, <&ssi_ssr_sst_div_fck>;
 	};
 
-	usb_l4_gate_ick: usb_l4_gate_ick {
+	usb_l4_gate_ick: usb_l4_gate_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-interface-clock";
 		clocks = <&core_l3_ck>;
@@ -502,7 +502,7 @@
 		reg = <0x0214>;
 	};
 
-	usb_l4_div_ick: usb_l4_div_ick {
+	usb_l4_div_ick: usb_l4_div_ick@240 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&core_l3_ck>;
@@ -517,7 +517,7 @@
 		clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
 	};
 
-	ssi_l4_ick: ssi_l4_ick {
+	ssi_l4_ick: ssi_l4_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -525,7 +525,7 @@
 		reg = <0x0214>;
 	};
 
-	gpt1_ick: gpt1_ick {
+	gpt1_ick: gpt1_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -533,7 +533,7 @@
 		reg = <0x0410>;
 	};
 
-	gpt1_gate_fck: gpt1_gate_fck {
+	gpt1_gate_fck: gpt1_gate_fck@400 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -541,7 +541,7 @@
 		reg = <0x0400>;
 	};
 
-	gpt1_mux_fck: gpt1_mux_fck {
+	gpt1_mux_fck: gpt1_mux_fck@440 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -554,7 +554,7 @@
 		clocks = <&gpt1_gate_fck>, <&gpt1_mux_fck>;
 	};
 
-	gpt2_ick: gpt2_ick {
+	gpt2_ick: gpt2_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -562,7 +562,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt2_gate_fck: gpt2_gate_fck {
+	gpt2_gate_fck: gpt2_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -570,7 +570,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt2_mux_fck: gpt2_mux_fck {
+	gpt2_mux_fck: gpt2_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -584,7 +584,7 @@
 		clocks = <&gpt2_gate_fck>, <&gpt2_mux_fck>;
 	};
 
-	gpt3_ick: gpt3_ick {
+	gpt3_ick: gpt3_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -592,7 +592,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt3_gate_fck: gpt3_gate_fck {
+	gpt3_gate_fck: gpt3_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -600,7 +600,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt3_mux_fck: gpt3_mux_fck {
+	gpt3_mux_fck: gpt3_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -614,7 +614,7 @@
 		clocks = <&gpt3_gate_fck>, <&gpt3_mux_fck>;
 	};
 
-	gpt4_ick: gpt4_ick {
+	gpt4_ick: gpt4_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -622,7 +622,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt4_gate_fck: gpt4_gate_fck {
+	gpt4_gate_fck: gpt4_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -630,7 +630,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt4_mux_fck: gpt4_mux_fck {
+	gpt4_mux_fck: gpt4_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -644,7 +644,7 @@
 		clocks = <&gpt4_gate_fck>, <&gpt4_mux_fck>;
 	};
 
-	gpt5_ick: gpt5_ick {
+	gpt5_ick: gpt5_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -652,7 +652,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt5_gate_fck: gpt5_gate_fck {
+	gpt5_gate_fck: gpt5_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -660,7 +660,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt5_mux_fck: gpt5_mux_fck {
+	gpt5_mux_fck: gpt5_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -674,7 +674,7 @@
 		clocks = <&gpt5_gate_fck>, <&gpt5_mux_fck>;
 	};
 
-	gpt6_ick: gpt6_ick {
+	gpt6_ick: gpt6_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -682,7 +682,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt6_gate_fck: gpt6_gate_fck {
+	gpt6_gate_fck: gpt6_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -690,7 +690,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt6_mux_fck: gpt6_mux_fck {
+	gpt6_mux_fck: gpt6_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -704,7 +704,7 @@
 		clocks = <&gpt6_gate_fck>, <&gpt6_mux_fck>;
 	};
 
-	gpt7_ick: gpt7_ick {
+	gpt7_ick: gpt7_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -712,7 +712,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt7_gate_fck: gpt7_gate_fck {
+	gpt7_gate_fck: gpt7_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -720,7 +720,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt7_mux_fck: gpt7_mux_fck {
+	gpt7_mux_fck: gpt7_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -734,7 +734,7 @@
 		clocks = <&gpt7_gate_fck>, <&gpt7_mux_fck>;
 	};
 
-	gpt8_ick: gpt8_ick {
+	gpt8_ick: gpt8_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -742,7 +742,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt8_gate_fck: gpt8_gate_fck {
+	gpt8_gate_fck: gpt8_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -750,7 +750,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt8_mux_fck: gpt8_mux_fck {
+	gpt8_mux_fck: gpt8_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -764,7 +764,7 @@
 		clocks = <&gpt8_gate_fck>, <&gpt8_mux_fck>;
 	};
 
-	gpt9_ick: gpt9_ick {
+	gpt9_ick: gpt9_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -772,7 +772,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt9_gate_fck: gpt9_gate_fck {
+	gpt9_gate_fck: gpt9_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -780,7 +780,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt9_mux_fck: gpt9_mux_fck {
+	gpt9_mux_fck: gpt9_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -794,7 +794,7 @@
 		clocks = <&gpt9_gate_fck>, <&gpt9_mux_fck>;
 	};
 
-	gpt10_ick: gpt10_ick {
+	gpt10_ick: gpt10_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -802,7 +802,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt10_gate_fck: gpt10_gate_fck {
+	gpt10_gate_fck: gpt10_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -810,7 +810,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt10_mux_fck: gpt10_mux_fck {
+	gpt10_mux_fck: gpt10_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -824,7 +824,7 @@
 		clocks = <&gpt10_gate_fck>, <&gpt10_mux_fck>;
 	};
 
-	gpt11_ick: gpt11_ick {
+	gpt11_ick: gpt11_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -832,7 +832,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt11_gate_fck: gpt11_gate_fck {
+	gpt11_gate_fck: gpt11_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -840,7 +840,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt11_mux_fck: gpt11_mux_fck {
+	gpt11_mux_fck: gpt11_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -854,7 +854,7 @@
 		clocks = <&gpt11_gate_fck>, <&gpt11_mux_fck>;
 	};
 
-	gpt12_ick: gpt12_ick {
+	gpt12_ick: gpt12_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -862,7 +862,7 @@
 		reg = <0x0210>;
 	};
 
-	gpt12_gate_fck: gpt12_gate_fck {
+	gpt12_gate_fck: gpt12_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -870,7 +870,7 @@
 		reg = <0x0200>;
 	};
 
-	gpt12_mux_fck: gpt12_mux_fck {
+	gpt12_mux_fck: gpt12_mux_fck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_32k_ck>, <&sys_ck>, <&alt_ck>;
@@ -884,7 +884,7 @@
 		clocks = <&gpt12_gate_fck>, <&gpt12_mux_fck>;
 	};
 
-	mcbsp1_ick: mcbsp1_ick {
+	mcbsp1_ick: mcbsp1_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -892,7 +892,7 @@
 		reg = <0x0210>;
 	};
 
-	mcbsp1_gate_fck: mcbsp1_gate_fck {
+	mcbsp1_gate_fck: mcbsp1_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -900,7 +900,7 @@
 		reg = <0x0200>;
 	};
 
-	mcbsp2_ick: mcbsp2_ick {
+	mcbsp2_ick: mcbsp2_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -908,7 +908,7 @@
 		reg = <0x0210>;
 	};
 
-	mcbsp2_gate_fck: mcbsp2_gate_fck {
+	mcbsp2_gate_fck: mcbsp2_gate_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -916,7 +916,7 @@
 		reg = <0x0200>;
 	};
 
-	mcspi1_ick: mcspi1_ick {
+	mcspi1_ick: mcspi1_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -924,7 +924,7 @@
 		reg = <0x0210>;
 	};
 
-	mcspi1_fck: mcspi1_fck {
+	mcspi1_fck: mcspi1_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -932,7 +932,7 @@
 		reg = <0x0200>;
 	};
 
-	mcspi2_ick: mcspi2_ick {
+	mcspi2_ick: mcspi2_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -940,7 +940,7 @@
 		reg = <0x0210>;
 	};
 
-	mcspi2_fck: mcspi2_fck {
+	mcspi2_fck: mcspi2_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -948,7 +948,7 @@
 		reg = <0x0200>;
 	};
 
-	uart1_ick: uart1_ick {
+	uart1_ick: uart1_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -956,7 +956,7 @@
 		reg = <0x0210>;
 	};
 
-	uart1_fck: uart1_fck {
+	uart1_fck: uart1_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -964,7 +964,7 @@
 		reg = <0x0200>;
 	};
 
-	uart2_ick: uart2_ick {
+	uart2_ick: uart2_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -972,7 +972,7 @@
 		reg = <0x0210>;
 	};
 
-	uart2_fck: uart2_fck {
+	uart2_fck: uart2_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -980,7 +980,7 @@
 		reg = <0x0200>;
 	};
 
-	uart3_ick: uart3_ick {
+	uart3_ick: uart3_ick@214 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -988,7 +988,7 @@
 		reg = <0x0214>;
 	};
 
-	uart3_fck: uart3_fck {
+	uart3_fck: uart3_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
@@ -996,7 +996,7 @@
 		reg = <0x0204>;
 	};
 
-	gpios_ick: gpios_ick {
+	gpios_ick: gpios_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -1004,7 +1004,7 @@
 		reg = <0x0410>;
 	};
 
-	gpios_fck: gpios_fck {
+	gpios_fck: gpios_fck@400 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -1012,7 +1012,7 @@
 		reg = <0x0400>;
 	};
 
-	mpu_wdt_ick: mpu_wdt_ick {
+	mpu_wdt_ick: mpu_wdt_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -1020,7 +1020,7 @@
 		reg = <0x0410>;
 	};
 
-	mpu_wdt_fck: mpu_wdt_fck {
+	mpu_wdt_fck: mpu_wdt_fck@400 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -1028,7 +1028,7 @@
 		reg = <0x0400>;
 	};
 
-	sync_32k_ick: sync_32k_ick {
+	sync_32k_ick: sync_32k_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -1036,7 +1036,7 @@
 		reg = <0x0410>;
 	};
 
-	wdt1_ick: wdt1_ick {
+	wdt1_ick: wdt1_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -1044,7 +1044,7 @@
 		reg = <0x0410>;
 	};
 
-	omapctrl_ick: omapctrl_ick {
+	omapctrl_ick: omapctrl_ick@410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -1052,7 +1052,7 @@
 		reg = <0x0410>;
 	};
 
-	cam_fck: cam_fck {
+	cam_fck: cam_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_96m_ck>;
@@ -1060,7 +1060,7 @@
 		reg = <0x0200>;
 	};
 
-	cam_ick: cam_ick {
+	cam_ick: cam_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&l4_ck>;
@@ -1068,7 +1068,7 @@
 		reg = <0x0210>;
 	};
 
-	mailboxes_ick: mailboxes_ick {
+	mailboxes_ick: mailboxes_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1076,7 +1076,7 @@
 		reg = <0x0210>;
 	};
 
-	wdt4_ick: wdt4_ick {
+	wdt4_ick: wdt4_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1084,7 +1084,7 @@
 		reg = <0x0210>;
 	};
 
-	wdt4_fck: wdt4_fck {
+	wdt4_fck: wdt4_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_32k_ck>;
@@ -1092,7 +1092,7 @@
 		reg = <0x0200>;
 	};
 
-	mspro_ick: mspro_ick {
+	mspro_ick: mspro_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1100,7 +1100,7 @@
 		reg = <0x0210>;
 	};
 
-	mspro_fck: mspro_fck {
+	mspro_fck: mspro_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_96m_ck>;
@@ -1108,7 +1108,7 @@
 		reg = <0x0200>;
 	};
 
-	fac_ick: fac_ick {
+	fac_ick: fac_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1116,7 +1116,7 @@
 		reg = <0x0210>;
 	};
 
-	fac_fck: fac_fck {
+	fac_fck: fac_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_12m_ck>;
@@ -1124,7 +1124,7 @@
 		reg = <0x0200>;
 	};
 
-	hdq_ick: hdq_ick {
+	hdq_ick: hdq_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1132,7 +1132,7 @@
 		reg = <0x0210>;
 	};
 
-	hdq_fck: hdq_fck {
+	hdq_fck: hdq_fck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_12m_ck>;
@@ -1140,7 +1140,7 @@
 		reg = <0x0200>;
 	};
 
-	i2c1_ick: i2c1_ick {
+	i2c1_ick: i2c1_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1148,7 +1148,7 @@
 		reg = <0x0210>;
 	};
 
-	i2c2_ick: i2c2_ick {
+	i2c2_ick: i2c2_ick@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1156,7 +1156,7 @@
 		reg = <0x0210>;
 	};
 
-	gpmc_fck: gpmc_fck {
+	gpmc_fck: gpmc_fck@238 {
 		#clock-cells = <0>;
 		compatible = "ti,fixed-factor-clock";
 		clocks = <&core_l3_ck>;
@@ -1174,7 +1174,7 @@
 		clock-div = <1>;
 	};
 
-	sdma_ick: sdma_ick {
+	sdma_ick: sdma_ick@238 {
 		#clock-cells = <0>;
 		compatible = "ti,fixed-factor-clock";
 		clocks = <&core_l3_ck>;
@@ -1184,7 +1184,7 @@
 		ti,clock-mult = <1>;
 	};
 
-	sdrc_ick: sdrc_ick {
+	sdrc_ick: sdrc_ick@238 {
 		#clock-cells = <0>;
 		compatible = "ti,fixed-factor-clock";
 		clocks = <&core_l3_ck>;
@@ -1194,7 +1194,7 @@
 		ti,clock-mult = <1>;
 	};
 
-	des_ick: des_ick {
+	des_ick: des_ick@21c {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1202,7 +1202,7 @@
 		reg = <0x021c>;
 	};
 
-	sha_ick: sha_ick {
+	sha_ick: sha_ick@21c {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1210,7 +1210,7 @@
 		reg = <0x021c>;
 	};
 
-	rng_ick: rng_ick {
+	rng_ick: rng_ick@21c {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1218,7 +1218,7 @@
 		reg = <0x021c>;
 	};
 
-	aes_ick: aes_ick {
+	aes_ick: aes_ick@21c {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1226,7 +1226,7 @@
 		reg = <0x021c>;
 	};
 
-	pka_ick: pka_ick {
+	pka_ick: pka_ick@21c {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l4_ck>;
@@ -1234,7 +1234,7 @@
 		reg = <0x021c>;
 	};
 
-	usb_fck: usb_fck {
+	usb_fck: usb_fck@204 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&func_48m_ck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
