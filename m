From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/2] DTS: ARM: OMAP3-N900: Add LP5523 support
Date: Tue, 22 Oct 2013 15:01:36 +0200
Message-ID: <1382446896-28436-3-git-send-email-sre@debian.org>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382446896-28436-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@linaro.org>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add support for LP5523 device.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 7688f6a..195e1eb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -230,6 +230,67 @@
 
 	clock-frequency = <100000>;
 
+	lp5523: lp5523@32 {
+		compatible = "national,lp5523";
+		reg = <0x32>;
+		clock-mode = /bits/ 8 <0>; /* LP55XX_CLOCK_AUTO */
+		enable-gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
+
+		chan0 {
+			chan-name = "lp5523:kb1";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan1 {
+			chan-name = "lp5523:kb2";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan2 {
+			chan-name = "lp5523:kb3";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan3 {
+			chan-name = "lp5523:kb4";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan4 {
+			chan-name = "lp5523:b";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan5 {
+			chan-name = "lp5523:g";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan6 {
+			chan-name = "lp5523:r";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan7 {
+			chan-name = "lp5523:kb5";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan8 {
+			chan-name = "lp5523:kb6";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+	};
+
 	bq27200: bq27200@55 {
 		compatible = "ti,bq27200";
 		reg = <0x55>;
-- 
1.8.4.rc3
