From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/8] ARM: dts: dra7: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:12 +0300
Message-ID: <1459782973-21201-8-git-send-email-t-kristo@ti.com>
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
name. This patch fixes following type of warnings for DRA7 clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |  376 +++++++++++++++++-----------------
 1 file changed, 188 insertions(+), 188 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d0bae06..c437c5c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -188,7 +188,7 @@
 		clock-frequency = <0>;
 	};
 
-	dpll_abe_ck: dpll_abe_ck {
+	dpll_abe_ck: dpll_abe_ck@1e0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-m4xen-clock";
 		clocks = <&abe_dpll_clk_mux>, <&abe_dpll_bypass_clk_mux>;
@@ -201,7 +201,7 @@
 		clocks = <&dpll_abe_ck>;
 	};
 
-	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck {
+	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -212,7 +212,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	abe_clk: abe_clk {
+	abe_clk: abe_clk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2x2_ck>;
@@ -221,7 +221,7 @@
 		ti,index-power-of-two;
 	};
 
-	dpll_abe_m2_ck: dpll_abe_m2_ck {
+	dpll_abe_m2_ck: dpll_abe_m2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_ck>;
@@ -232,7 +232,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck {
+	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@1f4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -243,7 +243,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_byp_mux: dpll_core_byp_mux {
+	dpll_core_byp_mux: dpll_core_byp_mux@12c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
@@ -251,7 +251,7 @@
 		reg = <0x012c>;
 	};
 
-	dpll_core_ck: dpll_core_ck {
+	dpll_core_ck: dpll_core_ck@120 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-core-clock";
 		clocks = <&sys_clkin1>, <&dpll_core_byp_mux>;
@@ -264,7 +264,7 @@
 		clocks = <&dpll_core_ck>;
 	};
 
-	dpll_core_h12x2_ck: dpll_core_h12x2_ck {
+	dpll_core_h12x2_ck: dpll_core_h12x2_ck@13c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -283,14 +283,14 @@
 		clock-div = <1>;
 	};
 
-	dpll_mpu_ck: dpll_mpu_ck {
+	dpll_mpu_ck: dpll_mpu_ck@160 {
 		#clock-cells = <0>;
 		compatible = "ti,omap5-mpu-dpll-clock";
 		clocks = <&sys_clkin1>, <&mpu_dpll_hs_clk_div>;
 		reg = <0x0160>, <0x0164>, <0x016c>, <0x0168>;
 	};
 
-	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck@170 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_mpu_ck>;
@@ -317,7 +317,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_dsp_byp_mux: dpll_dsp_byp_mux {
+	dpll_dsp_byp_mux: dpll_dsp_byp_mux@240 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&dsp_dpll_hs_clk_div>;
@@ -325,14 +325,14 @@
 		reg = <0x0240>;
 	};
 
-	dpll_dsp_ck: dpll_dsp_ck {
+	dpll_dsp_ck: dpll_dsp_ck@234 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_dsp_byp_mux>;
 		reg = <0x0234>, <0x0238>, <0x0240>, <0x023c>;
 	};
 
-	dpll_dsp_m2_ck: dpll_dsp_m2_ck {
+	dpll_dsp_m2_ck: dpll_dsp_m2_ck@244 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_dsp_ck>;
@@ -351,7 +351,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_iva_byp_mux: dpll_iva_byp_mux {
+	dpll_iva_byp_mux: dpll_iva_byp_mux@1ac {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&iva_dpll_hs_clk_div>;
@@ -359,14 +359,14 @@
 		reg = <0x01ac>;
 	};
 
-	dpll_iva_ck: dpll_iva_ck {
+	dpll_iva_ck: dpll_iva_ck@1a0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_iva_byp_mux>;
 		reg = <0x01a0>, <0x01a4>, <0x01ac>, <0x01a8>;
 	};
 
-	dpll_iva_m2_ck: dpll_iva_m2_ck {
+	dpll_iva_m2_ck: dpll_iva_m2_ck@1b0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_iva_ck>;
@@ -385,7 +385,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_gpu_byp_mux: dpll_gpu_byp_mux {
+	dpll_gpu_byp_mux: dpll_gpu_byp_mux@2e4 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
@@ -393,14 +393,14 @@
 		reg = <0x02e4>;
 	};
 
-	dpll_gpu_ck: dpll_gpu_ck {
+	dpll_gpu_ck: dpll_gpu_ck@2d8 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_gpu_byp_mux>;
 		reg = <0x02d8>, <0x02dc>, <0x02e4>, <0x02e0>;
 	};
 
-	dpll_gpu_m2_ck: dpll_gpu_m2_ck {
+	dpll_gpu_m2_ck: dpll_gpu_m2_ck@2e8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gpu_ck>;
@@ -411,7 +411,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_m2_ck: dpll_core_m2_ck {
+	dpll_core_m2_ck: dpll_core_m2_ck@130 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_ck>;
@@ -430,7 +430,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_ddr_byp_mux: dpll_ddr_byp_mux {
+	dpll_ddr_byp_mux: dpll_ddr_byp_mux@21c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
@@ -438,14 +438,14 @@
 		reg = <0x021c>;
 	};
 
-	dpll_ddr_ck: dpll_ddr_ck {
+	dpll_ddr_ck: dpll_ddr_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_ddr_byp_mux>;
 		reg = <0x0210>, <0x0214>, <0x021c>, <0x0218>;
 	};
 
-	dpll_ddr_m2_ck: dpll_ddr_m2_ck {
+	dpll_ddr_m2_ck: dpll_ddr_m2_ck@220 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_ck>;
@@ -456,7 +456,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_gmac_byp_mux: dpll_gmac_byp_mux {
+	dpll_gmac_byp_mux: dpll_gmac_byp_mux@2b4 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
@@ -464,14 +464,14 @@
 		reg = <0x02b4>;
 	};
 
-	dpll_gmac_ck: dpll_gmac_ck {
+	dpll_gmac_ck: dpll_gmac_ck@2a8 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_gmac_byp_mux>;
 		reg = <0x02a8>, <0x02ac>, <0x02b4>, <0x02b0>;
 	};
 
-	dpll_gmac_m2_ck: dpll_gmac_m2_ck {
+	dpll_gmac_m2_ck: dpll_gmac_m2_ck@2b8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_ck>;
@@ -530,7 +530,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_eve_byp_mux: dpll_eve_byp_mux {
+	dpll_eve_byp_mux: dpll_eve_byp_mux@290 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&eve_dpll_hs_clk_div>;
@@ -538,14 +538,14 @@
 		reg = <0x0290>;
 	};
 
-	dpll_eve_ck: dpll_eve_ck {
+	dpll_eve_ck: dpll_eve_ck@284 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_eve_byp_mux>;
 		reg = <0x0284>, <0x0288>, <0x0290>, <0x028c>;
 	};
 
-	dpll_eve_m2_ck: dpll_eve_m2_ck {
+	dpll_eve_m2_ck: dpll_eve_m2_ck@294 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_eve_ck>;
@@ -564,7 +564,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_core_h13x2_ck: dpll_core_h13x2_ck {
+	dpll_core_h13x2_ck: dpll_core_h13x2_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -575,7 +575,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_h14x2_ck: dpll_core_h14x2_ck {
+	dpll_core_h14x2_ck: dpll_core_h14x2_ck@144 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -586,7 +586,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_h22x2_ck: dpll_core_h22x2_ck {
+	dpll_core_h22x2_ck: dpll_core_h22x2_ck@154 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -597,7 +597,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_h23x2_ck: dpll_core_h23x2_ck {
+	dpll_core_h23x2_ck: dpll_core_h23x2_ck@158 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -608,7 +608,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_core_h24x2_ck: dpll_core_h24x2_ck {
+	dpll_core_h24x2_ck: dpll_core_h24x2_ck@15c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -625,7 +625,7 @@
 		clocks = <&dpll_ddr_ck>;
 	};
 
-	dpll_ddr_h11x2_ck: dpll_ddr_h11x2_ck {
+	dpll_ddr_h11x2_ck: dpll_ddr_h11x2_ck@228 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_x2_ck>;
@@ -642,7 +642,7 @@
 		clocks = <&dpll_dsp_ck>;
 	};
 
-	dpll_dsp_m3x2_ck: dpll_dsp_m3x2_ck {
+	dpll_dsp_m3x2_ck: dpll_dsp_m3x2_ck@248 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_dsp_x2_ck>;
@@ -659,7 +659,7 @@
 		clocks = <&dpll_gmac_ck>;
 	};
 
-	dpll_gmac_h11x2_ck: dpll_gmac_h11x2_ck {
+	dpll_gmac_h11x2_ck: dpll_gmac_h11x2_ck@2c0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_x2_ck>;
@@ -670,7 +670,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_gmac_h12x2_ck: dpll_gmac_h12x2_ck {
+	dpll_gmac_h12x2_ck: dpll_gmac_h12x2_ck@2c4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_x2_ck>;
@@ -681,7 +681,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_gmac_h13x2_ck: dpll_gmac_h13x2_ck {
+	dpll_gmac_h13x2_ck: dpll_gmac_h13x2_ck@2c8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_x2_ck>;
@@ -692,7 +692,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_gmac_m3x2_ck: dpll_gmac_m3x2_ck {
+	dpll_gmac_m3x2_ck: dpll_gmac_m3x2_ck@2bc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_x2_ck>;
@@ -727,7 +727,7 @@
 		clock-div = <1>;
 	};
 
-	l3_iclk_div: l3_iclk_div {
+	l3_iclk_div: l3_iclk_div@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		ti,max-div = <2>;
@@ -777,7 +777,7 @@
 		clock-div = <1>;
 	};
 
-	ipu1_gfclk_mux: ipu1_gfclk_mux {
+	ipu1_gfclk_mux: ipu1_gfclk_mux@520 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_abe_m2x2_ck>, <&dpll_core_h22x2_ck>;
@@ -785,7 +785,7 @@
 		reg = <0x0520>;
 	};
 
-	mcasp1_ahclkr_mux: mcasp1_ahclkr_mux {
+	mcasp1_ahclkr_mux: mcasp1_ahclkr_mux@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -793,7 +793,7 @@
 		reg = <0x0550>;
 	};
 
-	mcasp1_ahclkx_mux: mcasp1_ahclkx_mux {
+	mcasp1_ahclkx_mux: mcasp1_ahclkx_mux@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -801,7 +801,7 @@
 		reg = <0x0550>;
 	};
 
-	mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux {
+	mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -809,7 +809,7 @@
 		reg = <0x0550>;
 	};
 
-	timer5_gfclk_mux: timer5_gfclk_mux {
+	timer5_gfclk_mux: timer5_gfclk_mux@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
@@ -817,7 +817,7 @@
 		reg = <0x0558>;
 	};
 
-	timer6_gfclk_mux: timer6_gfclk_mux {
+	timer6_gfclk_mux: timer6_gfclk_mux@560 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
@@ -825,7 +825,7 @@
 		reg = <0x0560>;
 	};
 
-	timer7_gfclk_mux: timer7_gfclk_mux {
+	timer7_gfclk_mux: timer7_gfclk_mux@568 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
@@ -833,7 +833,7 @@
 		reg = <0x0568>;
 	};
 
-	timer8_gfclk_mux: timer8_gfclk_mux {
+	timer8_gfclk_mux: timer8_gfclk_mux@570 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
@@ -841,7 +841,7 @@
 		reg = <0x0570>;
 	};
 
-	uart6_gfclk_mux: uart6_gfclk_mux {
+	uart6_gfclk_mux: uart6_gfclk_mux@580 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -856,7 +856,7 @@
 	};
 };
 &prm_clocks {
-	sys_clkin1: sys_clkin1 {
+	sys_clkin1: sys_clkin1@110 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_12000000_ck>, <&virt_20000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
@@ -864,28 +864,28 @@
 		ti,index-starts-at-one;
 	};
 
-	abe_dpll_sys_clk_mux: abe_dpll_sys_clk_mux {
+	abe_dpll_sys_clk_mux: abe_dpll_sys_clk_mux@118 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
 		reg = <0x0118>;
 	};
 
-	abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux {
+	abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux@114 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_dpll_sys_clk_mux>, <&sys_32k_ck>;
 		reg = <0x0114>;
 	};
 
-	abe_dpll_clk_mux: abe_dpll_clk_mux {
+	abe_dpll_clk_mux: abe_dpll_clk_mux@10c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_dpll_sys_clk_mux>, <&sys_32k_ck>;
 		reg = <0x010c>;
 	};
 
-	abe_24m_fclk: abe_24m_fclk {
+	abe_24m_fclk: abe_24m_fclk@11c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2x2_ck>;
@@ -893,7 +893,7 @@
 		ti,dividers = <8>, <16>;
 	};
 
-	aess_fclk: aess_fclk {
+	aess_fclk: aess_fclk@178 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&abe_clk>;
@@ -901,7 +901,7 @@
 		ti,max-div = <2>;
 	};
 
-	abe_giclk_div: abe_giclk_div {
+	abe_giclk_div: abe_giclk_div@174 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&aess_fclk>;
@@ -909,7 +909,7 @@
 		ti,max-div = <2>;
 	};
 
-	abe_lp_clk_div: abe_lp_clk_div {
+	abe_lp_clk_div: abe_lp_clk_div@1d8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2x2_ck>;
@@ -917,7 +917,7 @@
 		ti,dividers = <16>, <32>;
 	};
 
-	abe_sys_clk_div: abe_sys_clk_div {
+	abe_sys_clk_div: abe_sys_clk_div@120 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin1>;
@@ -925,14 +925,14 @@
 		ti,max-div = <2>;
 	};
 
-	adc_gfclk_mux: adc_gfclk_mux {
+	adc_gfclk_mux: adc_gfclk_mux@1dc {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>, <&sys_32k_ck>;
 		reg = <0x01dc>;
 	};
 
-	sys_clk1_dclk_div: sys_clk1_dclk_div {
+	sys_clk1_dclk_div: sys_clk1_dclk_div@1c8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin1>;
@@ -941,7 +941,7 @@
 		ti,index-power-of-two;
 	};
 
-	sys_clk2_dclk_div: sys_clk2_dclk_div {
+	sys_clk2_dclk_div: sys_clk2_dclk_div@1cc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin2>;
@@ -950,7 +950,7 @@
 		ti,index-power-of-two;
 	};
 
-	per_abe_x1_dclk_div: per_abe_x1_dclk_div {
+	per_abe_x1_dclk_div: per_abe_x1_dclk_div@1bc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2_ck>;
@@ -959,7 +959,7 @@
 		ti,index-power-of-two;
 	};
 
-	dsp_gclk_div: dsp_gclk_div {
+	dsp_gclk_div: dsp_gclk_div@18c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_dsp_m2_ck>;
@@ -968,7 +968,7 @@
 		ti,index-power-of-two;
 	};
 
-	gpu_dclk: gpu_dclk {
+	gpu_dclk: gpu_dclk@1a0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gpu_m2_ck>;
@@ -977,7 +977,7 @@
 		ti,index-power-of-two;
 	};
 
-	emif_phy_dclk_div: emif_phy_dclk_div {
+	emif_phy_dclk_div: emif_phy_dclk_div@190 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_ddr_m2_ck>;
@@ -986,7 +986,7 @@
 		ti,index-power-of-two;
 	};
 
-	gmac_250m_dclk_div: gmac_250m_dclk_div {
+	gmac_250m_dclk_div: gmac_250m_dclk_div@19c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_m2_ck>;
@@ -995,7 +995,7 @@
 		ti,index-power-of-two;
 	};
 
-	l3init_480m_dclk_div: l3init_480m_dclk_div {
+	l3init_480m_dclk_div: l3init_480m_dclk_div@1ac {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -1004,7 +1004,7 @@
 		ti,index-power-of-two;
 	};
 
-	usb_otg_dclk_div: usb_otg_dclk_div {
+	usb_otg_dclk_div: usb_otg_dclk_div@184 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&usb_otg_clkin_ck>;
@@ -1013,7 +1013,7 @@
 		ti,index-power-of-two;
 	};
 
-	sata_dclk_div: sata_dclk_div {
+	sata_dclk_div: sata_dclk_div@1c0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin1>;
@@ -1022,7 +1022,7 @@
 		ti,index-power-of-two;
 	};
 
-	pcie2_dclk_div: pcie2_dclk_div {
+	pcie2_dclk_div: pcie2_dclk_div@1b8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_pcie_ref_m2_ck>;
@@ -1031,7 +1031,7 @@
 		ti,index-power-of-two;
 	};
 
-	pcie_dclk_div: pcie_dclk_div {
+	pcie_dclk_div: pcie_dclk_div@1b4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&apll_pcie_m2_ck>;
@@ -1040,7 +1040,7 @@
 		ti,index-power-of-two;
 	};
 
-	emu_dclk_div: emu_dclk_div {
+	emu_dclk_div: emu_dclk_div@194 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin1>;
@@ -1049,7 +1049,7 @@
 		ti,index-power-of-two;
 	};
 
-	secure_32k_dclk_div: secure_32k_dclk_div {
+	secure_32k_dclk_div: secure_32k_dclk_div@1c4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&secure_32k_clk_src_ck>;
@@ -1058,21 +1058,21 @@
 		ti,index-power-of-two;
 	};
 
-	clkoutmux0_clk_mux: clkoutmux0_clk_mux {
+	clkoutmux0_clk_mux: clkoutmux0_clk_mux@158 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
 		reg = <0x0158>;
 	};
 
-	clkoutmux1_clk_mux: clkoutmux1_clk_mux {
+	clkoutmux1_clk_mux: clkoutmux1_clk_mux@15c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
 		reg = <0x015c>;
 	};
 
-	clkoutmux2_clk_mux: clkoutmux2_clk_mux {
+	clkoutmux2_clk_mux: clkoutmux2_clk_mux@160 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
@@ -1087,21 +1087,21 @@
 		clock-div = <2>;
 	};
 
-	eve_clk: eve_clk {
+	eve_clk: eve_clk@180 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_eve_m2_ck>, <&dpll_dsp_m3x2_ck>;
 		reg = <0x0180>;
 	};
 
-	hdmi_dpll_clk_mux: hdmi_dpll_clk_mux {
+	hdmi_dpll_clk_mux: hdmi_dpll_clk_mux@164 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
 		reg = <0x0164>;
 	};
 
-	mlb_clk: mlb_clk {
+	mlb_clk: mlb_clk@134 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mlb_clkin_ck>;
@@ -1110,7 +1110,7 @@
 		ti,index-power-of-two;
 	};
 
-	mlbp_clk: mlbp_clk {
+	mlbp_clk: mlbp_clk@130 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mlbp_clkin_ck>;
@@ -1119,7 +1119,7 @@
 		ti,index-power-of-two;
 	};
 
-	per_abe_x1_gfclk2_div: per_abe_x1_gfclk2_div {
+	per_abe_x1_gfclk2_div: per_abe_x1_gfclk2_div@138 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2_ck>;
@@ -1128,7 +1128,7 @@
 		ti,index-power-of-two;
 	};
 
-	timer_sys_clk_div: timer_sys_clk_div {
+	timer_sys_clk_div: timer_sys_clk_div@144 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sys_clkin1>;
@@ -1136,28 +1136,28 @@
 		ti,max-div = <2>;
 	};
 
-	video1_dpll_clk_mux: video1_dpll_clk_mux {
+	video1_dpll_clk_mux: video1_dpll_clk_mux@168 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
 		reg = <0x0168>;
 	};
 
-	video2_dpll_clk_mux: video2_dpll_clk_mux {
+	video2_dpll_clk_mux: video2_dpll_clk_mux@16c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
 		reg = <0x016c>;
 	};
 
-	wkupaon_iclk_mux: wkupaon_iclk_mux {
+	wkupaon_iclk_mux: wkupaon_iclk_mux@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&abe_lp_clk_div>;
 		reg = <0x0108>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk {
+	gpio1_dbclk: gpio1_dbclk@1838 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1165,7 +1165,7 @@
 		reg = <0x1838>;
 	};
 
-	dcan1_sys_clk_mux: dcan1_sys_clk_mux {
+	dcan1_sys_clk_mux: dcan1_sys_clk_mux@1888 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin2>;
@@ -1173,7 +1173,7 @@
 		reg = <0x1888>;
 	};
 
-	timer1_gfclk_mux: timer1_gfclk_mux {
+	timer1_gfclk_mux: timer1_gfclk_mux@1840 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -1181,7 +1181,7 @@
 		reg = <0x1840>;
 	};
 
-	uart10_gfclk_mux: uart10_gfclk_mux {
+	uart10_gfclk_mux: uart10_gfclk_mux@1880 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -1190,14 +1190,14 @@
 	};
 };
 &cm_core_clocks {
-	dpll_pcie_ref_ck: dpll_pcie_ref_ck {
+	dpll_pcie_ref_ck: dpll_pcie_ref_ck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&sys_clkin1>;
 		reg = <0x0200>, <0x0204>, <0x020c>, <0x0208>;
 	};
 
-	dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck {
+	dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_pcie_ref_ck>;
@@ -1216,7 +1216,7 @@
 		ti,bit-shift = <7>;
 	};
 
-	apll_pcie_ck: apll_pcie_ck {
+	apll_pcie_ck: apll_pcie_ck@21c {
 		#clock-cells = <0>;
 		compatible = "ti,dra7-apll-clock";
 		clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
@@ -1305,7 +1305,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_per_byp_mux: dpll_per_byp_mux {
+	dpll_per_byp_mux: dpll_per_byp_mux@14c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&per_dpll_hs_clk_div>;
@@ -1313,14 +1313,14 @@
 		reg = <0x014c>;
 	};
 
-	dpll_per_ck: dpll_per_ck {
+	dpll_per_ck: dpll_per_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_per_byp_mux>;
 		reg = <0x0140>, <0x0144>, <0x014c>, <0x0148>;
 	};
 
-	dpll_per_m2_ck: dpll_per_m2_ck {
+	dpll_per_m2_ck: dpll_per_m2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_ck>;
@@ -1339,7 +1339,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_usb_byp_mux: dpll_usb_byp_mux {
+	dpll_usb_byp_mux: dpll_usb_byp_mux@18c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin1>, <&usb_dpll_hs_clk_div>;
@@ -1347,14 +1347,14 @@
 		reg = <0x018c>;
 	};
 
-	dpll_usb_ck: dpll_usb_ck {
+	dpll_usb_ck: dpll_usb_ck@180 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-j-type-clock";
 		clocks = <&sys_clkin1>, <&dpll_usb_byp_mux>;
 		reg = <0x0180>, <0x0184>, <0x018c>, <0x0188>;
 	};
 
-	dpll_usb_m2_ck: dpll_usb_m2_ck {
+	dpll_usb_m2_ck: dpll_usb_m2_ck@190 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_ck>;
@@ -1365,7 +1365,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_pcie_ref_m2_ck: dpll_pcie_ref_m2_ck {
+	dpll_pcie_ref_m2_ck: dpll_pcie_ref_m2_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_pcie_ref_ck>;
@@ -1382,7 +1382,7 @@
 		clocks = <&dpll_per_ck>;
 	};
 
-	dpll_per_h11x2_ck: dpll_per_h11x2_ck {
+	dpll_per_h11x2_ck: dpll_per_h11x2_ck@158 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -1393,7 +1393,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_h12x2_ck: dpll_per_h12x2_ck {
+	dpll_per_h12x2_ck: dpll_per_h12x2_ck@15c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -1404,7 +1404,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_h13x2_ck: dpll_per_h13x2_ck {
+	dpll_per_h13x2_ck: dpll_per_h13x2_ck@160 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -1415,7 +1415,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_h14x2_ck: dpll_per_h14x2_ck {
+	dpll_per_h14x2_ck: dpll_per_h14x2_ck@164 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -1426,7 +1426,7 @@
 		ti,invert-autoidle-bit;
 	};
 
-	dpll_per_m2x2_ck: dpll_per_m2x2_ck {
+	dpll_per_m2x2_ck: dpll_per_m2x2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -1485,7 +1485,7 @@
 		clock-div = <2>;
 	};
 
-	l3init_60m_fclk: l3init_60m_fclk {
+	l3init_60m_fclk: l3init_60m_fclk@104 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -1493,7 +1493,7 @@
 		ti,dividers = <1>, <8>;
 	};
 
-	clkout2_clk: clkout2_clk {
+	clkout2_clk: clkout2_clk@6b0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&clkoutmux2_clk_mux>;
@@ -1501,7 +1501,7 @@
 		reg = <0x06b0>;
 	};
 
-	l3init_960m_gfclk: l3init_960m_gfclk {
+	l3init_960m_gfclk: l3init_960m_gfclk@6c0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_clkdcoldo>;
@@ -1509,7 +1509,7 @@
 		reg = <0x06c0>;
 	};
 
-	dss_32khz_clk: dss_32khz_clk {
+	dss_32khz_clk: dss_32khz_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1517,7 +1517,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_48mhz_clk: dss_48mhz_clk {
+	dss_48mhz_clk: dss_48mhz_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48m_fclk>;
@@ -1525,7 +1525,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_dss_clk: dss_dss_clk {
+	dss_dss_clk: dss_dss_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_h12x2_ck>;
@@ -1534,7 +1534,7 @@
 		ti,set-rate-parent;
 	};
 
-	dss_hdmi_clk: dss_hdmi_clk {
+	dss_hdmi_clk: dss_hdmi_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&hdmi_dpll_clk_mux>;
@@ -1542,7 +1542,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_video1_clk: dss_video1_clk {
+	dss_video1_clk: dss_video1_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&video1_dpll_clk_mux>;
@@ -1550,7 +1550,7 @@
 		reg = <0x1120>;
 	};
 
-	dss_video2_clk: dss_video2_clk {
+	dss_video2_clk: dss_video2_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&video2_dpll_clk_mux>;
@@ -1558,7 +1558,7 @@
 		reg = <0x1120>;
 	};
 
-	gpio2_dbclk: gpio2_dbclk {
+	gpio2_dbclk: gpio2_dbclk@1760 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1566,7 +1566,7 @@
 		reg = <0x1760>;
 	};
 
-	gpio3_dbclk: gpio3_dbclk {
+	gpio3_dbclk: gpio3_dbclk@1768 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1574,7 +1574,7 @@
 		reg = <0x1768>;
 	};
 
-	gpio4_dbclk: gpio4_dbclk {
+	gpio4_dbclk: gpio4_dbclk@1770 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1582,7 +1582,7 @@
 		reg = <0x1770>;
 	};
 
-	gpio5_dbclk: gpio5_dbclk {
+	gpio5_dbclk: gpio5_dbclk@1778 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1590,7 +1590,7 @@
 		reg = <0x1778>;
 	};
 
-	gpio6_dbclk: gpio6_dbclk {
+	gpio6_dbclk: gpio6_dbclk@1780 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1598,7 +1598,7 @@
 		reg = <0x1780>;
 	};
 
-	gpio7_dbclk: gpio7_dbclk {
+	gpio7_dbclk: gpio7_dbclk@1810 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1606,7 +1606,7 @@
 		reg = <0x1810>;
 	};
 
-	gpio8_dbclk: gpio8_dbclk {
+	gpio8_dbclk: gpio8_dbclk@1818 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1614,7 +1614,7 @@
 		reg = <0x1818>;
 	};
 
-	mmc1_clk32k: mmc1_clk32k {
+	mmc1_clk32k: mmc1_clk32k@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1622,7 +1622,7 @@
 		reg = <0x1328>;
 	};
 
-	mmc2_clk32k: mmc2_clk32k {
+	mmc2_clk32k: mmc2_clk32k@1330 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1630,7 +1630,7 @@
 		reg = <0x1330>;
 	};
 
-	mmc3_clk32k: mmc3_clk32k {
+	mmc3_clk32k: mmc3_clk32k@1820 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1638,7 +1638,7 @@
 		reg = <0x1820>;
 	};
 
-	mmc4_clk32k: mmc4_clk32k {
+	mmc4_clk32k: mmc4_clk32k@1828 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1646,7 +1646,7 @@
 		reg = <0x1828>;
 	};
 
-	sata_ref_clk: sata_ref_clk {
+	sata_ref_clk: sata_ref_clk@1388 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_clkin1>;
@@ -1654,7 +1654,7 @@
 		reg = <0x1388>;
 	};
 
-	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
+	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@13f0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_960m_gfclk>;
@@ -1662,7 +1662,7 @@
 		reg = <0x13f0>;
 	};
 
-	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m {
+	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m@1340 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_960m_gfclk>;
@@ -1670,7 +1670,7 @@
 		reg = <0x1340>;
 	};
 
-	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k {
+	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1678,7 +1678,7 @@
 		reg = <0x0640>;
 	};
 
-	usb_phy2_always_on_clk32k: usb_phy2_always_on_clk32k {
+	usb_phy2_always_on_clk32k: usb_phy2_always_on_clk32k@688 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1686,7 +1686,7 @@
 		reg = <0x0688>;
 	};
 
-	usb_phy3_always_on_clk32k: usb_phy3_always_on_clk32k {
+	usb_phy3_always_on_clk32k: usb_phy3_always_on_clk32k@698 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1694,7 +1694,7 @@
 		reg = <0x0698>;
 	};
 
-	atl_dpll_clk_mux: atl_dpll_clk_mux {
+	atl_dpll_clk_mux: atl_dpll_clk_mux@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_32k_ck>, <&video1_clkin_ck>, <&video2_clkin_ck>, <&hdmi_clkin_ck>;
@@ -1702,7 +1702,7 @@
 		reg = <0x0c00>;
 	};
 
-	atl_gfclk_mux: atl_gfclk_mux {
+	atl_gfclk_mux: atl_gfclk_mux@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3_iclk_div>, <&dpll_abe_m2_ck>, <&atl_dpll_clk_mux>;
@@ -1710,7 +1710,7 @@
 		reg = <0x0c00>;
 	};
 
-	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div {
+	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div@13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_gmac_m2_ck>;
@@ -1719,7 +1719,7 @@
 		ti,dividers = <2>;
 	};
 
-	gmac_rft_clk_mux: gmac_rft_clk_mux {
+	gmac_rft_clk_mux: gmac_rft_clk_mux@13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&video1_clkin_ck>, <&video2_clkin_ck>, <&dpll_abe_m2_ck>, <&hdmi_clkin_ck>, <&l3_iclk_div>;
@@ -1727,7 +1727,7 @@
 		reg = <0x13d0>;
 	};
 
-	gpu_core_gclk_mux: gpu_core_gclk_mux {
+	gpu_core_gclk_mux: gpu_core_gclk_mux@1220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
@@ -1735,7 +1735,7 @@
 		reg = <0x1220>;
 	};
 
-	gpu_hyd_gclk_mux: gpu_hyd_gclk_mux {
+	gpu_hyd_gclk_mux: gpu_hyd_gclk_mux@1220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
@@ -1743,7 +1743,7 @@
 		reg = <0x1220>;
 	};
 
-	l3instr_ts_gclk_div: l3instr_ts_gclk_div {
+	l3instr_ts_gclk_div: l3instr_ts_gclk_div@e50 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&wkupaon_iclk_mux>;
@@ -1752,7 +1752,7 @@
 		ti,dividers = <8>, <16>, <32>;
 	};
 
-	mcasp2_ahclkr_mux: mcasp2_ahclkr_mux {
+	mcasp2_ahclkr_mux: mcasp2_ahclkr_mux@1860 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1760,7 +1760,7 @@
 		reg = <0x1860>;
 	};
 
-	mcasp2_ahclkx_mux: mcasp2_ahclkx_mux {
+	mcasp2_ahclkx_mux: mcasp2_ahclkx_mux@1860 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1768,7 +1768,7 @@
 		reg = <0x1860>;
 	};
 
-	mcasp2_aux_gfclk_mux: mcasp2_aux_gfclk_mux {
+	mcasp2_aux_gfclk_mux: mcasp2_aux_gfclk_mux@1860 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1776,7 +1776,7 @@
 		reg = <0x1860>;
 	};
 
-	mcasp3_ahclkx_mux: mcasp3_ahclkx_mux {
+	mcasp3_ahclkx_mux: mcasp3_ahclkx_mux@1868 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1784,7 +1784,7 @@
 		reg = <0x1868>;
 	};
 
-	mcasp3_aux_gfclk_mux: mcasp3_aux_gfclk_mux {
+	mcasp3_aux_gfclk_mux: mcasp3_aux_gfclk_mux@1868 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1792,7 +1792,7 @@
 		reg = <0x1868>;
 	};
 
-	mcasp4_ahclkx_mux: mcasp4_ahclkx_mux {
+	mcasp4_ahclkx_mux: mcasp4_ahclkx_mux@1898 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1800,7 +1800,7 @@
 		reg = <0x1898>;
 	};
 
-	mcasp4_aux_gfclk_mux: mcasp4_aux_gfclk_mux {
+	mcasp4_aux_gfclk_mux: mcasp4_aux_gfclk_mux@1898 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1808,7 +1808,7 @@
 		reg = <0x1898>;
 	};
 
-	mcasp5_ahclkx_mux: mcasp5_ahclkx_mux {
+	mcasp5_ahclkx_mux: mcasp5_ahclkx_mux@1878 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1816,7 +1816,7 @@
 		reg = <0x1878>;
 	};
 
-	mcasp5_aux_gfclk_mux: mcasp5_aux_gfclk_mux {
+	mcasp5_aux_gfclk_mux: mcasp5_aux_gfclk_mux@1878 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1824,7 +1824,7 @@
 		reg = <0x1878>;
 	};
 
-	mcasp6_ahclkx_mux: mcasp6_ahclkx_mux {
+	mcasp6_ahclkx_mux: mcasp6_ahclkx_mux@1904 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1832,7 +1832,7 @@
 		reg = <0x1904>;
 	};
 
-	mcasp6_aux_gfclk_mux: mcasp6_aux_gfclk_mux {
+	mcasp6_aux_gfclk_mux: mcasp6_aux_gfclk_mux@1904 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1840,7 +1840,7 @@
 		reg = <0x1904>;
 	};
 
-	mcasp7_ahclkx_mux: mcasp7_ahclkx_mux {
+	mcasp7_ahclkx_mux: mcasp7_ahclkx_mux@1908 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1848,7 +1848,7 @@
 		reg = <0x1908>;
 	};
 
-	mcasp7_aux_gfclk_mux: mcasp7_aux_gfclk_mux {
+	mcasp7_aux_gfclk_mux: mcasp7_aux_gfclk_mux@1908 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1856,7 +1856,7 @@
 		reg = <0x1908>;
 	};
 
-	mcasp8_ahclk_mux: mcasp8_ahclk_mux {
+	mcasp8_ahclk_mux: mcasp8_ahclk_mux@1890 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
@@ -1864,7 +1864,7 @@
 		reg = <0x1890>;
 	};
 
-	mcasp8_aux_gfclk_mux: mcasp8_aux_gfclk_mux {
+	mcasp8_aux_gfclk_mux: mcasp8_aux_gfclk_mux@1890 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
@@ -1872,7 +1872,7 @@
 		reg = <0x1890>;
 	};
 
-	mmc1_fclk_mux: mmc1_fclk_mux {
+	mmc1_fclk_mux: mmc1_fclk_mux@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
@@ -1880,7 +1880,7 @@
 		reg = <0x1328>;
 	};
 
-	mmc1_fclk_div: mmc1_fclk_div {
+	mmc1_fclk_div: mmc1_fclk_div@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc1_fclk_mux>;
@@ -1890,7 +1890,7 @@
 		ti,index-power-of-two;
 	};
 
-	mmc2_fclk_mux: mmc2_fclk_mux {
+	mmc2_fclk_mux: mmc2_fclk_mux@1330 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
@@ -1898,7 +1898,7 @@
 		reg = <0x1330>;
 	};
 
-	mmc2_fclk_div: mmc2_fclk_div {
+	mmc2_fclk_div: mmc2_fclk_div@1330 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc2_fclk_mux>;
@@ -1908,7 +1908,7 @@
 		ti,index-power-of-two;
 	};
 
-	mmc3_gfclk_mux: mmc3_gfclk_mux {
+	mmc3_gfclk_mux: mmc3_gfclk_mux@1820 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -1916,7 +1916,7 @@
 		reg = <0x1820>;
 	};
 
-	mmc3_gfclk_div: mmc3_gfclk_div {
+	mmc3_gfclk_div: mmc3_gfclk_div@1820 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc3_gfclk_mux>;
@@ -1926,7 +1926,7 @@
 		ti,index-power-of-two;
 	};
 
-	mmc4_gfclk_mux: mmc4_gfclk_mux {
+	mmc4_gfclk_mux: mmc4_gfclk_mux@1828 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -1934,7 +1934,7 @@
 		reg = <0x1828>;
 	};
 
-	mmc4_gfclk_div: mmc4_gfclk_div {
+	mmc4_gfclk_div: mmc4_gfclk_div@1828 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc4_gfclk_mux>;
@@ -1944,7 +1944,7 @@
 		ti,index-power-of-two;
 	};
 
-	qspi_gfclk_mux: qspi_gfclk_mux {
+	qspi_gfclk_mux: qspi_gfclk_mux@1838 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_128m_clk>, <&dpll_per_h13x2_ck>;
@@ -1952,7 +1952,7 @@
 		reg = <0x1838>;
 	};
 
-	qspi_gfclk_div: qspi_gfclk_div {
+	qspi_gfclk_div: qspi_gfclk_div@1838 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&qspi_gfclk_mux>;
@@ -1962,7 +1962,7 @@
 		ti,index-power-of-two;
 	};
 
-	timer10_gfclk_mux: timer10_gfclk_mux {
+	timer10_gfclk_mux: timer10_gfclk_mux@1728 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -1970,7 +1970,7 @@
 		reg = <0x1728>;
 	};
 
-	timer11_gfclk_mux: timer11_gfclk_mux {
+	timer11_gfclk_mux: timer11_gfclk_mux@1730 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -1978,7 +1978,7 @@
 		reg = <0x1730>;
 	};
 
-	timer13_gfclk_mux: timer13_gfclk_mux {
+	timer13_gfclk_mux: timer13_gfclk_mux@17c8 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -1986,7 +1986,7 @@
 		reg = <0x17c8>;
 	};
 
-	timer14_gfclk_mux: timer14_gfclk_mux {
+	timer14_gfclk_mux: timer14_gfclk_mux@17d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -1994,7 +1994,7 @@
 		reg = <0x17d0>;
 	};
 
-	timer15_gfclk_mux: timer15_gfclk_mux {
+	timer15_gfclk_mux: timer15_gfclk_mux@17d8 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2002,7 +2002,7 @@
 		reg = <0x17d8>;
 	};
 
-	timer16_gfclk_mux: timer16_gfclk_mux {
+	timer16_gfclk_mux: timer16_gfclk_mux@1830 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2010,7 +2010,7 @@
 		reg = <0x1830>;
 	};
 
-	timer2_gfclk_mux: timer2_gfclk_mux {
+	timer2_gfclk_mux: timer2_gfclk_mux@1738 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2018,7 +2018,7 @@
 		reg = <0x1738>;
 	};
 
-	timer3_gfclk_mux: timer3_gfclk_mux {
+	timer3_gfclk_mux: timer3_gfclk_mux@1740 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2026,7 +2026,7 @@
 		reg = <0x1740>;
 	};
 
-	timer4_gfclk_mux: timer4_gfclk_mux {
+	timer4_gfclk_mux: timer4_gfclk_mux@1748 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2034,7 +2034,7 @@
 		reg = <0x1748>;
 	};
 
-	timer9_gfclk_mux: timer9_gfclk_mux {
+	timer9_gfclk_mux: timer9_gfclk_mux@1750 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
@@ -2042,7 +2042,7 @@
 		reg = <0x1750>;
 	};
 
-	uart1_gfclk_mux: uart1_gfclk_mux {
+	uart1_gfclk_mux: uart1_gfclk_mux@1840 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2050,7 +2050,7 @@
 		reg = <0x1840>;
 	};
 
-	uart2_gfclk_mux: uart2_gfclk_mux {
+	uart2_gfclk_mux: uart2_gfclk_mux@1848 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2058,7 +2058,7 @@
 		reg = <0x1848>;
 	};
 
-	uart3_gfclk_mux: uart3_gfclk_mux {
+	uart3_gfclk_mux: uart3_gfclk_mux@1850 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2066,7 +2066,7 @@
 		reg = <0x1850>;
 	};
 
-	uart4_gfclk_mux: uart4_gfclk_mux {
+	uart4_gfclk_mux: uart4_gfclk_mux@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2074,7 +2074,7 @@
 		reg = <0x1858>;
 	};
 
-	uart5_gfclk_mux: uart5_gfclk_mux {
+	uart5_gfclk_mux: uart5_gfclk_mux@1870 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2082,7 +2082,7 @@
 		reg = <0x1870>;
 	};
 
-	uart7_gfclk_mux: uart7_gfclk_mux {
+	uart7_gfclk_mux: uart7_gfclk_mux@18d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2090,7 +2090,7 @@
 		reg = <0x18d0>;
 	};
 
-	uart8_gfclk_mux: uart8_gfclk_mux {
+	uart8_gfclk_mux: uart8_gfclk_mux@18e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2098,7 +2098,7 @@
 		reg = <0x18e0>;
 	};
 
-	uart9_gfclk_mux: uart9_gfclk_mux {
+	uart9_gfclk_mux: uart9_gfclk_mux@18e8 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
@@ -2106,7 +2106,7 @@
 		reg = <0x18e8>;
 	};
 
-	vip1_gclk_mux: vip1_gclk_mux {
+	vip1_gclk_mux: vip1_gclk_mux@1020 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
@@ -2114,7 +2114,7 @@
 		reg = <0x1020>;
 	};
 
-	vip2_gclk_mux: vip2_gclk_mux {
+	vip2_gclk_mux: vip2_gclk_mux@1028 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
@@ -2122,7 +2122,7 @@
 		reg = <0x1028>;
 	};
 
-	vip3_gclk_mux: vip3_gclk_mux {
+	vip3_gclk_mux: vip3_gclk_mux@1030 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
@@ -2139,7 +2139,7 @@
 };
 
 &scm_conf_clocks {
-	dss_deshdcp_clk: dss_deshdcp_clk {
+	dss_deshdcp_clk: dss_deshdcp_clk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3_iclk_div>;
@@ -2147,7 +2147,7 @@
 		reg = <0x558>;
 	};
 
-       ehrpwm0_tbclk: ehrpwm0_tbclk {
+       ehrpwm0_tbclk: ehrpwm0_tbclk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_root_clk_div>;
@@ -2155,7 +2155,7 @@
 		reg = <0x0558>;
 	};
 
-	ehrpwm1_tbclk: ehrpwm1_tbclk {
+	ehrpwm1_tbclk: ehrpwm1_tbclk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_root_clk_div>;
@@ -2163,7 +2163,7 @@
 		reg = <0x0558>;
 	};
 
-	ehrpwm2_tbclk: ehrpwm2_tbclk {
+	ehrpwm2_tbclk: ehrpwm2_tbclk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l4_root_clk_div>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
