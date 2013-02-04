From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 11/13] ARM: dts: omap4-panda: Add USB Host support
Date: Mon, 4 Feb 2013 17:58:58 +0200
Message-ID: <1359993540-20780-12-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58467 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab3BDP7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:59:46 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rogerq@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

Provide the RESET and Power regulators for the USB PHY,
the USB Host port mode and the PHY device.

Also provide pin multiplexer information for the USB host
pins.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   55 +++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 4122efe..fe2d3d4 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -57,6 +57,35 @@
 			"AFML", "Line In",
 			"AFMR", "Line In";
 	};
+
+	/* HS USB Port 1 RESET */
+	hsusb1_reset: hsusb1_reset_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb1_reset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 30 0>;	/* gpio_62 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Port 1 Power */
+	hsusb1_power: hsusb1_power_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb1_vbus";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 1 0>;	/* gpio_1 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+		reset-supply = <&hsusb1_reset>;
+		vcc-supply = <&hsusb1_power>;
+	};
 };
 
 &omap4_pmx_core {
@@ -67,6 +96,7 @@
 			&mcbsp1_pins
 			&dss_hdmi_pins
 			&tpd12s015_pins
+			&hsusbb1_pins
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -110,6 +140,23 @@
 			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
 		>;
 	};
+
+	hsusbb1_pins: pinmux_hsusbb1_pins {
+		pinctrl-single,pins = <
+			0x82 0x10C	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk INPUT | PULLDOWN */
+			0x84 0x4	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x86 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
+			0x88 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
+			0x8a 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
+			0x8c 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
+			0x8e 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
+			0x90 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
+			0x92 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
+			0x94 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
+			0x96 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
+			0x98 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
+		>;
+	    };
 };
 
 &i2c1 {
@@ -206,3 +253,11 @@
 &twl_usb_comparator {
 	usb-supply = <&vusb>;
 };
+
+&usbhshost {
+	port1_mode = <1>; /* OMAP_EHCI_PORT_MODE_PHY */
+};
+
+&usbhsehci {
+	phy = <&hsusb1_phy>;
+};
-- 
1.7.4.1

