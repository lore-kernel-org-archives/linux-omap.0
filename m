From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/5] arm: omap: counter-32k: convert to pm_runtime API
Date: Tue, 19 Oct 2010 12:22:13 +0300
Message-ID: <1287480136-2046-3-git-send-email-balbi@ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39043 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758119Ab0JSJWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:22:36 -0400
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Trivial patch removing clock framework and adding
pm_runtime API.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/counter-32k.c |   48 ++++++++++---------------------------
 1 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/counter-32k.c b/arch/arm/plat-omap/counter-32k.c
index f3fcb38..7bfd67a 100644
--- a/arch/arm/plat-omap/counter-32k.c
+++ b/arch/arm/plat-omap/counter-32k.c
@@ -27,7 +27,7 @@
 #include <linux/time.h>
 #include <linux/clocksource.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 
 struct omap_counter_32k_device {
@@ -37,7 +37,6 @@ struct omap_counter_32k_device {
 	cycles_t		last_cycles;
 
 	struct device		*dev;
-	struct clk		*ick;
 	void __iomem		*base;
 
 	/*
@@ -117,7 +116,6 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
 {
 	struct omap_counter_32k_device		*omap;
 	struct resource			*res;
-	struct clk			*ick;
 
 	int				ret;
 
@@ -130,11 +128,18 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret) {
+		dev_dbg(&pdev->dev, "unable to enable runtime pm\n");
+		goto err1;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_dbg(&pdev->dev, "couldn't get resource\n");
 		ret = -ENODEV;
-		goto err1;
+		goto err2;
 	}
 
 	base = ioremap(res->start, resource_size(res));
@@ -144,22 +149,8 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	ick = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(ick)) {
-		dev_dbg(&pdev->dev, "couldn't get clock\n");
-		ret = PTR_ERR(ick);
-		goto err3;
-	}
-
-	ret = clk_enable(ick);
-	if (ret) {
-		dev_dbg(&pdev->dev, "couldn't enable clock\n");
-		goto err4;
-	}
-
 	omap->base	= base;
 	omap->dev	= &pdev->dev;
-	omap->ick	= ick;
 
 	omap->cs.name	= "counter-32k";
 	omap->cs.rating	= 250;
@@ -174,7 +165,7 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
 	ret = clocksource_register(&omap->cs);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to register clocksource\n");
-		goto err5;
+		goto err3;
 	}
 
 	/* initialize our offset */
@@ -190,16 +181,12 @@ static int __init omap_counter_32k_probe(struct platform_device *pdev)
 
 	return 0;
 
-err5:
-	clk_disable(ick);
-
-err4:
-	clk_put(ick);
-
 err3:
 	iounmap(base);
 
 err2:
+	pm_runtime_put_sync(&pdev->dev);
+
 err1:
 	kfree(omap);
 
@@ -211,9 +198,8 @@ static int __exit omap_counter_32k_remove(struct platform_device *pdev)
 {
 	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
 
+	pm_runtime_put_sync(&pdev->dev);
 	clocksource_unregister(&omap->cs);
-	clk_disable(omap->ick);
-	clk_put(omap->ick);
 	iounmap(omap->base);
 	kfree(omap);
 	platform_set_drvdata(pdev, NULL);
@@ -221,16 +207,8 @@ static int __exit omap_counter_32k_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void omap_counter_32k_shutdown(struct platform_device *pdev)
-{
-	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
-
-	clk_disable(omap->ick);
-}
-
 static struct platform_driver omap_counter_32k_driver = {
 	.remove		= __exit_p(omap_counter_32k_remove),
-	.shutdown	= omap_counter_32k_shutdown,
 	.driver		= {
 		.name	= "omap-counter-32k",
 	},
-- 
1.7.3.1.120.g38a18

