From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/26] OMAPDSS: DSI: new panel registration
Date: Tue, 26 Mar 2013 15:33:43 +0200
Message-ID: <1364304836-18134-14-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36248 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNeu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:50 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds new way to register DSI panels. This new method will be
used by the panel drivers that are converted away from the current dss
bus based model.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   55 ++++++++++++++++++++++++++++++++++++++++-
 include/video/omapdss.h       |    3 +++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ddb8bf6..fb77aa8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5225,7 +5225,7 @@ static enum omap_channel dsi_get_channel(int module_id)
 	}
 }
 
-static int __init dsi_init_display(struct omap_dss_device *dssdev)
+static int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev =
 			dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
@@ -5253,6 +5253,59 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+int omap_dsi_register_panel(struct omap_dss_device *dssdev,
+		struct omap_dss_output *out)
+{
+	int r;
+	struct platform_device *dsidev;
+	struct dsi_data *dsi;
+
+	dssdev->type = OMAP_DISPLAY_TYPE_DSI;
+
+	switch (out->id) {
+	case OMAP_DSS_OUTPUT_DSI1:
+		dssdev->phy.dsi.module = 0;
+		break;
+	case OMAP_DSS_OUTPUT_DSI2:
+		dssdev->phy.dsi.module = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dsidev = dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
+	dsi = dsi_get_dsidrv_data(dsidev);
+
+	r = dsi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return r;
+	}
+
+	r = omapdss_output_set_device(&dsi->output, dssdev);
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
+EXPORT_SYMBOL(omap_dsi_register_panel);
+
+void omap_dsi_free_panel(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	dss_remove_panel(dssdev);
+
+	omapdss_output_unset_device(&dsi->output);
+}
+EXPORT_SYMBOL(omap_dsi_free_panel);
+
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 78c4e51..2bf90fd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -862,6 +862,9 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps);
+int omap_dsi_register_panel(struct omap_dss_device *dssdev,
+		struct omap_dss_output *out);
+void omap_dsi_free_panel(struct omap_dss_device *dssdev);
 
 int omap_dpi_register_panel(struct omap_dss_device *dssdev);
 void omap_dpi_free_panel(struct omap_dss_device *dssdev);
-- 
1.7.10.4

