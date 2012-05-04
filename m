From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 04/14] OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio infoframe and IEC-60958 enums
Date: Thu, 3 May 2012 20:43:58 -0500
Message-ID: <1336095848-6923-5-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759215Ab2EDBoc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:32 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Instead of having its own definitions for CEA-861 and IEC-60958, the HDMI
driver should use those provided by ALSA. This patch removes the definitions
that are already provided by ALSA.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   34 ++++++------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   81 +----------------------------
 2 files changed, 20 insertions(+), 95 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index aa18163..ac73309 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -29,6 +29,10 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/gpio.h>
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#include <sound/asound.h>
+#endif
 
 #include "ti_hdmi_4xxx_ip.h"
 #include "dss.h"
@@ -1147,9 +1151,8 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 }
 
 void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-		struct hdmi_core_infoframe_audio *info_aud)
+		struct snd_cea_861_aud_if *info_aud)
 {
-	u8 val;
 	u8 sum = 0, checksum = 0;
 	void __iomem *av_base = hdmi_av_base(ip_data);
 
@@ -1163,24 +1166,23 @@ void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_LEN, 0x0a);
 	sum += 0x84 + 0x001 + 0x00a;
 
-	val = (info_aud->db1_coding_type << 4)
-			| (info_aud->db1_channel_count - 1);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(0), val);
-	sum += val;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(0),
+		       info_aud->db1_ct_cc);
+	sum += info_aud->db1_ct_cc;
 
-	val = (info_aud->db2_sample_freq << 2) | info_aud->db2_sample_size;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(1), val);
-	sum += val;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(1),
+		       info_aud->db2_sf_ss);
+	sum += info_aud->db2_sf_ss;
 
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), info_aud->db3);
+	sum += info_aud->db3;
 
-	val = info_aud->db4_channel_alloc;
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), val);
-	sum += val;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), info_aud->db4_ca);
+	sum += info_aud->db4_ca;
 
