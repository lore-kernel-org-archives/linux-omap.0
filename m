From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 20/27] ARM: dts: omap4-sdp: remove unneded unit names
Date: Mon, 27 Jun 2016 15:21:01 -0400
Message-ID: <1467055268-13194-21-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap4-sdp.dtb
and omap4-sdp-es23plus.dtb:

"encoder@0 has a unit name, but no reg property"
"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-sdp.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7e6cd2d8ed5d..10d73a784050 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -160,7 +160,7 @@
 		enable-active-high;
 	};
 
-	tpd12s015: encoder@0 {
+	tpd12s015: encoder {
 		compatible = "ti,tpd12s015";
 
 		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
@@ -174,7 +174,7 @@
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -182,14 +182,14 @@
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
