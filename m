From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP: MMC (core): split device registration by OMAP
	variant
Date: Fri, 05 Jun 2009 04:30:42 -0600
Message-ID: <20090605103041.13544.10822.stgit@localhost.localdomain>
References: <20090605102716.13544.65328.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39506 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZFEKbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:31:16 -0400
In-Reply-To: <20090605102716.13544.65328.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Split OMAP-common MMC device registration into OMAP1 and OMAP2
components.  This is in preparation for the omap_device conversion of
the HSMMC portions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/devices.c |   41 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |   46 +++++++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/devices.c  |   50 -----------------------------------------
 3 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index bbbaeb0..8de7e3f 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -104,6 +104,47 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
+#define OMAP_MMC_NR_RES		2
+
+/* Register MMC devices */
+int __init omap_mmc_add(const char *name, int id, unsigned long base,
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
 static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 894cc35..4a64a4c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -515,6 +515,50 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
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
+
 void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			int nr_controllers)
 {
@@ -556,7 +600,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			size = HSMMC_SIZE;
 			name = "mmci-omap-hs";
 		}
-		omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
+		omap2_mmc_add(name, i, base, size, irq, mmc_data[i]);
 	};
 }
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 87fb7ff..8ca25ef 100644
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
 /* Numbering for the SPI-capable controllers when used for SPI:
  * spi		= 1
  * uwire	= 2


