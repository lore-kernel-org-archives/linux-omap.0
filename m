From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 14/20] ARM: dts: omap4: add clkctrl nodes
Date: Fri, 8 Dec 2017 17:17:27 +0200
Message-ID: <1512746251-20123-2-git-send-email-t-kristo@ti.com>
References: <1512746251-20123-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512746251-20123-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

This patch also removes any obsolete clock nodes, and reroutes all users
for these to use the new clkctrl clocks instead.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi           |  24 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 895 +++++++++++----------------------
 2 files changed, 306 insertions(+), 613 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 787ea2a..e912639 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/clock/omap4.h>
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
@@ -683,7 +684,7 @@
 			reg-names = "sys", "gdd";
 			ti,hwmods = "hsi";
 
-			clocks = <&hsi_fck>;
+			clocks = <&l3_init_clkctrl OMAP4_HSI_CLKCTRL 0>;
 			clock-names = "hsi_fck";
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
@@ -982,7 +983,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
-			clocks = <&dmt1_clk_mux>;
+			clocks = <&l4_wkup_clkctrl OMAP4_TIMER1_CLKCTRL 24>;
 			clock-names = "fck";
 		};
 
@@ -1214,7 +1215,7 @@
 			reg = <0x58000000 0x80>;
 			status = "disabled";
 			ti,hwmods = "dss_core";
-			clocks = <&dss_dss_clk>;
+			clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1225,7 +1226,7 @@
 				reg = <0x58001000 0x1000>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				ti,hwmods = "dss_dispc";
-				clocks = <&dss_dss_clk>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>;
 				clock-names = "fck";
 			};
 
@@ -1234,7 +1235,7 @@
 				reg = <0x58002000 0x1000>;
 				status = "disabled";
 				ti,hwmods = "dss_rfbi";
-				clocks = <&dss_dss_clk>, <&l3_div_ck>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>, <&l3_div_ck>;
 				clock-names = "fck", "ick";
 			};
 
@@ -1243,7 +1244,7 @@
 				reg = <0x58003000 0x1000>;
 				status = "disabled";
 				ti,hwmods = "dss_venc";
-				clocks = <&dss_tv_clk>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 11>;
 				clock-names = "fck";
 			};
 
@@ -1256,7 +1257,8 @@
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi1";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 			};
 
@@ -1269,7 +1271,8 @@
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi2";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 			};
 
@@ -1283,7 +1286,8 @@
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_hdmi";
-				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
+				clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 9>,
+					 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 				dmas = <&sdma 76>;
 				dma-names = "audio_tx";
@@ -1292,4 +1296,4 @@
 	};
 };
 
-/include/ "omap44xx-clocks.dtsi"
+#include "omap44xx-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 05732ed..279ff2f 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -174,14 +174,6 @@
 		ti,index-power-of-two;
 	};
 
-	aess_fclk: aess_fclk@528 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&abe_clk>;
-		ti,bit-shift = <24>;
-		ti,max-div = <2>;
-		reg = <0x0528>;
-	};
 
 	dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@1f4 {
 		#clock-cells = <0>;
@@ -464,7 +456,7 @@
 	ocp_abe_iclk: ocp_abe_iclk@528 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
-		clocks = <&aess_fclk>;
+		clocks = <&abe_clkctrl OMAP4_AESS_CLKCTRL 24>;
 		ti,bit-shift = <24>;
 		reg = <0x0528>;
 		ti,dividers = <2>, <1>;
@@ -478,156 +470,13 @@
 		clock-div = <4>;
 	};
 
