From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 09/27] ARM: dts: omap3-devkit8000-lcd-common: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:50 -0400
Message-ID: <1467055268-13194-10-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-devkit8000-lcd43.dtb
and omap3-devkit8000-lcd70.dtb:

"display@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi | 4 ++--
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index 738910db5c0c..2d64bcffaaa8 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -14,7 +14,7 @@
 		display2 = &tv0;
 	};
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "panel-dpi";
 		label = "lcd";
 
@@ -30,7 +30,7 @@
 
 &dss {
 	port {
-		dpi_lcd_out: endpoint@1 {
+		dpi_lcd_out: endpoint {
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts b/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
index d5705356d52c..d8b16398bfb3 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
@@ -16,7 +16,7 @@
 	model = "TimLL OMAP3 Devkit8000 with 4.3'' LCD panel";
 	compatible = "timll,omap3-devkit8000", "ti,omap3";
 
-	lcd0: display@0 {
+	lcd0: display {
 		panel-timing {
 			clock-frequency = <10164705>;
 			hactive = <480>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts b/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
index 4afad4b233ec..edb37ba80498 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
@@ -16,7 +16,7 @@
 	model = "TimLL OMAP3 Devkit8000 with 7.0'' LCD panel";
 	compatible = "timll,omap3-devkit8000", "ti,omap3";
 
-	lcd0: display@0 {
+	lcd0: display {
 		panel-timing {
 			clock-frequency = <40000000>;
 			hactive = <800>;
-- 
2.5.5
