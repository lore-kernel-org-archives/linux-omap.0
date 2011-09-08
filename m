From: <mythripk@ti.com>
Subject: [PATCH 07/10]OMAP4: DSS2: HDMI: Move the HDMI IP dependent audio
Date: Thu, 8 Sep 2011 19:06:24 +0530
Message-ID: <1315488987-4546-8-git-send-email-mythripk@ti.com>
References: <1315488987-4546-1-git-send-email-mythripk@ti.com>
 <1315488987-4546-2-git-send-email-mythripk@ti.com>
 <1315488987-4546-3-git-send-email-mythripk@ti.com>
 <1315488987-4546-4-git-send-email-mythripk@ti.com>
 <1315488987-4546-5-git-send-email-mythripk@ti.com>
 <1315488987-4546-6-git-send-email-mythripk@ti.com>
 <1315488987-4546-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59433 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895Ab1IHNog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 09:44:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p88DiWvj023855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 08:44:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p88DiW48003407
	for <linux-omap@vger.kernel.org>; Thu, 8 Sep 2011 19:14:32 +0530 (IST)
In-Reply-To: <1315488987-4546-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Move HDMI IP dependent audio functions from HDMI DSS file  to IP library.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |  257 +----------------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  260 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   22 +++
 3 files changed, 283 insertions(+), 256 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b6d63c6..2a8a55d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -37,6 +37,7 @@
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
+#include "ti_hdmi_4xxx_ip.h"
 #endif
 
 #include "ti_hdmi.h"
