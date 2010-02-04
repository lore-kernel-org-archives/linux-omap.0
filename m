From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 4/4] OMAP2/3 MMC: initial conversion to runtime PM
Date: Wed,  3 Feb 2010 16:51:28 -0800
Message-ID: <1265244688-4055-5-git-send-email-khilman@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:54207 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab0BDAvx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:51:53 -0500
Received: by mail-yx0-f189.google.com with SMTP id 27so1717780yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:51:53 -0800 (PST)
In-Reply-To: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert the HSMMC driver to use the runtime PM layer.  A notable
aspect of this is that the use of the dev_attr data from the
omap_hwmod allows the redaction of all of the integration-specific
hacks inside this driver.  Regulator control has not yet been
converted; the driver still uses the platform_data set_power hook.

In converting to runtime PM layer, the clock frameworks is no longer
used for fclk and iclk.  Instead, the runtime PM get and put functions
are used.  These result in calls into the OMAP runtime PM core which
internally uses the omap_device API to disable/re-enable the device.
(Note that the 2430 debounce clock is not currently handled here,
only the fclk and iclk are managed.)

In addition, the context_loss tracking has been removed from the
driver and is now handled by omap_device + runtime PM core.  The
driver's ->runtime_suspend() hook will be called before device is
disabled, and the driver's ->runtime_resume() hook will be called if
context has been lost.

Based on an initial conversion of this driver to use omap_device by
by Paul Walmsely: http://marc.info/?l=linux-omap&m=124419789124570&w=2
and then converted to use runtime PM API instead of omap_device API.

