From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 1/2] drm: omap: fix: Defer probe if an omapdss device requests for it at connect
Date: Mon, 7 Oct 2013 15:08:12 +0530
Message-ID: <1381138693-23404-2-git-send-email-archit@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com>
 <1381138693-23404-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab3JGJjO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 05:39:14 -0400
In-Reply-To: <1381138693-23404-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Some omapdss panels are connected to outputs/encoders(HDMI/DSI/DPI) that require
regulators. The output's connect op tries to get a regulator which may not exist
yet because it might get registered later in the kernel boot.

omapdrm currently ignores those panels which return a non zero value when
connected. A better approach would be for omapdrm to request for probe deferral
if a panel's connect op returns -EPROBE_DEFER.

A special case has to be considered when no panels are available to connect when
omapdrm probes. In this case too, we defer probe and expect that a panel will be
available to connect the next time.

The connecting of panels is moved very early in the the drm device's probe
before anything else is initialized. When we enter omap_modeset_init(), we have
a set of panels that have been connected. We now proceed with registering only
those panels which are already connected.

Checking whether the panel has a driver or whether it has get_timing/read_edid
ops in omap_modeset_init() are redundant with the new display model. These can
be removed since a dssdev device will always have a driver associated with it,
and all dssdev drivers have a get_timings op.

This fixes boot with omapdrm on an omap4 panda ES board. The regulators used by
HDMI aren't initialized because I2c isn't initialized, I2C isn't initialized
as it's pins are not configured because pinctrl is yet to probe.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c |  5 +++
 drivers/gpu/drm/omapdrm/omap_drv.c  | 70 +++++++++++++++++++++++++------------
 drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
 3 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 0fd2eb1..9c01311 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -623,6 +623,11 @@ void omap_crtc_pre_init(void)
 	dss_install_mgr_ops(&mgr_ops);
 }
 
+void omap_crtc_pre_uninit(void)
+{
+	dss_uninstall_mgr_ops();
+}
+
 /* initialize crtc */
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct drm_plane *plane, enum omap_channel channel, int id)
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 2603d90..be3bfe1 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -87,6 +87,43 @@ static bool channel_used(struct drm_device *dev, enum omap_channel channel)
 	return false;
 }
 
+static int omap_connect_dssdevs(void)
+{
+	int r;
+	struct omap_dss_device *dssdev = NULL;
+	bool no_displays = true;
+
+	for_each_dss_dev(dssdev) {
+		r = dssdev->driver->connect(dssdev);
+		if (r == -EPROBE_DEFER) {
+			omap_dss_put_device(dssdev);
+			goto cleanup;
+		} else if (r) {
+			dev_warn(dssdev->dev, "could not connect display: %s\n",
+				dssdev->name);
+		} else {
+			no_displays = false;
+		}
+	}
+
+	if (no_displays)
+		return -EPROBE_DEFER;
+
+	return 0;
+
+cleanup:
+	/*
+	 * if we are deferring probe, we disconnect the devices we previously
+	 * connected
+	 */
+	dssdev = NULL;
+
+	for_each_dss_dev(dssdev)
+		dssdev->driver->disconnect(dssdev);
+
+	return r;
+}
+
 static int omap_modeset_init(struct drm_device *dev)
 {
 	struct omap_drm_private *priv = dev->dev_private;
@@ -95,9 +132,6 @@ static int omap_modeset_init(struct drm_device *dev)
 	int num_mgrs = dss_feat_get_num_mgrs();
 	int num_crtcs;
 	int i, id = 0;
-	int r;
-
-	omap_crtc_pre_init();
 
 	drm_mode_config_init(dev);
 
@@ -119,26 +153,8 @@ static int omap_modeset_init(struct drm_device *dev)
 		enum omap_channel channel;
 		struct omap_overlay_manager *mgr;
 
-		if (!dssdev->driver) {
-			dev_warn(dev->dev, "%s has no driver.. skipping it\n",
-					dssdev->name);
-			continue;
-		}
-
-		if (!(dssdev->driver->get_timings ||
-					dssdev->driver->read_edid)) {
-			dev_warn(dev->dev, "%s driver does not support "
-				"get_timings or read_edid.. skipping it!\n",
-				dssdev->name);
-			continue;
-		}
-
-		r = dssdev->driver->connect(dssdev);
-		if (r) {
-			dev_err(dev->dev, "could not connect display: %s\n",
-					dssdev->name);
+		if (!omapdss_device_is_connected(dssdev))
 			continue;
-		}
 
 		encoder = omap_encoder_init(dev, dssdev);
 
@@ -656,9 +672,19 @@ static void pdev_shutdown(struct platform_device *device)
 
 static int pdev_probe(struct platform_device *device)
 {
+	int r;
+
 	if (omapdss_is_initialized() == false)
 		return -EPROBE_DEFER;
 
+	omap_crtc_pre_init();
+
+	r = omap_connect_dssdevs();
+	if (r) {
+		omap_crtc_pre_uninit();
+		return r;
+	}
+
 	DBG("%s", device->name);
 	return drm_platform_init(&omap_drm_driver, device);
 }
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 30b95b7..cb86cb3 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -158,6 +158,7 @@ enum omap_channel omap_crtc_channel(struct drm_crtc *crtc);
 int omap_crtc_apply(struct drm_crtc *crtc,
 		struct omap_drm_apply *apply);
 void omap_crtc_pre_init(void);
+void omap_crtc_pre_uninit(void);
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct drm_plane *plane, enum omap_channel channel, int id);
 
-- 
1.8.1.2

