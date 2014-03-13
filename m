From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Remove snd_soc_codec_set_cache_io() call
Date: Thu, 13 Mar 2014 18:22:35 +0200
Message-ID: <1394727755-7091-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbaCMQWu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 12:22:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, tiwai@suse.de, Jyri Sarha <jsarha@ti.com>

Remove snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP) call
and codec->control_data = aic31xx->regmap assignment since that
already done by core.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
This patch should fix the last minute breakkage of v3.15 ASoC updates build.

 sound/soc/codecs/tlv320aic31xx.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c9f6989..625b184 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1051,18 +1051,9 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
 
 	aic31xx = snd_soc_codec_get_drvdata(codec);
-	codec->control_data = aic31xx->regmap;
 
 	aic31xx->codec = codec;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
-
-	if (ret != 0) {
-		dev_err(codec->dev, "snd_soc_codec_set_cache_io failed %d\n",
-			ret);
-		return ret;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
 		aic31xx->disable_nb[i].nb.notifier_call =
 			aic31xx_regulator_event;
-- 
1.7.9.5

