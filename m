From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/19] OMAP: omap_device: add omap_device_is_valid()
Date: Mon, 15 Feb 2010 18:24:37 -0700
Message-ID: <20100216012431.1101.22805.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57395 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab0BPB05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:57 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

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
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
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
index 5195dbb..40289e0 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -90,6 +90,8 @@
 #define IGNORE_WAKEUP_LAT		1
 
 
+#define OMAP_DEVICE_MAGIC 0xf00dcafe
+
 /* Private functions */
 
 /**
@@ -403,6 +405,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
+	od->magic = OMAP_DEVICE_MAGIC;
+
 	ret = omap_device_register(od);
 	if (ret)
 		goto odbs_exit4;
@@ -589,6 +593,18 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 }
 
 /**
+ * omap_device_is_valid - Check if pointer is a valid omap_device
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


