From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 06/22] OMAPFB: clean up default display search
Date: Fri, 9 Aug 2013 11:38:51 +0300
Message-ID: <1376037547-10859-7-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030643Ab3HIIjj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:39 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the code for finding the default display into a function for
clarity and to make it easier to extend it in the future.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 27d6905..8bfe973 100644
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
1.8.1.2