@@ -630,229 +631,6 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-static void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_format *aud_fmt)
-{
-	u32 r;
-
-	DSSDBG("Enter hdmi_wp_audio_config_format\n");
-
-	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG);
-	r = FLD_MOD(r, aud_fmt->stereo_channels, 26, 24);
-	r = FLD_MOD(r, aud_fmt->active_chnnls_msk, 23, 16);
-	r = FLD_MOD(r, aud_fmt->en_sig_blk_strt_end, 5, 5);
-	r = FLD_MOD(r, aud_fmt->type, 4, 4);
-	r = FLD_MOD(r, aud_fmt->justification, 3, 3);
-	r = FLD_MOD(r, aud_fmt->sample_order, 2, 2);
-	r = FLD_MOD(r, aud_fmt->samples_per_word, 1, 1);
-	r = FLD_MOD(r, aud_fmt->sample_size, 0, 0);
-	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG, r);
-}
-
-static void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_dma *aud_dma)
-{
-	u32 r;
-
-	DSSDBG("Enter hdmi_wp_audio_config_dma\n");
-
-	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2);
-	r = FLD_MOD(r, aud_dma->transfer_size, 15, 8);
-	r = FLD_MOD(r, aud_dma->block_size, 7, 0);
-	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2, r);
-
-	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL);
-	r = FLD_MOD(r, aud_dma->mode, 9, 9);
-	r = FLD_MOD(r, aud_dma->fifo_threshold, 8, 0);
-	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL, r);
-}
-
-static void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
-					struct hdmi_core_audio_config *cfg)
-{
-	u32 r;
-	void __iomem *av_base = hdmi_av_base(ip_data);
-
-	/* audio clock recovery parameters */
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_ACR_CTRL);
-	r = FLD_MOD(r, cfg->use_mclk, 2, 2);
-	r = FLD_MOD(r, cfg->en_acr_pkt, 1, 1);
-	r = FLD_MOD(r, cfg->cts_mode, 0, 0);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_ACR_CTRL, r);
-
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL1, cfg->n, 7, 0);
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL2, cfg->n >> 8, 7, 0);
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL3, cfg->n >> 16, 7, 0);
-
-	if (cfg->cts_mode == HDMI_AUDIO_CTS_MODE_SW) {
-		REG_FLD_MOD(av_base, HDMI_CORE_AV_CTS_SVAL1, cfg->cts, 7, 0);
-		REG_FLD_MOD(av_base,
-				HDMI_CORE_AV_CTS_SVAL2, cfg->cts >> 8, 7, 0);
-		REG_FLD_MOD(av_base,
-				HDMI_CORE_AV_CTS_SVAL3, cfg->cts >> 16, 7, 0);
-	} else {
-		/*
-		 * HDMI IP uses this configuration to divide the MCLK to
-		 * update CTS value.
-		 */
-		REG_FLD_MOD(av_base,
-				HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
-
-		/* Configure clock for audio packets */
-		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_1,
-				cfg->aud_par_busclk, 7, 0);
-		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_2,
-				(cfg->aud_par_busclk >> 8), 7, 0);
-		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_3,
-				(cfg->aud_par_busclk >> 16), 7, 0);
-	}
-
-	/* Override of SPDIF sample frequency with value in I2S_CHST4 */
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_SPDIF_CTRL,
-						cfg->fs_override, 1, 1);
-
-	/* I2S parameters */
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_CHST4,
-						cfg->freq_sample, 3, 0);
-
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL);
-	r = FLD_MOD(r, cfg->i2s_cfg.en_high_bitrate_aud, 7, 7);
-	r = FLD_MOD(r, cfg->i2s_cfg.sck_edge_mode, 6, 6);
-	r = FLD_MOD(r, cfg->i2s_cfg.cbit_order, 5, 5);
-	r = FLD_MOD(r, cfg->i2s_cfg.vbit, 4, 4);
-	r = FLD_MOD(r, cfg->i2s_cfg.ws_polarity, 3, 3);
-	r = FLD_MOD(r, cfg->i2s_cfg.justification, 2, 2);
-	r = FLD_MOD(r, cfg->i2s_cfg.direction, 1, 1);
-	r = FLD_MOD(r, cfg->i2s_cfg.shift, 0, 0);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL, r);
-
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_CHST5);
-	r = FLD_MOD(r, cfg->freq_sample, 7, 4);
-	r = FLD_MOD(r, cfg->i2s_cfg.word_length, 3, 1);
-	r = FLD_MOD(r, cfg->i2s_cfg.word_max_length, 0, 0);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST5, r);
-
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_IN_LEN,
-			cfg->i2s_cfg.in_length_bits, 3, 0);
-
-	/* Audio channels and mode parameters */
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_HDMI_CTRL, cfg->layout, 2, 1);
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_AUD_MODE);
-	r = FLD_MOD(r, cfg->i2s_cfg.active_sds, 7, 4);
-	r = FLD_MOD(r, cfg->en_dsd_audio, 3, 3);
-	r = FLD_MOD(r, cfg->en_parallel_aud_input, 2, 2);
-	r = FLD_MOD(r, cfg->en_spdif, 1, 1);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_MODE, r);
-}
-
-static void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-		struct hdmi_core_infoframe_audio *info_aud)
-{
-	u8 val;
-	u8 sum = 0, checksum = 0;
-	void __iomem *av_base = hdmi_av_base(ip_data);
-
-	/*
-	 * Set audio info frame type, version and length as
-	 * described in HDMI 1.4a Section 8.2.2 specification.
-	 * Checksum calculation is defined in Section 5.3.5.
-	 */
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_TYPE, 0x84);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_VERS, 0x01);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_LEN, 0x0a);
-	sum += 0x84 + 0x001 + 0x00a;
-
-	val = (info_aud->db1_coding_type << 4)
-			| (info_aud->db1_channel_count - 1);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(0), val);
-	sum += val;
-
-	val = (info_aud->db2_sample_freq << 2) | info_aud->db2_sample_size;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(1), val);
-	sum += val;
-
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
-
-	val = info_aud->db4_channel_alloc;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), val);
-	sum += val;
-
-	val = (info_aud->db5_downmix_inh << 7) | (info_aud->db5_lsv << 3);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(4), val);
-	sum += val;
-
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(5), 0x00);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(6), 0x00);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(7), 0x00);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(8), 0x00);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(9), 0x00);
-
-	checksum = 0x100 - sum;
-	hdmi_write_reg(av_base,
-					HDMI_CORE_AV_AUDIO_CHSUM, checksum);
-
-	/*
-	 * TODO: Add MPEG and SPD enable and repeat cfg when EDID parsing
-	 * is available.
-	 */
-}
-
-static int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
-				u32 sample_freq, u32 *n, u32 *cts)
-{
-	u32 r;
-	u32 deep_color = 0;
-	u32 pclk = hdmi.cfg.timings.timings.pixel_clock;
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
 
 static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 					struct snd_pcm_substream *substream,
@@ -988,39 +766,6 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-static int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
-				struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	int err = 0;
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		REG_FLD_MOD(hdmi_av_base(ip_data),
-					HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 1, 31, 31);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 1, 30, 30);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		REG_FLD_MOD(hdmi_av_base(ip_data),
-					HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 0, 30, 30);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 0, 31, 31);
-		break;
-	default:
-		err = -EINVAL;
-	}
-	return err;
-}
-
 static int hdmi_audio_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index b97a3c0..c2a98f8 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -765,3 +765,263 @@ void hdmi_basic_configure(struct hdmi_ip_data *ip_data)
 	repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
 	hdmi_core_av_packet_config(ip_data, repeat_cfg);
 }
