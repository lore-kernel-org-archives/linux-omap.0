From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 27/28] ARM: dts: omap5: add hwmod module clocks
Date: Thu, 14 Apr 2016 14:08:16 +0300
Message-ID: <1460632097-25727-28-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clock nodes for the SoC hwmods. This is done in preparation to remove
hwmod data from kernel, hwmod will use the clock nodes instead for
module level enable / disable logic.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi |  689 ++++++++++++++++++++++++++++----
 1 file changed, 618 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 4899c23..f353dd9 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -167,6 +167,27 @@
 		ti,index-starts-at-one;
 	};
 
+	mpu_mod_ck: mpu_mod_ck@320 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0320>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	mmu_dsp_mod_ck: mmu_dsp_mod_ck@420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0420>;
+		clocks = <&dpll_iva_h11x2_ck>;
+	};
+
+	l4_abe_mod_ck: l4_abe_mod_ck@520 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0520>;
+		clocks = <&abe_iclk>;
+	};
+
 	dpll_core_byp_mux: dpll_core_byp_mux@12c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -417,6 +438,38 @@
 		reg = <0x0560>;
 	};
 
+	timer5_mod_ck: timer5_mod_ck@568 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0568>, <0x0568>;
+		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer6_mod_ck: timer6_mod_ck@570 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0570>, <0x0570>;
+		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer7_mod_ck: timer7_mod_ck@578 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0578>, <0x0578>;
+		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer8_mod_ck: timer8_mod_ck@580 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0580>, <0x0580>;
+		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
 	aess_fclk: aess_fclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -426,6 +479,13 @@
 		reg = <0x0528>;
 	};
 
+	mcpdm_mod_ck: mcpdm_mod_ck@530 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0530>;
+		clocks = <&pad_clks_ck>;
+	};
+
 	dmic_sync_mux_ck: dmic_sync_mux_ck@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -442,6 +502,13 @@
 		reg = <0x0538>;
 	};
 
+	dmic_mod_ck: dmic_mod_ck@538 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0538>;
+		clocks = <&dmic_gfclk>;
+	};
+
 	mcasp_sync_mux_ck: mcasp_sync_mux_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -466,6 +533,13 @@
 		reg = <0x0548>;
 	};
 
+	mcbsp1_mod_ck: mcbsp1_mod_ck@548 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0548>;
+		clocks = <&mcbsp1_gfclk>;
+	};
+
 	mcbsp1_gfclk: mcbsp1_gfclk@548 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -482,6 +556,13 @@
 		reg = <0x0550>;
 	};
 
+	mcbsp2_mod_ck: mcbsp2_mod_ck@550 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0550>;
+		clocks = <&mcbsp2_gfclk>;
+	};
+
 	mcbsp2_gfclk: mcbsp2_gfclk@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -506,36 +587,11 @@
 		reg = <0x0558>;
 	};
 
-	timer5_gfclk_mux: timer5_gfclk_mux@568 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0568>;
-	};
-
-	timer6_gfclk_mux: timer6_gfclk_mux@570 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0570>;
-	};
-
-	timer7_gfclk_mux: timer7_gfclk_mux@578 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0578>;
-	};
-
-	timer8_gfclk_mux: timer8_gfclk_mux@580 {
+	mcbsp3_mod_ck: mcbsp3_mod_ck@558 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0580>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0558>;
+		clocks = <&mcbsp3_gfclk>;
 	};
 
 	dummy_ck: dummy_ck {
@@ -553,6 +609,20 @@
 		ti,index-starts-at-one;
 	};
 
+	l4_wkup_mod_ck: l4_wkup_mod_ck@1920 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1920>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck@1930 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1930>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -606,13 +676,35 @@
 		reg = <0x1938>;
 	};
 
-	timer1_gfclk_mux: timer1_gfclk_mux@1940 {
+	gpio1_mod_ck: gpio1_mod_ck@1938 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1938>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	timer1_mod_ck: timer1_mod_ck@1940 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1940>, <0x1940>;
 		clocks = <&sys_clkin>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1940>;
 	};
