From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/3] OMAPDSS: HDMI: Implement initialization of MCLK
Date: Wed, 8 Feb 2012 21:10:22 -0600
Message-ID: <1328757023-20543-3-git-send-email-ricardo.neri@ti.com>
References: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757582Ab2BIDLB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 22:11:01 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q193B0u1011182
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q193B0lF020253
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600 (CST)
In-Reply-To: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

When the MCLK is used to drive the Audio Clock Regeneration packets,
the initialization procedure is to set ACR_CTRL[2] to 0 and then
back again to 1. Also, devices that do not support the MCLK, use
the TMDS clock directly by leaving ACR_CTRL[2] set to 0.

The MLCK clock divisor, mclk_mode, is configured only if MLCK
is used. Such configuration is no longer related to the CTS mode
as in some silicon revisions CTS SW-mode is used along with the MCLK.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   37 +++++++++++++++++-----------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 9af81f1..0150e21 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1023,13 +1023,9 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 	u32 r;
 	void __iomem *av_base = hdmi_av_base(ip_data);
 
-	/* audio clock recovery parameters */
-	r = hdmi_read_reg(av_base, HDMI_CORE_AV_ACR_CTRL);
-	r = FLD_MOD(r, cfg->use_mclk, 2, 2);
-	r = FLD_MOD(r, cfg->en_acr_pkt, 1, 1);
-	r = FLD_MOD(r, cfg->cts_mode, 0, 0);
-	hdmi_write_reg(av_base, HDMI_CORE_AV_ACR_CTRL, r);
-
+	/*
+	 * Parameters for generation of Audio Clock Recovery packets
+	 */
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL1, cfg->n, 7, 0);
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL2, cfg->n >> 8, 7, 0);
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_N_SVAL3, cfg->n >> 16, 7, 0);
@@ -1041,14 +1037,6 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 		REG_FLD_MOD(av_base,
 				HDMI_CORE_AV_CTS_SVAL3, cfg->cts >> 16, 7, 0);
 	} else {
-		/*
-		 * HDMI IP uses this configuration to divide the MCLK to
-		 * update CTS value.
-		 */
-		REG_FLD_MOD(av_base,
-				HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
-
-		/* Configure clock for audio packets */
 		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_1,
 				cfg->aud_par_busclk, 7, 0);
 		REG_FLD_MOD(av_base, HDMI_CORE_AV_AUD_PAR_BUSCLK_2,
@@ -1057,6 +1045,25 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 				(cfg->aud_par_busclk >> 16), 7, 0);
 	}
 
+	/* Set ACR clock divisor */
+	REG_FLD_MOD(av_base,
+			HDMI_CORE_AV_FREQ_SVAL, cfg->mclk_mode, 2, 0);
+
+	r = hdmi_read_reg(av_base, HDMI_CORE_AV_ACR_CTRL);
+	/*
+	 * Use TMDS clock for ACR packets. For devices that use
+	 * the MCLK, this is the first part of the MCLK initialization.
+	 */
+	r = FLD_MOD(r, 0, 2, 2);
+
+	r = FLD_MOD(r, cfg->en_acr_pkt, 1, 1);
+	r = FLD_MOD(r, cfg->cts_mode, 0, 0);
+	hdmi_write_reg(av_base, HDMI_CORE_AV_ACR_CTRL, r);
+
+	/* For devices using MCLK, this completes its initialization. */
+	if (cfg->use_mclk)
+		REG_FLD_MOD(av_base, HDMI_CORE_AV_ACR_CTRL, 1, 2, 2);
+
 	/* Override of SPDIF sample frequency with value in I2S_CHST4 */
 	REG_FLD_MOD(av_base, HDMI_CORE_AV_SPDIF_CTRL,
 						cfg->fs_override, 1, 1);
-- 
1.7.0.4

