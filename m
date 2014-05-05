From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 7/7] dts: dra7-evm: add USB support
Date: Mon, 5 May 2014 12:54:46 +0300
Message-ID: <1399283686-6127-8-git-send-email-rogerq@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175AbaEEJzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 05:55:16 -0400
In-Reply-To: <1399283686-6127-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com
Cc: george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add USB pinmux information and USB modes
for the USB controllers.

CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-ev=
m.dts
index 5babba0..1d77815 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -93,6 +93,18 @@
 			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+                pinctrl-single,pins =3D <
+			0x280	0xc0000	/* usb1_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
+                >;
+        };
+
+	usb2_pins: pinmux_usb2_pins {
+                pinctrl-single,pins =3D <
+			0x284	0xc0000 /* usb2_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
+                >;
+        };
 };
=20
 &i2c1 {
@@ -273,3 +285,15 @@
 &cpu0 {
 	cpu0-supply =3D <&smps123_reg>;
 };
+
+&usb1 {
+	dr_mode =3D "peripheral";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&usb1_pins>;
+};
+
+&usb2 {
+	dr_mode =3D "host";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&usb2_pins>;
+};
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
