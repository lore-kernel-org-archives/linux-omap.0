From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 7/9] ARM: dts: omap4: add hwmod module clocks
Date: Fri, 18 Dec 2015 15:58:59 +0200
Message-ID: <1450447141-29936-8-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add clock nodes for the SoC hwmods. This is done in preparation to remove
hwmod data from kernel, hwmod will use the clock nodes instead for
module level enable / disable logic.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi |  854 +++++++++++++++++++++++++++++---
 1 file changed, 781 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index f2c48f0..1d3e0b8 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -183,6 +183,20 @@
 		reg = <0x0528>;
 	};
 
+	aess_mod_ck: aess_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0528>;
+		clocks = <&aess_fclk>;
+	};
+
+	mcpdm_mod_ck: mcpdm_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0530>;
+		clocks = <&pad_clks_ck>;
+	};
+
 	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -194,6 +208,34 @@
 		ti,invert-autoidle-bit;
 	};
 
+	mpu_mod_ck: mpu_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0320>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	mmu_dsp_mod_ck: mmu_dsp_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0420>;
+		clocks = <&dpll_iva_m4x2_ck>;
+	};
+
+	dsp_mod_ck: dsp_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0420>;
+		clocks = <&dpll_iva_m4x2_ck>;
+	};
+
+	l4_abe_mod_ck: l4_abe_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0520>;
+		clocks = <&ocp_abe_iclk>;
+	};
+
 	core_hsd_byp_clk_mux_ck: core_hsd_byp_clk_mux_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -480,6 +522,13 @@
 		reg = <0x0538>;
 	};
 
+	dmic_mod_ck: dmic_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0538>;
+		clocks = <&func_dmic_abe_gfclk>;
+	};
+
 	func_dmic_abe_gfclk: func_dmic_abe_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -496,6 +545,13 @@
 		reg = <0x0540>;
 	};
 
+	mcasp_mod_ck: mcasp_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0540>;
+		clocks = <&func_mcasp_abe_gfclk>;
+	};
+
 	func_mcasp_abe_gfclk: func_mcasp_abe_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -520,6 +576,13 @@
 		reg = <0x0548>;
 	};
 
+	mcbsp1_mod_ck: mcbsp1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0548>;
+		clocks = <&func_mcbsp1_gfclk>;
+	};
+
 	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -536,6 +599,13 @@
 		reg = <0x0550>;
 	};
 
+	mcbsp2_mod_ck: mcbsp2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0550>;
+		clocks = <&func_mcbsp2_gfclk>;
+	};
+
 	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -552,6 +622,13 @@
 		reg = <0x0558>;
 	};
 
+	mcbsp3_mod_ck: mcbsp3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0558>;
+		clocks = <&func_mcbsp3_gfclk>;
+	};
+
 	slimbus1_fclk_1: slimbus1_fclk_1 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -568,52 +645,66 @@
 		reg = <0x0560>;
 	};
 
-	slimbus1_fclk_2: slimbus1_fclk_2 {
+	slimbus1_mod_ck: slimbus1_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&pad_clks_ck>;
-		ti,bit-shift = <10>;
+		compatible = "ti,omap4-sw-mod-clock";
 		reg = <0x0560>;
+		clocks = <&slimbus1_fclk_0>;
 	};
 
-	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
+	timer5_mod_ck: timer5_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&slimbus_clk>;
-		ti,bit-shift = <11>;
-		reg = <0x0560>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0568>;
+		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
 	};
 
-	timer5_sync_mux: timer5_sync_mux {
+	timer6_mod_ck: timer6_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0570>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0568>;
 	};
 
-	timer6_sync_mux: timer6_sync_mux {
+	timer7_mod_ck: timer7_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0578>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0570>;
 	};
 
-	timer7_sync_mux: timer7_sync_mux {
+	timer8_mod_ck: timer8_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0580>;
 		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x0578>;
 	};
 
