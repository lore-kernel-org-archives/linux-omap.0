From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 29/30] ARM: dts: dra7: add hwmod module clocks
Date: Mon, 11 Apr 2016 11:19:20 +0300
Message-ID: <1460362761-4842-30-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add clock nodes for the SoC hwmods. This is done in preparation to remove
hwmod data from kernel, hwmod will use the clock nodes instead for
module level enable / disable logic.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |  986 ++++++++++++++++++++++++++++++----
 1 file changed, 885 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index c437c5c..fb7d00d 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -411,6 +411,13 @@
 		ti,invert-autoidle-bit;
 	};
 
+	mpu_mod_ck: mpu_mod_ck@320 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0320>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
 	dpll_core_m2_ck: dpll_core_m2_ck@130 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -801,44 +808,67 @@
 		reg = <0x0550>;
 	};
 
-	mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux@550 {
+	timer5_mod_ck: timer5_mod_ck@558 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x0550>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0558>, <0x0558>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>,
+			 <&clkoutmux0_clk_mux>;
+		ti,bit-shift = <24>;
 	};
 
-	timer5_gfclk_mux: timer5_gfclk_mux@558 {
+	timer6_mod_ck: timer6_mod_ck@560 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0560>, <0x0560>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>,
+			 <&clkoutmux0_clk_mux>;
 		ti,bit-shift = <24>;
-		reg = <0x0558>;
 	};
 
-	timer6_gfclk_mux: timer6_gfclk_mux@560 {
+	timer7_mod_ck: timer7_mod_ck@568 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0568>, <0x0568>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>,
+			 <&clkoutmux0_clk_mux>;
 		ti,bit-shift = <24>;
-		reg = <0x0560>;
 	};
 
-	timer7_gfclk_mux: timer7_gfclk_mux@568 {
+	timer8_mod_ck: timer8_mod_ck@570 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0570>, <0x0570>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>,
+			 <&clkoutmux0_clk_mux>;
 		ti,bit-shift = <24>;
-		reg = <0x0568>;
 	};
 
-	timer8_gfclk_mux: timer8_gfclk_mux@570 {
+	i2c5_mod_ck: i2c5_mod_ck@578 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0578>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
-		ti,bit-shift = <24>;
-		reg = <0x0570>;
+		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0550>;
 	};
 
 	uart6_gfclk_mux: uart6_gfclk_mux@580 {
@@ -849,6 +879,20 @@
 		reg = <0x0580>;
 	};
 
+	uart6_mod_ck: uart6_mod_ck@580 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0580>;
+		clocks = <&uart6_gfclk_mux>;
+	};
+
+	rtcss_mod_ck: rtcss_mod_ck@744 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0744>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	dummy_ck: dummy_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -932,6 +976,20 @@
 		reg = <0x01dc>;
 	};
 
+	l4_wkup_mod_ck: l4_wkup_mod_ck@1820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1820>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck@1830 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1830>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	sys_clk1_dclk_div: sys_clk1_dclk_div@1c8 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1165,6 +1223,31 @@
 		reg = <0x1838>;
 	};
 
+	gpio1_mod_ck: gpio1_mod_ck@1838 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1838>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	timer1_mod_ck: timer1_mod_ck@1840 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1840>, <0x1840>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	counter_32k_mod_ck: counter_32k_mod_ck@1850 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1850>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
 	dcan1_sys_clk_mux: dcan1_sys_clk_mux@1888 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1173,12 +1256,11 @@
 		reg = <0x1888>;
 	};
 
-	timer1_gfclk_mux: timer1_gfclk_mux@1840 {
+	dcan1_mod_ck: dcan1_mod_ck@1888 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1840>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1888>;
+		clocks = <&dcan1_sys_clk_mux>;
 	};
 
 	uart10_gfclk_mux: uart10_gfclk_mux@1880 {
@@ -1188,6 +1270,13 @@
 		ti,bit-shift = <24>;
 		reg = <0x1880>;
 	};
