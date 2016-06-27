From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 16/27] ARM: dts: sbc-t3x30: remove unneded unit names
Date: Mon, 27 Jun 2016 15:20:57 -0400
Message-ID: <1467055268-13194-17-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-sbc-t3517.dtb,
omap3-sbc-t3530.dtb and omap3-sbc-t3730.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-sb-t35.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 827f614261f6..73643fabde5d 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -3,7 +3,7 @@
  */
 
 / {
-	tfp410: encoder@0 {
+	tfp410: encoder {
 		compatible = "ti,tfp410";
 
 		powerdown-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;  /* gpio_54 */
@@ -18,7 +18,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
 				};
 			};
@@ -26,14 +26,14 @@
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
