From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] staging: drm/omap: move where DMM driver is registered
Date: Thu,  5 Apr 2012 10:34:56 -0500
Message-ID: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33288 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab2DEPlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 11:41:03 -0400
Received: by yenl12 with SMTP id l12so754898yen.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 08:41:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Not sure what triggered the change in behavior, but seems to
result in recursively acquiring a mutex and hanging on boot.  But
omap_drm_init() seems a much more sane place to register the
driver for the DMM sub-device.
---
 drivers/staging/omapdrm/omap_drv.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 3df5b4c..620b8d5 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -803,9 +803,6 @@ static void pdev_shutdown(struct platform_device *device)
 static int pdev_probe(struct platform_device *device)
 {
 	DBG("%s", device->name);
-	if (platform_driver_register(&omap_dmm_driver))
-		dev_err(&device->dev, "DMM registration failed\n");
-
 	return drm_platform_init(&omap_drm_driver, device);
 }
 
@@ -833,6 +830,10 @@ struct platform_driver pdev = {
 static int __init omap_drm_init(void)
 {
 	DBG("init");
+	if (platform_driver_register(&omap_dmm_driver)) {
+		/* we can continue on without DMM.. so not fatal */
+		dev_err(NULL, "DMM registration failed\n");
+	}
 	return platform_driver_register(&pdev);
 }
 
-- 
1.7.9.1

