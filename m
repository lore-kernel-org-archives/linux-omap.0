From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] ARM: dts: Move most of am335x-bonegreen.dts to am335x-bonegreen-common.dtsi
Date: Tue, 27 Dec 2016 11:58:36 -0600
Message-ID: <20161227175837.28970-3-robertcnelson@gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161227175837.28970-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is going to be shared with the SeeedStudio BeagleBone Green Wireless

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi | 44 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bonegreen.dts         | 38 +---------------------
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen-common.dtsi

diff --git a/arch/arm/boot/dts/am335x-bonegreen-common.dtsi b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
new file mode 100644
index 000000000000..853e6d3a028d
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-bonegreen-common.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&ldo3_reg {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmcsd_fixed>;
+};
+
+&mmc2 {
+	vmmc-supply = <&vmmcsd_fixed>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins>;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&am33xx_pinmux {
+	uart2_pins: uart2_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&rtc {
+	system-power-controller;
+};
diff --git a/arch/arm/boot/dts/am335x-bonegreen.dts b/arch/arm/boot/dts/am335x-bonegreen.dts
index dce3c8657e04..a8b4d969ce2a 100644
--- a/arch/arm/boot/dts/am335x-bonegreen.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen.dts
@@ -9,45 +9,9 @@
 
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
+#include "am335x-bonegreen-common.dtsi"
 
 / {
 	model = "TI AM335x BeagleBone Green";
 	compatible = "ti,am335x-bone-green", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
 };
-
-&ldo3_reg {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-always-on;
-};
-
-&mmc1 {
-	vmmc-supply = <&vmmcsd_fixed>;
-};
-
-&mmc2 {
-	vmmc-supply = <&vmmcsd_fixed>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_pins>;
-	bus-width = <8>;
-	status = "okay";
-};
-
-&am33xx_pinmux {
-	uart2_pins: uart2_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
-		>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-	status = "okay";
-};
-
-&rtc {
-	system-power-controller;
-};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
