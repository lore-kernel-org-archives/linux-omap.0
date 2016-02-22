From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
Date: Mon, 22 Feb 2016 16:42:59 +0200
Message-ID: <1456152179-12558-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160212215326.GD19432@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160212215326.GD19432-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add linux,can-disable; to all gpios exported from gpio-keys driver, so
userspace can disable them

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 74d8f7eb..f01a151 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -68,6 +68,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x09>; /* SW_CAMERA_LENS_COVER */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		camera_focus {
@@ -75,6 +76,7 @@
 			gpios = <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
 			linux,code = <0x210>; /* KEY_CAMERA_FOCUS */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		camera_capture {
@@ -82,6 +84,7 @@
 			gpios = <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
 			linux,code = <0xd4>; /* KEY_CAMERA */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		lock_button {
@@ -89,6 +92,7 @@
 			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
 			linux,code = <0x98>; /* KEY_SCREENLOCK */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		keypad_slide {
@@ -97,6 +101,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x0a>; /* SW_KEYPAD_SLIDE */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		proximity_sensor {
@@ -104,6 +109,7 @@
 			gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x0b>; /* SW_FRONT_PROXIMITY */
+			linux,can-disable;
 		};
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
