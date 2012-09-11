From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/17] W1: OMAP HDQ1W: Remove dependencies to mach/hardware.h
Date: Mon, 10 Sep 2012 22:31:01 -0700
Message-ID: <20120911053101.29637.31257.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48023 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753547Ab2IKFbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:03 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Evgeniy Polyakov <zbr@ioremap.net>, linux-omap@vger.kernel.org

No need for hardcoded IRQ here.

We can't include mach headers for ARM common zImage support.

Cc: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/w1/masters/omap_hdq.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 4b0fcf3..fee195a 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -19,7 +19,6 @@
 #include <linux/pm_runtime.h>
 
 #include <asm/irq.h>
-#include <mach/hardware.h>
 
 #include "../w1.h"
 #include "../w1_int.h"
@@ -644,7 +643,7 @@ static int omap_hdq_remove(struct platform_device *pdev)
 
 	/* remove module dependency */
 	pm_runtime_disable(&pdev->dev);
-	free_irq(INT_24XX_HDQ_IRQ, hdq_data);
+	free_irq(platform_get_irq(pdev, 0), hdq_data);
 	platform_set_drvdata(pdev, NULL);
 	iounmap(hdq_data->hdq_base);
 	kfree(hdq_data);

