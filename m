From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 24/30] ARM: dts: am43xx: add hwmod module clocks
Date: Mon, 11 Apr 2016 11:19:15 +0300
Message-ID: <1460362761-4842-25-git-send-email-t-kristo@ti.com>
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
 arch/arm/boot/dts/am43xx-clocks.dtsi |  746 ++++++++++++++++++++++++++++++----
 1 file changed, 676 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 34fecf2..62163a1 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -383,55 +383,6 @@
 		clock-frequency = <32768>;
 	};
 
-	timer1_fck: timer1_fck@4200 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>, <&clk_rc32k_ck>, <&clk_32768_ck>, <&clk_32k_tpm_ck>;
-		reg = <0x4200>;
-	};
-
-	timer2_fck: timer2_fck@4204 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x4204>;
-	};
-
-	timer3_fck: timer3_fck@4208 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x4208>;
-	};
-
-	timer4_fck: timer4_fck@420c {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x420c>;
-	};
-
-	timer5_fck: timer5_fck@4210 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x4210>;
-	};
-
-	timer6_fck: timer6_fck@4214 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x4214>;
-	};
-
-	timer7_fck: timer7_fck@4218 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
-		reg = <0x4218>;
-	};
-
 	wdt1_fck: wdt1_fck@422c {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -524,6 +475,13 @@
 		reg = <0x2b68>;
 	};
 
+	gpio1_mod_ck: gpio1_mod_ck@2b68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b68>;
+		clocks = <&sys_clkin_ck>;
+	};
+
 	gpio1_dbclk: gpio1_dbclk@8c78 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -532,6 +490,13 @@
 		reg = <0x8c78>;
 	};
 
+	gpio2_mod_ck: gpio2_mod_ck@8c78 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c78>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk@8c80 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -540,6 +505,13 @@
 		reg = <0x8c80>;
 	};
 
+	gpio3_mod_ck: gpio3_mod_ck@8c80 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c80>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio3_dbclk: gpio3_dbclk@8c88 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -548,6 +520,13 @@
 		reg = <0x8c88>;
 	};
 
+	gpio4_mod_ck: gpio4_mod_ck@8c88 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c88>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio4_dbclk: gpio4_dbclk@8c90 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -556,6 +535,13 @@
 		reg = <0x8c90>;
 	};
 
+	gpio5_mod_ck: gpio5_mod_ck@8c90 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c90>;
+		clocks = <&l4ls_gclk>;
+	};
+
 	gpio5_dbclk: gpio5_dbclk@8c98 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -564,6 +550,255 @@
 		reg = <0x8c98>;
 	};
 
