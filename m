From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 07/11] ARM: dts: omap3-igep0030-rev-g: Support IGEP COM MODULE Rev. G
Date: Thu,  6 Nov 2014 13:01:47 +0100
Message-ID: <1415275311-6857-8-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53274 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaKFMC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:28 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add support for the new hardware revision of the IGEP COM MODULE. Basically,
the new revision G replaces the old Wifi module for a Wilink8 based module.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 67 ++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-rev-g.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89ca..454feb61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -303,6 +303,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-ha-lcd.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
+	omap3-igep0030-rev-g.dtb \
 	omap3-ldp.dtb \
 	omap3-lilly-dbb056.dtb \
 	omap3-n900.dtb \
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
new file mode 100644
index 0000000..9326b28
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -0,0 +1,67 @@
+/*
+ * Device Tree Source for IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)
+ *
+ * Copyright (C) 2014 Javier Martinez Canillas <javier@collabora.co.uk>
+ * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-igep0030-common.dtsi"
+
+/ {
+	model = "IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)";
+	compatible = "isee,omap3-igep0030-rev-g", "ti,omap36xx", "ti,omap3";
+
+	/* Regulator to trigger the WL_EN signal of the Wifi module */
+	lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbep5clwmc-wlen";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 11 GPIO_ACTIVE_HIGH>;		/* gpio_139 - WL_EN */
+		enable-active-high;
+	};
+};
+
+&omap3_pmx_core {
+	lbep5clwmc_pins: pinmux_lbep5clwmc_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT | MUX_MODE4)	/* sdmmc2_dat4.gpio_136 - W_IRQ */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 - BT_EN */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - WL_EN */
+		>;
+	};
+
+	leds_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21be, PIN_OUTPUT | MUX_MODE4)	/* i2c2_scl.gpio_168 */
+		>;
+	};
+
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&leds_pins &leds_core2_pins>;
+
+	boot {
+		label = "omap3:green:boot";
+		gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
+		default-state = "on";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins &lbep5clwmc_pins>;
+	vmmc-supply = <&lbep5clwmc_wlen>;
+	bus-width = <4>;
+	non-removable;
+};
-- 
1.9.1

