From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 08/14] OMAPDSS: HDMI: OMAP4: Expand configuration for IEC-60958 audio
Date: Thu, 3 May 2012 20:44:02 -0500
Message-ID: <1336095848-6923-9-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37430 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755795Ab2EDBob (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:31 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Utilize a snd_aes_iec958 struct to write the parameters of the IEC-60958
channel status word into the HDMI IP registers. Hence, the user of the
driver has full control of what parameters are written in the word.

Also, some of the parameters of the I2S structure have been removed
as they are actually IEC-60958 parameters.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   29 +++++++++++++++++++----------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    4 +---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index cbda730..9c3dfd4 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1114,10 +1114,25 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_SPDIF_CTRL,
 						cfg->fs_override, 1, 1);
 
-	/* I2S parameters */
-	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_CHST4,
-						cfg->freq_sample, 3, 0);
-
+	/*
+	 * Set IEC-60958-3 channel status word. It is passed to the IP
+	 * just as it is received. The user of the driver is responsible
+	 * for its contents.
+	 */
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST0,
+		       cfg->iec60958_cfg->status[0]);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST1,
+		       cfg->iec60958_cfg->status[1]);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST2,
+		       cfg->iec60958_cfg->status[2]);
+	/* yes, this is correct: status[3] goes to CHST4 register */
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST4,
+		       cfg->iec60958_cfg->status[3]);
+	/* yes, this is correct: status[4] goes to CHST5 register */
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST5,
+		       cfg->iec60958_cfg->status[4]);
+
+	/* set I2S parameters */
 	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL);
 	r = FLD_MOD(r, cfg->i2s_cfg.sck_edge_mode, 6, 6);
 	r = FLD_MOD(r, cfg->i2s_cfg.vbit, 4, 4);
@@ -1126,12 +1141,6 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 	r = FLD_MOD(r, cfg->i2s_cfg.shift, 0, 0);
 	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL, r);
 
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_CHST5);
-	r = FLD_MOD(r, cfg->freq_sample, 7, 4);
-	r = FLD_MOD(r, cfg->i2s_cfg.word_length, 3, 1);
-	r = FLD_MOD(r, cfg->i2s_cfg.word_max_length, 0, 0);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_CHST5, r);
-
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_I2S_IN_LEN,
 			cfg->i2s_cfg.in_length_bits, 3, 0);
 
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 5d6e37a..4fd4f35 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -412,8 +412,6 @@ struct hdmi_audio_dma {
 };
 
 struct hdmi_core_audio_i2s_config {
-	u8 word_max_length;
-	u8 word_length;
 	u8 in_length_bits;
 	u8 justification;
 	u8 sck_edge_mode;
@@ -425,7 +423,7 @@ struct hdmi_core_audio_i2s_config {
 
 struct hdmi_core_audio_config {
 	struct hdmi_core_audio_i2s_config	i2s_cfg;
-	u32					freq_sample;
+	struct snd_aes_iec958			*iec60958_cfg;
 	bool					fs_override;
 	u32					n;
 	u32					cts;
-- 
1.7.5.4

