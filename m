From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 7/7] omapdss: DSS: add reg-id param to dpi_select_source
Date: Wed, 4 Jun 2014 12:11:03 +0530
Message-ID: <1401864063-19196-8-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36235 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbaFDGmo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:44 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add an argument which describes which DPI instance we are referring to when
selecting it's overlay manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dss.c | 12 ++++++------
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 3e204a8..776c409 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -396,7 +396,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	r = dss_dpi_select_source(out->manager->id);
+	r = dss_dpi_select_source(out->port_num, out->manager->id);
 	if (r)
 		goto err_src_sel;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 3b41953..8fd141f 100644
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
index 849ede1..a7a0d8a 100644
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

