From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 04/32] ARM: dts: omap3-gta04: fixes for tvout / venc
Date: Wed, 25 Jul 2018 08:58:36 +0200
Message-ID: <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* fix connector compatibility (composite)
* add comment for gpio1 23
* fix port reg number
* add proper #address-cells
* we use only one venc_out channel
* fix invert-polarity for the VENC since we have an inverting OPA362 Amplifier

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 2db670e2a4bd..fa887743860e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -131,7 +131,7 @@
 	};
 
 	tv0: connector {
-		compatible = "svideo-connector";
+		compatible = "composite-video-connector";
 		label = "tv";
 
 		port {
@@ -143,7 +143,7 @@
 
 	tv_amp: opa362 {
 		compatible = "ti,opa362";
-		enable-gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;	/* GPIO_23 to enable video out amplifier */
 
 		ports {
 			#address-cells = <1>;
@@ -157,7 +157,7 @@
 			};
 
 			port@1 {
-				reg = <1>;
+				reg = <0>;
 				opa_out: endpoint {
 					remote-endpoint = <&tv_connector_in>;
 				};
@@ -551,10 +551,14 @@
 
 	vdda-supply = <&vdac>;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	port {
+		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
-			ti,channels = <2>;
+			ti,channels = <1>;
 			ti,invert-polarity;
 		};
 	};
-- 
2.12.2
