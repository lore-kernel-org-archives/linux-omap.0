From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 06/41] OMAPFB: search for default display with DT alias
Date: Tue, 21 Jan 2014 12:56:38 +0200
Message-ID: <1390301833-24944-7-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbaAUK71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 05:59:27 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Improve the search for the default display in two ways:
* compare the given display name to the display's alias
* if no display name is given, look for "display0" DT alias

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index b7469636f15c..f121e87b30be 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2423,7 +2423,10 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 	const char *def_name;
 	int i;
 
-	/* search with the display name from the user or the board file */
+	/*
+	 * Search with the display name from the user or the board file,
+	 * comparing to display names and aliases
+	 */
 
 	def_name = omapdss_get_default_display_name();
 
@@ -2435,12 +2438,30 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 
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
1.8.3.2

