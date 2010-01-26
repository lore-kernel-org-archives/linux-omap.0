From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP: omap_device: add omap_device_is_valid()
Date: Tue, 26 Jan 2010 11:00:43 -0800
Message-ID: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:64915 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0AZTA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:00:57 -0500
Received: by fxm20 with SMTP id 20so714393fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 11:00:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The omap_device struct contains a 'struct platform_device'.  Normally,
converting a platform_device pointer to an omap_device pointer
consists of simply doing a container_of(), as is done currently by the
to_omap_device() macro.

However, if this is attempted when using platform_device that has not
been created as part of the omap_device creation, the container_of()
will point to a memory location before the platform_device pointer
which will contain random data.

Therefore, we need a way to detect valid omap_device pointers.  This
patch solves this by using the simple magic number approach.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Changes from original version:
- set magic value before omap_device_register()

 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 76d4917..4677ff7 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -62,6 +62,7 @@
  *
  */
 struct omap_device {
+	u32                             magic;
 	struct platform_device		pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
@@ -81,6 +82,7 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
+bool omap_device_is_valid(struct omap_device *od);
 int omap_device_count_resources(struct omap_device *od);
 int omap_device_fill_resources(struct omap_device *od, struct resource *res);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d8c75c8..187a08f 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -100,6 +100,8 @@
 # error Unknown OMAP device
 #endif
 
+#define OMAP_DEVICE_MAGIC 0xf00dcafe
+
 /* Private functions */
 
 /**
@@ -413,6 +415,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
+	od->magic = OMAP_DEVICE_MAGIC;
+
 	ret = omap_device_register(od);
 	if (ret)
 		goto odbs_exit4;
@@ -599,6 +603,18 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 }
 
 /**
+ * omap_device_is_valid()
+ * @od: struct omap_device *
+ *
+ * Return whether struct omap_device pointer @od points to a valid
+ * omap_device.
+ */
+bool omap_device_is_valid(struct omap_device *od)
+{
+	return (od && od->magic == OMAP_DEVICE_MAGIC);
+}
+
+/**
  * omap_device_get_pwrdm - return the powerdomain * associated with @od
  * @od: struct omap_device *
  *
-- 
1.6.6