-	dmic_sync_mux_ck: dmic_sync_mux_ck@538 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
-		ti,bit-shift = <25>;
-		reg = <0x0538>;
-	};
-
-	func_dmic_abe_gfclk: func_dmic_abe_gfclk@538 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0538>;
-	};
-
-	mcasp_sync_mux_ck: mcasp_sync_mux_ck@540 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
-		ti,bit-shift = <25>;
-		reg = <0x0540>;
-	};
-
-	func_mcasp_abe_gfclk: func_mcasp_abe_gfclk@540 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcasp_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0540>;
-	};
-
-	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@548 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
-		ti,bit-shift = <25>;
-		reg = <0x0548>;
-	};
-
-	func_mcbsp1_gfclk: func_mcbsp1_gfclk@548 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcbsp1_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0548>;
-	};
-
-	mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@550 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
-		ti,bit-shift = <25>;
-		reg = <0x0550>;
-	};
-
-	func_mcbsp2_gfclk: func_mcbsp2_gfclk@550 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcbsp2_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0550>;
-	};
-
-	mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@558 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
-		ti,bit-shift = <25>;
-		reg = <0x0558>;
-	};
-
-	func_mcbsp3_gfclk: func_mcbsp3_gfclk@558 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0558>;
-	};
-
-	slimbus1_fclk_1: slimbus1_fclk_1@560 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_24m_clk>;
-		ti,bit-shift = <9>;
-		reg = <0x0560>;
-	};
-
-	slimbus1_fclk_0: slimbus1_fclk_0@560 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&abe_24m_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x0560>;
-	};
-
-	slimbus1_fclk_2: slimbus1_fclk_2@560 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&pad_clks_ck>;
-		ti,bit-shift = <10>;
-		reg = <0x0560>;
-	};
-
-	slimbus1_slimbus_clk: slimbus1_slimbus_clk@560 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&slimbus_clk>;
-		ti,bit-shift = <11>;
-		reg = <0x0560>;
-	};
-
-	timer5_sync_mux: timer5_sync_mux@568 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0568>;
-	};
-
-	timer6_sync_mux: timer6_sync_mux@570 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0570>;
-	};
-
-	timer7_sync_mux: timer7_sync_mux@578 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0578>;
-	};
-
-	timer8_sync_mux: timer8_sync_mux@580 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0580>;
-	};
-
 	dummy_ck: dummy_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <0>;
 	};
 };
+
 &prm_clocks {
 	sys_clkin_ck: sys_clkin_ck@110 {
 		#clock-cells = <0>;
@@ -675,22 +524,6 @@
 		ti,max-div = <2>;
 	};
 
-	gpio1_dbclk: gpio1_dbclk@1838 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1838>;
-	};
-
-	dmt1_clk_mux: dmt1_clk_mux@1840 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1840>;
-	};
-
 	usim_ck: usim_ck@1858 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -708,45 +541,10 @@
 		reg = <0x1858>;
 	};
 
-	pmd_stm_clock_mux_ck: pmd_stm_clock_mux_ck@1a20 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
-		ti,bit-shift = <20>;
-		reg = <0x1a20>;
-	};
-
-	pmd_trace_clk_mux_ck: pmd_trace_clk_mux_ck@1a20 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
-		ti,bit-shift = <22>;
-		reg = <0x1a20>;
-	};
-
-	stm_clk_div_ck: stm_clk_div_ck@1a20 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&pmd_stm_clock_mux_ck>;
-		ti,bit-shift = <27>;
-		ti,max-div = <64>;
-		reg = <0x1a20>;
-		ti,index-power-of-two;
-	};
-
-	trace_clk_div_div_ck: trace_clk_div_div_ck@1a20 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&pmd_trace_clk_mux_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1a20>;
-		ti,dividers = <0>, <1>, <2>, <0>, <4>;
-	};
-
 	trace_clk_div_ck: trace_clk_div_ck {
 		#clock-cells = <0>;
 		compatible = "ti,clkdm-gate-clock";
-		clocks = <&trace_clk_div_div_ck>;
+		clocks = <&emu_sys_clkctrl OMAP4_DEBUGSS_CLKCTRL 24>;
 	};
 };
 
@@ -975,155 +773,6 @@
 		ti,max-div = <2>;
 	};
 
