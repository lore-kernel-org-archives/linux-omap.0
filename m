From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 14/19] ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
Date: Mon, 12 May 2014 12:12:25 +0300
Message-ID: <fdeddff24bc38efb7a155b2569a5f2056278cb9d.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbaELJNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:13:01 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds a simple-card sound node for HDMI audio, the associated
hdmi-codec node, and sound-dai-cells propeties to the DAI nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index d2c45bf..c04f453 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -41,7 +41,7 @@
 		};
 	};
 
-	sound: sound {
+	sound: sound@0 {
 		compatible = "ti,abe-twl6040";
 		ti,model = "PandaBoard";
 
@@ -65,6 +65,24 @@
 			"AFMR", "Line In";
 	};
 
+	sound@1 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,cpu {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi_audio>;
+		};
+	};
+
+	hdmi_audio: hdmi_audio@0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,hdmi-audio";
+		status = "okay";
+	};
+
 	/* HS USB Port 1 Power */
 	hsusb1_power: hsusb1_power_reg {
 		compatible = "regulator-fixed";
@@ -512,6 +530,7 @@
 };
 
 &hdmi {
+	#sound-dai-cells = <0>;
 	status = "ok";
 	vdda-supply = <&vdac>;
 
-- 
1.7.9.5

