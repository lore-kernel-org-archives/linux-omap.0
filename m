From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 03/14] GPIO: OMAP: move bank width into struct gpio_bank
Date: Fri, 20 May 2011 17:14:46 +0200
Message-ID: <1305904497-26013-4-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35203 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:16 -0400
Received: by wwi36 with SMTP id 36so3383070wwi.2
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:10 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Rather than having a file-global bank_width variable, move it into
struct gpio_bank so it can be bank-specific.   Note the bank width
is already passed per-bank via platform_data, so current code would
be incorrect if any banks had different width.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 6fcee66..4691ed8 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -54,6 +54,7 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
+	u32 width;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -79,8 +80,6 @@ static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
  */
 static struct gpio_bank *gpio_bank;
 
-static int bank_width;
-
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
@@ -878,7 +877,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
-					(bank - gpio_bank) * 32 + gpio);
+			       (bank - gpio_bank) * bank->width + gpio);
 			return -EINVAL;
 		}
 		spin_lock_irqsave(&bank->lock, flags);
@@ -1545,14 +1544,14 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
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
@@ -1602,7 +1601,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
-	bank_width = pdata->bank_width;
+	bank->width = pdata->bank_width;
 
 	spin_lock_init(&bank->lock);
 
-- 
1.7.3.4

