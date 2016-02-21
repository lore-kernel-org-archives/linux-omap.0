From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: dts: n900: Use linux input defines instead hardcoded constants
Date: Sun, 21 Feb 2016 12:06:48 +0100
Message-ID: <1456052808-14461-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pavel Machel <pavel-+ZI9xUNit7I@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This makes DTS structure more readable.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-n900.dts |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index e0443cd..85c29f3 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -65,45 +65,45 @@
 		camera_lens_cover {
 			label =3D "Camera Lens Cover";
 			gpios =3D <&gpio4 14 GPIO_ACTIVE_LOW>; /* 110 */
-			linux,input-type =3D <5>; /* EV_SW */
-			linux,code =3D <0x09>; /* SW_CAMERA_LENS_COVER */
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_CAMERA_LENS_COVER>;
 			wakeup-source;
 		};
=20
 		camera_focus {
 			label =3D "Camera Focus";
 			gpios =3D <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
-			linux,code =3D <0x210>; /* KEY_CAMERA_FOCUS */
+			linux,code =3D <KEY_CAMERA_FOCUS>;
 			wakeup-source;
 		};
=20
 		camera_capture {
 			label =3D "Camera Capture";
 			gpios =3D <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
-			linux,code =3D <0xd4>; /* KEY_CAMERA */
+			linux,code =3D <KEY_CAMERA>;
 			wakeup-source;
 		};
=20
 		lock_button {
 			label =3D "Lock Button";
 			gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
-			linux,code =3D <0x98>; /* KEY_SCREENLOCK */
+			linux,code =3D <KEY_SCREENLOCK>;
 			wakeup-source;
 		};
=20
 		keypad_slide {
 			label =3D "Keypad Slide";
 			gpios =3D <&gpio3 7 GPIO_ACTIVE_LOW>; /* 71 */
-			linux,input-type =3D <5>; /* EV_SW */
-			linux,code =3D <0x0a>; /* SW_KEYPAD_SLIDE */
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_KEYPAD_SLIDE>;
 			wakeup-source;
 		};
=20
 		proximity_sensor {
 			label =3D "Proximity Sensor";
 			gpios =3D <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
-			linux,input-type =3D <5>; /* EV_SW */
-			linux,code =3D <0x0b>; /* SW_FRONT_PROXIMITY */
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_FRONT_PROXIMITY>;
 		};
 	};
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
