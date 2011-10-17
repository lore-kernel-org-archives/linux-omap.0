From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}
Date: Mon, 17 Oct 2011 13:41:02 +0200
Message-ID: <1318851662-637-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35172 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab1JQLlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Oct 2011 07:41:42 -0400
Received: by yxp4 with SMTP id 4so3675198yxp.5
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 04:41:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Cousson Benoit <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Expose omap_device_{alloc, delete, register} so we can use them outside
of omap_device.c.

This approach allows users, which need to manipulate an archdata member
of a device before it is registered, to do so. This is also useful
for users who have their devices created very early so they can be used
at ->reserve() time to reserve CMA memory.

The immediate use case for this is to set the private iommu archdata
member, which binds a device to its associated iommu controller.
This way, generic code will be able to attach omap devices to their
iommus, without calling any omap-specific API.

With this in hand, we can further clean the existing mainline OMAP iommu
driver and its mainline users, and focus on generic IOMMU approaches
for future users (rpmsg/remoteproc and the upcoming generic DMA API).

This patch is still considered an interim solution until DT fully materializes
for omap; at that point, this functionality will be removed as DT will
take care of creating the devices and configuring them correctly.

Tested on OMAP4 with a generic rpmsg/remoteproc that doesn't use any
omap-specific IOMMU API anymore.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    7 +++++++
 arch/arm/plat-omap/omap_device.c              |   13 +++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 12c5b0c..28d7a38 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -100,6 +100,13 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
+struct omap_device *omap_device_alloc(struct platform_device *pdev,
+				      struct omap_hwmod **ohs, int oh_cnt,
+				      struct omap_device_pm_latency *pm_lats,
+				      int pm_lats_cnt);
+void omap_device_delete(struct omap_device *od);
+int omap_device_register(struct platform_device *pdev);
+
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index cd90bed..913179c 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -96,14 +96,7 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-static int omap_device_register(struct platform_device *pdev);
 static int omap_early_device_register(struct platform_device *pdev);
-static struct omap_device *omap_device_alloc(struct platform_device *pdev,
-				      struct omap_hwmod **ohs, int oh_cnt,
-				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt);
-static void omap_device_delete(struct omap_device *od);
-
 
 static struct omap_device_pm_latency omap_default_latency[] = {
 	{
@@ -508,7 +501,7 @@ static int omap_device_fill_resources(struct omap_device *od,
  *
  * Returns an struct omap_device pointer or ERR_PTR() on error;
  */
-static struct omap_device *omap_device_alloc(struct platform_device *pdev,
+struct omap_device *omap_device_alloc(struct platform_device *pdev,
 					struct omap_hwmod **ohs, int oh_cnt,
 					struct omap_device_pm_latency *pm_lats,
 					int pm_lats_cnt)
@@ -590,7 +583,7 @@ oda_exit1:
 	return ERR_PTR(ret);
 }
 
-static void omap_device_delete(struct omap_device *od)
+void omap_device_delete(struct omap_device *od)
 {
 	if (!od)
 		return;
@@ -816,7 +809,7 @@ static struct dev_pm_domain omap_device_pm_domain = {
  * platform_device_register() on the underlying platform_device.
  * Returns the return value of platform_device_register().
  */
-static int omap_device_register(struct platform_device *pdev)
+int omap_device_register(struct platform_device *pdev)
 {
 	pr_debug("omap_device: %s: registering\n", pdev->name);
 
-- 
1.7.4.1

