From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 29/32] OMAPDSS: add module_get/put to omap_dss_get/put_device()
Date: Thu, 30 May 2013 12:34:50 +0300
Message-ID: <1369906493-27538-30-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49843 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030375Ab3E3JgA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:00 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_get_device() should be called for omap_dss_device before it is
used to increase its refcount. Currently we only increase the refcount
for the underlying device.

This patch adds managing the ref count to the underlying module also,
which contains the ops for the omap_dss_device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 13 +++++++++++--
 include/video/omapdss.h           |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 8096764..0daf3e3 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -158,15 +158,24 @@ void omapdss_unregister_display(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_unregister_display);
 
-void omap_dss_get_device(struct omap_dss_device *dssdev)
+struct omap_dss_device *omap_dss_get_device(struct omap_dss_device *dssdev)
 {
-	get_device(dssdev->dev);
+	if (!try_module_get(dssdev->owner))
+		return NULL;
+
+	if (get_device(dssdev->dev) == NULL) {
+		module_put(dssdev->owner);
+		return NULL;
+	}
+
+	return dssdev;
 }
 EXPORT_SYMBOL(omap_dss_get_device);
 
 void omap_dss_put_device(struct omap_dss_device *dssdev)
 {
 	put_device(dssdev->dev);
+	module_put(dssdev->owner);
 }
 EXPORT_SYMBOL(omap_dss_put_device);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index c32d90e..b2e6160 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -766,7 +766,7 @@ void omap_dss_unregister_driver(struct omap_dss_driver *);
 int omapdss_register_display(struct omap_dss_device *dssdev);
 void omapdss_unregister_display(struct omap_dss_device *dssdev);
 
-void omap_dss_get_device(struct omap_dss_device *dssdev);
+struct omap_dss_device *omap_dss_get_device(struct omap_dss_device *dssdev);
 void omap_dss_put_device(struct omap_dss_device *dssdev);
 #define for_each_dss_dev(d) while ((d = omap_dss_get_next_device(d)) != NULL)
 struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from);
-- 
1.8.1.2

