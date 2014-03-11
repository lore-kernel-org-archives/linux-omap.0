From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 7/7] ARM: dts: Add support for the Overo Summit
Date: Tue, 11 Mar 2014 13:20:35 +0100
Message-ID: <1394540435-25401-8-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54340 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbaCKMVB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:21:01 -0400
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Summit is an expansion board for Gumstix Overo products.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile                       |  2 ++
 arch/arm/boot/dts/omap3-overo-storm-summit.dts   | 30 +++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi | 31 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-summit.dts         | 30 +++++++++++++++++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-summit.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-summit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7742e69..6565a7d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -217,6 +217,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-overo-storm-gallop43.dtb \
 	omap3-overo-palo43.dtb \
 	omap3-overo-storm-palo43.dtb \
+	omap3-overo-summit.dtb \
+	omap3-overo-storm-summit.dtb \
 	omap3-overo-tobi.dtb \
 	omap3-overo-storm-tobi.dtb \
 	omap3-gta04.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-storm-summit.dts b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
new file mode 100644
index 0000000..a0d7fd8
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Summit expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo-storm.dtsi"
+#include "omap3-overo-summit-common.dtsi"
+
+/ {
+	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Summit";
+	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)	/* etk_d7.gpio_21 */
+		>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-summit-common.dtsi b/arch/arm/boot/dts/omap3-overo-summit-common.dtsi
new file mode 100644
index 0000000..999d1cd
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-summit-common.dtsi
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Summit expansion board is manufactured by Gumstix Inc.
+ */
+
+#include "omap3-overo-common-peripherals.dtsi"
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+		heartbeat {
+			label = "overo:red:gpio21";
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&lis33de {
+	status = "disabled";
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-summit.dts b/arch/arm/boot/dts/omap3-overo-summit.dts
new file mode 100644
index 0000000..6976560
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-summit.dts
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Summit expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo.dtsi"
+#include "omap3-overo-summit-common.dtsi"
+
+/ {
+	model = "OMAP35xx Gumstix Overo on Summit";
+	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)	/* etk_d7.gpio_21 */
+		>;
+	};
+};
+
-- 
1.8.3.2

