From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v2 1/3] ARM: OMAP: omap_device: keep track of driver bound status
Date: Fri, 10 Aug 2012 11:39:11 -0700
Message-ID: <1344623953-26434-2-git-send-email-khilman@ti.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39367 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759915Ab2HJSjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 14:39:19 -0400
Received: by yhmm54 with SMTP id m54so2073723yhm.33
        for <linux-omap@vger.kernel.org>; Fri, 10 Aug 2012 11:39:16 -0700 (PDT)
In-Reply-To: <1344623953-26434-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Use the bus notifier to keep track of driver bound status by adding a
new internal field to struct omap_device: _driver_status.

This will be useful for follow-up patches which need to know whether
or not a driver is bound in order to make intelligent omap_device
enable/idle decisions.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 4327b2c..e7259c0 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -60,6 +60,7 @@ extern struct dev_pm_domain omap_device_pm_domain;
  * @_dev_wakeup_lat_limit: dev wakeup latency limit in nsec - set by OMAP PM
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
+ * @_driver_status: one of BUS_NOTIFY_*_DRIVER from <linux/device.h>
  *
  * Integrates omap_hwmod data into Linux platform_device.
  *
@@ -73,6 +74,7 @@ struct omap_device {
 	struct omap_device_pm_latency	*pm_lats;
 	u32				dev_wakeup_lat;
 	u32				_dev_wakeup_lat_limit;
+	unsigned long			_driver_status;
 	u8				pm_lats_cnt;
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..1d1b5ff 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -385,17 +385,21 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *od;
 
 	switch (event) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		if (pdev->dev.of_node)
-			omap_device_build_from_dt(pdev);
-		break;
-
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (pdev->dev.of_node)
+			omap_device_build_from_dt(pdev);
+		/* fall through */
+	default:
+		od = to_omap_device(pdev);
+		if (od)
+			od->_driver_status = event;
 	}
 
 	return NOTIFY_DONE;
-- 
1.7.9.2

