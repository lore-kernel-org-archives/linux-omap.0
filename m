From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 10/10] OMAP: McBSP: Add pm runtime support
Date: Tue, 21 Dec 2010 13:10:30 +0530
Message-ID: <1292917231-13800-10-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43229 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757856Ab0LUHmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:03 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

Add pm runtime support for McBSP driver.
Reference to fclk is not removed because it is required when the
functional clock is switched from one source to another.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    5 +++--
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 arch/arm/plat-omap/mcbsp.c              |   23 ++++++-----------------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 40d8f93..284c34e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -23,6 +23,7 @@
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 #include <plat/omap_device.h>
+#include <linux/pm_runtime.h>
 
 #include "control.h"
 
@@ -86,7 +87,7 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	clk_disable(mcbsp->fclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (IS_ERR_VALUE(r)) {
@@ -96,7 +97,7 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	clk_enable(mcbsp->fclk);
+	pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index d8275f7..a2bd268 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -477,7 +477,6 @@ struct omap_mcbsp {
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk *iclk;
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP3
 	struct omap_mcbsp_st_data *st_data;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 9a0f76a..ac332ab 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -28,6 +28,7 @@
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 #include <plat/omap_device.h>
+#include <linux/pm_runtime.h>
 
 #include "../mach-omap2/cm-regbits-34xx.h"
 
@@ -764,8 +765,7 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp->iclk);
-	clk_enable(mcbsp->fclk);
+	pm_runtime_get_sync(mcbsp->dev);
 
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_request(mcbsp);
@@ -813,8 +813,7 @@ err_clk_disable:
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_free(mcbsp);
 
-	clk_disable(mcbsp->fclk);
-	clk_disable(mcbsp->iclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	spin_lock(&mcbsp->lock);
 	mcbsp->free = true;
@@ -844,8 +843,7 @@ void omap_mcbsp_free(unsigned int id)
 	/* Do procedure specific to omap34xx arch, if applicable */
 	omap34xx_mcbsp_free(mcbsp);
 
-	clk_disable(mcbsp->fclk);
-	clk_disable(mcbsp->iclk);
+	pm_runtime_put_sync(mcbsp->dev);
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* Free IRQs */
@@ -1858,32 +1856,24 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
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
 
 	/* Initialize mcbsp properties for OMAP34XX if needed / applicable */
 	omap34xx_device_init(mcbsp);
 
 	return 0;
 
-err_fclk:
-	clk_put(mcbsp->iclk);
 err_res:
 	iounmap(mcbsp->io_base);
 err_ioremap:
@@ -1906,7 +1896,6 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 		omap34xx_device_exit(mcbsp);
 
 		clk_put(mcbsp->fclk);
-		clk_put(mcbsp->iclk);
 
 		iounmap(mcbsp->io_base);
 		kfree(mcbsp);
-- 
1.7.0.4

