From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/9] ASoC: omap-abe-twl6040: DAI link selection based on platform data
Date: Thu, 22 Dec 2011 18:38:19 +0200
Message-ID: <1324571902-16918-7-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39570 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755428Ab1LVQix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 11:38:53 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id u2so4293149lag.37
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 08:38:52 -0800 (PST)
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

We can have machines without DMIC connected. In this case there is
no need to create amother (unusable) capture PCM on the card.
The existence of the DMIC connection can be checked via
pdata->has_dmic.
Select the correct dai_link structure for the card based on
pdata->has_dmic.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index cf3cb08..9e6e4c2 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -212,7 +212,7 @@ static int omapabe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link sdp4430_dai[] = {
+static struct snd_soc_dai_link twl6040_dmic_dai[] = {
 	{
 		.name = "TWL6040",
 		.stream_name = "TWL6040",
@@ -235,11 +235,21 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
 	},
 };
 
+static struct snd_soc_dai_link twl6040_only_dai[] = {
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
 	.dapm_routes = audio_map,
@@ -266,6 +276,14 @@ static __devinit int omapabe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (pdata->has_dmic) {
+		card->dai_link = twl6040_dmic_dai;
+		card->num_links = ARRAY_SIZE(twl6040_dmic_dai);
+	} else {
+		card->dai_link = twl6040_only_dai;
+		card->num_links = ARRAY_SIZE(twl6040_only_dai);
+	}
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-- 
1.7.8.1

