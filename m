From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 5/5] OMAPDSS: DSS: add reg-id param to dpi_select_source
Date: Mon, 26 May 2014 14:58:12 +0530
Message-ID: <1401096492-1405-5-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
 <1401096492-1405-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbaEZJ3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 May 2014 05:29:46 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4Q9Tk6C019803
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:46 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4Q9TkY3014949
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:46 -0500
In-Reply-To: <1401096492-1405-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add an argument which describes which DPI instance we are referring to when
selecting it's overlay manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dss.c | 12 ++++++------
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 962c722..bcf8ee2 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -405,7 +405,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	r = dss_dpi_select_source(out->manager->id);
+	r = dss_dpi_select_source(out->port_num, out->manager->id);
 	if (r)
 		goto err_src_sel;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 54a84f4..862e771 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -72,7 +72,7 @@ struct dss_features {
 	const char *parent_clk_name;
 	enum omap_display_type *ports;
 	int num_ports;
-	int (*dpi_select_source)(enum omap_channel channel);
+	int (*dpi_select_source)(int id, enum omap_channel channel);
 };
 
 static struct {
@@ -566,7 +566,7 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
-static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
+static int dss_dpi_select_source_omap2_omap3(int id, enum omap_channel channel)
 {
 	if (channel != OMAP_DSS_CHANNEL_LCD)
 		return -EINVAL;
@@ -574,7 +574,7 @@ static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
 	return 0;
 }
 
-static int dss_dpi_select_source_omap4(enum omap_channel channel)
+static int dss_dpi_select_source_omap4(int id, enum omap_channel channel)
 {
 	int val;
 
@@ -594,7 +594,7 @@ static int dss_dpi_select_source_omap4(enum omap_channel channel)
 	return 0;
 }
 
-static int dss_dpi_select_source_omap5(enum omap_channel channel)
+static int dss_dpi_select_source_omap5(int id, enum omap_channel channel)
 {
 	int val;
 
@@ -620,9 +620,9 @@ static int dss_dpi_select_source_omap5(enum omap_channel channel)
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
index c91f5bd..cf0a151 100644
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

