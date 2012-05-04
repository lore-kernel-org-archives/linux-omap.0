From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 11/14] OMAPDSS: HDMI: Add an audio configuration function
Date: Thu, 3 May 2012 20:44:05 -0500
Message-ID: <1336095848-6923-12-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52866 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759218Ab2EDBoc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:32 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

The generic HDMI driver does not need to know about the specific
settings of a given IP. Hence, it just passes the audio configuration
and the IP library parses such configuration and sets the IP
accordingly. This patch introduces an IP-specific audio configuration
function.

Also, this patch implements the audio config function for OMAP4. The
DMA, format and core config functions are no longer exposed to the
generic HDMI driver as they are IP-specific.

The audio configuration function caters for 16-bit through 24-bit
audio samples with sample rates from 32kHz and up to 192kHz as well
as up to 8 audio channels.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/ti_hdmi.h         |    5 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  189 ++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   10 --
 4 files changed, 191 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 508cc4a..bff51a0 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -572,6 +572,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.audio_disable		=       ti_hdmi_4xxx_wp_audio_disable,
 	.audio_start		=       ti_hdmi_4xxx_audio_start,
 	.audio_stop		=       ti_hdmi_4xxx_audio_stop,
+	.audio_config		=	ti_hdmi_4xxx_audio_config,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 852a803..e734cb4 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -116,6 +116,9 @@ struct ti_hdmi_ip_ops {
 	int (*audio_start)(struct hdmi_ip_data *ip_data);
 
 	void (*audio_stop)(struct hdmi_ip_data *ip_data);
+
+	int (*audio_config)(struct hdmi_ip_data *ip_data,
+		struct omap_dss_audio *audio);
 #endif
 
 };
@@ -195,5 +198,7 @@ int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_audio_stop(struct hdmi_ip_data *ip_data);
+int ti_hdmi_4xxx_audio_config(struct hdmi_ip_data *ip_data,
+		struct omap_dss_audio *audio);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 5612534..74d9420 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -31,10 +31,12 @@
 #include <linux/gpio.h>
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 #include <sound/asound.h>
+#include <sound/asoundef.h>
 #endif
 
 #include "ti_hdmi_4xxx_ip.h"
 #include "dss.h"
+#include "dss_features.h"
 
 static inline void hdmi_write_reg(void __iomem *base_addr,
 				const u16 idx, u32 val)
@@ -1026,7 +1028,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
-void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
+static void ti_hdmi_4xxx_wp_audio_config_format(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_format *aud_fmt)
 {
 	u32 r;
@@ -1045,7 +1047,7 @@ void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CFG, r);
 }
 
-void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
+static void ti_hdmi_4xxx_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_dma *aud_dma)
 {
 	u32 r;
@@ -1063,7 +1065,7 @@ void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL, r);
 }
 
-void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+static void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
 					struct hdmi_core_audio_config *cfg)
 {
 	u32 r;
@@ -1154,7 +1156,7 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_MODE, r);
 }
 
-void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+static void ti_hdmi_4xxx_core_audio_infoframe_cfg(struct hdmi_ip_data *ip_data,
 		struct snd_cea_861_aud_if *info_aud)
 {
 	u8 sum = 0, checksum = 0;
@@ -1204,6 +1206,185 @@ void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 	 */
 }
 