+
+	uart10_mod_ck: uart10_mod_ck@1880 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1880>;
+		clocks = <&uart10_gfclk_mux>;
+	};
 };
 &cm_core_clocks {
 	dpll_pcie_ref_ck: dpll_pcie_ref_ck@200 {
@@ -1223,6 +1312,20 @@
 		reg = <0x021c>, <0x0220>;
 	};
 
+	smartreflex_mpu_mod_ck: smartreflex_mpu_mod_ck@628 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0628>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	smartreflex_core_mod_ck: smartreflex_core_mod_ck@638 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0638>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
 	optfclk_pciephy1_32khz: optfclk_pciephy1_32khz@4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1231,6 +1334,13 @@
 		ti,bit-shift = <8>;
 	};
 
+	pcie1_mod_ck: pcie1_mod_ck@13b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x13b0>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	optfclk_pciephy2_32khz: optfclk_pciephy2_32khz@4a0093b8 {
 		compatible = "ti,gate-clock";
 		clocks = <&sys_32k_ck>;
@@ -1265,6 +1375,13 @@
 		ti,bit-shift = <9>;
 	};
 
+	pcie2_mod_ck: pcie2_mod_ck@13b8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x13b8>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	optfclk_pciephy1_div_clk: optfclk_pciephy1_div_clk@4a0093b0 {
 		compatible = "ti,gate-clock";
 		clocks = <&optfclk_pciephy_div>;
@@ -1509,6 +1626,69 @@
 		reg = <0x06c0>;
 	};
 
+	l3_main_1_mod_ck: l3_main_1_mod_ck@720 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0720>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	gpmc_mod_ck: gpmc_mod_ck@728 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0728>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	tpcc_mod_ck: tpcc_mod_ck@770 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0770>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	tptc0_mod_ck: tptc0_mod_ck@778 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0778>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	tptc1_mod_ck: tptc1_mod_ck@780 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0780>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	vcp1_mod_ck: vcp1_mod_ck@788 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0788>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	vcp2_mod_ck: vcp2_mod_ck@790 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0790>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	dma_system_mod_ck: dma_system_mod_ck@a20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0a20>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	dmm_mod_ck: dmm_mod_ck@b20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0b20>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	dss_32khz_clk: dss_32khz_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1542,6 +1722,34 @@
 		reg = <0x1120>;
 	};
 
+	dss_dispc_mod_ck: dss_dispc_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_core_mod_ck: dss_core_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_hdmi_mod_ck: dss_hdmi_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_48mhz_clk>;
+	};
+
+	bb2d_mod_ck: bb2d_mod_ck@1130 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1130>;
+		clocks = <&dpll_core_h24x2_ck>;
+	};
+
 	dss_video1_clk: dss_video1_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1566,6 +1774,13 @@
 		reg = <0x1760>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck@1760 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1760>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk@1768 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1574,6 +1789,13 @@
 		reg = <0x1768>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck@1768 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1768>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gpio4_dbclk: gpio4_dbclk@1770 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1582,6 +1804,13 @@
 		reg = <0x1770>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck@1770 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1770>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gpio5_dbclk: gpio5_dbclk@1778 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1590,6 +1819,13 @@
 		reg = <0x1778>;
 	};
 
+	gpio5_mod_ck: gpio5_mod_ck@1778 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1778>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gpio6_dbclk: gpio6_dbclk@1780 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1598,6 +1834,116 @@
 		reg = <0x1780>;
 	};
 
+	gpio6_mod_ck: gpio6_mod_ck@1780 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1780>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	hdq1w_mod_ck: hdq1w_mod_ck@1788 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1788>;
+		clocks = <&func_12m_fclk>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck@17a0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17a0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck@17a8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17a8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck@17b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17b0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c4_mod_ck: i2c4_mod_ck@17b8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17b8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	l4_per1_mod_ck: l4_per1_mod_ck@17c0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x17c0>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	timer13_mod_ck: timer13_mod_ck@17c8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x17c8>, <0x17c8>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer14_mod_ck: timer14_mod_ck@17d0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x17d0>, <0x17d0>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer15_mod_ck: timer15_mod_ck@17d8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x17d8>, <0x17d8>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	mcspi1_mod_ck: mcspi1_mod_ck@17f0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17f0>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi2_mod_ck: mcspi2_mod_ck@17f8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x17f8>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi3_mod_ck: mcspi3_mod_ck@1800 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1800>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi4_mod_ck: mcspi4_mod_ck@1808 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1808>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	gpio7_dbclk: gpio7_dbclk@1810 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1606,6 +1952,13 @@
 		reg = <0x1810>;
 	};
 
