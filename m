From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/8] OMAP: Fix a BUG in l3 error handler.
Date: Thu, 8 Sep 2011 10:52:02 +0530
Message-ID: <1315459327-3285-4-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1IHFW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 01:22:27 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Todd Poynor <toddpoynor@google.com>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Todd Poynor <toddpoynor@google.com>

With the current sequence of registering the irq and
assigning it to the app_irq, debug_irq driver variables,
there can be corner cases where the pending irq gets
triggered immediately after registering, handler gets called
resulting in a crash. So changed this sequence.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index d560c88..cf237dd 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -124,7 +124,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 {
 	static struct omap4_l3		*l3;
 	struct resource	*res;
-	int ret, irq;
+	int ret;
 
 	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
 	if (!l3)
@@ -176,8 +176,8 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	/*
 	 * Setup interrupt Handlers
 	 */
-	irq = platform_get_irq(pdev, 0);
-	ret = request_irq(irq,
+	l3->debug_irq = platform_get_irq(pdev, 0);
+	ret = request_irq(l3->debug_irq,
 			l3_interrupt_handler,
 			IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
@@ -185,10 +185,9 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 					 OMAP44XX_IRQ_L3_DBG);
 		goto err3;
 	}
-	l3->debug_irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	ret = request_irq(irq,
+	l3->app_irq = platform_get_irq(pdev, 1);
+	ret = request_irq(l3->app_irq,
 			l3_interrupt_handler,
 			IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret) {
@@ -196,7 +195,6 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 					 OMAP44XX_IRQ_L3_APP);
 		goto err4;
 	}
-	l3->app_irq = irq;
 
 	return 0;
 
-- 
1.7.4.1

