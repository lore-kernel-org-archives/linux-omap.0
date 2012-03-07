From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in gpio_irq_handler
Date: Wed, 7 Mar 2012 16:45:55 +0530
Message-ID: <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41129 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab2CGLQ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:26 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

This local variable is just assigned zero and then OR'ed
with isr. It does not appear to serve any purpose and so
removing it.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3765654..de5fe8f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -626,7 +626,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 isr;
 	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
-	u32 retrigger = 0;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -663,8 +662,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			chained_irq_exit(chip, desc);
 		}
 
-		isr |= retrigger;
-		retrigger = 0;
 		if (!isr)
 			break;
 
-- 
1.7.0.4

