From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz
Date: Mon,  5 Sep 2016 11:16:38 +0200
Message-ID: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, marek@goldelico.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This helps to get 100% intensity closer to "always on".

It compensates for an effect of dmtimer which at 100% still emits short
"off" impulses and the startup-time of the DC/DC converter makes
backlight intensity not reach full scale. The lower the PWM frequency
is, the smaller is this effect.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index c09a057..94f12dd 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -102,7 +102,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm11 0 2000000 0>;
+		pwms = <&pwm11 0 12000000 0>;
 		pwm-names = "backlight";
 		brightness-levels = <0 11 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <9>;	/* => 90 */
-- 
2.7.3
