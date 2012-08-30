From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 09/23] OMAPDSS: Create links between managers, outputs and devices
Date: Thu, 30 Aug 2012 17:10:31 +0530
Message-ID: <1346326845-16583-10-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34265 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab2H3Lmz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:55 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Links between DSS entities are made in dss_recheck_connections when a new panel
is probed. Rewrite the code in dss_recheck_connections to link managers to
outputs, and outputs to devices.

The fields in omap_dss_device struct gives information on which output and
manager to connect to. The desired manager and output pointers are retrieved and
prepared(existing outputs/devices unset, if default display)) to form the
desired links. The output is linked to the device, and then the manager to the
output. If a probed device's required manager isn't free, the required output
is still connected to the device so that it's easier to use the panel in the
future.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   96 +++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 952c6fa..07605f1 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -525,51 +525,67 @@ void dss_init_overlays(struct platform_device *pdev)
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 {
 	int i;
-	struct omap_overlay_manager *lcd_mgr;
-	struct omap_overlay_manager *tv_mgr;
-	struct omap_overlay_manager *lcd2_mgr = NULL;
-	struct omap_overlay_manager *lcd3_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
+	struct omap_dss_output *out = NULL;
+	enum omap_dss_output_id id;
+
+	switch (dssdev->type) {
+	case OMAP_DISPLAY_TYPE_DPI:
+		out = omap_dss_get_output(OMAP_DSS_OUTPUT_DPI);
+		break;
+	case OMAP_DISPLAY_TYPE_DBI:
+		out = omap_dss_get_output(OMAP_DSS_OUTPUT_DBI);
+		break;
+	case OMAP_DISPLAY_TYPE_SDI:
+		out = omap_dss_get_output(OMAP_DSS_OUTPUT_SDI);
+		break;
+	case OMAP_DISPLAY_TYPE_VENC:
+		out = omap_dss_get_output(OMAP_DSS_OUTPUT_VENC);
+		break;
+	case OMAP_DISPLAY_TYPE_HDMI:
+		out = omap_dss_get_output(OMAP_DSS_OUTPUT_HDMI);
+		break;
+	case OMAP_DISPLAY_TYPE_DSI:
+		id = dssdev->phy.dsi.module == 0 ? OMAP_DSS_OUTPUT_DSI1 :
+					OMAP_DSS_OUTPUT_DSI2;
+		out = omap_dss_get_output(id);
+		break;
+	default:
+		break;
+	}
 
-	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD);
-	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_DIGIT);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		lcd3_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD3);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD2);
-
-	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD3) {
-		if (!lcd3_mgr->device || force) {
-			if (lcd3_mgr->device)
-				lcd3_mgr->unset_device(lcd3_mgr);
-			lcd3_mgr->set_device(lcd3_mgr, dssdev);
-			mgr = lcd3_mgr;
-		}
-	} else if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
-		if (!lcd2_mgr->device || force) {
-			if (lcd2_mgr->device)
-				lcd2_mgr->unset_device(lcd2_mgr);
-			lcd2_mgr->set_device(lcd2_mgr, dssdev);
-			mgr = lcd2_mgr;
-		}
-	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
-			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
-		if (!lcd_mgr->device || force) {
-			if (lcd_mgr->device)
-				lcd_mgr->unset_device(lcd_mgr);
-			lcd_mgr->set_device(lcd_mgr, dssdev);
-			mgr = lcd_mgr;
-		}
+	/*
+	 * We don't want to touch board files and mention channel for VENC
+	 * devices. Force the channel as DIGIT for HDMI and VENC devices
+	 */
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC ||
+			dssdev->type == OMAP_DISPLAY_TYPE_HDMI)
+		dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
+
+	mgr = omap_dss_get_overlay_manager(dssdev->channel);
+
+	if (!mgr || !out) {
+		DSSERR("Incorrect manager or output\n");
+		return;
 	}
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
-			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
-		if (!tv_mgr->device || force) {
-			if (tv_mgr->device)
-				tv_mgr->unset_device(tv_mgr);
-			tv_mgr->set_device(tv_mgr, dssdev);
-			mgr = tv_mgr;
+	if (!mgr->output || force) {
+		struct omap_dss_output *curr_out = mgr->output;
+
+		if (curr_out) {
+			if (curr_out->device)
+				curr_out->unset_device(curr_out);
+			mgr->unset_output(mgr);
 		}
+		out->set_device(out, dssdev);
+		mgr->set_output(mgr, out);
+	} else {
+		/*
+		 * connect a floating output to the device even if the desired
+		 * manager is in use
+		 */
+		if (!out->manager && !out->device)
+			out->set_device(out, dssdev);
 	}
 
 	if (mgr) {
-- 
1.7.9.5

