From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 10/27] ARM: dts: omap3-gta04: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:51 -0400
Message-ID: <1467055268-13194-11-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-gta04a3.dtb,
omap3-gta04a4.dtb and omap3-gta04a5.dtb:

"dmtimer-pwm@11 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 3eb53bc493dd..c09a0574af90 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -110,7 +110,7 @@
 		pinctrl-0 = <&backlight_pins>;
 	};
 
-	pwm11: dmtimer-pwm@11 {
+	pwm11: dmtimer-pwm {
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
@@ -121,7 +121,7 @@
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	};
 
-	tv0: connector@1 {
+	tv0: connector {
 		compatible = "svideo-connector";
 		label = "tv";
 
@@ -142,14 +142,14 @@
 
 			port@0 {
 				reg = <0>;
-				opa_in: endpoint@0 {
+				opa_in: endpoint {
 					remote-endpoint = <&venc_out>;
 				};
 			};
 
 			port@1 {
 				reg = <1>;
-				opa_out: endpoint@0 {
+				opa_out: endpoint {
 					remote-endpoint = <&tv_connector_in>;
 				};
 			};
-- 
2.5.5
