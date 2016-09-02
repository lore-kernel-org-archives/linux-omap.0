From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/2] ARM: dts: am57xx-beagle-x15: Remove pinmux configurations for erratum i869
Date: Fri, 2 Sep 2016 12:14:44 -0500
Message-ID: <20160902171445.27757-2-nm@ti.com>
References: <20160902171445.27757-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160902171445.27757-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, robertcnelson@gmail.com, nsekhar@ti.com, jkridner@beagleboard.org, beagleboard-x15@googlegroups.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Pinmuxing for DRA7x/AM57x family of processors need to be done in IO
isolation as part of initial bootloader executed from SRAM. This is
done as part of iodelay configuration sequence and is required due
to the limitations introduced by erratum ID: i869[1] (IO Glitches
can occur when changing IO settings) and elaborated in the Technical
Reference Manual[2] 18.4.6.1.7 Isolation Requirements.

Only peripheral that is permitted for dynamic pin mux configuration
is MMC and DCAN. MMC is permitted to change to accommodate the
requirements for varied speeds (which require IO-delay support in
kernel as well). DCAN is a result of i893[1] (DCAN initialization
sequence). However, since we don't use DCAN on X15, with the exception
of MMC, all other pin mux configurations are removed from the dts.

[1] http://www.ti.com/lit/pdf/sprz429
[2] http://www.ti.com/lit/pdf/sprui30

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in v2:
	- renamed $subject to indicate we are not removing *every pinmux*
	- Update in commit message to encompass DCAN as well - for future
	  references as well

v1: https://patchwork.kernel.org/patch/9310615/

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 222 +-------------------------------
 1 file changed, 1 insertion(+), 221 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 9067ca092dc5..ef21da558ea3 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -59,8 +59,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>;
 
 		led0 {
 			label = "beagle-x15:usr0";
@@ -116,9 +114,6 @@
 	tpd12s015: encoder {
 		compatible = "ti,tpd12s015";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpd12s015_pins>;
-
 		gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
 			<&gpio6 28 GPIO_ACTIVE_HIGH>,	/* gpio6_28, LS OE */
 			<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
@@ -173,43 +168,6 @@
 };
 
 &dra7_pmx_core {
-	leds_pins_default: leds_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37a8, PIN_OUTPUT | MUX_MODE14)	/* spi1_d1.gpio7_8 */
-			DRA7XX_CORE_IOPAD(0x37ac, PIN_OUTPUT | MUX_MODE14)	/* spi1_d0.gpio7_9 */
-			DRA7XX_CORE_IOPAD(0x37c0, PIN_OUTPUT | MUX_MODE14)	/* spi2_sclk.gpio7_14 */
-			DRA7XX_CORE_IOPAD(0x37c4, PIN_OUTPUT | MUX_MODE14)	/* spi2_d1.gpio7_15 */
-		>;
-	};
-
-	i2c1_pins_default: i2c1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda.sda */
-			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl.scl */
-		>;
-	};
-
-	hdmi_pins: pinmux_hdmi_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
-			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
-		>;
-	};
-
-	i2c3_pins_default: i2c3_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x36a4, PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
-			DRA7XX_CORE_IOPAD(0x36a8, PIN_INPUT| MUX_MODE10)	/* mcasp1_fsx.i2c3_scl */
-		>;
-	};
-
-	uart3_pins_default: uart3_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
-			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
-		>;
-	};
-
 	mmc1_pins_default: mmc1_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
@@ -236,154 +194,9 @@
 			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