+
+	counter_32k_mod_ck: counter_32k_mod_ck@1950 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1950>;
+		clocks = <&wkupaon_iclk_mux>;
+	};
+
+	kbd_mod_ck: kbd_mod_ck@1978 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1978>;
+		clocks = <&sys_32k_ck>;
+	};
+
 };
 &cm_core_clocks {
 
@@ -852,6 +944,48 @@
 		reg = <0x1420>;
 	};
 
+	dss_dispc_mod_ck: dss_dispc_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1420>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi1_mod_ck: dss_dsi1_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1420>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi2_mod_ck: dss_dsi2_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1420>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_core_mod_ck: dss_core_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1420>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_rfbi_mod_ck: dss_rfbi_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1420>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	dss_hdmi_mod_ck: dss_hdmi_mod_ck@1420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1420>;
+		clocks = <&dss_48mhz_clk>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk@1060 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -860,6 +994,13 @@
 		reg = <0x1060>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck@1060 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1060>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk@1068 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -868,6 +1009,13 @@
 		reg = <0x1068>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck@1068 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1068>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gpio4_dbclk: gpio4_dbclk@1070 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -876,6 +1024,13 @@
 		reg = <0x1070>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck@1070 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1070>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gpio5_dbclk: gpio5_dbclk@1078 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -884,6 +1039,13 @@
 		reg = <0x1078>;
 	};
 
+	gpio5_mod_ck: gpio5_mod_ck@1078 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1078>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gpio6_dbclk: gpio6_dbclk@1080 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -892,6 +1054,76 @@
 		reg = <0x1080>;
 	};
 
+	gpio6_mod_ck: gpio6_mod_ck@1080 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1080>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck@10a0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10a0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck@10a8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10a8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck@10b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10b0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c4_mod_ck: i2c4_mod_ck@10b8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10b8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	l4_per_mod_ck: l4_per_mod_ck@10c0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x10c0>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	mcspi1_mod_ck: mcspi1_mod_ck@10f0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10f0>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi2_mod_ck: mcspi2_mod_ck@10f8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x10f8>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi3_mod_ck: mcspi3_mod_ck@1100 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1100>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi4_mod_ck: mcspi4_mod_ck@1108 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1108>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	gpio7_dbclk: gpio7_dbclk@1110 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -900,6 +1132,13 @@
 		reg = <0x1110>;
 	};
 
+	gpio7_mod_ck: gpio7_mod_ck@1110 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1110>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	gpio8_dbclk: gpio8_dbclk@1118 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -908,6 +1147,83 @@
 		reg = <0x1118>;
 	};
 
+	gpio8_mod_ck: gpio8_mod_ck@1118 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1118>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	mmc3_mod_ck: mmc3_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1120>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc4_mod_ck: mmc4_mod_ck@1128 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1128>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	uart1_mod_ck: uart1_mod_ck@1140 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1140>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	uart2_mod_ck: uart2_mod_ck@1148 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1148>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	uart3_mod_ck: uart3_mod_ck@1150 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1150>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	uart4_mod_ck: uart4_mod_ck@1158 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1158>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc5_mod_ck: mmc5_mod_ck@1160 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1160>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c5_mod_ck: i2c5_mod_ck@1168 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1168>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	uart5_mod_ck: uart5_mod_ck@1170 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1170>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	uart6_mod_ck: uart6_mod_ck@1178 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1178>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	iss_ctrlclk: iss_ctrlclk@1320 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -932,6 +1248,54 @@
 		reg = <0x0f20>;
 	};
 
