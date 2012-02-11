From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 5/5] OMAPDSS/ASoC: Relocate ASoC HDMI codec. Part 1
Date: Sat, 11 Feb 2012 17:55:30 -0600
Message-ID: <1329004530-28029-6-git-send-email-ricardo.neri@ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48924 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab2BKX4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:56:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1BNu2HR000987
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:02 -0600
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1BNu2ID019815
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:02 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The ASoC HDMI codec is to be relocated under sound/soc/codecs. This
patch removes the codec from DSS code. A second patch will place
this code under ASoC.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |  236 -----------------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   57 -------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    5 -
 3 files changed, 0 insertions(+), 298 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index dfc1487..e463940 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,12 +33,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <video/omapdss.h>
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-#include <sound/soc.h>
-#include <sound/pcm_params.h>
-#include "ti_hdmi_4xxx_ip.h"
-#endif
 
 #include "ti_hdmi.h"
 #include "dss.h"
@@ -564,220 +558,6 @@ int omapdss_hdmi_get_hdmi_mode(void)
 }
 EXPORT_SYMBOL(omapdss_hdmi_get_hdmi_mode);
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-
-static int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct platform_device *pdev = to_platform_device(codec->dev);
-	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
-	int err = 0;
-
-	if (!(ip_data->ops) && !(ip_data->ops->audio_enable)) {
-		dev_err(&pdev->dev, "Cannot enable/disable audio\n");
-		return -ENODEV;
-	}
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ip_data->ops->audio_enable(ip_data, true);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ip_data->ops->audio_enable(ip_data, false);
-		break;
-	default:
-		err = -EINVAL;
-	}
-	return err;
-}
-
-static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *params,
-				    struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
-	struct hdmi_audio_format audio_format;
-	struct hdmi_audio_dma audio_dma;
-	struct hdmi_core_audio_config core_cfg;
-	struct hdmi_core_infoframe_audio aud_if_cfg;
-	int err, n, cts;
-	enum hdmi_core_audio_sample_freq sample_freq;
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		core_cfg.i2s_cfg.word_max_length =
-			HDMI_AUDIO_I2S_MAX_WORD_20BITS;
-		core_cfg.i2s_cfg.word_length = HDMI_AUDIO_I2S_CHST_WORD_16_BITS;
-		core_cfg.i2s_cfg.in_length_bits =
-			HDMI_AUDIO_I2S_INPUT_LENGTH_16;
-		core_cfg.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_LEFT;
-		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_TWOSAMPLES;
-		audio_format.sample_size = HDMI_AUDIO_SAMPLE_16BITS;
-		audio_format.justification = HDMI_AUDIO_JUSTIFY_LEFT;
-		audio_dma.transfer_size = 0x10;
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		core_cfg.i2s_cfg.word_max_length =
-			HDMI_AUDIO_I2S_MAX_WORD_24BITS;
-		core_cfg.i2s_cfg.word_length = HDMI_AUDIO_I2S_CHST_WORD_24_BITS;
-		core_cfg.i2s_cfg.in_length_bits =
-			HDMI_AUDIO_I2S_INPUT_LENGTH_24;
-		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_ONESAMPLE;
-		audio_format.sample_size = HDMI_AUDIO_SAMPLE_24BITS;
-		audio_format.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
-		core_cfg.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
-		audio_dma.transfer_size = 0x20;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (params_rate(params)) {
-	case 32000:
-		sample_freq = HDMI_AUDIO_FS_32000;
-		break;
-	case 44100:
-		sample_freq = HDMI_AUDIO_FS_44100;
-		break;
-	case 48000:
-		sample_freq = HDMI_AUDIO_FS_48000;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	err = hdmi_config_audio_acr(ip_data, params_rate(params), &n, &cts);
-	if (err < 0)
-		return err;
-
-	/* Audio wrapper config */
-	audio_format.stereo_channels = HDMI_AUDIO_STEREO_ONECHANNEL;
-	audio_format.active_chnnls_msk = 0x03;
-	audio_format.type = HDMI_AUDIO_TYPE_LPCM;
-	audio_format.sample_order = HDMI_AUDIO_SAMPLE_LEFT_FIRST;
-	/* Disable start/stop signals of IEC 60958 blocks */
-	audio_format.en_sig_blk_strt_end = HDMI_AUDIO_BLOCK_SIG_STARTEND_OFF;
-
-	audio_dma.block_size = 0xC0;
-	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
-	audio_dma.fifo_threshold = 0x20; /* in number of samples */
-
-	hdmi_wp_audio_config_dma(ip_data, &audio_dma);
-	hdmi_wp_audio_config_format(ip_data, &audio_format);
-
-	/*
-	 * I2S config
-	 */
-	core_cfg.i2s_cfg.en_high_bitrate_aud = false;
-	/* Only used with high bitrate audio */
-	core_cfg.i2s_cfg.cbit_order = false;
-	/* Serial data and word select should change on sck rising edge */
-	core_cfg.i2s_cfg.sck_edge_mode = HDMI_AUDIO_I2S_SCK_EDGE_RISING;
-	core_cfg.i2s_cfg.vbit = HDMI_AUDIO_I2S_VBIT_FOR_PCM;
-	/* Set I2S word select polarity */
-	core_cfg.i2s_cfg.ws_polarity = HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_LEFT;
-	core_cfg.i2s_cfg.direction = HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST;
-	/* Set serial data to word select shift. See Phillips spec. */
-	core_cfg.i2s_cfg.shift = HDMI_AUDIO_I2S_FIRST_BIT_SHIFT;
-	/* Enable one of the four available serial data channels */
-	core_cfg.i2s_cfg.active_sds = HDMI_AUDIO_I2S_SD0_EN;
-
-	/* Core audio config */
-	core_cfg.freq_sample = sample_freq;
-	core_cfg.n = n;
-	core_cfg.cts = cts;
-	if (dss_has_feature(FEAT_HDMI_CTS_SWMODE)) {
-		core_cfg.aud_par_busclk = 0;
-		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_SW;
-		core_cfg.use_mclk = dss_has_feature(FEAT_HDMI_AUDIO_USE_MCLK);
-	} else {
-		core_cfg.aud_par_busclk = (((128 * 31) - 1) << 8);
-		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_HW;
-		core_cfg.use_mclk = true;
-	}
-
-	if (core_cfg.use_mclk)
-		core_cfg.mclk_mode = HDMI_AUDIO_MCLK_128FS;
-	core_cfg.layout = HDMI_AUDIO_LAYOUT_2CH;
-	core_cfg.en_spdif = false;
-	/* Use sample frequency from channel status word */
-	core_cfg.fs_override = true;
-	/* Enable ACR packets */
-	core_cfg.en_acr_pkt = true;
-	/* Disable direct streaming digital audio */
-	core_cfg.en_dsd_audio = false;
-	/* Use parallel audio interface */
-	core_cfg.en_parallel_aud_input = true;
-
-	ti_hdmi_4xxx_core_audio_config(ip_data, &core_cfg);
-
-	/*
-	 * Configure packet
-	 * info frame audio see doc CEA861-D page 74
-	 */
-	aud_if_cfg.db1_coding_type = HDMI_INFOFRAME_AUDIO_DB1CT_FROM_STREAM;
-	aud_if_cfg.db1_channel_count = 2;
-	aud_if_cfg.db2_sample_freq = HDMI_INFOFRAME_AUDIO_DB2SF_FROM_STREAM;
-	aud_if_cfg.db2_sample_size = HDMI_INFOFRAME_AUDIO_DB2SS_FROM_STREAM;
-	aud_if_cfg.db4_channel_alloc = 0x00;
-	aud_if_cfg.db5_downmix_inh = false;
-	aud_if_cfg.db5_lsv = 0;
-
-	ti_hdmi_4xxx_core_audio_infoframe_config(ip_data, &aud_if_cfg);
-	return 0;
-}
-
-static int hdmi_audio_startup(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
-{
-	if (!hdmi.mode) {
-		pr_err("Current video settings do not support audio.\n");
-		return -EIO;
-	}
-	return 0;
-}
-
-static int hdmi_audio_codec_probe(struct snd_soc_codec *codec)
-{
-	struct hdmi_ip_data *priv = &hdmi.ip_data;
-
-	snd_soc_codec_set_drvdata(codec, priv);
-	return 0;
-}
-
-static struct snd_soc_codec_driver hdmi_audio_codec_drv = {
-	.probe = hdmi_audio_codec_probe,
-};
-
-static struct snd_soc_dai_ops hdmi_audio_codec_ops = {
-	.hw_params = hdmi_audio_hw_params,
-	.trigger = hdmi_audio_trigger,
-	.startup = hdmi_audio_startup,
-};
-
-static struct snd_soc_dai_driver hdmi_codec_dai_drv = {
-		.name = "hdmi-audio-codec",
-		.playback = {
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_32000 |
-				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE |
-				SNDRV_PCM_FMTBIT_S24_LE,
-		},
-		.ops = &hdmi_audio_codec_ops,
-};
-#endif
-
 static int hdmi_get_clocks(struct platform_device *pdev)
 {
 	struct clk *clk;
@@ -839,17 +619,6 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_panel_init();
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-
-	/* Register ASoC codec DAI */
-	r = snd_soc_register_codec(&pdev->dev, &hdmi_audio_codec_drv,
-					&hdmi_codec_dai_drv, 1);
-	if (r) {
-		DSSERR("can't register ASoC HDMI audio codec\n");
-		return r;
-	}
-#endif
 	return 0;
 }
 
@@ -857,11 +626,6 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_panel_exit();
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-	snd_soc_unregister_codec(&pdev->dev);
-#endif
-
 	pm_runtime_disable(&pdev->dev);
 
 	hdmi_put_clocks();
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 542963b..4a3b5b1 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1154,63 +1154,6 @@ void ti_hdmi_4xxx_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 	 */
 }
 
