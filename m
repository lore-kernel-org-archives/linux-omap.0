From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 5/9] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Fri,  7 Mar 2014 20:22:15 +0100
Message-ID: <1394220139-1760-6-git-send-email-florian.vaussard@epfl.ch>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45177 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbaCGTWc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:32 -0500
In-Reply-To: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add the High-Speed USB PHY.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi  | 44 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-storm.dtsi | 16 ++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi       | 16 ++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index edac70e..13d1ad2 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -30,6 +30,24 @@
 		ti,codec = <&twl_audio>;
 	};
 
+	/* HS USB Port 2 Power */
+	hsusb2_power: hsusb2_power_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio6 8 0>;				/* gpio_168: vbus enable */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio6 23 GPIO_ACTIVE_LOW>;	/* gpio_183 */
+		vcc-supply = <&hsusb2_power>;
+	};
+
 	/* Regulator to trigger the nPoweron signal of the Wifi module */
 	w3cbw003c_npoweron: regulator-w3cbw003c-npoweron {
 		compatible = "regulator-fixed";
@@ -64,6 +82,11 @@
 };
 
 &omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusb2_pins
+	>;
+
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
@@ -116,6 +139,19 @@
 			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
 		>;
 	};
+
+	hsusb2_pins: pinmux_hsusb2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
+			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
+			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
+			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
+			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
+			OMAP3_CORE1_IOPAD(0x21be, PIN_OUTPUT | MUX_MODE4)		/* i2c2_scl.gpio_168 */
+			OMAP3_CORE1_IOPAD(0x21c0, PIN_OUTPUT | MUX_MODE4)		/* i2c2_sda.gpio_183 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -177,6 +213,14 @@
 	power = <50>;
 };
 
+&usbhshost {
+	port2-mode = "ehci-phy";
+};
+
+&usbhsehci {
+	phys = <0 &hsusb2_phy>;
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
diff --git a/arch/arm/boot/dts/omap3-overo-storm.dtsi b/arch/arm/boot/dts/omap3-overo-storm.dtsi
index c235ae8..6cb418b 100644
--- a/arch/arm/boot/dts/omap3-overo-storm.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-storm.dtsi
@@ -10,6 +10,22 @@
 #include "omap3-overo-base.dtsi"
 
 &omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusb2_2_pins
+	>;
+
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+		>;
+	};
+
 	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
 		pinctrl-single,pins = <
 			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 95c59b2..c37b130 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -10,6 +10,22 @@
 #include "omap3-overo-base.dtsi"
 
 &omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusb2_2_pins
+	>;
+
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+		>;
+	};
+
 	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
 		pinctrl-single,pins = <
 			OMAP3430_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
-- 
1.8.3.2

