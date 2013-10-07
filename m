From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 2/2] drm: omap: disconnect devices when omapdrm module is removed
Date: Mon, 7 Oct 2013 15:08:13 +0530
Message-ID: <1381138693-23404-3-git-send-email-archit@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com>
 <1381138693-23404-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33364 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059Ab3JGJjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 05:39:19 -0400
In-Reply-To: <1381138693-23404-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

omapdrm establishes connections for omap_dss_device devices when probed. It
should also be responsible to disconnect the devices. Keeping the devices
connected can prevent the panel driver modules from unloading, it also causes
issues when we try to remove or re-insert omapdrm module.

Before omapdrm module is removed, we need to make sure that all the connectors
are disabled. Without this, the omap_dss_devices won't disconnect, and cause
issues when we try to re-insert omapdrm.

For now, disable encoders in omap_encoder_destroy. We are not clear if this is
the best place to disable an encoder. This makes successive module insertions
and removal work unlike before. But it leads to warning backtraces when the
module is removed. The func omap_crtc_destroy() gves a warning because
omap_crtc->apply_irq.registered is still set when we try to disable the crtc. I
haven't figured out a way to prevent this, would appreciate some help here.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c     | 15 +++++++++++----
 drivers/gpu/drm/omapdrm/omap_encoder.c |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index be3bfe1..45f7ec6 100644
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
@@ -694,6 +698,9 @@ static int pdev_remove(struct platform_device *device)
 	DBG("");
 	drm_platform_exit(&omap_drm_driver, device);
 
+	omap_disconnect_dssdevs();
+	omap_crtc_pre_uninit();
+
 	platform_driver_unregister(&omap_dmm_driver);
 	return 0;
 }
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 6a12e89..5290a88 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -51,6 +51,9 @@ struct omap_dss_device *omap_encoder_get_dssdev(struct drm_encoder *encoder)
 static void omap_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+
+	omap_encoder_set_enabled(encoder, false);
+
 	drm_encoder_cleanup(encoder);
 	kfree(omap_encoder);
 }
-- 
1.8.1.2

