From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH v2 5/6] ARM: dts: cm-t54: add ADS7846 touchscreen support
Date: Wed, 17 Sep 2014 15:10:07 +0300
Message-ID: <1410955808-2174-6-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:46826 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692AbaIQMKU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 08:10:20 -0400
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add ADS7846 touchscreen support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 v2:  Fixed comment style issue for mux mode.

 arch/arm/boot/dts/omap5-cm-t54.dts |   61 ++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index e7afeb4..de76550 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -51,6 +51,13 @@
 		enable-active-high;
 	};
 
+	ads7846reg: ads7846-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "ads7846-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
@@ -164,6 +171,15 @@
 	};
 };
 
+&omap5_pmx_wkup {
+
+	ads7846_pins: pinmux_ads7846_pins {
+		pinctrl-single,pins = <
+			0x02 (PIN_INPUT_PULLDOWN | MUX_MODE6)  /* llib_wakereqin.gpio1_wk15 */
+		>;
+	};
+};
+
 &omap5_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
@@ -300,6 +316,51 @@
 			OMAP5_IOPAD(0x013a, PIN_OUTPUT | MUX_MODE3) /* gpio6_187.dispc_data23 */
 		>;
 	};
+
+	mcspi2_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x00fc, PIN_INPUT | MUX_MODE0) /* mcspi2_clk */
+			OMAP5_IOPAD(0x00fe, PIN_INPUT | MUX_MODE0) /* mcspi2_simo */
+			OMAP5_IOPAD(0x0100, PIN_INPUT | MUX_MODE0) /* mcspi2_somi */
+			OMAP5_IOPAD(0x0102, PIN_INPUT | MUX_MODE0) /* mcspi2_cs0 */
+		>;
+	};
+};
+
+&mcspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+
+	/* touch controller */
+	ads7846@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ads7846_pins>;
+
+		compatible = "ti,ads7846";
+		vcc-supply = <&ads7846reg>;
+
+		reg = <0>;				/* CS0 */
+		spi-max-frequency = <1500000>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 0>;			/* gpio1_wk15 */
+		pendown-gpio = <&gpio1 15 0>;
+
+
+		ti,x-min = /bits/ 16 <0x0>;
+		ti,x-max = /bits/ 16 <0x0fff>;
+		ti,y-min = /bits/ 16 <0x0>;
+		ti,y-max = /bits/ 16 <0x0fff>;
+
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+
+		ti,debounce-max = /bits/ 16 <30>;
+		ti,debounce-tol = /bits/ 16 <10>;
+		ti,debounce-rep = /bits/ 16 <1>;
+
+		linux,wakeup;
+	};
 };
 
 &mmc1 {
-- 
1.7.5.4

