From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/5] OMAPFB: connect ovl managers to all dssdevs
Date: Fri, 7 Dec 2012 13:55:09 +0200
Message-ID: <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58707 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668Ab2LGLzc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 06:55:32 -0500
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit 5d89bcc341771d95e3a2996218e5949a6627f59e (OMAPDSS: remove initial
display code from omapdss) moved setting up the initial overlay, overlay
manager, output and display connections from omapdss to omapfb.

However, currently omapfb only handles the connection related to the
default display, which means that no overlay managers are connected to
other displays.

This patch changes omapfb to go through all dssdevs, and connect an
overlay manager to them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   38 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1df973e..24739fc 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2353,27 +2353,37 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 }
 
 static int omapfb_init_connections(struct omapfb2_device *fbdev,
-		struct omap_dss_device *dssdev)
+		struct omap_dss_device *def_dssdev)
 {
 	int i, r;
-	struct omap_overlay_manager *mgr = NULL;
+	struct omap_overlay_manager *mgr;
 
-	for (i = 0; i < fbdev->num_managers; i++) {
-		mgr = fbdev->managers[i];
-
-		if (dssdev->channel == mgr->id)
-			break;
+	if (!def_dssdev->output) {
+		dev_err(fbdev->dev, "no output for the default display\n");
+		return -EINVAL;
 	}
 
-	if (i == fbdev->num_managers)
-		return -ENODEV;
+	for (i = 0; i < fbdev->num_displays; ++i) {
+		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
+		struct omap_dss_output *out = dssdev->output;
 
-	if (mgr->output)
-		mgr->unset_output(mgr);
+		mgr = omap_dss_get_overlay_manager(dssdev->channel);
 
-	r = mgr->set_output(mgr, dssdev->output);
-	if (r)
-		return r;
+		if (!mgr || !out)
+			continue;
+
+		if (mgr->output)
+			mgr->unset_output(mgr);
+
+		mgr->set_output(mgr, out);
+	}
+
+	mgr = def_dssdev->output->manager;
+
+	if (!mgr) {
+		dev_err(fbdev->dev, "no ovl manager for the default display\n");
+		return -EINVAL;
+	}
 
 	for (i = 0; i < fbdev->num_overlays; i++) {
 		struct omap_overlay *ovl = fbdev->overlays[i];
-- 
1.7.10.4

