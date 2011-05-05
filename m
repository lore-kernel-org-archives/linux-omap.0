From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 5/5] OMAP4: DSS2: HDMI: Implement ASoC Codec driver for HDMI audio
Date: Thu,  5 May 2011 02:01:34 -0500
Message-ID: <1304578894-23967-6-git-send-email-ricardo.neri@ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab1EEHB2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 03:01:28 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4571SJZ008170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 02:01:28 -0500
In-Reply-To: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, mythripk@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

Implement an ASoC Codec Driver to handle audio configuration. The
implementation offers an interface for audio configuration and
control to be exposed to ALSA while hidding the HDMI details.

The ASoC driver supports the Basic Audio configuration as described
in CEA-861-D: 2-channel linear PCM with 32, 44.1 and 48kHz sample
rates and 16 bits/sample. It additionally supports 24 bit/sample
in 32-bit words.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |  217 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 217 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c5676ee..91b11a1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -30,9 +30,15 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <plat/display.h>
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#endif
 
 #include "dss.h"
 #include "hdmi.h"
+#include "dss_features.h"
 
 static struct {
 	struct mutex lock;
@@ -1488,12 +1494,207 @@ static int hdmi_config_audio_acr(u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct hdmi_audio_format audio_format;
+	struct hdmi_audio_dma audio_dma;
+	struct hdmi_core_audio_config core_cfg;
+	struct hdmi_core_infoframe_audio aud_if_cfg;
+	int err, n, cts;
+	enum hdmi_core_audio_sample_freq sample_freq;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		core_cfg.i2s_cfg.word_max_length =
+			HDMI_AUDIO_I2S_MAX_WORD_20BITS;
+		core_cfg.i2s_cfg.word_length = HDMI_AUDIO_I2S_CHST_WORD_16_BITS;
+		core_cfg.i2s_cfg.in_length_bits =
+			HDMI_AUDIO_I2S_INPUT_LENGTH_16;
+		core_cfg.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_LEFT;
+		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_TWOSAMPLES;
+		audio_format.sample_size = HDMI_AUDIO_SAMPLE_16BITS;
+		audio_format.justification = HDMI_AUDIO_JUSTIFY_LEFT;
+		audio_dma.transfer_size = 0x10;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		core_cfg.i2s_cfg.word_max_length =
+			HDMI_AUDIO_I2S_MAX_WORD_24BITS;
+		core_cfg.i2s_cfg.word_length = HDMI_AUDIO_I2S_CHST_WORD_24_BITS;
+		core_cfg.i2s_cfg.in_length_bits =
+			HDMI_AUDIO_I2S_INPUT_LENGTH_24;
+		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_ONESAMPLE;
+		audio_format.sample_size = HDMI_AUDIO_SAMPLE_24BITS;
+		audio_format.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
+		core_cfg.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
+		audio_dma.transfer_size = 0x20;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_rate(params)) {
+	case 32000:
+		sample_freq = HDMI_AUDIO_FS_32000;
+		break;
+	case 44100:
+		sample_freq = HDMI_AUDIO_FS_44100;
+		break;
+	case 48000:
+		sample_freq = HDMI_AUDIO_FS_48000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = hdmi_config_audio_acr(params_rate(params), &n, &cts);
+	if (err < 0)
+		return err;
+
+	/* Audio wrapper config */
+	audio_format.stereo_channels = HDMI_AUDIO_STEREO_ONECHANNEL;
+	audio_format.active_chnnls_msk = 0x03;
+	audio_format.type = HDMI_AUDIO_TYPE_LPCM;
+	audio_format.sample_order = HDMI_AUDIO_SAMPLE_LEFT_FIRST;
+	/* Disable start/stop signals of IEC 60958 blocks */
+	audio_format.en_sig_blk_strt_end = HDMI_AUDIO_BLOCK_SIG_STARTEND_OFF;
+
+	audio_dma.block_size = 0xC0;
+	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
+	audio_dma.fifo_threshold = 0x20; /* in number of samples */
+
+	hdmi_wp_audio_config_dma(&audio_dma);
+	hdmi_wp_audio_config_format(&audio_format);
+
+	/*
+	 * I2S config
+	 */
+	core_cfg.i2s_cfg.en_high_bitrate_aud = false;
+	/* Only used with high bitrate audio */
+	core_cfg.i2s_cfg.cbit_order = false;
+	/* Serial data and word select should change on sck rising edge */
+	core_cfg.i2s_cfg.sck_edge_mode = HDMI_AUDIO_I2S_SCK_EDGE_RISING;
+	core_cfg.i2s_cfg.vbit = HDMI_AUDIO_I2S_VBIT_FOR_PCM;
+	/* Set I2S word select polarity */
+	core_cfg.i2s_cfg.ws_polarity = HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_LEFT;
+	core_cfg.i2s_cfg.direction = HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST;
+	/* Set serial data to word select shift. See Phillips spec. */
+	core_cfg.i2s_cfg.shift = HDMI_AUDIO_I2S_FIRST_BIT_SHIFT;
+	/* Enable one of the four available serial data channels */
+	core_cfg.i2s_cfg.active_sds = HDMI_AUDIO_I2S_SD0_EN;
+
+	/* Core audio config */
+	core_cfg.freq_sample = sample_freq;
+	core_cfg.n = n;
+	core_cfg.cts = cts;
+	if (dss_has_feature(FEAT_HDMI_CTS_SWMODE)) {
+		core_cfg.aud_par_busclk = 0;
+		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_SW;
+		core_cfg.use_mclk = false;
+	} else {
+		core_cfg.aud_par_busclk = (((128 * 31) - 1) << 8);
+		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_HW;
+		core_cfg.use_mclk = true;
+		core_cfg.mclk_mode = HDMI_AUDIO_MCLK_128FS;
+	}
+	core_cfg.layout = HDMI_AUDIO_LAYOUT_2CH;
+	core_cfg.en_spdif = false;
+	/* Use sample frequency from channel status word */
+	core_cfg.fs_override = true;
+	/* Enable ACR packets */
+	core_cfg.en_acr_pkt = true;
+	/* Disable direct streaming digital audio */
+	core_cfg.en_dsd_audio = false;
+	/* Use parallel audio interface */
+	core_cfg.en_parallel_aud_input = true;
+
+	hdmi_core_audio_config(&core_cfg);
+
+	/*
+	 * Configure packet
+	 * info frame audio see doc CEA861-D page 74
+	 */
+	aud_if_cfg.db1_coding_type = HDMI_INFOFRAME_AUDIO_DB1CT_FROM_STREAM;
+	aud_if_cfg.db1_channel_count = 2;
+	aud_if_cfg.db2_sample_freq = HDMI_INFOFRAME_AUDIO_DB2SF_FROM_STREAM;
+	aud_if_cfg.db2_sample_size = HDMI_INFOFRAME_AUDIO_DB2SS_FROM_STREAM;
+	aud_if_cfg.db4_channel_alloc = 0x00;
+	aud_if_cfg.db5_downmix_inh = false;
+	aud_if_cfg.db5_lsv = 0;
+
+	hdmi_core_audio_infoframe_config(&aud_if_cfg);
+	return 0;
+}
+
+static int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
+				  struct snd_soc_dai *dai)
+{
+	int err = 0;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		REG_FLD_MOD(HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
+		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 1, 31, 31);
+		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 1, 30, 30);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		REG_FLD_MOD(HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
+		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 0, 30, 30);
+		REG_FLD_MOD(HDMI_WP_AUDIO_CTRL, 0, 31, 31);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
+}
+
+static int hdmi_audio_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	if (!hdmi.mode) {
+		pr_err("Current video settings do not support audio.\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static struct snd_soc_codec_driver hdmi_audio_codec_drv = {
+};
+
+static struct snd_soc_dai_ops hdmi_audio_codec_ops = {
+	.hw_params = hdmi_audio_hw_params,
+	.trigger = hdmi_audio_trigger,
+	.startup = hdmi_audio_startup,
+};
+
+static struct snd_soc_dai_driver hdmi_codec_dai_drv = {
+		.name = "hdmi-audio-codec",
+		.playback = {
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_32000 |
+				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+		},
+		.ops = &hdmi_audio_codec_ops,
+};
 #endif
 
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	int ret;
+#endif
 
 	hdmi.pdata = pdev->dev.platform_data;
 	hdmi.pdev = pdev;
@@ -1515,6 +1716,17 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_panel_init();
 
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+
+	/* Register ASoC codec DAI */
+	ret = snd_soc_register_codec(&pdev->dev, &hdmi_audio_codec_drv,
+					&hdmi_codec_dai_drv, 1);
+	if (ret) {
+		DSSERR("can't register ASoC HDMI audio codec\n");
+		return ret;
+	}
+#endif
 	return 0;
 }
 
@@ -1522,6 +1734,11 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_panel_exit();
 
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	snd_soc_unregister_codec(&pdev->dev);
+#endif
+
 	iounmap(hdmi.base_wp);
 
 	return 0;
-- 
1.7.1

