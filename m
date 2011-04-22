From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 03/15] OMAP: GPIO: move bank width into struct gpio_bank
Date: Fri, 22 Apr 2011 16:01:55 -0700
Message-ID: <1303513327-14532-4-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50000 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab1DVXAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:08 -0400
Received: by pve37 with SMTP id 37so643365pve.7
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:07 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Rather than having a file-global bank_width variable, move it into
struct gpio_bank so it can be bank-specific.   Note the bank width
is already passed per-bank via platform_data, so current code would
be incorrect if any banks had different width.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8b5ca6e..443fb9a 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -159,6 +159,7 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
+	u32 width;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -184,8 +185,6 @@ static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
  */
 static struct gpio_bank *gpio_bank;
 
-static int bank_width;
-
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
@@ -983,7 +982,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
-					(bank - gpio_bank) * 32 + gpio);
+			       (bank - gpio_bank) * bank->width + gpio);
 			return -EINVAL;
 		}
 		spin_lock_irqsave(&bank->lock, flags);
@@ -1650,14 +1649,14 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	} else {
 		bank->chip.label = "gpio";
 		bank->chip.base = gpio;
-		gpio += bank_width;
+		gpio += bank->width;
 	}
-	bank->chip.ngpio = bank_width;
+	bank->chip.ngpio = bank->width;
 
 	gpiochip_add(&bank->chip);
 
 	for (j = bank->virtual_irq_start;
-		     j < bank->virtual_irq_start + bank_width; j++) {
+		     j < bank->virtual_irq_start + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
 		if (bank_is_mpuio(bank))
@@ -1707,7 +1706,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
-	bank_width = pdata->bank_width;
+	bank->width = pdata->bank_width;
 
 	spin_lock_init(&bank->lock);
 
-- 
1.7.4