+	timer10_mod_ck: timer10_mod_ck@1028 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1028>, <0x1028>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer11_mod_ck: timer11_mod_ck@1030 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1030>, <0x1030>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck@1038 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1038>, <0x1038>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck@1040 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1040>, <0x1040>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck@1048 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1048>, <0x1048>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer9_mod_ck: timer9_mod_ck@1050 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1050>, <0x1050>;
+		clocks = <&sys_clkin>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
 	mmc1_32khz_clk: mmc1_32khz_clk@1628 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -948,6 +1312,27 @@
 		reg = <0x1688>;
 	};
 
+	sata_mod_ck: sata_mod_ck@1688 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1688>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	ocp2scp1_mod_ck: ocp2scp1_mod_ck@16e0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x16e0>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	ocp2scp3_mod_ck: ocp2scp3_mod_ck@16e8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x16e8>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1012,6 +1397,13 @@
 		reg = <0x1658>;
 	};
 
+	usb_host_hs_mod_ck: usb_host_hs_mod_ck@1658 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1658>;
+		clocks = <&l3init_60m_fclk>;
+	};
+
 	utmi_p2_gfclk: utmi_p2_gfclk@1658 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1044,6 +1436,13 @@
 		reg = <0x16f0>;
 	};
 
+	usb_otg_ss_mod_ck: usb_otg_ss_mod_ck@16f0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x16f0>;
+		clocks = <&dpll_core_h13x2_ck>;
+	};
+
 	usb_phy_cm_clk32k: usb_phy_cm_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1052,6 +1451,90 @@
 		reg = <0x0640>;
 	};
 
+	l3_main_1_mod_ck: l3_main_1_mod_ck@720 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0720>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	l3_main_2_mod_ck: l3_main_2_mod_ck@820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0820>;
+		clocks = <&l3_iclk_div>;
+	};
+
+	mmu_ipu_mod_ck: mmu_ipu_mod_ck@920 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0920>;
+		clocks = <&dpll_core_h22x2_ck>;
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
+	emif1_mod_ck: emif1_mod_ck@b30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b30>;
+		clocks = <&dpll_core_h11x2_ck>;
+	};
+
+	emif2_mod_ck: emif2_mod_ck@b38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b38>;
+		clocks = <&dpll_core_h11x2_ck>;
+	};
+
+	l4_cfg_mod_ck: l4_cfg_mod_ck@d20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d20>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck@d28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d28>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	mailbox_mod_ck: mailbox_mod_ck@d30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d30>;
+		clocks = <&l4_root_clk_div>;
+	};
+
+	l3_main_3_mod_ck: l3_main_3_mod_ck@e20 {
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
 	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@1668 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1060,6 +1543,13 @@
 		reg = <0x1668>;
 	};
 
+	usb_tll_hs_mod_ck: usb_tll_hs_mod_ck@1668 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1668>;
+		clocks = <&l4_root_clk_div>;
+	};
+
 	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@1668 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1127,6 +1617,13 @@
 		reg = <0x1628>;
 	};
 
+	mmc1_mod_ck: mmc1_mod_ck@1628 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1628>;
+		clocks = <&mmc1_fclk>;
+	};
+
 	mmc2_fclk_mux: mmc2_fclk_mux@1630 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1144,59 +1641,80 @@
 		reg = <0x1630>;
 	};
 
-	timer10_gfclk_mux: timer10_gfclk_mux@1028 {
+	mmc2_mod_ck: mmc2_mod_ck@1630 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1028>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1630>;
+		clocks = <&mmc2_fclk>;
 	};
 
-	timer11_gfclk_mux: timer11_gfclk_mux@1030 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1030>;
+};
+
+&cm_core_clockdomains {
+	l3init_clkdm: l3init_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&usb_tll_hs_mod_ck>, <&usb_host_hs_mod_ck>,
+			 <&sata_mod_ck>, <&ocp2scp1_mod_ck>, <&mmc1_mod_ck>,
+			 <&mmc2_mod_ck>, <&usb_otg_ss_mod_ck>,
+			 <&ocp2scp3_mod_ck>, <&dpll_usb_ck>;
 	};
 
