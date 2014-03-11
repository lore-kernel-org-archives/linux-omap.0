From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/7] ARM: dts: overo: Create a file for common Gumstix peripherals
Date: Tue, 11 Mar 2014 13:20:29 +0100
Message-ID: <1394540435-25401-2-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54227 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbaCKMUz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:20:55 -0400
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Gumstix expansion boards share a couple of peripherals:
- uart3 is used for the console
- AT24C01 EEPROM on i2c3

Use this file for overo-tobi.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../boot/dts/omap3-overo-common-peripherals.dtsi   | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     | 40 +----------------
 2 files changed, 52 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi

diff --git a/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi b/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
new file mode 100644
index 0000000..bca81ae
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Peripherals common to all Gumstix Overo boards (Tobi, Summit, Palo43,...)
+ */
+
+&omap3_pmx_core {
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+
+	/* optional 1K EEPROM with revision information */
+	eeprom@51 {
+		compatible = "atmel,24c01";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 384e87d..060eb77 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -10,6 +10,8 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
+#include "omap3-overo-common-peripherals.dtsi"
+
 / {
 	leds {
 		compatible = "gpio-leds";
@@ -21,22 +23,6 @@
 	};
 };
 
-&omap3_pmx_core {
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-};
-
 #include "omap-gpmc-smsc9221.dtsi"
 
 &gpmc {
@@ -49,25 +35,3 @@
 	};
 };
 
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-	clock-frequency = <100000>;
-
-	/* optional 1K EEPROM with revision information */
-	eeprom@51 {
-		compatible = "atmel,24c01";
-		reg = <0x51>;
-		pagesize = <8>;
-	};
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
-
-- 
1.8.3.2

