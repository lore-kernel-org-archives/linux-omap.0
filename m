From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/26] OMAPDSS: DPI: new panel registration
Date: Tue, 26 Mar 2013 15:33:42 +0200
Message-ID: <1364304836-18134-13-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45941 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934269Ab3CZNes (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:48 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds new way to register DPI panels. This new method will be
used by the panel drivers that are converted away from the current dss
bus based model.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   35 ++++++++++++++++++++++++++++++++++-
 include/video/omapdss.h       |    2 ++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 08342d1..e7beea2 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -575,7 +575,7 @@ static enum omap_channel dpi_get_channel(void)
 	}
 }
 
-static int __init dpi_init_display(struct omap_dss_device *dssdev)
+static int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev;
 
@@ -615,6 +615,39 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+int omap_dpi_register_panel(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	dssdev->type = OMAP_DISPLAY_TYPE_DPI;
+
+	r = dpi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return r;
+	}
+
+	r = omapdss_output_set_device(&dpi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		return r;
+	}
+
+	dss_add_panel(dssdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dpi_register_panel);
+
+void omap_dpi_free_panel(struct omap_dss_device *dssdev)
+{
+	dss_remove_panel(dssdev);
+
+	omapdss_output_unset_device(&dpi.output);
+}
+EXPORT_SYMBOL(omap_dpi_free_panel);
+
 static struct omap_dss_device * __init dpi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ab36ee3..78c4e51 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -863,6 +863,8 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps);
 
+int omap_dpi_register_panel(struct omap_dss_device *dssdev);
+void omap_dpi_free_panel(struct omap_dss_device *dssdev);
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
 void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
-- 
1.7.10.4

