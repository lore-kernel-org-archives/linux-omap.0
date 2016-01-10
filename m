From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
Date: Sun, 10 Jan 2016 19:46:30 +0200
Message-ID: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Add linux,can-disable; to all gpios exported from gpio-keys driver, so
userspace can disable them

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 8ea924c..b58e8a0 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -68,6 +68,7 @@
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_CAMERA_LENS_COVER>;
 			gpio-key,wakeup;
+			linux,can-disable;
 		};
 
 		camera_focus {
@@ -75,6 +76,7 @@
 			gpios = <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
 			linux,code = <KEY_CAMERA_FOCUS>;
 			gpio-key,wakeup;
+			linux,can-disable;
 		};
 
 		camera_capture {
@@ -82,6 +84,7 @@
 			gpios = <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
 			linux,code = <KEY_CAMERA>;
 			gpio-key,wakeup;
+			linux,can-disable;
 		};
 
 		lock_button {
@@ -89,6 +92,7 @@
 			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
 			linux,code = <KEY_SCREENLOCK>;
 			gpio-key,wakeup;
+			linux,can-disable;
 		};
 
 		keypad_slide {
@@ -97,6 +101,7 @@
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_KEYPAD_SLIDE>;
 			gpio-key,wakeup;
+			linux,can-disable;
 		};
 
 		proximity_sensor {
@@ -104,6 +109,7 @@
 			gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_FRONT_PROXIMITY>;
+			linux,can-disable;
 		};
 	};
 
-- 
1.9.1
