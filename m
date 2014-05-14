From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 7/7] dts: dra7-evm: add USB support
Date: Wed, 14 May 2014 10:58:13 +0300
Message-ID: <53732215.8050608@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399283686-6127-8-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=46rom: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Add USB pinmux information and USB modes
for the USB controllers.

CC: Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-ev=
m.dts
index 5babba0..222a7fa 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -93,6 +93,18 @@
 			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+                pinctrl-single,pins =3D <
+			0x280 (PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+                >;
+        };
+
+	usb2_pins: pinmux_usb2_pins {
+                pinctrl-single,pins =3D <
+			0x284 (PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
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
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