The omap_hsmmc driver has some hacks in this version to compensate for
the fact that the main runtime PM core prevents runtime transitions
during suspend.  This prevens us from using common hooks for runtime
PM and static PM.  Current workaround is to hack in some extra put/get
calls in the suspend/resume path while this issue is being discussed
on linux-pm.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/devices.c         |  152 +++++++++--------------
 arch/arm/mach-omap2/hsmmc.c           |   12 +-
 arch/arm/plat-omap/include/plat/mmc.h |    5 +
 drivers/mmc/host/omap_hsmmc.c         |  226 +++++++++++++++------------------
 4 files changed, 176 insertions(+), 219 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1a9a1bd..9a81872 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -29,6 +30,9 @@
 
 #include "mux.h"
 
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -588,6 +592,18 @@ static inline void omap_hsmmc_reset(void) {}
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
+static struct omap_device_pm_latency omap_hsmmc_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func	 = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
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
@@ -686,110 +702,58 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
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
-			if (!cpu_is_omap44xx() && !cpu_is_omap34xx())
-				return;
-			base = OMAP3_MMC3_BASE;
-			irq = INT_34XX_MMC3_IRQ;
-			break;
-		case 3:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = INT_44XX_MMC4_IRQ;
-			break;
-		case 4:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = INT_44XX_MMC5_IRQ;
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
-		} else if (cpu_is_omap44xx()) {
-			if (i < 3) {
-				base += OMAP4_MMC_REG_OFFSET;
-				irq += IRQ_GIC_START;
-			}
-			size = OMAP4_HSMMC_SIZE;
-			name = "mmci-omap-hs";
-		} else {
-			size = OMAP3_HSMMC_SIZE;
-			name = "mmci-omap-hs";
-		}
-		omap2_mmc_add(name, i, base, size, irq, mmc_data[i]);
+		/*
+		 * return device handle to board setup code
+		 * XXX Can this be removed?
+		 */
+		mmc_data[idx]->dev = &od->pdev.dev;
 	};
 }
 
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1156b28..32aa69e 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -1,8 +1,8 @@
 /*
- * linux/arch/arm/mach-omap2/hsmmc.c
+ * OMAP HS-MMC platform init
  *
- * Copyright (C) 2007-2008 Texas Instruments
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2007-2008,2010 Texas Instruments
+ * Copyright (C) 2008-2009 Nokia Corporation
  * Author: Texas Instruments
  *
  * This program is free software; you can redistribute it and/or modify
@@ -17,6 +17,7 @@
 #include <plat/control.h>
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
+#include <plat/omap_device.h>
 
 #include "hsmmc.h"
 
@@ -145,6 +146,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	struct omap2_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
+	int controller_cnt = 0;
 
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -167,6 +169,8 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			continue;
 		}
 
+		controller_cnt++;
+
 		mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
 			      GFP_KERNEL);
 		if (!mmc) {
@@ -246,7 +250,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		hsmmc_data[c->mmc - 1] = mmc;
 	}
 
-	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
+	omap2_init_mmc(hsmmc_data, controller_cnt);
 
 	/* pass the device nodes back to board setup code */
 	for (c = controllers; c->mmc; c++) {
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 18b1f49..149c544 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -14,8 +14,10 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <plat/board.h>
+#include <plat/omap_hwmod.h>
 
 #define OMAP15XX_NR_MMC		1
 #define OMAP16XX_NR_MMC		2
@@ -79,6 +81,9 @@ struct omap_mmc_platform_data {
 
 	u64 dma_mask;
 
+	/* integration attributes from the omap_hwmod layer */
+	struct mmc_dev_attr *dev_attr;
+
 	struct omap_mmc_slot_data {
 
 		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a05eae9..49fa146 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -32,6 +32,8 @@
 #include <linux/semaphore.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+
 #include <plat/dma.h>
 #include <mach/hardware.h>
 #include <plat/board.h>
@@ -177,7 +179,6 @@ struct omap_hsmmc_host {
 	int			slot_id;
 	int			got_dbclk;
 	int			response_busy;
-	int			context_loss;
 	int			dpm_state;
 	int			vdd;
 	int			protect_card;
@@ -504,27 +505,23 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 /*
  * Restore the MMC host context, if it was lost as result of a
  * power state change.
+ *
+ * FIXME: this should probably be renamed, as it is more of
+ *        a device re-init than a context restore.   Also,
+ *        not sure why this isn't shared with other init code.
+ *
+ * TODO:  Also, the HW/SW reset and autoidle setting will have already
+ *        been done already by omap_device, so should not be
+ *        necessary.  They should be removed from driver.
+ *
  */
 static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 {
 	struct mmc_ios *ios = &host->mmc->ios;
-	struct omap_mmc_platform_data *pdata = host->pdata;
-	int context_loss = 0;
 	u32 hctl, capa, con;
 	u16 dsor = 0;
 	unsigned long timeout;
 
-	if (pdata->get_context_loss_count) {
-		context_loss = pdata->get_context_loss_count(host->dev);
-		if (context_loss < 0)
-			return 1;
-	}
-
-	dev_dbg(mmc_dev(host->mmc), "context was %slost\n",
-		context_loss == host->context_loss ? "not " : "");
-	if (host->context_loss == context_loss)
-		return 1;
-
 	/* Wait for hardware reset */
 	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
 	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
@@ -623,29 +620,12 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
 	else
 		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
-out:
-	host->context_loss = context_loss;
 
+out:
 	dev_dbg(mmc_dev(host->mmc), "context is restored\n");
 	return 0;
 }
 
-/*
- * Save the MMC host context (store the number of power state changes so far).
- */
-static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
-{
-	struct omap_mmc_platform_data *pdata = host->pdata;
-	int context_loss;
-
-	if (pdata->get_context_loss_count) {
-		context_loss = pdata->get_context_loss_count(host->dev);
-		if (context_loss < 0)
-			return;
-		host->context_loss = context_loss;
-	}
-}
-
 #else
 
 static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
@@ -653,12 +633,12 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	return 0;
 }
 
+#endif
+
 static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
 {
 }
 
-#endif
-
 /*
  * Send init stream sequence to card
  * before sending IDLE command
@@ -1055,8 +1035,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	int ret;
 
 	/* Disable the clocks */
-	clk_disable(host->fclk);
-	clk_disable(host->iclk);
+	pm_runtime_put_sync(host->dev);
 	if (host->got_dbclk)
 		clk_disable(host->dbclk);
 
@@ -1067,8 +1046,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	if (!ret)
 		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
 					       vdd);
-	clk_enable(host->iclk);
-	clk_enable(host->fclk);
+	pm_runtime_get_sync(host->dev);
 	if (host->got_dbclk)
 		clk_enable(host->dbclk);
 
@@ -1442,6 +1420,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	struct omap_mmc_platform_data *pdata = host->pdata;
 	u16 dsor = 0;
 	unsigned long regval;
 	unsigned long timeout;
@@ -1488,7 +1467,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (pdata->dev_attr->flags & MMC_INTERNAL_XCVR) {
 		/* Only MMC1 can interface at 3V without some flavor
 		 * of external transceiver; but they all handle 1.8V.
 		 */
@@ -1572,7 +1551,7 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	u32 hctl, capa, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->dev_attr->flags & MMC_INTERNAL_XCVR) {
 		hctl = SDVS30;
 		capa = VS30 | VS18;
 	} else {
@@ -1615,8 +1594,8 @@ enum {ENABLED = 0, DISABLED, CARDSLEEP, REGSLEEP, OFF};
 /* Handler for [ENABLED -> DISABLED] transition */
 static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
 {
-	omap_hsmmc_context_save(host);
-	clk_disable(host->fclk);
+	pm_runtime_put_sync(host->dev);
+
 	host->dpm_state = DISABLED;
 
 	dev_dbg(mmc_dev(host->mmc), "ENABLED -> DISABLED\n");
@@ -1635,8 +1614,8 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	if (!mmc_try_claim_host(host->mmc))
 		return 0;
 
-	clk_enable(host->fclk);
-	omap_hsmmc_context_restore(host);
+	pm_runtime_get_sync(host->dev);
+
 	if (mmc_card_can_sleep(host->mmc)) {
 		err = mmc_card_sleep(host->mmc);
 		if (err < 0) {
@@ -1652,7 +1631,7 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 		mmc_slot(host).set_sleep(host->dev, host->slot_id, 1, 0,
 					 new_state == CARDSLEEP);
 	/* FIXME: turn off bus power and perhaps interrupts too */
-	clk_disable(host->fclk);
+	pm_runtime_put_sync(host->dev);
 	host->dpm_state = new_state;
 
 	mmc_release_host(host->mmc);
@@ -1706,13 +1685,8 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 /* Handler for [DISABLED -> ENABLED] transition */
 static int omap_hsmmc_disabled_to_enabled(struct omap_hsmmc_host *host)
 {
-	int err;
-
-	err = clk_enable(host->fclk);
-	if (err < 0)
-		return err;
+	pm_runtime_get_sync(host->dev);
 
-	omap_hsmmc_context_restore(host);
 	host->dpm_state = ENABLED;
 
 	dev_dbg(mmc_dev(host->mmc), "DISABLED -> ENABLED\n");
@@ -1726,8 +1700,8 @@ static int omap_hsmmc_sleep_to_enabled(struct omap_hsmmc_host *host)
 	if (!mmc_try_claim_host(host->mmc))
 		return 0;
 
-	clk_enable(host->fclk);
-	omap_hsmmc_context_restore(host);
+	pm_runtime_get_sync(host->dev);
+
 	if (mmc_slot(host).set_sleep)
 		mmc_slot(host).set_sleep(host->dev, host->slot_id, 0,
 			 host->vdd, host->dpm_state == CARDSLEEP);
@@ -1747,9 +1721,8 @@ static int omap_hsmmc_sleep_to_enabled(struct omap_hsmmc_host *host)
 /* Handler for [OFF -> ENABLED] transition */
 static int omap_hsmmc_off_to_enabled(struct omap_hsmmc_host *host)
 {
-	clk_enable(host->fclk);
+	pm_runtime_get_sync(host->dev);
 
-	omap_hsmmc_context_restore(host);
 	omap_hsmmc_conf_bus_power(host);
 	mmc_power_restore_host(host->mmc);
 
@@ -1808,32 +1781,29 @@ static int omap_hsmmc_disable(struct mmc_host *mmc, int lazy)
 	}
 }
 
-static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
+static int omap_hsmmc_enable_simple(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	int err;
 
-	err = clk_enable(host->fclk);
-	if (err)
-		return err;
-	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
-	omap_hsmmc_context_restore(host);
+	pm_runtime_get_sync(host->dev);
+
+	dev_dbg(mmc_dev(host->mmc), "enabled\n");
 	return 0;
 }
 
-static int omap_hsmmc_disable_fclk(struct mmc_host *mmc, int lazy)
+static int omap_hsmmc_disable_simple(struct mmc_host *mmc, int lazy)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	omap_hsmmc_context_save(host);
-	clk_disable(host->fclk);
-	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
+	pm_runtime_put_sync(host->dev);
+
+	dev_dbg(mmc_dev(host->mmc), "idle\n");
 	return 0;
 }
 
 static const struct mmc_host_ops omap_hsmmc_ops = {
-	.enable = omap_hsmmc_enable_fclk,
-	.disable = omap_hsmmc_disable_fclk,
+	.enable = omap_hsmmc_enable_simple,
+	.disable = omap_hsmmc_disable_simple,
 	.request = omap_hsmmc_request,
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
@@ -1857,30 +1827,21 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	int context_loss = 0;
-
-	if (host->pdata->get_context_loss_count)
-		context_loss = host->pdata->get_context_loss_count(host->dev);
 
 	seq_printf(s, "mmc%d:\n"
 			" enabled:\t%d\n"
 			" dpm_state:\t%d\n"
 			" nesting_cnt:\t%d\n"
-			" ctx_loss:\t%d:%d\n"
 			"\nregs:\n",
 			mmc->index, mmc->enabled ? 1 : 0,
-			host->dpm_state, mmc->nesting_cnt,
-			host->context_loss, context_loss);
+			host->dpm_state, mmc->nesting_cnt);
 
 	if (host->suspended || host->dpm_state == OFF) {
 		seq_printf(s, "host suspended, can't read registers\n");
 		return 0;
 	}
 
-	if (clk_enable(host->fclk) != 0) {
-		seq_printf(s, "can't read the regs\n");
-		return 0;
-	}
+	pm_runtime_get_sync(host->dev);
 
 	seq_printf(s, "SYSCONFIG:\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, SYSCONFIG));
@@ -1897,7 +1858,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	seq_printf(s, "CAPA:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CAPA));
 
-	clk_disable(host->fclk);
+	pm_runtime_put_sync(host->dev);
 
 	return 0;
 }
@@ -2023,18 +1984,17 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	/* we start off in DISABLED state */
 	host->dpm_state = DISABLED;
 
-	if (mmc_host_enable(host->mmc) != 0) {
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
+	pm_runtime_enable(host->dev);
+#ifndef CONFIG_PM_RUNTIME
+	/*
+	 * If runtime PM is not enabled, ensure clocks are always enabled.
+	 */
+	clk_enable(host->iclk);
+	clk_enable(host->fclk);
+#endif
 
-	if (clk_enable(host->iclk) != 0) {
-		mmc_host_disable(host->mmc);
-		clk_put(host->iclk);
-		clk_put(host->fclk);
+	if (mmc_host_enable(host->mmc) != 0)
 		goto err1;
-	}
 
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
@@ -2076,32 +2036,19 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
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
-	case OMAP_MMC4_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC4_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC4_RX;
-		break;
-	case OMAP_MMC5_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC5_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC5_RX;
-		break;
-	default:
-		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+		goto err_irq;
+	}
+	host->dma_line_tx = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
 		goto err_irq;
 	}
+	host->dma_line_rx = res->end;
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, IRQF_DISABLED,
@@ -2180,9 +2127,10 @@ err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
 	mmc_host_disable(host->mmc);
-	clk_disable(host->iclk);
+	pm_runtime_suspend(host->dev);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
+
 	if (host->got_dbclk) {
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
@@ -2216,7 +2164,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		flush_scheduled_work();
 
 		mmc_host_disable(host->mmc);
-		clk_disable(host->iclk);
+		pm_runtime_suspend(host->dev);
+
 		clk_put(host->fclk);
 		clk_put(host->iclk);
 		if (host->got_dbclk) {
@@ -2272,7 +2221,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
-			clk_disable(host->iclk);
+
 			if (host->got_dbclk)
 				clk_disable(host->dbclk);
 		} else {
@@ -2287,6 +2236,11 @@ static int omap_hsmmc_suspend(struct device *dev)
 			mmc_host_disable(host->mmc);
 		}
 
+		/*
+		 * HACK: "extra" put to compensate for DPM core keeping
+		 *       runtime PM disabled.  -- khilman
+		 */
+		pm_runtime_put_sync(host->dev);
 	}
 	return ret;
 }
@@ -2302,12 +2256,14 @@ static int omap_hsmmc_resume(struct device *dev)
 		return 0;
 
 	if (host) {
-		ret = clk_enable(host->iclk);
-		if (ret)
-			goto clk_en_err;
+		/*
+		 * HACK: "extra" get to compensate for DPM core keeping
+		 *       runtime PM disabled.  -- khilman
+		 */
+		pm_runtime_get_sync(host->dev);
 
 		if (mmc_host_enable(host->mmc) != 0) {
-			clk_disable(host->iclk);
+			pm_runtime_suspend(host->dev);
 			goto clk_en_err;
 		}
 
@@ -2346,9 +2302,37 @@ clk_en_err:
 #define omap_hsmmc_resume		NULL
 #endif
 
+/* called just before device is disabled */
+static int omap_hsmmc_runtime_suspend(struct device *dev)
+{
+	struct omap_hsmmc_host *host;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	host = platform_get_drvdata(to_platform_device(dev));
+	omap_hsmmc_context_save(host);
+
+	return 0;
+}
+
+/* called after device is (re)enabled, ONLY if context was lost */
+static int omap_hsmmc_runtime_resume(struct device *dev)
+{
+	struct omap_hsmmc_host *host;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	host = platform_get_drvdata(to_platform_device(dev));
+	omap_hsmmc_context_restore(host);
+
+	return 0;
+}
+
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
+	.runtime_suspend = omap_hsmmc_runtime_suspend,
+	.runtime_resume = omap_hsmmc_runtime_resume,
 };
 
 static struct platform_driver omap_hsmmc_driver = {
-- 
1.6.6

