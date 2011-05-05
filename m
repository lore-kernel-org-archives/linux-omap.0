From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/5] OMAP4: DSS2: HDMI: Add enums and structures for audio
Date: Thu,  5 May 2011 02:01:32 -0500
Message-ID: <1304578894-23967-4-git-send-email-ricardo.neri@ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40323 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab1EEHB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 03:01:27 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4571QNV008167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 02:01:26 -0500
In-Reply-To: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, mythripk@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

Add enurations and structures for audio configuration. This includes
enumerations for the Audio InfoFrame, I2S, audio FIFO and audio core.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.h |  220 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 218 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index 9887ab9..1a5da3c 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -48,6 +48,10 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_WP_VIDEO_TIMING_H			HDMI_WP_REG(0x68)
 #define HDMI_WP_VIDEO_TIMING_V			HDMI_WP_REG(0x6C)
 #define HDMI_WP_WP_CLK				HDMI_WP_REG(0x70)
+#define HDMI_WP_AUDIO_CFG			HDMI_WP_REG(0x80)
+#define HDMI_WP_AUDIO_CFG2			HDMI_WP_REG(0x84)
+#define HDMI_WP_AUDIO_CTRL			HDMI_WP_REG(0x88)
+#define HDMI_WP_AUDIO_DATA			HDMI_WP_REG(0x8C)
 
 /* HDMI IP Core System */
 #define HDMI_CORE_SYS_REG(idx)			HDMI_REG(HDMI_CORE_SYS + idx)
@@ -105,6 +109,8 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_CORE_AV_AVI_DBYTE_NELEMS		HDMI_CORE_AV_REG(15)
 #define HDMI_CORE_AV_SPD_DBYTE			HDMI_CORE_AV_REG(0x190)
 #define HDMI_CORE_AV_SPD_DBYTE_NELEMS		HDMI_CORE_AV_REG(27)
+#define HDMI_CORE_AV_AUD_DBYTE(n)		HDMI_CORE_AV_REG(n * 4 + 0x210)
+#define HDMI_CORE_AV_AUD_DBYTE_NELEMS		HDMI_CORE_AV_REG(10)
 #define HDMI_CORE_AV_MPEG_DBYTE		HDMI_CORE_AV_REG(0x290)
 #define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		HDMI_CORE_AV_REG(27)
 #define HDMI_CORE_AV_GEN_DBYTE			HDMI_CORE_AV_REG(0x300)
@@ -153,6 +159,10 @@ struct hdmi_reg { u16 idx; };
 #define HDMI_CORE_AV_SPD_VERS			HDMI_CORE_AV_REG(0x184)
 #define HDMI_CORE_AV_SPD_LEN			HDMI_CORE_AV_REG(0x188)
 #define HDMI_CORE_AV_SPD_CHSUM			HDMI_CORE_AV_REG(0x18C)
+#define HDMI_CORE_AV_AUDIO_TYPE		HDMI_CORE_AV_REG(0x200)
+#define HDMI_CORE_AV_AUDIO_VERS		HDMI_CORE_AV_REG(0x204)
+#define HDMI_CORE_AV_AUDIO_LEN			HDMI_CORE_AV_REG(0x208)
+#define HDMI_CORE_AV_AUDIO_CHSUM		HDMI_CORE_AV_REG(0x20C)
 #define HDMI_CORE_AV_MPEG_TYPE			HDMI_CORE_AV_REG(0x280)
 #define HDMI_CORE_AV_MPEG_VERS			HDMI_CORE_AV_REG(0x284)
 #define HDMI_CORE_AV_MPEG_LEN			HDMI_CORE_AV_REG(0x288)
@@ -272,7 +282,7 @@ enum hdmi_core_packet_ctrl {
 	HDMI_PACKETREPEATOFF = 0
 };
 
