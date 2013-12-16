From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 06/27] OMAPFB: clean up default display search
Date: Mon, 16 Dec 2013 16:56:13 +0200
Message-ID: <1387205794-32246-7-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42575 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab3LPO6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 09:58:08 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the code for finding the default display into a function for
clarity and to make it easier to extend it in the future.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 27d6905683f3..8bfe973e55ec 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2407,6 +2407,34 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 	return 0;
 }
 
+static struct omap_dss_device *
+omapfb_find_default_display(struct omapfb2_device *fbdev)
+{
+	const char *def_name;
+	int i;
+
+	/* search with the display name from the user or the board file */
+
+	def_name = omapdss_get_default_display_name();
+
+	if (def_name) {
+		for (i = 0; i < fbdev->num_displays; ++i) {
+			struct omap_dss_device *dssdev;
+
+			dssdev = fbdev->displays[i].dssdev;
+
+			if (dssdev->name && strcmp(def_name, dssdev->name) == 0)
+				return dssdev;
+		}
+
+		/* def_name given but not found */
+		return NULL;
+	}
+
+	/* return the first display we have in the list */
+	return fbdev->displays[0].dssdev;
+}
+
 static int omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
@@ -2484,23 +2512,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	for (i = 0; i < fbdev->num_managers; i++)
 		fbdev->managers[i] = omap_dss_get_overlay_manager(i);
 
-	def_display = NULL;
-
-	for (i = 0; i < fbdev->num_displays; ++i) {
-		struct omap_dss_device *dssdev;
-		const char *def_name;
-
-		def_name = omapdss_get_default_display_name();
-
-		dssdev = fbdev->displays[i].dssdev;
-
-		if (def_name == NULL ||
-			(dssdev->name && strcmp(def_name, dssdev->name) == 0)) {
-			def_display = dssdev;
-			break;
-		}
-	}
-
+	def_display = omapfb_find_default_display(fbdev);
 	if (def_display == NULL) {
 		dev_err(fbdev->dev, "failed to find default display\n");
 		r = -EPROBE_DEFER;
-- 
1.8.3.2