-	timer8_sync_mux: timer8_sync_mux {
+	wd_timer3_mod_ck: wd_timer3_mod_ck {
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
+	slimbus1_fclk_2: slimbus1_fclk_2 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&pad_clks_ck>;
+		ti,bit-shift = <10>;
+		reg = <0x0560>;
+	};
+
+	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&slimbus_clk>;
+		ti,bit-shift = <11>;
+		reg = <0x0560>;
 	};
 
 	dummy_ck: dummy_ck {
@@ -622,6 +713,7 @@
 		clock-frequency = <0>;
 	};
 };
+
 &prm_clocks {
 	sys_clkin_ck: sys_clkin_ck {
 		#clock-cells = <0>;
@@ -631,6 +723,20 @@
 		ti,index-starts-at-one;
 	};
 
+	l4_wkup_mod_ck: l4_wkup_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1820>;
+		clocks = <&l4_wkup_clk_mux_ck>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1830>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -677,12 +783,26 @@
 		reg = <0x1838>;
 	};
 
-	dmt1_clk_mux: dmt1_clk_mux {
+	gpio1_mod_ck: gpio1_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1838>;
+		clocks = <&l4_wkup_clk_mux_ck>;
+	};
+
+	timer1_mod_ck: timer1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1840>;
 		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
 		ti,bit-shift = <24>;
-		reg = <0x1840>;
+	};
+
+	counter_32k_mod_ck: counter_32k_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1850>;
+		clocks = <&sys_32k_ck>;
 	};
 
 	usim_ck: usim_ck {
@@ -694,6 +814,13 @@
 		ti,dividers = <14>, <18>;
 	};
 
+	kbd_mod_ck: kbd_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1878>;
+		clocks = <&sys_32k_ck>;
+	};
+
 	usim_fclk: usim_fclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -737,6 +864,13 @@
 		ti,dividers = <0>, <1>, <2>, <0>, <4>;
 	};
 
+	debugss_mod_ck: debugss_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1a20>;
+		clocks = <&trace_clk_div_ck>;
+	};
+
 	trace_clk_div_ck: trace_clk_div_ck {
 		#clock-cells = <0>;
 		compatible = "ti,clkdm-gate-clock";
@@ -747,7 +881,14 @@
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
 
@@ -993,6 +1134,55 @@
 		reg = <0x1120>;
 	};
 
+	dss_venc_mod_ck: dss_venc_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_tv_clk>;
+	};
+
+	dss_dispc_mod_ck: dss_dispc_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi1_mod_ck: dss_dsi1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_dsi2_mod_ck: dss_dsi2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_core_mod_ck: dss_core_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_rfbi_mod_ck: dss_rfbi_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_dss_clk>;
+	};
+
+	dss_hdmi_mod_ck: dss_hdmi_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1120>;
+		clocks = <&dss_48mhz_clk>;
+	};
+
 	dss_tv_clk: dss_tv_clk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1028,6 +1218,13 @@
 		ti,index-power-of-two;
 	};
 
+	fdif_mod_ck: fdif_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1028>;
+		clocks = <&fdif_fck>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1036,6 +1233,13 @@
 		reg = <0x1460>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1460>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1044,6 +1248,13 @@
 		reg = <0x1468>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1468>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio4_dbclk: gpio4_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1052,6 +1263,13 @@
 		reg = <0x1470>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1470>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio5_dbclk: gpio5_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1060,6 +1278,13 @@
 		reg = <0x1478>;
 	};
 
+	gpio5_mod_ck: gpio5_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1478>;
+		clocks = <&l4_div_ck>;
+	};
+
 	gpio6_dbclk: gpio6_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1068,6 +1293,55 @@
 		reg = <0x1480>;
 	};
 
+	gpio6_mod_ck: gpio6_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1480>;
+		clocks = <&l4_div_ck>;
+	};
+
+	hdq1w_mod_ck: hdq1w_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1488>;
+		clocks = <&func_12m_fclk>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14a0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14a8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14b0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	i2c4_mod_ck: i2c4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14b8>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	l4_per_mod_ck: l4_per_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x14c0>;
+		clocks = <&l4_div_ck>;
+	};
+
 	sgx_clk_mux: sgx_clk_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1076,6 +1350,13 @@
 		reg = <0x1220>;
 	};
 