+	gpio7_mod_ck: gpio7_mod_ck@1810 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1810>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gpio8_dbclk: gpio8_dbclk@1818 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1614,6 +1967,13 @@
 		reg = <0x1818>;
 	};
 
+	gpio8_mod_ck: gpio8_mod_ck@1818 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1818>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	mmc1_clk32k: mmc1_clk32k@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1646,6 +2006,24 @@
 		reg = <0x1828>;
 	};
 
+	mmc4_mod_ck: mmc4_mod_ck@1828 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1828>;
+		clocks = <&mmc4_gfclk_div>;
+	};
+
+	timer16_mod_ck: timer16_mod_ck@1830 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1830>, <0x1830>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
 	sata_ref_clk: sata_ref_clk@1388 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1654,6 +2032,13 @@
 		reg = <0x1388>;
 	};
 
+	sata_mod_ck: sata_mod_ck@1388 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1388>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@13f0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1662,6 +2047,100 @@
 		reg = <0x13f0>;
 	};
 
+	usb_otg_ss1_mod_ck: usb_otg_ss1_mod_ck@13f0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x13f0>;
+		clocks = <&dpll_core_h13x2_ck>;
+	};
+
+	l4_per2_mod_ck: l4_per2_mod_ck@170c {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x170c>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	l4_per3_mod_ck: l4_per3_mod_ck@1714 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1714>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	timer10_mod_ck: timer10_mod_ck@1728 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1728>, <0x1728>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer11_mod_ck: timer11_mod_ck@1730 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1730>, <0x1730>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck@1738 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1738>, <0x1738>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck@1740 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1740>, <0x1740>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck@1748 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1748>, <0x1748>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	timer9_mod_ck: timer9_mod_ck@1750 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1750>, <0x1750>;
+		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>,
+			 <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>,
+			 <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>,
+			 <&video2_div_clk>, <&hdmi_div_clk>;
+		ti,bit-shift = <24>;
+	};
+
+	elm_mod_ck: elm_mod_ck@1758 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1758>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m@1340 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1670,6 +2149,27 @@
 		reg = <0x1340>;
 	};
 
+	usb_otg_ss2_mod_ck: usb_otg_ss2_mod_ck@1340 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1340>;
+		clocks = <&dpll_core_h13x2_ck>;
+	};
+
+	usb_otg_ss3_mod_ck: usb_otg_ss3_mod_ck@1348 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1348>;
+		clocks = <&dpll_core_h13x2_ck>;
+	};
+
+	usb_otg_ss4_mod_ck: usb_otg_ss4_mod_ck@1350 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1350>;
+		clocks = <&dpll_core_h13x2_ck>;
+	};
+
 	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1710,6 +2210,132 @@
 		reg = <0x0c00>;
 	};
 
+	atl_mod_ck: atl_mod_ck@c00 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0c00>;
+		clocks = <&atl_gfclk_mux>;
+	};
+
+	l4_cfg_mod_ck: l4_cfg_mod_ck@d20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d20>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck@d28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d28>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox1_mod_ck: mailbox1_mod_ck@d30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d30>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox2_mod_ck: mailbox2_mod_ck@d48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d48>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox3_mod_ck: mailbox3_mod_ck@d50 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d50>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox4_mod_ck: mailbox4_mod_ck@d58 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d58>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox5_mod_ck: mailbox5_mod_ck@d60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d60>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox6_mod_ck: mailbox6_mod_ck@d68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d68>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox7_mod_ck: mailbox7_mod_ck@d70 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d70>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox8_mod_ck: mailbox8_mod_ck@d78 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d78>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox9_mod_ck: mailbox9_mod_ck@d80 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d80>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox10_mod_ck: mailbox10_mod_ck@d88 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d88>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox11_mod_ck: mailbox11_mod_ck@d90 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d90>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox12_mod_ck: mailbox12_mod_ck@d98 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d98>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mailbox13_mod_ck: mailbox13_mod_ck@da0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0da0>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	l3_main_2_mod_ck: l3_main_2_mod_ck@e20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e20>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	l3_instr_mod_ck: l3_instr_mod_ck@e28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e28>;
+		clocks = <&l3_iclk_div>;
+	};
+
 	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div@13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1719,6 +2345,27 @@
 		ti,dividers = <2>;
 	};
 
