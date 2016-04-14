From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 24/28] ARM: dts: omap4: add hwmod module clocks
Date: Thu, 14 Apr 2016 14:08:13 +0300
Message-ID: <1460632097-25727-25-git-send-email-t-kristo@ti.com>
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
 arch/arm/boot/dts/omap44xx-clocks.dtsi |  853 +++++++++++++++++++++++++++++---
 1 file changed, 780 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 9573b37..ac6171c 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -183,6 +183,20 @@
 		reg = <0x0528>;
 	};
 
+	aess_mod_ck: aess_mod_ck@528 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0528>;
+		clocks = <&aess_fclk>;
+	};
+
+	mcpdm_mod_ck: mcpdm_mod_ck@530 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0530>;
+		clocks = <&pad_clks_ck>;
+	};
+
 	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@1f4 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -194,6 +208,34 @@
 		ti,invert-autoidle-bit;
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
+		clocks = <&dpll_iva_m4x2_ck>;
+	};
+
+	dsp_mod_ck: dsp_mod_ck@420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0420>;
+		clocks = <&dpll_iva_m4x2_ck>;
+	};
+
+	l4_abe_mod_ck: l4_abe_mod_ck@520 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0520>;
+		clocks = <&ocp_abe_iclk>;
+	};
+
 	core_hsd_byp_clk_mux_ck: core_hsd_byp_clk_mux_ck@12c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -480,6 +522,13 @@
 		reg = <0x0538>;
 	};
 
+	dmic_mod_ck: dmic_mod_ck@538 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0538>;
+		clocks = <&func_dmic_abe_gfclk>;
+	};
+
 	func_dmic_abe_gfclk: func_dmic_abe_gfclk@538 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -496,6 +545,13 @@
 		reg = <0x0540>;
 	};
 
+	mcasp_mod_ck: mcasp_mod_ck@540 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0540>;
+		clocks = <&func_mcasp_abe_gfclk>;
+	};
+
 	func_mcasp_abe_gfclk: func_mcasp_abe_gfclk@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -520,6 +576,13 @@
 		reg = <0x0548>;
 	};
 
+	mcbsp1_mod_ck: mcbsp1_mod_ck@548 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0548>;
+		clocks = <&func_mcbsp1_gfclk>;
+	};
+
 	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@550 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -536,6 +599,13 @@
 		reg = <0x0550>;
 	};
 
+	mcbsp2_mod_ck: mcbsp2_mod_ck@550 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0550>;
+		clocks = <&func_mcbsp2_gfclk>;
+	};
+
 	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@558 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -552,6 +622,13 @@
 		reg = <0x0558>;
 	};
 
+	mcbsp3_mod_ck: mcbsp3_mod_ck@558 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0558>;
+		clocks = <&func_mcbsp3_gfclk>;
+	};
+
 	slimbus1_fclk_1: slimbus1_fclk_1@560 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -568,52 +645,66 @@
 		reg = <0x0560>;
 	};
 
-	slimbus1_fclk_2: slimbus1_fclk_2@560 {
+	slimbus1_mod_ck: slimbus1_mod_ck@560 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&pad_clks_ck>;
-		ti,bit-shift = <10>;
+		compatible = "ti,omap4-sw-mod-clock";
 		reg = <0x0560>;
+		clocks = <&slimbus1_fclk_0>;
 	};
 
-	slimbus1_slimbus_clk: slimbus1_slimbus_clk@560 {
+	timer5_mod_ck: timer5_mod_ck@568 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&slimbus_clk>;
-		ti,bit-shift = <11>;
-		reg = <0x0560>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0568>, <0x0568>;
+		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
 	};
 
-	timer5_sync_mux: timer5_sync_mux@568 {
+	timer6_mod_ck: timer6_mod_ck@570 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0570>, <0x0570>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0568>;
 	};
 
-	timer6_sync_mux: timer6_sync_mux@570 {
+	timer7_mod_ck: timer7_mod_ck@578 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0578>, <0x0578>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0570>;
 	};
 
-	timer7_sync_mux: timer7_sync_mux@578 {
+	timer8_mod_ck: timer8_mod_ck@580 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0580>, <0x0580>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0578>;
 	};
 