+	gpu_mod_ck: gpu_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1220>;
+		clocks = <&sgx_clk_mux>;
+	};
+
 	hsi_fck: hsi_fck {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1086,6 +1367,13 @@
 		ti,index-power-of-two;
 	};
 
+	hsi_mod_ck: hsi_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1338>;
+		clocks = <&hsi_fck>;
+	};
+
 	iss_ctrlclk: iss_ctrlclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1094,6 +1382,13 @@
 		reg = <0x1020>;
 	};
 
+	iss_mod_ck: iss_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1020>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
 	mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1102,6 +1397,55 @@
 		reg = <0x14e0>;
 	};
 
+	mcbsp4_mod_ck: mcbsp4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14e0>;
+		clocks = <&per_mcbsp4_gfclk>;
+	};
+
+	mcspi1_mod_ck: mcspi1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14f0>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi2_mod_ck: mcspi2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14f8>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi3_mod_ck: mcspi3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1500>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mcspi4_mod_ck: mcspi4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1508>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc3_mod_ck: mmc3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1520>;
+		clocks = <&func_48m_fclk>;
+	};
+
+	mmc4_mod_ck: mmc4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1528>;
+		clocks = <&func_48m_fclk>;
+	};
+
 	per_mcbsp4_gfclk: per_mcbsp4_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1118,6 +1462,13 @@
 		reg = <0x1328>;
 	};
 
+	mmc1_mod_ck: mmc1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1328>;
+		clocks = <&hsmmc1_fclk>;
+	};
+
 	hsmmc2_fclk: hsmmc2_fclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1126,6 +1477,13 @@
 		reg = <0x1330>;
 	};
 
+	mmc2_mod_ck: mmc2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1330>;
+		clocks = <&hsmmc2_fclk>;
+	};
+
 	ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1134,6 +1492,68 @@
 		reg = <0x13e0>;
 	};
 
+	ocp2scp_usb_phy_mod_ck: ocp2scp_usb_phy_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x13e0>;
+		clocks = <&ocp2scp_usb_phy_phy_48m>;
+	};
+
+	timer10_mod_ck: timer10_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1428>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer11_mod_ck: timer11_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1430>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1438>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1440>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1448>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	timer9_mod_ck: timer9_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x1450>;
+		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	elm_mod_ck: elm_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x1458>;
+		clocks = <&l4_div_ck>;
+	};
+
 	sha2md5_fck: sha2md5_fck {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1166,76 +1586,91 @@
 		reg = <0x1538>;
 	};
 
-	smartreflex_core_fck: smartreflex_core_fck {
+	slimbus2_mod_ck: slimbus2_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0638>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1538>;
+		clocks = <&slimbus2_fclk_0>;
 	};
 
