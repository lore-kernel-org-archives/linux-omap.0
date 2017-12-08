From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 15/20] ARM: dts: omap5: add clkctrl nodes
Date: Fri, 8 Dec 2017 17:17:28 +0200
Message-ID: <1512746251-20123-3-git-send-email-t-kristo@ti.com>
References: <1512746251-20123-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512746251-20123-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for OMAP5 SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

This patch also removes any obsolete clock nodes, and reroutes all users
for these to use the new clkctrl clocks instead.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi           |  30 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 623 +++++++++++----------------------
 2 files changed, 222 insertions(+), 431 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b0992b8..4bc5225 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/clock/omap5.h>
 
 / {
 	#address-cells = <2>;
@@ -744,7 +745,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
-			clocks = <&timer1_gfclk_mux>;
+			clocks = <&wkupaon_clkctrl OMAP5_TIMER1_CLKCTRL 24>;
 			clock-names = "fck";
 		};
 
@@ -905,7 +906,8 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
 				syscon-phy-power = <&scm_conf 0x300>;
-				clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
+				clocks = <&usb_phy_cm_clk32k>,
+					 <&l3init_clkctrl OMAP5_USB_OTG_SS_CLKCTRL 8>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
 			};
@@ -919,7 +921,7 @@
 				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy_cm_clk32k>,
 					 <&sys_clkin>,
-					 <&usb_otg_ss_refclk960m>;
+					 <&l3init_clkctrl OMAP5_USB_OTG_SS_CLKCTRL 8>;
 				clock-names =	"wkupclk",
 						"sysclk",
 						"refclk";
@@ -987,7 +989,8 @@
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				syscon-phy-power = <&scm_conf 0x374>;
-				clocks = <&sys_clkin>, <&sata_ref_clk>;
+				clocks = <&sys_clkin>,
+					 <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
 				clock-names = "sysclk", "refclk";
 				#phy-cells = <0>;
 			};
@@ -999,7 +1002,7 @@
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&sata_phy>;
 			phy-names = "sata-phy";
-			clocks = <&sata_ref_clk>;
+			clocks = <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
 			ti,hwmods = "sata";
 			ports-implemented = <0x1>;
 		};
@@ -1009,7 +1012,7 @@
 			reg = <0x58000000 0x80>;
 			status = "disabled";
 			ti,hwmods = "dss_core";
-			clocks = <&dss_dss_clk>;
+			clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 8>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1020,7 +1023,7 @@
 				reg = <0x58001000 0x1000>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				ti,hwmods = "dss_dispc";
-				clocks = <&dss_dss_clk>;
+				clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 8>;
 				clock-names = "fck";
 			};
 
@@ -1029,7 +1032,7 @@
 				reg = <0x58002000 0x100>;
 				status = "disabled";
 				ti,hwmods = "dss_rfbi";
-				clocks = <&dss_dss_clk>, <&l3_iclk_div>;
+				clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 8>, <&l3_iclk_div>;
 				clock-names = "fck", "ick";
 			};
 
@@ -1042,7 +1045,8 @@
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi1";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 8>,
+					 <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 			};
 
@@ -1055,7 +1059,8 @@
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_dsi2";
-				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 8>,
+					 <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 			};
 
@@ -1069,7 +1074,8 @@
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_hdmi";
-				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
+				clocks = <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 9>,
+					 <&dss_clkctrl OMAP5_DSS_CORE_CLKCTRL 10>;
 				clock-names = "fck", "sys_clk";
 				dmas = <&sdma 76>;
 				dma-names = "audio_tx";
@@ -1143,7 +1149,7 @@
 	coefficients = <65 (-1791)>;
 };
 
-/include/ "omap54xx-clocks.dtsi"
+#include "omap54xx-clocks.dtsi"
 
 &gpu_thermal {
 	coefficients = <117 (-2992)>;
diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 5291934..9619a74 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -432,22 +432,6 @@
 		reg = <0x0528>;
 	};
 
