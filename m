From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP2/3 MMC: initial conversion to omap_device
Date: Fri, 05 Jun 2009 04:30:44 -0600
Message-ID: <20090605103042.13544.7335.stgit@localhost.localdomain>
References: <20090605102716.13544.65328.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39507 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZFEKbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:31:17 -0400
In-Reply-To: <20090605102716.13544.65328.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Convert the HSMMC driver to use omap_device.  A notable aspect of this
is that the use of the dev_attr data from the omap_hwmod allows the
redaction of all of the integration-specific hacks inside this driver.
Regulator control has not yet been converted; the driver still uses the
platform_data set_power hook.

Note that the non-HS MMC driver, used on 2420 and previous, has not yet
been converted.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/devices.c         |  146 ++++++++++++++++-----------------
 arch/arm/mach-omap2/mmc-twl4030.c     |   12 ++-
 arch/arm/plat-omap/include/mach/mmc.h |   11 ++
 drivers/mmc/host/omap_hsmmc.c         |   99 ++++++++++------------
 4 files changed, 133 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4a64a4c..ebfe678 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,9 @@
 #include <mach/gpio.h>
 #include <mach/mmc.h>
 
+#include <mach/omap_device.h>
+#include <mach/omap_hwmod.h>
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -484,6 +488,28 @@ static inline void omap_hsmmc_reset(void) {}
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
+/*
+ * XXX Eventually this latency data should be pushed into the
+ * corresponding data: e.g., clock data, regulator data, etc.  Several
+ * devices may share regulators, which can make these latencies less
+ * useful.
+ *
+ * XXX These latency numbers are wrong.  Replace them with measured latency
+ * data.
+ */
+static struct omap_device_pm_latency omap_hsmmc_latency[] = {
+	[0] = {
+		.deactivate_lat	 = 1,
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_lat	 = 1,
+		.activate_func	 = omap_device_enable_hwmods,
+	},
+	/*
+	 * XXX There should also be an entry here to power off/on the
+	 * MMC regulators/PBIAS cells, etc.
+	 */
+};
+
 static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
@@ -515,94 +541,60 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-#define OMAP_MMC_NR_RES		2
-
-/*
- * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
- */
-int __init omap2_mmc_add(const char *name, int id, unsigned long base,
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
+#define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
 void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-			int nr_controllers)
+			   int nr_controllers)
 {
-	int i;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct omap_device_pm_latency *ohl;
+	char oh_name[MAX_OMAP_MMC_HWMOD_NAME_LEN];
 	char *name;
+	int i, l;
+	int ohl_cnt = 0;
 
-	for (i = 0; i < nr_controllers; i++) {
-		unsigned long base, size;
-		unsigned int irq = 0;
+	if (cpu_is_omap2420()) {
+		name = "mmci-omap";
+	} else {
+		name = "mmci-omap-hs";
+		ohl = omap_hsmmc_latency;
+		ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
+	}
 
-		if (!mmc_data[i])
+	/*
+	 * XXX This isn't a good way to set these up.  What if a board
+	 * uses MMC2 but not MMC1?
+	 */
+	for (i = 1; i <= nr_controllers; i++) {
+		int idx = i - 1;
+
+		l = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
+			     "mmc%d_hwmod", i);
+		WARN(l >= MAX_OMAP_MMC_HWMOD_NAME_LEN,
+		     "String buffer overflow in MMC%d device setup\n", i);
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
 			continue;
+		}
 
-		omap2_mmc_mux(mmc_data[i], i);
+		mmc_data[idx]->dev_attr = oh->dev_attr;
 
-		switch (i) {
-		case 0:
-			base = OMAP2_MMC1_BASE;
-			irq = INT_24XX_MMC_IRQ;
-			break;
-		case 1:
-			base = OMAP2_MMC2_BASE;
-			irq = INT_24XX_MMC2_IRQ;
-			break;
-		case 2:
-			if (!cpu_is_omap34xx())
-				return;
-			base = OMAP3_MMC3_BASE;
-			irq = INT_34XX_MMC3_IRQ;
-			break;
-		default:
-			continue;
-		}
+		omap2_mmc_mux(mmc_data[idx], idx);
+		od = omap_device_build(name, idx, oh, mmc_data[idx],
+				       sizeof(struct omap_mmc_platform_data),
+				       ohl, ohl_cnt);
+		WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		     name, oh_name);
 
