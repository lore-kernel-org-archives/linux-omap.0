From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [RFC PATCH] ARM: dts: DRA74X: Move common pinctrl definitions to
 common header
Date: Fri, 01 Apr 2016 13:44:50 +0100
Message-ID: <1459514690.11664.1.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The I2C{1,2}, MCSPI{1,2}, UART{1,2}, QSPI1, USB{1,2}, RGMII
and ATL functions can each be wired in only one way.  Reduce
duplication by defining that in dra74x.dtsi.

Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |  50 +---------
 arch/arm/boot/dts/dra7-evm.dts          | 142 +-------------------------
 arch/arm/boot/dts/dra74x.dtsi           | 171 ++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 189 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 0a5fc5d02ce2..5b9af94c7a7f 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -190,13 +190,6 @@
 		>;
 	};
 
-	i2c1_pins_default: i2c1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda.sda */
-			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl.scl */
-		>;
-	};
-
 	hdmi_pins: pinmux_hdmi_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
@@ -245,39 +238,6 @@
 		>;
 	};
 
-	cpsw_pins_default: cpsw_pins_default {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
-			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
-			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
-			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
-			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
-			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
-			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
-			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
-			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
-			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
-			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
-			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
-
-			/* Slave 2 */
-			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
-			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
-			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
-			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
-			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
-			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
-			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
-			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
-			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
-			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
-			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
-		>;
-
-	};
-
 	cpsw_pins_sleep: cpsw_pins_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 */
@@ -343,12 +303,6 @@
 		>;
 	};
 
-	usb1_pins: pinmux_usb1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
-		>;
-	};
-
 	extcon_usb1_pins: extcon_usb1_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_rtsn.gpio7_25 */
@@ -397,7 +351,7 @@
 &i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_default>;
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
 	tps659038: tps659038@58 {
@@ -642,7 +596,7 @@
 &mac {
 	status = "okay";
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_pins_default>;
+	pinctrl-0 = <&cpsw_pins_rgmii>;
 	pinctrl-1 = <&cpsw_pins_sleep>;
 	dual_emac;
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d9b87236019d..4689c6044f97 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -158,20 +158,6 @@
 		>;
 	};
 
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda */
-			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl */
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
-			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
-		>;
-	};
-
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3688, PIN_INPUT | MUX_MODE9) /* gpio6_14.i2c3_sda */
@@ -179,44 +165,6 @@
 		>;
 	};
 
-	mcspi1_pins: pinmux_mcspi1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37a4, PIN_INPUT | MUX_MODE0) /* spi1_sclk */
-			DRA7XX_CORE_IOPAD(0x37a8, PIN_INPUT | MUX_MODE0) /* spi1_d1 */
-			DRA7XX_CORE_IOPAD(0x37ac, PIN_INPUT | MUX_MODE0) /* spi1_d0 */
-			DRA7XX_CORE_IOPAD(0x37b0, PIN_INPUT_SLEW | MUX_MODE0) /* spi1_cs0 */
-			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs2.hdmi1_hpd */
-			DRA7XX_CORE_IOPAD(0x37bc, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs3.hdmi1_cec */
-		>;
-	};
-
-	mcspi2_pins: pinmux_mcspi2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37c0, PIN_INPUT | MUX_MODE0) /* spi2_sclk */
-			DRA7XX_CORE_IOPAD(0x37c4, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			DRA7XX_CORE_IOPAD(0x37cc, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_cs0 */
-		>;
-	};
-
-	uart1_pins: pinmux_uart1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37e0, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_rxd */
-			DRA7XX_CORE_IOPAD(0x37e4, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_txd */
-			DRA7XX_CORE_IOPAD(0x37e8, PIN_INPUT | MUX_MODE3) /* uart1_ctsn */
-			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT | MUX_MODE3) /* uart1_rtsn */
-		>;
-	};
-
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37f0, PIN_INPUT | MUX_MODE0) /* uart2_rxd */
-			DRA7XX_CORE_IOPAD(0x37f4, PIN_INPUT | MUX_MODE0) /* uart2_txd */
-			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT | MUX_MODE0) /* uart2_ctsn */
-			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT | MUX_MODE0) /* uart2_rtsn */
-		>;
-	};
-
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3648, PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd */
@@ -224,33 +172,6 @@
 		>;
 	};
 
-	qspi1_pins: pinmux_qspi1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x344c, PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
-			DRA7XX_CORE_IOPAD(0x3450, PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
-			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
-			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
-			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
-			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
-			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
-			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
-			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
-			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
-		>;
-	};
-
-	usb1_pins: pinmux_usb1_pins {
-                pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
-                >;
-        };
-
-	usb2_pins: pinmux_usb2_pins {
-                pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3684, PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
-                >;
-        };
-
 	nand_flash_x16: nand_flash_x16 {
 		/* On DRA7 EVM, GPMC_WPN and NAND_BOOTn comes from DIP switch
 		 * So NAND flash requires following switch settings:
@@ -282,39 +203,6 @@
 		>;
 	};
 
-	cpsw_default: cpsw_default {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txc.rgmii0_txc */
-			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txctl.rgmii0_txctl */
-			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3.rgmii0_txd3 */
-			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd2.rgmii0_txd2 */
-			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd1.rgmii0_txd1 */
-			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd0.rgmii0_txd0 */
-			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxc.rgmii0_rxc */
-			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxctl.rgmii0_rxctl */
-			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd3.rgmii0_rxd3 */
-			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd2.rgmii0_rxd2 */
-			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd1.rgmii0_rxd1 */
-			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd0.rgmii0_rxd0 */
-
-			/* Slave 2 */
-			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
-			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
-			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
-			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
-			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
-			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
-			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
-			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
-			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
-			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
-			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
-		>;
-
-	};
-
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 */
@@ -375,13 +263,6 @@
 		>;
 	};
 
