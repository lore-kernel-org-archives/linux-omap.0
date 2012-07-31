From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 RESEND] OMAPDSS: DISPC: Improvements to DIGIT sync signal selection
Date: Tue, 31 Jul 2012 18:56:59 -0500
Message-ID: <1343779019-10611-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab2GaX6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 19:58:15 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6VNwFQ1019445
	for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 18:58:15 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6VNwEbn011560
	for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 18:58:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

DSS code wrongly assumes that VENC is always available as source for the external
sync signal for the display controller DIGIT channel. One cannot blindly write/read
the value of DSS_CONTROL[15] as in certain processors (e.g., OMAP5) this operation
may not be valid. If the the sync source is not read correctly, the callers of
dss_get_hdmi_venc_clk_source might make wrong assumptions about, for instance,
video timings.

Logic is added to correctly get the sync signal based on the available displays
in the DIGIT channel. The source is set only if both VENC and HDMI are supported.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
v3: instead of BUG_ON calls, select only if both VENC and HDMI are available.
v2: use BUG_ON() to simplify handling of invalid cases.

 drivers/video/omap2/dss/dss.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..29e677e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -648,9 +648,14 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
-void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
 {
-	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+	enum omap_display_type dp;
+	dp = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+
+	/* Select only if we have options */
+	if ((dp & OMAP_DISPLAY_TYPE_VENC) && (dp & OMAP_DISPLAY_TYPE_HDMI))
+		REG_FLD_MOD(DSS_CONTROL, src, 15, 15);
 }
 
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
@@ -661,6 +666,9 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
 		return DSS_VENC_TV_CLK;
 
+	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
+		return DSS_HDMI_M_PCLK;
+
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
-- 
1.7.5.4

