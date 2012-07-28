From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/2] OMAPDSS: DISPC: Improve logic of selection of external sync signal
Date: Fri, 27 Jul 2012 19:21:36 -0500
Message-ID: <1343434897-8444-2-git-send-email-ricardo.neri@ti.com>
References: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47315 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2G1AXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 20:23:40 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6S0Ndbn014479
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:23:39 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6S0Ndr0020712
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:23:39 -0500
In-Reply-To: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The DIGIT channel of the display controller can take the external sync
signal from VENC or HDMI. The code was wrongly assuming that VENC was always
available, which is not necessarily true (e.g., OMAP5). Now, first verify if
the requested external source sync signal is available before getting/setting
the source.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss.c |   19 +++++++++++++++++--
 drivers/video/omap2/dss/dss.h |    2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..e399b4f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -648,9 +648,21 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
-void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+int dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
 {
-	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+	enum omap_display_type displays;
+
+	displays = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+
+	/* discard invalid cases */
+	if (src == DSS_VENC_TV_CLK && !(displays & OMAP_DISPLAY_TYPE_VENC))
+		return -EINVAL;
+
+	if (src == DSS_HDMI_M_PCLK && !(displays & OMAP_DISPLAY_TYPE_HDMI))
+		return -EINVAL;
+
+	REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
+	return 0;
 }
 
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
@@ -661,6 +673,9 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
 		return DSS_VENC_TV_CLK;
 
+	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
+		return DSS_HDMI_M_PCLK;
+
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f67afe7..7ae763c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -270,7 +270,7 @@ bool dss_ovl_use_replication(struct dss_lcd_mgr_config config,
 int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
-void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
+int dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
-- 
1.7.5.4

