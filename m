From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 1/2] OMAP3: PM: Add function omap_device_find_pdev to omap_device layer
Date: Mon, 27 Jul 2009 16:58:07 +0530
Message-ID: <1248694087-7177-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZG0L2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jul 2009 07:28:15 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6RBS9gv013415
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 06:28:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

This patch adds a function, omap_device_find_pdev, which will get the
omap_device associated with the platform_device provided. This is currently
required by the SRF layer for setting max_dev_wakeup_lat and getting
dev_context_loss_count.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/plat-omap/include/mach/omap_device.h |    2 +-
 arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omap_device.h b/arch/arm/plat-omap/include/mach/omap_device.h
index bd0e136..5874af2 100644
--- a/arch/arm/plat-omap/include/mach/omap_device.h
+++ b/arch/arm/plat-omap/include/mach/omap_device.h
@@ -136,6 +136,6 @@ struct omap_device_pm_latency {
 	int (*activate_func)(struct omap_device *od);
 };
 
-
+struct omap_device *omap_device_find_pdev(struct platform_device *pdev);
 #endif
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 2c409fc..b947faf 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -685,3 +685,25 @@ int omap_device_enable_clocks(struct omap_device *od)
 	/* XXX pass along return value here? */
 	return 0;
 }
+
+/**
+ * omap_device_find_pdev - look up an OMAP module by platform_device
+ * @pdev: platform_device to find
+ *
+ * Finds a registered OMAP module by the platform_device associated
+ * with it in the omap_device structure. Returns a pointer to the
+ * struct omap_device if found, or NULL otherwise.
+ */
+
+struct omap_device *omap_device_find_pdev(struct platform_device *pdev)
+{
+	struct omap_device *od;
+
+	if (!pdev)
+		return NULL;
+
+	od = _find_by_pdev(pdev);
+
+	return od;
+}
+
-- 
1.6.2.4

