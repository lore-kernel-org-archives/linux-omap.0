From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v4] OMAPDSS: DISPC: Improvements to DIGIT sync signal selection
Date: Wed, 1 Aug 2012 07:56:40 -0500
Message-ID: <1343825800-6971-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45734 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2HAM6X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 08:58:23 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q71CwNOo001533
	for <linux-omap@vger.kernel.org>; Wed, 1 Aug 2012 07:58:23 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q71CwMah024798
	for <linux-omap@vger.kernel.org>; Wed, 1 Aug 2012 07:58:23 -0500
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
v4: add WARN_ONs to signal invalid selections.
v3: instead of BUG_ON calls, select only if both VENC and HDMI are available.
v2: use BUG_ON() to simplify handling of invalid cases.

 drivers/video/omap2/dss/dss.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..4491ab7 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -648,9 +648,18 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
-void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
 {
-	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+	enum omap_display_type dp;
+	dp = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+
+	/* Complain about invalid selections */
+	WARN_ON((src == DSS_VENC_TV_CLK) && !(dp & OMAP_DISPLAY_TYPE_VENC));
+	WARN_ON((src == DSS_HDMI_M_PCLK) && !(dp & OMAP_DISPLAY_TYPE_HDMI));
+
+	/* Select only if we have options */
+	if ((dp & OMAP_DISPLAY_TYPE_VENC) && (dp & OMAP_DISPLAY_TYPE_HDMI))
+		REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
@@ -661,6 +670,9 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
 		return DSS_VENC_TV_CLK;
 
+	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
+		return DSS_HDMI_M_PCLK;
+
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
-- 
1.7.5.4

