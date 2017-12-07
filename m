From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 16/20] ARM: dts: dra7: add clkctrl nodes
Date: Thu, 7 Dec 2017 10:46:49 +0200
Message-ID: <1512636413-25243-17-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for DRA7 SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

This patch also removes any obsolete clock nodes, and reroutes all users
for these to use the new clkctrl clocks instead.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi          |   4 +-
 arch/arm/boot/dts/dra7.dtsi                     |  65 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   4 +-
 arch/arm/boot/dts/dra72x.dtsi                   |   4 +-
 arch/arm/boot/dts/dra74x.dtsi                   |   6 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi            | 909 ++++++------------------
 7 files changed, 259 insertions(+), 735 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 49aeecd..16f4fa9 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -554,7 +554,7 @@
 
 &mcasp3 {
 	#sound-dai-cells = <0>;
-	assigned-clocks = <&mcasp3_ahclkx_mux>;
+	assigned-clocks = <&l4per_clkctrl 0x168 24>;
 	assigned-clock-parents = <&sys_clkin2>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index e088bb9..ec98c6e 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -204,7 +204,7 @@
 
 &atl {
 	assigned-clocks = <&abe_dpll_sys_clk_mux>,
-			  <&atl_gfclk_mux>,
+			  <&atl_clkctrl 0 26>,
 			  <&dpll_abe_ck>,
 			  <&dpll_abe_m2x2_ck>,
 			  <&atl_clkin2_ck>;
@@ -222,7 +222,7 @@
 &mcasp3 {
 	#sound-dai-cells = <0>;
 
-	assigned-clocks = <&mcasp3_ahclkx_mux>;
+	assigned-clocks = <&l4per_clkctrl 0x168 24>;
 	assigned-clock-parents = <&atl_clkin2_ck>;
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5e24cea..a76ccba 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -887,7 +887,7 @@
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
 			clock-names = "fck";
-			clocks = <&timer1_gfclk_mux>;
+			clocks = <&wkupaon_clkctrl 0x20 24>;
 		};
 
 		timer2: timer@48032000 {
@@ -1370,7 +1370,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-			clocks = <&qspi_gfclk_div>;
+			clocks = <&l4per_clkctrl 0x138 25>;
 			clock-names = "fck";
 			num-cs = <4>;
 			interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
@@ -1392,7 +1392,8 @@
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				syscon-phy-power = <&scm_conf 0x374>;
-				clocks = <&sys_clkin1>, <&sata_ref_clk>;
+				clocks = <&sys_clkin1>,
+					 <&l3init_clkctrl 0x68 8>;
 				clock-names = "sysclk", "refclk";
 				syscon-pllreset = <&scm_conf 0x3fc>;
 				#phy-cells = <0>;
@@ -1407,9 +1408,9 @@
 				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
-					 <&optfclk_pciephy1_32khz>,
-					 <&optfclk_pciephy1_clk>,
-					 <&optfclk_pciephy1_div_clk>,
+					 <&l3init_clkctrl 0x90 8>,
+					 <&l3init_clkctrl 0x90 9>,
+					 <&l3init_clkctrl 0x90 10>,
 					 <&optfclk_pciephy_div>,
 					 <&sys_clkin1>;
 				clock-names = "dpll_ref", "dpll_ref_m2",
@@ -1427,9 +1428,9 @@
 				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
-					 <&optfclk_pciephy2_32khz>,
-					 <&optfclk_pciephy2_clk>,
-					 <&optfclk_pciephy2_div_clk>,
+					 <&l3init_clkctrl 0x98 8>,
+					 <&l3init_clkctrl 0x98 9>,
+					 <&l3init_clkctrl 0x98 10>,
 					 <&optfclk_pciephy_div>,
 					 <&sys_clkin1>;
 				clock-names = "dpll_ref", "dpll_ref_m2",
@@ -1446,7 +1447,7 @@
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&sata_phy>;
 			phy-names = "sata-phy";
-			clocks = <&sata_ref_clk>;
+			clocks = <&l3init_clkctrl 0x68 8>;
 			ti,hwmods = "sata";
 			ports-implemented = <0x1>;
 		};
@@ -1474,7 +1475,7 @@
 				reg = <0x4a084000 0x400>;
 				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
-					 <&usb_otg_ss1_refclk960m>;
+					 <&l3init_clkctrl 0xd0 8>;
 				clock-names =	"wkupclk",
 						"refclk";
 				#phy-cells = <0>;
@@ -1486,7 +1487,7 @@
 				reg = <0x4a085000 0x400>;
 				syscon-phy-power = <&scm_conf 0xe74>;
 				clocks = <&usb_phy2_always_on_clk32k>,
-					 <&usb_otg_ss2_refclk960m>;
+					 <&l3init_clkctrl 0x20 8>;
 				clock-names =	"wkupclk",
 						"refclk";
 				#phy-cells = <0>;
@@ -1501,7 +1502,7 @@
 				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy3_always_on_clk32k>,
 					 <&sys_clkin1>,
-					 <&usb_otg_ss1_refclk960m>;
+					 <&l3init_clkctrl 0xd0 8>;
 				clock-names =	"wkupclk",
 						"sysclk",
 						"refclk";
@@ -1648,7 +1649,7 @@
 			ti,hwmods = "atl";
 			ti,provided-clocks = <&atl_clkin0_ck>, <&atl_clkin1_ck>,
 					     <&atl_clkin2_ck>, <&atl_clkin3_ck>;
-			clocks = <&atl_gfclk_mux>;
+			clocks = <&atl_clkctrl 0 26>;
 			clock-names = "fck";
 			status = "disabled";
 		};
@@ -1664,8 +1665,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 129 1>, <&edma_xbar 128 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp1_aux_gfclk_mux>, <&mcasp1_ahclkx_mux>,
-				 <&mcasp1_ahclkr_mux>;
+			clocks = <&ipu_clkctrl 0x10 22>, <&ipu_clkctrl 0x10 24>,
+				 <&ipu_clkctrl 0x10 28>;
 			clock-names = "fck", "ahclkx", "ahclkr";
 			status = "disabled";
 		};
