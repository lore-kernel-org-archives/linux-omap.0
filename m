From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/6] gpio/omap: Remove bank->id information and misc cleanup
Date: Fri, 24 Feb 2012 23:21:26 +0100
Message-ID: <1330122091-28113-2-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab2BXWWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 17:22:17 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The driver does not need anymore any id to identify the GPIO instance.
Remove every occurence of the bank->id inside the driver.

Remove two trailing spaces.
Add a dev variable for better readability in probe.
Remove unused variable bank->pbase.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f49bd6f..a0c3e03 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -50,7 +50,6 @@ struct gpio_regs {
 
 struct gpio_bank {
 	struct list_head node;
-	unsigned long pbase;
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
@@ -77,7 +76,6 @@ struct gpio_bank {
 	int stride;
 	u32 width;
 	int context_loss_count;
-	u16 id;
 	int power_mode;
 	bool workaround_enabled;
 
@@ -155,7 +153,7 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = __raw_readl(base + reg);
 
-	if (set) 
+	if (set)
 		l |= mask;
 	else
 		l &= ~mask;
@@ -495,7 +493,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long flags;
 
 	if (bank->non_wakeup_gpios & gpio_bit) {
-		dev_err(bank->dev, 
+		dev_err(bank->dev,
 			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
 		return -EINVAL;
 	}
@@ -1048,37 +1046,36 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
 	int ret = 0;
 
-	if (!pdev->dev.platform_data) {
+	if (!dev->platform_data) {
 		ret = -EINVAL;
 		goto err_exit;
 	}
 
 	bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
 	if (!bank) {
-		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
+		dev_err(dev, "Memory alloc failed\n");
 		ret = -ENOMEM;
 		goto err_exit;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n",
-				pdev->id);
+		dev_err(dev, "Invalid IRQ resource\n");
 		ret = -ENODEV;
 		goto err_free;
 	}
 
 	bank->irq = res->start;
-	bank->id = pdev->id;
 
 	pdata = pdev->dev.platform_data;
 	bank->virtual_irq_start = pdata->virtual_irq_start;
-	bank->dev = &pdev->dev;
+	bank->dev = dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
@@ -1098,16 +1095,14 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n",
-				pdev->id);
+		dev_err(dev, "Invalid mem resource\n");
 		ret = -ENODEV;
 		goto err_free;
 	}
 
 	bank->base = ioremap(res->start, resource_size(res));
 	if (!bank->base) {
-		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n",
-				pdev->id);
+		dev_err(dev, "Could not ioremap\n");
 		ret = -ENOMEM;
 		goto err_free;
 	}
-- 
1.7.0.4

