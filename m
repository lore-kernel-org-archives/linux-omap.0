From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/7] ARM: dts: Add support for the Overo Palo43
Date: Tue, 11 Mar 2014 13:20:31 +0100
Message-ID: <1394540435-25401-4-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54261 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112AbaCKMU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:20:57 -0400
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Palo43 is an expansion board for Gumstix Overo products.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile                       |  2 +
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi | 53 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-palo43.dts         | 38 +++++++++++++++++
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts   | 38 +++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo43.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-palo43.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0320303..98d508d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -209,6 +209,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
+	omap3-overo-palo43.dtb \
+	omap3-overo-storm-palo43.dtb \
 	omap3-overo-tobi.dtb \
 	omap3-overo-storm-tobi.dtb \
 	omap3-gta04.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
new file mode 100644
index 0000000..abea232
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Palo43 expansion board is manufactured by Gumstix Inc.
+ */
+
+#include "omap3-overo-common-peripherals.dtsi"
+
+#include <dt-bindings/input/input.h>
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
+		gpio22 {
+			label = "overo:blue:gpio22";
+			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;		/* gpio_22 */
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&button_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button0@23 {
+			label = "button0";
+			linux,code = <BTN_0>;
+			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
+			gpio-key,wakeup;
+		};
+		button1@14 {
+			label = "button1";
+			linux,code = <BTN_1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
+			gpio-key,wakeup;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-palo43.dts b/arch/arm/boot/dts/omap3-overo-palo43.dts
new file mode 100644
index 0000000..cedb103
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-palo43.dts
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Palo43 expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo.dtsi"
+#include "omap3-overo-palo43-common.dtsi"
+
+/ {
+	model = "OMAP35xx Gumstix Overo on Palo43";
+	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)	/* etk_d7.gpio_21 */
+			OMAP3430_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)	/* etk_d8.gpio_22 */
+		>;
+	};
+
+	button_pins: pinmux_button_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25ee, PIN_INPUT | MUX_MODE4)	/* etk_d9.gpio_23 */
+			OMAP3430_CORE2_IOPAD(0x25dc, PIN_INPUT | MUX_MODE4)	/* etk_d0.gpio_14 */
+		>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
new file mode 100644
index 0000000..b585d8f
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Palo43 expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo-storm.dtsi"
+#include "omap3-overo-palo43-common.dtsi"
+
+/ {
+	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo43";
+	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)	/* etk_d7.gpio_21 */
+			OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)	/* etk_d8.gpio_22 */
+		>;
+	};
+
+	button_pins: pinmux_button_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25ee, PIN_INPUT | MUX_MODE4)	/* etk_d9.gpio_23 */
+			OMAP3630_CORE2_IOPAD(0x25dc, PIN_INPUT | MUX_MODE4)	/* etk_d0.gpio_14 */
+		>;
+	};
+};
+
-- 
1.8.3.2

