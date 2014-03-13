From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] DTS: ARM: OMAP3-N900: Add WL1251 support
Date: Thu, 13 Mar 2014 22:59:55 +0100
Message-ID: <1394747995-25090-2-git-send-email-sre@debian.org>
References: <1394747995-25090-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:49703 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbaCMWAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 18:00:07 -0400
In-Reply-To: <1394747995-25090-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "John W. Linville" <linville@tuxdriver.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add device tree support for the wireless chip
built into the Nokia N900.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index e91dae7..0f48b9b 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -148,6 +148,15 @@
 		>;
 	};
 
+	mcspi4_pins: pinmux_mcspi4_pins {
+		pinctrl-single,pins = <
+			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
+			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
+			0x160 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
+			0x166 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
@@ -203,6 +212,13 @@
 			0x15e (PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
 		>;
 	};
+
+	wl1251_pins: pinmux_wl1251 {
+		pinctrl-single,pins = <
+			0x0ce (PIN_OUTPUT | MUX_MODE4)		/* gpio 87 => wl1251 enable */
+			0x05a (PIN_INPUT | MUX_MODE4)		/* gpio 42 => wl1251 irq */
+		>;
+	};
 };
 
 &i2c1 {
@@ -603,6 +619,30 @@
 	};
 };
 
+&mcspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi4_pins>;
+
+	wl1251@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl1251_pins>;
+
+		vio-supply = <&vio>;
+
+		compatible = "ti,wl1251";
+		reg = <0>;
+		spi-max-frequency = <48000000>;
+
+		spi-cpol;
+		spi-cpha;
+
+		ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
+	};
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
-- 
1.9.0