@@ -1681,8 +1682,9 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 131 1>, <&edma_xbar 130 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp2_aux_gfclk_mux>, <&mcasp2_ahclkx_mux>,
-				 <&mcasp2_ahclkr_mux>;
+			clocks = <&l4per_clkctrl 0x160 22>,
+				 <&l4per_clkctrl 0x160 24>,
+				 <&l4per_clkctrl 0x160 28>;
 			clock-names = "fck", "ahclkx", "ahclkr";
 			status = "disabled";
 		};
@@ -1698,7 +1700,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 133 1>, <&edma_xbar 132 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x168 22>,
+				 <&l4per_clkctrl 0x168 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1714,7 +1717,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 135 1>, <&edma_xbar 134 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp4_aux_gfclk_mux>, <&mcasp4_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x198 22>,
+				 <&l4per_clkctrl 0x198 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1730,7 +1734,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 137 1>, <&edma_xbar 136 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp5_aux_gfclk_mux>, <&mcasp5_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x178 22>,
+				 <&l4per_clkctrl 0x178 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1746,7 +1751,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 139 1>, <&edma_xbar 138 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp6_aux_gfclk_mux>, <&mcasp6_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x204 22>,
+				 <&l4per_clkctrl 0x204 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1762,7 +1768,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 141 1>, <&edma_xbar 140 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp7_aux_gfclk_mux>, <&mcasp7_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x208 22>,
+				 <&l4per_clkctrl 0x208 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1778,7 +1785,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&edma_xbar 143 1>, <&edma_xbar 142 1>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp8_aux_gfclk_mux>, <&mcasp8_ahclkx_mux>;
+			clocks = <&l4per_clkctrl 0x190 22>,
+				 <&l4per_clkctrl 0x190 24>;
 			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
