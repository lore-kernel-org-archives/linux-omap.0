From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/2] drm: omap: disconnect devices when omapdrm module is removed
Date: Thu, 19 Sep 2013 14:19:45 +0530
Message-ID: <1379580585-18364-1-git-send-email-archit@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54730 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab3ISIuk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Sep 2013 04:50:40 -0400
In-Reply-To: <1379502502-8781-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

omapdrm established connections for omap_dss_device devices when probed. It
should also be responsible to disconnect the devices. Keeping the devices
connected can prevent the panel driver modules from unloading, it can also
cause problems when omapdrm is re-inserted.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 45fbb1c..44a1203 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -86,6 +86,13 @@ static bool channel_used(struct drm_device *dev, enum omap_channel channel)
 
 	return false;
 }
+static void omap_disconnect_dssdevs(void)
+{
+	struct omap_dss_device *dssdev = NULL;
+
+	for_each_dss_dev(dssdev)
+		dssdev->driver->disconnect(dssdev);
+}
 
 static int omap_connect_dssdevs(void)
 {
@@ -110,10 +117,7 @@ cleanup:
 	 * if we are deferring probe, we disconnect the devices we previously
 	 * connected
 	 */
-	dssdev = NULL;
-
-	for_each_dss_dev(dssdev)
-		dssdev->driver->disconnect(dssdev);
+	omap_disconnect_dssdevs();
 
 	return r;
 }
@@ -688,6 +692,8 @@ static int pdev_remove(struct platform_device *device)
 	DBG("");
 	drm_platform_exit(&omap_drm_driver, device);
 
+	omap_disconnect_dssdevs();
+
 	platform_driver_unregister(&omap_dmm_driver);
 	return 0;
 }
-- 
1.8.1.2

