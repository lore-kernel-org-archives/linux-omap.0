From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/8] ARM: dts: omap4: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:08 +0300
Message-ID: <1459782973-21201-4-git-send-email-t-kristo@ti.com>
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
name. This patch fixes following type of warnings for OMAP4 clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap443x-clocks.dtsi |    2 +-
 arch/arm/boot/dts/omap446x-clocks.dtsi |    4 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi |  316 ++++++++++++++++----------------
 3 files changed, 161 insertions(+), 161 deletions(-)

diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi b/arch/arm/boot/dts/omap443x-clocks.dtsi
index 2bd2166..f370d96 100644
--- a/arch/arm/boot/dts/omap443x-clocks.dtsi
+++ b/arch/arm/boot/dts/omap443x-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &prm_clocks {
-	bandgap_fclk: bandgap_fclk {
+	bandgap_fclk: bandgap_fclk@1888 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
diff --git a/arch/arm/boot/dts/omap446x-clocks.dtsi b/arch/arm/boot/dts/omap446x-clocks.dtsi
index be033e9..fb5929b 100644
--- a/arch/arm/boot/dts/omap446x-clocks.dtsi
+++ b/arch/arm/boot/dts/omap446x-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &prm_clocks {
-	div_ts_ck: div_ts_ck {
+	div_ts_ck: div_ts_ck@1888 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&l4_wkup_clk_mux_ck>;
@@ -17,7 +17,7 @@
 		ti,dividers = <8>, <16>, <32>;
 	};
 
-	bandgap_ts_fclk: bandgap_ts_fclk {
+	bandgap_ts_fclk: bandgap_ts_fclk@1888 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&div_ts_ck>;
diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index f2c48f0..9573b37 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -20,7 +20,7 @@
 		clock-frequency = <12000000>;
 	};
 
-	pad_clks_ck: pad_clks_ck {
+	pad_clks_ck: pad_clks_ck@108 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pad_clks_src_ck>;
@@ -46,7 +46,7 @@
 		clock-frequency = <12000000>;
 	};
 
-	slimbus_clk: slimbus_clk {
+	slimbus_clk: slimbus_clk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&slimbus_src_clk>;
@@ -132,21 +132,21 @@
 		clock-frequency = <60000000>;
 	};
 
-	dpll_abe_ck: dpll_abe_ck {
+	dpll_abe_ck: dpll_abe_ck@1e0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-m4xen-clock";
 		clocks = <&abe_dpll_refclk_mux_ck>, <&abe_dpll_bypass_clk_mux_ck>;
 		reg = <0x01e0>, <0x01e4>, <0x01ec>, <0x01e8>;
 	};
 
-	dpll_abe_x2_ck: dpll_abe_x2_ck {
+	dpll_abe_x2_ck: dpll_abe_x2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-x2-clock";
 		clocks = <&dpll_abe_ck>;
 		reg = <0x01f0>;
 	};
 
-	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck {
+	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -165,7 +165,7 @@
 		clock-div = <8>;
 	};
 
-	abe_clk: abe_clk {
+	abe_clk: abe_clk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2x2_ck>;
@@ -174,7 +174,7 @@
 		ti,index-power-of-two;
 	};
 
-	aess_fclk: aess_fclk {
+	aess_fclk: aess_fclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&abe_clk>;
@@ -183,7 +183,7 @@
 		reg = <0x0528>;
 	};
 
-	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck {
+	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@1f4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -194,7 +194,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	core_hsd_byp_clk_mux_ck: core_hsd_byp_clk_mux_ck {
+	core_hsd_byp_clk_mux_ck: core_hsd_byp_clk_mux_ck@12c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_abe_m3x2_ck>;
@@ -202,7 +202,7 @@
 		reg = <0x012c>;
 	};
 
-	dpll_core_ck: dpll_core_ck {
+	dpll_core_ck: dpll_core_ck@120 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-core-clock";
 		clocks = <&sys_clkin_ck>, <&core_hsd_byp_clk_mux_ck>;
@@ -215,7 +215,7 @@
 		clocks = <&dpll_core_ck>;
 	};
 
-	dpll_core_m6x2_ck: dpll_core_m6x2_ck {
+	dpll_core_m6x2_ck: dpll_core_m6x2_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -226,7 +226,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_m2_ck: dpll_core_m2_ck {
+	dpll_core_m2_ck: dpll_core_m2_ck@130 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_ck>;
@@ -245,7 +245,7 @@
 		clock-div = <2>;
 	};
 
-	dpll_core_m5x2_ck: dpll_core_m5x2_ck {
+	dpll_core_m5x2_ck: dpll_core_m5x2_ck@13c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -256,7 +256,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	div_core_ck: div_core_ck {
+	div_core_ck: div_core_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_m5x2_ck>;
@@ -264,7 +264,7 @@
 		ti,max-div = <2>;
 	};
 
-	div_iva_hs_clk: div_iva_hs_clk {
+	div_iva_hs_clk: div_iva_hs_clk@1dc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_m5x2_ck>;
@@ -273,7 +273,7 @@
 		ti,index-power-of-two;
 	};
 
-	div_mpu_hs_clk: div_mpu_hs_clk {
+	div_mpu_hs_clk: div_mpu_hs_clk@19c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_m5x2_ck>;
@@ -282,7 +282,7 @@
 		ti,index-power-of-two;
 	};
 
-	dpll_core_m4x2_ck: dpll_core_m4x2_ck {
+	dpll_core_m4x2_ck: dpll_core_m4x2_ck@138 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -301,7 +301,7 @@
 		clock-div = <2>;
 	};
 
-	dpll_abe_m2_ck: dpll_abe_m2_ck {
+	dpll_abe_m2_ck: dpll_abe_m2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_ck>;
@@ -310,7 +310,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_m3x2_gate_ck: dpll_core_m3x2_gate_ck {
+	dpll_core_m3x2_gate_ck: dpll_core_m3x2_gate_ck@134 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -318,7 +318,7 @@
 		reg = <0x0134>;
 	};
 
-	dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck {
+	dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck@134 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -333,7 +333,7 @@
 		clocks = <&dpll_core_m3x2_gate_ck>, <&dpll_core_m3x2_div_ck>;
 	};
 
-	dpll_core_m7x2_ck: dpll_core_m7x2_ck {
+	dpll_core_m7x2_ck: dpll_core_m7x2_ck@144 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -344,7 +344,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	iva_hsd_byp_clk_mux_ck: iva_hsd_byp_clk_mux_ck {
+	iva_hsd_byp_clk_mux_ck: iva_hsd_byp_clk_mux_ck@1ac {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&div_iva_hs_clk>;
@@ -352,7 +352,7 @@
 		reg = <0x01ac>;
 	};
 
-	dpll_iva_ck: dpll_iva_ck {
+	dpll_iva_ck: dpll_iva_ck@1a0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&iva_hsd_byp_clk_mux_ck>;
@@ -365,7 +365,7 @@
 		clocks = <&dpll_iva_ck>;
 	};
 
-	dpll_iva_m4x2_ck: dpll_iva_m4x2_ck {
+	dpll_iva_m4x2_ck: dpll_iva_m4x2_ck@1b8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_iva_x2_ck>;
@@ -376,7 +376,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_iva_m5x2_ck: dpll_iva_m5x2_ck {
+	dpll_iva_m5x2_ck: dpll_iva_m5x2_ck@1bc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_iva_x2_ck>;
@@ -387,14 +387,14 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_mpu_ck: dpll_mpu_ck {
+	dpll_mpu_ck: dpll_mpu_ck@160 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&div_mpu_hs_clk>;
 		reg = <0x0160>, <0x0164>, <0x016c>, <0x0168>;
 	};
 
-	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck@170 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_mpu_ck>;
@@ -421,7 +421,7 @@
 		clock-div = <3>;
 	};
 
-	l3_div_ck: l3_div_ck {
+	l3_div_ck: l3_div_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&div_core_ck>;
@@ -430,7 +430,7 @@
 		reg = <0x0100>;
 	};
 
-	l4_div_ck: l4_div_ck {
+	l4_div_ck: l4_div_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&l3_div_ck>;
@@ -455,7 +455,7 @@
 		clock-div = <2>;
 	};
 
-	ocp_abe_iclk: ocp_abe_iclk {
+	ocp_abe_iclk: ocp_abe_iclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&aess_fclk>;
@@ -472,7 +472,7 @@
 		clock-div = <4>;
 	};
 
-	dmic_sync_mux_ck: dmic_sync_mux_ck {
+	dmic_sync_mux_ck: dmic_sync_mux_ck@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
@@ -480,7 +480,7 @@
 		reg = <0x0538>;
 	};
 
-	func_dmic_abe_gfclk: func_dmic_abe_gfclk {
+	func_dmic_abe_gfclk: func_dmic_abe_gfclk@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -488,7 +488,7 @@
 		reg = <0x0538>;
 	};
 
-	mcasp_sync_mux_ck: mcasp_sync_mux_ck {
+	mcasp_sync_mux_ck: mcasp_sync_mux_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
@@ -496,7 +496,7 @@
 		reg = <0x0540>;
 	};
 
-	func_mcasp_abe_gfclk: func_mcasp_abe_gfclk {
+	func_mcasp_abe_gfclk: func_mcasp_abe_gfclk@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcasp_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -504,7 +504,7 @@
 		reg = <0x0540>;
 	};
 
-	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck {
+	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@548 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
@@ -512,7 +512,7 @@
 		reg = <0x0548>;
 	};
 
-	func_mcbsp1_gfclk: func_mcbsp1_gfclk {
+	func_mcbsp1_gfclk: func_mcbsp1_gfclk@548 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp1_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -520,7 +520,7 @@
 		reg = <0x0548>;
 	};
 
-	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck {
+	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
@@ -528,7 +528,7 @@
 		reg = <0x0550>;
 	};
 
-	func_mcbsp2_gfclk: func_mcbsp2_gfclk {
+	func_mcbsp2_gfclk: func_mcbsp2_gfclk@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp2_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -536,7 +536,7 @@
 		reg = <0x0550>;
 	};
 
-	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck {
+	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
@@ -544,7 +544,7 @@
 		reg = <0x0558>;
 	};
 
-	func_mcbsp3_gfclk: func_mcbsp3_gfclk {
+	func_mcbsp3_gfclk: func_mcbsp3_gfclk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -552,7 +552,7 @@
 		reg = <0x0558>;
 	};
 
-	slimbus1_fclk_1: slimbus1_fclk_1 {
+	slimbus1_fclk_1: slimbus1_fclk_1@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_24m_clk>;
@@ -560,7 +560,7 @@
 		reg = <0x0560>;
 	};
 
-	slimbus1_fclk_0: slimbus1_fclk_0 {
+	slimbus1_fclk_0: slimbus1_fclk_0@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&abe_24m_fclk>;
@@ -568,7 +568,7 @@
 		reg = <0x0560>;
 	};
 
-	slimbus1_fclk_2: slimbus1_fclk_2 {
+	slimbus1_fclk_2: slimbus1_fclk_2@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pad_clks_ck>;
@@ -576,7 +576,7 @@
 		reg = <0x0560>;
 	};
 
-	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
+	slimbus1_slimbus_clk: slimbus1_slimbus_clk@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&slimbus_clk>;
@@ -584,7 +584,7 @@
 		reg = <0x0560>;
 	};
 
-	timer5_sync_mux: timer5_sync_mux {
+	timer5_sync_mux: timer5_sync_mux@568 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
@@ -592,7 +592,7 @@
 		reg = <0x0568>;
 	};
 
-	timer6_sync_mux: timer6_sync_mux {
+	timer6_sync_mux: timer6_sync_mux@570 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
@@ -600,7 +600,7 @@
 		reg = <0x0570>;
 	};
 
-	timer7_sync_mux: timer7_sync_mux {
+	timer7_sync_mux: timer7_sync_mux@578 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
@@ -608,7 +608,7 @@
 		reg = <0x0578>;
 	};
 
-	timer8_sync_mux: timer8_sync_mux {
+	timer8_sync_mux: timer8_sync_mux@580 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
@@ -623,7 +623,7 @@
 	};
 };
 &prm_clocks {
-	sys_clkin_ck: sys_clkin_ck {
+	sys_clkin_ck: sys_clkin_ck@110 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
@@ -631,7 +631,7 @@
 		ti,index-starts-at-one;
 	};
 
-	abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck {
+	abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -639,7 +639,7 @@
 		reg = <0x0108>;
 	};
 
-	abe_dpll_refclk_mux_ck: abe_dpll_refclk_mux_ck {
+	abe_dpll_refclk_mux_ck: abe_dpll_refclk_mux_ck@10c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -654,14 +654,14 @@
 		clock-div = <1>;
 	};
 
-	l4_wkup_clk_mux_ck: l4_wkup_clk_mux_ck {
+	l4_wkup_clk_mux_ck: l4_wkup_clk_mux_ck@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&lp_clk_div_ck>;
 		reg = <0x0108>;
 	};
 
-	syc_clk_div_ck: syc_clk_div_ck {
+	syc_clk_div_ck: syc_clk_div_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin_ck>;
@@ -669,7 +669,7 @@
 		ti,max-div = <2>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk {
+	gpio1_dbclk: gpio1_dbclk@1838 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -677,7 +677,7 @@
 		reg = <0x1838>;
 	};
 
-	dmt1_clk_mux: dmt1_clk_mux {
+	dmt1_clk_mux: dmt1_clk_mux@1840 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -685,7 +685,7 @@
 		reg = <0x1840>;
 	};
 
-	usim_ck: usim_ck {
+	usim_ck: usim_ck@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m4x2_ck>;
@@ -694,7 +694,7 @@
 		ti,dividers = <14>, <18>;
 	};
 
-	usim_fclk: usim_fclk {
+	usim_fclk: usim_fclk@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&usim_ck>;
@@ -702,7 +702,7 @@
 		reg = <0x1858>;
 	};
 
-	pmd_stm_clock_mux_ck: pmd_stm_clock_mux_ck {
+	pmd_stm_clock_mux_ck: pmd_stm_clock_mux_ck@1a20 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
@@ -710,7 +710,7 @@
 		reg = <0x1a20>;
 	};
 
-	pmd_trace_clk_mux_ck: pmd_trace_clk_mux_ck {
+	pmd_trace_clk_mux_ck: pmd_trace_clk_mux_ck@1a20 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
@@ -718,7 +718,7 @@
 		reg = <0x1a20>;
 	};
 
-	stm_clk_div_ck: stm_clk_div_ck {
+	stm_clk_div_ck: stm_clk_div_ck@1a20 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&pmd_stm_clock_mux_ck>;
@@ -728,7 +728,7 @@
 		ti,index-power-of-two;
 	};
 
-	trace_clk_div_div_ck: trace_clk_div_div_ck {
+	trace_clk_div_div_ck: trace_clk_div_div_ck@1a20 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&pmd_trace_clk_mux_ck>;
@@ -752,7 +752,7 @@
 };
 
 &cm2_clocks {
-	per_hsd_byp_clk_mux_ck: per_hsd_byp_clk_mux_ck {
+	per_hsd_byp_clk_mux_ck: per_hsd_byp_clk_mux_ck@14c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&per_hs_clk_div_ck>;
@@ -760,14 +760,14 @@
 		reg = <0x014c>;
 	};
 
-	dpll_per_ck: dpll_per_ck {
+	dpll_per_ck: dpll_per_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&per_hsd_byp_clk_mux_ck>;
 		reg = <0x0140>, <0x0144>, <0x014c>, <0x0148>;
 	};
 
-	dpll_per_m2_ck: dpll_per_m2_ck {
+	dpll_per_m2_ck: dpll_per_m2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_ck>;
@@ -776,14 +776,14 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_x2_ck: dpll_per_x2_ck {
+	dpll_per_x2_ck: dpll_per_x2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-x2-clock";
 		clocks = <&dpll_per_ck>;
 		reg = <0x0150>;
 	};
 
-	dpll_per_m2x2_ck: dpll_per_m2x2_ck {
+	dpll_per_m2x2_ck: dpll_per_m2x2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -794,7 +794,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_m3x2_gate_ck: dpll_per_m3x2_gate_ck {
+	dpll_per_m3x2_gate_ck: dpll_per_m3x2_gate_ck@154 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -802,7 +802,7 @@
 		reg = <0x0154>;
 	};
 
-	dpll_per_m3x2_div_ck: dpll_per_m3x2_div_ck {
+	dpll_per_m3x2_div_ck: dpll_per_m3x2_div_ck@154 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -817,7 +817,7 @@
 		clocks = <&dpll_per_m3x2_gate_ck>, <&dpll_per_m3x2_div_ck>;
 	};
 
-	dpll_per_m4x2_ck: dpll_per_m4x2_ck {
+	dpll_per_m4x2_ck: dpll_per_m4x2_ck@158 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -828,7 +828,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_m5x2_ck: dpll_per_m5x2_ck {
+	dpll_per_m5x2_ck: dpll_per_m5x2_ck@15c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -839,7 +839,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_m6x2_ck: dpll_per_m6x2_ck {
+	dpll_per_m6x2_ck: dpll_per_m6x2_ck@160 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -850,7 +850,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_m7x2_ck: dpll_per_m7x2_ck {
+	dpll_per_m7x2_ck: dpll_per_m7x2_ck@164 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -861,14 +861,14 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_usb_ck: dpll_usb_ck {
+	dpll_usb_ck: dpll_usb_ck@180 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-j-type-clock";
 		clocks = <&sys_clkin_ck>, <&usb_hs_clk_div_ck>;
 		reg = <0x0180>, <0x0184>, <0x018c>, <0x0188>;
 	};
 
-	dpll_usb_clkdcoldo_ck: dpll_usb_clkdcoldo_ck {
+	dpll_usb_clkdcoldo_ck: dpll_usb_clkdcoldo_ck@1b4 {
 		#clock-cells = <0>;
 		compatible = "ti,fixed-factor-clock";
 		clocks = <&dpll_usb_ck>;
@@ -879,7 +879,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_usb_m2_ck: dpll_usb_m2_ck {
+	dpll_usb_m2_ck: dpll_usb_m2_ck@190 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_ck>;
@@ -890,7 +890,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	ducati_clk_mux_ck: ducati_clk_mux_ck {
+	ducati_clk_mux_ck: ducati_clk_mux_ck@100 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&div_core_ck>, <&dpll_per_m6x2_ck>;
@@ -921,7 +921,7 @@
 		clock-div = <8>;
 	};
 
-	func_48m_fclk: func_48m_fclk {
+	func_48m_fclk: func_48m_fclk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m2x2_ck>;
@@ -937,7 +937,7 @@
 		clock-div = <4>;
 	};
 
-	func_64m_fclk: func_64m_fclk {
+	func_64m_fclk: func_64m_fclk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m4x2_ck>;
@@ -945,7 +945,7 @@
 		ti,dividers = <2>, <4>;
 	};
 
-	func_96m_fclk: func_96m_fclk {
+	func_96m_fclk: func_96m_fclk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m2x2_ck>;
@@ -953,7 +953,7 @@
 		ti,dividers = <2>, <4>;
 	};
 
-	init_60m_fclk: init_60m_fclk {
+	init_60m_fclk: init_60m_fclk@104 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -961,7 +961,7 @@
 		ti,dividers = <1>, <8>;
 	};
 
-	per_abe_nc_fclk: per_abe_nc_fclk {
+	per_abe_nc_fclk: per_abe_nc_fclk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2_ck>;
@@ -969,7 +969,7 @@
 		ti,max-div = <2>;
 	};
 
-	aes1_fck: aes1_fck {
+	aes1_fck: aes1_fck@15a0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3_div_ck>;
@@ -977,7 +977,7 @@
 		reg = <0x15a0>;
 	};
 
-	aes2_fck: aes2_fck {
+	aes2_fck: aes2_fck@15a8 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3_div_ck>;
@@ -985,7 +985,7 @@
 		reg = <0x15a8>;
 	};
 
-	dss_sys_clk: dss_sys_clk {
+	dss_sys_clk: dss_sys_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&syc_clk_div_ck>;
@@ -993,7 +993,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_tv_clk: dss_tv_clk {
+	dss_tv_clk: dss_tv_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&extalt_clkin_ck>;
@@ -1001,7 +1001,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_dss_clk: dss_dss_clk {
+	dss_dss_clk: dss_dss_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_m5x2_ck>;
@@ -1010,7 +1010,7 @@
 		ti,set-rate-parent;
 	};
 
-	dss_48mhz_clk: dss_48mhz_clk {
+	dss_48mhz_clk: dss_48mhz_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48mc_fclk>;
@@ -1018,7 +1018,7 @@
 		reg = <0x1120>;
 	};
 
-	fdif_fck: fdif_fck {
+	fdif_fck: fdif_fck@1028 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m4x2_ck>;
@@ -1028,7 +1028,7 @@
 		ti,index-power-of-two;
 	};
 
-	gpio2_dbclk: gpio2_dbclk {
+	gpio2_dbclk: gpio2_dbclk@1460 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1036,7 +1036,7 @@
 		reg = <0x1460>;
 	};
 
-	gpio3_dbclk: gpio3_dbclk {
+	gpio3_dbclk: gpio3_dbclk@1468 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1044,7 +1044,7 @@
 		reg = <0x1468>;
 	};
 
-	gpio4_dbclk: gpio4_dbclk {
+	gpio4_dbclk: gpio4_dbclk@1470 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1052,7 +1052,7 @@
 		reg = <0x1470>;
 	};
 
-	gpio5_dbclk: gpio5_dbclk {
+	gpio5_dbclk: gpio5_dbclk@1478 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1060,7 +1060,7 @@
 		reg = <0x1478>;
 	};
 
-	gpio6_dbclk: gpio6_dbclk {
+	gpio6_dbclk: gpio6_dbclk@1480 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1068,7 +1068,7 @@
 		reg = <0x1480>;
 	};
 
-	sgx_clk_mux: sgx_clk_mux {
+	sgx_clk_mux: sgx_clk_mux@1220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_m7x2_ck>, <&dpll_per_m7x2_ck>;
@@ -1076,7 +1076,7 @@
 		reg = <0x1220>;
 	};
 
-	hsi_fck: hsi_fck {
+	hsi_fck: hsi_fck@1338 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m2x2_ck>;
@@ -1086,7 +1086,7 @@
 		ti,index-power-of-two;
 	};
 
-	iss_ctrlclk: iss_ctrlclk {
+	iss_ctrlclk: iss_ctrlclk@1020 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_96m_fclk>;
@@ -1094,7 +1094,7 @@
 		reg = <0x1020>;
 	};
 
-	mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck {
+	mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck@14e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_96m_fclk>, <&per_abe_nc_fclk>;
@@ -1102,7 +1102,7 @@
 		reg = <0x14e0>;
 	};
 
-	per_mcbsp4_gfclk: per_mcbsp4_gfclk {
+	per_mcbsp4_gfclk: per_mcbsp4_gfclk@14e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp4_sync_mux_ck>, <&pad_clks_ck>;
@@ -1110,7 +1110,7 @@
 		reg = <0x14e0>;
 	};
 
-	hsmmc1_fclk: hsmmc1_fclk {
+	hsmmc1_fclk: hsmmc1_fclk@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_64m_fclk>, <&func_96m_fclk>;
@@ -1118,7 +1118,7 @@
 		reg = <0x1328>;
 	};
 
-	hsmmc2_fclk: hsmmc2_fclk {
+	hsmmc2_fclk: hsmmc2_fclk@1330 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_64m_fclk>, <&func_96m_fclk>;
@@ -1126,7 +1126,7 @@
 		reg = <0x1330>;
 	};
 
-	ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m {
+	ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@13e0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48m_fclk>;
@@ -1134,7 +1134,7 @@
 		reg = <0x13e0>;
 	};
 
-	sha2md5_fck: sha2md5_fck {
+	sha2md5_fck: sha2md5_fck@15c8 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3_div_ck>;
@@ -1142,7 +1142,7 @@
 		reg = <0x15c8>;
 	};
 
-	slimbus2_fclk_1: slimbus2_fclk_1 {
+	slimbus2_fclk_1: slimbus2_fclk_1@1538 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_abe_24m_fclk>;
@@ -1150,7 +1150,7 @@
 		reg = <0x1538>;
 	};
 
-	slimbus2_fclk_0: slimbus2_fclk_0 {
+	slimbus2_fclk_0: slimbus2_fclk_0@1538 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_24mc_fclk>;
@@ -1158,7 +1158,7 @@
 		reg = <0x1538>;
 	};
 
-	slimbus2_slimbus_clk: slimbus2_slimbus_clk {
+	slimbus2_slimbus_clk: slimbus2_slimbus_clk@1538 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pad_slimbus_core_clks_ck>;
@@ -1166,7 +1166,7 @@
 		reg = <0x1538>;
 	};
 
-	smartreflex_core_fck: smartreflex_core_fck {
+	smartreflex_core_fck: smartreflex_core_fck@638 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_wkup_clk_mux_ck>;
@@ -1174,7 +1174,7 @@
 		reg = <0x0638>;
 	};
 
-	smartreflex_iva_fck: smartreflex_iva_fck {
+	smartreflex_iva_fck: smartreflex_iva_fck@630 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_wkup_clk_mux_ck>;
@@ -1182,7 +1182,7 @@
 		reg = <0x0630>;
 	};
 
-	smartreflex_mpu_fck: smartreflex_mpu_fck {
+	smartreflex_mpu_fck: smartreflex_mpu_fck@628 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_wkup_clk_mux_ck>;
@@ -1190,7 +1190,7 @@
 		reg = <0x0628>;
 	};
 
-	cm2_dm10_mux: cm2_dm10_mux {
+	cm2_dm10_mux: cm2_dm10_mux@1428 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1198,7 +1198,7 @@
 		reg = <0x1428>;
 	};
 
-	cm2_dm11_mux: cm2_dm11_mux {
+	cm2_dm11_mux: cm2_dm11_mux@1430 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1206,7 +1206,7 @@
 		reg = <0x1430>;
 	};
 
-	cm2_dm2_mux: cm2_dm2_mux {
+	cm2_dm2_mux: cm2_dm2_mux@1438 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1214,7 +1214,7 @@
 		reg = <0x1438>;
 	};
 
-	cm2_dm3_mux: cm2_dm3_mux {
+	cm2_dm3_mux: cm2_dm3_mux@1440 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1222,7 +1222,7 @@
 		reg = <0x1440>;
 	};
 
-	cm2_dm4_mux: cm2_dm4_mux {
+	cm2_dm4_mux: cm2_dm4_mux@1448 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1230,7 +1230,7 @@
 		reg = <0x1448>;
 	};
 
-	cm2_dm9_mux: cm2_dm9_mux {
+	cm2_dm9_mux: cm2_dm9_mux@1450 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
@@ -1238,7 +1238,7 @@
 		reg = <0x1450>;
 	};
 
-	usb_host_fs_fck: usb_host_fs_fck {
+	usb_host_fs_fck: usb_host_fs_fck@13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48mc_fclk>;
@@ -1246,7 +1246,7 @@
 		reg = <0x13d0>;
 	};
 
-	utmi_p1_gfclk: utmi_p1_gfclk {
+	utmi_p1_gfclk: utmi_p1_gfclk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&init_60m_fclk>, <&xclk60mhsp1_ck>;
@@ -1254,7 +1254,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk {
+	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&utmi_p1_gfclk>;
@@ -1262,7 +1262,7 @@
 		reg = <0x1358>;
 	};
 
-	utmi_p2_gfclk: utmi_p2_gfclk {
+	utmi_p2_gfclk: utmi_p2_gfclk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&init_60m_fclk>, <&xclk60mhsp2_ck>;
@@ -1270,7 +1270,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk {
+	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&utmi_p2_gfclk>;
@@ -1278,7 +1278,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk {
+	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1286,7 +1286,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk {
+	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -1294,7 +1294,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk {
+	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1302,7 +1302,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk {
+	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1310,7 +1310,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk {
+	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -1318,7 +1318,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_func48mclk: usb_host_hs_func48mclk {
+	usb_host_hs_func48mclk: usb_host_hs_func48mclk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48mc_fclk>;
@@ -1326,7 +1326,7 @@
 		reg = <0x1358>;
 	};
 
-	usb_host_hs_fck: usb_host_hs_fck {
+	usb_host_hs_fck: usb_host_hs_fck@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1334,7 +1334,7 @@
 		reg = <0x1358>;
 	};
 
-	otg_60m_gfclk: otg_60m_gfclk {
+	otg_60m_gfclk: otg_60m_gfclk@1360 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&utmi_phy_clkout_ck>, <&xclk60motg_ck>;
@@ -1342,7 +1342,7 @@
 		reg = <0x1360>;
 	};
 
-	usb_otg_hs_xclk: usb_otg_hs_xclk {
+	usb_otg_hs_xclk: usb_otg_hs_xclk@1360 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&otg_60m_gfclk>;
@@ -1350,7 +1350,7 @@
 		reg = <0x1360>;
 	};
 
-	usb_otg_hs_ick: usb_otg_hs_ick {
+	usb_otg_hs_ick: usb_otg_hs_ick@1360 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3_div_ck>;
@@ -1358,7 +1358,7 @@
 		reg = <0x1360>;
 	};
 
-	usb_phy_cm_clk32k: usb_phy_cm_clk32k {
+	usb_phy_cm_clk32k: usb_phy_cm_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1366,7 +1366,7 @@
 		reg = <0x0640>;
 	};
 
-	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk {
+	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@1368 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1374,7 +1374,7 @@
 		reg = <0x1368>;
 	};
 
-	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk {
+	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@1368 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1382,7 +1382,7 @@
 		reg = <0x1368>;
 	};
 
-	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk {
+	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@1368 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&init_60m_fclk>;
@@ -1390,7 +1390,7 @@
 		reg = <0x1368>;
 	};
 
-	usb_tll_hs_ick: usb_tll_hs_ick {
+	usb_tll_hs_ick: usb_tll_hs_ick@1368 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_div_ck>;
@@ -1407,7 +1407,7 @@
 };
 
 &scrm_clocks {
-	auxclk0_src_gate_ck: auxclk0_src_gate_ck {
+	auxclk0_src_gate_ck: auxclk0_src_gate_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1415,7 +1415,7 @@
 		reg = <0x0310>;
 	};
 
-	auxclk0_src_mux_ck: auxclk0_src_mux_ck {
+	auxclk0_src_mux_ck: auxclk0_src_mux_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1429,7 +1429,7 @@
 		clocks = <&auxclk0_src_gate_ck>, <&auxclk0_src_mux_ck>;
 	};
 
-	auxclk0_ck: auxclk0_ck {
+	auxclk0_ck: auxclk0_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk0_src_ck>;
@@ -1438,7 +1438,7 @@
 		reg = <0x0310>;
 	};
 
-	auxclk1_src_gate_ck: auxclk1_src_gate_ck {
+	auxclk1_src_gate_ck: auxclk1_src_gate_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1446,7 +1446,7 @@
 		reg = <0x0314>;
 	};
 
-	auxclk1_src_mux_ck: auxclk1_src_mux_ck {
+	auxclk1_src_mux_ck: auxclk1_src_mux_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1460,7 +1460,7 @@
 		clocks = <&auxclk1_src_gate_ck>, <&auxclk1_src_mux_ck>;
 	};
 
-	auxclk1_ck: auxclk1_ck {
+	auxclk1_ck: auxclk1_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk1_src_ck>;
@@ -1469,7 +1469,7 @@
 		reg = <0x0314>;
 	};
 
-	auxclk2_src_gate_ck: auxclk2_src_gate_ck {
+	auxclk2_src_gate_ck: auxclk2_src_gate_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1477,7 +1477,7 @@
 		reg = <0x0318>;
 	};
 
-	auxclk2_src_mux_ck: auxclk2_src_mux_ck {
+	auxclk2_src_mux_ck: auxclk2_src_mux_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1491,7 +1491,7 @@
 		clocks = <&auxclk2_src_gate_ck>, <&auxclk2_src_mux_ck>;
 	};
 
-	auxclk2_ck: auxclk2_ck {
+	auxclk2_ck: auxclk2_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk2_src_ck>;
@@ -1500,7 +1500,7 @@
 		reg = <0x0318>;
 	};
 
-	auxclk3_src_gate_ck: auxclk3_src_gate_ck {
+	auxclk3_src_gate_ck: auxclk3_src_gate_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1508,7 +1508,7 @@
 		reg = <0x031c>;
 	};
 
-	auxclk3_src_mux_ck: auxclk3_src_mux_ck {
+	auxclk3_src_mux_ck: auxclk3_src_mux_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1522,7 +1522,7 @@
 		clocks = <&auxclk3_src_gate_ck>, <&auxclk3_src_mux_ck>;
 	};
 
-	auxclk3_ck: auxclk3_ck {
+	auxclk3_ck: auxclk3_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk3_src_ck>;
@@ -1531,7 +1531,7 @@
 		reg = <0x031c>;
 	};
 
-	auxclk4_src_gate_ck: auxclk4_src_gate_ck {
+	auxclk4_src_gate_ck: auxclk4_src_gate_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1539,7 +1539,7 @@
 		reg = <0x0320>;
 	};
 
-	auxclk4_src_mux_ck: auxclk4_src_mux_ck {
+	auxclk4_src_mux_ck: auxclk4_src_mux_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1553,7 +1553,7 @@
 		clocks = <&auxclk4_src_gate_ck>, <&auxclk4_src_mux_ck>;
 	};
 
-	auxclk4_ck: auxclk4_ck {
+	auxclk4_ck: auxclk4_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk4_src_ck>;
@@ -1562,7 +1562,7 @@
 		reg = <0x0320>;
 	};
 
-	auxclk5_src_gate_ck: auxclk5_src_gate_ck {
+	auxclk5_src_gate_ck: auxclk5_src_gate_ck@324 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1570,7 +1570,7 @@
 		reg = <0x0324>;
 	};
 
-	auxclk5_src_mux_ck: auxclk5_src_mux_ck {
+	auxclk5_src_mux_ck: auxclk5_src_mux_ck@324 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1584,7 +1584,7 @@
 		clocks = <&auxclk5_src_gate_ck>, <&auxclk5_src_mux_ck>;
 	};
 
-	auxclk5_ck: auxclk5_ck {
+	auxclk5_ck: auxclk5_ck@324 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk5_src_ck>;
@@ -1593,7 +1593,7 @@
 		reg = <0x0324>;
 	};
 
-	auxclkreq0_ck: auxclkreq0_ck {
+	auxclkreq0_ck: auxclkreq0_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
@@ -1601,7 +1601,7 @@
 		reg = <0x0210>;
 	};
 
-	auxclkreq1_ck: auxclkreq1_ck {
+	auxclkreq1_ck: auxclkreq1_ck@214 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
@@ -1609,7 +1609,7 @@
 		reg = <0x0214>;
 	};
 
-	auxclkreq2_ck: auxclkreq2_ck {
+	auxclkreq2_ck: auxclkreq2_ck@218 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
@@ -1617,7 +1617,7 @@
 		reg = <0x0218>;
 	};
 
-	auxclkreq3_ck: auxclkreq3_ck {
+	auxclkreq3_ck: auxclkreq3_ck@21c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
@@ -1625,7 +1625,7 @@
 		reg = <0x021c>;
 	};
 
-	auxclkreq4_ck: auxclkreq4_ck {
+	auxclkreq4_ck: auxclkreq4_ck@220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
@@ -1633,7 +1633,7 @@
 		reg = <0x0220>;
 	};
 
-	auxclkreq5_ck: auxclkreq5_ck {
+	auxclkreq5_ck: auxclkreq5_ck@224 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