-	timer8_sync_mux: timer8_sync_mux@580 {
+	wd_timer3_mod_ck: wd_timer3_mod_ck@588 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0580>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0588>;
+		clocks = <&sys_32k_ck>;
+	};
+
+	slimbus1_fclk_2: slimbus1_fclk_2@560 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&pad_clks_ck>;
+		ti,bit-shift = <10>;
+		reg = <0x0560>;
+	};
+
+	slimbus1_slimbus_clk: slimbus1_slimbus_clk@560 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&slimbus_clk>;
+		ti,bit-shift = <11>;
+		reg = <0x0560>;
 	};
 
 	dummy_ck: dummy_ck {
@@ -631,6 +722,20 @@
 		ti,index-starts-at-one;
 	};
 
+	l4_wkup_mod_ck: l4_wkup_mod_ck@1820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1820>;
+		clocks = <&l4_wkup_clk_mux_ck>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck@1830 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1830>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@108 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -677,12 +782,26 @@
 		reg = <0x1838>;
 	};
 
-	dmt1_clk_mux: dmt1_clk_mux@1840 {
+	gpio1_mod_ck: gpio1_mod_ck@1838 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1838>;
+		clocks = <&l4_wkup_clk_mux_ck>;
+	};
+
+	timer1_mod_ck: timer1_mod_ck@1840 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1840>, <0x1840>;
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1840>;
+	};
+
+	counter_32k_mod_ck: counter_32k_mod_ck@1850 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1850>;
+		clocks = <&sys_32k_ck>;
 	};
 
 	usim_ck: usim_ck@1858 {
@@ -694,6 +813,13 @@
 		ti,dividers = <14>, <18>;
 	};
 
+	kbd_mod_ck: kbd_mod_ck@1878 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1878>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	usim_fclk: usim_fclk@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -737,6 +863,13 @@
 		ti,dividers = <0>, <1>, <2>, <0>, <4>;
 	};
 
+	debugss_mod_ck: debugss_mod_ck@1a20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1a20>;
+		clocks = <&trace_clk_div_ck>;
+	};
+
 	trace_clk_div_ck: trace_clk_div_ck {
 		#clock-cells = <0>;
 		compatible = "ti,clkdm-gate-clock";
@@ -747,7 +880,14 @@
 &prm_clockdomains {
 	emu_sys_clkdm: emu_sys_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&trace_clk_div_ck>;
+		clocks = <&debugss_mod_ck>, <&trace_clk_div_ck>;
+	};
+
+	l4_wkup_clkdm: l4_wkup_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&timer1_mod_ck>, <&l4_wkup_mod_ck>, <&gpio1_mod_ck>,
+			 <&wd_timer2_mod_ck>, <&counter_32k_mod_ck>,
+			 <&kbd_mod_ck>;
 	};
 };
 
@@ -993,6 +1133,55 @@
 		reg = <0x1120>;
 	};
 
+	dss_venc_mod_ck: dss_venc_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_tv_clk>;
+	};
+
+	dss_dispc_mod_ck: dss_dispc_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi1_mod_ck: dss_dsi1_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi2_mod_ck: dss_dsi2_mod_ck@1120 {
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
+	dss_rfbi_mod_ck: dss_rfbi_mod_ck@1120 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
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
 	dss_tv_clk: dss_tv_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1028,6 +1217,13 @@
 		ti,index-power-of-two;
 	};
 
+	fdif_mod_ck: fdif_mod_ck@1028 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1028>;
+		clocks = <&fdif_fck>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk@1460 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1036,6 +1232,13 @@
 		reg = <0x1460>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck@1460 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1460>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk@1468 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1044,6 +1247,13 @@
 		reg = <0x1468>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck@1468 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1468>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio4_dbclk: gpio4_dbclk@1470 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1052,6 +1262,13 @@
 		reg = <0x1470>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck@1470 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1470>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio5_dbclk: gpio5_dbclk@1478 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1060,6 +1277,13 @@
 		reg = <0x1478>;
 	};
 
+	gpio5_mod_ck: gpio5_mod_ck@1478 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1478>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio6_dbclk: gpio6_dbclk@1480 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1068,6 +1292,55 @@
 		reg = <0x1480>;
 	};
 
+	gpio6_mod_ck: gpio6_mod_ck@1480 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1480>;
+		clocks = <&l4_div_ck>;
+	};
+
+	hdq1w_mod_ck: hdq1w_mod_ck@1488 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1488>;
+		clocks = <&func_12m_fclk>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck@14a0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14a0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck@14a8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14a8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck@14b0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14b0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c4_mod_ck: i2c4_mod_ck@14b8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14b8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	l4_per_mod_ck: l4_per_mod_ck@14c0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x14c0>;
+		clocks = <&l4_div_ck>;
+	};
+
 	sgx_clk_mux: sgx_clk_mux@1220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1076,6 +1349,13 @@
 		reg = <0x1220>;
 	};
 