+	gpio6_mod_ck: gpio6_mod_ck@8c98 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c98>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	hdq1w_mod_ck: hdq1w_mod_ck@8ca0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8ca0>;
+		clocks = <&func_12m_clk>;
+	};
+
+	i2c2_mod_ck: i2c2_mod_ck@8ca8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8ca8>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	i2c3_mod_ck: i2c3_mod_ck@8cb0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8cb0>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	mailbox_mod_ck: mailbox_mod_ck@8cb8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8cb8>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	mmc1_mod_ck: mmc1_mod_ck@8cc0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8cc0>;
+		clocks = <&mmc_clk>;
+	};
+
+	mmc2_mod_ck: mmc2_mod_ck@8cc8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8cc8>;
+		clocks = <&mmc_clk>;
+	};
+
+	spi0_mod_ck: spi0_mod_ck@8d00 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d00>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi1_mod_ck: spi1_mod_ck@8d08 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d08>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi2_mod_ck: spi2_mod_ck@8d10 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d10>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi3_mod_ck: spi3_mod_ck@8d18 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d18>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spi4_mod_ck: spi4_mod_ck@8d20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d20>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	spinlock_mod_ck: spinlock_mod_ck@8d28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d28>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	timer2_mod_ck: timer2_mod_ck@8d30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d30>, <0x4204>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer3_mod_ck: timer3_mod_ck@8d38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d38>, <0x4208>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer4_mod_ck: timer4_mod_ck@8d40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d40>, <0x420c>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer5_mod_ck: timer5_mod_ck@8d48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d48>, <0x4210>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer6_mod_ck: timer6_mod_ck@8d50 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d50>, <0x4214>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer7_mod_ck: timer7_mod_ck@8d58 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d58>, <0x4218>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>;
+	};
+
+	timer8_mod_ck: timer8_mod_ck@8d60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d60>, <0x421c>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>,
+			 <&clk_32k_tpm_ck>;
+	};
+
+	timer9_mod_ck: timer9_mod_ck@8d68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d68>, <0x4220>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>,
+			 <&clk_32k_tpm_ck>;
+	};
+
+	timer10_mod_ck: timer10_mod_ck@8d70 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d70>, <0x4224>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>,
+			 <&clk_32k_tpm_ck>;
+	};
+
+	timer11_mod_ck: timer11_mod_ck@8d78 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x8d78>, <0x4228>;
+		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>,
+			 <&clk_32k_tpm_ck>;
+	};
+
+	uart2_mod_ck: uart2_mod_ck@8d80 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d80>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart3_mod_ck: uart3_mod_ck@8d88 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d88>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart4_mod_ck: uart4_mod_ck@8d90 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d90>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart5_mod_ck: uart5_mod_ck@8d98 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8d98>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	uart6_mod_ck: uart6_mod_ck@8da0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8da0>;
+		clocks = <&dpll_per_m2_div4_ck>;
+	};
+
+	ocp2scp0_mod_ck: ocp2scp0_mod_ck@8db8 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8db8>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	ocp2scp1_mod_ck: ocp2scp1_mod_ck@8dc0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8dc0>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	emif_mod_ck: emif_mod_ck@8f20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8f20>;
+		clocks = <&dpll_ddr_m2_ck>;
+	};
+
+	dss_dispc_mod_ck: dss_dispc_mod_ck@9220 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x9220>;
+		clocks = <&disp_clk>;
+	};
+
+	dss_core_mod_ck: dss_core_mod_ck@9220 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x9220>;
+		clocks = <&disp_clk>;
+	};
+
+	dss_rfbi_mod_ck: dss_rfbi_mod_ck@9220 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-mod-clock";
+		reg = <0x9220>;
+		clocks = <&disp_clk>;
+	};
+
+	cpgmac0_mod_ck: cpgmac0_mod_ck@9320 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x9320>;
+		clocks = <&cpsw_125mhz_gclk>;
+	};
+
 	mmc_clk: mmc_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -629,40 +864,40 @@
 		reg = <0x2a30>;
 	};
 
-	timer8_fck: timer8_fck@421c {
+	counter_32k_mod_ck: counter_32k_mod_ck@2a30 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
-		reg = <0x421c>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2a30>;
+		clocks = <&synctimer_32kclk>;
 	};
 