-	dss_sys_clk: dss_sys_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&syc_clk_div_ck>;
-		ti,bit-shift = <10>;
-		reg = <0x1120>;
-	};
-
-	dss_tv_clk: dss_tv_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&extalt_clkin_ck>;
-		ti,bit-shift = <11>;
-		reg = <0x1120>;
-	};
-
-	dss_dss_clk: dss_dss_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m5x2_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1120>;
-		ti,set-rate-parent;
-	};
-
-	dss_48mhz_clk: dss_48mhz_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48mc_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1120>;
-	};
-
-	fdif_fck: fdif_fck@1028 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&dpll_per_m4x2_ck>;
-		ti,bit-shift = <24>;
-		ti,max-div = <4>;
-		reg = <0x1028>;
-		ti,index-power-of-two;
-	};
-
-	gpio2_dbclk: gpio2_dbclk@1460 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1460>;
-	};
-
-	gpio3_dbclk: gpio3_dbclk@1468 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1468>;
-	};
-
-	gpio4_dbclk: gpio4_dbclk@1470 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1470>;
-	};
-
-	gpio5_dbclk: gpio5_dbclk@1478 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1478>;
-	};
-
-	gpio6_dbclk: gpio6_dbclk@1480 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1480>;
-	};
-
-	sgx_clk_mux: sgx_clk_mux@1220 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dpll_core_m7x2_ck>, <&dpll_per_m7x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1220>;
-	};
-
-	hsi_fck: hsi_fck@1338 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		ti,max-div = <4>;
-		reg = <0x1338>;
-		ti,index-power-of-two;
-	};
-
-	iss_ctrlclk: iss_ctrlclk@1020 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_96m_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1020>;
-	};
-
-	mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck@14e0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_96m_fclk>, <&per_abe_nc_fclk>;
-		ti,bit-shift = <25>;
-		reg = <0x14e0>;
-	};
-
-	per_mcbsp4_gfclk: per_mcbsp4_gfclk@14e0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcbsp4_sync_mux_ck>, <&pad_clks_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x14e0>;
-	};
-
-	hsmmc1_fclk: hsmmc1_fclk@1328 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_64m_fclk>, <&func_96m_fclk>;
-		ti,bit-shift = <24>;
-		reg = <0x1328>;
-	};
-
-	hsmmc2_fclk: hsmmc2_fclk@1330 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_64m_fclk>, <&func_96m_fclk>;
-		ti,bit-shift = <24>;
-		reg = <0x1330>;
-	};
-
-	ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@13e0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48m_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x13e0>;
-	};
-
 	sha2md5_fck: sha2md5_fck@15c8 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1132,222 +781,6 @@
 		reg = <0x15c8>;
 	};
 
-	slimbus2_fclk_1: slimbus2_fclk_1@1538 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&per_abe_24m_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1538>;
-	};
-
-	slimbus2_fclk_0: slimbus2_fclk_0@1538 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_24mc_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1538>;
-	};
-
-	slimbus2_slimbus_clk: slimbus2_slimbus_clk@1538 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&pad_slimbus_core_clks_ck>;
-		ti,bit-shift = <10>;
-		reg = <0x1538>;
-	};
-
-	smartreflex_core_fck: smartreflex_core_fck@638 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0638>;
-	};
-
-	smartreflex_iva_fck: smartreflex_iva_fck@630 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0630>;
-	};
-
-	smartreflex_mpu_fck: smartreflex_mpu_fck@628 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_wkup_clk_mux_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0628>;
-	};
-
-	cm2_dm10_mux: cm2_dm10_mux@1428 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1428>;
-	};
-
-	cm2_dm11_mux: cm2_dm11_mux@1430 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1430>;
-	};
-
-	cm2_dm2_mux: cm2_dm2_mux@1438 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1438>;
-	};
-
-	cm2_dm3_mux: cm2_dm3_mux@1440 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1440>;
-	};
-
-	cm2_dm4_mux: cm2_dm4_mux@1448 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1448>;
-	};
-
-	cm2_dm9_mux: cm2_dm9_mux@1450 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1450>;
-	};
-
-	usb_host_fs_fck: usb_host_fs_fck@13d0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48mc_fclk>;
-		ti,bit-shift = <1>;
-		reg = <0x13d0>;
-	};
-
-	utmi_p1_gfclk: utmi_p1_gfclk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&init_60m_fclk>, <&xclk60mhsp1_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&utmi_p1_gfclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1358>;
-	};
-
-	utmi_p2_gfclk: utmi_p2_gfclk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&init_60m_fclk>, <&xclk60mhsp2_ck>;
-		ti,bit-shift = <25>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&utmi_p2_gfclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <10>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_m2_ck>;
-		ti,bit-shift = <13>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <11>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <12>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_m2_ck>;
-		ti,bit-shift = <14>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_func48mclk: usb_host_hs_func48mclk@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48mc_fclk>;
-		ti,bit-shift = <15>;
-		reg = <0x1358>;
-	};
-
-	usb_host_hs_fck: usb_host_hs_fck@1358 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <1>;
-		reg = <0x1358>;
-	};
-
-	otg_60m_gfclk: otg_60m_gfclk@1360 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&utmi_phy_clkout_ck>, <&xclk60motg_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1360>;
-	};
-
-	usb_otg_hs_xclk: usb_otg_hs_xclk@1360 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&otg_60m_gfclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1360>;
-	};
-
-	usb_otg_hs_ick: usb_otg_hs_ick@1360 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3_div_ck>;
-		ti,bit-shift = <0>;
-		reg = <0x1360>;
-	};
-
 	usb_phy_cm_clk32k: usb_phy_cm_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1355,44 +788,12 @@
 		ti,bit-shift = <8>;
 		reg = <0x0640>;
 	};