-int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
-				u32 sample_freq, u32 *n, u32 *cts)
-{
-	u32 r;
-	u32 deep_color = 0;
-	u32 pclk = ip_data->cfg.timings.timings.pixel_clock;
-
-	if (n == NULL || cts == NULL)
-		return -EINVAL;
-	/*
-	 * Obtain current deep color configuration. This needed
-	 * to calculate the TMDS clock based on the pixel clock.
-	 */
-	r = REG_GET(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, 1, 0);
-	switch (r) {
-	case 1: /* No deep color selected */
-		deep_color = 100;
-		break;
-	case 2: /* 10-bit deep color selected */
-		deep_color = 125;
-		break;
-	case 3: /* 12-bit deep color selected */
-		deep_color = 150;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (sample_freq) {
-	case 32000:
-		if ((deep_color == 125) && ((pclk == 54054)
-				|| (pclk == 74250)))
-			*n = 8192;
-		else
-			*n = 4096;
-		break;
-	case 44100:
-		*n = 6272;
-		break;
-	case 48000:
-		if ((deep_color == 125) && ((pclk == 54054)
-				|| (pclk == 74250)))
-			*n = 8192;
-		else
-			*n = 6144;
-		break;
-	default:
-		*n = 0;
-		return -EINVAL;
-	}
-
-	/* Calculate CTS. See HDMI 1.3a or 1.4a specifications */
-	*cts = pclk * (*n / 128) * deep_color / (sample_freq / 10);
-
-	return 0;
-}
-
 void ti_hdmi_4xxx_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
 {
 	REG_FLD_MOD(hdmi_av_base(ip_data),
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 43cd783..d51022b 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -574,9 +574,4 @@ struct hdmi_core_audio_config {
 	bool					en_spdif;
 };
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
-				u32 sample_freq, u32 *n, u32 *cts);
-#endif
 #endif
-- 
1.7.0.4

