From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/2] arm: mach-omap2: omap_l3_smx: fix irq handler setup
Date: Wed, 16 Mar 2011 19:16:03 +0200
Message-ID: <1300295763-497-2-git-send-email-aaro.koskinen@nokia.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:27008 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1CPRMP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 13:12:15 -0400
In-Reply-To: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

The handler function may be called from the point it is registered.
Since the handler inspects IRQ numbers, we must set them up before
registration.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 265bff3..5f2da75 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -226,7 +226,6 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 	struct omap3_l3         *l3;
 	struct resource         *res;
 	int                     ret;
-	int                     irq;
 
 	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
 	if (!l3) {
@@ -249,18 +248,17 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	ret = request_irq(irq, omap3_l3_app_irq,
+	l3->debug_irq = platform_get_irq(pdev, 0);
+	ret = request_irq(l3->debug_irq, omap3_l3_app_irq,
 		IRQF_DISABLED | IRQF_TRIGGER_RISING,
 		"l3-debug-irq", l3);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request debug irq\n");
 		goto err3;
 	}
-	l3->debug_irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	ret = request_irq(irq, omap3_l3_app_irq,
+	l3->app_irq = platform_get_irq(pdev, 1);
+	ret = request_irq(l3->app_irq, omap3_l3_app_irq,
 		IRQF_DISABLED | IRQF_TRIGGER_RISING,
 		"l3-app-irq", l3);
 
@@ -269,7 +267,6 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	l3->app_irq = irq;
 	goto err0;
 
 err4:
-- 
1.5.6.5