-		if (cpu_is_omap2420()) {
-			size = OMAP2420_MMC_SIZE;
-			name = "mmci-omap";
-		} else {
-			size = HSMMC_SIZE;
-			name = "mmci-omap-hs";
-		}
-		omap2_mmc_add(name, i, base, size, irq, mmc_data[i]);
+		/*
+		 * return device handle to board setup code
+		 * XXX Can this be removed?
+		 */
+		mmc_data[idx]->dev = &od->pdev.dev;
 	};
-}
+};
 
 #endif
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 886066b..84093ec 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -2,7 +2,7 @@
  * linux/arch/arm/mach-omap2/mmc-twl4030.c
  *
  * Copyright (C) 2007-2008 Texas Instruments
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  * Author: Texas Instruments
  *
  * This program is free software; you can redistribute it and/or modify
@@ -23,6 +23,7 @@
 #include <mach/control.h>
 #include <mach/mmc.h>
 #include <mach/board.h>
+#include <mach/omap_device.h>
 
 #include "mmc-twl4030.h"
 
@@ -328,6 +329,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 {
 	struct twl4030_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
+	int controller_cnt = 0;
 
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -351,6 +353,8 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			continue;
 		}
 
+		controller_cnt++;
+
 		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
 		if (!mmc) {
 			pr_err("Cannot allocate memory for mmc device!\n");
@@ -369,6 +373,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		mmc->dma_mask = 0xffffffff;
 		mmc->init = twl_mmc_late_init;
 
+		mmc->device_enable = omap_device_enable;
+		mmc->device_shutdown = omap_device_shutdown;
+		mmc->device_idle = omap_device_idle;
+
 		/* note: twl4030 card detect GPIOs can disable VMMCx ... */
 		if (gpio_is_valid(c->gpio_cd)) {
 			mmc->cleanup = twl_mmc_cleanup;
@@ -425,7 +433,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		hsmmc_data[c->mmc - 1] = mmc;
 	}
 
-	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
+	omap2_init_mmc(hsmmc_data, controller_cnt);
 
 	/* pass the device nodes back to board setup code */
 	for (c = controllers; c->mmc; c++) {
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 4996a54..99fe3e1 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -14,9 +14,12 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <mach/board.h>
 
+#include <mach/omap_hwmod.h>
+
 #define OMAP15XX_NR_MMC		1
 #define OMAP16XX_NR_MMC		2
 #define OMAP1_MMC_SIZE		0x080
@@ -69,6 +72,14 @@ struct omap_mmc_platform_data {
 
 	u64 dma_mask;
 
+	/* omap_device function pointers */
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_shutdown)(struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
+
+	/* integration attributes from the omap_hwmod layer */
+	struct mmc_dev_attr *dev_attr;
+
 	struct omap_mmc_slot_data {
 
 		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2f19c63..da1a9f3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -529,7 +529,8 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	/* Disable the clocks */
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
-	clk_disable(host->dbclk);
+	if (host->dbclk_enabled)
+		clk_disable(host->dbclk);
 
 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -543,7 +544,8 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 
 	clk_enable(host->fclk);
 	clk_enable(host->iclk);
-	clk_enable(host->dbclk);
+	if (host->dbclk_enabled)
+		clk_enable(host->dbclk);
 
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 		OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
@@ -827,6 +829,7 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct omap_mmc_platform_data *pdata = host->pdata;
 	u16 dsor = 0;
 	unsigned long regval;
 	unsigned long timeout;
@@ -858,7 +861,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (pdata->dev_attr->flags & MMC_INTERNAL_XCVR) {
 		/* Only MMC1 can interface at 3V without some flavor
 		 * of external transceiver; but they all handle 1.8V.
 		 */
@@ -934,10 +937,11 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 
 static void omap_hsmmc_init(struct mmc_omap_host *host)
 {
+	struct omap_mmc_platform_data *pdata = host->pdata;
 	u32 hctl, capa, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (pdata->dev_attr->flags & MMC_INTERNAL_XCVR) {
 		hctl = SDVS30;
 		capa = VS30 | VS18;
 	} else {
@@ -1037,18 +1041,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	if (clk_enable(host->fclk) != 0) {
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
-
-	if (clk_enable(host->iclk) != 0) {
-		clk_disable(host->fclk);
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
+	if (pdata->device_enable)
+		pdata->device_enable(pdev);
 
 	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 	/*
@@ -1082,24 +1076,19 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_init(host);
 
-	/* Select DMA lines */
-	switch (host->id) {
-	case OMAP_MMC1_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC1_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC1_RX;
-		break;
-	case OMAP_MMC2_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC2_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC2_RX;
-		break;
-	case OMAP_MMC3_DEVID:
-		host->dma_line_tx = OMAP34XX_DMA_MMC3_TX;
-		host->dma_line_rx = OMAP34XX_DMA_MMC3_RX;
-		break;
-	default:
-		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
 		goto err_irq;
 	}
+	host->dma_line_tx = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
+		goto err_irq;
+	}
+	host->dma_line_rx = res->end;
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED,
@@ -1161,10 +1150,12 @@ err_irq_cd:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
-	clk_disable(host->fclk);
-	clk_disable(host->iclk);
+	if (pdata->device_shutdown)
+		pdata->device_shutdown(pdev);
+
 	clk_put(host->fclk);
 	clk_put(host->iclk);
+
 	if (host->dbclk_enabled) {
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
@@ -1183,6 +1174,7 @@ err:
 static int omap_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	struct omap_mmc_platform_data *pdata = host->pdata;
 	struct resource *res;
 
 	if (host) {
@@ -1194,10 +1186,12 @@ static int omap_mmc_remove(struct platform_device *pdev)
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_scheduled_work();
 
-		clk_disable(host->fclk);
-		clk_disable(host->iclk);
+		if (pdata->device_shutdown)
+			pdata->device_shutdown(pdev);
+
 		clk_put(host->fclk);
 		clk_put(host->iclk);
+
 		if (host->dbclk_enabled) {
 			clk_disable(host->dbclk);
 			clk_put(host->dbclk);
@@ -1220,6 +1214,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	int ret = 0;
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	struct omap_mmc_platform_data *pdata = host->pdata;
 
 	if (host && host->suspended)
 		return 0;
@@ -1243,9 +1238,12 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
-			clk_disable(host->fclk);
-			clk_disable(host->iclk);
-			clk_disable(host->dbclk);
+
+			if (pdata->device_idle)
+				pdata->device_idle(pdev);
+
+			if (host->dbclk_enabled)
+				clk_disable(host->dbclk);
 		}
 
 	}
@@ -1257,25 +1255,19 @@ static int omap_mmc_resume(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	struct omap_mmc_platform_data *pdata = host->pdata;
 
 	if (host && !host->suspended)
 		return 0;
 
 	if (host) {
 
-		ret = clk_enable(host->fclk);
-		if (ret)
-			goto clk_en_err;
+		if (pdata->device_enable)
+			pdata->device_enable(pdev);
 
-		ret = clk_enable(host->iclk);
-		if (ret) {
-			clk_disable(host->fclk);
-			clk_put(host->fclk);
-			goto clk_en_err;
-		}
-
-		if (clk_enable(host->dbclk) != 0)
-			dev_dbg(mmc_dev(host->mmc),
+		if (host->dbclk_enabled)
+			if (clk_enable(host->dbclk) != 0)
+				dev_dbg(mmc_dev(host->mmc),
 					"Enabling debounce clk failed\n");
 
 		omap_hsmmc_init(host);
@@ -1294,11 +1286,6 @@ static int omap_mmc_resume(struct platform_device *pdev)
 	}
 
 	return ret;
-
-clk_en_err:
-	dev_dbg(mmc_dev(host->mmc),
-		"Failed to enable MMC clocks during resume\n");
-	return ret;
 }
 
 #else


