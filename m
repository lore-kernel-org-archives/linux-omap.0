From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 12/14] ASoC: twl4030: Convert to use devm_kzalloc
Date: Mon, 10 Sep 2012 13:46:30 +0300
Message-ID: <1347273992-9107-13-git-send-email-peter.ujfalusi@ti.com>
References: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37343 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757212Ab2IJKqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 06:46:50 -0400
Received: by obbuo13 with SMTP id uo13so2659030obb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 03:46:48 -0700 (PDT)
In-Reply-To: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Tero Kristo <t-kristo@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, linux-kernel@vger.kernel.org

Allocate the private data with devm_kzalloc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 27ccea4..413e698 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2231,7 +2231,8 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
 	struct twl4030_priv *twl4030;
 
-	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
+	twl4030 = devm_kzalloc(codec->dev, sizeof(struct twl4030_priv),
+			       GFP_KERNEL);
 	if (twl4030 == NULL) {
 		dev_err(codec->dev, "Can not allocate memory\n");
 		return -ENOMEM;
@@ -2253,7 +2254,6 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 	/* Reset registers to their chip default before leaving */
 	twl4030_reset_registers(codec);
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	kfree(twl4030);
 
 	if (pdata && pdata->hs_extmute && gpio_is_valid(pdata->hs_extmute_gpio))
 		gpio_free(pdata->hs_extmute_gpio);
-- 
1.7.12

