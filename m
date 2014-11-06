From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 05/11] ARM: dts: omap3-igep00x0: Move outside common file the on board Wifi module.
Date: Thu,  6 Nov 2014 13:01:45 +0100
Message-ID: <1415275311-6857-6-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:62789 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKFMC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:26 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

New IGEP boards revisions will use another Wifi module, so this patch moves
the DT nodes outside the common omap3-igep.dtsi file to specific DT for every
board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi    | 29 ---------------------------
 arch/arm/boot/dts/omap3-igep0020.dts | 39 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0030.dts | 39 ++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 04a58ab..6118e7f 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -31,18 +31,6 @@
 		regulator-always-on;
 	};
 
-	lbee1usjyc_vmmc: lbee1usjyc_vmmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&lbee1usjyc_pins>;
-		compatible = "regulator-fixed";
-		regulator-name = "regulator-lbee1usjyc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* gpio_138 WIFI_PDN */
-		startup-delay-us = <10000>;
-		enable-active-high;
-		vin-supply = <&vdd33>;
-	};
 };
 
 &omap3_pmx_core {
@@ -60,15 +48,6 @@
 		>;
 	};
 
-	/* WiFi/BT combo */
-	lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
-		pinctrl-single,pins = <
-			0x136 (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 */
-			0x138 (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 */
-			0x13a (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 */
-		>;
-	};
-
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
 			0x10c (PIN_INPUT | MUX_MODE0)		/* mcbsp2_fsx.mcbsp2_fsx */
@@ -223,14 +202,6 @@
       bus-width = <4>;
 };
 
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
-	vmmc-supply = <&lbee1usjyc_vmmc>;
-	bus-width = <4>;
-	non-removable;
-};
-
 &mmc3 {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 75a3ac3..0d82f09 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -45,6 +45,27 @@
 		};
 	};
 
+	/* Regulator to trigger the WIFI_PDN signal of the Wifi module */
+	lbee1usjyc_pdn: lbee1usjyc_pdn {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbee1usjyc-pdn";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* gpio_138 - WIFI_PDN */
+		startup-delay-us = <10000>;
+		enable-active-high;
+	};
+
+	/* Regulator to trigger the RESET_N_W signal of the Wifi module */
+	lbee1usjyc_reset_n_w: lbee1usjyc_reset_n_w {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbee1usjyc-reset-n-w";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 11 GPIO_ACTIVE_HIGH>;	/* gpio_139 - RESET_N_W */
+		enable-active-high;
+	};
+
        /* HS USB Port 1 Power */
        hsusb1_power: hsusb1_power_reg {
                compatible = "regulator-fixed";
@@ -150,6 +171,14 @@
 		>;
 	};
 
+	lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 - RESET_N_W */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 - WIFI_PDN */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - RST_N_B */
+		>;
+	};
+
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)	/* uart2_cts.uart2_cts */
@@ -218,6 +247,16 @@
 	};
 };
 
+/* On board Wifi module */
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins &lbee1usjyc_pins>;
+	vmmc-supply = <&lbee1usjyc_pdn>;
+	vmmc_aux-supply = <&lbee1usjyc_reset_n_w>;
+	bus-width = <4>;
+	non-removable;
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index d7527b6..cc2a374 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -44,9 +44,38 @@
 			 default-state = "off";
 		};
 	};
+
+	/* Regulator to trigger the WIFI_PDN signal of the Wifi module */
+	lbee1usjyc_pdn: lbee1usjyc_pdn {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbee1usjyc-pdn";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* gpio_138 - WIFI_PDN */
+		startup-delay-us = <10000>;
+		enable-active-high;
+	};
+
+	/* Regulator to trigger the RESET_N_W signal of the Wifi module */
+	lbee1usjyc_reset_n_w: lbee1usjyc_reset_n_w {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbee1usjyc-reset-n-w";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 11 GPIO_ACTIVE_HIGH>;	/* gpio_139 - RESET_N_W */
+		enable-active-high;
+	};
 };
 
 &omap3_pmx_core {
+	lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 - RESET_N_W */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 - WIFI_PDN */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - RST_N_B */
+		>;
+	};
+
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
@@ -65,6 +94,16 @@
 	};
 };
 
+/* On board Wifi module */
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins &lbee1usjyc_pins>;
+	vmmc-supply = <&lbee1usjyc_pdn>;
+	vmmc_aux-supply = <&lbee1usjyc_reset_n_w>;
+	bus-width = <4>;
+	non-removable;
+};
+
 &uart2 {
        pinctrl-names = "default";
        pinctrl-0 = <&uart2_pins>;
-- 
1.9.1

