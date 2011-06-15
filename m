From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 14/18] GPIO: OMAP: Fix use of readl/readw to access isr_reg
Date: Wed, 15 Jun 2011 09:53:22 +0530
Message-ID: <1308111806-29152-5-git-send-email-tarun.kanti@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52684 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1FOEW4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 00:22:56 -0400
In-Reply-To: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Charulatha V <charu@ti.com>

In gpio_irq_handler, isr register is always accessed as 32 bit register and only
for OMAP15xx the first 16 MSBs are masked. Correct this by using the appropriate
readl/readw registers as per the bank width.

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c6987f2..01b568f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -590,10 +590,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 enabled;
 
 		enabled = _get_gpio_irqbank_mask(bank);
-		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
+		if (bank->width == 32)
+			isr = __raw_readl(isr_reg) & enabled;
+		else if (bank->width == 16)
+			isr = (__raw_readw(isr_reg) & enabled) & 0x0000ffff;
+		isr_saved = isr;
 
 		if (bank->regs->leveldetect0)
 			level_mask = bank->level_mask & enabled;
-- 
1.6.0.4

