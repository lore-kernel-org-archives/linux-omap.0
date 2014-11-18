From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 2/9] ARM: dts: cm-t3x: add ADS7846 touchscreen support
Date: Tue, 18 Nov 2014 11:13:17 +0200
Message-ID: <1416302004-22199-3-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:48002 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbaKRJNp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 04:13:45 -0500
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add ADS7846 touchscreen support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   57 +++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index e4c0c56..3636fed 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -49,6 +49,13 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&hsusb2_power>;
 	};
+
+	ads7846reg: ads7846-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "ads7846-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &omap3_pmx_core {
@@ -115,6 +122,21 @@
 			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
 		>;
 	};
+
+	ads7846_pins: pinmux_ads7846_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20ba, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_ncs6.gpio_57 */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c8, PIN_INPUT | MUX_MODE0)	/* mcspi1_clk */
+			OMAP3_CORE1_IOPAD(0x21ca, PIN_INPUT | MUX_MODE0)	/* mcspi1_simo */
+			OMAP3_CORE1_IOPAD(0x21cc, PIN_INPUT | MUX_MODE0)	/* mcspi1_somi */
+			OMAP3_CORE1_IOPAD(0x21ce, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcspi1_cs0 */
+		>;
+	};
 };
 
 &uart3 {
@@ -147,3 +169,38 @@
 &usbhsehci {
 	phys = <&hsusb1_phy &hsusb2_phy>;
 };
+
+&mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+
+	/* touch controller */
+	ads7846@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ads7846_pins>;
+
+		compatible = "ti,ads7846";
+		vcc-supply = <&ads7846reg>;
+
+		reg = <0>;			/* CS0 */
+		spi-max-frequency = <1500000>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <25 0>;		/* gpio_57 */
+		pendown-gpio = <&gpio2 25 0>;
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
+};
-- 
1.7.5.4

