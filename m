From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 5/7] ARM: dts: Add support for the Overo Alto35
Date: Tue, 11 Mar 2014 13:20:33 +0100
Message-ID: <1394540435-25401-6-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54300 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117AbaCKMU7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:20:59 -0400
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Alto35 is an expansion board for Gumstix Overo products.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/Makefile                       |  2 +
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi | 77 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-alto35.dts         | 22 +++++++
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts   | 21 +++++++
 4 files changed, 122 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-alto35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-alto35.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd7821b..de5cfcc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -209,6 +209,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-n900.dtb \
 	omap3-n9.dtb \
 	omap3-n950.dtb \
+	omap3-overo-alto35.dtb \
+	omap3-overo-storm-alto35.dtb \
 	omap3-overo-gallop43.dtb \
 	omap3-overo-storm-gallop43.dtb \
 	omap3-overo-palo43.dtb \
diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
new file mode 100644
index 0000000..19d6486
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Alto35 expansion board is manufactured by Gumstix Inc.
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
+		gpio148 {
+			label = "overo:red:gpio148";
+			gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>;		/* gpio 148 */
+		};
+		gpio150 {
+			label = "overo:yellow:gpio150";
+			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>;		/* gpio 150 */
+		};
+		gpio151 {
+			label = "overo:blue:gpio151";
+			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;		/* gpio 151 */
+		};
+		gpio170 {
+			label = "overo:green:gpio170";
+			gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;		/* gpio 170 */
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&button_pins>;
+		button0@10 {
+			label = "button0";
+			linux,code = <BTN_0>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;		/* gpio_10 */
+			gpio-key,wakeup;
+		};
+	};
+};
+
+&omap3_pmx_core {
+	led_pins: pinmux_led_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE4)	/* uart1_tx.gpio_148 */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)	/* uart1_cts.gpio_150 */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_OUTPUT | MUX_MODE4)	/* uart1_rx.gpio_151 */
+			OMAP3_CORE1_IOPAD(0x21c6, PIN_OUTPUT | MUX_MODE4)	/* hdq_sio.gpio_170 */
+		>;
+	};
+};
+
+&omap3_pmx_wkup {
+	button_pins: pinmux_button_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a18, PIN_INPUT | MUX_MODE4)		/* sys_clkout1.gpio_10 */
+		>;
+	};
+};
+
+&usbhshost {
+	status = "disabled";
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-alto35.dts b/arch/arm/boot/dts/omap3-overo-alto35.dts
new file mode 100644
index 0000000..a3249eb
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-alto35.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Alto35 expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo.dtsi"
+#include "omap3-overo-alto35-common.dtsi"
+
+/ {
+	model = "OMAP35xx Gumstix Overo on Alto35";
+	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3";
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
new file mode 100644
index 0000000..e9cae52
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Alto35 expansion board is manufactured by Gumstix Inc.
+ */
+
+/dts-v1/;
+
+#include "omap3-overo-storm.dtsi"
+#include "omap3-overo-alto35-common.dtsi"
+
+/ {
+	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Alto35";
+	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
+};
-- 
1.8.3.2

