From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 25/27] ARM: dts: omap5-cm-t54: remove unneded unit names and add reg properties
Date: Mon, 27 Jun 2016 15:21:06 -0400
Message-ID: <1467055268-13194-26-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap5-cm-t54.dtb:

"connector@0 has a unit name, but no reg property"
"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap5-cm-t54.dts | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 93fdfa96776e..a9765605d53b 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -112,7 +112,7 @@
                 };
         };
 
-	hdmi0: connector@0 {
+	hdmi0: connector0 {
 		compatible = "hdmi-connector";
 		label = "hdmi";
 
@@ -130,7 +130,7 @@
 		};
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder0 {
 		compatible = "ti,tfp410";
 
 		ports {
@@ -140,7 +140,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_dvi_out>;
 				};
 			};
@@ -148,14 +148,14 @@
 			port@1 {
 				reg = <1>;
 
-				tfp410_out: endpoint@0 {
+				tfp410_out: endpoint {
 					remote-endpoint = <&dvi_connector_in>;
 				};
 			};
 		};
 	};
 
-	dvi0: connector@1 {
+	dvi0: connector1 {
 		compatible = "dvi-connector";
 		label = "dvi";
 
@@ -646,12 +646,17 @@
 	pinctrl-0 = <&dss_dpi_pins>;
 
 	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		dpi_dvi_out: endpoint@0 {
+			reg = <0>;
 			remote-endpoint = <&tfp410_in>;
 			data-lines = <24>;
 		};
 
 		dpi_lcd_out: endpoint@1 {
+			reg = <1>;
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
-- 
2.5.5