-	timer9_fck: timer9_fck@4220 {
+	cpsw_50m_clkdiv: cpsw_50m_clkdiv {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
-		reg = <0x4220>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_core_m5_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
 	};
 
-	timer10_fck: timer10_fck@4224 {
+	adc_tsc_mod_ck: adc_tsc_mod_ck@2920 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
-		reg = <0x4224>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2920>;
+		clocks = <&adc_tsc_fck>;
 	};
 
-	timer11_fck: timer11_fck@4228 {
+	l4_wkup_mod_ck: l4_wkup_mod_ck@2a20 {
 		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&tclkin_ck>, <&sys_clkin_ck>, <&clkdiv32k_ick>, <&clk_32k_tpm_ck>;
-		reg = <0x4228>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2a20>;
+		clocks = <&sys_clkin_ck>;
 	};
 
-	cpsw_50m_clkdiv: cpsw_50m_clkdiv {
+	wkup_m3_mod_ck: wkup_m3_mod_ck@2a28 {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&dpll_core_m5_ck>;
-		clock-mult = <1>;
-		clock-div = <1>;
+		compatible = "ti,omap4-sw-no-idlest-mod-clock";
+		reg = <0x2a28>;
+		clocks = <&sys_clkin_ck>;
 	};
 
 	cpsw_5m_clkdiv: cpsw_5m_clkdiv {
@@ -740,6 +975,146 @@
 		reg = <0x4260>;
 	};
 
+	mpu_mod_ck: mpu_mod_ck@8320 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8320>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	gfx_mod_ck: gfx_mod_ck@8420 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8420>;
+		clocks = <&gfx_fck_div_ck>;
+	};
+
+	rtc_mod_ck: rtc_mod_ck@8520 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8520>;
+		clocks = <&clk_32768_ck>;
+	};
+
+	l3_main_mod_ck: l3_main_mod_ck@8820 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8820>;
+		clocks = <&l3_gclk>;
+	};
+
+	aes_mod_ck: aes_mod_ck@8828 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8828>;
+		clocks = <&aes0_fck>;
+	};
+
+	l3_instr_mod_ck: l3_instr_mod_ck@8840 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8840>;
+		clocks = <&l3_gclk>;
+	};
+
+	ocmcram_mod_ck: ocmcram_mod_ck@8850 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8850>;
+		clocks = <&l3_gclk>;
+	};
+
+	sham_mod_ck: sham_mod_ck@8858 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8858>;
+		clocks = <&l3_gclk>;
+	};
+
+	vpfe0_mod_ck: vpfe0_mod_ck@8868 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8868>;
+		clocks = <&l3_gclk>;
+	};
+
+	vpfe1_mod_ck: vpfe1_mod_ck@8870 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8870>;
+		clocks = <&l3_gclk>;
+	};
+
+	tpcc_mod_ck: tpcc_mod_ck@8878 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8878>;
+		clocks = <&l3_gclk>;
+	};
+
+	tptc0_mod_ck: tptc0_mod_ck@8880 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8880>;
+		clocks = <&l3_gclk>;
+	};
+
+	tptc1_mod_ck: tptc1_mod_ck@8888 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8888>;
+		clocks = <&l3_gclk>;
+	};
+
+	tptc2_mod_ck: tptc2_mod_ck@8890 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8890>;
+		clocks = <&l3_gclk>;
+	};
+
+	l4_hs_mod_ck: l4_hs_mod_ck@88a0 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x88a0>;
+		clocks = <&l4hs_gclk>;
+	};
+
+	gpmc_mod_ck: gpmc_mod_ck@8a20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a20>;
+		clocks = <&l3s_gclk>;
+	};
+
+	mcasp0_mod_ck: mcasp0_mod_ck@8a38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a38>;
+		clocks = <&mcasp0_fck>;
+	};
+
+	mcasp1_mod_ck: mcasp1_mod_ck@8a40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a40>;
+		clocks = <&mcasp1_fck>;
+	};
+
+	mmc3_mod_ck: mmc3_mod_ck@8a48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a48>;
+		clocks = <&mmc_clk>;
+	};
+
+	qspi_mod_ck: qspi_mod_ck@8a58 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a58>;
+		clocks = <&l3s_gclk>;
+	};
+
 	usb_phy0_always_on_clk32k: usb_phy0_always_on_clk32k@2a40 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -756,6 +1131,56 @@
 		reg = <0x2a48>;
 	};
 
+	timer1_mod_ck: timer1_mod_ck@2b28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x2b28>, <0x4200>;
+		clocks = <&sys_clkin_ck>, <&clkdiv32k_ick>, <&tclkin_ck>,
+			 <&clk_rc32k_ck>, <&clk_32768_ck>, <&clk_32k_tpm_ck>;
+	};
+
+	wd_timer2_mod_ck: wd_timer2_mod_ck@2b38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b38>;
+		clocks = <&wdt1_fck>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck@2b40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b40>;
+		clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+	};
+
+	uart1_mod_ck: uart1_mod_ck@2b48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b48>;
+		clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+	};
+
+	smartreflex0_mod_ck: smartreflex0_mod_ck@2b50 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b50>;
+		clocks = <&smartreflex0_fck>;
+	};
+
+	smartreflex1_mod_ck: smartreflex1_mod_ck@2b58 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b58>;
+		clocks = <&smartreflex1_fck>;
+	};
+
+	control_mod_ck: control_mod_ck@2b60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x2b60>;
+		clocks = <&sys_clkin_ck>;
+	};
+
 	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m@8a60 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -764,6 +1189,13 @@
 		reg = <0x8a60>;
 	};
 
+	usb_otg_ss0_mod_ck: usb_otg_ss0_mod_ck@8a60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a60>;
+		clocks = <&l3s_gclk>;
+	};
+
 	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@8a68 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -771,4 +1203,179 @@
 		ti,bit-shift = <8>;
 		reg = <0x8a68>;
 	};
