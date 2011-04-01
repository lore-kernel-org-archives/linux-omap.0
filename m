From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/5] OMAP: DSS2: make omap_dss_(un)register_device static
Date: Fri,  1 Apr 2011 13:00:26 +0300
Message-ID: <1301652030-32223-2-git-send-email-tomi.valkeinen@ti.com>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53912 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755322Ab1DAKAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:46 -0400
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_register_device and omap_dss_unregister_device can only be
called from core.c, so we can make it static.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 ---
 drivers/video/omap2/dss/core.c            |    7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 5e04ddc..e239a0d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -519,9 +519,6 @@ struct omap_dss_driver {
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
-int omap_dss_register_device(struct omap_dss_device *);
-void omap_dss_unregister_device(struct omap_dss_device *);
-
 void omap_dss_get_device(struct omap_dss_device *dssdev);
 void omap_dss_put_device(struct omap_dss_device *dssdev);
 #define for_each_dss_dev(d) while ((d = omap_dss_get_next_device(d)) != NULL)
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 1aa2ed1..9bcb0b8 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -54,6 +54,9 @@ unsigned int dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
+static int omap_dss_register_device(struct omap_dss_device *);
+static void omap_dss_unregister_device(struct omap_dss_device *);
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
@@ -480,7 +483,7 @@ static void omap_dss_dev_release(struct device *dev)
 	reset_device(dev, 0);
 }
 
-int omap_dss_register_device(struct omap_dss_device *dssdev)
+static int omap_dss_register_device(struct omap_dss_device *dssdev)
 {
 	static int dev_num;
 
@@ -494,7 +497,7 @@ int omap_dss_register_device(struct omap_dss_device *dssdev)
 	return device_register(&dssdev->dev);
 }
 
-void omap_dss_unregister_device(struct omap_dss_device *dssdev)
+static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
 }
-- 
1.7.1

