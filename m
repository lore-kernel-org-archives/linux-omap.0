From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 09/11] ARM: dts: omap3-igep0020-rev-f: Support IGEPv2 Rev. F
Date: Thu,  6 Nov 2014 13:01:49 +0100
Message-ID: <1415275311-6857-10-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55128 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKFMCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:34 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add support for the new hardware revision of the IGEPv2. Basically, the new
revision F replaces the old Wifi module for a Wilink8 based module.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 45 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-igep0020-rev-f.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 454feb61..fb19271 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -302,6 +302,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-ha.dtb \
 	omap3-ha-lcd.dtb \
 	omap3-igep0020.dtb \
+	omap3-igep0020-rev-f.dtb \
 	omap3-igep0030.dtb \
 	omap3-igep0030-rev-g.dtb \
 	omap3-ldp.dtb \
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
new file mode 100644
index 0000000..cc8bd0c
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -0,0 +1,45 @@
+/*
+ * Device Tree Source for IGEPv2 Rev. F (TI OMAP AM/DM37x)
+ *
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
+ * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-igep0020-common.dtsi"
+
+/ {
+	model = "IGEPv2 Rev. F (TI OMAP AM/DM37x)";
+	compatible = "isee,omap3-igep0020-rev-f", "ti,omap36xx", "ti,omap3";
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
+			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT | MUX_MODE4)	/* mcspi1_cs3.gpio_177 - W_IRQ */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 - BT_EN */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - WL_EN */
+		>;
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

