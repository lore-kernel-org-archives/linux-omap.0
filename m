From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2] ARM: dts: am335x-baltos: add LED support
Date: Tue, 28 Mar 2017 15:09:16 +0200
Message-ID: <1490706556-30046-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

All three devices provide GPIO based LEDs named power,
wlan and app.

Place LEDs definition into a separate dtsi file as not all
devices including am335x-baltos.dtsi have the same LED layout.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
Changes v1 -> v2:
  - move LEDs definition to a separate dtsi file (Tony Lindgren)

 arch/arm/boot/dts/am335x-baltos-ir2110.dts |  1 +
 arch/arm/boot/dts/am335x-baltos-ir3220.dts |  1 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts |  1 +
 arch/arm/boot/dts/am335x-baltos-leds.dtsi  | 50 ++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-leds.dtsi

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 501c752..75de1e7 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "am335x-baltos.dtsi"
+#include "am335x-baltos-leds.dtsi"
 
 / {
 	model = "OnRISC Baltos iR 2110";
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 19f53b8..46df1b2 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "am335x-baltos.dtsi"
+#include "am335x-baltos-leds.dtsi"
 
 / {
 	model = "OnRISC Baltos iR 3220";
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 2b9d7f4..5d56355 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "am335x-baltos.dtsi"
+#include "am335x-baltos-leds.dtsi"
 
 / {
 	model = "OnRISC Baltos iR 5221";
diff --git a/arch/arm/boot/dts/am335x-baltos-leds.dtsi b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
new file mode 100644
index 0000000..3ab1767
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-baltos-leds.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * VScom OnRISC
+ * http://www.vscom.de
+ */
+
+/*#include "am33xx.dtsi"*/
+
+/ {
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds>;
+
+		compatible = "gpio-leds";
+
+		power {
+			label = "onrisc:red:power";
+			linux,default-trigger = "default-on";
+			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+		wlan {
+			label = "onrisc:blue:wlan";
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		app {
+			label = "onrisc:green:app";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	user_leds: pinmux_user_leds {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+		>;
+	};
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