+	gmac_mod_ck: gmac_mod_ck@13d0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x13d0>;
+		clocks = <&dpll_gmac_ck>;
+	};
+
+	ocp2scp1_mod_ck: ocp2scp1_mod_ck@13e0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x13e0>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	ocp2scp3_mod_ck: ocp2scp3_mod_ck@13e8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x13e8>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gmac_rft_clk_mux: gmac_rft_clk_mux@13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1792,6 +2439,13 @@
 		reg = <0x1868>;
 	};
 
+	mcasp3_mod_ck: mcasp3_mod_ck@1868 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1868>;
+		clocks = <&mcasp3_aux_gfclk_mux>;
+	};
+
 	mcasp4_ahclkx_mux: mcasp4_ahclkx_mux@1898 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1880,6 +2534,13 @@
 		reg = <0x1328>;
 	};
 
+	mmc1_mod_ck: mmc1_mod_ck@1328 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1328>;
+		clocks = <&mmc1_fclk_div>;
+	};
+
 	mmc1_fclk_div: mmc1_fclk_div@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1908,6 +2569,13 @@
 		ti,index-power-of-two;
 	};
 
+	mmc2_mod_ck: mmc2_mod_ck@1330 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1330>;
+		clocks = <&mmc2_fclk_div>;
+	};
+
 	mmc3_gfclk_mux: mmc3_gfclk_mux@1820 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1926,6 +2594,13 @@
 		ti,index-power-of-two;
 	};
 
+	mmc3_mod_ck: mmc3_mod_ck@1820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1820>;
+		clocks = <&mmc3_gfclk_div>;
+	};
+
 	mmc4_gfclk_mux: mmc4_gfclk_mux@1828 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1952,6 +2627,13 @@
 		reg = <0x1838>;
 	};
 
+	qspi_mod_ck: qspi_mod_ck@1838 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1838>;
+		clocks = <&qspi_gfclk_div>;
+	};
+
 	qspi_gfclk_div: qspi_gfclk_div@1838 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1962,148 +2644,131 @@
 		ti,index-power-of-two;
 	};
 
-	timer10_gfclk_mux: timer10_gfclk_mux@1728 {
+	uart1_gfclk_mux: uart1_gfclk_mux@1840 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1728>;
+		reg = <0x1840>;
 	};
 
-	timer11_gfclk_mux: timer11_gfclk_mux@1730 {
+	uart1_mod_ck: uart1_mod_ck@1840 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1730>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1840>;
+		clocks = <&uart1_gfclk_mux>;
 	};
 
-	timer13_gfclk_mux: timer13_gfclk_mux@17c8 {
+	uart2_gfclk_mux: uart2_gfclk_mux@1848 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x17c8>;
+		reg = <0x1848>;
 	};
 
-	timer14_gfclk_mux: timer14_gfclk_mux@17d0 {
+	uart2_mod_ck: uart2_mod_ck@1848 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x17d0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1848>;
+		clocks = <&uart2_gfclk_mux>;
 	};
 
-	timer15_gfclk_mux: timer15_gfclk_mux@17d8 {
+	uart3_gfclk_mux: uart3_gfclk_mux@1850 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x17d8>;
+		reg = <0x1850>;
 	};
 
-	timer16_gfclk_mux: timer16_gfclk_mux@1830 {
+	uart3_mod_ck: uart3_mod_ck@1850 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1830>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1850>;
+		clocks = <&uart3_gfclk_mux>;
 	};
 
