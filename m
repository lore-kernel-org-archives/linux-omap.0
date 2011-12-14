From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/10] ASoC: omap-abe-twl6040: Add support for PandaBoard
Date: Wed, 14 Dec 2011 11:47:00 +0200
Message-ID: <1323856022-24053-8-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33418 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661Ab1LNJtT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:19 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id u2so262174lag.23
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:17 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

PandaBoard has a bit different set of audio features compared
to SDP4430:
- No DMIC
- Earphone pins are not connected
- Vibra is not connected

On PandaBoard 4430:
- FM receiver is connected to AFML/R input
- FM transmitter is connected to AUXL/R output
- Input jack is connected as to HSMIC

On PandaBoard ES:
- FM receiver/transmitter is not connected
- Input jack is connected to AFML/R

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig            |    5 ++-
 sound/soc/omap/omap-abe-twl6040.c |   82 ++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 98410b8..3463ee2 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -99,7 +99,8 @@ config SND_OMAP_SOC_SDP3430
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	depends on TWL4030_CORE && SND_OMAP_SOC
+	depends on MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
@@ -108,6 +109,8 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  Say Y if you want to add support for SoC audio on OMAP boards using
 	  ABE and twl6040 codec. This driver currently supports:
 	  - SDP4430/Blaze boards
+	  - PandaBoard 4430
+	  - PandaBoard ES (4460)
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 4974ea1..25a75f3 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -119,9 +119,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
 	SND_SOC_DAPM_INPUT("FM Stereo In"),
+	SND_SOC_DAPM_LINE("FM Stereo Out", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route sdp4430_audio_map[] = {
 	/* External Mics: MAINMIC, SUBMIC with bias*/
 	{"MAINMIC", NULL, "Main Mic Bias"},
 	{"SUBMIC", NULL, "Main Mic Bias"},
@@ -147,6 +149,42 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"AFMR", NULL, "FM Stereo In"},
 };
 
+static const struct snd_soc_dapm_route panda_audio_map[] = {
+	/* External Speakers: HFL, HFR  - through expansion connector */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset Mic: HSMIC with bias */
+	{"HSMIC", NULL, "Headset Mic Bias"},
+	{"Headset Mic Bias", NULL, "Headset Mic"},
+
+	/* Headset Stereophone (Headphone): HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+
+	/* Aux/FM Stereo In: AFML, AFMR */
+	{"AFML", NULL, "FM Stereo In"},
+	{"AFMR", NULL, "FM Stereo In"},
+
+	/* AUXL/R output to FM transmitter */
+	{"FM Stereo Out", NULL, "AUXL"},
+	{"FM Stereo Out", NULL, "AUXR"},
+};
+
+static const struct snd_soc_dapm_route pandaes_audio_map[] = {
+	/* External Speakers: HFL, HFR  - through expansion connector */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset Stereophone (Headphone): HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
+
+	/* Line in jack: AFML, AFMR */
+	{"AFML", NULL, "Line In"},
+	{"AFMR", NULL, "Line In"},
+};
+
 static int omapabe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -225,15 +263,23 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
 	},
 };
 
+static struct snd_soc_dai_link panda_dai[] = {
+	{
+		.name = "TWL6040",
+		.stream_name = "TWL6040",
+		.cpu_dai_name = "omap-mcpdm",
+		.codec_dai_name = "twl6040-legacy",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl6040-codec",
+		.init = omapabe_twl6040_init,
+		.ops = &omapabe_ops,
+	},
+};
+
 /* Audio machine driver */
 static struct snd_soc_card omapabe_card = {
-	.dai_link = sdp4430_dai,
-	.num_links = ARRAY_SIZE(sdp4430_dai),
-
 	.dapm_widgets = twl6040_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static __devinit int omapabe_probe(struct platform_device *pdev)
@@ -256,6 +302,30 @@ static __devinit int omapabe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	switch (pdata->board) {
+	case OMAP_ABE_TWL6040_SDP4430:
+		card->dai_link = sdp4430_dai;
+		card->num_links = ARRAY_SIZE(sdp4430_dai);
+		card->dapm_routes = sdp4430_audio_map;
+		card->num_dapm_routes = ARRAY_SIZE(sdp4430_audio_map);
+		break;
+	case OMAP_ABE_TWL6040_PANDA:
+		card->dai_link = panda_dai;
+		card->num_links = ARRAY_SIZE(panda_dai);
+		card->dapm_routes = panda_audio_map;
+		card->num_dapm_routes = ARRAY_SIZE(panda_audio_map);
+		break;
+	case OMAP_ABE_TWL6040_PANDA_ES:
+		card->dai_link = panda_dai;
+		card->num_links = ARRAY_SIZE(panda_dai);
+		card->dapm_routes = pandaes_audio_map;
+		card->num_dapm_routes = ARRAY_SIZE(pandaes_audio_map);
+		break;
+	default:
+		dev_err(&pdev->dev, "Invalid board type: %d\n", pdata->board);
+		return -ENODEV;
+	}
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-- 
1.7.8

