From: Stefan Roese <sr@denx.de>
Subject: [PATCH 3/3] arm: dts: Add Siemens am335x-dxr2-e.dts
Date: Wed,  5 Feb 2014 13:12:41 +0100
Message-ID: <1391602361-2666-3-git-send-email-sr@denx.de>
References: <1391602361-2666-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:45071 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaBEMMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 07:12:43 -0500
In-Reply-To: <1391602361-2666-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lukas Stockmann <lukas.stockmann@siemens.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>

Add support for the Siemens DXR2 board. The DXR2-E is the first one
that is pushed now. It uses the Draco SOM and therefor includes this
dtsi file for the common device nodes.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-dxr2-e.dts | 242 ++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-dxr2-e.dts

diff --git a/arch/arm/boot/dts/am335x-dxr2-e.dts b/arch/arm/boot/dts/am335x-dxr2-e.dts
new file mode 100644
index 0000000..5fef637
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-dxr2-e.dts
@@ -0,0 +1,242 @@
+/*
+ * Support for Siemens DXR2.E board
+ *
+ * Copyright (C) 2013,2014 - Stefan Roese <sr@denx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include "am335x-draco.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Siemens DXR2.E";
+	compatible = "siemens,dxr2", "ti,am33xx";
+
+	/* ethernet alias is needed for the MAC address passing from U-Boot */
+	aliases {
+		ethernet0 = &cpsw_emac0;
+		mdio-gpio0 = &mdio0;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		button0 {
+			label = "button0";
+			gpios = <&gpio0 27 0>;
+			linux,code = <KEY_F1>; /* button0 */
+		};
+	};
+
+	am33xx_pinmux: pinmux@44e10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_mux_pins>;
+
+		gpio_mux_pins: gpio_mux_pins {
+			pinctrl-single,pins = <
+				0x020 (PIN_OUTPUT | MUX_MODE4)	/* GPMC_AD8, sinus inverter */
+				0x024 (PIN_OUTPUT | MUX_MODE4)	/* GPMC_AD9, sinus inverter */
+				0x028 (PIN_INPUT | MUX_MODE4)	/* GPMC_AD10, sinus inverter */
+				0x02c (PIN_INPUT | MUX_MODE7)	/* GPMC_AD11, button */
+				0x030 (PIN_OUTPUT | MUX_MODE7)	/* GPMC_AD12, UI */
+				0x034 (PIN_OUTPUT | MUX_MODE7)	/* GPMC_AD13, UI */
+				0x038 (PIN_OUTPUT | MUX_MODE7)	/* conf_gpmc_ad14, relay0 */
+				0x03c (PIN_OUTPUT | MUX_MODE7)	/* GPMC_AD15, UI */
+				0x08c (PIN_OUTPUT | MUX_MODE7)	/* GPMC_CLK, UI */
+				0x0d4 (PIN_OUTPUT | MUX_MODE7)	/* LCD_DATA13, AO_EN */
+				0x0dc (PIN_OUTPUT | MUX_MODE7)	/* LCD_DATA15, UI */
+				0x0ec (PIN_INPUT | MUX_MODE7)	/* LCD_AC_BIAS_EN, PWfail */
+				0x0f0 (PIN_OUTPUT | MUX_MODE7)	/* MMC0_DAT3, UI */
+				0x0f4 (PIN_OUTPUT | MUX_MODE7)	/* MMC0_DAT2, UI */
+				0x0f8 (PIN_OUTPUT | MUX_MODE7)	/* MMC0_DAT1, UI */
+				0x0fc (PIN_OUTPUT | MUX_MODE7)	/* MMC0_DAT0, UI */
+				0x108 (PIN_OUTPUT | MUX_MODE7)	/* MII1_COL, relay1 */
+				0x100 (PIN_OUTPUT | MUX_MODE7)	/* MMC0_CLK, UI */
+				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* MII1_RX_DV.gpio3.4, di0 */
+				0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* MII1_TXD2.gpio0.17, di1 */
+				0x12c (PIN_OUTPUT | MUX_MODE1)	/* MII1_TXCLK, MSTP RX2 */
+				0x164 (PIN_OUTPUT | MUX_MODE7)	/* ECAP0_IN_PWM0_OUT, relay2 */
+				0x168 (PIN_INPUT | MUX_MODE1)	/* MII1_RXCLK, tpuart RX4 */
+				0x16c (PIN_OUTPUT | MUX_MODE1)	/* LCD_DATA9, tpuart TX4 */
+				0x178 (PIN_OUTPUT | MUX_MODE7)	/* UART1_CTS, UI */
+				0x1b0 (PIN_OUTPUT | MUX_MODE7)	/* XDMA_EVENT_INTR0, KNX Power */
+				0x1d0 (PIN_INPUT | MUX_MODE0)	/* tms jtag */
+				0x1d4 (PIN_INPUT | MUX_MODE0)	/* tdi jtag */
+				0x1d8 (PIN_OUTPUT | MUX_MODE0)	/* tdo jtag */
+				0x1dc (PIN_INPUT | MUX_MODE0)	/* tck jtag */
+				0x1e0 (PIN_INPUT | MUX_MODE0)	/* trstn jtag */
+			>;
+		};
+
+		user_leds_s0: user_leds_s0 {
+			pinctrl-single,pins = <
+				0x88 (PIN_INPUT | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
+				0x1e4 (PIN_INPUT | MUX_MODE7)	/* emu0.gpio3_7 */
+			>;
+		};
+
+		epwmss0_pins: epwmss0_pins {
+			pinctrl-single,pins = <
+				0x150 (PIN_OUTPUT | MUX_MODE3)	/* conf_spi0_sclk.ehrpwm0A */
+				0x154 (PIN_OUTPUT | MUX_MODE3)	/* conf_spi0_d0.ehrpwm0B */
+			>;
+		};
+
+		epwmss1_pins: epwmss1_pins {
+			pinctrl-single,pins = <
+				0x0c8 (PIN_OUTPUT | MUX_MODE2)	/* lcd_data10.lcd_data10 */
+				0x0cc (PIN_OUTPUT | MUX_MODE2)	/* lcd_data11.lcd_data11 */
+			>;
+		};
+
+		ecap1_pins: ecap1_pins {
+			pinctrl-single,pins = <
+				0x160 (PIN_OUTPUT | MUX_MODE2)	/* conf_spi0_cs1*/
+			>;
+		};
+
+		cpsw_default: cpsw_default {
+			pinctrl-single,pins = <
+				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+				0x114 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txen.mii1_txen */
+				0x124 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd1.mii1_txd1 */
+				0x128 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd0.mii1_txd0 */
+				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.mii1_rxd1 */
+				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.mii1_rxd0 */
+				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
+			>;
+		};
+
+		cpsw_sleep: cpsw_sleep {
+			pinctrl-single,pins = <
+				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
+		davinci_mdio_default: davinci_mdio_default {
+			pinctrl-single,pins = <
+				/* MDIO */
+				0x148 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+				0x14c (PIN_OUTPUT | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			>;
+		};
+
+		davinci_mdio_sleep: davinci_mdio_sleep {
+			pinctrl-single,pins = <
+				/* MDIO reset value */
+				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
+		gpio_mdio_default: gpio_mdio_default {
+			pinctrl-single,pins = <
+				/* MDIO via GPIO */
+				0x148 (PIN_INPUT | MUX_MODE7)	/* mdio_data.mdio_data GPIO0_0 */
+				0x14c (PIN_OUTPUT | MUX_MODE7)	/* mdio_clk.mdio_clk GPIO0_1 */
+			>;
+		};
+	};
+
+	ocp {
+		epwmss0: epwmss@48300000 {
+			status = "okay";
+			compatible = "ti,am33xx-pwmss";
+
+			ehrpwm0: ehrpwm@48300200 {
+				compatible = "ti,am33xx-ehrpwm";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&epwmss0_pins>;
+			};
+		};
+
+		epwmss1: epwmss@48302000 {
+			status = "okay";
+			compatible = "ti,am33xx-pwmss";
+
+			ecap1: ecap@48302100 {
+				compatible = "ti,am33xx-ecap";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&ecap1_pins>;
+			};
+
+			ehrpwm1: ehrpwm@48302200 {
+				compatible = "ti,am33xx-ehrpwm";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&epwmss1_pins>;
+			};
+		};
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+		compatible = "gpio-leds";
+
+		led@0 {
+			label = "led0";
+			gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@1 {
+			label = "led1";
+			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	slaves = <1>;			/* use only one emac if */
+
+	mdio0: gpio {
+		compatible = "virtual,mdio-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_mdio_default>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH	/* MDIO-CLK */
+			 &gpio0 0 GPIO_ACTIVE_HIGH>;	/* MDIO-DATA */
+
+		phy0: ethernet-phy@1 {
+			reg = <0>;
+		};
+	};
+};
+
+/* Disable davinci/am335x mdio interface on this platform */
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	status = "disabled";
+};
+
+&cpsw_emac0 {
+	phy_id = <&mdio0>, <0>;
+	phy-mode = "rmii";
+};
+
+&phy_sel {
+	rmii-clock-ext;
+};
-- 
1.8.5.3