-	timer2_gfclk_mux: timer2_gfclk_mux@1738 {
+	uart4_gfclk_mux: uart4_gfclk_mux@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1738>;
+		reg = <0x1858>;
 	};
 
-	timer3_gfclk_mux: timer3_gfclk_mux@1740 {
+	uart4_mod_ck: uart4_mod_ck@1858 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1740>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1858>;
+		clocks = <&uart4_gfclk_mux>;
 	};
 
-	timer4_gfclk_mux: timer4_gfclk_mux@1748 {
+	uart5_gfclk_mux: uart5_gfclk_mux@1870 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1748>;
+		reg = <0x1870>;
 	};
 
-	timer9_gfclk_mux: timer9_gfclk_mux@1750 {
+	uart5_mod_ck: uart5_mod_ck@1870 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1750>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1870>;
+		clocks = <&uart5_gfclk_mux>;
 	};
 
-	uart1_gfclk_mux: uart1_gfclk_mux@1840 {
+	uart7_gfclk_mux: uart7_gfclk_mux@18d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1840>;
+		reg = <0x18d0>;
 	};
 
-	uart2_gfclk_mux: uart2_gfclk_mux@1848 {
+	uart7_mod_ck: uart7_mod_ck@18d0 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1848>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x18d0>;
+		clocks = <&uart7_gfclk_mux>;
 	};
 
-	uart3_gfclk_mux: uart3_gfclk_mux@1850 {
+	uart8_gfclk_mux: uart8_gfclk_mux@18e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1850>;
+		reg = <0x18e0>;
 	};
 
-	uart4_gfclk_mux: uart4_gfclk_mux@1858 {
+	uart8_mod_ck: uart8_mod_ck@18e0 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1858>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x18e0>;
+		clocks = <&uart8_gfclk_mux>;
 	};
 
-	uart5_gfclk_mux: uart5_gfclk_mux@1870 {
+	uart9_gfclk_mux: uart9_gfclk_mux@18e8 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1870>;
+		reg = <0x18e8>;
 	};
 
-	uart7_gfclk_mux: uart7_gfclk_mux@18d0 {
+	uart9_mod_ck: uart9_mod_ck@18e8 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x18d0>;
-	};
-
-	uart8_gfclk_mux: uart8_gfclk_mux@18e0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x18e0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x18e8>;
+		clocks = <&uart9_gfclk_mux>;
 	};
 
