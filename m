From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 14/27] ARM: dts: omap3-overo-common-dvi: remove unneded unit names
Date: Mon, 27 Jun 2016 15:20:55 -0400
Message-ID: <1467055268-13194-15-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-overo-summit.dtb,
omap3-overo-storm-tobi.dtb, omap3-overo-storm-summit.dtb and
omap3-overo-tobi.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi b/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
index 802f704f67e5..ae5564abbe2f 100644
--- a/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
@@ -69,7 +69,7 @@
 		display0 = &dvi0;
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder {
 		compatible = "ti,tfp410";
 
 		ports {
@@ -79,7 +79,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
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
+	dvi0: connector {
 		compatible = "dvi-connector";
 		label = "dvi";
 
-- 
2.5.5
