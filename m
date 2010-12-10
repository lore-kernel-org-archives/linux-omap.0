From: Hema HK <hemahk@ti.com>
Subject: [PATCH 5/5 v4] usb: musb: Using runtime pm APIs for musb.
Date: Fri, 10 Dec 2010 18:23:46 +0530
Message-ID: <1291985626-27174-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57461 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951Ab0LJMxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 07:53:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks, sysconfig settings.

enable clock, configure no-idle/standby when active and configure force idle/standby
and disable clock when idled. This is taken care by the runtime framework when 
driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
Need to configure MUSB into force standby and force idle mode when usb not used

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---

 drivers/usb/musb/musb_core.h |    2 -
 drivers/usb/musb/omap2430.c  |   77 ++++++++++---------------------------------
 2 files changed, 20 insertions(+), 59 deletions(-)

Index: usb/drivers/usb/musb/omap2430.c
===================================================================
--- usb.orig/drivers/usb/musb/omap2430.c
+++ usb/drivers/usb/musb/omap2430.c
@@ -33,6 +33,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -40,7 +41,6 @@
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	struct clk		*clk;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -216,20 +216,12 @@ static inline void omap2430_low_level_ex
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
-
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l |= ENABLEWAKEUP;	/* enable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
 }
 
 static inline void omap2430_low_level_init(struct musb *musb)
 {
 	u32 l;
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
@@ -307,21 +299,6 @@ static int omap2430_musb_init(struct mus
 
 	omap2430_low_level_init(musb);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	l &= ~NOSTDBY;		/* remove possible nostdby */
-	l |= SMARTSTDBY;	/* enable smart standby */
-	l &= ~AUTOIDLE;		/* disable auto idle */
-	l &= ~NOIDLE;		/* remove possible noidle */
-	l |= SMARTIDLE;		/* enable smart idle */
-	/*
-	 * MUSB AUTOIDLE don't work in 3430.
-	 * Workaround by Richard Woodruff/TI
-	 */
-	if (!cpu_is_omap3430())
-		l |= AUTOIDLE;		/* enable auto idle */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -384,7 +361,7 @@ static int __init omap2430_probe(struct 
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
 	struct omap2430_glue		*glue;
-	struct clk			*clk;
+	int				status = 0;
 
 	int				ret = -ENOMEM;
 
@@ -400,26 +377,12 @@ static int __init omap2430_probe(struct 
 		goto err1;
 	}
 
-	clk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
-		ret = PTR_ERR(clk);
-		goto err2;
-	}
-
-	ret = clk_enable(clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err3;
-	}
-
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
 	musb->dev.coherent_dma_mask	= omap2430_dmamask;
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-	glue->clk			= clk;
 
 	pdata->platform_ops		= &omap2430_ops;
 
@@ -429,28 +392,29 @@ static int __init omap2430_probe(struct 
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err4;
+		goto err2;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err4;
+		goto err2;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err4;
+		goto err2;
 	}
 
-	return 0;
+	pm_runtime_enable(&pdev->dev);
+	if (pm_runtime_get_sync(dev)) {
+		dev_err(dev, "pm_runtime_get_sync FAILED");
+		goto err2;
+	}
 
-err4:
-	clk_disable(clk);
+	return 0;
 
-err3:
-	clk_put(clk);
 
 err2:
 	platform_device_put(musb);
@@ -468,8 +432,7 @@ static int __exit omap2430_remove(struct
 
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
-	clk_disable(glue->clk);
-	clk_put(glue->clk);
+	pm_runtime_put_sync(&pdev->dev);
 	kfree(glue);
 
 	return 0;
@@ -478,13 +441,11 @@ static int __exit omap2430_remove(struct
 #ifdef CONFIG_PM
 static void omap2430_save_context(struct musb *musb)
 {
-	musb->context.otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
 	musb->context.otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
 }
 
 static void omap2430_restore_context(struct musb *musb)
 {
-	musb_writel(musb->mregs, OTG_SYSCONFIG, musb->context.otg_sysconfig);
 	musb_writel(musb->mregs, OTG_FORCESTDBY, musb->context.otg_forcestandby);
 }
 
@@ -496,8 +457,11 @@ static int omap2430_suspend(struct devic
 	omap2430_low_level_exit(musb);
 	otg_set_suspend(musb->xceiv, 1);
 	omap2430_save_context(musb);
-	clk_disable(glue->clk);
 
+	if (pm_runtime_put_sync(dev))
+		dev_err(dev, "pm_runtime_put_sync FAILED");
+		return -EINVLD;
+	}
 	return 0;
 }
 
@@ -505,14 +469,11 @@ static int omap2430_resume(struct device
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
-	int				ret;
 
-	ret = clk_enable(glue->clk);
-	if (ret) {
-		dev_err(dev, "faled to enable clock\n");
-		return ret;
+	if (pm_runtime_get_sync(&pdev->dev) {
+		dev_err(dev, "pm_runtime_get_sync FAILED");
+		return -EINVLD;
 	}
-
 	omap2430_low_level_init(musb);
 	omap2430_restore_context(musb);
 	otg_set_suspend(musb->xceiv, 0);
Index: usb/drivers/usb/musb/musb_core.h
===================================================================
--- usb.orig/drivers/usb/musb/musb_core.h
+++ usb/drivers/usb/musb/musb_core.h
@@ -360,7 +360,7 @@ struct musb_context_registers {
 
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
     defined(CONFIG_ARCH_OMAP4)
-	u32 otg_sysconfig, otg_forcestandby;
+	u32 otg_forcestandby;
 #endif
 	u8 power;
 	u16 intrtxe, intrrxe;
