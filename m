From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/21] drm/omap: stop connector polling during suspend
Date: Thu, 26 Feb 2015 15:20:22 +0200
Message-ID: <1424956829-22892-15-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932344AbbBZNVW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:22 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When not using proper hotplug detection, DRM polls periodically the
connectors to find out if a cable is connected. This polling can happen
at any time, even very late in the suspend process.

This causes a problem with omapdrm, when the poll happens during the
suspend process after GPIOs have been disabled, leading to a crash in
gpio_get().

This patch fixes the issue by adding suspend and resume hooks to
omapdrm, in which we disable and enable, respectively, the polling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 0ebd1315fff8..d0b1aece8cc5 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -694,9 +694,28 @@ static int pdev_remove(struct platform_device *device)
 	return 0;
 }
 
+static int omap_drm_suspend(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	drm_kms_helper_poll_disable(drm_dev);
+
+	return 0;
+}
+
+static int omap_drm_resume(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	drm_kms_helper_poll_enable(drm_dev);
+
+	return omap_gem_resume(dev);
+}
+
 #ifdef CONFIG_PM
 static const struct dev_pm_ops omapdrm_pm_ops = {
-	.resume = omap_gem_resume,
+	.suspend = omap_drm_suspend,
+	.resume = omap_drm_resume,
 };
 #endif
 
-- 
2.3.0

