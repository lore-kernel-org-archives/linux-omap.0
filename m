From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ARM: dts: N900: GPIO key definitions
Date: Tue, 22 Oct 2013 14:49:38 +0200
Message-ID: <1382446178-27638-1-git-send-email-sre@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add device tree node for the GPIO keys provided by the
N900 board. This is a simple conversion of the existing
board code.

Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 30ac779..2841002 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -26,6 +26,54 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		camera_lens_cover {
+			label = "Camera Lens Cover";
+			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>; /* 110 */
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0x09>; /* SW_CAMERA_LENS_COVER */
+			gpio-key,wakeup;
+		};
+
+		camera_focus {
+			label = "Camera Focus";
+			gpios = <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
+			linux,code = <0x210>; /* KEY_CAMERA_FOCUS */
+			gpio-key,wakeup;
+		};
+
+		camera_capture {
+			label = "Camera Capture";
+			gpios = <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
+			linux,code = <0xd4>; /* KEY_CAMERA */
+			gpio-key,wakeup;
+		};
+
+		lock_button {
+			label = "Lock Button";
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
+			linux,code = <0x98>; /* KEY_SCREENLOCK */
+			gpio-key,wakeup;
+		};
+
+		keypad_slide {
+			label = "Keypad Slide";
+			gpios = <&gpio3 7 GPIO_ACTIVE_LOW>; /* 71 */
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0x0a>; /* SW_KEYPAD_SLIDE */
+			gpio-key,wakeup;
+		};
+
+		proximity_sensor {
+			label = "Proximity Sensor";
+			gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0x0b>; /* SW_FRONT_PROXIMITY */
+		};
+	};
+
 };
 
 &omap3_pmx_core {
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
