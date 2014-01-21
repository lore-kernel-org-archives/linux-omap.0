From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 03/41] OMAPDSS: add 'label' support for DT
Date: Tue, 21 Jan 2014 12:56:35 +0200
Message-ID: <1390301833-24944-4-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38698 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbaAUK7M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 05:59:12 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support to get the label (i.e. a "nickname") for a display from the
DT data. If there is no label defined, use the display's alias (e.g.
'display0') as a name.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 669a81fdf58e..012ada38a29d 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -137,6 +138,14 @@ int omapdss_register_display(struct omap_dss_device *dssdev)
 	snprintf(dssdev->alias, sizeof(dssdev->alias),
 			"display%d", disp_num_counter++);
 
+	/* Use 'label' property for name, if it exists */
+	if (dssdev->dev->of_node)
+		of_property_read_string(dssdev->dev->of_node, "label",
+			&dssdev->name);
+
+	if (dssdev->name == NULL)
+		dssdev->name = dssdev->alias;
+
 	if (drv && drv->get_resolution == NULL)
 		drv->get_resolution = omapdss_default_get_resolution;
 	if (drv && drv->get_recommended_bpp == NULL)
-- 
1.8.3.2

