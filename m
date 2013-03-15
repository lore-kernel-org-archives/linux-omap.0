From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 23/23] ARM: dts: omap3-beagle: Add USB Host support
Date: Fri, 15 Mar 2013 17:16:44 +0200
Message-ID: <1363360604-21368-24-git-send-email-rogerq@ti.com>
References: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59116 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab3COPRl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 11:17:41 -0400
In-Reply-To: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rogerq@ti.com, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>

Provide RESET and Power regulators for the USB PHY,
the USB Host port mode and the PHY device.

Also provide pin multiplexer information for USB host
pins.

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   71 ++++++++++++++++++++++++++++=
++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/oma=
p3-beagle.dts
index f624dc8..02d23f1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -38,6 +38,57 @@
 		};
 	};
=20
+	/* HS USB Port 2 RESET */
+	hsusb2_reset: hsusb2_reset_reg {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "hsusb2_reset";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio5 19 0>;	/* gpio_147 */
+		startup-delay-us =3D <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Port 2 Power */
+	hsusb2_power: hsusb2_power_reg {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "hsusb2_vbus";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&twl_gpio 18 0>;	/* GPIO LEDA */
+		startup-delay-us =3D <70000>;
+	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible =3D "usb-nop-xceiv";
+		reset-supply =3D <&hsusb2_reset>;
+		vcc-supply =3D <&hsusb2_power>;
+	};
+};
+
+&omap3_pmx_core {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <
+			&hsusbb2_pins
+	>;
+
+	hsusbb2_pins: pinmux_hsusbb2_pins {
+		pinctrl-single,pins =3D <
+			0x5c0 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
+			0x5c2 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x5c4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT |=
 PULLDOWN */
+			0x5c6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT |=
 PULLDOWN */
+			0x5c8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT =
| PULLDOWN */
+			0x5cA 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT =
| PULLDOWN */
+			0x1a4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT =
| PULLDOWN */
+			0x1a6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT =
| PULLDOWN */
+			0x1a8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT =
| PULLDOWN */
+			0x1aa 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT =
| PULLDOWN */
+			0x1ac 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT =
| PULLDOWN */
+			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT =
| PULLDOWN */
+		>;
+	};
 };
=20
 &i2c1 {
@@ -65,3 +116,23 @@
 &mmc3 {
 	status =3D "disabled";
 };
+
+&usbhshost {
+	port2-mode =3D "ehci-phy";
+};
+
+&usbhsehci {
+	phys =3D <0 &hsusb2_phy>;
+};
+
+&twl_gpio {
+	ti,use-leds;
+	/* pullups: BIT(1) */
+	ti,pullups =3D <0x000002>;
+	/*
+	 * pulldowns:
+	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(15), BIT(16), BIT(17)
+	 */
+	ti,pulldowns =3D <0x03a1c4>;
+};
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
