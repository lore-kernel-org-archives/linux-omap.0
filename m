From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 21/23] ARM: dts: omap4-panda: Add USB Host support
Date: Fri, 15 Mar 2013 17:16:42 +0200
Message-ID: <1363360604-21368-22-git-send-email-rogerq@ti.com>
References: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rogerq@ti.com, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

Provide the RESET and Power regulators for the USB PHY,
the USB Host port mode and the PHY device.

Also provide pin multiplexer information for the USB host
pins.

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   56 +++++++++++++++++++++++++++++=
++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap=
4-panda.dts
index 4122efe..cfc7683 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -57,6 +57,36 @@
 			"AFML", "Line In",
 			"AFMR", "Line In";
 	};
+
+	/* HS USB Port 1 RESET */
+	hsusb1_reset: hsusb1_reset_reg {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "hsusb1_reset";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio2 30 0>;	/* gpio_62 */
+		startup-delay-us =3D <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Port 1 Power */
+	hsusb1_power: hsusb1_power_reg {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "hsusb1_vbus";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio1 1 0>;	/* gpio_1 */
+		startup-delay-us =3D <70000>;
+		enable-active-high;
+	};
+
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible =3D "usb-nop-xceiv";
+		reset-supply =3D <&hsusb1_reset>;
+		vcc-supply =3D <&hsusb1_power>;
+		clock-frequency =3D <19200000>;
+	};
 };
=20
 &omap4_pmx_core {
@@ -67,6 +97,7 @@
 			&mcbsp1_pins
 			&dss_hdmi_pins
 			&tpd12s015_pins
+			&hsusbb1_pins
 	>;
=20
 	twl6040_pins: pinmux_twl6040_pins {
@@ -110,6 +141,23 @@
 			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
 		>;
 	};
+
+	hsusbb1_pins: pinmux_hsusbb1_pins {
+		pinctrl-single,pins =3D <
+			0x82 0x10C	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk INPUT | P=
ULLDOWN */
+			0x84 0x4	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x86 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | P=
ULLDOWN */
+			0x88 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | P=
ULLDOWN */
+			0x8a 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | =
PULLDOWN */
+			0x8c 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | =
PULLDOWN */
+			0x8e 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | =
PULLDOWN */
+			0x90 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | =
PULLDOWN */
+			0x92 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | =
PULLDOWN */
+			0x94 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | =
PULLDOWN */
+			0x96 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | =
PULLDOWN */
+			0x98 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | =
PULLDOWN */
+		>;
+	    };
 };
=20
 &i2c1 {
@@ -206,3 +254,11 @@
 &twl_usb_comparator {
 	usb-supply =3D <&vusb>;
 };
+
+&usbhshost {
+	port1-mode =3D "ehci-phy";
+};
+
+&usbhsehci {
+	phys =3D <&hsusb1_phy>;
+};
--=20
1.7.4.1
