From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAP: DSS2: Add omap_dss_register_driver_probe()
Date: Fri,  1 Apr 2011 13:00:29 +0300
Message-ID: <1301652030-32223-5-git-send-email-tomi.valkeinen@ti.com>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40157 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755468Ab1DAKAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:50 -0400
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement omap_dss_register_driver_probe() function, which is similar to
platform_driver_probe(). omap_dss_register_driver_probe will add the
driver and probe devices in one go, thus enabling us to use __init for
panel probe functions.

Also, if no devices are found in omap_dss_register_driver_probe(), the
function will return -ENODEV, which causes the panel driver module to be
unloaded.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/core.c            |   44 +++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e239a0d..226a78f 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -517,6 +517,8 @@ struct omap_dss_driver {
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
+int omap_dss_register_driver_probe(struct omap_dss_driver *,
+		int (*probe)(struct omap_dss_device *));
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
 void omap_dss_get_device(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 3584e3e..b3eba14 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -447,6 +447,50 @@ void omap_dss_unregister_driver(struct omap_dss_driver *dssdriver)
 }
 EXPORT_SYMBOL(omap_dss_unregister_driver);
 
+static int omap_dss_driver_probe_fail(struct device *dev)
+{
+	return -ENXIO;
+}
+
+static int find_any_dev(struct device *dev, void *data)
+{
+	struct omap_dss_driver *dssdrv = data;
+	return dev->driver == &dssdrv->driver;
+}
+
+int omap_dss_register_driver_probe(struct omap_dss_driver *dssdriver,
+		int (*probe)(struct omap_dss_device *))
+{
+	int r;
+
+	/* make sure driver won't have bind/unbind attributes */
+	dssdriver->driver.suppress_bind_attrs = true;
+
+	/* temporary section violation during probe() */
+	dssdriver->probe = probe;
+	r = omap_dss_register_driver(dssdriver);
+
+	/* fixup that section violation */
+
+	dssdriver->probe = NULL;
+	dssdriver->driver.probe = omap_dss_driver_probe_fail;
+
+	if (r)
+		return r;
+
+	/* find any device using this driver */
+	r = bus_for_each_dev(&dss_bus_type, NULL, dssdriver, find_any_dev);
+
+	if (r == 0) {
+		/* no devices for this driver */
+		omap_dss_unregister_driver(dssdriver);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dss_register_driver_probe);
+
 /* DEVICE */
 static void reset_device(struct device *dev, int check)
 {
-- 
1.7.1

