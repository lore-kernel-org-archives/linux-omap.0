From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] ARM: dts: n900: Add aliases for lcd and tvout displays
Date: Wed,  3 Jan 2018 00:17:14 +0200
Message-ID: <1514931434-13192-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

When both lcd and tv are enabled, the order in which they will be probed is
unknown, so it might happen (and it happens in reality) that tv is
configured as display0 and lcd as display1, which results in nothing
displayed on lcd, as display1 is disabled by default.

Fix that by providing correct aliases for lcd and tv

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 669c51c..4b9c3a7 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -35,6 +35,8 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		display0 = &lcd;
+		display1 = &tv;
 	};
 
 	cpus {
@@ -965,7 +967,7 @@
 		ti,esd-recovery-timeout-ms = <8000>;
 	};
 
-	acx565akm@2 {
+	lcd: acx565akm@2 {
 		compatible = "sony,acx565akm";
 		spi-max-frequency = <6000000>;
 		reg = <2>;
-- 
1.9.1