-	smartreflex_iva_fck: smartreflex_iva_fck {
+	uart1_mod_ck: uart1_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0630>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1540>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	smartreflex_mpu_fck: smartreflex_mpu_fck {
+	uart2_mod_ck: uart2_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0628>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1548>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm10_mux: cm2_dm10_mux {
+	uart3_mod_ck: uart3_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1428>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1550>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm11_mux: cm2_dm11_mux {
+	uart4_mod_ck: uart4_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1430>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1558>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm2_mux: cm2_dm2_mux {
+	mmc5_mod_ck: mmc5_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1438>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1560>;
+		clocks = <&func_48m_fclk>;
 	};
 
-	cm2_dm3_mux: cm2_dm3_mux {
+	smartreflex_core_fck: smartreflex_core_fck {
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
 
-	cm2_dm4_mux: cm2_dm4_mux {
+	smartreflex_core_mod_ck: smartreflex_core_mod_ck {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1448>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0638>;
+		clocks = <&smartreflex_core_fck>;
 	};
 
-	cm2_dm9_mux: cm2_dm9_mux {
+	smartreflex_iva_fck: smartreflex_iva_fck {
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
+	smartreflex_iva_mod_ck: smartreflex_iva_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0630>;
+		clocks = <&smartreflex_iva_fck>;
+	};
+
+	smartreflex_mpu_fck: smartreflex_mpu_fck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_wkup_clk_mux_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x0628>;
+	};
+
+	smartreflex_mpu_mod_ck: smartreflex_mpu_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x0628>;
+		clocks = <&smartreflex_mpu_fck>;
 	};
 
 	usb_host_fs_fck: usb_host_fs_fck {
@@ -1246,6 +1681,13 @@
 		reg = <0x13d0>;
 	};
 
+	usb_host_fs_mod_ck: usb_host_fs_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x13d0>;
+		clocks = <&usb_host_fs_fck>;
+	};
+
 	utmi_p1_gfclk: utmi_p1_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1262,6 +1704,13 @@
 		reg = <0x1358>;
 	};
 
+	usb_host_hs_mod_ck: usb_host_hs_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x1358>;
+		clocks = <&usb_host_hs_fck>;
+	};
+
 	utmi_p2_gfclk: utmi_p2_gfclk {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1342,6 +1791,13 @@
 		reg = <0x1360>;
 	};
 
+	usb_otg_hs_mod_ck: usb_otg_hs_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1360>;
+		clocks = <&usb_otg_hs_ick>;
+	};
+
 	usb_otg_hs_xclk: usb_otg_hs_xclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1366,6 +1822,139 @@
 		reg = <0x0640>;
 	};
 
+	l3_main_1_mod_ck: l3_main_1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0720>;
+		clocks = <&l3_div_ck>;
+	};
+
+	l3_main_2_mod_ck: l3_main_2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0820>;
+		clocks = <&l3_div_ck>;
+	};
+
+	gpmc_mod_ck: gpmc_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0828>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ocmc_ram_mod_ck: ocmc_ram_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0830>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ipu_mod_ck: ipu_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0920>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
+	mmu_ipu_mod_ck: mmu_ipu_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0920>;
+		clocks = <&ducati_clk_mux_ck>;
+	};
+
+	dma_system_mod_ck: dma_system_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0a20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	dmm_mod_ck: dmm_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0b20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	emif1_mod_ck: emif1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b30>;
+		clocks = <&ddrphy_ck>;
+	};
+
+	emif2_mod_ck: emif2_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0b38>;
+		clocks = <&ddrphy_ck>;
+	};
+
+	c2c_mod_ck: c2c_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0c20>;
+		clocks = <&div_core_ck>;
+	};
+
+	l4_cfg_mod_ck: l4_cfg_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d20>;
+		clocks = <&l4_div_ck>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d28>;
+		clocks = <&l4_div_ck>;
+	};
+
+	mailbox_mod_ck: mailbox_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x0d30>;
+		clocks = <&l4_div_ck>;
+	};
+
+	l3_main_3_mod_ck: l3_main_3_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e20>;
+		clocks = <&l3_div_ck>;
+	};
+
+	l3_instr_mod_ck: l3_instr_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e28>;
+		clocks = <&l3_div_ck>;
+	};
+
+	ocp_wp_noc_mod_ck: ocp_wp_noc_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0e40>;
+		clocks = <&l3_div_ck>;
+	};
+
+	iva_mod_ck: iva_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0f20>;
+		clocks = <&dpll_iva_m5x2_ck>;
+	};
+
+	sl2if_mod_ck: sl2if_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x0f28>;
+		clocks = <&dpll_iva_m5x2_ck>;
+	};
+
 	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1397,12 +1986,110 @@
 		ti,bit-shift = <0>;
 		reg = <0x1368>;
 	};
+
+	usb_tll_hs_mod_ck: usb_tll_hs_mod_ck {
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
 
@@ -1641,3 +2328,24 @@
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

