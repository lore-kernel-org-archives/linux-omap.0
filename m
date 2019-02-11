From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap3-gta04: declare backlight in lcd node
Date: Mon, 11 Feb 2019 17:20:07 +0100
Message-ID: <20190211162007.15626-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

The lcd display of the gta04 has a backlight but the backlight
was not referenced in the lcd node, so screen blanking did
not turn off the backlight. Fix that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
the backlight property for the driver was accepted here:
https://lore.kernel.org/lkml/a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com/

 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 8c55d33ff694..3b88eb5f1a72 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -142,6 +142,7 @@
 			spi-cpol;
 			spi-cpha;
 
+			backlight= <&backlight>;
 			label = "lcd";
 			port {
 				lcd_in: endpoint {
@@ -151,7 +152,7 @@
 		};
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm11 0 12000000 0>;
 		pwm-names = "backlight";
-- 
2.11.0