-	dmic_sync_mux_ck: dmic_sync_mux_ck@538 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
-		ti,bit-shift = <26>;
-		reg = <0x0538>;
-	};
-
-	dmic_gfclk: dmic_gfclk@538 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0538>;
-	};
-
 	mcasp_sync_mux_ck: mcasp_sync_mux_ck@540 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -464,86 +448,6 @@
 		reg = <0x0540>;
 	};
 
-	mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@548 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
-		ti,bit-shift = <26>;
-		reg = <0x0548>;
-	};
-
-	mcbsp1_gfclk: mcbsp1_gfclk@548 {
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
-		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
-		ti,bit-shift = <26>;
-		reg = <0x0550>;
-	};
-
-	mcbsp2_gfclk: mcbsp2_gfclk@550 {
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
-		clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
-		ti,bit-shift = <26>;
-		reg = <0x0558>;
-	};
-
-	mcbsp3_gfclk: mcbsp3_gfclk@558 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0558>;
-	};
-
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
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0580>;
-	};
-
 	dummy_ck: dummy_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -603,23 +507,8 @@
 		clock-mult = <1>;
 		clock-div = <1>;
 	};
-
-	gpio1_dbclk: gpio1_dbclk@1938 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1938>;
-	};
-
-	timer1_gfclk_mux: timer1_gfclk_mux@1940 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1940>;
-	};
 };
+
 &cm_core_clocks {
 
 	dpll_per_byp_mux: dpll_per_byp_mux@14c {
@@ -825,95 +714,6 @@
 		ti,dividers = <1>, <8>;
 	};
 
-	dss_32khz_clk: dss_32khz_clk@1420 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <11>;
-		reg = <0x1420>;
-	};
-
-	dss_48mhz_clk: dss_48mhz_clk@1420 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48m_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1420>;
-	};
-
-	dss_dss_clk: dss_dss_clk@1420 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_h12x2_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1420>;
-		ti,set-rate-parent;
-	};
-
-	dss_sys_clk: dss_sys_clk@1420 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dss_syc_gfclk_div>;
-		ti,bit-shift = <10>;
-		reg = <0x1420>;
-	};
-
-	gpio2_dbclk: gpio2_dbclk@1060 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1060>;
-	};
-
-	gpio3_dbclk: gpio3_dbclk@1068 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1068>;
-	};
-
-	gpio4_dbclk: gpio4_dbclk@1070 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1070>;
-	};
-
-	gpio5_dbclk: gpio5_dbclk@1078 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1078>;
-	};
-
-	gpio6_dbclk: gpio6_dbclk@1080 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1080>;
-	};
-
-	gpio7_dbclk: gpio7_dbclk@1110 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1110>;
-	};
-
-	gpio8_dbclk: gpio8_dbclk@1118 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1118>;
-	};
-
 	iss_ctrlclk: iss_ctrlclk@1320 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -938,118 +738,6 @@
 		reg = <0x0f20>;
 	};
 
-	mmc1_32khz_clk: mmc1_32khz_clk@1628 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1628>;
-	};
-
-	sata_ref_clk: sata_ref_clk@1688 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_clkin>;
-		ti,bit-shift = <8>;
-		reg = <0x1688>;
-	};
-
-	usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_m2_ck>;
-		ti,bit-shift = <13>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_m2_ck>;
-		ti,bit-shift = <14>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_hsic480m_p3_clk: usb_host_hs_hsic480m_p3_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_m2_ck>;
-		ti,bit-shift = <7>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <11>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <12>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_hsic60m_p3_clk: usb_host_hs_hsic60m_p3_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <6>;
-		reg = <0x1658>;
-	};
-
-	utmi_p1_gfclk: utmi_p1_gfclk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&l3init_60m_fclk>, <&xclk60mhsp1_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&utmi_p1_gfclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1658>;
-	};
-
-	utmi_p2_gfclk: utmi_p2_gfclk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&l3init_60m_fclk>, <&xclk60mhsp2_ck>;
-		ti,bit-shift = <25>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&utmi_p2_gfclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1658>;
-	};
-
-	usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@1658 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <10>;
-		reg = <0x1658>;
-	};
-
-	usb_otg_ss_refclk960m: usb_otg_ss_refclk960m@16f0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_usb_clkdcoldo>;
-		ti,bit-shift = <8>;
-		reg = <0x16f0>;
-	};
-
 	usb_phy_cm_clk32k: usb_phy_cm_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1058,30 +746,6 @@
 		reg = <0x0640>;
 	};
 
