From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 4/8] ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S bus
Date: Mon, 27 Jan 2014 17:37:53 +0200
Message-ID: <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbaA0Piw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jan 2014 10:38:52 -0500
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com

Add machine driver support for BeagleBone-Black and other boards with
tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
port in I2S mode. McASP produces the bit clock for the i2s bus from
the masted clock by a simple divider and the available sample rates
depend on the used master clock frequency. The only properly working
sample format appears to be SNDRV_PCM_FORMAT_S32_LE. The other formats
have been disabled. The 8 least significant bits of the 32 bit samples
are ignored.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: bcousson@baylibre.com
---
 .../bindings/sound/davinci-evm-audio.txt           |    4 +-
 sound/soc/davinci/davinci-evm.c                    |  153 +++++++++++++++++++-
 2 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
index 963e100..2a535d9 100644
--- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
@@ -1,7 +1,9 @@
 * Texas Instruments SoC audio setups with TLV320AIC3X Codec
 
 Required properties:
-- compatible : "ti,da830-evm-audio" : forDM365/DA8xx/OMAPL1x/AM33xx
+- compatible :
+  "ti,da830-evm-audio" : for DM365/DA8xx/OMAPL1x/AM33xx
+  "ti,am33xx-beaglebone-black-audio" : for Beaglebone-black HDMI audio
 - ti,model : The user-visible name of this sound complex.
 - ti,audio-codec : The phandle of the TLV320AIC3x audio codec
 - ti,mcasp-controller : The phandle of the McASP controller
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index d3e4cb0..00f1e83 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -21,6 +21,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/pcm_params.h>
 
 #include <asm/dma.h>
 #include <asm/mach-types.h>
@@ -33,8 +34,13 @@
 struct snd_soc_card_drvdata_davinci {
 	struct clk *mclk;
 	unsigned sysclk;
+	struct snd_pcm_hw_constraint_list *rate_constraint;
 };
 
+/* If changing sample format the tda998x configuration (REG_CTS_N) needs
+   to be changed. */
+#define TDA998X_SAMPLE_FORMAT SNDRV_PCM_FORMAT_S32_LE
+
 static int evm_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -67,9 +73,10 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *soc_card = codec->card;
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		snd_soc_card_get_drvdata(soc_card);
+	unsigned sysclk = drvdata->sysclk;
 	int ret = 0;
-	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
-			   snd_soc_card_get_drvdata(soc_card))->sysclk;
 
 	/* set the codec system clock */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
@@ -84,12 +91,63 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int evm_tda998x_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		snd_soc_card_get_drvdata(soc_card);
+	struct snd_mask *fmt = constrs_mask(&runtime->hw_constraints,
+					    SNDRV_PCM_HW_PARAM_FORMAT);
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, TDA998X_SAMPLE_FORMAT);
+
+	runtime->hw.rate_min = drvdata->rate_constraint->list[0];
+	runtime->hw.rate_max = drvdata->rate_constraint->list[
+		drvdata->rate_constraint->count - 1];
+	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
+
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   drvdata->rate_constraint);
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
+				     2, 2);
+
+	return evm_startup(substream);
+}
+
+static int evm_tda998x_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *soc_card = codec->card;
+	struct platform_device *pdev = to_platform_device(soc_card->dev);
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		snd_soc_card_get_drvdata(soc_card);
+	unsigned sysclk = drvdata->sysclk;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
 static struct snd_soc_ops evm_ops = {
 	.startup = evm_startup,
 	.shutdown = evm_shutdown,
 	.hw_params = evm_hw_params,
 };
 
+static struct snd_soc_ops evm_tda998x_ops = {
+	.startup = evm_tda998x_startup,
+	.shutdown = evm_shutdown,
+	.hw_params = evm_tda998x_hw_params,
+};
+
 /* davinci-evm machine dapm widgets */
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
@@ -156,6 +214,79 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static unsigned int tda998x_hdmi_rates[] = {
+	32000,
+	44100,
+	48000,
+	88200,
+	96000,
+};
+
+static struct snd_pcm_hw_constraint_list *evm_tda998x_rate_constraint(
+	struct snd_soc_card *soc_card)
+{
+	struct platform_device *pdev = to_platform_device(soc_card->dev);
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		snd_soc_card_get_drvdata(soc_card);
+	unsigned sysclk = drvdata->sysclk;
+	struct snd_pcm_hw_constraint_list *ret;
+	unsigned int *rates;
+	int i, j = 0;
+
+	ret = devm_kzalloc(soc_card->dev, sizeof(*ret), GFP_KERNEL);
+	rates = devm_kzalloc(soc_card->dev, sizeof(tda998x_hdmi_rates),
+			     GFP_KERNEL);
+	if (!ret || !rates)
+		return NULL;
+
+	ret->list = rates;
+	ret->mask = 0;
+	for (i = 0; i < ARRAY_SIZE(tda998x_hdmi_rates); i++) {
+		unsigned int bclk_freq = tda998x_hdmi_rates[i] * 2 *
+			snd_pcm_format_width(TDA998X_SAMPLE_FORMAT);
+		if (sysclk % bclk_freq == 0) {
+			rates[j++] = tda998x_hdmi_rates[i];
+			dev_dbg(soc_card->dev, "Allowing rate %u\n",
+				tda998x_hdmi_rates[i]);
+		}
+	}
+	ret->count = j;
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget tda998x_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("HDMI Out"),
+};
+
+static int evm_tda998x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dapm_context *dapm = &rtd->codec->dapm;
+	struct snd_soc_card *soc_card = rtd->codec->card;
+	struct snd_soc_card_drvdata_davinci *drvdata =
+		snd_soc_card_get_drvdata(soc_card);
+	int ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, 0, 1);
+	if (ret < 0)
+		return ret;
+
+	drvdata->rate_constraint = evm_tda998x_rate_constraint(soc_card);
+
+	snd_soc_dapm_new_controls(dapm, tda998x_dapm_widgets,
+				  ARRAY_SIZE(tda998x_dapm_widgets));
+
+	ret = snd_soc_of_parse_audio_routing(soc_card, "ti,audio-routing");
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(dapm, "RX");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(dapm, "HDMI Out");
+
+	return 0;
+}
+
 /* davinci-evm digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link dm6446_evm_dai = {
 	.name = "TLV320AIC3X",
@@ -341,7 +472,7 @@ static struct snd_soc_card da850_snd_soc_card = {
 #if defined(CONFIG_OF)
 
 /*
- * The struct is used as place holder. It will be completely
+ * The structs are used as place holders. They will be completely
  * filled with data from dt node.
  */
 static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
@@ -354,10 +485,24 @@ static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
 		   SND_SOC_DAIFMT_IB_NF,
 };
 
+static struct snd_soc_dai_link evm_dai_tda998x_hdmi = {
+	.name		= "NXP TDA998x HDMI Chip",
+	.stream_name	= "HDMI",
+	.codec_dai_name	= "hdmi-hifi",
+	.ops		= &evm_tda998x_ops,
+	.init           = evm_tda998x_init,
+	.dai_fmt	= (SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_IB_NF),
+};
+
 static const struct of_device_id davinci_evm_dt_ids[] = {
 	{
 		.compatible = "ti,da830-evm-audio",
-		.data = (void *) &evm_dai_tlv320aic3x,
+		.data = &evm_dai_tlv320aic3x,
+	},
+	{
+		.compatible = "ti,am33xx-beaglebone-black-audio",
+		.data = &evm_dai_tda998x_hdmi,
 	},
 	{ /* sentinel */ }
 };
-- 
1.7.9.5

