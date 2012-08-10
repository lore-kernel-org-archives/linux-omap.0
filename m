From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/5] OMAPDSS: SDI: Maintain copy of data pairs in driver data
Date: Fri, 10 Aug 2012 16:07:06 +0530
Message-ID: <1344595026-10607-6-git-send-email-archit@ti.com>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2HJKiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 06:38:54 -0400
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The SDI driver currently relies on the omap_dss_device struct to configure the
number of data pairs as specified by the panel. This makes the SDI interface
driver dependent on the omap_dss_device struct.

Make the SDI driver data maintain it's own data lines field. A panel driver
is expected to call omapdss_sdi_set_datapairs() before enabling the interface.
Even though we configure the number of data pairs here, this function would be
finally mapped to a generic interface op called set_data_lines. The datapairs
argument type has been changed from u8 to int at some places to be in sync with
the 'set_data_lines' ops of other interfaces.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |    1 +
 drivers/video/omap2/dss/dss.c                  |    2 +-
 drivers/video/omap2/dss/dss.h                  |    2 +-
 drivers/video/omap2/dss/sdi.c                  |   10 +++++++++-
 include/video/omapdss.h                        |    1 +
 5 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 77fe59f..c835aa7 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -601,6 +601,7 @@ static int acx_panel_power_on(struct omap_dss_device *dssdev)
 	mutex_lock(&md->mutex);
 
 	omapdss_sdi_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_sdi_set_datapairs(dssdev, dssdev->phy.sdi.datapairs);
 
 	r = omapdss_sdi_display_enable(dssdev);
 	if (r) {
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..d692047 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -144,7 +144,7 @@ static void dss_restore_context(void)
 #undef SR
 #undef RR
 
-void dss_sdi_init(u8 datapairs)
+void dss_sdi_init(int datapairs)
 {
 	u32 l;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3fe76c0..e70e702 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -280,7 +280,7 @@ void dss_dump_clocks(struct seq_file *s);
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
-void dss_sdi_init(u8 datapairs);
+void dss_sdi_init(int datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 243e96d..c667ef1 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -35,6 +35,7 @@ static struct {
 
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
+	int datapairs;
 } sdi;
 
 static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
@@ -106,7 +107,8 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	sdi_config_lcd_manager(dssdev);
 
-	dss_sdi_init(dssdev->phy.sdi.datapairs);
+	dss_sdi_init(sdi.datapairs);
+
 	r = dss_sdi_enable();
 	if (r)
 		goto err_sdi_enable;
@@ -164,6 +166,12 @@ void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_sdi_set_timings);
 
+void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
+{
+	sdi.datapairs = datapairs;
+}
+EXPORT_SYMBOL(omapdss_sdi_set_datapairs);
+
 static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 47f29b7..bb77dc2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -766,6 +766,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
 void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
+void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs);
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