@@ -1800,7 +1808,7 @@
 		mac: ethernet@48484000 {
 			compatible = "ti,dra7-cpsw","ti,cpsw";
 			ti,hwmods = "gmac";
-			clocks = <&gmac_main_clk>, <&gmac_rft_clk_mux>;
+			clocks = <&gmac_main_clk>, <&l3init_clkctrl 0xb0 25>;
 			clock-names = "fck", "cpts";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
@@ -1870,7 +1878,7 @@
 			reg = <0x4ae3c000 0x2000>;
 			syscon-raminit = <&scm_conf 0x558 0>;
 			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dcan1_sys_clk_mux>;
+			clocks = <&wkupaon_clkctrl 0x68 24>;
 			status = "disabled";
 		};
 
@@ -1901,7 +1909,7 @@
 				reg = <0x58001000 0x1000>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				ti,hwmods = "dss_dispc";
-				clocks = <&dss_dss_clk>;
+				clocks = <&dss_clkctrl 0 8>;
 				clock-names = "fck";
 				/* CTRL_CORE_SMA_SW_1 */
 				syscon-pol = <&scm_conf 0x534>;
@@ -1917,7 +1925,8 @@
 				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 				ti,hwmods = "dss_hdmi";
-				clocks = <&dss_48mhz_clk>, <&dss_hdmi_clk>;
+				clocks = <&dss_clkctrl 0 9>,
+					 <&dss_clkctrl 0 10>;
 				clock-names = "fck", "sys_clk";
 			};
 		};
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2e485a1..adcbf7b 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -514,7 +514,7 @@
 
 &atl {
 	assigned-clocks = <&abe_dpll_sys_clk_mux>,
-			  <&atl_gfclk_mux>,
+			  <&atl_clkctrl 0 26>,
 			  <&dpll_abe_ck>,
 			  <&dpll_abe_m2x2_ck>,
 			  <&atl_clkin2_ck>;
@@ -532,7 +532,7 @@
 &mcasp3 {
 	#sound-dai-cells = <0>;
 
-	assigned-clocks = <&mcasp3_ahclkx_mux>;
+	assigned-clocks = <&l4per_clkctrl 0x168 24>;
 	assigned-clock-parents = <&atl_clkin2_ck>;
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 6710760..f654749 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -25,8 +25,8 @@
 	      <0x58004300 0x20>;
 	reg-names = "dss", "pll1_clkctrl", "pll1";
 
-	clocks = <&dss_dss_clk>,
-		 <&dss_video1_clk>;
+	clocks = <&dss_clkctrl 0 8>,
+		 <&dss_clkctrl 0 12>;
 	clock-names = "fck", "video1_clk";
 };
 
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 24e6746..c30d53b 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -93,9 +93,9 @@
 	reg-names = "dss", "pll1_clkctrl", "pll1",
 		    "pll2_clkctrl", "pll2";
 
-	clocks = <&dss_dss_clk>,
-		 <&dss_video1_clk>,
-		 <&dss_video2_clk>;
+	clocks = <&dss_clkctrl 0 8>,
+		 <&dss_clkctrl 0 12>,
+		 <&dss_clkctrl 0 13>;
 	clock-names = "fck", "video1_clk", "video2_clk";
 };
 
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index e62b628..8d1e604 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -11,25 +11,25 @@
 	atl_clkin0_ck: atl_clkin0_ck {
 		#clock-cells = <0>;
 		compatible = "ti,dra7-atl-clock";
-		clocks = <&atl_gfclk_mux>;
+		clocks = <&atl_clkctrl 0 26>;
 	};
 
 	atl_clkin1_ck: atl_clkin1_ck {
 		#clock-cells = <0>;
 		compatible = "ti,dra7-atl-clock";
-		clocks = <&atl_gfclk_mux>;
+		clocks = <&atl_clkctrl 0 26>;
 	};
 
 	atl_clkin2_ck: atl_clkin2_ck {
 		#clock-cells = <0>;
 		compatible = "ti,dra7-atl-clock";
-		clocks = <&atl_gfclk_mux>;
+		clocks = <&atl_clkctrl 0 26>;
 	};
 
 	atl_clkin3_ck: atl_clkin3_ck {
 		#clock-cells = <0>;
 		compatible = "ti,dra7-atl-clock";
-		clocks = <&atl_gfclk_mux>;
+		clocks = <&atl_clkctrl 0 26>;
 	};
 
 	hdmi_clkin_ck: hdmi_clkin_ck {
@@ -809,70 +809,6 @@
 		assigned-clock-parents = <&dpll_core_h22x2_ck>;
 	};
 
