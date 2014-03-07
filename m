From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 1/9] ARM: dts: overo: reorganize include files
Date: Fri,  7 Mar 2014 20:22:11 +0100
Message-ID: <1394220139-1760-2-git-send-email-florian.vaussard@epfl.ch>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45131 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbaCGTW2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:28 -0500
In-Reply-To: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Currently, overo-related include files are organized as follow:

                     omap3-overo.dtsi
                             |
                             |
omap34xx.dtsi   omap3-overo-tobi-common.dtsi   omap36xx.dtsi
      |              |                 |             |
      ---------------                  ---------------
              |                                |
    omap3-overo-tobi.dts          omap3-overo-storm-tobi.dts

This is unpractical when one has to deal with SoC-specific pinmux
belonging to the omap3_pmx_core2 (defined in omap34xx/omap36xx),
for pins related to the processor board. With the current
hierarchy, such pinmux has to be defined in the expansion board's
.dts, which is not logical.

This patches reorganizes the files to add (yet another) abstraction
layer between the processor and the expansion boards.

omap34xx.dtsi       omap3-overo-base.dtsi      omap36xx.dtsi
      |              |                 |             |
      ---------------                  ---------------
              |                                |
      omap3-overo.dtsi               omap3-overo-storm.dtsi
              |                                |
      --------                                  ------
      |         omap3-overo-tobi-common.dtsi         |
      |              |                 |             |
      ---------------                  ---------------
              |                                |
    omap3-overo-tobi.dts          omap3-overo-storm-tobi.dts

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 94 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts   |  2 +-
 arch/arm/boot/dts/omap3-overo-storm.dtsi       | 11 +++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi |  2 -
 arch/arm/boot/dts/omap3-overo-tobi.dts         |  2 +-
 arch/arm/boot/dts/omap3-overo.dtsi             | 89 +-----------------------
 6 files changed, 110 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-base.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm.dtsi

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
new file mode 100644
index 0000000..5970999
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * The Gumstix Overo must be combined with an expansion board.
+ */
+
+/ {
+	pwmleds {
+		compatible = "pwm-leds";
+
+		overo {
+			label = "overo:blue:COM";
+			pwms = <&twl_pwmled 1 7812500>;
+			max-brightness = <127>;
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "overo";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
+	};
+};
+
+#include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
+
+/* i2c2 pins are used for gpio */
+&i2c2 {
+	status = "disabled";
+};
+
+/* on board microSD slot */
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+};
+
+/* optional on board WiFi */
+&mmc2 {
+	bus-width = <4>;
+};
+
+&twl_gpio {
+	ti,use-leds;
+};
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
+
+&omap3_pmx_core {
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
index 966b5c9..879383a 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
@@ -12,7 +12,7 @@
 
 /dts-v1/;
 
-#include "omap36xx.dtsi"
+#include "omap3-overo-storm.dtsi"
 #include "omap3-overo-tobi-common.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap3-overo-storm.dtsi b/arch/arm/boot/dts/omap3-overo-storm.dtsi
new file mode 100644
index 0000000..c30efb3
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-storm.dtsi
@@ -0,0 +1,11 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap36xx.dtsi"
+#include "omap3-overo-base.dtsi"
+
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 4edc013..9b4a6d2 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -10,8 +10,6 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
-#include "omap3-overo.dtsi"
-
 / {
 	leds {
 		compatible = "gpio-leds";
diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
index de5653e..fd6400e 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
@@ -12,7 +12,7 @@
 
 /dts-v1/;
 
-#include "omap34xx.dtsi"
+#include "omap3-overo.dtsi"
 #include "omap3-overo-tobi-common.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 5970999..7bbda68 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -1,94 +1,11 @@
 /*
- * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
-/*
- * The Gumstix Overo must be combined with an expansion board.
- */
-
-/ {
-	pwmleds {
-		compatible = "pwm-leds";
-
-		overo {
-			label = "overo:blue:COM";
-			pwms = <&twl_pwmled 1 7812500>;
-			max-brightness = <127>;
-			linux,default-trigger = "mmc0";
-		};
-	};
-
-	sound {
-		compatible = "ti,omap-twl4030";
-		ti,model = "overo";
-
-		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-
-		twl_audio: audio {
-			compatible = "ti,twl4030-audio";
-			codec {
-			};
-		};
-	};
-};
-
-#include "twl4030.dtsi"
-#include "twl4030_omap3.dtsi"
-
-/* i2c2 pins are used for gpio */
-&i2c2 {
-	status = "disabled";
-};
-
-/* on board microSD slot */
-&mmc1 {
-	vmmc-supply = <&vmmc1>;
-	bus-width = <4>;
-};
-
-/* optional on board WiFi */
-&mmc2 {
-	bus-width = <4>;
-};
-
-&twl_gpio {
-	ti,use-leds;
-};
-
-&usb_otg_hs {
-	interface-type = <0>;
-	usb-phy = <&usb2_phy>;
-	phys = <&usb2_phy>;
-	phy-names = "usb2-phy";
-	mode = <3>;
-	power = <50>;
-};
-
-&omap3_pmx_core {
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-};
+#include "omap34xx.dtsi"
+#include "omap3-overo-base.dtsi"
 
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
-- 
1.8.3.2

