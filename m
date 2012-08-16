From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/9] ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
Date: Thu, 16 Aug 2012 16:41:03 +0300
Message-ID: <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56665 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753853Ab2HPNlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 09:41:11 -0400
Received: by qatk31 with SMTP id k31so804771qat.16
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 06:41:09 -0700 (PDT)
In-Reply-To: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

The muxing is done at board level, no need to do it in the ASoC machine
driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/am3517evm.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 009533a..a997988 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -47,26 +47,10 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 	/* Set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 			CODEC_CLOCK, SND_SOC_CLOCK_IN);
-	if (ret < 0) {
+	if (ret < 0)
 		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_CLKR_SRC_CLKX\n");
-		return ret;
-	}
 
-	snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_FSR_SRC_FSX\n");
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_ops am3517evm_ops = {
-- 
1.7.8.6

