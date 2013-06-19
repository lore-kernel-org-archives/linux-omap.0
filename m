From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 5/6] ARM: dts: omap3beagle-xm: Add idle state pins for USB host
Date: Wed, 19 Jun 2013 17:05:52 +0300
Message-ID: <1371650753-11452-6-git-send-email-rogerq@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42319 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934811Ab3FSOGf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 10:06:35 -0400
In-Reply-To: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stern@rowland.harvard.edu, tony@atomide.com
Cc: balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>

Add the Idle state pins for USB host and enable WAKEUP on
DIR, DAT0-3, so that the PHY can wakeup the OMAP SoC from
sleep on any USB activity (e.g. remote wakeup or connect/disconnect).

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |   29 +++++++++++++++++++++++--=
----
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/=
omap3-beagle-xm.dts
index d3808ed..f1d56c2 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -89,12 +89,7 @@
 };
=20
 &omap3_pmx_core {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <
-			&hsusbb2_pins
-	>;
-
-	hsusbb2_pins: pinmux_hsusbb2_pins {
+	hsusb2_pins: pinmux_hsusb2_pins {
 		pinctrl-single,pins =3D <
 			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
 			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
@@ -110,6 +105,25 @@
 			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 *=
/
 		>;
 	};
+
+	/* WAKEUP enabled on DIR, DAT0-3 */
+	hsusb2_idle_pins: pinmux_hsusb2_idle_pins {
+		pinctrl-single,pins =3D <
+			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			0x5c4 (PIN_INPUT_PULLDOWN | WAKEUP_EN | MUX_MODE3)	/* etk_d12.hsusb=
2_dir */
+			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)			/* etk_d13.hsusb2_nxt */
+			0x5c8 (PIN_INPUT_PULLDOWN | WAKEUP_EN | MUX_MODE3)	/* etk_d14.hsusb=
2_data0 */
+			0x5cA (PIN_INPUT_PULLDOWN | WAKEUP_EN | MUX_MODE3)	/* etk_d15.hsusb=
2_data1 */
+			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 *=
/
+			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 *=
/
+			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 =
*/
+			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 =
*/
+			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 *=
/
+			0x1ae (PIN_INPUT_PULLDOWN | WAKEUP_EN | MUX_MODE3)	/* mcspi2_cs1.hs=
usb2_data3 */
+		>;
+		interrupts =3D <77>; /* route padconf wakeup to EHCI IRQ */
+	};
 };
=20
 &i2c1 {
@@ -181,6 +195,9 @@
 };
=20
 &usbhshost {
+	pinctrl-names =3D "default", "idle";
+	pinctrl-0 =3D <&hsusb2_pins>;
+	pinctrl-1 =3D <&hsusb2_idle_pins>;
 	port2-mode =3D "ehci-phy";
 };
=20
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
