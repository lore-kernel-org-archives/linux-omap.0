From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/7] ARM: dts: am335x-icev2: Disable Industrial I/O LEDs and fix naming
Date: Fri, 7 Oct 2016 09:44:23 -0500
Message-ID: <20161007144428.16671-2-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007144428.16671-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The LEDs tied to the Industrial I/O output pins are meant for providing
status feed-back and are not the primary use for the pins. Disable
this use by default. Also unify the LED naming across IDK platforms.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-icev2.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index d46efc6..fa3f5dc 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -43,52 +43,52 @@
 		enable-active-high;
 	};
 
-	leds0 {
+	leds-iio {
+		status = "disabled";
 		compatible = "gpio-leds";
-
-		led0 {
+		led-out0 {
 			label = "out0";
 			gpios = <&tpic2810 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led1 {
+		led-out1 {
 			label = "out1";
 			gpios = <&tpic2810 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led2 {
+		led-out2 {
 			label = "out2";
 			gpios = <&tpic2810 2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led3 {
+		led-out3 {
 			label = "out3";
 			gpios = <&tpic2810 3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led4 {
+		led-out4 {
 			label = "out4";
 			gpios = <&tpic2810 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led5 {
+		led-out5 {
 			label = "out5";
 			gpios = <&tpic2810 5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led6 {
+		led-out6 {
 			label = "out6";
 			gpios = <&tpic2810 6 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		led7 {
+		led-out7 {
 			label = "out7";
 			gpios = <&tpic2810 7 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
