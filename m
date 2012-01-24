From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 09/13] ASoC: omap-abe-twl6040: DAI link selection based on platform data
Date: Tue, 24 Jan 2012 13:52:26 +0200
Message-ID: <1327405950-6676-10-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50867 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756427Ab2AXLxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:53:03 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id c1so2926488lah.5
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:53:01 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

We can have machines without DMIC connected. In this case there is
no need to create amother (unusable) capture PCM on the card.
The existence of the DMIC connection can be checked via
pdata->has_dmic.
Select the correct dai_link structure for the card based on
pdata->has_dmic.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index d95bd82..7ad5b25 100644
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
@@ -235,11 +235,22 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
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
 	.owner = THIS_MODULE,
-	.dai_link = sdp4430_dai,
-	.num_links = ARRAY_SIZE(sdp4430_dai),
 
 	.dapm_widgets = twl6040_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
@@ -267,6 +278,14 @@ static __devinit int omapabe_probe(struct platform_device *pdev)
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
1.7.8.3

