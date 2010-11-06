From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/6] omap: iommu: code reorganization and cleanup
Date: Fri,  5 Nov 2010 19:19:56 -0600
Message-ID: <1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab0KFBa2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:30:28 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Since omap-iommu is now using hwmod, there are structures and
arrays that can be cleaned up to increase the readability of
the code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c        |   95 +++++++++++--------------------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +-
 2 files changed, 34 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 0a76bce..135474b 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -17,53 +17,17 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-struct iommu_device {
-	struct iommu_platform_data pdata;
+static char *omap3_devices[] = {
+	"isp",
+	"iva2",
+	NULL,
 };
-static struct iommu_device *devices;
-static int num_iommu_devices;
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct iommu_device omap3_devices[] = {
-	{
-		.pdata = {
-			.name = "isp",
-		},
-	},
-#if defined(CONFIG_MPU_BRIDGE_IOMMU)
-	{
-		.pdata = {
-			.name = "iva2",
-		},
-	},
-#endif
-};
-#define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
-#else
-#define omap3_devices		NULL
-#define NR_OMAP3_IOMMU_DEVICES	0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct iommu_device omap4_devices[] = {
-	{
-		.pdata = {
-			.name = "ducati",
-		},
-	},
-#if defined(CONFIG_MPU_TESLA_IOMMU)
-	{
-		.pdata = {
-			.name = "tesla",
-		},
-	},
-#endif
+
+static char *omap4_devices[] = {
+	"ducati",
+	"tesla",
+	NULL,
 };
-#define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
-#else
-#define omap4_devices		NULL
-#define NR_OMAP4_IOMMU_DEVICES	0
-#endif
 
 static struct omap_device_pm_latency iommu_latencies[] = {
 	[0] = {
@@ -73,36 +37,28 @@ static struct omap_device_pm_latency iommu_latencies[] = {
 	},
 };
 
-static int __init omap_iommu_init(void)
+static int __init omap_iommu_add(char **devices)
 {
 	int i;
 
-	if (cpu_is_omap34xx()) {
-		devices = omap3_devices;
-		num_iommu_devices = NR_OMAP3_IOMMU_DEVICES;
-	} else if (cpu_is_omap44xx()) {
-		devices = omap4_devices;
-		num_iommu_devices = NR_OMAP4_IOMMU_DEVICES;
-	} else
-		return -ENODEV;
-
-	for (i = 0; i < num_iommu_devices; i++) {
+	for (i = 0; devices[i]; i++) {
 		struct omap_hwmod *oh;
 		struct omap_device *od;
+		struct iommu_platform_data pdata;
 
-		oh = omap_hwmod_lookup(devices[i].pdata.name);
+		oh = omap_hwmod_lookup(devices[i]);
 		if (!oh) {
 			pr_err("%s: hwmod not found\n", __func__);
 			return -ENODEV;
 		}
 
-		devices[i].pdata.mmu_attr =
-				(struct omap_mmu_dev_attr *)oh->dev_attr;
-		devices[i].pdata.device_enable = omap_device_enable;
-		devices[i].pdata.device_disable = omap_device_idle;
+		pdata.name = devices[i];
+		pdata.mmu_attr = (struct omap_mmu_dev_attr *)oh->dev_attr;
+		pdata.device_enable = omap_device_enable;
+		pdata.device_disable = omap_device_idle;
 
 		od = omap_device_build("omap-iommu", i, oh,
-				&devices[i].pdata, sizeof(devices[i].pdata),
+				&pdata, sizeof(pdata),
 				iommu_latencies, ARRAY_SIZE(iommu_latencies),
 				0);
 		if (!od) {
@@ -110,8 +66,23 @@ static int __init omap_iommu_init(void)
 			return -EPERM;
 		}
 	}
+
 	return 0;
 }
+
+static int __init omap_iommu_init(void)
+{
+	int err;
+
+	if (cpu_is_omap34xx())
+		err = omap_iommu_add(omap3_devices);
+	else if (cpu_is_omap44xx())
+		err = omap_iommu_add(omap4_devices);
+	else
+		return -ENODEV;
+
+	return err;
+}
 module_init(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index fd8ffeb..2205c3c 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -109,7 +109,7 @@ struct omap_mmu_dev_attr {
 };
 
 struct iommu_platform_data {
-	const char *name;
+	char *name;
 	struct omap_mmu_dev_attr *mmu_attr;
 
 	int (*device_enable)(struct platform_device *pdev);
-- 
1.7.1