-/* INFOFRAME_AVI_ definitions */
+/* INFOFRAME_AVI_ and INFOFRAME_AUDIO_ definitions */
 enum hdmi_core_infoframe {
 	HDMI_INFOFRAME_AVI_DB1Y_RGB = 0,
 	HDMI_INFOFRAME_AVI_DB1Y_YUV422 = 1,
@@ -317,7 +327,36 @@ enum hdmi_core_infoframe {
 	HDMI_INFOFRAME_AVI_DB5PR_7 = 6,
 	HDMI_INFOFRAME_AVI_DB5PR_8 = 7,
 	HDMI_INFOFRAME_AVI_DB5PR_9 = 8,
-	HDMI_INFOFRAME_AVI_DB5PR_10 = 9
+	HDMI_INFOFRAME_AVI_DB5PR_10 = 9,
+	HDMI_INFOFRAME_AUDIO_DB1CT_FROM_STREAM = 0,
+	HDMI_INFOFRAME_AUDIO_DB1CT_IEC60958 = 1,
+	HDMI_INFOFRAME_AUDIO_DB1CT_AC3 = 2,
+	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG1 = 3,
+	HDMI_INFOFRAME_AUDIO_DB1CT_MP3 = 4,
+	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG2_MULTICH = 5,
+	HDMI_INFOFRAME_AUDIO_DB1CT_AAC = 6,
+	HDMI_INFOFRAME_AUDIO_DB1CT_DTS = 7,
+	HDMI_INFOFRAME_AUDIO_DB1CT_ATRAC = 8,
+	HDMI_INFOFRAME_AUDIO_DB1CT_ONEBIT = 9,
+	HDMI_INFOFRAME_AUDIO_DB1CT_DOLBY_DIGITAL_PLUS = 10,
+	HDMI_INFOFRAME_AUDIO_DB1CT_DTS_HD = 11,
+	HDMI_INFOFRAME_AUDIO_DB1CT_MAT = 12,
+	HDMI_INFOFRAME_AUDIO_DB1CT_DST = 13,
+	HDMI_INFOFRAME_AUDIO_DB1CT_WMA_PRO = 14,
+	HDMI_INFOFRAME_AUDIO_DB2SF_FROM_STREAM = 0,
+	HDMI_INFOFRAME_AUDIO_DB2SF_32000 = 1,
+	HDMI_INFOFRAME_AUDIO_DB2SF_44100 = 2,
+	HDMI_INFOFRAME_AUDIO_DB2SF_48000 = 3,
+	HDMI_INFOFRAME_AUDIO_DB2SF_88200 = 4,
+	HDMI_INFOFRAME_AUDIO_DB2SF_96000 = 5,
+	HDMI_INFOFRAME_AUDIO_DB2SF_176400 = 6,
+	HDMI_INFOFRAME_AUDIO_DB2SF_192000 = 7,
+	HDMI_INFOFRAME_AUDIO_DB2SS_FROM_STREAM = 0,
+	HDMI_INFOFRAME_AUDIO_DB2SS_16BIT = 1,
+	HDMI_INFOFRAME_AUDIO_DB2SS_20BIT = 2,
+	HDMI_INFOFRAME_AUDIO_DB2SS_24BIT = 3,
+	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PERMITTED = 0,
+	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PROHIBITED = 1
 };
 
 enum hdmi_packing_mode {
@@ -327,6 +366,121 @@ enum hdmi_packing_mode {
 	HDMI_PACK_ALREADYPACKED = 7
 };
 
+enum hdmi_core_audio_sample_freq {
+	HDMI_AUDIO_FS_32000 = 0x3,
+	HDMI_AUDIO_FS_44100 = 0x0,
+	HDMI_AUDIO_FS_48000 = 0x2,
+	HDMI_AUDIO_FS_88200 = 0x8,
+	HDMI_AUDIO_FS_96000 = 0xA,
+	HDMI_AUDIO_FS_176400 = 0xC,
+	HDMI_AUDIO_FS_192000 = 0xE,
+	HDMI_AUDIO_FS_NOT_INDICATED = 0x1
+};
+
+enum hdmi_core_audio_layout {
+	HDMI_AUDIO_LAYOUT_2CH = 0,
+	HDMI_AUDIO_LAYOUT_8CH = 1
+};
+
+enum hdmi_core_cts_mode {
+	HDMI_AUDIO_CTS_MODE_HW = 0,
+	HDMI_AUDIO_CTS_MODE_SW = 1
+};
+
+enum hdmi_stereo_channels {
+	HDMI_AUDIO_STEREO_NOCHANNELS = 0,
+	HDMI_AUDIO_STEREO_ONECHANNEL = 1,
+	HDMI_AUDIO_STEREO_TWOCHANNELS = 2,
+	HDMI_AUDIO_STEREO_THREECHANNELS = 3,
+	HDMI_AUDIO_STEREO_FOURCHANNELS = 4
+};
+
+enum hdmi_audio_type {
+	HDMI_AUDIO_TYPE_LPCM = 0,
+	HDMI_AUDIO_TYPE_IEC = 1
+};
+
+enum hdmi_audio_justify {
+	HDMI_AUDIO_JUSTIFY_LEFT = 0,
+	HDMI_AUDIO_JUSTIFY_RIGHT = 1
+};
+
+enum hdmi_audio_sample_order {
+	HDMI_AUDIO_SAMPLE_RIGHT_FIRST = 0,
+	HDMI_AUDIO_SAMPLE_LEFT_FIRST = 1
+};
+
+enum hdmi_audio_samples_perword {
+	HDMI_AUDIO_ONEWORD_ONESAMPLE = 0,
+	HDMI_AUDIO_ONEWORD_TWOSAMPLES = 1
+};
+
+enum hdmi_audio_sample_size {
+	HDMI_AUDIO_SAMPLE_16BITS = 0,
+	HDMI_AUDIO_SAMPLE_24BITS = 1
+};
+
+enum hdmi_audio_transf_mode {
+	HDMI_AUDIO_TRANSF_DMA = 0,
+	HDMI_AUDIO_TRANSF_IRQ = 1
+};
+
+enum hdmi_audio_blk_strt_end_sig {
+	HDMI_AUDIO_BLOCK_SIG_STARTEND_ON = 0,
+	HDMI_AUDIO_BLOCK_SIG_STARTEND_OFF = 1
+};
+
+enum hdmi_audio_i2s_config {
+	HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_LEFT = 0,
+	HDMI_AUDIO_I2S_WS_POLARIT_YLOW_IS_RIGHT = 1,
+	HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST = 0,
+	HDMI_AUDIO_I2S_LSB_SHIFTED_FIRST = 1,
+	HDMI_AUDIO_I2S_MAX_WORD_20BITS = 0,
+	HDMI_AUDIO_I2S_MAX_WORD_24BITS = 1,
+	HDMI_AUDIO_I2S_CHST_WORD_NOT_SPECIFIED = 0,
+	HDMI_AUDIO_I2S_CHST_WORD_16_BITS = 1,
+	HDMI_AUDIO_I2S_CHST_WORD_17_BITS = 6,
+	HDMI_AUDIO_I2S_CHST_WORD_18_BITS = 2,
+	HDMI_AUDIO_I2S_CHST_WORD_19_BITS = 4,
+	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_20MAX = 5,
+	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_24MAX = 1,
+	HDMI_AUDIO_I2S_CHST_WORD_21_BITS = 6,
+	HDMI_AUDIO_I2S_CHST_WORD_22_BITS = 2,
+	HDMI_AUDIO_I2S_CHST_WORD_23_BITS = 4,
+	HDMI_AUDIO_I2S_CHST_WORD_24_BITS = 5,
+	HDMI_AUDIO_I2S_SCK_EDGE_FALLING = 0,
+	HDMI_AUDIO_I2S_SCK_EDGE_RISING = 1,
+	HDMI_AUDIO_I2S_VBIT_FOR_PCM = 0,
+	HDMI_AUDIO_I2S_VBIT_FOR_COMPRESSED = 1,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_NA = 0,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_16 = 2,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_17 = 12,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_18 = 4,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_19 = 8,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_20 = 10,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_21 = 13,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_22 = 5,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_23 = 9,
+	HDMI_AUDIO_I2S_INPUT_LENGTH_24 = 11,
+	HDMI_AUDIO_I2S_FIRST_BIT_SHIFT = 0,
+	HDMI_AUDIO_I2S_FIRST_BIT_NO_SHIFT = 1,
+	HDMI_AUDIO_I2S_SD0_EN = 1,
+	HDMI_AUDIO_I2S_SD1_EN = 1 << 1,
+	HDMI_AUDIO_I2S_SD2_EN = 1 << 2,
+	HDMI_AUDIO_I2S_SD3_EN = 1 << 3,
+};
+
+enum hdmi_audio_mclk_mode {
+	HDMI_AUDIO_MCLK_128FS = 0,
+	HDMI_AUDIO_MCLK_256FS = 1,
+	HDMI_AUDIO_MCLK_384FS = 2,
+	HDMI_AUDIO_MCLK_512FS = 3,
+	HDMI_AUDIO_MCLK_768FS = 4,
+	HDMI_AUDIO_MCLK_1024FS = 5,
+	HDMI_AUDIO_MCLK_1152FS = 6,
+	HDMI_AUDIO_MCLK_192FS = 7
+};
+
 struct hdmi_core_video_config {
 	enum hdmi_core_inputbus_width	ip_bus_width;
 	enum hdmi_core_dither_trunc	op_dither_truc;
@@ -376,6 +530,19 @@ struct hdmi_core_infoframe_avi {
 	u16	db12_13_pixel_sofright;
 		/* Pixel number start of right bar */
 };
+/*
+ * Refer to section 8.2 in HDMI 1.3 specification for
+ * details about infoframe databytes
+ */
+struct hdmi_core_infoframe_audio {
+	u8 db1_coding_type;
+	u8 db1_channel_count;
+	u8 db2_sample_freq;
+	u8 db2_sample_size;
+	u8 db4_channel_alloc;
+	bool db5_downmix_inh;
+	u8 db5_lsv;	/* Level shift values for downmix */
+};
 
 struct hdmi_core_packet_enable_repeat {
 	u32	audio_pkt;
@@ -412,4 +579,53 @@ struct hdmi_config {
 	struct hdmi_cm cm;
 };
 
+struct hdmi_audio_format {
+	enum hdmi_stereo_channels		stereo_channels;
+	u8					active_chnnls_msk;
+	enum hdmi_audio_type			type;
+	enum hdmi_audio_justify			justification;
+	enum hdmi_audio_sample_order		sample_order;
+	enum hdmi_audio_samples_perword		samples_per_word;
+	enum hdmi_audio_sample_size		sample_size;
+	enum hdmi_audio_blk_strt_end_sig	en_sig_blk_strt_end;
+};
+
+struct hdmi_audio_dma {
+	u8				transfer_size;
+	u8				block_size;
+	enum hdmi_audio_transf_mode	mode;
+	u16				fifo_threshold;
+};
+
+struct hdmi_core_audio_i2s_config {
+	u8 word_max_length;
+	u8 word_length;
+	u8 in_length_bits;
+	u8 justification;
+	u8 en_high_bitrate_aud;
+	u8 sck_edge_mode;
+	u8 cbit_order;
+	u8 vbit;
+	u8 ws_polarity;
+	u8 direction;
+	u8 shift;
+	u8 active_sds;
+};
+
+struct hdmi_core_audio_config {
+	struct hdmi_core_audio_i2s_config	i2s_cfg;
+	enum hdmi_core_audio_sample_freq	freq_sample;
+	bool					fs_override;
+	u32					n;
+	u32					cts;
+	u32					aud_par_busclk;
+	enum hdmi_core_audio_layout		layout;
+	enum hdmi_core_cts_mode			cts_mode;
+	bool					use_mclk;
+	enum hdmi_audio_mclk_mode		mclk_mode;
+	bool					en_acr_pkt;
+	bool					en_dsd_audio;
+	bool					en_parallel_aud_input;
+	bool					en_spdif;
+};
 #endif
-- 
1.7.1

