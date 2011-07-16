From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 REPOST 13/20] gpio/omap: cleanup omap_gpio_mod_init function
Date: Sat, 16 Jul 2011 13:45:45 +0530
Message-ID: <1310804152-9243-14-git-send-email-tarun.kanti@ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49834 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab1GPIQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jul 2011 04:16:31 -0400
In-Reply-To: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

With register offsets now defined for respective OMAP versions we can get rid
of cpu_class_* checks. This function now has common initialization code for
all OMAP versions. Initialization specific to OMAP16xx has been moved within
omap16xx_gpio_init().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio16xx.c |   31 +++++++++++++++++-
 drivers/gpio/gpio-omap.c       |   68 +++++++++------------------------------
 2 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 08dda3c..bd9c49e 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -218,12 +218,41 @@ static struct __initdata platform_device * omap16xx_gpio_dev[] = {
 static int __init omap16xx_gpio_init(void)
 {
 	int i;
+	void __iomem *base;
+	struct resource *res;
+	struct platform_device *pdev;
+	struct omap_gpio_platform_data *pdata;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
+	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
+		pdev = omap16xx_gpio_dev[i];
+		pdata = pdev->dev.platform_data;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (unlikely(!res)) {
+			dev_err(&pdev->dev, "Invalid mem resource.\n");
+			return -ENODEV;
+		}
+
+		base = ioremap(res->start, resource_size(res));
+		if (unlikely(!base)) {
+			dev_err(&pdev->dev, "ioremap failed.\n");
+			return -ENOMEM;
+		}
+
+		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
+
+		/*
+		 * Enable system clock for GPIO module.
+		 * The CAM_CLK_CTRL *is* really the right place.
+		 */
+		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
+					ULPD_CAM_CLK_CTRL);
+
 		platform_device_register(omap16xx_gpio_dev[i]);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 5b32bbf..0da78f3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -875,62 +875,26 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
  */
 static struct lock_class_key gpio_lock_class;
 
-/* TODO: Cleanup cpu_is_* checks */
 static void omap_gpio_mod_init(struct gpio_bank *bank)
 {
-	if (cpu_class_is_omap2()) {
-		if (cpu_is_omap44xx()) {
-			__raw_writel(0xffffffff, bank->base +
-					OMAP4_GPIO_IRQSTATUSCLR0);
-			__raw_writel(0x00000000, bank->base +
-					 OMAP4_GPIO_DEBOUNCENABLE);
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-		} else if (cpu_is_omap34xx()) {
-			__raw_writel(0x00000000, bank->base +
-					OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(0xffffffff, bank->base +
-					OMAP24XX_GPIO_IRQSTATUS1);
-			__raw_writel(0x00000000, bank->base +
-					OMAP24XX_GPIO_DEBOUNCE_EN);
-
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		}
-	} else if (cpu_class_is_omap1()) {
-		if (bank_is_mpuio(bank)) {
-			__raw_writew(0xffff, bank->base +
-				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
-			mpuio_init(bank);
-		}
-		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
-			__raw_writew(0xffff, bank->base
-						+ OMAP1510_GPIO_INT_MASK);
-			__raw_writew(0x0000, bank->base
-						+ OMAP1510_GPIO_INT_STATUS);
-		}
-		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
-			__raw_writew(0x0000, bank->base
-						+ OMAP1610_GPIO_IRQENABLE1);
-			__raw_writew(0xffff, bank->base
-						+ OMAP1610_GPIO_IRQSTATUS1);
-			__raw_writew(0x0014, bank->base
-						+ OMAP1610_GPIO_SYSCONFIG);
+	void __iomem *base = bank->base;
+	u32 l = 0xffffffff;
 
-			/*
-			 * Enable system clock for GPIO module.
-			 * The CAM_CLK_CTRL *is* really the right place.
-			 */
-			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
-						ULPD_CAM_CLK_CTRL);
-		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
-			__raw_writel(0xffffffff, bank->base
-						+ OMAP7XX_GPIO_INT_MASK);
-			__raw_writel(0x00000000, bank->base
-						+ OMAP7XX_GPIO_INT_STATUS);
-		}
+	if (bank_is_mpuio(bank)) {
+		__raw_writel(0xffff, bank->base + bank->regs->irqenable);
+		if (bank->regs->wkup_status)
+			mpuio_init(bank);
+		return;
 	}
+
+	if (bank->width == 16)
+		l = 0xffff;
+
+	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqenable_inv);
+	_gpio_rmw(base, bank->regs->irqstatus, l,
+					bank->regs->irqenable_inv == false);
+	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debounce_en != 0);
+	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl != 0);
 }
 
 static __init void
-- 
1.6.0.4