-	val = (info_aud->db5_downmix_inh << 7) | (info_aud->db5_lsv << 3);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(4), val);
-	sum += val;
+	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(4),
+		       info_aud->db5_dminh_lsv);
+	sum += info_aud->db5_dminh_lsv;
 
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(5), 0x00);
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(6), 0x00);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index a5f28af..26b91ff 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -279,35 +279,6 @@ enum hdmi_core_infoframe {
 	HDMI_INFOFRAME_AVI_DB5PR_8 = 7,
 	HDMI_INFOFRAME_AVI_DB5PR_9 = 8,
 	HDMI_INFOFRAME_AVI_DB5PR_10 = 9,
-	HDMI_INFOFRAME_AUDIO_DB1CT_FROM_STREAM = 0,
-	HDMI_INFOFRAME_AUDIO_DB1CT_IEC60958 = 1,
-	HDMI_INFOFRAME_AUDIO_DB1CT_AC3 = 2,
-	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG1 = 3,
-	HDMI_INFOFRAME_AUDIO_DB1CT_MP3 = 4,
-	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG2_MULTICH = 5,
-	HDMI_INFOFRAME_AUDIO_DB1CT_AAC = 6,
-	HDMI_INFOFRAME_AUDIO_DB1CT_DTS = 7,
-	HDMI_INFOFRAME_AUDIO_DB1CT_ATRAC = 8,
-	HDMI_INFOFRAME_AUDIO_DB1CT_ONEBIT = 9,
-	HDMI_INFOFRAME_AUDIO_DB1CT_DOLBY_DIGITAL_PLUS = 10,
-	HDMI_INFOFRAME_AUDIO_DB1CT_DTS_HD = 11,
-	HDMI_INFOFRAME_AUDIO_DB1CT_MAT = 12,
-	HDMI_INFOFRAME_AUDIO_DB1CT_DST = 13,
-	HDMI_INFOFRAME_AUDIO_DB1CT_WMA_PRO = 14,
-	HDMI_INFOFRAME_AUDIO_DB2SF_FROM_STREAM = 0,
-	HDMI_INFOFRAME_AUDIO_DB2SF_32000 = 1,
-	HDMI_INFOFRAME_AUDIO_DB2SF_44100 = 2,
-	HDMI_INFOFRAME_AUDIO_DB2SF_48000 = 3,
-	HDMI_INFOFRAME_AUDIO_DB2SF_88200 = 4,
-	HDMI_INFOFRAME_AUDIO_DB2SF_96000 = 5,
-	HDMI_INFOFRAME_AUDIO_DB2SF_176400 = 6,
-	HDMI_INFOFRAME_AUDIO_DB2SF_192000 = 7,
-	HDMI_INFOFRAME_AUDIO_DB2SS_FROM_STREAM = 0,
-	HDMI_INFOFRAME_AUDIO_DB2SS_16BIT = 1,
-	HDMI_INFOFRAME_AUDIO_DB2SS_20BIT = 2,
-	HDMI_INFOFRAME_AUDIO_DB2SS_24BIT = 3,
-	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PERMITTED = 0,
-	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PROHIBITED = 1
 };
 
 enum hdmi_packing_mode {
@@ -317,17 +288,6 @@ enum hdmi_packing_mode {
 	HDMI_PACK_ALREADYPACKED = 7
 };
 
-enum hdmi_core_audio_sample_freq {
-	HDMI_AUDIO_FS_32000 = 0x3,
-	HDMI_AUDIO_FS_44100 = 0x0,
-	HDMI_AUDIO_FS_48000 = 0x2,
-	HDMI_AUDIO_FS_88200 = 0x8,
-	HDMI_AUDIO_FS_96000 = 0xA,
-	HDMI_AUDIO_FS_176400 = 0xC,
-	HDMI_AUDIO_FS_192000 = 0xE,
-	HDMI_AUDIO_FS_NOT_INDICATED = 0x1
-};
-
 enum hdmi_core_audio_layout {
 	HDMI_AUDIO_LAYOUT_2CH = 0,
 	HDMI_AUDIO_LAYOUT_8CH = 1
@@ -386,33 +346,10 @@ enum hdmi_audio_i2s_config {
 	HDMI_AUDIO_I2S_WS_POLARIT_YLOW_IS_RIGHT = 1,
 	HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST = 0,
 	HDMI_AUDIO_I2S_LSB_SHIFTED_FIRST = 1,
-	HDMI_AUDIO_I2S_MAX_WORD_20BITS = 0,
-	HDMI_AUDIO_I2S_MAX_WORD_24BITS = 1,
-	HDMI_AUDIO_I2S_CHST_WORD_NOT_SPECIFIED = 0,
-	HDMI_AUDIO_I2S_CHST_WORD_16_BITS = 1,
-	HDMI_AUDIO_I2S_CHST_WORD_17_BITS = 6,
-	HDMI_AUDIO_I2S_CHST_WORD_18_BITS = 2,
-	HDMI_AUDIO_I2S_CHST_WORD_19_BITS = 4,
-	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_20MAX = 5,
-	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_24MAX = 1,
-	HDMI_AUDIO_I2S_CHST_WORD_21_BITS = 6,
-	HDMI_AUDIO_I2S_CHST_WORD_22_BITS = 2,
-	HDMI_AUDIO_I2S_CHST_WORD_23_BITS = 4,
-	HDMI_AUDIO_I2S_CHST_WORD_24_BITS = 5,
 	HDMI_AUDIO_I2S_SCK_EDGE_FALLING = 0,
 	HDMI_AUDIO_I2S_SCK_EDGE_RISING = 1,
 	HDMI_AUDIO_I2S_VBIT_FOR_PCM = 0,
 	HDMI_AUDIO_I2S_VBIT_FOR_COMPRESSED = 1,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_NA = 0,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_16 = 2,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_17 = 12,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_18 = 4,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_19 = 8,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_20 = 10,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_21 = 13,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_22 = 5,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_23 = 9,
-	HDMI_AUDIO_I2S_INPUT_LENGTH_24 = 11,
 	HDMI_AUDIO_I2S_FIRST_BIT_SHIFT = 0,
 	HDMI_AUDIO_I2S_FIRST_BIT_NO_SHIFT = 1,
 	HDMI_AUDIO_I2S_SD0_EN = 1,
@@ -441,20 +378,6 @@ struct hdmi_core_video_config {
 	enum hdmi_core_tclkselclkmult	tclk_sel_clkmult;
 };
 
-/*
- * Refer to section 8.2 in HDMI 1.3 specification for
- * details about infoframe databytes
- */
-struct hdmi_core_infoframe_audio {
-	u8 db1_coding_type;
-	u8 db1_channel_count;
-	u8 db2_sample_freq;
-	u8 db2_sample_size;
-	u8 db4_channel_alloc;
-	bool db5_downmix_inh;
-	u8 db5_lsv;	/* Level shift values for downmix */
-};
-
 struct hdmi_core_packet_enable_repeat {
 	u32	audio_pkt;
 	u32	audio_pkt_repeat;
@@ -507,7 +430,7 @@ struct hdmi_core_audio_i2s_config {
 
 struct hdmi_core_audio_config {
 	struct hdmi_core_audio_i2s_config	i2s_cfg;
-	enum hdmi_core_audio_sample_freq	freq_sample;
+	u32					freq_sample;
 	bool					fs_override;
 	u32					n;
 	u32					cts;
@@ -527,7 +450,7 @@ struct hdmi_core_audio_config {
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
 void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-		struct hdmi_core_infoframe_audio *info_aud);
+		struct snd_cea_861_aud_if *info_aud);
 void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 					struct hdmi_core_audio_config *cfg);
 void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
-- 
1.7.5.4

