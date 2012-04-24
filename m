From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: OMAP: Move omap_mmc_add() to mach-omap1
Date: Mon, 23 Apr 2012 17:08:37 -0700
Message-ID: <20120424000837.17783.63424.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40213 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab2DXAIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:38 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Now that omap2420 is using hwmod for MMC, this code is omap1
only used on omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c         |   43 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c          |   48 ---------------------------------
 arch/arm/plat-omap/include/plat/mmc.h |    9 ------
 3 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index b853f61..2192676 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -144,6 +144,49 @@ static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
+#define OMAP_MMC_NR_RES		2
+
+/*
+ * Register MMC devices.
+ */
+static int __init omap_mmc_add(const char *name, int id, unsigned long base,
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
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 1151d0b..1cba927 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -28,54 +28,6 @@
 #include <plat/menelaus.h>
 #include <plat/omap44xx.h>
 
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
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 7a38750..3ed9250 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -176,9 +176,6 @@ extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-int omap_mmc_add(const char *name, int id, unsigned long base,
-				unsigned long size, unsigned int irq,
-				struct omap_mmc_platform_data *data);
 #else
 static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
@@ -187,12 +184,6 @@ static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 {
 }
-static inline int omap_mmc_add(const char *name, int id, unsigned long base,
-				unsigned long size, unsigned int irq,
-				struct omap_mmc_platform_data *data)
-{
-	return 0;
-}
 
 #endif
 #endif

