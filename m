From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2] OMAPDSS: DISPC: Improve DIGIT channel sync signal selection
Date: Mon, 30 Jul 2012 19:11:24 -0500
Message-ID: <1343693484-26133-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2GaAMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 20:12:38 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6V0Cb5E022481
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 19:12:37 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6V0CbqO020232
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 19:12:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

DSS code wrongly assumes that VENC is always available as source for the external
sync signal for the display controller DIGIT channel. One cannot blindly
rely only on the value of DSS_CONTROL[15] as on certain processors (e.g., OMAP5)
reading/writing on that bit may not be valid. If the the sync source is not read
correctly, the callers of dss_get_hdmi_venc_clk_source might make wrong assumptions
about, for instance, video timings.

This patch adds logic to correctly get the sync signal based on the
available displays in the DIGIT channel. A kernel BUG is thrown if an
invalid source is selected.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
v2: use BUG_ON() to simplify handling of invalid cases.
 drivers/video/omap2/dss/dss.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..2f8e4b6 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -648,9 +648,15 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
-void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
 {
-	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+	enum omap_display_type dp;
+	dp = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+
+	BUG_ON((src == DSS_VENC_TV_CLK) && !(dp & OMAP_DISPLAY_TYPE_VENC));
+	BUG_ON((src == DSS_HDMI_M_PCLK) && !(dp & OMAP_DISPLAY_TYPE_HDMI));
+
+	REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
@@ -661,6 +667,9 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
 		return DSS_VENC_TV_CLK;
 
+	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
+		return DSS_HDMI_M_PCLK;
+
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
-- 
1.7.5.4