-	uart9_gfclk_mux: uart9_gfclk_mux@18e8 {
+	dcan2_mod_ck: dcan2_mod_ck@18f0 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x18e8>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x18f0>;
+		clocks = <&sys_clkin1>;
 	};
 
 	vip1_gclk_mux: vip1_gclk_mux@1020 {
@@ -2134,7 +2799,100 @@
 &cm_core_clockdomains {
 	coreaon_clkdm: coreaon_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&dpll_usb_ck>;
+		clocks = <&smartreflex_mpu_mod_ck>, <&smartreflex_core_mod_ck>,
+			 <&dpll_usb_ck>;
+	};
+
+	atl_clkdm: atl_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&atl_mod_ck>;
+	};
+
+	l3main1_clkdm: l3main1_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&tpcc_mod_ck>, <&tptc1_mod_ck>, <&l3_main_1_mod_ck>,
+			 <&vcp1_mod_ck>, <&gpmc_mod_ck>, <&tptc0_mod_ck>,
+			 <&vcp2_mod_ck>;
+	};
+
+	l4cfg_clkdm: l4cfg_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mailbox12_mod_ck>, <&mailbox6_mod_ck>,
+			 <&mailbox10_mod_ck>, <&mailbox11_mod_ck>,
+			 <&mailbox4_mod_ck>, <&mailbox8_mod_ck>,
+			 <&mailbox5_mod_ck>, <&mailbox3_mod_ck>,
+			 <&mailbox2_mod_ck>, <&l4_cfg_mod_ck>,
+			 <&mailbox13_mod_ck>, <&mailbox7_mod_ck>,
+			 <&mailbox1_mod_ck>, <&spinlock_mod_ck>,
+			 <&mailbox9_mod_ck>;
+	};
+
+	l3instr_clkdm: l3instr_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_instr_mod_ck>, <&l3_main_2_mod_ck>;
+	};
+
+	l4per_clkdm: l4per_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&timer3_mod_ck>, <&gpio6_mod_ck>, <&timer11_mod_ck>,
+			 <&hdq1w_mod_ck>, <&uart3_mod_ck>, <&gpio2_mod_ck>,
+			 <&uart1_mod_ck>, <&i2c4_mod_ck>, <&i2c2_mod_ck>,
+			 <&timer4_mod_ck>, <&i2c3_mod_ck>, <&l4_per1_mod_ck>,
+			 <&elm_mod_ck>, <&gpio3_mod_ck>, <&mcspi3_mod_ck>,
+			 <&uart4_mod_ck>, <&mmc4_mod_ck>, <&timer2_mod_ck>,
+			 <&mmc3_mod_ck>, <&gpio5_mod_ck>, <&gpio8_mod_ck>,
+			 <&gpio4_mod_ck>, <&mcspi1_mod_ck>, <&timer9_mod_ck>,
+			 <&mcspi2_mod_ck>, <&uart5_mod_ck>, <&timer10_mod_ck>,
+			 <&mcspi4_mod_ck>, <&uart2_mod_ck>, <&i2c1_mod_ck>,
+			 <&gpio7_mod_ck>;
+	};
+
+	l4per3_clkdm: l4per3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&timer16_mod_ck>, <&timer15_mod_ck>,
+			 <&l4_per3_mod_ck>, <&timer13_mod_ck>,
+			 <&timer14_mod_ck>;
+	};
+
+	l4per2_clkdm: l4per2_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&qspi_mod_ck>, <&uart8_mod_ck>, <&uart7_mod_ck>,
+			 <&l4_per2_mod_ck>, <&uart9_mod_ck>, <&mcasp3_mod_ck>,
+			 <&dcan2_mod_ck>;
+	};
+
+	dss_clkdm: dss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dss_hdmi_mod_ck>, <&dss_core_mod_ck>,
+			 <&dss_dispc_mod_ck>, <&bb2d_mod_ck>;
+	};
+
+	pcie_clkdm: pcie_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&pcie2_mod_ck>, <&pcie1_mod_ck>;
+	};
+
+	emif_clkdm: emif_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dmm_mod_ck>;
+	};
+
+	l3init_clkdm: l3init_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&ocp2scp1_mod_ck>, <&usb_otg_ss1_mod_ck>,
+			 <&sata_mod_ck>, <&mmc1_mod_ck>, <&usb_otg_ss4_mod_ck>,
+			 <&usb_otg_ss2_mod_ck>, <&ocp2scp3_mod_ck>,
+			 <&usb_otg_ss3_mod_ck>, <&mmc2_mod_ck>;
+	};
+
+	dma_clkdm: dma_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dma_system_mod_ck>;
+	};
+
+	gmac_clkdm: gmac_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gmac_mod_ck>;
 	};
 };
 
@@ -2171,3 +2929,30 @@
 		reg = <0x0558>;
 	};
 };
+
+&prm_clockdomains {
+	wkupaon_clkdm: wkupaon_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gpio1_mod_ck>, <&wd_timer2_mod_ck>,
+			 <&l4_wkup_mod_ck>, <&timer1_mod_ck>, <&uart10_mod_ck>,
+			 <&dcan1_mod_ck>, <&counter_32k_mod_ck>;
+	};
+};
+
+&cm_core_aon_clockdomains {
+	ipu_clkdm: ipu_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&timer7_mod_ck>, <&timer6_mod_ck>, <&uart6_mod_ck>,
+			 <&i2c5_mod_ck>, <&timer8_mod_ck>, <&timer5_mod_ck>;
+	};
+
+	mpu_clkdm: mpu_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mpu_mod_ck>;
+	};
+
+	rtc_clkdm: rtc_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&rtcss_mod_ck>;
+	};
+};
-- 
1.7.9.5