-	mcasp1_ahclkr_mux: mcasp1_ahclkr_mux@550 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <28>;
-		reg = <0x0550>;
-	};
-
-	mcasp1_ahclkx_mux: mcasp1_ahclkx_mux@550 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x0550>;
-	};
-
-	mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux@550 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x0550>;
-	};
-
-	timer5_gfclk_mux: timer5_gfclk_mux@558 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
-		ti,bit-shift = <24>;
-		reg = <0x0558>;
-	};
-
-	timer6_gfclk_mux: timer6_gfclk_mux@560 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
-		ti,bit-shift = <24>;
-		reg = <0x0560>;
-	};
-
-	timer7_gfclk_mux: timer7_gfclk_mux@568 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
-		ti,bit-shift = <24>;
-		reg = <0x0568>;
-	};
-
-	timer8_gfclk_mux: timer8_gfclk_mux@570 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
-		ti,bit-shift = <24>;
-		reg = <0x0570>;
-	};
-
-	uart6_gfclk_mux: uart6_gfclk_mux@580 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0580>;
-	};
-
 	dummy_ck: dummy_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -1188,39 +1124,8 @@
 		clocks = <&sys_clkin1>, <&abe_lp_clk_div>;
 		reg = <0x0108>;
 	};
-
-	gpio1_dbclk: gpio1_dbclk@1838 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1838>;
-	};
-
-	dcan1_sys_clk_mux: dcan1_sys_clk_mux@1888 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_clkin1>, <&sys_clkin2>;
-		ti,bit-shift = <24>;
-		reg = <0x1888>;
-	};
-
-	timer1_gfclk_mux: timer1_gfclk_mux@1840 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1840>;
-	};
-
-	uart10_gfclk_mux: uart10_gfclk_mux@1880 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1880>;
-	};
 };
+
 &cm_core_clocks {
 	dpll_pcie_ref_ck: dpll_pcie_ref_ck@200 {
 		#clock-cells = <0>;
@@ -1255,22 +1160,6 @@
 		reg = <0x021c>, <0x0220>;
 	};
 
-	optfclk_pciephy1_32khz: optfclk_pciephy1_32khz@4a0093b0 {
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		#clock-cells = <0>;
-		reg = <0x13b0>;
-		ti,bit-shift = <8>;
-	};
-
-	optfclk_pciephy2_32khz: optfclk_pciephy2_32khz@4a0093b8 {
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		#clock-cells = <0>;
-		reg = <0x13b8>;
-		ti,bit-shift = <8>;
-	};
-
 	optfclk_pciephy_div: optfclk_pciephy_div@4a00821c {
 		compatible = "ti,divider-clock";
 		clocks = <&apll_pcie_ck>;
@@ -1281,38 +1170,6 @@
 		ti,max-div = <2>;
 	};
 
-	optfclk_pciephy1_clk: optfclk_pciephy1_clk@4a0093b0 {
-		compatible = "ti,gate-clock";
-		clocks = <&apll_pcie_ck>;
-		#clock-cells = <0>;
-		reg = <0x13b0>;
-		ti,bit-shift = <9>;
-	};
-
-	optfclk_pciephy2_clk: optfclk_pciephy2_clk@4a0093b8 {
-		compatible = "ti,gate-clock";
-		clocks = <&apll_pcie_ck>;
-		#clock-cells = <0>;
-		reg = <0x13b8>;
-		ti,bit-shift = <9>;
-	};
-
-	optfclk_pciephy1_div_clk: optfclk_pciephy1_div_clk@4a0093b0 {
-		compatible = "ti,gate-clock";
-		clocks = <&optfclk_pciephy_div>;
-		#clock-cells = <0>;
-		reg = <0x13b0>;
-		ti,bit-shift = <10>;
-	};
-
-	optfclk_pciephy2_div_clk: optfclk_pciephy2_div_clk@4a0093b8 {
-		compatible = "ti,gate-clock";
-		clocks = <&optfclk_pciephy_div>;
-		#clock-cells = <0>;
-		reg = <0x13b8>;
-		ti,bit-shift = <10>;
-	};
-
 	apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
@@ -1541,167 +1398,6 @@
 		reg = <0x06c0>;
 	};
 
