From: Archit Taneja <archit@ti.com>
Subject: [RFC 6/6] omapdss: DSS: add reg-id param to dpi_select_source
Date: Thu, 8 May 2014 14:45:17 +0530
Message-ID: <1399540517-17883-6-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43184 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbaEHJQk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:16:40 -0400
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add an argument which describes which DPI instance we are referring to when
selecting it's overlay manager. This will come into use when a DSS version
supports multiple DPI instances.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dss.c | 12 ++++++------
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index faf266e..def8e68 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -420,7 +420,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	r = dss_dpi_select_source(out->manager->id);
+	r = dss_dpi_select_source(out->reg, out->manager->id);
 	if (r)
 		goto err_src_sel;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 4087f3b..ffa6d84 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -74,7 +74,7 @@ struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *parent_clk_name;
-	int (*dpi_select_source)(enum omap_channel channel);
+	int (*dpi_select_source)(int id, enum omap_channel channel);
 	int (*init_ports)(struct platform_device *pdev);
 	void (*uninit_ports)(struct platform_device *pdev);
 };
@@ -570,7 +570,7 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
-static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
+static int dss_dpi_select_source_omap2_omap3(int id, enum omap_channel channel)
 {
 	if (channel != OMAP_DSS_CHANNEL_LCD)
 		return -EINVAL;
@@ -578,7 +578,7 @@ static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
 	return 0;
 }
 
-static int dss_dpi_select_source_omap4(enum omap_channel channel)
+static int dss_dpi_select_source_omap4(int id, enum omap_channel channel)
 {
 	int val;
 
@@ -598,7 +598,7 @@ static int dss_dpi_select_source_omap4(enum omap_channel channel)
 	return 0;
 }
 
-static int dss_dpi_select_source_omap5(enum omap_channel channel)
+static int dss_dpi_select_source_omap5(int id, enum omap_channel channel)
 {
 	int val;
 
@@ -624,9 +624,9 @@ static int dss_dpi_select_source_omap5(enum omap_channel channel)
 	return 0;
 }
 
-int dss_dpi_select_source(enum omap_channel channel)
+int dss_dpi_select_source(int id, enum omap_channel channel)
 {
-	return dss.feat->dpi_select_source(channel);
+	return dss.feat->dpi_select_source(id, channel);
 }
 
 static int dss_get_clocks(void)
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 6f68f72..f3ddcc9 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -209,7 +209,7 @@ int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
 unsigned long dss_get_dispc_clk_rate(void);
-int dss_dpi_select_source(enum omap_channel channel);
+int dss_dpi_select_source(int id, enum omap_channel channel);
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
-- 
1.8.3.2

