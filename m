From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 15/20] GPIO: OMAP: Use readl in irq_handler for all access
Date: Fri, 1 Jul 2011 15:17:09 +0530
Message-ID: <1309513634-20971-16-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50449 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885Ab1GAJrs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 05:47:48 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Charulatha V <charu@ti.com>

Even when bank->width is 16, all the OMAP1 registers are 4-byte aligned, so just
use a 4-byte read.  The 'enabled' mask is already taking care to mask for bank width.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7f32f7b..25675a6 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -568,8 +568,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
 
 		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
-- 
1.6.0.4

