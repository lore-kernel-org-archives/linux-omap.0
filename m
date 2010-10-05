From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 7/7] [RFC] OMAP: pm_runtime support for MCBSP
Date: Tue,  5 Oct 2010 22:07:42 +0530
Message-ID: <1286296662-7639-7-git-send-email-kishon@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab0JEQkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 12:40:07 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o95Ge4wi030674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 11:40:06 -0500
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nskamat@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Partha Basak <p-basak2@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    7 ++++---
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 arch/arm/plat-omap/mcbsp.c              |   27 +++++++--------------------
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 25c6703..e9082ff 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -7,7 +7,7 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
+*
  * Multichannel mode not supported.
  */
 #include <linux/module.h>
@@ -24,6 +24,7 @@
 #include <plat/mcbsp.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <linux/pm_runtime.h>
 
 #include "control.h"
 
@@ -87,7 +88,7 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	clk_disable(mcbsp->fclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (IS_ERR_VALUE(r)) {
@@ -97,7 +98,7 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	clk_enable(mcbsp->fclk);
+	pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1ff283c..b989d0c 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -462,7 +462,6 @@ struct omap_mcbsp {
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk *iclk;
 	struct clk *fclk;
 	struct omap_mcbsp_st_data *st_data;
 	int dma_op_mode;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6b705e1..2a1dce1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -29,6 +29,7 @@
 #include <plat/mcbsp.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <linux/pm_runtime.h>
 
 #include "../mach-omap2/cm-regbits-34xx.h"
 
@@ -777,8 +778,7 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp->iclk);
-	clk_enable(mcbsp->fclk);
+	pm_runtime_get_sync(mcbsp->dev);
 
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_request(mcbsp);
@@ -826,8 +826,7 @@ err_clk_disable:
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_free(mcbsp);
 
-	clk_disable(mcbsp->fclk);
-	clk_disable(mcbsp->iclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	spin_lock(&mcbsp->lock);
 	mcbsp->free = 1;
@@ -857,8 +856,7 @@ void omap_mcbsp_free(unsigned int id)
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_free(mcbsp);
 
-	clk_disable(mcbsp->fclk);
-	clk_disable(mcbsp->iclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* Free IRQs */
@@ -1737,24 +1735,18 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	}
 	mcbsp->dma_tx_sync = res->start;
 
-	mcbsp->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(mcbsp->iclk)) {
-		ret = PTR_ERR(mcbsp->iclk);
-		dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
-		goto err_res;
-	}
-
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
 		dev_err(&pdev->dev, "unable to get fck: %d\n", ret);
-		goto err_fclk;
+		goto err_res;
 	}
 
 	mcbsp->pdata = pdata;
 	mcbsp->dev = &pdev->dev;
 	mcbsp_ptr[id] = mcbsp;
 	platform_set_drvdata(pdev, mcbsp);
+	pm_runtime_enable(mcbsp->dev);
 
 	omap_additional_add(mcbsp->dev);
 	if (pdata->dma_op_mode != -EINVAL) {
@@ -1800,8 +1792,6 @@ err_io_st:
 	kfree(mcbsp->st_data);
 err_st_data:
 	clk_put(mcbsp->fclk);
-err_fclk:
-	clk_put(mcbsp->iclk);
 err_res:
 	iounmap(mcbsp->io_base);
 err_ioremap:
@@ -1830,15 +1820,12 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 			kfree(mcbsp->st_data);
 		}
 
-		clk_disable(mcbsp->fclk);
-		clk_disable(mcbsp->iclk);
 		clk_put(mcbsp->fclk);
-		clk_put(mcbsp->iclk);
+		pm_runtime_put_sync(mcbsp->dev);
 
 		iounmap(mcbsp->io_base);
 
 		mcbsp->fclk = NULL;
-		mcbsp->iclk = NULL;
 		mcbsp->free = 0;
 		mcbsp->dev = NULL;
 	}
-- 
1.7.0.4