+	gpu_mod_ck: gpu_mod_ck@1220 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1220>;
+		clocks = <&sgx_clk_mux>;
+	};
+
 	hsi_fck: hsi_fck@1338 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1086,6 +1366,13 @@
 		ti,index-power-of-two;
 	};
 
+	hsi_mod_ck: hsi_mod_ck@1338 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1338>;
+		clocks = <&hsi_fck>;
+	};
+
 	iss_ctrlclk: iss_ctrlclk@1020 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1094,6 +1381,13 @@
 		reg = <0x1020>;
 	};
 
+	iss_mod_ck: iss_mod_ck@1020 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1020>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
 	mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck@14e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1102,6 +1396,55 @@
 		reg = <0x14e0>;
 	};
 
+	mcbsp4_mod_ck: mcbsp4_mod_ck@14e0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14e0>;
+		clocks = <&per_mcbsp4_gfclk>;
+	};
+
+	mcspi1_mod_ck: mcspi1_mod_ck@14f0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14f0>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi2_mod_ck: mcspi2_mod_ck@14f8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14f8>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi3_mod_ck: mcspi3_mod_ck@1500 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1500>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi4_mod_ck: mcspi4_mod_ck@1508 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1508>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc3_mod_ck: mmc3_mod_ck@1520 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1520>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc4_mod_ck: mmc4_mod_ck@1528 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1528>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	per_mcbsp4_gfclk: per_mcbsp4_gfclk@14e0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1118,6 +1461,13 @@
 		reg = <0x1328>;
 	};
 
+	mmc1_mod_ck: mmc1_mod_ck@1328 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1328>;
+		clocks = <&hsmmc1_fclk>;
+	};
+
 	hsmmc2_fclk: hsmmc2_fclk@1330 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1126,6 +1476,13 @@
 		reg = <0x1330>;
 	};
 
+	mmc2_mod_ck: mmc2_mod_ck@1330 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1330>;
+		clocks = <&hsmmc2_fclk>;
+	};
+
 	ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@13e0 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1134,6 +1491,68 @@
 		reg = <0x13e0>;
 	};
 
+	ocp2scp_usb_phy_mod_ck: ocp2scp_usb_phy_mod_ck@13e0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x13e0>;
+		clocks = <&ocp2scp_usb_phy_phy_48m>;
+	};
+
+	timer10_mod_ck: timer10_mod_ck@1428 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1428>, <0x1428>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer11_mod_ck: timer11_mod_ck@1430 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1430>, <0x1430>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck@1438 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1438>, <0x1438>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck@1440 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1440>, <0x1440>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck@1448 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1448>, <0x1448>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer9_mod_ck: timer9_mod_ck@1450 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1450>, <0x1450>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	elm_mod_ck: elm_mod_ck@1458 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1458>;
+		clocks = <&l4_div_ck>;
+	};
+
 	sha2md5_fck: sha2md5_fck@15c8 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1166,76 +1585,91 @@
 		reg = <0x1538>;
 	};
 
-	smartreflex_core_fck: smartreflex_core_fck@638 {
+	slimbus2_mod_ck: slimbus2_mod_ck@1538 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0638>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1538>;
+		clocks = <&slimbus2_fclk_0>;
 	};
 
