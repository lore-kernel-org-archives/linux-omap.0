From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 5/7] ASoC: TWL6030: Add restrictions for low-power
 playback mode
Date: Tue, 23 Feb 2010 18:10:42 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD1B17@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46310 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676Ab0BXAKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 19:10:49 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

From: Misael Lopez Cruz <x0052729@ti.com>

Low-power playback mode is a special scenario where only headset path
(headset DAC and driver) is active. Only in this mode the codec can
support 44.1 and 48 kHz, low-power PLL should provide sysclk signal.

Currently, handsfree DAC and driver are the only components that can
prevent codec to enter to low-power playback mode. Other components
like earphone driver, vibrator driver or loopback (which are not yet
supported in the driver) can cause the same effect.

In order to detect conflicting paths, CODEC driver supervises
non-low-power widgets powered by DAPM mechanism, just at the point
pcm trigger callback gets called.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6030.c |   79 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
index 792407f..53aa837 100644
--- a/sound/soc/codecs/twl6030.c
+++ b/sound/soc/codecs/twl6030.c
@@ -48,6 +48,7 @@ struct twl6030_data {
 	int audpwron;
 	int codec_powered;
 	int pll;
+	int non_lp;
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
@@ -352,6 +353,20 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 	return 0;
 }
 
+static int twl6030_power_mode_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct twl6030_data *priv = codec->private_data;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		priv->non_lp++;
+	else
+		priv->non_lp--;
+
+	return 0;
+}
+
 /*
  * MICATT volume control:
  * from -6 to 0 dB in 6 dB steps
@@ -485,10 +500,14 @@ static const struct snd_soc_dapm_widget twl6030_dapm_widgets[] = {
 			TWL6030_REG_HSLCTL, 0, 0),
 	SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback",
 			TWL6030_REG_HSRCTL, 0, 0),
-	SND_SOC_DAPM_DAC("HFDAC Left", "Handsfree Playback",
-			TWL6030_REG_HFLCTL, 0, 0),
-	SND_SOC_DAPM_DAC("HFDAC Right", "Handsfree Playback",
-			TWL6030_REG_HFRCTL, 0, 0),
+	SND_SOC_DAPM_DAC_E("HFDAC Left", "Handsfree Playback",
+			TWL6030_REG_HFLCTL, 0, 0,
+			twl6030_power_mode_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("HFDAC Right", "Handsfree Playback",
+			TWL6030_REG_HFRCTL, 0, 0,
+			twl6030_power_mode_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback switches */
 	SND_SOC_DAPM_SWITCH("HSDAC Left Playback",
@@ -504,10 +523,14 @@ static const struct snd_soc_dapm_widget twl6030_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0, &hsl_driver_switch_controls),
 	SND_SOC_DAPM_SWITCH("Headset Right Driver",
 			SND_SOC_NOPM, 0, 0, &hsr_driver_switch_controls),
-	SND_SOC_DAPM_SWITCH("Handsfree Left Driver",
-			SND_SOC_NOPM, 0, 0, &hfl_driver_switch_controls),
-	SND_SOC_DAPM_SWITCH("Handsfree Right Driver",
-			SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls),
+	SND_SOC_DAPM_SWITCH_E("Handsfree Left Driver",
+			SND_SOC_NOPM, 0, 0, &hfl_driver_switch_controls,
+			twl6030_power_mode_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SWITCH_E("Handsfree Right Driver",
+			SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls,
+			twl6030_power_mode_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback PGAs */
 	SND_SOC_DAPM_PGA("HFDAC Left PGA",
@@ -668,6 +691,17 @@ static int twl6030_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/*
+	 * capture is not supported at 17.64 MHz,
+	 * it's reserved for headset low-power playback scenario
+	 */
+	if ((priv->sysclk == 17640000) && substream->stream) {
+		dev_err(codec->dev,
+			"capture mode is not supported at %dHz\n",
+			priv->sysclk);
+		return -EINVAL;
+	}
+
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE,
 				priv->sysclk_constraints);
@@ -712,6 +746,34 @@ static int twl6030_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int twl6030_trigger(struct snd_pcm_substream *substream,
+			int cmd, struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl6030_data *priv = codec->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/*
+		 * low-power playback mode is restricted
+		 * for headset path only
+		 */
+		if ((priv->sysclk == 17640000) && priv->non_lp) {
+			dev_err(codec->dev,
+				"some enabled paths aren't supported at %dHz\n",
+				priv->sysclk);
+			return -EPERM;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int twl6030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -822,6 +884,7 @@ static int twl6030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static struct snd_soc_dai_ops twl6030_dai_ops = {
 	.startup	= twl6030_startup,
 	.hw_params	= twl6030_hw_params,
+	.trigger	= twl6030_trigger,
 	.set_sysclk	= twl6030_set_dai_sysclk,
 };
 
-- 
1.6.1.3

