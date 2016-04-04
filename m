From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 8/8] ARM: dts: omap5: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:13 +0300
Message-ID: <1459782973-21201-9-git-send-email-t-kristo@ti.com>
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
name. This patch fixes following type of warnings for OMAP5 clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi |  260 ++++++++++++++++----------------
 1 file changed, 130 insertions(+), 130 deletions(-)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 83b425f..4899c23 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -14,7 +14,7 @@
 		clock-frequency = <12000000>;
 	};
 
-	pad_clks_ck: pad_clks_ck {
+	pad_clks_ck: pad_clks_ck@108 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pad_clks_src_ck>;
@@ -34,7 +34,7 @@
 		clock-frequency = <12000000>;
 	};
 
-	slimbus_clk: slimbus_clk {
+	slimbus_clk: slimbus_clk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&slimbus_src_clk>;
@@ -102,7 +102,7 @@
 		clock-frequency = <60000000>;
 	};
 
-	dpll_abe_ck: dpll_abe_ck {
+	dpll_abe_ck: dpll_abe_ck@1e0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-m4xen-clock";
 		clocks = <&abe_dpll_clk_mux>, <&abe_dpll_bypass_clk_mux>;
@@ -115,7 +115,7 @@
 		clocks = <&dpll_abe_ck>;
 	};
 
-	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck {
+	dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@1f0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -132,7 +132,7 @@
 		clock-div = <8>;
 	};
 
-	abe_clk: abe_clk {
+	abe_clk: abe_clk@108 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_m2x2_ck>;
@@ -141,7 +141,7 @@
 		ti,index-power-of-two;
 	};
 
-	abe_iclk: abe_iclk {
+	abe_iclk: abe_iclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&aess_fclk>;
@@ -158,7 +158,7 @@
 		clock-div = <16>;
 	};
 