-	atl_pins: pinmux_atl_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3698, PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
-			DRA7XX_CORE_IOPAD(0x369c, PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
-		>;
-	};
-
 	mcasp3_pins: pinmux_mcasp3_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3724, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_aclkx */
@@ -403,8 +284,6 @@
 
 &i2c1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
 	tps659038: tps659038@58 {
@@ -568,8 +447,6 @@
 
 &i2c2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
 
 	pcf_hdmi: gpio@26 {
@@ -596,28 +473,20 @@
 
 &mcspi1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi1_pins>;
 };
 
 &mcspi2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi2_pins>;
 };
 
 &uart1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 			      <&dra7_pmx_core 0x3e0>;
 };
 
 &uart2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
@@ -650,8 +519,6 @@
 
 &qspi {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi1_pins>;
 
 	spi-max-frequency = <48000000>;
 	m25p80@0 {
@@ -723,14 +590,10 @@
 
 &usb1 {
 	dr_mode = "peripheral";
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_pins>;
 };
 
 &usb2 {
 	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb2_pins>;
 };
 
 &elm {
@@ -836,7 +699,7 @@
 &mac {
 	status = "okay";
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_default>;
+	pinctrl-0 = <&cpsw_pins_rgmii>;
 	pinctrl-1 = <&cpsw_sleep>;
 	dual_emac;
 };
@@ -868,9 +731,6 @@
 };
 
 &atl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&atl_pins>;
-
 	assigned-clocks = <&abe_dpll_sys_clk_mux>,
 			  <&atl_gfclk_mux>,
 			  <&dpll_abe_ck>,
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 4220eeffc65a..998fa3b3bb01 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -103,6 +103,127 @@
 	};
 };
 
+&dra7_pmx_core {
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda */
+			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37a4, PIN_INPUT | MUX_MODE0) /* spi1_sclk */
+			DRA7XX_CORE_IOPAD(0x37a8, PIN_INPUT | MUX_MODE0) /* spi1_d1 */
+			DRA7XX_CORE_IOPAD(0x37ac, PIN_INPUT | MUX_MODE0) /* spi1_d0 */
+			DRA7XX_CORE_IOPAD(0x37b0, PIN_INPUT_SLEW | MUX_MODE0) /* spi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs2.hdmi1_hpd */
+			DRA7XX_CORE_IOPAD(0x37bc, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs3.hdmi1_cec */
+		>;
+	};
+
+	mcspi2_pins: pinmux_mcspi2_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37c0, PIN_INPUT | MUX_MODE0) /* spi2_sclk */
+			DRA7XX_CORE_IOPAD(0x37c4, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
+			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
+			DRA7XX_CORE_IOPAD(0x37cc, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_cs0 */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37e0, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_rxd */
+			DRA7XX_CORE_IOPAD(0x37e4, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_txd */
+			DRA7XX_CORE_IOPAD(0x37e8, PIN_INPUT | MUX_MODE3) /* uart1_ctsn */
+			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT | MUX_MODE3) /* uart1_rtsn */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37f0, PIN_INPUT | MUX_MODE0) /* uart2_rxd */
+			DRA7XX_CORE_IOPAD(0x37f4, PIN_INPUT | MUX_MODE0) /* uart2_txd */
+			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT | MUX_MODE0) /* uart2_ctsn */
+			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT | MUX_MODE0) /* uart2_rtsn */
+		>;
+	};
+
+	qspi1_pins: pinmux_qspi1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x344c, PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
+			DRA7XX_CORE_IOPAD(0x3450, PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
+			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
+			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
+			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
+			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
+			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
+			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
+			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
+		>;
+	};
+
+	usb1_pins: pinmux_usb1_pins {
+                pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+                >;
+        };
+
+	usb2_pins: pinmux_usb2_pins {
+                pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3684, PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
+                >;
+        };
+
+	cpsw_pins_rgmii: pinmux_cpsw_pins_rgmii {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txc.rgmii0_txc */
+			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txctl.rgmii0_txctl */
+			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3.rgmii0_txd3 */
+			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd2.rgmii0_txd2 */
+			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd1.rgmii0_txd1 */
+			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd0.rgmii0_txd0 */
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxc.rgmii0_rxc */
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxctl.rgmii0_rxctl */
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd3.rgmii0_rxd3 */
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd2.rgmii0_rxd2 */
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd1.rgmii0_rxd1 */
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd0.rgmii0_rxd0 */
+
+			/* Slave 2 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
+			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+		>;
+
+	};
+
+	atl_pins: pinmux_atl_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3698, PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
+			DRA7XX_CORE_IOPAD(0x369c, PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
+		>;
+	};
+};
+
 &dss {
 	reg = <0x58000000 0x80>,
 	      <0x58004054 0x4>,
@@ -131,6 +252,56 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+};
+
+&mcspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_pins>;
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
+
+&usb2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_pins>;
+};
+
+&atl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&atl_pins>;
+};
+
 &mailbox6 {
 	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
 		ti,mbox-tx = <6 2 2>;

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
