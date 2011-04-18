From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] cbus: retu: Fix build breakage caused by recent genirq commits
Date: Mon, 18 Apr 2011 22:21:31 +0300
Message-ID: <1303154492-13520-2-git-send-email-jhnikula@gmail.com>
References: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61034 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab1DRTVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 15:21:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1481820ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 12:21:47 -0700 (PDT)
In-Reply-To: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Convert retu.c to use updated irq function names after the genirq cleanup
commits 0c6f8a8 "genirq: Remove compat code" and
a0cd9ca "genirq: Namespace cleanup".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 drivers/cbus/retu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index f271e57..ec108f3 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -298,10 +298,10 @@ static void retu_irq_init(struct retu *retu)
 	int			irq;
 
 	for (irq = base; irq < end; irq++) {
-		set_irq_chip_data(irq, retu);
-		set_irq_chip_and_handler(irq, &retu_irq_chip,
+		irq_set_chip_data(irq, retu);
+		irq_set_chip_and_handler(irq, &retu_irq_chip,
 				handle_simple_irq);
-		set_irq_nested_thread(irq, 1);
+		irq_set_nested_thread(irq, 1);
 		retu_irq_setup(irq);
 	}
 }
@@ -316,8 +316,8 @@ static void retu_irq_exit(struct retu *retu)
 #ifdef CONFIG_ARM
 		set_irq_flags(irq, 0);
 #endif
-		set_irq_chip_and_handler(irq, NULL, NULL);
-		set_irq_chip_data(irq, NULL);
+		irq_set_chip_and_handler(irq, NULL, NULL);
+		irq_set_chip_data(irq, NULL);
 	}
 }
 
@@ -479,7 +479,7 @@ static int __init retu_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	set_irq_wake(retu->irq, 1);
+	irq_set_irq_wake(retu->irq, 1);
 
 	/* Register power off function */
 	pm_power_off = retu_power_off;
-- 
1.7.0.4