-	smartreflex_iva_fck: smartreflex_iva_fck@630 {
+	uart1_mod_ck: uart1_mod_ck@1540 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0630>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1540>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	smartreflex_mpu_fck: smartreflex_mpu_fck@628 {
+	uart2_mod_ck: uart2_mod_ck@1548 {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0628>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1548>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm10_mux: cm2_dm10_mux@1428 {
+	uart3_mod_ck: uart3_mod_ck@1550 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1428>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1550>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm11_mux: cm2_dm11_mux@1430 {
+	uart4_mod_ck: uart4_mod_ck@1558 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1430>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1558>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm2_mux: cm2_dm2_mux@1438 {
+	mmc5_mod_ck: mmc5_mod_ck@1560 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1438>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1560>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm3_mux: cm2_dm3_mux@1440 {
+	smartreflex_core_fck: smartreflex_core_fck@638 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1440>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_wkup_clk_mux_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x0638>;
 	};
 
-	cm2_dm4_mux: cm2_dm4_mux@1448 {
+	smartreflex_core_mod_ck: smartreflex_core_mod_ck@638 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1448>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0638>;
+		clocks = <&smartreflex_core_fck>;
 	};
 
-	cm2_dm9_mux: cm2_dm9_mux@1450 {
+	smartreflex_iva_fck: smartreflex_iva_fck@630 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1450>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_wkup_clk_mux_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x0630>;
+	};
+
+	smartreflex_iva_mod_ck: smartreflex_iva_mod_ck@630 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0630>;
+		clocks = <&smartreflex_iva_fck>;
+	};
+
+	smartreflex_mpu_fck: smartreflex_mpu_fck@628 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_wkup_clk_mux_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x0628>;
+	};
+
+	smartreflex_mpu_mod_ck: smartreflex_mpu_mod_ck@628 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0628>;
+		clocks = <&smartreflex_mpu_fck>;
 	};
 
 	usb_host_fs_fck: usb_host_fs_fck@13d0 {
@@ -1246,6 +1680,13 @@
 		reg = <0x13d0>;
 	};
 
+	usb_host_fs_mod_ck: usb_host_fs_mod_ck@13d0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x13d0>;
+		clocks = <&usb_host_fs_fck>;
+	};
+
 	utmi_p1_gfclk: utmi_p1_gfclk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1262,6 +1703,13 @@
 		reg = <0x1358>;
 	};
 
+	usb_host_hs_mod_ck: usb_host_hs_mod_ck@1358 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1358>;
+		clocks = <&usb_host_hs_fck>;
+	};
+
 	utmi_p2_gfclk: utmi_p2_gfclk@1358 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1342,6 +1790,13 @@
 		reg = <0x1360>;
 	};
 
+	usb_otg_hs_mod_ck: usb_otg_hs_mod_ck@1360 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1360>;
+		clocks = <&usb_otg_hs_ick>;
+	};
+
 	usb_otg_hs_xclk: usb_otg_hs_xclk@1360 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1366,6 +1821,139 @@
 		reg = <0x0640>;
 	};
 
+	l3_main_1_mod_ck: l3_main_1_mod_ck@720 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0720>;
+		clocks = <&l3_div_ck>;
+	};
+
+	l3_main_2_mod_ck: l3_main_2_mod_ck@820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0820>;
+		clocks = <&l3_div_ck>;
+	};
+
+	gpmc_mod_ck: gpmc_mod_ck@828 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0828>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ocmc_ram_mod_ck: ocmc_ram_mod_ck@830 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0830>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ipu_mod_ck: ipu_mod_ck@920 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0920>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
+	mmu_ipu_mod_ck: mmu_ipu_mod_ck@920 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0920>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
+	dma_system_mod_ck: dma_system_mod_ck@a20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0a20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	dmm_mod_ck: dmm_mod_ck@b20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0b20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	emif1_mod_ck: emif1_mod_ck@b30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b30>;
+		clocks = <&ddrphy_ck>;
+	};
+
+	emif2_mod_ck: emif2_mod_ck@b38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b38>;
+		clocks = <&ddrphy_ck>;
+	};
+
+	c2c_mod_ck: c2c_mod_ck@c20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0c20>;
+		clocks = <&div_core_ck>;
+	};
+
+	l4_cfg_mod_ck: l4_cfg_mod_ck@d20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d20>;
+		clocks = <&l4_div_ck>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck@d28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d28>;
+		clocks = <&l4_div_ck>;
+	};
+
+	mailbox_mod_ck: mailbox_mod_ck@d30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d30>;
+		clocks = <&l4_div_ck>;
+	};
+
+	l3_main_3_mod_ck: l3_main_3_mod_ck@e20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	l3_instr_mod_ck: l3_instr_mod_ck@e28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e28>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ocp_wp_noc_mod_ck: ocp_wp_noc_mod_ck@e40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e40>;
+		clocks = <&l3_div_ck>;
+	};
+
+	iva_mod_ck: iva_mod_ck@f20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0f20>;
+		clocks = <&dpll_iva_m5x2_ck>;
+	};
+
+	sl2if_mod_ck: sl2if_mod_ck@f28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0f28>;
+		clocks = <&dpll_iva_m5x2_ck>;
+	};
+
 	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@1368 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1397,12 +1985,110 @@
 		ti,bit-shift = <0>;
 		reg = <0x1368>;
 	};