+int ti_hdmi_4xxx_audio_config(struct hdmi_ip_data *ip_data,
+		struct omap_dss_audio *audio)
+{
+	struct hdmi_audio_format audio_format;
+	struct hdmi_audio_dma audio_dma;
+	struct hdmi_core_audio_config core;
+	int err, n, cts, channel_count;
+	unsigned int fs_nr;
+	bool word_length_16b = false;
+
+	if (!audio || !audio->iec || !audio->cea || !ip_data)
+		return -EINVAL;
+
+	core.iec60958_cfg = audio->iec;
+	/*
+	 * In the IEC-60958 status word, check if the audio sample word length
+	 * is 16-bit as several optimizations can be performed in such case.
+	 */
+	if (!(audio->iec->status[4] & IEC958_AES4_CON_MAX_WORDLEN_24))
+		if (audio->iec->status[4] & IEC958_AES4_CON_WORDLEN_20_16)
+			word_length_16b = true;
+
+	/* I2S configuration. See Phillips' specification */
+	if (word_length_16b)
+		core.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_LEFT;
+	else
+		core.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
+	/*
+	 * The I2S input word length is twice the lenght given in the IEC-60958
+	 * status word. If the word size is greater than
+	 * 20 bits, increment by one.
+	 */
+	core.i2s_cfg.in_length_bits = audio->iec->status[4]
+		& IEC958_AES4_CON_WORDLEN;
+	if (audio->iec->status[4] & IEC958_AES4_CON_MAX_WORDLEN_24)
+		core.i2s_cfg.in_length_bits++;
+	core.i2s_cfg.sck_edge_mode = HDMI_AUDIO_I2S_SCK_EDGE_RISING;
+	core.i2s_cfg.vbit = HDMI_AUDIO_I2S_VBIT_FOR_PCM;
+	core.i2s_cfg.direction = HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST;
+	core.i2s_cfg.shift = HDMI_AUDIO_I2S_FIRST_BIT_SHIFT;
+
+	/* convert sample frequency to a number */
+	switch (audio->iec->status[3] & IEC958_AES3_CON_FS) {
+	case IEC958_AES3_CON_FS_32000:
+		fs_nr = 32000;
+		break;
+	case IEC958_AES3_CON_FS_44100:
+		fs_nr = 44100;
+		break;
+	case IEC958_AES3_CON_FS_48000:
+		fs_nr = 48000;
+		break;
+	case IEC958_AES3_CON_FS_88200:
+		fs_nr = 88200;
+		break;
+	case IEC958_AES3_CON_FS_96000:
+		fs_nr = 96000;
+		break;
+	case IEC958_AES3_CON_FS_176400:
+		fs_nr = 176400;
+		break;
+	case IEC958_AES3_CON_FS_192000:
+		fs_nr = 192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = hdmi_compute_acr(fs_nr, &n, &cts);
+
+	/* Audio clock regeneration settings */
+	core.n = n;
+	core.cts = cts;
+	if (dss_has_feature(FEAT_HDMI_CTS_SWMODE)) {
+		core.aud_par_busclk = 0;
+		core.cts_mode = HDMI_AUDIO_CTS_MODE_SW;
+		core.use_mclk = dss_has_feature(FEAT_HDMI_AUDIO_USE_MCLK);
+	} else {
+		core.aud_par_busclk = (((128 * 31) - 1) << 8);
+		core.cts_mode = HDMI_AUDIO_CTS_MODE_HW;
+		core.use_mclk = true;
+	}
+
+	if (core.use_mclk)
+		core.mclk_mode = HDMI_AUDIO_MCLK_128FS;
+
+	/* Audio channels settings */
+	channel_count = (audio->cea->db1_ct_cc &
+			 CEA861_AUDIO_INFOFRAME_DB1CC) + 1;
+
+	switch (channel_count) {
+	case 2:
+		audio_format.active_chnnls_msk = 0x03;
+		break;
+	case 3:
+		audio_format.active_chnnls_msk = 0x07;
+		break;
+	case 4:
+		audio_format.active_chnnls_msk = 0x0f;
+		break;
+	case 5:
+		audio_format.active_chnnls_msk = 0x1f;
+		break;
+	case 6:
+		audio_format.active_chnnls_msk = 0x3f;
+		break;
+	case 7:
+		audio_format.active_chnnls_msk = 0x7f;
+		break;
+	case 8:
+		audio_format.active_chnnls_msk = 0xff;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * the HDMI IP needs to enable four stereo channels when transmitting
+	 * more than 2 audio channels
+	 */
+	if (channel_count == 2) {
+		audio_format.stereo_channels = HDMI_AUDIO_STEREO_ONECHANNEL;
+		core.i2s_cfg.active_sds = HDMI_AUDIO_I2S_SD0_EN;
+		core.layout = HDMI_AUDIO_LAYOUT_2CH;
+	} else {
+		audio_format.stereo_channels = HDMI_AUDIO_STEREO_FOURCHANNELS;
+		core.i2s_cfg.active_sds = HDMI_AUDIO_I2S_SD0_EN |
+				HDMI_AUDIO_I2S_SD1_EN | HDMI_AUDIO_I2S_SD2_EN |
+				HDMI_AUDIO_I2S_SD3_EN;
+		core.layout = HDMI_AUDIO_LAYOUT_8CH;
+	}
+
+	core.en_spdif = false;
+	/* use sample frequency from channel status word */
+	core.fs_override = true;
+	/* enable ACR packets */
+	core.en_acr_pkt = true;
+	/* disable direct streaming digital audio */
+	core.en_dsd_audio = false;
+	/* use parallel audio interface */
+	core.en_parallel_aud_input = true;
+
+	/* DMA settings */
+	if (word_length_16b)
+		audio_dma.transfer_size = 0x10;
+	else
+		audio_dma.transfer_size = 0x20;
+	audio_dma.block_size = 0xC0;
+	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
+	audio_dma.fifo_threshold = 0x20; /* in number of samples */
+
+	/* audio FIFO format settings */
+	if (word_length_16b) {
+		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_TWOSAMPLES;
+		audio_format.sample_size = HDMI_AUDIO_SAMPLE_16BITS;
+		audio_format.justification = HDMI_AUDIO_JUSTIFY_LEFT;
+	} else {
+		audio_format.samples_per_word = HDMI_AUDIO_ONEWORD_ONESAMPLE;
+		audio_format.sample_size = HDMI_AUDIO_SAMPLE_24BITS;
+		audio_format.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
+	}
+	audio_format.type = HDMI_AUDIO_TYPE_LPCM;
+	audio_format.sample_order = HDMI_AUDIO_SAMPLE_LEFT_FIRST;
+	/* disable start/stop signals of IEC 60958 blocks */
+	audio_format.en_sig_blk_strt_end = HDMI_AUDIO_BLOCK_SIG_STARTEND_ON;
+
+	/* configure DMA and audio FIFO format*/
+	ti_hdmi_4xxx_wp_audio_config_dma(ip_data, &audio_dma);
+	ti_hdmi_4xxx_wp_audio_config_format(ip_data, &audio_format);
+
+	/* configure the core*/
+	ti_hdmi_4xxx_core_audio_config(ip_data, &core);
+
+	/* configure CEA 861 audio infoframe*/
+	ti_hdmi_4xxx_core_audio_infoframe_cfg(ip_data, audio->cea);
+
+	return 0;
+}
+
 int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data)
 {
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 7199c19..609d086 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -438,14 +438,4 @@ struct hdmi_core_audio_config {
 	bool					en_spdif;
 };
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
-void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-		struct snd_cea_861_aud_if *info_aud);
-void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
-					struct hdmi_core_audio_config *cfg);
-void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_dma *aud_dma);
-void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_format *aud_fmt);
-#endif
 #endif
-- 
1.7.5.4