+
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_format *aud_fmt)
+{
+	u32 r;
+
+	DSSDBG("Enter hdmi_wp_audio_config_format\n");
+
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG);
+	r = FLD_MOD(r, aud_fmt->stereo_channels, 26, 24);
+	r = FLD_MOD(r, aud_fmt->active_chnnls_msk, 23, 16);
+	r = FLD_MOD(r, aud_fmt->en_sig_blk_strt_end, 5, 5);
+	r = FLD_MOD(r, aud_fmt->type, 4, 4);
+	r = FLD_MOD(r, aud_fmt->justification, 3, 3);
+	r = FLD_MOD(r, aud_fmt->sample_order, 2, 2);
+	r = FLD_MOD(r, aud_fmt->samples_per_word, 1, 1);
+	r = FLD_MOD(r, aud_fmt->sample_size, 0, 0);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG, r);
+}
+
+void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_dma *aud_dma)
+{
+	u32 r;
+
+	DSSDBG("Enter hdmi_wp_audio_config_dma\n");
+
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2);
+	r = FLD_MOD(r, aud_dma->transfer_size, 15, 8);
+	r = FLD_MOD(r, aud_dma->block_size, 7, 0);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG2, r);
+
+	r = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL);
+	r = FLD_MOD(r, aud_dma->mode, 9, 9);
+	r = FLD_MOD(r, aud_dma->fifo_threshold, 8, 0);
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL, r);
+}
+
+void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+					struct hdmi_core_audio_config *cfg)
+{
+	u32 r;
+	void __iomem *av_base = hdmi_av_base(ip_data);
+
+	/* audio clock recovery parameters */
+	r = hdmi_read_reg(av_base, HDMI_CORE_AV_ACR_CTRL);
+	r = FLD_MOD(r, cfg->use_mclk, 2, 2);
+	r = FLD_MOD(r, cfg->en_acr_pkt, 1, 1);
+	r = FLD_MOD(r, cfg->cts_mode, 0, 0);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_ACR_CTRL, r);
+
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL1, cfg->n, 7, 0);
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL2, cfg->n >> 8, 7, 0);
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL3, cfg->n >> 16, 7, 0);
+
+	if (cfg->cts_mode == HDMI_AUDIO_CTS_MODE_SW) {
+		REG_FLD_MOD(av_base, HDMI_CORE_AV_CTS_SVAL1, cfg->cts, 7, 0);
+		REG_FLD_MOD(av_base,
+				HDMI_CORE_AV_CTS_SVAL2, cfg->cts >> 8, 7, 0);
+		REG_FLD_MOD(av_base,
+				HDMI_CORE_AV_CTS_SVAL3, cfg->cts >> 16, 7, 0);
+	} else {
+		/*
+		 * HDMI IP uses this configuration to divide the MCLK to
+		 * update CTS value.
+		 */
+		REG_FLD_MOD(av_base,
+				HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
+
+		/* Configure clock for audio packets */
+		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_1,
+				cfg->aud_par_busclk, 7, 0);
+		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_2,
+				(cfg->aud_par_busclk >> 8), 7, 0);
+		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_3,
+				(cfg->aud_par_busclk >> 16), 7, 0);
+	}
+
+	/* Override of SPDIF sample frequency with value in I2S_CHST4 */
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_SPDIF_CTRL,
+						cfg->fs_override, 1, 1);
+
+	/* I2S parameters */
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_CHST4,
+						cfg->freq_sample, 3, 0);
+
+	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL);
+	r = FLD_MOD(r, cfg->i2s_cfg.en_high_bitrate_aud, 7, 7);
+	r = FLD_MOD(r, cfg->i2s_cfg.sck_edge_mode, 6, 6);
+	r = FLD_MOD(r, cfg->i2s_cfg.cbit_order, 5, 5);
+	r = FLD_MOD(r, cfg->i2s_cfg.vbit, 4, 4);
+	r = FLD_MOD(r, cfg->i2s_cfg.ws_polarity, 3, 3);
+	r = FLD_MOD(r, cfg->i2s_cfg.justification, 2, 2);
+	r = FLD_MOD(r, cfg->i2s_cfg.direction, 1, 1);
+	r = FLD_MOD(r, cfg->i2s_cfg.shift, 0, 0);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL, r);
+
+	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_CHST5);
+	r = FLD_MOD(r, cfg->freq_sample, 7, 4);
+	r = FLD_MOD(r, cfg->i2s_cfg.word_length, 3, 1);
+	r = FLD_MOD(r, cfg->i2s_cfg.word_max_length, 0, 0);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST5, r);
+
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_IN_LEN,
+			cfg->i2s_cfg.in_length_bits, 3, 0);
+
+	/* Audio channels and mode parameters */
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_HDMI_CTRL, cfg->layout, 2, 1);
+	r = hdmi_read_reg(av_base, HDMI_CORE_AV_AUD_MODE);
+	r = FLD_MOD(r, cfg->i2s_cfg.active_sds, 7, 4);
+	r = FLD_MOD(r, cfg->en_dsd_audio, 3, 3);
+	r = FLD_MOD(r, cfg->en_parallel_aud_input, 2, 2);
+	r = FLD_MOD(r, cfg->en_spdif, 1, 1);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_MODE, r);
+}
+
+void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+		struct hdmi_core_infoframe_audio *info_aud)
+{
+	u8 val;
+	u8 sum = 0, checksum = 0;
+	void __iomem *av_base = hdmi_av_base(ip_data);
+
+	/*
+	 * Set audio info frame type, version and length as
+	 * described in HDMI 1.4a Section 8.2.2 specification.
+	 * Checksum calculation is defined in Section 5.3.5.
+	 */
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_TYPE, 0x84);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_VERS, 0x01);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_LEN, 0x0a);
+	sum += 0x84 + 0x001 + 0x00a;
+
+	val = (info_aud->db1_coding_type << 4)
+			| (info_aud->db1_channel_count - 1);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(0), val);
+	sum += val;
+
+	val = (info_aud->db2_sample_freq << 2) | info_aud->db2_sample_size;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(1), val);
+	sum += val;
+
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
+
+	val = info_aud->db4_channel_alloc;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), val);
+	sum += val;
+
+	val = (info_aud->db5_downmix_inh << 7) | (info_aud->db5_lsv << 3);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(4), val);
+	sum += val;
+
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(5), 0x00);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(6), 0x00);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(7), 0x00);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(8), 0x00);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(9), 0x00);
+
+	checksum = 0x100 - sum;
+	hdmi_write_reg(av_base,
+					HDMI_CORE_AV_AUDIO_CHSUM, checksum);
+
+	/*
+	 * TODO: Add MPEG and SPD enable and repeat cfg when EDID parsing
+	 * is available.
+	 */
+}
+
+int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
+				u32 sample_freq, u32 *n, u32 *cts)
+{
+	u32 r;
+	u32 deep_color = 0;
+	u32 pclk = ip_data->cfg.timings.timings.pixel_clock;
+
+	if (n == NULL || cts == NULL)
+		return -EINVAL;
+	/*
+	 * Obtain current deep color configuration. This needed
+	 * to calculate the TMDS clock based on the pixel clock.
+	 */
+	r = REG_GET(hdmi_wp_base(ip_data), HDMI_WP_VIDEO_CFG, 1, 0);
+	switch (r) {
+	case 1: /* No deep color selected */
+		deep_color = 100;
+		break;
+	case 2: /* 10-bit deep color selected */
+		deep_color = 125;
+		break;
+	case 3: /* 12-bit deep color selected */
+		deep_color = 150;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (sample_freq) {
+	case 32000:
+		if ((deep_color == 125) && ((pclk == 54054)
+				|| (pclk == 74250)))
+			*n = 8192;
+		else
+			*n = 4096;
+		break;
+	case 44100:
+		*n = 6272;
+		break;
+	case 48000:
+		if ((deep_color == 125) && ((pclk == 54054)
+				|| (pclk == 74250)))
+			*n = 8192;
+		else
+			*n = 6144;
+		break;
+	default:
+		*n = 0;
+		return -EINVAL;
+	}
+
+	/* Calculate CTS. See HDMI 1.3a or 1.4a specifications */
+	*cts = pclk * (*n / 128) * deep_color / (sample_freq / 10);
+
+	return 0;
+}
+
+int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
+				struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	int err = 0;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+					HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 1, 31, 31);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 1, 30, 30);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		REG_FLD_MOD(hdmi_av_base(ip_data),
+					HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 0, 30, 30);
+		REG_FLD_MOD(hdmi_wp_base(ip_data),
+					HDMI_WP_AUDIO_CTRL, 0, 31, 31);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
+}
+#endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 7feead1..929de88 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -24,6 +24,11 @@
 #include <linux/string.h>
 #include <video/omapdss.h>
 #include "ti_hdmi.h"
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#endif
 
 struct hdmi_reg { u16 idx; };
 
@@ -572,4 +577,21 @@ struct hdmi_core_audio_config {
 	bool					en_parallel_aud_input;
 	bool					en_spdif;
 };
+
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
+				struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai);
+int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
+				u32 sample_freq, u32 *n, u32 *cts);
+void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+		struct hdmi_core_infoframe_audio *info_aud);
+void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+					struct hdmi_core_audio_config *cfg);
+void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_dma *aud_dma);
+void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_format *aud_fmt);
+#endif
 #endif
-- 
1.7.5.4

