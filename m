From: Stefan Roese <sr@denx.de>
Subject: [PATCH 3/4 v2] arm: omap3: Add Technexion Thunder support (TAO3530 SOM based)
Date: Fri, 29 Aug 2014 12:40:05 +0200
Message-ID: <1409308806-27036-3-git-send-email-sr@denx.de>
References: <1409308806-27036-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:38059 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbaH2KkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2014 06:40:20 -0400
In-Reply-To: <1409308806-27036-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Tapani Utriainen <tapani@technexion.com>, Tony Lindgren <tony@atomide.com>

This baseboard is equipped with the Technexion TAO35030 SOM. So
includes this dtsi. Some Thunder specific features are:

- LCD panel

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Tapani Utriainen <tapani@technexion.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/omap3-thunder.dts | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-thunder.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..e00c889 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -309,6 +309,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-sbc-t3517.dtb \
 	omap3-sbc-t3530.dtb \
 	omap3-sbc-t3730.dtb \
+	omap3-thunder.dtb \
 	omap3-zoom3.dtb
 dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
 	am335x-bone.dtb \
diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/omap3-thunder.dts
new file mode 100644
index 0000000..d659515
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-thunder.dts
@@ -0,0 +1,129 @@
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
+	model = "TI OMAP3 Thunder baseboard with TAO3530 SOM";
+	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap34xx", "ti,omap3";
+};
+
+&omap3_pmx_core {
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
+		compatible = "samsung,lte430wq-f0c", "panel-dpi";
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
+			clock-frequency = <9000000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <3>;
+			hback-porch = <2>;
+			hsync-len = <42>;
+			vback-porch = <2>;
+			vfront-porch = <3>;
+			vsync-len = <11>;
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
-- 
2.1.0