-	timer2_gfclk_mux: timer2_gfclk_mux@1038 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1038>;
+	dss_clkdm: dss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dss_dsi2_mod_ck>, <&dss_rfbi_mod_ck>,
+			 <&dss_hdmi_mod_ck>, <&dss_dispc_mod_ck>,
+			 <&dss_dsi1_mod_ck>, <&dss_core_mod_ck>;
 	};
 
-	timer3_gfclk_mux: timer3_gfclk_mux@1040 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1040>;
+	emif_clkdm: emif_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&emif1_mod_ck>, <&dmm_mod_ck>, <&emif2_mod_ck>;
 	};
 
-	timer4_gfclk_mux: timer4_gfclk_mux@1048 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1048>;
+	l3main1_clkdm: l3main1_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_1_mod_ck>;
 	};
 
-	timer9_gfclk_mux: timer9_gfclk_mux@1050 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1050>;
+	l4cfg_clkdm: l4cfg_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&spinlock_mod_ck>, <&l4_cfg_mod_ck>,
+			 <&mailbox_mod_ck>;
 	};
-};
 
-&cm_core_clockdomains {
-	l3init_clkdm: l3init_clkdm {
+	dma_clkdm: dma_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&dpll_usb_ck>;
+		clocks = <&dma_system_mod_ck>;
+	};
+
+	l3main2_clkdm: l3main2_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_2_mod_ck>;
+	};
+
+	ipu_clkdm: ipu_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mmu_ipu_mod_ck>;
+	};
+
+	l3instr_clkdm: l3instr_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_3_mod_ck>, <&l3_instr_mod_ck>;
+	};
+
+	l4per_clkdm: l4per_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l4_per_mod_ck>, <&uart6_mod_ck>, <&i2c4_mod_ck>,
+			 <&gpio8_mod_ck>, <&uart5_mod_ck>, <&gpio4_mod_ck>,
+			 <&timer4_mod_ck>, <&mcspi2_mod_ck>, <&mmc3_mod_ck>,
+			 <&mmc5_mod_ck>, <&timer9_mod_ck>, <&gpio7_mod_ck>,
+			 <&mcspi3_mod_ck>, <&uart4_mod_ck>, <&uart2_mod_ck>,
+			 <&i2c3_mod_ck>, <&timer11_mod_ck>, <&mmc4_mod_ck>,
+			 <&i2c5_mod_ck>, <&gpio2_mod_ck>, <&gpio3_mod_ck>,
+			 <&uart3_mod_ck>, <&i2c2_mod_ck>, <&mcspi1_mod_ck>,
+			 <&timer2_mod_ck>, <&gpio5_mod_ck>, <&uart1_mod_ck>,
+			 <&timer10_mod_ck>, <&gpio6_mod_ck>, <&timer3_mod_ck>,
+			 <&mcspi4_mod_ck>, <&i2c1_mod_ck>;
 	};
 };
 
@@ -1388,3 +1906,32 @@
 		reg = <0x021c>;
 	};
 };
+
+&prm_clockdomains {
+	wkupaon_clkdm: wkupaon_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&kbd_mod_ck>, <&gpio1_mod_ck>, <&counter_32k_mod_ck>,
+			 <&timer1_mod_ck>, <&wd_timer2_mod_ck>,
+			 <&l4_wkup_mod_ck>;
+	};
+};
+
+&cm_core_aon_clockdomains {
+	mpu_clkdm: mpu_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mpu_mod_ck>;
+	};
+
+	dsp_clkdm: dsp_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mmu_dsp_mod_ck>;
+	};
+
+	abe_clkdm: abe_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&timer5_mod_ck>, <&timer7_mod_ck>, <&mcbsp2_mod_ck>,
+			 <&mcbsp1_mod_ck>, <&dmic_mod_ck>, <&timer6_mod_ck>,
+			 <&mcbsp3_mod_ck>, <&mcpdm_mod_ck>, <&l4_abe_mod_ck>,
+			 <&timer8_mod_ck>;
+	};
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
