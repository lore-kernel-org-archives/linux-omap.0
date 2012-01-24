From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 11/13] ASoC: omap-abe-twl6040: Use provided MCLK frequency from pdata
Date: Tue, 24 Jan 2012 13:52:28 +0200
Message-ID: <1327405950-6676-12-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:54512 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756444Ab2AXLxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:53:07 -0500
Received: by lagy4 with SMTP id y4so1676930lag.11
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:53:05 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Avoid using hardwired configuration for MCLK frequency.
Different board design might use other MCLK frequency.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 91ea873..2e283d4 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -45,12 +45,15 @@ static int omapabe_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
 	int clk_id, freq;
 	int ret;
 
 	clk_id = twl6040_get_clk_id(rtd->codec);
 	if (clk_id == TWL6040_SYSCLK_SEL_HPPLL)
-		freq = 38400000;
+		freq = pdata->mclk_freq;
 	else if (clk_id == TWL6040_SYSCLK_SEL_LPPLL)
 		freq = 32768;
 	else
@@ -298,6 +301,11 @@ static __devinit int omapabe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (!pdata->mclk_freq) {
+		dev_err(&pdev->dev, "MCLK frequency missing\n");
+		return -ENODEV;
+	}
+
 	if (pdata->has_dmic) {
 		card->dai_link = twl6040_dmic_dai;
 		card->num_links = ARRAY_SIZE(twl6040_dmic_dai);
-- 
1.7.8.3

