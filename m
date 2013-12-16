From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 05/27] OMAPDSS: get dssdev->alias from DT alias
Date: Mon, 16 Dec 2013 16:56:12 +0200
Message-ID: <1387205794-32246-6-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33041 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab3LPO6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:06 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

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
 drivers/video/omap2/dss/display.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 012ada38a29d..21080f9dae87 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -134,9 +134,24 @@ static int disp_num_counter;
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
 
 	/* Use 'label' property for name, if it exists */
 	if (dssdev->dev->of_node)
-- 
1.8.3.2