+
+	usb_otg_ss1_mod_ck: usb_otg_ss1_mod_ck@8a68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8a68>;
+		clocks = <&l3s_gclk>;
+	};
+
+	pruss_mod_ck: pruss_mod_ck@8b20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8b20>;
+		clocks = <&pruss_ocp_gclk>;
+	};
+
+	l4_ls_mod_ck: l4_ls_mod_ck@8c20 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c20>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	d_can0_mod_ck: d_can0_mod_ck@8c28 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c28>;
+		clocks = <&dcan0_fck>;
+	};
+
+	d_can1_mod_ck: d_can1_mod_ck@8c30 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c30>;
+		clocks = <&dcan1_fck>;
+	};
+
+	epwmss0_mod_ck: epwmss0_mod_ck@8c38 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c38>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss1_mod_ck: epwmss1_mod_ck@8c40 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c40>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss2_mod_ck: epwmss2_mod_ck@8c48 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c48>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss3_mod_ck: epwmss3_mod_ck@8c50 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c50>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss4_mod_ck: epwmss4_mod_ck@8c58 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c58>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	epwmss5_mod_ck: epwmss5_mod_ck@8c60 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c60>;
+		clocks = <&l4ls_gclk>;
+	};
+
+	elm_mod_ck: elm_mod_ck@8c68 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x8c68>;
+		clocks = <&l4ls_gclk>;
+	};
+};
+
+&prcm_clockdomains {
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
+	dss_clkdm: dss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dss_rfbi_mod_ck>, <&dss_dispc_mod_ck>,
+			 <&dss_core_mod_ck>;
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
+	emif_clkdm: emif_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&emif_mod_ck>;
+	};
+
+	l4ls_clkdm: l4ls_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gpio2_mod_ck>, <&ocp2scp0_mod_ck>, <&d_can1_mod_ck>,
+			 <&d_can0_mod_ck>, <&uart2_mod_ck>, <&epwmss3_mod_ck>,
+			 <&gpio4_mod_ck>, <&spi0_mod_ck>, <&timer9_mod_ck>,
+			 <&i2c3_mod_ck>, <&timer5_mod_ck>, <&gpio5_mod_ck>,
+			 <&timer2_mod_ck>, <&uart4_mod_ck>, <&epwmss4_mod_ck>,
+			 <&spi2_mod_ck>, <&spi4_mod_ck>, <&mailbox_mod_ck>,
+			 <&epwmss5_mod_ck>, <&uart6_mod_ck>, <&elm_mod_ck>,
+			 <&spi3_mod_ck>, <&spi1_mod_ck>, <&epwmss1_mod_ck>,
+			 <&l4_ls_mod_ck>, <&uart5_mod_ck>, <&mmc1_mod_ck>,
+			 <&timer6_mod_ck>, <&timer3_mod_ck>, <&timer4_mod_ck>,
+			 <&i2c2_mod_ck>, <&mmc2_mod_ck>, <&gpio3_mod_ck>,
+			 <&timer10_mod_ck>, <&uart3_mod_ck>, <&timer7_mod_ck>,
+			 <&gpio6_mod_ck>, <&ocp2scp1_mod_ck>, <&epwmss0_mod_ck>,
+			 <&timer8_mod_ck>, <&epwmss2_mod_ck>,
+			 <&spinlock_mod_ck>, <&hdq1w_mod_ck>, <&timer11_mod_ck>;
+	};
+
+	gfx_l3_clkdm: gfx_l3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&gfx_mod_ck>;
+	};
+
+	l3s_tsc_clkdm: l3s_tsc_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&adc_tsc_mod_ck>;
+	};
+
+	l3s_clkdm: l3s_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&qspi_mod_ck>, <&gpmc_mod_ck>, <&mcasp0_mod_ck>,
+			 <&vpfe0_mod_ck>, <&mmc3_mod_ck>, <&vpfe1_mod_ck>,
+			 <&usb_otg_ss1_mod_ck>, <&usb_otg_ss0_mod_ck>,
+			 <&mcasp1_mod_ck>;
+	};
+
+	l4_wkup_clkdm: l4_wkup_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&uart1_mod_ck>, <&smartreflex0_mod_ck>,
+			 <&smartreflex1_mod_ck>, <&gpio1_mod_ck>,
+			 <&l4_wkup_mod_ck>, <&control_mod_ck>, <&timer1_mod_ck>,
+			 <&wd_timer2_mod_ck>, <&i2c1_mod_ck>;
+	};
+
+	l4_wkup_aon_clkdm: l4_wkup_aon_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&counter_32k_mod_ck>, <&wkup_m3_mod_ck>;
+	};
+
+	l3_clkdm: l3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&l3_main_mod_ck>, <&ocmcram_mod_ck>, <&aes_mod_ck>,
+			 <&sham_mod_ck>, <&l4_hs_mod_ck>, <&tpcc_mod_ck>,
+			 <&tptc0_mod_ck>, <&l3_instr_mod_ck>, <&tptc2_mod_ck>,
+			 <&tptc1_mod_ck>;
+	};
 };
-- 
1.7.9.5