-	usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@1668 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1668>;
-	};
-
-	usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@1668 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1668>;
-	};
-
-	usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@1668 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_60m_fclk>;
-		ti,bit-shift = <10>;
-		reg = <0x1668>;
-	};
-
 	fdif_fclk: fdif_fclk@1328 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1115,88 +779,6 @@
 		ti,max-div = <2>;
 		reg = <0x1638>;
 	};
-
-	mmc1_fclk_mux: mmc1_fclk_mux@1628 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1628>;
-	};
-
-	mmc1_fclk: mmc1_fclk@1628 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc1_fclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <2>;
-		reg = <0x1628>;
-	};
-
-	mmc2_fclk_mux: mmc2_fclk_mux@1630 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1630>;
-	};
-
-	mmc2_fclk: mmc2_fclk@1630 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc2_fclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <2>;
-		reg = <0x1630>;
-	};
-
-	timer10_gfclk_mux: timer10_gfclk_mux@1028 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1028>;
-	};
-
-	timer11_gfclk_mux: timer11_gfclk_mux@1030 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1030>;
-	};
-
-	timer2_gfclk_mux: timer2_gfclk_mux@1038 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1038>;
-	};
-
-	timer3_gfclk_mux: timer3_gfclk_mux@1040 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1040>;
-	};
-
-	timer4_gfclk_mux: timer4_gfclk_mux@1048 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1048>;
-	};
-
-	timer9_gfclk_mux: timer9_gfclk_mux@1050 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin>, <&sys_32k_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1050>;
-	};
 };
 
 &cm_core_clockdomains {
@@ -1394,3 +976,206 @@
 		reg = <0x021c>;
 	};
 };
+
+&cm_core_aon {
+	mpu_cm: mpu_cm@300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x300 0x100>;
+
+		mpu_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	dsp_cm: dsp_cm@400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x400 0x100>;
+
+		dsp_clkctrl: clk@20 {
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
+			reg = <0x20 0x64>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&cm_core {
+	l3main1_cm: l3main1_cm@700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x700 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x700 0x100>;
+
+		l3main1_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3main2_cm: l3main2_cm@800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x800 0x100>;
+
+		l3main2_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	ipu_cm: ipu_cm@900 {
+		compatible = "ti,omap4-cm";
+		reg = <0x900 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x900 0x100>;
+
+		ipu_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	dma_cm: dma_cm@a00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xa00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xa00 0x100>;
+
+		dma_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	emif_cm: emif_cm@b00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xb00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xb00 0x100>;
+
+		emif_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4cfg_cm: l4cfg_cm@d00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xd00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xd00 0x100>;
+
+		l4cfg_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3instr_cm: l3instr_cm@e00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xe00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xe00 0x100>;
+
+		l3instr_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4per_cm: l4per_cm@1000 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1000 0x200>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1000 0x200>;
+
+		l4per_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x15c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	dss_cm: dss_cm@1400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1400 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1400 0x100>;
+
+		dss_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3init_cm: l3init_cm@1600 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1600 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1600 0x100>;
+
+		l3init_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xd4>;
+			#clock-cells = <2>;
+		};
+	};
+};
+
+&prm {
+	wkupaon_cm: wkupaon_cm@1900 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1900 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1900 0x100>;
+
+		wkupaon_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x5c>;
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
