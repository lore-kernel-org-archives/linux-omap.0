From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] Revert "OMAP: omap_device: add omap_device_is_valid()"
Date: Tue, 31 Aug 2010 17:03:14 -0700
Message-ID: <1283299395-24193-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44753 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0IAADV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 20:03:21 -0400
Received: by gyd8 with SMTP id 8so2780608gyd.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 17:03:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

From: Kevin Hilman <khilman@ti.com>

This reverts commit 0007122ad85cc36b1c18c0b59344093ca210d206.

The dereference method of checking for a valid omap_device when
wrapping a platform_device is rather unsafe and dangerous.

Instead, a better way of checking for a valid omap-device is
to use a common parent device for all omap_devices, then a check
can simply be made using the device parent.  The only user of this
API was the initial version of the runtime PM core for OMAP.  This
has now been switched to check device parent, so there are no more
users of this API.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 --
 arch/arm/plat-omap/omap_device.c              |   20 --------------------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 25cd9ac..bad4c3d 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -62,7 +62,6 @@
  *
  */
 struct omap_device {
-	u32                             magic;
 	struct platform_device		pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
@@ -82,7 +81,6 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
-bool omap_device_is_valid(struct omap_device *od);
 int omap_device_count_resources(struct omap_device *od);
 int omap_device_fill_resources(struct omap_device *od, struct resource *res);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..7f05f49 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -90,12 +90,6 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-/*
- * OMAP_DEVICE_MAGIC: used to determine whether a struct omap_device
- * obtained via container_of() is in fact a struct omap_device
- */
-#define OMAP_DEVICE_MAGIC		 0xf00dcafe
-
 /* Private functions */
 
 /**
@@ -414,8 +408,6 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
-	od->magic = OMAP_DEVICE_MAGIC;
-
 	if (is_early_device)
 		ret = omap_early_device_register(od);
 	else
@@ -627,18 +619,6 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 }
 
 /**
- * omap_device_is_valid - Check if pointer is a valid omap_device
- * @od: struct omap_device *
- *
- * Return whether struct omap_device pointer @od points to a valid
- * omap_device.
- */
-bool omap_device_is_valid(struct omap_device *od)
-{
-	return (od && od->magic == OMAP_DEVICE_MAGIC);
-}
-
-/**
  * omap_device_get_pwrdm - return the powerdomain * associated with @od
  * @od: struct omap_device *
  *
-- 
1.7.2.1

