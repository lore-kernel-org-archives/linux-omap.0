From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 11/18] ARM: dts: omap3-tobi: Create a file for common Gumstix peripherals
Date: Thu,  9 Jan 2014 17:48:05 +0100
Message-ID: <1389286092-27087-12-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41061 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbaAIQsu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:50 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Gumstix expansion boards share a couple of peripherals:
- i2c3 is used for the console
- AT24C01 EEPROM on i2c3

Use this file for omap3-tobi.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-common.dtsi | 39 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-tobi.dts          | 27 +--------------------
 2 files changed, 40 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common.dtsi

diff --git a/arch/arm/boot/dts/omap3-overo-common.dtsi b/arch/arm/boot/dts/omap3-overo-common.dtsi
new file mode 100644
index 0000000..5f38ce8
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-common.dtsi
@@ -0,0 +1,39 @@
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
+#include "omap3-overo.dtsi"
+
+&omap3_pmx_core {
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
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
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 67c056d..928d12f 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -10,7 +10,7 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
-#include "omap3-overo.dtsi"
+#include "omap3-overo-common.dtsi"
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
@@ -38,15 +38,6 @@
 	};
 };
 
-&omap3_pmx_core {
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
-		>;
-	};
-};
-
 #include "omap-gpmc-smsc9221.dtsi"
 
 &gpmc {
@@ -59,19 +50,3 @@
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
-- 
1.8.1.2

