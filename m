From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 07/22] OMAPFB: search for default display with DT alias
Date: Fri, 9 Aug 2013 11:38:52 +0300
Message-ID: <1376037547-10859-8-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48250 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030622Ab3HIIjl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:41 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Improve the search for the default display in two ways:
* compare the given display name to the display's alias
* if no display name is given, look for "display0" DT alias

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 8bfe973..961c5c2 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2413,7 +2413,10 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 	const char *def_name;
 	int i;
 
-	/* search with the display name from the user or the board file */
+	/*
+	 * Search with the display name from the user or the board file,
+	 * comparing to display names and aliases
+	 */
 
 	def_name = omapdss_get_default_display_name();
 
@@ -2425,12 +2428,30 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 
 			if (dssdev->name && strcmp(def_name, dssdev->name) == 0)
 				return dssdev;
+
+			if (strcmp(def_name, dssdev->alias) == 0)
+				return dssdev;
 		}
 
 		/* def_name given but not found */
 		return NULL;
 	}
 
+	/* then look for DT alias display0 */
+	for (i = 0; i < fbdev->num_displays; ++i) {
+		struct omap_dss_device *dssdev;
+		int id;
+
+		dssdev = fbdev->displays[i].dssdev;
+
+		if (dssdev->dev->of_node == NULL)
+			continue;
+
+		id = of_alias_get_id(dssdev->dev->of_node, "display");
+		if (id == 0)
+			return dssdev;
+	}
+
 	/* return the first display we have in the list */
 	return fbdev->displays[0].dssdev;
 }
-- 
1.8.1.2