-	dss_32khz_clk: dss_32khz_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <11>;
-		reg = <0x1120>;
-	};
-
-	dss_48mhz_clk: dss_48mhz_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&func_48m_fclk>;
-		ti,bit-shift = <9>;
-		reg = <0x1120>;
-	};
-
-	dss_dss_clk: dss_dss_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_h12x2_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1120>;
-		ti,set-rate-parent;
-	};
-
-	dss_hdmi_clk: dss_hdmi_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&hdmi_dpll_clk_mux>;
-		ti,bit-shift = <10>;
-		reg = <0x1120>;
-	};
-
-	dss_video1_clk: dss_video1_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&video1_dpll_clk_mux>;
-		ti,bit-shift = <12>;
-		reg = <0x1120>;
-	};
-
-	dss_video2_clk: dss_video2_clk@1120 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&video2_dpll_clk_mux>;
-		ti,bit-shift = <13>;
-		reg = <0x1120>;
-	};
-
-	gpio2_dbclk: gpio2_dbclk@1760 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1760>;
-	};
-
-	gpio3_dbclk: gpio3_dbclk@1768 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1768>;
-	};
-
-	gpio4_dbclk: gpio4_dbclk@1770 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1770>;
-	};
-
-	gpio5_dbclk: gpio5_dbclk@1778 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1778>;
-	};
-
-	gpio6_dbclk: gpio6_dbclk@1780 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1780>;
-	};
-
-	gpio7_dbclk: gpio7_dbclk@1810 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1810>;
-	};
-
-	gpio8_dbclk: gpio8_dbclk@1818 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1818>;
-	};
-
-	mmc1_clk32k: mmc1_clk32k@1328 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1328>;
-	};
-
-	mmc2_clk32k: mmc2_clk32k@1330 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1330>;
-	};
-
-	mmc3_clk32k: mmc3_clk32k@1820 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1820>;
-	};
-
-	mmc4_clk32k: mmc4_clk32k@1828 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_32k_ck>;
-		ti,bit-shift = <8>;
-		reg = <0x1828>;
-	};
-
-	sata_ref_clk: sata_ref_clk@1388 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_clkin1>;
-		ti,bit-shift = <8>;
-		reg = <0x1388>;
-	};
-
-	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@13f0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_960m_gfclk>;
-		ti,bit-shift = <8>;
-		reg = <0x13f0>;
-	};
-
-	usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m@1340 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3init_960m_gfclk>;
-		ti,bit-shift = <8>;
-		reg = <0x1340>;
-	};
-
 	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k@640 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
@@ -1726,38 +1422,6 @@
 		reg = <0x0698>;
 	};
 
-	atl_dpll_clk_mux: atl_dpll_clk_mux@c00 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sys_32k_ck>, <&video1_clkin_ck>, <&video2_clkin_ck>, <&hdmi_clkin_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x0c00>;
-	};
-
-	atl_gfclk_mux: atl_gfclk_mux@c00 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&l3_iclk_div>, <&dpll_abe_m2_ck>, <&atl_dpll_clk_mux>;
-		ti,bit-shift = <26>;
-		reg = <0x0c00>;
-	};
-
-	rmii_50mhz_clk_mux: rmii_50mhz_clk_mux@13d0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dpll_gmac_h11x2_ck>, <&rmii_clk_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x13d0>;
-	};
-
-	gmac_rft_clk_mux: gmac_rft_clk_mux@13d0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&video1_clkin_ck>, <&video2_clkin_ck>, <&dpll_abe_m2_ck>, <&hdmi_clkin_ck>, <&l3_iclk_div>;
-		ti,bit-shift = <25>;
-		reg = <0x13d0>;
-	};
-
 	gpu_core_gclk_mux: gpu_core_gclk_mux@1220 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -1787,362 +1451,6 @@
 		ti,dividers = <8>, <16>, <32>;
 	};
 
