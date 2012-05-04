From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 05/14] OMAPDSS: HDMI: OMAP4: Remove invalid I2S settings
Date: Thu, 3 May 2012 20:43:59 -0500
Message-ID: <1336095848-6923-6-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab2EDBod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 21:44:33 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

According to the most up-to-date documentation from Texas Instruments,
the configuration of High Bitrate Audio is not possible. Also, it is
not possible to set polarity of the I2S Word Select signal. This patch
removes the invalid settings.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    3 ---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    5 -----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index ac73309..985caf9 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1121,11 +1121,8 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 						cfg->freq_sample, 3, 0);
 
 	r = hdmi_read_reg(av_base, HDMI_CORE_AV_I2S_IN_CTRL);
-	r = FLD_MOD(r, cfg->i2s_cfg.en_high_bitrate_aud, 7, 7);
 	r = FLD_MOD(r, cfg->i2s_cfg.sck_edge_mode, 6, 6);
-	r = FLD_MOD(r, cfg->i2s_cfg.cbit_order, 5, 5);
 	r = FLD_MOD(r, cfg->i2s_cfg.vbit, 4, 4);
-	r = FLD_MOD(r, cfg->i2s_cfg.ws_polarity, 3, 3);
 	r = FLD_MOD(r, cfg->i2s_cfg.justification, 2, 2);
 	r = FLD_MOD(r, cfg->i2s_cfg.direction, 1, 1);
 	r = FLD_MOD(r, cfg->i2s_cfg.shift, 0, 0);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 26b91ff..40b724c 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -342,8 +342,6 @@ enum hdmi_audio_blk_strt_end_sig {
 };
 
 enum hdmi_audio_i2s_config {
-	HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_LEFT = 0,
-	HDMI_AUDIO_I2S_WS_POLARIT_YLOW_IS_RIGHT = 1,
 	HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST = 0,
 	HDMI_AUDIO_I2S_LSB_SHIFTED_FIRST = 1,
 	HDMI_AUDIO_I2S_SCK_EDGE_FALLING = 0,
@@ -418,11 +416,8 @@ struct hdmi_core_audio_i2s_config {
 	u8 word_length;
 	u8 in_length_bits;
 	u8 justification;
-	u8 en_high_bitrate_aud;
 	u8 sck_edge_mode;
-	u8 cbit_order;
 	u8 vbit;
-	u8 ws_polarity;
 	u8 direction;
 	u8 shift;
 	u8 active_sds;
-- 
1.7.5.4

