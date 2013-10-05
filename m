From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
Date: Sat,  5 Oct 2013 02:04:38 +0200
Message-ID: <1380931479-16142-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39047 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3JEAF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 20:05:29 -0400
In-Reply-To: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Add device nodes for the HS USB Host port 1, USB PHY and its
required regulator and also pin mux setup for HS USB1 pins.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi    | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0020.dts | 25 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 0f92224..ec2ecd2 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -27,6 +27,11 @@
 };
 
 &omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusbb1_pins
+	>;
+
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
 			0x152 (PIN_INPUT | MUX_MODE0)		/* uart1_rx.uart1_rx */
@@ -78,6 +83,23 @@
 		>;
 	};
 
+	hsusbb1_pins: pinmux_hsusbb1_pins {
+		pinctrl-single,pins = <
+			0x5aa (PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
+			0x5a8 (PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
+			0x5bc (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
+			0x5be (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
+			0x5ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
+			0x5ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
+			0x5b0 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
+			0x5b2 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
+			0x5b4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
+			0x5b6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
+			0x5b8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
+			0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
+		>;
+	};
+
 	leds_pins: pinmux_leds_pins { };
 };
 
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 903e944..180b186 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -55,6 +55,23 @@
 		regulator-name = "vdd33a";
 		regulator-always-on;
 	};
+
+       /* HS USB Port 1 Power */
+       hsusb1_power: hsusb1_power_reg {
+               compatible = "regulator-fixed";
+               regulator-name = "hsusb1_vbus";
+               regulator-min-microvolt = <3300000>;
+               regulator-max-microvolt = <3300000>;
+               gpio = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* GPIO LEDA */
+               startup-delay-us = <70000>;
+       };
+
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
+		vcc-supply = <&hsusb1_power>;
+	};
 };
 
 &leds_pins {
@@ -173,3 +190,11 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&usbhshost {
+	port1-mode = "ehci-phy";
+};
+
+&usbhsehci {
+	phys = <&hsusb1_phy>;
+};
-- 
1.8.4.rc3

