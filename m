From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/26] OMAPDSS: don't use dss bus in suspend/resume
Date: Tue, 26 Mar 2013 15:33:39 +0200
Message-ID: <1364304836-18134-10-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55863 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNeo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:44 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have support functions to suspend and resume all the displays that
are used with system suspend. These functions use the dss bus to iterate
the display devices.

As we aim to remove the custom dss bus totally, this patch removes the
explicit use of dss bus from these functions. Instead the
for_each_dss_dev() macro is used to go through the devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   77 ++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 50792bf..85e1cd3 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -76,74 +76,53 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_timings);
 
-static int dss_suspend_device(struct device *dev, void *data)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		dssdev->activate_after_resume = false;
-		return 0;
-	}
-
-	dssdev->driver->disable(dssdev);
-
-	dssdev->activate_after_resume = true;
-
-	return 0;
-}
-
 int dss_suspend_all_devices(void)
 {
-	int r;
-	struct bus_type *bus = dss_get_bus();
-
-	r = bus_for_each_dev(bus, NULL, NULL, dss_suspend_device);
-	if (r) {
-		/* resume all displays that were suspended */
-		dss_resume_all_devices();
-		return r;
-	}
-
-	return 0;
-}
+	struct omap_dss_device *dssdev = NULL;
 
-static int dss_resume_device(struct device *dev, void *data)
-{
-	int r;
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	for_each_dss_dev(dssdev) {
+		if (!dssdev->driver)
+			continue;
 
-	if (dssdev->activate_after_resume) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			return r;
+		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+			dssdev->driver->disable(dssdev);
+			dssdev->activate_after_resume = true;
+		} else {
+			dssdev->activate_after_resume = false;
+		}
 	}
 
-	dssdev->activate_after_resume = false;
-
 	return 0;
 }
 
 int dss_resume_all_devices(void)
 {
-	struct bus_type *bus = dss_get_bus();
-
-	return bus_for_each_dev(bus, NULL, NULL, dss_resume_device);
-}
+	struct omap_dss_device *dssdev = NULL;
 
-static int dss_disable_device(struct device *dev, void *data)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	for_each_dss_dev(dssdev) {
+		if (!dssdev->driver)
+			continue;
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
-		dssdev->driver->disable(dssdev);
+		if (dssdev->activate_after_resume) {
+			dssdev->driver->enable(dssdev);
+			dssdev->activate_after_resume = false;
+		}
+	}
 
 	return 0;
 }
 
 void dss_disable_all_devices(void)
 {
-	struct bus_type *bus = dss_get_bus();
-	bus_for_each_dev(bus, NULL, NULL, dss_disable_device);
+	struct omap_dss_device *dssdev = NULL;
+
+	for_each_dss_dev(dssdev) {
+		if (!dssdev->driver)
+			continue;
+
+		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+			dssdev->driver->disable(dssdev);
+	}
 }
 
 static LIST_HEAD(panel_list);
-- 
1.7.10.4

