From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/32] OMAPDSS: use the panel list in omap_dss_get_next_device
Date: Thu, 30 May 2013 12:34:43 +0300
Message-ID: <1369906493-27538-23-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030337Ab3E3Jfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:35:51 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_get_next_device() uses the dss bus to iterate over the
displays. This patch changes omap_dss_get_next_device() to use the new
panel list instead.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 54 ++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 1c175a4..ba83ec3 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -191,27 +191,51 @@ void omap_dss_put_device(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omap_dss_put_device);
 
-/* ref count of the found device is incremented. ref count
- * of from-device is decremented. */
+/*
+ * ref count of the found device is incremented.
+ * ref count of from-device is decremented.
+ */
 struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
 {
-	struct device *dev;
-	struct device *dev_start = NULL;
-	struct omap_dss_device *dssdev = NULL;
+	struct list_head *l;
+	struct omap_dss_device *dssdev;
+
+	mutex_lock(&panel_list_mutex);
 
-	int match(struct device *dev, void *data)
-	{
-		return 1;
+	if (list_empty(&panel_list)) {
+		dssdev = NULL;
+		goto out;
 	}
 
-	if (from)
-		dev_start = &from->dev;
-	dev = bus_find_device(dss_get_bus(), dev_start, NULL, match);
-	if (dev)
-		dssdev = to_dss_device(dev);
-	if (from)
-		put_device(&from->dev);
+	if (from == NULL) {
+		dssdev = list_first_entry(&panel_list, struct omap_dss_device,
+				panel_list);
+		omap_dss_get_device(dssdev);
+		goto out;
+	}
+
+	omap_dss_put_device(from);
+
+	list_for_each(l, &panel_list) {
+		dssdev = list_entry(l, struct omap_dss_device, panel_list);
+		if (dssdev == from) {
+			if (list_is_last(l, &panel_list)) {
+				dssdev = NULL;
+				goto out;
+			}
+
+			dssdev = list_entry(l->next, struct omap_dss_device,
+					panel_list);
+			omap_dss_get_device(dssdev);
+			goto out;
+		}
+	}
 
+	WARN(1, "'from' dssdev not found\n");
+
+	dssdev = NULL;
+out:
+	mutex_unlock(&panel_list_mutex);
 	return dssdev;
 }
 EXPORT_SYMBOL(omap_dss_get_next_device);
-- 
1.8.1.2

