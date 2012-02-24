From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/6] ARM: OMAP: omap_device: Add omap_device_unregister()
Date: Fri, 24 Feb 2012 15:28:52 +0530
Message-ID: <1330077537-19618-2-git-send-email-rnayak@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47513 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2BXJ7J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 04:59:09 -0500
In-Reply-To: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>

Add support to unregister an omap_device using
omap_device_unregister api.

While here, also fix the kerneldoc comments for
omap_device_register.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 05f7615..ce0dc86 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -106,6 +106,7 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 				      int pm_lats_cnt);
 void omap_device_delete(struct omap_device *od);
 int omap_device_register(struct platform_device *pdev);
+void omap_device_unregister(struct platform_device *pdev);
 
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 2d00ab0..27aa02d 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -808,8 +808,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
  * @od: struct omap_device * to register
  *
  * Register the omap_device structure.  This currently just calls
- * platform_device_register() on the underlying platform_device.
- * Returns the return value of platform_device_register().
+ * platform_device_add() on the underlying platform_device.
+ * Returns the return value of platform_device_add().
  */
 int omap_device_register(struct platform_device *pdev)
 {
@@ -820,6 +820,22 @@ int omap_device_register(struct platform_device *pdev)
 	return platform_device_add(pdev);
 }
 
+/**
+ * omap_device_unregister - unregister an omap_device with one omap_hwmod
+ * @od: struct omap_device * to unregister
+ *
+ * Unregister the omap_device structure.  This currently just calls
+ * platform_device_del() on the underlying platform_device.
+ * No return value.
+ */
+void omap_device_unregister(struct platform_device *pdev)
+{
+	pr_debug("omap_device: %s: unregistering\n", pdev->name);
+
+	pdev->dev.parent = &omap_device_parent;
+	pdev->dev.pm_domain = &omap_device_pm_domain;
+	platform_device_del(pdev);
+}
 
 /* Public functions for use by device drivers through struct platform_data */
 
-- 
1.7.1

