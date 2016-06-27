From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 19/27] ARM: dts: omap4-panda-common: remove unneded unit names
Date: Mon, 27 Jun 2016 15:21:00 -0400
Message-ID: <1467055268-13194-20-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap4-panda.dtb,
omap4-panda-a4.dtb and omap4-panda-es.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"
"encoder@1 has a unit name, but no reg property"
"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-panda-common.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index e1d606f64cb7..f8f13952cfeb 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -103,7 +103,7 @@
 		enable-active-high;
 	};
 
-	tfp410: encoder@0 {
+	tfp410: encoder0 {
 		compatible = "ti,tfp410";
 		powerdown-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;	/* gpio_0 */
 
@@ -114,7 +114,7 @@
 			port@0 {
 				reg = <0>;
 
-				tfp410_in: endpoint@0 {
+				tfp410_in: endpoint {
 					remote-endpoint = <&dpi_out>;
 				};
 			};
@@ -122,14 +122,14 @@
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
 
@@ -144,7 +144,7 @@
 		};
 	};
 
-	tpd12s015: encoder@1 {
+	tpd12s015: encoder1 {
 		compatible = "ti,tpd12s015";
 
 		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
@@ -158,7 +158,7 @@
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -166,14 +166,14 @@
 			port@1 {
 				reg = <1>;
 
-				tpd12s015_out: endpoint@0 {
+				tpd12s015_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
 		};
 	};
 
-	hdmi0: connector@1 {
+	hdmi0: connector1 {
 		compatible = "hdmi-connector";
 		label = "hdmi";
 
-- 
2.5.5