-	mcasp2_ahclkr_mux: mcasp2_ahclkr_mux@1860 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <28>;
-		reg = <0x1860>;
-	};
-
-	mcasp2_ahclkx_mux: mcasp2_ahclkx_mux@1860 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1860>;
-	};
-
-	mcasp2_aux_gfclk_mux: mcasp2_aux_gfclk_mux@1860 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1860>;
-	};
-
-	mcasp3_ahclkx_mux: mcasp3_ahclkx_mux@1868 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1868>;
-		assigned-clocks = <&mcasp3_ahclkx_mux>;
-		assigned-clock-parents = <&abe_24m_fclk>;
-	};
-
-	mcasp3_aux_gfclk_mux: mcasp3_aux_gfclk_mux@1868 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1868>;
-	};
-
-	mcasp4_ahclkx_mux: mcasp4_ahclkx_mux@1898 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1898>;
-	};
-
-	mcasp4_aux_gfclk_mux: mcasp4_aux_gfclk_mux@1898 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1898>;
-	};
-
-	mcasp5_ahclkx_mux: mcasp5_ahclkx_mux@1878 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1878>;
-	};
-
-	mcasp5_aux_gfclk_mux: mcasp5_aux_gfclk_mux@1878 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1878>;
-	};
-
-	mcasp6_ahclkx_mux: mcasp6_ahclkx_mux@1904 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1904>;
-	};
-
-	mcasp6_aux_gfclk_mux: mcasp6_aux_gfclk_mux@1904 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1904>;
-	};
-
-	mcasp7_ahclkx_mux: mcasp7_ahclkx_mux@1908 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1908>;
-	};
-
-	mcasp7_aux_gfclk_mux: mcasp7_aux_gfclk_mux@1908 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <22>;
-		reg = <0x1908>;
-	};
-
-	mcasp8_ahclkx_mux: mcasp8_ahclkx_mux@1890 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <22>;
-		reg = <0x1890>;
-	};
-
-	mcasp8_aux_gfclk_mux: mcasp8_aux_gfclk_mux@1890 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
-		ti,bit-shift = <24>;
-		reg = <0x1890>;
-	};
-
-	mmc1_fclk_mux: mmc1_fclk_mux@1328 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1328>;
-	};
-
-	mmc1_fclk_div: mmc1_fclk_div@1328 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc1_fclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <4>;
-		reg = <0x1328>;
-		ti,index-power-of-two;
-	};
-
-	mmc2_fclk_mux: mmc2_fclk_mux@1330 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1330>;
-	};
-
-	mmc2_fclk_div: mmc2_fclk_div@1330 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc2_fclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <4>;
-		reg = <0x1330>;
-		ti,index-power-of-two;
-	};
-
-	mmc3_gfclk_mux: mmc3_gfclk_mux@1820 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1820>;
-	};
-
-	mmc3_gfclk_div: mmc3_gfclk_div@1820 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc3_gfclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <4>;
-		reg = <0x1820>;
-		ti,index-power-of-two;
-	};
-
-	mmc4_gfclk_mux: mmc4_gfclk_mux@1828 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1828>;
-	};
-
-	mmc4_gfclk_div: mmc4_gfclk_div@1828 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&mmc4_gfclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <4>;
-		reg = <0x1828>;
-		ti,index-power-of-two;
-	};
-
-	qspi_gfclk_mux: qspi_gfclk_mux@1838 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_128m_clk>, <&dpll_per_h13x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1838>;
-	};
-
-	qspi_gfclk_div: qspi_gfclk_div@1838 {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&qspi_gfclk_mux>;
-		ti,bit-shift = <25>;
-		ti,max-div = <4>;
-		reg = <0x1838>;
-		ti,index-power-of-two;
-	};
-
-	timer10_gfclk_mux: timer10_gfclk_mux@1728 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1728>;
-	};
-
-	timer11_gfclk_mux: timer11_gfclk_mux@1730 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1730>;
-	};
-
-	timer13_gfclk_mux: timer13_gfclk_mux@17c8 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x17c8>;
-	};
-
-	timer14_gfclk_mux: timer14_gfclk_mux@17d0 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x17d0>;
-	};
-
-	timer15_gfclk_mux: timer15_gfclk_mux@17d8 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x17d8>;
-	};
-
-	timer16_gfclk_mux: timer16_gfclk_mux@1830 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1830>;
-	};
-
-	timer2_gfclk_mux: timer2_gfclk_mux@1738 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1738>;
-	};
-
-	timer3_gfclk_mux: timer3_gfclk_mux@1740 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1740>;
-	};
-
-	timer4_gfclk_mux: timer4_gfclk_mux@1748 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1748>;
-	};
-
-	timer9_gfclk_mux: timer9_gfclk_mux@1750 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
-		ti,bit-shift = <24>;
-		reg = <0x1750>;
-	};
-
-	uart1_gfclk_mux: uart1_gfclk_mux@1840 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1840>;
-	};
-
-	uart2_gfclk_mux: uart2_gfclk_mux@1848 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1848>;
-	};
-
-	uart3_gfclk_mux: uart3_gfclk_mux@1850 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1850>;
-	};
-
-	uart4_gfclk_mux: uart4_gfclk_mux@1858 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1858>;
-	};
-
-	uart5_gfclk_mux: uart5_gfclk_mux@1870 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x1870>;
-	};
-
-	uart7_gfclk_mux: uart7_gfclk_mux@18d0 {
-		#clock-cells = <0>;
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
-	};
-
-	uart9_gfclk_mux: uart9_gfclk_mux@18e8 {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
-		ti,bit-shift = <24>;
-		reg = <0x18e8>;
-	};
-
 	vip1_gclk_mux: vip1_gclk_mux@1020 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -2216,3 +1524,210 @@
 		reg = <0x6c4>;
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
+	ipu_cm: ipu_cm@500 {
+		compatible = "ti,omap4-cm";
+		reg = <0x500 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x500 0x100>;
+
+		ipu_clkctrl: clk@40 {
+			compatible = "ti,clkctrl";
+			reg = <0x40 0x44>;
+			#clock-cells = <2>;
+		};
+	};
+
+	rtc_cm: rtc_cm@700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x700 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x700 0x100>;
+
+		rtc_clkctrl: clk@40 {
+			compatible = "ti,clkctrl";
+			reg = <0x40 0x8>;
+			#clock-cells = <2>;
+		};
+	};
+
+};
+
+&cm_core {
+	coreaon_cm: coreaon_cm@600 {
+		compatible = "ti,omap4-cm";
+		reg = <0x600 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x600 0x100>;
+
+		coreaon_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x1c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3main1_cm: l3main1_cm@700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x700 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x700 0x100>;
+
+		l3main1_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x74>;
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
+			reg = <0x20 0x4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	atl_cm: atl_cm@c00 {
+		compatible = "ti,omap4-cm";
+		reg = <0xc00 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xc00 0x100>;
+
+		atl_clkctrl: clk@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0x4>;
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
+			reg = <0x20 0x84>;
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
+	dss_cm: dss_cm@1100 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1100 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1100 0x100>;
+
+		dss_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x14>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l3init_cm: l3init_cm@1300 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1300 0x100>;
+
+		l3init_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0xd4>;
+			#clock-cells = <2>;
+		};
+	};
+
+	l4per_cm: l4per_cm@1700 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1700 0x300>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1700 0x300>;
+
+		l4per_clkctrl: clk@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0x20c>;
+			#clock-cells = <2>;
+
+			assigned-clocks = <&l4per_clkctrl 0x168 24>;
+			assigned-clock-parents = <&abe_24m_fclk>;
+		};
+	};
+
+};
+
+&prm {
+	wkupaon_cm: wkupaon_cm@1800 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1800 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1800 0x100>;
+
+		wkupaon_clkctrl: clk@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x6c>;
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
