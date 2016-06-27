From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 26/27] ARM: dts: omap5-board-common: remove unneded unit names
Date: Mon, 27 Jun 2016 15:21:07 -0400
Message-ID: <1467055268-13194-27-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap5-igep0050.dtb,
omap5-sbc-t54.dtb and omap5-uevm.dtb:

"connector@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"encoder@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap5-board-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index df774f9bd7cc..5196113202a2 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -87,7 +87,7 @@
 		};
 	};
 
-	tpd12s015: encoder@0 {
+	tpd12s015: encoder {
 		compatible = "ti,tpd12s015";
 
 		pinctrl-names = "default";
@@ -102,7 +102,7 @@
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -110,14 +110,14 @@
 			port@1 {
 				reg = <1>;
 
-				tpd12s015_out: endpoint@0 {
+				tpd12s015_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
 		};
 	};
 
-	hdmi0: connector@0 {
+	hdmi0: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
 
-- 
2.5.5
