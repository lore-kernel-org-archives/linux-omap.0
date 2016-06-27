From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 13/27] ARM: dts: omap3-igep0020-common: remove unneded unit names
Date: Mon, 27 Jun 2016 15:20:54 -0400
Message-ID: <1467055268-13194-14-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-igep0020.dtb
and omap3-igep0020-rev-f.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index b6971060648a..667f96245729 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -60,7 +60,7 @@
 		vcc-supply = <&hsusb1_power>;
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder {
 		compatible = "ti,tfp410";
 		powerdown-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>; /* gpio_170 */
 
@@ -71,7 +71,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
 				};
 			};
@@ -79,14 +79,14 @@
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
+	dvi0: connector {
 		compatible = "dvi-connector";
 		label = "dvi";
 
-- 
2.5.5
