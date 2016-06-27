From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/27] ARM: dts: omap3-devkit8000: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:49 -0400
Message-ID: <1467055268-13194-9-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-devkit8000.dtb,
omap3-devkit8000-lcd43.dtb and omap3-devkit8000-lcd70.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-devkit8000-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index b1b8ebf90c1c..586010179752 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -68,7 +68,7 @@
 		};
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder0 {
 		compatible = "ti,tfp410";
 		powerdown-gpios = <&twl_gpio 7 GPIO_ACTIVE_LOW>;
 
@@ -79,7 +79,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_dvi_out>;
 				};
 			};
@@ -87,14 +87,14 @@
 			port@1 {
 				reg = <1>;
 
-				tfp410_out: endpoint@0 {
+				tfp410_out: endpoint {
 					remote-endpoint = <&dvi_connector_in>;
 				};
 			};
 		};
 	};
 
-	dvi0: connector@0 {
+	dvi0: connector0 {
 		compatible = "dvi-connector";
 		label = "dvi";
 
@@ -109,7 +109,7 @@
 		};
 	};
 
-	tv0: connector@1 {
+	tv0: connector1 {
 		compatible = "svideo-connector";
 		label = "tv";
 
@@ -352,7 +352,7 @@
 	vdda_dac-supply = <&vdac>;
 
 	port {
-		dpi_dvi_out: endpoint@0 {
+		dpi_dvi_out: endpoint {
 			remote-endpoint = <&tfp410_in>;
 			data-lines = <24>;
 		};
-- 
2.5.5