-
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
-	cpsw_pins_sleep: cpsw_pins_sleep {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			DRA7XX_CORE_IOPAD(0x3650, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3654, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3658, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x365c, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3660, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3664, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE15)
-
-			/* Slave 2 */
-			DRA7XX_CORE_IOPAD(0x3598, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x359c, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a0, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a4, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a8, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35ac, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE15)
-		>;
-	};
-
-	davinci_mdio_pins_default: davinci_mdio_pins_default {
-		pinctrl-single,pins = <
-			/* MDIO */
-			DRA7XX_CORE_IOPAD(0x363c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_mclk */
-			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
-		>;
-	};
-
-	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x363c, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT | MUX_MODE15)
-		>;
-	};
-
-	tps659038_pins_default: tps659038_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14)	/* wakeup0.gpio1_0 */
-		>;
-	};
-
-	tmp102_pins_default: tmp102_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_PULLUP | MUX_MODE14)	/* spi2_d0.gpio7_16 */
-		>;
-	};
-
-	mcp79410_pins_default: mcp79410_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3824, PIN_INPUT_PULLUP | MUX_MODE1)	/* wakeup3.sys_nirq1 */
-		>;
-	};
-
-	usb1_pins: pinmux_usb1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
-		>;
-	};
-
-	tpd12s015_pins: pinmux_tpd12s015_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37b0, PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
-			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
-			DRA7XX_CORE_IOPAD(0x3770, PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
-		>;
-	};
-
-	clkout2_pins_default: clkout2_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3694, PIN_OUTPUT_PULLDOWN | MUX_MODE9)	/* xref_clk0.clkout2 */
-		>;
-	};
-
-	clkout2_pins_sleep: clkout2_pins_sleep {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3694, PIN_INPUT | MUX_MODE15)	/* xref_clk0.clkout2 */
-		>;
-	};
-
-	mcasp3_pins_default: mcasp3_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_aclkx.mcasp3_aclkx */
-			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_fsx.mcasp3_fsx */
-			DRA7XX_CORE_IOPAD(0x372c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr0.mcasp3_axr0 */
-			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr1.mcasp3_axr1 */
-		>;
-	};
-
-	mcasp3_pins_sleep: mcasp3_pins_sleep {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x372c, PIN_INPUT | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT | MUX_MODE15)
-		>;
-	};
 };
-
 &i2c1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	tps659038: tps659038@58 {
@@ -392,9 +205,6 @@
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tps659038_pins_default>;
-
 		#interrupt-cells = <2>;
 		interrupt-controller;
 
@@ -556,8 +366,6 @@
 	tmp102: tmp102@48 {
 		compatible = "ti,tmp102";
 		reg = <0x48>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&tmp102_pins_default>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		#thermal-sensor-cells = <1>;
@@ -567,9 +375,6 @@
 		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic3104";
 		reg = <0x18>;
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&clkout2_pins_default>;
-		pinctrl-1 = <&clkout2_pins_sleep>;
 		assigned-clocks = <&clkoutmux2_clk_mux>;
 		assigned-clock-parents = <&sys_clk2_dclk_div>;
 
@@ -590,8 +395,6 @@
 
 &i2c3 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins_default>;
 	clock-frequency = <400000>;
 
 	mcp_rtc: rtc@6f {
@@ -601,9 +404,6 @@
 				      <&dra7_pmx_core 0x424>;
 		interrupt-names = "irq", "wakeup";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&mcp79410_pins_default>;
-
 		vcc-supply = <&vdd_3v3>;
 		wakeup-source;
 	};
@@ -623,16 +423,10 @@
 	status = "okay";
 	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 			      <&dra7_pmx_core 0x3f8>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_default>;
 };
 
 &mac {
 	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_pins_default>;
-	pinctrl-1 = <&cpsw_pins_sleep>;
 	dual_emac;
 };
 
@@ -648,12 +442,6 @@
 	dual_emac_res_vlan = <2>;
 };
 
-&davinci_mdio {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&davinci_mdio_pins_default>;
-	pinctrl-1 = <&davinci_mdio_pins_sleep>;
-};
-
 &mmc1 {
 	status = "okay";
 
@@ -669,7 +457,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-0 = <&mmc1_pins_default>;
 
 	vmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
@@ -691,8 +479,6 @@
 
 &usb1 {
 	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_pins>;
 };
 
 &omap_dwc3_2 {
@@ -768,9 +554,6 @@
 	status = "ok";
 	vdda-supply = <&ldo4_reg>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_pins>;
-
 	port {
 		hdmi_out: endpoint {
 			remote-endpoint = <&tpd12s015_in>;
@@ -784,9 +567,6 @@
 
 &mcasp3 {
 	#sound-dai-cells = <0>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&mcasp3_pins_default>;
-	pinctrl-1 = <&mcasp3_pins_sleep>;
 	assigned-clocks = <&mcasp3_ahclkx_mux>;
 	assigned-clock-parents = <&sys_clkin2>;
 	status = "okay";
-- 
2.9.1.200.gb1ec08f
