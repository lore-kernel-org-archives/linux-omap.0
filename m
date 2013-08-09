From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 05/22] OMAPDSS: get dssdev->alias from DT alias
Date: Fri, 9 Aug 2013 11:38:50 +0300
Message-ID: <1376037547-10859-6-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030636Ab3HIIjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:37 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently create a "displayX" style alias name for all displays,
using a number that is incremented for each registered display. With the
new DSS device model there is no clear order in which the displays are
registered, and thus the numbering is somewhat random.

This patch improves the behavior for DT case so that if the displays
have been assigned DT aliases, those aliases will be used as DSS
aliases.

This means that "display0" is always the one specified in the DT alias,
and thus display0 can be used as default display in case the user didn't
specify a default display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 64fb6e5..a8833ca 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -133,9 +134,24 @@ static int disp_num_counter;
 int omapdss_register_display(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_driver *drv = dssdev->driver;
+	int id;
 
-	snprintf(dssdev->alias, sizeof(dssdev->alias),
-			"display%d", disp_num_counter++);
+	/*
+	 * Note: this presumes all the displays are either using DT or non-DT,
+	 * which normally should be the case. This also presumes that all
+	 * displays either have an DT alias, or none has.
+	 */
+
+	if (dssdev->dev->of_node) {
+		id = of_alias_get_id(dssdev->dev->of_node, "display");
+
+		if (id < 0)
+			id = disp_num_counter++;
+	} else {
+		id = disp_num_counter++;
+	}
+
+	snprintf(dssdev->alias, sizeof(dssdev->alias), "display%d", id);
 
 	if (dssdev->name == NULL)
 		dssdev->name = dssdev->alias;
-- 
1.8.1.2

