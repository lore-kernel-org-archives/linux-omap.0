From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 05/27] ARM: dts: omap3-beagle: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:46 -0400
Message-ID: <1467055268-13194-6-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-beagle.dtb:

"encoder@0 has a unit name, but no reg property"
"encoder@0/ports/port@0/endpoint@0 has a unit name, but no reg property"
"encoder@0/ports/port@1/endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-beagle.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a4deff0e2d52..a19d907d4850 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -85,7 +85,7 @@
 
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder0 {
 		compatible = "ti,tfp410";
 		powerdown-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>;	/* gpio_170 */
 
@@ -99,7 +99,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
 				};
 			};
@@ -107,14 +107,14 @@
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
 
@@ -129,7 +129,7 @@
 		};
 	};
 
-	tv0: connector@1 {
+	tv0: connector1 {
 		compatible = "svideo-connector";
 		label = "tv";
 
-- 
2.5.5
