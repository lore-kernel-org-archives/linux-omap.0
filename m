From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 04/12] usb: musb: Using runtime pm APIs for musb.
Date: Thu, 17 Feb 2011 14:38:41 +0200
Message-ID: <1297946329-9353-5-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50340 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756145Ab1BQMjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:39:09 -0500
In-Reply-To: <1297946329-9353-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks, sysconfig settings.

Enable clock, configure no-idle/standby when active and configure force idle/standby
and disable clock when idled. This is taken care by the runtime framework when
driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
Need to configure MUSB into force standby and force idle mode when usb not used

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.h |    2 +-
 drivers/usb/musb/omap2430.c  |   81 ++++++++++++------------------------------
 2 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 2c8dde6..5216729 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -360,7 +360,7 @@ struct musb_context_registers {
 
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
     defined(CONFIG_ARCH_OMAP4)
-	u32 otg_sysconfig, otg_forcestandby;
+	u32 otg_forcestandby;
 #endif
 	u8 power;
 	u16 intrtxe, intrrxe;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index a3f1233..bb6e6cd 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -33,6 +33,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/err.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -40,7 +42,6 @@
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	struct clk		*clk;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -216,20 +217,12 @@ static inline void omap2430_low_level_exit(struct musb *musb)
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
@@ -309,21 +302,6 @@ static int omap2430_musb_init(struct musb *musb)
 
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
@@ -386,7 +364,7 @@ static int __init omap2430_probe(struct platform_device *pdev)
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
 	struct omap2430_glue		*glue;
-	struct clk			*clk;
+	int				status = 0;
 
 	int				ret = -ENOMEM;
 
@@ -402,26 +380,12 @@ static int __init omap2430_probe(struct platform_device *pdev)
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
 
@@ -431,29 +395,32 @@ static int __init omap2430_probe(struct platform_device *pdev)
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
+	status = pm_runtime_get_sync(&pdev->dev);
+	if (status < 0) {
+		dev_err(&pdev->dev, "pm_runtime_get_sync FAILED");
+		goto err3;
+	}
 
-err4:
-	clk_disable(clk);
+	return 0;
 
 err3:
-	clk_put(clk);
-
+	pm_runtime_disable(&pdev->dev);
 err2:
 	platform_device_put(musb);
 
@@ -470,8 +437,8 @@ static int __exit omap2430_remove(struct platform_device *pdev)
 
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
-	clk_disable(glue->clk);
-	clk_put(glue->clk);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	kfree(glue);
 
 	return 0;
@@ -480,13 +447,11 @@ static int __exit omap2430_remove(struct platform_device *pdev)
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
 
@@ -498,7 +463,10 @@ static int omap2430_suspend(struct device *dev)
 	omap2430_low_level_exit(musb);
 	otg_set_suspend(musb->xceiv, 1);
 	omap2430_save_context(musb);
-	clk_disable(glue->clk);
+
+	if (!pm_runtime_suspended(dev) && dev->bus && dev->bus->pm &&
+			dev->bus->pm->runtime_suspend)
+		dev->bus->pm->runtime_suspend(dev);
 
 	return 0;
 }
@@ -507,13 +475,10 @@ static int omap2430_resume(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
-	int				ret;
 
-	ret = clk_enable(glue->clk);
-	if (ret) {
-		dev_err(dev, "faled to enable clock\n");
-		return ret;
-	}
+	if (!pm_runtime_suspended(dev) && dev->bus && dev->bus->pm &&
+			dev->bus->pm->runtime_resume)
+		dev->bus->pm->runtime_resume(dev);
 
 	omap2430_low_level_init(musb);
 	omap2430_restore_context(musb);
-- 
1.7.4.rc2

