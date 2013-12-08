From: Jyri Sarha <jsarha@ti.com>
Subject: [RFC v2 4/8] ASoC: hdmi-codec: Add devicetree binding with documentation
Date: Sun, 8 Dec 2013 14:16:47 +0200
Message-ID: <16c91c4504cd5fa699f04236ef17e84bd23459d6.1386503348.git.jsarha@ti.com>
References: <cover.1386503347.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab3LHMRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Dec 2013 07:17:40 -0500
In-Reply-To: <cover.1386503347.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: bcousson@baylibre.com
---
 Documentation/devicetree/bindings/sound/hdmi.txt |   17 +++++++++++++++++
 sound/soc/codecs/hdmi.c                          |   10 ++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt

diff --git a/Documentation/devicetree/bindings/sound/hdmi.txt b/Documentation/devicetree/bindings/sound/hdmi.txt
new file mode 100644
index 0000000..31af7bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hdmi.txt
@@ -0,0 +1,17 @@
+Device-Tree bindings for dummy HDMI codec
+
+Required properties:
+	- compatible: should be "linux,hdmi-audio".
+
+CODEC output pins:
+  * TX
+
+CODEC input pins:
+  * RX
+
+Example node:
+
+	hdmi_audio: hdmi_audio@0 {
+		compatible = "linux,hdmi-audio";
+		status = "okay";
+	};
diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 32797a8..9cb1c7d 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -20,6 +20,7 @@
  */
 #include <linux/module.h>
 #include <sound/soc.h>
+#include <linux/of_device.h>
 
 #define DRV_NAME "hdmi-audio-codec"
 
@@ -60,6 +61,14 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id hdmi_audio_codec_ids[] = {
+	{ .compatible = "linux,hdmi-audio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
+#endif
+
 static struct snd_soc_codec_driver hdmi_codec = {
 	.dapm_widgets = hdmi_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
@@ -83,6 +92,7 @@ static struct platform_driver hdmi_codec_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(hdmi_audio_codec_ids),
 	},
 
 	.probe		= hdmi_codec_probe,
-- 
1.7.9.5

