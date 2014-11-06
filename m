From: Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/11] ARM: dts: omap3-igep0030-common: Introduce igep0030 common dtsi file.
Date: Thu,  6 Nov 2014 13:01:46 +0100
Message-ID: <1415275311-6857-7-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use the omap3-igep0030-common.dtsi file and remove repeated parts leaving
the nodes that are not common between IGEP COM MODULE hardware revisions.

Signed-off-by: Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap3-igep0030-common.dtsi | 60 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0030.dts         | 58 +++++----------------------
 2 files changed, 69 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-common.dtsi

diff --git a/arch/arm/boot/dts/omap3-igep0030-common.dtsi b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
new file mode 100644
index 0000000..0cb1527
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0030-common.dtsi
@@ -0,0 +1,60 @@
+/*
+ * Common Device Tree Source for IGEP COM MODULE
+ *
+ * Copyright (C) 2014 Javier Martinez Canillas <javier-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
+ * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-igep.dtsi"
+
+/ {
+	leds: gpio_leds {
+		compatible = "gpio-leds";
+
+		user0 {
+			 label = "omap3:red:user0";
+			 gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* LEDA */
+			 default-state = "off";
+		};
+
+		user1 {
+			 label = "omap3:green:user1";
+			 gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>;	/* LEDB */
+			 default-state = "off";
+		};
+
+		user2 {
+			 label = "omap3:red:user1";
+			 gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;		/* gpio_16 */
+			 default-state = "off";
+		};
+	};
+};
+
+&omap3_pmx_core {
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x216e, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_dr.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_clk.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE1)	/* mcbsp3_fsx.uart2_rx */
+		>;
+	};
+};
+
+&omap3_pmx_core2 {
+	leds_core2_pins: pinmux_leds_core2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)	/* etk_d2.gpio_16 */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index cc2a374..8150f47 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -9,42 +9,12 @@
  * published by the Free Software Foundation.
  */
 
-#include "omap3-igep.dtsi"
+#include "omap3-igep0030-common.dtsi"
 
 / {
 	model = "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
 
-	leds {
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins>;
-		compatible = "gpio-leds";
-
-		boot {
-			 label = "omap3:green:boot";
-			 gpios = <&twl_gpio 13 GPIO_ACTIVE_LOW>;
-			 default-state = "on";
-		};
-
-		user0 {
-			 label = "omap3:red:user0";
-			 gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>; /* LEDA */
-			 default-state = "off";
-		};
-
-		user1 {
-			 label = "omap3:green:user1";
-			 gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>; /* LEDB */
-			 default-state = "off";
-		};
-
-		user2 {
-			 label = "omap3:red:user1";
-			 gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-			 default-state = "off";
-		};
-	};
-
 	/* Regulator to trigger the WIFI_PDN signal of the Wifi module */
 	lbee1usjyc_pdn: lbee1usjyc_pdn {
 		compatible = "regulator-fixed";
@@ -75,22 +45,16 @@
 			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - RST_N_B */
 		>;
 	};
-
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
-			OMAP3_CORE1_IOPAD(0x216e, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_dr.uart2_rts */
-			OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_clk.uart2_tx */
-			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE1)	/* mcbsp3_fsx.uart2_rx */
-		>;
-	};
 };
 
-&omap3_pmx_core2 {
-	leds_pins: pinmux_leds_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
-		>;
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&leds_core2_pins>;
+
+	boot {
+		label = "omap3:green:boot";
+		gpios = <&twl_gpio 13 GPIO_ACTIVE_LOW>;	/* LEDSYNC */
+		default-state = "on";
 	};
 };
 
@@ -104,7 +68,3 @@
 	non-removable;
 };
 
-&uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
-};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
