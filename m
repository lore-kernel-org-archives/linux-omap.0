From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 REPOST 4/8] ASoC: hdmi-codec: Add devicetree binding with documentation
Date: Fri, 20 Dec 2013 12:40:16 +0200
Message-ID: <16c91c4504cd5fa699f04236ef17e84bd23459d6.1387535303.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831Ab3LTKkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 05:40:47 -0500
In-Reply-To: <cover.1387535299.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, bcousson@baylibre.com
Cc: broonie@kernel.org, Jyri Sarha <jsarha@ti.com>

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

