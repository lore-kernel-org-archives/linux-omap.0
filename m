From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 06/27] ARM: dts: omap3-beagle-xm: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:47 -0400
Message-ID: <1467055268-13194-7-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-beagle-xm.dtb:

"encoder@0 has a unit name, but no reg property"
"encoder@0/ports/port@0/endpoint@0 has a unit name, but no reg property"
"encoder@0/ports/port@1/endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-beagle-xm.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 01e1e2d5c735..8ffde06281ad 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -91,7 +91,7 @@
 		vcc-supply = <&hsusb2_power>;
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder0 {
 		compatible = "ti,tfp410";
 		powerdown-gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
 
@@ -104,7 +104,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
 				};
 			};
@@ -112,14 +112,14 @@
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
 
@@ -134,7 +134,7 @@
 		};
 	};
 
-	tv0: connector@1 {
+	tv0: connector1 {
 		compatible = "svideo-connector";
 		label = "tv";
 
-- 
2.5.5
