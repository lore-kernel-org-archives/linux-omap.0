From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: omap3-beagle-xm: Add USB Host support
Date: Thu, 18 Apr 2013 14:44:33 +0300
Message-ID: <1366285474-19967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com
Cc: robertcnelson@gmail.com, grinberg@compulab.co.il, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Provide RESET and Power regulators for the USB PHY,
the USB Host port mode and the PHY device.

Also provide pin multiplexer information for USB host
pins.

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |   61 +++++++++++++++++++++++++=
++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/=
omap3-beagle-xm.dts
index 5a31964..04376a6 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -57,6 +57,59 @@
 		ti,mcbsp =3D <&mcbsp2>;
 		ti,codec =3D <&twl_audio>;
 	};
+
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
+
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
@@ -125,3 +178,11 @@
 	mode =3D <3>;
 	power =3D <50>;
 };
+
+&usbhshost {
+	port2-mode =3D "ehci-phy";
+};
+
+&usbhsehci {
+	phys =3D <0 &hsusb2_phy>;
+};
--=20
1.7.4.1
