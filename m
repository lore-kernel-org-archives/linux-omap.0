From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 03/13] ASoC: omap-abe-twl6040: Correct internal prefix, Kconfig entry
Date: Tue, 24 Jan 2012 13:52:20 +0200
Message-ID: <1327405950-6676-4-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:42856 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756403Ab2AXLwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:52:51 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p5so2213471lag.38
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:52:50 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Change the internal prefixes within the driver from sdp4430.
At he same time correct the Kconfig text as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/Kconfig            |    7 ++--
 sound/soc/omap/omap-abe-twl6040.c |   65 +++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4eae929..98410b8 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -98,15 +98,16 @@ config SND_OMAP_SOC_SDP3430
 	  SDP3430.
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
-	tristate "SoC Audio support for Texas Instruments SDP4430"
+	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
 	select SND_SOC_DMIC
 	help
-	  Say Y if you want to add support for SoC audio on Texas Instruments
-	  SDP4430.
+	  Say Y if you want to add support for SoC audio on OMAP boards using
+	  ABE and twl6040 codec. This driver currently supports:
+	  - SDP4430/Blaze boards
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index ceadb13..5598165 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -1,5 +1,6 @@
 /*
- * sdp4430.c  --  SoC audio for TI OMAP4430 SDP
+ * omap-abe-twl6040.c  --  SoC audio for TI OMAP based boards with ABE and
+ *			   twl6040 codec
  *
  * Author: Misael Lopez Cruz <misael.lopez@ti.com>
  *
@@ -38,7 +39,7 @@
 #include "omap-pcm.h"
 #include "../codecs/twl6040.h"
 
-static int sdp4430_hw_params(struct snd_pcm_substream *substream,
+static int omapabe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -64,11 +65,11 @@ static int sdp4430_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops sdp4430_ops = {
-	.hw_params = sdp4430_hw_params,
+static struct snd_soc_ops omapabe_ops = {
+	.hw_params = omapabe_hw_params,
 };
 
-static int sdp4430_dmic_hw_params(struct snd_pcm_substream *substream,
+static int omapabe_dmic_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -90,8 +91,8 @@ static int sdp4430_dmic_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops sdp4430_dmic_ops = {
-	.hw_params = sdp4430_dmic_hw_params,
+static struct snd_soc_ops omapabe_dmic_ops = {
+	.hw_params = omapabe_dmic_hw_params,
 };
 
 /* Headset jack */
@@ -110,7 +111,7 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 };
 
 /* SDP4430 machine DAPM */
-static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Ext Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -145,7 +146,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"AFMR", NULL, "FM Stereo In"},
 };
 
-static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
+static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	int ret, hs_trim;
@@ -175,7 +176,7 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static const struct snd_soc_dapm_widget sdp4430_dmic_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Digital Mic", NULL),
 };
 
@@ -184,14 +185,14 @@ static const struct snd_soc_dapm_route dmic_audio_map[] = {
 	{"Digital Mic1 Bias", NULL, "Digital Mic"},
 };
 
-static int sdp4430_dmic_init(struct snd_soc_pcm_runtime *rtd)
+static int omapabe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	ret = snd_soc_dapm_new_controls(dapm, sdp4430_dmic_dapm_widgets,
-				ARRAY_SIZE(sdp4430_dmic_dapm_widgets));
+	ret = snd_soc_dapm_new_controls(dapm, dmic_dapm_widgets,
+				ARRAY_SIZE(dmic_dapm_widgets));
 	if (ret)
 		return ret;
 
@@ -208,8 +209,8 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
 		.codec_dai_name = "twl6040-legacy",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl6040-codec",
-		.init = sdp4430_twl6040_init,
-		.ops = &sdp4430_ops,
+		.init = omapabe_twl6040_init,
+		.ops = &omapabe_ops,
 	},
 	{
 		.name = "DMIC",
@@ -218,27 +219,27 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "dmic-codec",
-		.init = sdp4430_dmic_init,
-		.ops = &sdp4430_dmic_ops,
+		.init = omapabe_dmic_init,
+		.ops = &omapabe_dmic_ops,
 	},
 };
 
 /* Audio machine driver */
-static struct snd_soc_card snd_soc_sdp4430 = {
+static struct snd_soc_card omapabe_card = {
 	.name = "SDP4430",
 	.owner = THIS_MODULE,
 	.dai_link = sdp4430_dai,
 	.num_links = ARRAY_SIZE(sdp4430_dai),
 
-	.dapm_widgets = sdp4430_twl6040_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(sdp4430_twl6040_dapm_widgets),
+	.dapm_widgets = twl6040_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static struct platform_device *sdp4430_snd_device;
+static struct platform_device *omapabe_snd_device;
 
-static int __init sdp4430_soc_init(void)
+static int __init omapabe_soc_init(void)
 {
 	int ret;
 
@@ -246,15 +247,15 @@ static int __init sdp4430_soc_init(void)
 		return -ENODEV;
 	printk(KERN_INFO "SDP4430 SoC init\n");
 
-	sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!sdp4430_snd_device) {
+	omapabe_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omapabe_snd_device) {
 		printk(KERN_ERR "Platform device allocation failed\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(sdp4430_snd_device, &snd_soc_sdp4430);
+	platform_set_drvdata(omapabe_snd_device, &omapabe_card);
 
-	ret = platform_device_add(sdp4430_snd_device);
+	ret = platform_device_add(omapabe_snd_device);
 	if (ret)
 		goto err;
 
@@ -262,18 +263,18 @@ static int __init sdp4430_soc_init(void)
 
 err:
 	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(sdp4430_snd_device);
+	platform_device_put(omapabe_snd_device);
 	return ret;
 }
-module_init(sdp4430_soc_init);
+module_init(omapabe_soc_init);
 
-static void __exit sdp4430_soc_exit(void)
+static void __exit omapabe_soc_exit(void)
 {
-	platform_device_unregister(sdp4430_snd_device);
+	platform_device_unregister(omapabe_snd_device);
 }
-module_exit(sdp4430_soc_exit);
+module_exit(omapabe_soc_exit);
 
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
-MODULE_DESCRIPTION("ALSA SoC SDP4430");
+MODULE_DESCRIPTION("ALSA SoC for OMAP boards with ABE and twl6040 codec");
 MODULE_LICENSE("GPL");
 
-- 
1.7.8.3

