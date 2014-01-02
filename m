From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 2/4] drm/omap: fix: disconnect devices when omapdrm module is removed
Date: Thu, 2 Jan 2014 14:49:52 +0530
Message-ID: <1388654394-5708-3-git-send-email-archit@ti.com>
References: <1388654394-5708-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32889 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaABJUH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jan 2014 04:20:07 -0500
In-Reply-To: <1388654394-5708-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

At omapdrm probe, we install manager ops and connect omapdss devices. This
needs to be undone when omapdrm module is removed so that omapdss is in a
clean state. This ensures that we can re-insert omapdrm module, or some other
module which uses omapdss(like omapfb/omap_vout).

Currently, omapdrm's remove neither uninstalls manager ops, or disconnects
omapdss devices. We make sure that this is done in pdev_remove.

omapdrm establishes connections for omap_dss_device devices when probed. It
should also be responsible to disconnect the devices. Keeping the devices
connected can prevent the panel driver modules from unloading, it also causes
issues when we try to remove or re-insert omapdrm module.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 651f902..fca5667 100644
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
@@ -116,10 +123,7 @@ cleanup:
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
@@ -693,6 +697,9 @@ static int pdev_remove(struct platform_device *device)
 	DBG("");
 	drm_platform_exit(&omap_drm_driver, device);
 
+	omap_disconnect_dssdevs();
+	omap_crtc_pre_uninit();
+
 	platform_driver_unregister(&omap_dmm_driver);
 	return 0;
 }
-- 
1.8.3.2

