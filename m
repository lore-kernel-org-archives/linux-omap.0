From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 3/4] OMAP: MMC (core): split device registration by OMAP
Date: Wed,  3 Feb 2010 16:51:27 -0800
Message-ID: <1265244688-4055-4-git-send-email-khilman@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f228.google.com ([209.85.217.228]:39112 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab0BDAvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:51:47 -0500
Received: by gxk28 with SMTP id 28so1869537gxk.9
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:51:46 -0800 (PST)
In-Reply-To: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Split OMAP-common MMC device registration into OMAP1 and OMAP2
components.  This is in preparation for the omap_device conversion of
the HSMMC portions.

Original version by Paul: http://marc.info/?l=linux-omap&m=124419789024565&w=2
Updated for current linux-omap by Kevin.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap1/devices.c |   45 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/devices.c |   45 ++++++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/devices.c  |   50 -----------------------------------------
 3 files changed, 88 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index a2d07aa..60f2ed3 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -160,6 +160,49 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
+#define OMAP_MMC_NR_RES		2
+
+/*
+ * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
+ */
+int __init omap1_mmc_add(const char *name, int id, unsigned long base,
+				unsigned long size, unsigned int irq,
+				struct omap_mmc_platform_data *data)
+{
+	struct platform_device *pdev;
+	struct resource res[OMAP_MMC_NR_RES];
+	int ret;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
+	res[0].start = base;
+	res[0].end = base + size - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = res[1].end = irq;
+	res[1].flags = IORESOURCE_IRQ;
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret == 0)
+		ret = platform_device_add_data(pdev, data, sizeof(*data));
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto fail;
+
+	/* return device handle to board setup code */
+	data->dev = &pdev->dev;
+	return 0;
+
+fail:
+	platform_device_put(pdev);
+	return ret;
+}
+
 void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			int nr_controllers)
 {
@@ -190,7 +233,7 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		}
 		size = OMAP1_MMC_SIZE;
 
-		omap_mmc_add("mmci-omap", i, base, size, irq, mmc_data[i]);
+		omap1_mmc_add("mmci-omap", i, base, size, irq, mmc_data[i]);
 	};
 }
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c104d5c..1a9a1bd 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -686,6 +686,49 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
+#define OMAP_MMC_NR_RES		2
+
+/*
+ * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
+ */
+int __init omap2_mmc_add(const char *name, int id, unsigned long base,
+				unsigned long size, unsigned int irq,
+				struct omap_mmc_platform_data *data)
+{
+	struct platform_device *pdev;
+	struct resource res[OMAP_MMC_NR_RES];
+	int ret;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
+	res[0].start = base;
+	res[0].end = base + size - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = res[1].end = irq;
+	res[1].flags = IORESOURCE_IRQ;
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret == 0)
+		ret = platform_device_add_data(pdev, data, sizeof(*data));
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto fail;
+
+	/* return device handle to board setup code */
+	data->dev = &pdev->dev;
+	return 0;
+
+fail:
+	platform_device_put(pdev);
+	return ret;
+}
+
 void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			int nr_controllers)
 {
@@ -746,7 +789,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			size = OMAP3_HSMMC_SIZE;
 			name = "mmci-omap-hs";
 		}
-		omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
+		omap2_mmc_add(name, i, base, size, irq, mmc_data[i]);
 	};
 }
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 59f92c8..9712b5c 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -192,56 +192,6 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
-#define OMAP_MMC_NR_RES		2
-
-/*
- * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
- */
-int __init omap_mmc_add(const char *name, int id, unsigned long base,
-				unsigned long size, unsigned int irq,
-				struct omap_mmc_platform_data *data)
-{
-	struct platform_device *pdev;
-	struct resource res[OMAP_MMC_NR_RES];
-	int ret;
-
-	pdev = platform_device_alloc(name, id);
-	if (!pdev)
-		return -ENOMEM;
-
-	memset(res, 0, OMAP_MMC_NR_RES * sizeof(struct resource));
-	res[0].start = base;
-	res[0].end = base + size - 1;
-	res[0].flags = IORESOURCE_MEM;
-	res[1].start = res[1].end = irq;
-	res[1].flags = IORESOURCE_IRQ;
-
-	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
-	if (ret == 0)
-		ret = platform_device_add_data(pdev, data, sizeof(*data));
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-		goto fail;
-
-	/* return device handle to board setup code */
-	data->dev = &pdev->dev;
-	return 0;
-
-fail:
-	platform_device_put(pdev);
-	return ret;
-}
-
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 #if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
 
 #ifdef CONFIG_ARCH_OMAP2
-- 
1.6.6

