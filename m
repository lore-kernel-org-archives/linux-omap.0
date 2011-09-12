From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 6/8] OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
Date: Mon, 12 Sep 2011 12:12:51 +0300
Message-ID: <1315818773-18660-7-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47060 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab1ILJNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:21 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Add dss_get_hdmi_venc_clk_source(), which can be used to get the value
programmed with dss_select_hdmi_venc_clk_source(). This can be used to
find out if the digit output is going to VENC or HDMI.

For OMAP2/3 dss_get_hdmi_venc_clk_source() always returns
DSS_VENC_TV_CLK.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   11 +++++++++++
 drivers/video/omap2/dss/dss.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 356d3c1..3e09726 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -639,6 +639,17 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
+enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
+{
+	enum omap_display_type displays;
+
+	displays = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
+		return DSS_VENC_TV_CLK;
+
+	return REG_GET(DSS_CONTROL, 15, 15);
+}
+
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d790580..48bba53 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -205,6 +205,7 @@ int dss_runtime_get(void);
 void dss_runtime_put(void);
 
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
+enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-- 
1.7.4.1