-	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck {
+	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@1f4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_abe_x2_ck>;
@@ -167,7 +167,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_byp_mux: dpll_core_byp_mux {
+	dpll_core_byp_mux: dpll_core_byp_mux@12c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&dpll_abe_m3x2_ck>;
@@ -175,7 +175,7 @@
 		reg = <0x012c>;
 	};
 
-	dpll_core_ck: dpll_core_ck {
+	dpll_core_ck: dpll_core_ck@120 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-core-clock";
 		clocks = <&sys_clkin>, <&dpll_core_byp_mux>;
@@ -188,7 +188,7 @@
 		clocks = <&dpll_core_ck>;
 	};
 
-	dpll_core_h21x2_ck: dpll_core_h21x2_ck {
+	dpll_core_h21x2_ck: dpll_core_h21x2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -213,7 +213,7 @@
 		clock-div = <2>;
 	};
 
-	dpll_core_h11x2_ck: dpll_core_h11x2_ck {
+	dpll_core_h11x2_ck: dpll_core_h11x2_ck@138 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -222,7 +222,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h12x2_ck: dpll_core_h12x2_ck {
+	dpll_core_h12x2_ck: dpll_core_h12x2_ck@13c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -231,7 +231,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h13x2_ck: dpll_core_h13x2_ck {
+	dpll_core_h13x2_ck: dpll_core_h13x2_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -240,7 +240,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h14x2_ck: dpll_core_h14x2_ck {
+	dpll_core_h14x2_ck: dpll_core_h14x2_ck@144 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -249,7 +249,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h22x2_ck: dpll_core_h22x2_ck {
+	dpll_core_h22x2_ck: dpll_core_h22x2_ck@154 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -258,7 +258,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h23x2_ck: dpll_core_h23x2_ck {
+	dpll_core_h23x2_ck: dpll_core_h23x2_ck@158 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -267,7 +267,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_h24x2_ck: dpll_core_h24x2_ck {
+	dpll_core_h24x2_ck: dpll_core_h24x2_ck@15c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -276,7 +276,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_m2_ck: dpll_core_m2_ck {
+	dpll_core_m2_ck: dpll_core_m2_ck@130 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_ck>;
@@ -285,7 +285,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_core_m3x2_ck: dpll_core_m3x2_ck {
+	dpll_core_m3x2_ck: dpll_core_m3x2_ck@134 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_core_x2_ck>;
@@ -302,7 +302,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_iva_byp_mux: dpll_iva_byp_mux {
+	dpll_iva_byp_mux: dpll_iva_byp_mux@1ac {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&iva_dpll_hs_clk_div>;
@@ -310,7 +310,7 @@
 		reg = <0x01ac>;
 	};
 
-	dpll_iva_ck: dpll_iva_ck {
+	dpll_iva_ck: dpll_iva_ck@1a0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin>, <&dpll_iva_byp_mux>;
@@ -323,7 +323,7 @@
 		clocks = <&dpll_iva_ck>;
 	};
 
-	dpll_iva_h11x2_ck: dpll_iva_h11x2_ck {
+	dpll_iva_h11x2_ck: dpll_iva_h11x2_ck@1b8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_iva_x2_ck>;
@@ -332,7 +332,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_iva_h12x2_ck: dpll_iva_h12x2_ck {
+	dpll_iva_h12x2_ck: dpll_iva_h12x2_ck@1bc {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_iva_x2_ck>;
@@ -349,14 +349,14 @@
 		clock-div = <1>;
 	};
 
-	dpll_mpu_ck: dpll_mpu_ck {
+	dpll_mpu_ck: dpll_mpu_ck@160 {
 		#clock-cells = <0>;
 		compatible = "ti,omap5-mpu-dpll-clock";
 		clocks = <&sys_clkin>, <&mpu_dpll_hs_clk_div>;
 		reg = <0x0160>, <0x0164>, <0x016c>, <0x0168>;
 	};
 
-	dpll_mpu_m2_ck: dpll_mpu_m2_ck {
+	dpll_mpu_m2_ck: dpll_mpu_m2_ck@170 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_mpu_ck>;
@@ -381,7 +381,7 @@
 		clock-div = <3>;
 	};
 
-	l3_iclk_div: l3_iclk_div {
+	l3_iclk_div: l3_iclk_div@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		ti,max-div = <2>;
@@ -399,7 +399,7 @@
 		clock-div = <1>;
 	};
 
-	l4_root_clk_div: l4_root_clk_div {
+	l4_root_clk_div: l4_root_clk_div@100 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		ti,max-div = <2>;
@@ -409,7 +409,7 @@
 		ti,index-power-of-two;
 	};
 
-	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
+	slimbus1_slimbus_clk: slimbus1_slimbus_clk@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&slimbus_clk>;
@@ -417,7 +417,7 @@
 		reg = <0x0560>;
 	};
 
-	aess_fclk: aess_fclk {
+	aess_fclk: aess_fclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&abe_clk>;
@@ -426,7 +426,7 @@
 		reg = <0x0528>;
 	};
 
-	dmic_sync_mux_ck: dmic_sync_mux_ck {
+	dmic_sync_mux_ck: dmic_sync_mux_ck@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
@@ -434,7 +434,7 @@
 		reg = <0x0538>;
 	};
 
-	dmic_gfclk: dmic_gfclk {
+	dmic_gfclk: dmic_gfclk@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -442,7 +442,7 @@
 		reg = <0x0538>;
 	};
 
-	mcasp_sync_mux_ck: mcasp_sync_mux_ck {
+	mcasp_sync_mux_ck: mcasp_sync_mux_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
@@ -450,7 +450,7 @@
 		reg = <0x0540>;
 	};
 
-	mcasp_gfclk: mcasp_gfclk {
+	mcasp_gfclk: mcasp_gfclk@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcasp_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -458,7 +458,7 @@
 		reg = <0x0540>;
 	};
 
-	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck {
+	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@548 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
@@ -466,7 +466,7 @@
 		reg = <0x0548>;
 	};
 
-	mcbsp1_gfclk: mcbsp1_gfclk {
+	mcbsp1_gfclk: mcbsp1_gfclk@548 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp1_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -474,7 +474,7 @@
 		reg = <0x0548>;
 	};
 
-	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck {
+	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
@@ -482,7 +482,7 @@
 		reg = <0x0550>;
 	};
 
-	mcbsp2_gfclk: mcbsp2_gfclk {
+	mcbsp2_gfclk: mcbsp2_gfclk@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp2_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -490,7 +490,7 @@
 		reg = <0x0550>;
 	};
 
-	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck {
+	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
@@ -498,7 +498,7 @@
 		reg = <0x0558>;
 	};
 
-	mcbsp3_gfclk: mcbsp3_gfclk {
+	mcbsp3_gfclk: mcbsp3_gfclk@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
@@ -506,7 +506,7 @@
 		reg = <0x0558>;
 	};
 
-	timer5_gfclk_mux: timer5_gfclk_mux {
+	timer5_gfclk_mux: timer5_gfclk_mux@568 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
@@ -514,7 +514,7 @@
 		reg = <0x0568>;
 	};
 
-	timer6_gfclk_mux: timer6_gfclk_mux {
+	timer6_gfclk_mux: timer6_gfclk_mux@570 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
@@ -522,7 +522,7 @@
 		reg = <0x0570>;
 	};
 
-	timer7_gfclk_mux: timer7_gfclk_mux {
+	timer7_gfclk_mux: timer7_gfclk_mux@578 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
@@ -530,7 +530,7 @@
 		reg = <0x0578>;
 	};
 
-	timer8_gfclk_mux: timer8_gfclk_mux {
+	timer8_gfclk_mux: timer8_gfclk_mux@580 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
@@ -545,7 +545,7 @@
 	};
 };
 &prm_clocks {
-	sys_clkin: sys_clkin {
+	sys_clkin: sys_clkin@110 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
@@ -553,14 +553,14 @@
 		ti,index-starts-at-one;
 	};
 
-	abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux {
+	abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
 		reg = <0x0108>;
 	};
 
-	abe_dpll_clk_mux: abe_dpll_clk_mux {
+	abe_dpll_clk_mux: abe_dpll_clk_mux@10c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -583,7 +583,7 @@
 		clock-div = <1>;
 	};
 
-	wkupaon_iclk_mux: wkupaon_iclk_mux {
+	wkupaon_iclk_mux: wkupaon_iclk_mux@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&abe_lp_clk_div>;
@@ -598,7 +598,7 @@
 		clock-div = <1>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk {
+	gpio1_dbclk: gpio1_dbclk@1938 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -606,7 +606,7 @@
 		reg = <0x1938>;
 	};
 
-	timer1_gfclk_mux: timer1_gfclk_mux {
+	timer1_gfclk_mux: timer1_gfclk_mux@1940 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -616,7 +616,7 @@
 };
 &cm_core_clocks {
 
-	dpll_per_byp_mux: dpll_per_byp_mux {
+	dpll_per_byp_mux: dpll_per_byp_mux@14c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&per_dpll_hs_clk_div>;
@@ -624,7 +624,7 @@
 		reg = <0x014c>;
 	};
 
-	dpll_per_ck: dpll_per_ck {
+	dpll_per_ck: dpll_per_ck@140 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin>, <&dpll_per_byp_mux>;
@@ -637,7 +637,7 @@
 		clocks = <&dpll_per_ck>;
 	};
 
-	dpll_per_h11x2_ck: dpll_per_h11x2_ck {
+	dpll_per_h11x2_ck: dpll_per_h11x2_ck@158 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -646,7 +646,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_h12x2_ck: dpll_per_h12x2_ck {
+	dpll_per_h12x2_ck: dpll_per_h12x2_ck@15c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -655,7 +655,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_h14x2_ck: dpll_per_h14x2_ck {
+	dpll_per_h14x2_ck: dpll_per_h14x2_ck@164 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -664,7 +664,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_m2_ck: dpll_per_m2_ck {
+	dpll_per_m2_ck: dpll_per_m2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_ck>;
@@ -673,7 +673,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_m2x2_ck: dpll_per_m2x2_ck {
+	dpll_per_m2x2_ck: dpll_per_m2x2_ck@150 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -682,7 +682,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_per_m3x2_ck: dpll_per_m3x2_ck {
+	dpll_per_m3x2_ck: dpll_per_m3x2_ck@154 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_x2_ck>;
@@ -691,7 +691,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_unipro1_ck: dpll_unipro1_ck {
+	dpll_unipro1_ck: dpll_unipro1_ck@200 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin>, <&sys_clkin>;
@@ -706,7 +706,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_unipro1_m2_ck: dpll_unipro1_m2_ck {
+	dpll_unipro1_m2_ck: dpll_unipro1_m2_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_unipro1_ck>;
@@ -715,7 +715,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_unipro2_ck: dpll_unipro2_ck {
+	dpll_unipro2_ck: dpll_unipro2_ck@1c0 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin>, <&sys_clkin>;
@@ -730,7 +730,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_unipro2_m2_ck: dpll_unipro2_m2_ck {
+	dpll_unipro2_m2_ck: dpll_unipro2_m2_ck@1d0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_unipro2_ck>;
@@ -739,7 +739,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll_usb_byp_mux: dpll_usb_byp_mux {
+	dpll_usb_byp_mux: dpll_usb_byp_mux@18c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&usb_dpll_hs_clk_div>;
@@ -747,7 +747,7 @@
 		reg = <0x018c>;
 	};
 
-	dpll_usb_ck: dpll_usb_ck {
+	dpll_usb_ck: dpll_usb_ck@180 {
 		#clock-cells = <0>;
 		compatible = "ti,omap4-dpll-j-type-clock";
 		clocks = <&sys_clkin>, <&dpll_usb_byp_mux>;
@@ -762,7 +762,7 @@
 		clock-div = <1>;
 	};
 
-	dpll_usb_m2_ck: dpll_usb_m2_ck {
+	dpll_usb_m2_ck: dpll_usb_m2_ck@190 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_ck>;
@@ -811,7 +811,7 @@
 		clock-div = <2>;
 	};
 
-	l3init_60m_fclk: l3init_60m_fclk {
+	l3init_60m_fclk: l3init_60m_fclk@104 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -819,7 +819,7 @@
 		ti,dividers = <1>, <8>;
 	};
 
-	dss_32khz_clk: dss_32khz_clk {
+	dss_32khz_clk: dss_32khz_clk@1420 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -827,7 +827,7 @@
 		reg = <0x1420>;
 	};
 
-	dss_48mhz_clk: dss_48mhz_clk {
+	dss_48mhz_clk: dss_48mhz_clk@1420 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_48m_fclk>;
@@ -835,7 +835,7 @@
 		reg = <0x1420>;
 	};
 
-	dss_dss_clk: dss_dss_clk {
+	dss_dss_clk: dss_dss_clk@1420 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_per_h12x2_ck>;
@@ -844,7 +844,7 @@
 		ti,set-rate-parent;
 	};
 
-	dss_sys_clk: dss_sys_clk {
+	dss_sys_clk: dss_sys_clk@1420 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dss_syc_gfclk_div>;
@@ -852,7 +852,7 @@
 		reg = <0x1420>;
 	};
 
-	gpio2_dbclk: gpio2_dbclk {
+	gpio2_dbclk: gpio2_dbclk@1060 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -860,7 +860,7 @@
 		reg = <0x1060>;
 	};
 
-	gpio3_dbclk: gpio3_dbclk {
+	gpio3_dbclk: gpio3_dbclk@1068 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -868,7 +868,7 @@
 		reg = <0x1068>;
 	};
 
-	gpio4_dbclk: gpio4_dbclk {
+	gpio4_dbclk: gpio4_dbclk@1070 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -876,7 +876,7 @@
 		reg = <0x1070>;
 	};
 
-	gpio5_dbclk: gpio5_dbclk {
+	gpio5_dbclk: gpio5_dbclk@1078 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -884,7 +884,7 @@
 		reg = <0x1078>;
 	};
 
-	gpio6_dbclk: gpio6_dbclk {
+	gpio6_dbclk: gpio6_dbclk@1080 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -892,7 +892,7 @@
 		reg = <0x1080>;
 	};
 
-	gpio7_dbclk: gpio7_dbclk {
+	gpio7_dbclk: gpio7_dbclk@1110 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -900,7 +900,7 @@
 		reg = <0x1110>;
 	};
 
-	gpio8_dbclk: gpio8_dbclk {
+	gpio8_dbclk: gpio8_dbclk@1118 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -908,7 +908,7 @@
 		reg = <0x1118>;
 	};
 
-	iss_ctrlclk: iss_ctrlclk {
+	iss_ctrlclk: iss_ctrlclk@1320 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&func_96m_fclk>;
@@ -916,7 +916,7 @@
 		reg = <0x1320>;
 	};
 
-	lli_txphy_clk: lli_txphy_clk {
+	lli_txphy_clk: lli_txphy_clk@f20 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_unipro1_clkdcoldo>;
@@ -924,7 +924,7 @@
 		reg = <0x0f20>;
 	};
 
-	lli_txphy_ls_clk: lli_txphy_ls_clk {
+	lli_txphy_ls_clk: lli_txphy_ls_clk@f20 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_unipro1_m2_ck>;
@@ -932,7 +932,7 @@
 		reg = <0x0f20>;
 	};
 
-	mmc1_32khz_clk: mmc1_32khz_clk {
+	mmc1_32khz_clk: mmc1_32khz_clk@1628 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -940,7 +940,7 @@
 		reg = <0x1628>;
 	};
 
-	sata_ref_clk: sata_ref_clk {
+	sata_ref_clk: sata_ref_clk@1688 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_clkin>;
@@ -948,7 +948,7 @@
 		reg = <0x1688>;
 	};
 
-	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk {
+	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -956,7 +956,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk {
+	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -964,7 +964,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_hsic480m_p3_clk: usb_host_hs_hsic480m_p3_clk {
+	usb_host_hs_hsic480m_p3_clk: usb_host_hs_hsic480m_p3_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_m2_ck>;
@@ -972,7 +972,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk {
+	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -980,7 +980,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk {
+	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -988,7 +988,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_hsic60m_p3_clk: usb_host_hs_hsic60m_p3_clk {
+	usb_host_hs_hsic60m_p3_clk: usb_host_hs_hsic60m_p3_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -996,7 +996,7 @@
 		reg = <0x1658>;
 	};
 
-	utmi_p1_gfclk: utmi_p1_gfclk {
+	utmi_p1_gfclk: utmi_p1_gfclk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3init_60m_fclk>, <&xclk60mhsp1_ck>;
@@ -1004,7 +1004,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk {
+	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&utmi_p1_gfclk>;
@@ -1012,7 +1012,7 @@
 		reg = <0x1658>;
 	};
 
-	utmi_p2_gfclk: utmi_p2_gfclk {
+	utmi_p2_gfclk: utmi_p2_gfclk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&l3init_60m_fclk>, <&xclk60mhsp2_ck>;
@@ -1020,7 +1020,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk {
+	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&utmi_p2_gfclk>;
@@ -1028,7 +1028,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk {
+	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -1036,7 +1036,7 @@
 		reg = <0x1658>;
 	};
 
-	usb_otg_ss_refclk960m: usb_otg_ss_refclk960m {
+	usb_otg_ss_refclk960m: usb_otg_ss_refclk960m@16f0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll_usb_clkdcoldo>;
@@ -1044,7 +1044,7 @@
 		reg = <0x16f0>;
 	};
 
-	usb_phy_cm_clk32k: usb_phy_cm_clk32k {
+	usb_phy_cm_clk32k: usb_phy_cm_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1052,7 +1052,7 @@
 		reg = <0x0640>;
 	};
 
-	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk {
+	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@1668 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -1060,7 +1060,7 @@
 		reg = <0x1668>;
 	};
 
-	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk {
+	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@1668 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -1068,7 +1068,7 @@
 		reg = <0x1668>;
 	};
 
-	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk {
+	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@1668 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&l3init_60m_fclk>;
@@ -1076,7 +1076,7 @@
 		reg = <0x1668>;
 	};
 
-	fdif_fclk: fdif_fclk {
+	fdif_fclk: fdif_fclk@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_h11x2_ck>;
@@ -1085,7 +1085,7 @@
 		reg = <0x1328>;
 	};
 
-	gpu_core_gclk_mux: gpu_core_gclk_mux {
+	gpu_core_gclk_mux: gpu_core_gclk_mux@1520 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>;
@@ -1093,7 +1093,7 @@
 		reg = <0x1520>;
 	};
 
-	gpu_hyd_gclk_mux: gpu_hyd_gclk_mux {
+	gpu_hyd_gclk_mux: gpu_hyd_gclk_mux@1520 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>;
@@ -1101,7 +1101,7 @@
 		reg = <0x1520>;
 	};
 
-	hsi_fclk: hsi_fclk {
+	hsi_fclk: hsi_fclk@1638 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll_per_m2x2_ck>;
@@ -1110,7 +1110,7 @@
 		reg = <0x1638>;
 	};
 
-	mmc1_fclk_mux: mmc1_fclk_mux {
+	mmc1_fclk_mux: mmc1_fclk_mux@1628 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
@@ -1118,7 +1118,7 @@
 		reg = <0x1628>;
 	};
 
-	mmc1_fclk: mmc1_fclk {
+	mmc1_fclk: mmc1_fclk@1628 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc1_fclk_mux>;
@@ -1127,7 +1127,7 @@
 		reg = <0x1628>;
 	};
 
-	mmc2_fclk_mux: mmc2_fclk_mux {
+	mmc2_fclk_mux: mmc2_fclk_mux@1630 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
@@ -1135,7 +1135,7 @@
 		reg = <0x1630>;
 	};
 
-	mmc2_fclk: mmc2_fclk {
+	mmc2_fclk: mmc2_fclk@1630 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mmc2_fclk_mux>;
@@ -1144,7 +1144,7 @@
 		reg = <0x1630>;
 	};
 
-	timer10_gfclk_mux: timer10_gfclk_mux {
+	timer10_gfclk_mux: timer10_gfclk_mux@1028 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1152,7 +1152,7 @@
 		reg = <0x1028>;
 	};
 
-	timer11_gfclk_mux: timer11_gfclk_mux {
+	timer11_gfclk_mux: timer11_gfclk_mux@1030 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1160,7 +1160,7 @@
 		reg = <0x1030>;
 	};
 
-	timer2_gfclk_mux: timer2_gfclk_mux {
+	timer2_gfclk_mux: timer2_gfclk_mux@1038 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1168,7 +1168,7 @@
 		reg = <0x1038>;
 	};
 
-	timer3_gfclk_mux: timer3_gfclk_mux {
+	timer3_gfclk_mux: timer3_gfclk_mux@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1176,7 +1176,7 @@
 		reg = <0x1040>;
 	};
 
-	timer4_gfclk_mux: timer4_gfclk_mux {
+	timer4_gfclk_mux: timer4_gfclk_mux@1048 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1184,7 +1184,7 @@
 		reg = <0x1048>;
 	};
 
-	timer9_gfclk_mux: timer9_gfclk_mux {
+	timer9_gfclk_mux: timer9_gfclk_mux@1050 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
@@ -1201,7 +1201,7 @@
 };
 
 &scrm_clocks {
-	auxclk0_src_gate_ck: auxclk0_src_gate_ck {
+	auxclk0_src_gate_ck: auxclk0_src_gate_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1209,7 +1209,7 @@
 		reg = <0x0310>;
 	};
 
-	auxclk0_src_mux_ck: auxclk0_src_mux_ck {
+	auxclk0_src_mux_ck: auxclk0_src_mux_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1223,7 +1223,7 @@
 		clocks = <&auxclk0_src_gate_ck>, <&auxclk0_src_mux_ck>;
 	};
 
-	auxclk0_ck: auxclk0_ck {
+	auxclk0_ck: auxclk0_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk0_src_ck>;
@@ -1232,7 +1232,7 @@
 		reg = <0x0310>;
 	};
 
-	auxclk1_src_gate_ck: auxclk1_src_gate_ck {
+	auxclk1_src_gate_ck: auxclk1_src_gate_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1240,7 +1240,7 @@
 		reg = <0x0314>;
 	};
 
-	auxclk1_src_mux_ck: auxclk1_src_mux_ck {
+	auxclk1_src_mux_ck: auxclk1_src_mux_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1254,7 +1254,7 @@
 		clocks = <&auxclk1_src_gate_ck>, <&auxclk1_src_mux_ck>;
 	};
 
-	auxclk1_ck: auxclk1_ck {
+	auxclk1_ck: auxclk1_ck@314 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk1_src_ck>;
@@ -1263,7 +1263,7 @@
 		reg = <0x0314>;
 	};
 
-	auxclk2_src_gate_ck: auxclk2_src_gate_ck {
+	auxclk2_src_gate_ck: auxclk2_src_gate_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1271,7 +1271,7 @@
 		reg = <0x0318>;
 	};
 
-	auxclk2_src_mux_ck: auxclk2_src_mux_ck {
+	auxclk2_src_mux_ck: auxclk2_src_mux_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1285,7 +1285,7 @@
 		clocks = <&auxclk2_src_gate_ck>, <&auxclk2_src_mux_ck>;
 	};
 
-	auxclk2_ck: auxclk2_ck {
+	auxclk2_ck: auxclk2_ck@318 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk2_src_ck>;
@@ -1294,7 +1294,7 @@
 		reg = <0x0318>;
 	};
 
-	auxclk3_src_gate_ck: auxclk3_src_gate_ck {
+	auxclk3_src_gate_ck: auxclk3_src_gate_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1302,7 +1302,7 @@
 		reg = <0x031c>;
 	};
 
-	auxclk3_src_mux_ck: auxclk3_src_mux_ck {
+	auxclk3_src_mux_ck: auxclk3_src_mux_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1316,7 +1316,7 @@
 		clocks = <&auxclk3_src_gate_ck>, <&auxclk3_src_mux_ck>;
 	};
 
-	auxclk3_ck: auxclk3_ck {
+	auxclk3_ck: auxclk3_ck@31c {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk3_src_ck>;
@@ -1325,7 +1325,7 @@
 		reg = <0x031c>;
 	};
 
-	auxclk4_src_gate_ck: auxclk4_src_gate_ck {
+	auxclk4_src_gate_ck: auxclk4_src_gate_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&dpll_core_m3x2_ck>;
@@ -1333,7 +1333,7 @@
 		reg = <0x0320>;
 	};
 
-	auxclk4_src_mux_ck: auxclk4_src_mux_ck {
+	auxclk4_src_mux_ck: auxclk4_src_mux_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
@@ -1347,7 +1347,7 @@
 		clocks = <&auxclk4_src_gate_ck>, <&auxclk4_src_mux_ck>;
 	};
 
-	auxclk4_ck: auxclk4_ck {
+	auxclk4_ck: auxclk4_ck@320 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&auxclk4_src_ck>;
@@ -1356,7 +1356,7 @@
 		reg = <0x0320>;
 	};
 
-	auxclkreq0_ck: auxclkreq0_ck {
+	auxclkreq0_ck: auxclkreq0_ck@210 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
@@ -1364,7 +1364,7 @@
 		reg = <0x0210>;
 	};
 
-	auxclkreq1_ck: auxclkreq1_ck {
+	auxclkreq1_ck: auxclkreq1_ck@214 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
@@ -1372,7 +1372,7 @@
 		reg = <0x0214>;
 	};
 
-	auxclkreq2_ck: auxclkreq2_ck {
+	auxclkreq2_ck: auxclkreq2_ck@218 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
@@ -1380,7 +1380,7 @@
 		reg = <0x0218>;
 	};
 
-	auxclkreq3_ck: auxclkreq3_ck {
+	auxclkreq3_ck: auxclkreq3_ck@21c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
