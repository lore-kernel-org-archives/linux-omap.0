From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 4/4 RFC]OMAP:GPIO: Convert all printk's to pr_* in gpio
Date: Fri, 12 Feb 2010 19:07:31 +0530
Message-ID: <1265981851-11970-5-git-send-email-charu@ti.com>
References: <1265981851-11970-1-git-send-email-charu@ti.com>
 <1265981851-11970-2-git-send-email-charu@ti.com>
 <1265981851-11970-3-git-send-email-charu@ti.com>
 <1265981851-11970-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab0BLNiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Feb 2010 08:38:54 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDco9W008647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:38:53 -0600
In-Reply-To: <1265981851-11970-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Charulatha V <charu@ti.com>

GPIO driver still uses printk's instead of using pr_*
This patch fixes all such instances.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/gpio.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 65b8edb..f28900f 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -824,7 +824,7 @@ static inline int gpio_valid(int gpio)
 static int check_gpio(int gpio)
 {
 	if (unlikely(gpio_valid(gpio) < 0)) {
-		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
+		pr_err("omap-gpio: invalid GPIO %d\n", gpio);
 		dump_stack();
 		return -1;
 	}
@@ -937,7 +937,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	}
 
 	if (!(bank->mod_usage & l)) {
-		printk(KERN_ERR "GPIO %d not requested\n", gpio);
+		pr_err("GPIO %d not requested\n", gpio);
 		return;
 	}
 
@@ -974,7 +974,7 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 	reg = bank->base;
 
 	if (!bank->mod_usage) {
-		printk(KERN_ERR "GPIO not requested\n");
+		pr_err("GPIO not requested\n");
 		return;
 	}
 
@@ -1209,7 +1209,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long uninitialized_var(flags);
 
 	if (bank->non_wakeup_gpios & (1 << gpio)) {
-		printk(KERN_ERR "Unable to modify wakeup on "
+		pr_err("Unable to modify wakeup on "
 				"non-wakeup GPIO%d\n",
 				(bank - gpio_bank) * 32 + gpio);
 		return -EINVAL;
@@ -1535,7 +1535,7 @@ static int __init omap3_gpio_pads_init(void)
 		GFP_KERNEL);
 
 	if (gpio_pads == NULL) {
-		printk(KERN_ERR "FATAL: Failed to allocate gpio_pads\n");
+		pr_err("FATAL: Failed to allocate gpio_pads\n");
 		return -ENOMEM;
 	}
 
@@ -2002,7 +2002,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	int id, i;
 
 	if (!pdev || !pdata) {
-		printk(KERN_ERR "GPIO device initialize without"
+		pr_err("GPIO device initialize without"
 					"platform data\n");
 		return -EINVAL;
 	}
@@ -2018,7 +2018,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	id = pdev->id;
 	if (id > gpio_bank_count) {
-		printk(KERN_ERR "Invalid GPIO device id (%d)\n", id);
+		pr_err("Invalid GPIO device id (%d)\n", id);
 		return -EINVAL;
 	}
 
@@ -2031,14 +2031,14 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	bank->ick = clk_get(NULL, pdata->ick_name);
 	if (IS_ERR(bank->ick))
-		printk(KERN_ERR "Could not get %s\n", pdata->ick_name);
+		pr_err("Could not get %s\n", pdata->ick_name);
 	else
 		clk_enable(bank->ick);
 
 	if (cpu_is_omap24xx()) {
 		bank->fck = clk_get(NULL, pdata->fck_name);
 		if (IS_ERR(bank->fck))
-			printk(KERN_ERR "Could not get %s\n", pdata->fck_name);
+			pr_err("Could not get %s\n", pdata->fck_name);
 		else
 			clk_enable(bank->fck);
 	}
@@ -2048,19 +2048,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
-		printk(KERN_ERR "GPIO Bank %i Invalid mem resource\n", id);
+		pr_err("GPIO Bank %i Invalid mem resource\n", id);
 		return -ENODEV;
 	}
 
 	bank->base = ioremap(res->start, resource_size(res));
 	if (!bank->base) {
-		printk(KERN_ERR "Could not ioremap gpio bank%i\n", id);
+		pr_err("Could not ioremap gpio bank%i\n", id);
 		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
-		printk(KERN_ERR "GPIO Bank %i Invalid irq resource\n", id);
+		pr_err("GPIO Bank %i Invalid irq resource\n", id);
 		return -ENODEV;
 	}
 
@@ -2126,7 +2126,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		bank->dbck = clk_get(NULL, pdata->dbck_name);
 		if (IS_ERR(bank->dbck))
-			printk(KERN_ERR "Could not get %s\n", pdata->dbck_name);
+			pr_err("Could not get %s\n", pdata->dbck_name);
 	}
 
 	/* Enable autoidle for the OCP interface */
-- 
1.6.3.3

