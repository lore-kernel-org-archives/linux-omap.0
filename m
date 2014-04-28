From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH v2 2/2] ARM: dts: cm-t54: add WiFi/BT support
Date: Mon, 28 Apr 2014 14:41:45 +0300
Message-ID: <1398685305-29840-3-git-send-email-lifshitz@compulab.co.il>
References: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
 <1398685305-29840-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:45226 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbaD1LnK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 07:43:10 -0400
In-Reply-To: <1398685305-29840-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il, Dmitry Lifshitz <lifshitz@compulab.co.il>

Add support of AW-NH387 (mwifiex) WiFi/BT chip connected to MMC3.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

Changes from V1:

* Platform quirk for deasserting PDN and RST GPIOs of WiFi chip replaced by
  appropriate regulators in DT.

 arch/arm/boot/dts/omap5-cm-t54.dts |   53 +++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 787c4aa..570130f 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -23,6 +23,28 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vwlan_pdn_fixed: fixed-regulator-vwlan-pdn {
+		compatible = "regulator-fixed";
+		regulator-name = "vwlan_pdn_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ldo2_reg>;
+		gpio = <&gpio4 13 GPIO_ACTIVE_HIGH>;   /* gpio4_109 */
+		startup-delay-us = <1000>;
+		enable-active-high;
+	};
+
+	vwlan_fixed: fixed-regulator-vwlan {
+		compatible = "regulator-fixed";
+		regulator-name = "vwlan_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vwlan_pdn_fixed>;
+		gpio = <&gpio4 14 GPIO_ACTIVE_HIGH>;   /* gpio4_110 */
+		startup-delay-us = <1000>;
+		enable-active-high;
+	};
+
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
@@ -92,6 +114,24 @@
 		>;
 	};
 
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			OMAP5_CORE_IOPAD(0x29a4, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_clk */
+			OMAP5_CORE_IOPAD(0x29a6, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_cmd */
+			OMAP5_CORE_IOPAD(0x29a8, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data0 */
+			OMAP5_CORE_IOPAD(0x29aa, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data1 */
+			OMAP5_CORE_IOPAD(0x29ac, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data2 */
+			OMAP5_CORE_IOPAD(0x29ae, PIN_INPUT_PULLUP | MUX_MODE0) /* wlsdio_data3 */
+		>;
+	};
+
+	wlan_gpios_pins: pinmux_wlan_gpios_pins {
+		pinctrl-single,pins = <
+			OMAP5_CORE_IOPAD(0x299c, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_109 */
+			OMAP5_CORE_IOPAD(0x299e, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_110 */
+		>;
+	};
+
 	usbhost_pins: pinmux_usbhost_pins {
 		pinctrl-single,pins = <
 			OMAP5_CORE_IOPAD(0x28c4, PIN_INPUT | MUX_MODE0)  /* usbb2_hsic_strobe */
@@ -121,6 +161,17 @@
 	ti,non-removable;
 };
 
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&mmc3_pins
+		&wlan_gpios_pins
+	>;
+	vmmc-supply = <&vwlan_fixed>;
+	bus-width = <4>;
+	ti,non-removable;
+};
+
 &mmc4 {
 	status = "disabled";
 };
@@ -255,7 +306,7 @@
 					regulator-name = "ldo2";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
+					startup-delay-us = <1000>;
 				};
 
 				ldo3_reg: ldo3 {
-- 
1.7.5.4

