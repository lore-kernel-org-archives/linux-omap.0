From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Index ruledata in drvdata with substream->stream
Date: Fri, 27 Mar 2015 11:47:51 +0200
Message-ID: <1427449671-18014-1-git-send-email-jsarha@ti.com>
References: <20150327062008.GA11983@mwanda>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51183 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbbC0JsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2015 05:48:07 -0400
In-Reply-To: <20150327062008.GA11983@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, dan.carpenter@oracle.com, Jyri Sarha <jsarha@ti.com>

The serializer direction definitions runs from 1 to 2, which does not
suite the purpose. The substream->stream is perfect for the purpose
and should have been used from the beginning.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 76156d18..0b6b1b2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1149,7 +1149,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		if (mcasp->serial_dir[i] == dir)
 			max_channels++;
 	}
-	mcasp->ruledata[dir].serializers = max_channels;
+	mcasp->ruledata[substream->stream].serializers = max_channels;
 	max_channels *= mcasp->tdm_slots;
 	/*
 	 * If the already active stream has less channels than the calculated
@@ -1172,7 +1172,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
 		int ret;
 
-		mcasp->ruledata[dir].mcasp = mcasp;
+		mcasp->ruledata[substream->stream].mcasp = mcasp;
 
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_RATE,
-- 
1.9.1