+
+	usb_tll_hs_mod_ck: usb_tll_hs_mod_ck@1368 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1368>;
+		clocks = <&usb_tll_hs_ick>;
+	};
 };
 
 &cm2_clockdomains {
 	l3_init_clkdm: l3_init_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&dpll_usb_ck>, <&usb_host_fs_fck>;
+		clocks = <&mmc2_mod_ck>, <&usb_otg_hs_mod_ck>,
+			 <&usb_host_fs_mod_ck>, <&usb_tll_hs_mod_ck>,
+			 <&usb_host_hs_mod_ck>, <&mmc1_mod_ck>, <&hsi_mod_ck>,
+			 <&ocp2scp_usb_phy_mod_ck>, <&dpll_usb_ck>,
+			 <&usb_host_fs_fck>;
+	};
+
+	l3_gfx_clkdm: l3_gfx_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gpu_mod_ck>;
+	};
+
+	l4_per_clkdm: l4_per_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l4_per_mod_ck>, <&uart2_mod_ck>, <&uart1_mod_ck>,
+			 <&timer10_mod_ck>, <&gpio2_mod_ck>, <&mcspi3_mod_ck>,
+			 <&uart4_mod_ck>, <&gpio5_mod_ck>, <&hdq1w_mod_ck>,
+			 <&mcbsp4_mod_ck>, <&i2c1_mod_ck>, <&i2c3_mod_ck>,
+			 <&mcspi2_mod_ck>, <&timer9_mod_ck>, <&i2c4_mod_ck>,
+			 <&timer2_mod_ck>, <&timer4_mod_ck>, <&mcspi4_mod_ck>,
+			 <&timer11_mod_ck>, <&mcspi1_mod_ck>, <&timer3_mod_ck>,
+			 <&mmc3_mod_ck>, <&mmc5_mod_ck>, <&gpio4_mod_ck>,
+			 <&gpio6_mod_ck>, <&uart3_mod_ck>, <&slimbus2_mod_ck>,
+			 <&gpio3_mod_ck>, <&i2c2_mod_ck>, <&mmc4_mod_ck>,
+			 <&elm_mod_ck>;
+	};
+
+	ivahd_clkdm: ivahd_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&sl2if_mod_ck>, <&iva_mod_ck>;
+	};
+
+	l4_cfg_clkdm: l4_cfg_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&spinlock_mod_ck>, <&mailbox_mod_ck>,
+			 <&l4_cfg_mod_ck>;
+	};
+
+	l3_instr_clkdm: l3_instr_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&ocp_wp_noc_mod_ck>, <&l3_main_3_mod_ck>,
+			 <&l3_instr_mod_ck>;
+	};
+
+	iss_clkdm: iss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&fdif_mod_ck>, <&iss_mod_ck>;
+	};
+
+	l3_emif_clkdm: l3_emif_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&emif2_mod_ck>, <&emif1_mod_ck>, <&dmm_mod_ck>;
+	};
+
+	ducati_clkdm: ducati_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&ipu_mod_ck>, <&mmu_ipu_mod_ck>;
+	};
+
+	l3_dma_clkdm: l3_dma_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dma_system_mod_ck>;
+	};
+
+	l3_2_clkdm: l3_2_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gpmc_mod_ck>, <&l3_main_2_mod_ck>,
+			 <&ocmc_ram_mod_ck>;
+	};
+
+	l3_dss_clkdm: l3_dss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dss_venc_mod_ck>, <&dss_hdmi_mod_ck>,
+			 <&dss_dsi2_mod_ck>, <&dss_core_mod_ck>,
+			 <&dss_dsi1_mod_ck>, <&dss_rfbi_mod_ck>,
+			 <&dss_dispc_mod_ck>;
+	};
+
+	l4_ao_clkdm: l4_ao_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&smartreflex_core_mod_ck>, <&smartreflex_mpu_mod_ck>,
+			 <&smartreflex_iva_mod_ck>;
+	};
+
+	d2d_clkdm: d2d_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&c2c_mod_ck>;
+	};
+
+	l3_1_clkdm: l3_1_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_1_mod_ck>;
 	};
 };
 
@@ -1641,3 +2327,24 @@
 		reg = <0x0224>;
 	};
 };
+
+&cm1_clockdomains {
+	mpuss_clkdm: mpuss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mpu_mod_ck>;
+	};
+
+	tesla_clkdm: tesla_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mmu_dsp_mod_ck>, <&dsp_mod_ck>;
+	};
+
+	abe_clkdm: abe_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&mcpdm_mod_ck>, <&l4_abe_mod_ck>, <&wd_timer3_mod_ck>,
+			 <&timer7_mod_ck>, <&timer5_mod_ck>, <&mcbsp3_mod_ck>,
+			 <&mcbsp2_mod_ck>, <&timer6_mod_ck>, <&mcbsp1_mod_ck>,
+			 <&timer8_mod_ck>, <&mcasp_mod_ck>, <&dmic_mod_ck>,
+			 <&aess_mod_ck>, <&slimbus1_mod_ck>;
+	};
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
