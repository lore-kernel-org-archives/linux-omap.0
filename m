From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/6] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Wed, 12 Jul 2017 17:18:42 +0200
Message-ID: <20170712151846.24621-3-sebastian.reichel@collabora.co.uk>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Motorola CPCAP is a PMIC with audio functionality, that can be
found on Motorola Droid 4 and probably a few other phones from
Motorola's Droid series.

This adds the DT binding for the codec sub-module found inside
the PMIC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../bindings/sound/motorola,cpcap-audio-codec.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
new file mode 100644
index 000000000000..6b8cd616bd46
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
@@ -0,0 +1,19 @@
+Motorola CPCAP audio CODEC
+--------------------------
+
+This module is part of the CPCAP. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
+
+Required properties:
+
+  - compatible : "motorola,cpcap-audio-codec"
+  - vdd-supply : Phandle to audio regulator
+
+Example:
+
+&cpcap {
+	audio-codec {
+		compatible = "motorola,cpcap-audio-codec";
+		vdd-supply = <&vaudio>;
+	};
+};
-- 
2.13.2
