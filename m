From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Set rule constraints if implicit BCLK divider is used
Date: Tue, 17 Mar 2015 16:56:43 +0200
Message-ID: <1426604203-6467-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52700 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbCQO45 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 10:56:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>

Set a rule constraints to allow only combinations of sample-rate and
number of frame-bits that can be played/captured with a reasonable
sample-rate accuracy.

Also, takes the number of serializers into account when implicitly
selecting the BLCK divider.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
Now this works as it should.

Thanks,
Jyri

 sound/soc/davinci/davinci-mcasp.c | 150 +++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index de3b155..3ecee3b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/math64.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -64,6 +65,11 @@ struct davinci_mcasp_context {
 	u32	*xrsr_regs; /* for serializer configuration */
 };
 
+struct davinci_mcasp_ruledata {
+	struct davinci_mcasp *mcasp;
+	int serializers;
+};
+
 struct davinci_mcasp {
 	struct davinci_pcm_dma_params dma_params[2];
 	struct snd_dmaengine_dai_dma_data dma_data[2];
@@ -98,6 +104,8 @@ struct davinci_mcasp {
 #ifdef CONFIG_PM_SLEEP
 	struct davinci_mcasp_context context;
 #endif
+
+	struct davinci_mcasp_ruledata ruledata[2];
 };
 
 static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 offset,
@@ -855,6 +863,30 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
 	return 0;
 }
 
+static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
+				      unsigned int bclk_freq,
+				      int *error_ppm)
+{
+	int div = mcasp->sysclk_freq / bclk_freq;
+	int rem = mcasp->sysclk_freq % bclk_freq;
+
+	if (rem != 0) {
+		if (div == 0 ||
+		    ((mcasp->sysclk_freq / div) - bclk_freq) >
+		    (bclk_freq - (mcasp->sysclk_freq / (div+1)))) {
+			div++;
+			rem = rem - bclk_freq;
+		}
+	}
+	if (error_ppm)
+		*error_ppm =
+			(div*1000000 + (int)div64_long(1000000LL*rem,
+						       (int)bclk_freq))
+			/div - 1000000;
+
+	return div;
+}
+
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
@@ -872,16 +904,19 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	 * the machine driver, we need to calculate the ratio.
 	 */
 	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
-		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
-		unsigned int div = mcasp->sysclk_freq / bclk_freq;
-		if (mcasp->sysclk_freq % bclk_freq != 0) {
-			if (((mcasp->sysclk_freq / div) - bclk_freq) >
-			    (bclk_freq - (mcasp->sysclk_freq / (div+1))))
-				div++;
-			dev_warn(mcasp->dev,
-				 "Inaccurate BCLK: %u Hz / %u != %u Hz\n",
-				 mcasp->sysclk_freq, div, bclk_freq);
-		}
+		uint bclk_freq = snd_soc_params_to_bclk(params);
+		int dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			TX_MODE : RX_MODE;
+		int ppm, div;
+
+		bclk_freq /= mcasp->ruledata[dir].serializers;
+
+		div = davinci_mcasp_calc_clk_div(mcasp, bclk_freq, &ppm);
+
+		if (ppm)
+			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
+				 ppm);
+
 		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
 	}
 
@@ -973,6 +1008,74 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static const unsigned int davinci_mcasp_dai_rates[] = {
+	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
+	88200, 96000, 176400, 192000,
+};
+
+#define DAVINCI_MAX_RATE_ERROR_PPM 1000
+
+static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
+				      struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
+	int frame_size;
+	int i, count = 0;
+
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0)
+		return frame_size;
+
+	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
+		uint bclk_freq = frame_size*davinci_mcasp_dai_rates[i]/
+			rd->serializers;
+		int ppm;
+
+		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
+			list[count++] = davinci_mcasp_dai_rates[i];
+
+	}
+	dev_dbg(rd->mcasp->dev, "%d frequencies for %u fsize (%d)\n",
+		count, frame_size, rd->serializers);
+
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 count, list, 0);
+}
+
+static int davinci_mcasp_hw_rule_framebits(struct snd_pcm_hw_params *params,
+					   struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	struct snd_interval *ci =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	unsigned int max_chan_per_wire = ci->max / rd->serializers;
+	unsigned int list[max_chan_per_wire*4];
+	int rate = params_rate(params);
+	int chans, fbits, count = 0;
+
+	for (chans = ci->min; chans <= max_chan_per_wire; chans++) {
+		for (fbits = 8; fbits <= 32; fbits += 8) {
+			uint bclk_freq = chans*fbits*rate;
+			int ppm;
+
+			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
+				list[count++] = chans*fbits*rd->serializers;
+				BUG_ON(count > ARRAY_SIZE(list));
+			}
+		}
+	}
+
+	dev_dbg(rd->mcasp->dev,
+		"%d possible frame size for %d Hz (%d)\n",
+		count, rate, rd->serializers);
+
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 count, list, 0);
+}
+
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
@@ -998,6 +1101,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		if (mcasp->serial_dir[i] == dir)
 			max_channels++;
 	}
+	mcasp->ruledata[dir].serializers = max_channels;
 	max_channels *= mcasp->tdm_slots;
 	/*
 	 * If the already active stream has less channels than the calculated
@@ -1012,6 +1116,32 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	snd_pcm_hw_constraint_minmax(substream->runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS,
 				     2, max_channels);
+
+	/*
+	 * If we rely on implicit BCLK divider setting we should
+	 * set constraints based on what we can provide.
+	 */
+	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
+		int ret;
+
+		mcasp->ruledata[dir].mcasp = mcasp;
+
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  davinci_mcasp_hw_rule_rate,
+					  &mcasp->ruledata[dir],
+					  SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+		if (ret)
+			return ret;
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_FRAME_BITS,
+					  davinci_mcasp_hw_rule_framebits,
+					  &mcasp->ruledata[dir],
+					  SNDRV_PCM_HW_PARAM_RATE, -1);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
1.9.1

