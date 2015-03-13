From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC (do not merge)] ASoC: davinci-mcasp: Set rule constraint if implicit bclk divider is used
Date: Fri, 13 Mar 2015 13:36:55 +0200
Message-ID: <1426246615-12772-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39678 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164AbbCMLhN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2015 07:37:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>

Set a rule constraint to allow only sample-rate and sample-format
combinations that can be played/captured with reasonable accuracy.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
In theory this patch does exactly what it is supposed to. It only
allows a sample-rate and sample-format combination if the rate can be
produced with reasonable accuracy. Unfortunately the alsa-lib and
alsa-tools are not able use this information too well. If the requested
sample-rate and sample-format is not available the aplay/arecord
fails, even if plughw is selected, with:

pcm_params.c:170: snd1_pcm_hw_param_get_min: Assertion `!snd_interval_empty(i)' failed.

I think we are better of without this patch until the behavior of ALSA
userspace improved.

 sound/soc/davinci/davinci-mcasp.c | 94 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index de3b155..4ff5820 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -855,6 +855,29 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
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
+			(div*1000000 + 1000*((rem*1000)/(int)bclk_freq))/div
+			- 1000000;
+
+	return div;
+}
+
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
@@ -872,16 +895,14 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
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
+		int ppm;
+		uint bclk_freq = snd_soc_params_to_bclk(params);
+		int div = davinci_mcasp_calc_clk_div(mcasp, bclk_freq, &ppm);
+
+		if (ppm)
+			dev_info(mcasp->dev, "BCLK rate is off by %d PPM\n",
+				 ppm);
+
 		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
 	}
 
@@ -973,6 +994,46 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
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
+	struct davinci_mcasp *mcasp = rule->private;
+	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
+	int frame_size;
+	int i, count = 0;
+
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0)
+		return frame_size;
+
+	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
+		uint bclk_freq = frame_size*davinci_mcasp_dai_rates[i];
+		int ppm;
+
+		davinci_mcasp_calc_clk_div(mcasp, bclk_freq, &ppm);
+
+		dev_dbg(mcasp->dev,
+			"%u bit frames @ %u Hz => %d PPM error\n",
+			frame_size, davinci_mcasp_dai_rates[i], ppm);
+
+		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
+			list[count++] = davinci_mcasp_dai_rates[i];
+
+	}
+	dev_dbg(mcasp->dev, "%d frequencies for %u fsize\n",
+		count, frame_size);
+
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 count, list, 0);
+}
+
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
@@ -1012,6 +1073,19 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	snd_pcm_hw_constraint_minmax(substream->runtime,
 				     SNDRV_PCM_HW_PARAM_CHANNELS,
 				     2, max_channels);
+
+	/*
+	 * If we rely on implicit BCLK divider setting we should
+	 * set constraints based on what we can provide.
+	 */
+	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq)
+		return snd_pcm_hw_rule_add(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   davinci_mcasp_hw_rule_rate,
+					   mcasp,
+					   SNDRV_PCM_HW_PARAM_FRAME_BITS,
+					   SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+
 	return 0;
 }
 
-- 
1.9.1

