From: Stefan Roese <sr@denx.de>
Subject: [PATCH 4/4 v2] arm: omap3: Add HEAD acoustics omap3-ha.dts and omap3-ha-lcd.dts (TAO3530 based)
Date: Fri, 29 Aug 2014 12:40:06 +0200
Message-ID: <1409308806-27036-4-git-send-email-sr@denx.de>
References: <1409308806-27036-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.183]:30698 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaH2KkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2014 06:40:16 -0400
In-Reply-To: <1409308806-27036-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Tapani Utriainen <tapani@technexion.com>, Tony Lindgren <tony@atomide.com>

These baseboards are equipped with the Technexion TAO35030 SOM. So
they include this dtsi. The common parts are extracted into an "common"
dtsi file. The main difference between both boards is, that the *lcd
has DSS support enabled for the LCD.

Some HEAD acoustics specific features are:

- LED handling
- Special FPGA/DSP audio driver (not included in this series)
- powerdown GPIO

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Tapani Utriainen <tapani@technexion.com>
Cc: Tony Lindgren <tony@atomide.com>
---
v2:
- Used OMAP3_CORE1_IOPAD macros for all mux entries

 arch/arm/boot/dts/Makefile             |   2 +
 arch/arm/boot/dts/omap3-ha-common.dtsi |  88 ++++++++++++++++++
 arch/arm/boot/dts/omap3-ha-lcd.dts     | 165 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-ha.dts         |  28 ++++++
 4 files changed, 283 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-ha-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-ha-lcd.dts
 create mode 100644 arch/arm/boot/dts/omap3-ha.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e00c889..892b7d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -287,6 +287,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-evm.dtb \
 	omap3-evm-37xx.dtb \
 	omap3-gta04.dtb \
+	omap3-ha.dtb \
+	omap3-ha-lcd.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
 	omap3-ldp.dtb \
diff --git a/arch/arm/boot/dts/omap3-ha-common.dtsi b/arch/arm/boot/dts/omap3-ha-common.dtsi
new file mode 100644
index 0000000..bd66545
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-ha-common.dtsi
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014 Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-tao3530.dtsi"
+
+/ {
+	gpio_poweroff {
+		pinctrl-names = "default";
+		pinctrl-0 = <&poweroff_pins>;
+
+		compatible = "gpio-poweroff";
+		gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;	/* GPIO 168 */
+	};
+};
+
+&omap3_pmx_core {
+	sound2_pins: pinmux_sound2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x209e, PIN_OUTPUT | MUX_MODE4)	/* gpmc_d8 gpio_44 */
+		>;
+	};
+
+	led_blue_pins: pinmux_led_blue_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2110, PIN_OUTPUT | MUX_MODE4)	/* cam_xclka gpio_96, LED blue */
+		>;
+	};
+
+	led_green_pins: pinmux_led_green_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2126, PIN_OUTPUT | MUX_MODE4)	/* cam_d8 gpio_107, LED green */
+		>;
+	};
+
+	led_red_pins: pinmux_led_red_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x212e, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* cam_xclkb gpio_111, LED red */
+		>;
+	};
+
+	poweroff_pins: pinmux_poweroff_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21be, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* i2c2_scl gpio_168 */
+		>;
+	};
+
+	powerdown_input_pins: pinmux_powerdown_input_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT_PULLUP | MUX_MODE4)	/* i2c2_sda gpio_183 */
+		>;
+	};
+
+	fpga_boot0_pins: fpga_boot0_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT | MUX_MODE4)	/* cam_d2 gpio_101 */
+			OMAP3_CORE1_IOPAD(0x211c, PIN_OUTPUT | MUX_MODE4)	/* cam_d3 gpio_102 */
+			OMAP3_CORE1_IOPAD(0x211e, PIN_OUTPUT | MUX_MODE4)	/* cam_d4 gpio_103 */
+			OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT_PULLUP | MUX_MODE4)	/* cam_d5 gpio_104 */
+		>;
+	};
+
+	fpga_boot1_pins: fpga_boot1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE4)	/* gpmc_d10 gpio_46 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_OUTPUT | MUX_MODE4)	/* gpmc_d11 gpio_47 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_OUTPUT | MUX_MODE4)	/* gpmc_d12 gpio_48 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_d13 gpio_49 */
+		>;
+	};
+};
+
+/* I2C2: mux'ed with GPIO168 which is connected to nKILL_POWER */
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/omap3-ha-lcd.dts
new file mode 100644
index 0000000..11aa28d
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-ha-lcd.dts
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014 Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-ha-common.dtsi"
+
+/ {
+	model = "TI OMAP3 HEAD acoustics LCD-baseboard with TAO3530 SOM";
+	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusbb2_pins
+		&powerdown_input_pins
+		&fpga_boot0_pins
+		&fpga_boot1_pins
+		&led_blue_pins
+		&led_green_pins
+		&led_red_pins
+		&touchscreen_wake_pins
+	>;
+
+	touchscreen_irq_pins: pinmux_touchscreen_irq_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpio_136, Touchscreen IRQ */
+		>;
+	};
+
+	touchscreen_wake_pins: pinmux_touchscreen_wake_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x212c, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* gpio_110, Touchscreen Wake */
+		>;
+	};
+
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)	/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)	/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)	/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)	/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)	/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)	/* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)	/* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)	/* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)	/* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)	/* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)	/* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)	/* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)	/* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)	/* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)	/* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)	/* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)	/* dss_data17.dss_data17 */
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)	/* dss_data18.dss_data18 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)	/* dss_data19.dss_data19 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)	/* dss_data20.dss_data20 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)	/* dss_data21.dss_data21 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)	/* dss_data22.dss_data22 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)	/* dss_data23.dss_data23 */
+		>;
+	};
+
+	lte430_pins: pinmux_lte430_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 */
+		>;
+	};
+
+	backlight_pins: pinmux_backlight_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 */
+		>;
+	};
+};
+
+/* I2C2: mux'ed with GPIO168 which is connected to nKILL_POWER */
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+/* Needed to power the DPI pins */
+&vpll2 {
+	regulator-always-on;
+};
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display@0 {
+		compatible = "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lte430_pins>;
+		enable-gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;	/* gpio_138 */
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <31250000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <86>;
+			hsync-len = <1>;
+			vback-porch = <30>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+
+	backlight {
+		compatible = "gpio-backlight";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		gpios = <&gpio5 11 GPIO_ACTIVE_HIGH>;		/* gpio_139 */
+
+		default-on;
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-ha.dts b/arch/arm/boot/dts/omap3-ha.dts
new file mode 100644
index 0000000..fde3256
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-ha.dts
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014 Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-ha-common.dtsi"
+
+/ {
+	model = "TI OMAP3 HEAD acoustics baseboard with TAO3530 SOM";
+	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusbb2_pins
+		&powerdown_input_pins
+		&fpga_boot0_pins
+		&fpga_boot1_pins
+		&led_blue_pins
+		&led_green_pins
+		&led_red_pins
+	>;
+};
-- 
2.1.0

