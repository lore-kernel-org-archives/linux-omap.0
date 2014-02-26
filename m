From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 3/5] ASoC: tlv320aic31xx: Add DT binding document
Date: Wed, 26 Feb 2014 11:14:27 +0200
Message-ID: <a72a69de5c86ee9e0931bac8d42cd72e4bee1a6b.1393405575.git.jsarha@ti.com>
References: <cover.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbaBZJOx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 04:14:53 -0500
In-Reply-To: <cover.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Initial version of tlv320aic31xx device tree bindings document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
new file mode 100644
index 0000000..a512b4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -0,0 +1,57 @@
+Texas Instruments - tlv320aic31xx Codec module
+
+The tlv320aic31xx serial control bus communicates through I2C protocols
+
+Required properties:
+
+- compatible - "string" - One of:
+    "ti,tlv320aic310x" - Generic TLV320AIC31xx with mono speaker amp
+    "ti,tlv320aic311x" - Generic TLV320AIC31xx with stereo speaker amp
+    "ti,tlv320aic3100" - TLV320AIC3100 (mono speaker amp, no MiniDSP)
+    "ti,tlv320aic3110" - TLV320AIC3110 (stereo speaker amp, no MiniDSP)
+    "ti,tlv320aic3120" - TLV320AIC3120 (mono speaker amp, MiniDSP)
+    "ti,tlv320aic3111" - TLV320AIC3111 (stereo speaker amp, MiniDSP)
+
+- reg - <int> -  I2C slave address
+
+
+Optional properties:
+
+- gpio-reset - gpio pin number used for codec reset
+- ai31xx-micbias-vg - MicBias Voltage required.
+	1 - MICBIAS output is powered to 2.0V,
+	2 - MICBIAS output is powered to 2.5V,
+	3 - MICBIAS output is connected to AVDD,
+	If this node is not mentioned or if the value is incorrect, then MicBias
+	is powered down.
+- HPVDD-supply, SPRVDD-supply, SPLVDD-supply, AVDD-supply, IOVDD-supply,
+  DVDD-supply : power supplies for the device as covered in
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+CODEC output pins:
+  * HPL
+  * HPR
+  * SPL, devices with stereo speaker amp
+  * SPR, devices with stereo speaker amp
+  * SPK, devices with mono speaker amp
+
+CODEC input pins:
+  * MIC1LP
+  * MIC1RP
+  * MIC1LM
+
+The pins can be used in referring sound node's audio-routing property.
+
+Example:
+
+tlv320aic31xx: tlv320aic31xx@18 {
+	compatible = "ti,tlv320aic311x";
+	reg = <0x18>;
+
+	HPVDD-supply = <&regulator>;
+	SPRVDD-supply = <&regulator>;
+	SPLVDD-supply = <&regulator>;
+	AVDD-supply = <&regulator>;
+	IOVDD-supply = <&regulator>;
+	DVDD-supply = <&regulator>;
+};
-- 
1.7.9.5

