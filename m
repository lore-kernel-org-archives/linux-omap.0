From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 16/19] ARM: omap5-uevm.dts: Add hdmi audio related nodes
Date: Mon, 12 May 2014 12:12:27 +0300
Message-ID: <8f1b49f42fe2da2f637e4e4753c0d3253e108170.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40803 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769AbaELJNF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:13:05 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds a simple-card sound node for HDMI audio, the associated
hdmi-codec node, and sound-dai-cells propeties to the DAI nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index f625a87..42d625b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -561,6 +561,24 @@
 			};
 		};
 	};
+
+	sound@0 {
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
 };
 
 &dss {
@@ -568,6 +586,7 @@
 };
 
 &hdmi {
+	#sound-dai-cells = <0>;
 	status = "ok";
 	vdda-supply = <&ldo4_reg>;
 
-- 
1.7.9.5

