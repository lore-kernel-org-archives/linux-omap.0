From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3] ASoC: davinci-mcasp: Set rule constraints if implicit BCLK divider is used
Date: Fri, 20 Mar 2015 13:31:08 +0200
Message-ID: <1426851068-26366-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40099 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbCTLbW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 07:31:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>

Set rule constraints to allow only combinations of sample-rate,
sample-format, and channels counts that can be played/captured with
reasonable sample-rate accuracy.

The logic with tdm-slots and serializers (=i2s data wires) goes like
this: The first wire will take all channels up to number of tdm-slots,
before following wires (if any) are used. If the first wire is used
fully, the remaining wires share the same clocks and the divider can
be calculated for the first wire.

Also, takes the number of tdm-slots into account when implicitly
selecting the BLCK divider.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
Previous version of the patch:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089319.html

Since v2 I changed the SNDRV_PCM_HW_PARAM_SAMPLE_BITS rule in the to
SNDRV_PCM_HW_PARAM_FORMAT rule. 

Somehow the constraints with a SNDRV_PCM_HW_PARAM_SAMPLE_BITS rule
using snd_interval_list() converged to an empty set when ever I tried
to play a format that could not pass the rule with any channel count
or rate, resulting all too familiar assertion in alsa-lib. However,
the direct tampering with SNDRV_PCM_HW_PARAM_FORMAT mask appears to
work as it should.

In addition to SAMPLE_BITS- to FORMAT-rule change I optimized the rate
rule a bit so that it does not try the rates that are outside current
range. According to my tests this does not affect the behavior in any
other way but slightly speeds up the decision making.

 sound/soc/davinci/davinci-mcasp.c | 207 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 197 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d40b392..76156d18 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -27,6 +27,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/davinci_asp.h>
+#include <linux/math64.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -65,6 +66,11 @@ struct davinci_mcasp_context {
 	bool	pm_state;
 };
 
+struct davinci_mcasp_ruledata {
+	struct davinci_mcasp *mcasp;
+	int serializers;
+};
+
 struct davinci_mcasp {
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 	void __iomem *base;
@@ -99,6 +105,8 @@ struct davinci_mcasp {
 #ifdef CONFIG_PM_SLEEP
 	struct davinci_mcasp_context context;
 #endif
+
+	struct davinci_mcasp_ruledata ruledata[2];
 };
 
 static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 offset,
@@ -868,6 +876,30 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
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
@@ -883,16 +915,20 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
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
+		int channels = params_channels(params);
+		int rate = params_rate(params);
+		int sbits = params_width(params);
+		int ppm, div;
+
+		if (channels > mcasp->tdm_slots)
+			channels = mcasp->tdm_slots;
+
+		div = davinci_mcasp_calc_clk_div(mcasp, rate*sbits*channels,
+						 &ppm);
+		if (ppm)
+			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
+				 ppm);
+
 		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
 	}
 
@@ -974,6 +1010,120 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
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
+	struct snd_interval *ri =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	int sbits = params_width(params);
+	int channels = params_channels(params);
+	unsigned int list[ARRAY_SIZE(davinci_mcasp_dai_rates)];
+	int i, count = 0;
+
+	if (channels > rd->mcasp->tdm_slots)
+		channels = rd->mcasp->tdm_slots;
+
+	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
+		if (ri->min <= davinci_mcasp_dai_rates[i] &&
+		    ri->max >= davinci_mcasp_dai_rates[i]) {
+			uint bclk_freq = sbits*channels*
+				davinci_mcasp_dai_rates[i];
+			int ppm;
+
+			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM)
+				list[count++] = davinci_mcasp_dai_rates[i];
+		}
+	}
+	dev_dbg(rd->mcasp->dev,
+		"%d frequencies (%d-%d) for %d sbits and %d channels\n",
+		count, ri->min, ri->max, sbits, channels);
+
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 count, list, 0);
+}
+
+static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
+					struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	struct snd_mask nfmt;
+	int rate = params_rate(params);
+	int channels = params_channels(params);
+	int i, count = 0;
+
+	snd_mask_none(&nfmt);
+
+	if (channels > rd->mcasp->tdm_slots)
+		channels = rd->mcasp->tdm_slots;
+
+	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
+		if (snd_mask_test(fmt, i)) {
+			uint bclk_freq = snd_pcm_format_width(i)*channels*rate;
+			int ppm;
+
+			davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
+				snd_mask_set(&nfmt, i);
+				count++;
+			}
+		}
+	}
+	dev_dbg(rd->mcasp->dev,
+		"%d possible sample format for %d Hz and %d channels\n",
+		count, rate, channels);
+
+	return snd_mask_refine(fmt, &nfmt);
+}
+
+static int davinci_mcasp_hw_rule_channels(struct snd_pcm_hw_params *params,
+					  struct snd_pcm_hw_rule *rule)
+{
+	struct davinci_mcasp_ruledata *rd = rule->private;
+	struct snd_interval *ci =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	int sbits = params_width(params);
+	int rate = params_rate(params);
+	int max_chan_per_wire = rd->mcasp->tdm_slots < ci->max ?
+		rd->mcasp->tdm_slots : ci->max;
+	unsigned int list[ci->max - ci->min + 1];
+	int c1, c, count = 0;
+
+	for (c1 = ci->min; c1 <= max_chan_per_wire; c1++) {
+		uint bclk_freq = c1*sbits*rate;
+		int ppm;
+
+		davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq, &ppm);
+		if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
+			/* If we can use all tdm_slots, we can put any
+			   amount of channels to remaining wires as
+			   long as they fit in. */
+			if (c1 == rd->mcasp->tdm_slots) {
+				for (c = c1; c <= rd->serializers*c1 &&
+					     c <= ci->max; c++)
+					list[count++] = c;
+			} else {
+				list[count++] = c1;
+			}
+		}
+	}
+	dev_dbg(rd->mcasp->dev,
+		"%d possible channel counts (%d-%d) for %d Hz and %d sbits\n",
+		count, ci->min, ci->max, rate, sbits);
+
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 count, list, 0);
+}
+
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *cpu_dai)
 {
@@ -999,6 +1149,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 		if (mcasp->serial_dir[i] == dir)
 			max_channels++;
 	}
+	mcasp->ruledata[dir].serializers = max_channels;
 	max_channels *= mcasp->tdm_slots;
 	/*
 	 * If the already active stream has less channels than the calculated
@@ -1013,6 +1164,42 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
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
+					  SNDRV_PCM_HW_PARAM_FORMAT,
+					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		if (ret)
+			return ret;
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_FORMAT,
+					  davinci_mcasp_hw_rule_format,
+					  &mcasp->ruledata[dir],
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		if (ret)
+			return ret;
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS,
+					  davinci_mcasp_hw_rule_channels,
+					  &mcasp->ruledata[dir],
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  SNDRV_PCM_HW_PARAM_FORMAT, -1);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
1.9.1