-
-	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@1368 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <10>;
-		reg = <0x1368>;
-	};
-
-	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@1368 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1368>;
-	};
-
-	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@1368 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&init_60m_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1368>;
-	};
-
-	usb_tll_hs_ick: usb_tll_hs_ick@1368 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l4_div_ck>;
-		ti,bit-shift = <0>;
-		reg = <0x1368>;
-	};
 };
 
 &cm2_clockdomains {
 	l3_init_clkdm: l3_init_clkdm {
 		compatible = "ti,clockdomain";
-		clocks = <&dpll_usb_ck>, <&usb_host_fs_fck>;
+		clocks = <&dpll_usb_ck>;
 	};
 };
 
@@ -1631,3 +1032,291 @@
 		reg = <0x0224>;
 	};
 };
+
+&cm1 {
+	mpuss_cm: mpuss_cm@300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x300 0x100>;
+
+		mpuss_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	tesla_cm: tesla_cm@400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x400 0x100>;
+
+		tesla_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	abe_cm: abe_cm@500 {
+		compatible = "ti,omap4-cm";
+		reg = <0x500 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x500 0x100>;
+
+		abe_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x6c>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&cm2 {
+	l4_ao_cm: l4_ao_cm@600 {
+		compatible = "ti,omap4-cm";
+		reg = <0x600 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x600 0x100>;
+
+		l4_ao_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_1_cm: l3_1_cm@700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x700 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x700 0x100>;
+
+		l3_1_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_2_cm: l3_2_cm@800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x800 0x100>;
+
+		l3_2_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	ducati_cm: ducati_cm@900 {
+		compatible = "ti,omap4-cm";
+		reg = <0x900 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x900 0x100>;
+
+		ducati_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_dma_cm: l3_dma_cm@a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xa00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xa00 0x100>;
+
+		l3_dma_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_emif_cm: l3_emif_cm@b00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xb00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xb00 0x100>;
+
+		l3_emif_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	d2d_cm: d2d_cm@c00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xc00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xc00 0x100>;
+
+		d2d_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_cfg_cm: l4_cfg_cm@d00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xd00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xd00 0x100>;
+
+		l4_cfg_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_instr_cm: l3_instr_cm@e00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xe00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xe00 0x100>;
+
+		l3_instr_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x24>;
+			#clock-cells = <2>;
+		};
+	};
+
+	ivahd_cm: ivahd_cm@f00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xf00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xf00 0x100>;
+
+		ivahd_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
+	iss_cm: iss_cm@1000 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1000 0x100>;
+
+		iss_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_dss_cm: l3_dss_cm@1100 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1100 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1100 0x100>;
+
+		l3_dss_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_gfx_cm: l3_gfx_cm@1200 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1200 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1200 0x100>;
+
+		l3_gfx_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3_init_cm: l3_init_cm@1300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1300 0x100>;
+
+		l3_init_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4_per_cm: l4_per_cm@1400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1400 0x200>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1400 0x200>;
+
+		l4_per_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x144>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&prm {
+	l4_wkup_cm: l4_wkup_cm@1800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1800 0x100>;
+
+		l4_wkup_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x5c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	emu_sys_cm: emu_sys_cm@1a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1a00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1a00 0x100>;
+
+		emu_sys_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+};
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
