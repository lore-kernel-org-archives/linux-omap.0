From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 10/10] ARM: dts: omap4-droid4: update backlight led-controller
Date: Fri, 30 Mar 2018 19:24:14 +0200
Message-ID: <20180330172414.26575-11-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sre@kernel.org>

This updates the backlight led-controller node to follow the
new binding instead of the legacy out-of-tree binding.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 3ed090a9db6c..da1571c24039 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -380,20 +380,24 @@
 };
 
 &i2c1 {
-	lm3532@38 {
+	led-controller@38 {
 		compatible = "ti,lm3532";
 		reg = <0x38>;
 
 		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
 
-		lcd_backlight: backlight {
-			compatible = "ti,lm3532-backlight";
+		lcd_backlight: bank0 {
+			label = "lcd";
+			ti,led-sources = <0>;
+			ti,ramp-up-ms = <1>;
+			ti,ramp-down-ms = <0>;
+		};
 
-			lcd {
-				led-sources = <0 1 2>;
-				ramp-up-msec = <1>;
-				ramp-down-msec = <0>;
-			};
+		keyboard_backlight: bank1 {
+			label = "keyboard";
+			ti,led-sources = <1>;
+			ti,ramp-up-msec = <1>;
+			ti,ramp-down-msec = <0>;
 		};
 	};
 };
-- 
2.16.2
