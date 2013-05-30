From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/27] OMAPDSS: modify get/find functions to go through the device chain
Date: Thu, 30 May 2013 12:35:55 +0300
Message-ID: <1369906580-27585-3-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42822 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030397Ab3E3Jgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:36:51 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

In the future will have arbitrarily long video pipeline chains, instead
of the current two-entities-per-pipeline model.

This patch changes the affected get/find style functions so that they
properly go through the video pipeline chain, for example when getting
the overlay manager connected to a given display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c  | 14 +++++++++++++-
 drivers/video/omap2/dss/output.c |  8 +++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 752b985..d6212d63 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -422,7 +422,19 @@ static void wait_pending_extra_info_updates(void)
 
 static struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
 {
-	return mgr->output ? mgr->output->device : NULL;
+	struct omap_dss_device *dssdev;
+
+	dssdev = mgr->output;
+	if (dssdev == NULL)
+		return NULL;
+
+	while (dssdev->device)
+		dssdev = dssdev->device;
+
+	if (dssdev->driver)
+		return dssdev;
+	else
+		return NULL;
 }
 
 static struct omap_dss_device *dss_ovl_get_device(struct omap_overlay *ovl)
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 0ba168e..3f5c0a7 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -146,7 +146,13 @@ EXPORT_SYMBOL(omap_dss_find_output_by_node);
 
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
-	return omap_dss_get_device(dssdev->output);
+	while (dssdev->output)
+		dssdev = dssdev->output;
+
+	if (dssdev->id != 0)
+		return omap_dss_get_device(dssdev);
+
+	return NULL;
 }
 EXPORT_SYMBOL(omapdss_find_output_from_display);
 
-- 
1.8.1.2

