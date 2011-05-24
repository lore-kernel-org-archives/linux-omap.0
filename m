From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 03/15] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Tue, 24 May 2011 19:54:42 +0530
Message-ID: <1306247094-25372-4-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43548 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab1EXOZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:26 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

gpio_bank_count is the count of number of GPIO devices
in a SoC. Remove this dependency from the driver. Also remove
the dependency on array of pointers to gpio_bank struct of
all GPIO devices.

TODO:
The save_context/ restore_context need to be modified to be
called from the prepare_for_/resume_after_ idle, only for the
specific banks and remove the gpio_save_context call from
pm34xx.c. This would be handled in one of the later patches in this
series.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    1 -
 arch/arm/mach-omap1/gpio16xx.c         |    2 -
 arch/arm/mach-omap1/gpio7xx.c          |    2 -
 arch/arm/mach-omap2/gpio.c             |    1 -
 arch/arm/plat-omap/include/plat/gpio.h |    3 -
 drivers/gpio/gpio_omap.c               |  156 ++++++++++++++++----------------
 6 files changed, 76 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 6d83e0a..f18a4a9 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -117,7 +117,6 @@ static int __init omap15xx_gpio_init(void)
 	platform_device_register(&omap15xx_mpu_gpio);
 	platform_device_register(&omap15xx_gpio);
 
-	gpio_bank_count = 2;
 	return 0;
 }
 postcore_initcall(omap15xx_gpio_init);
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 6bba196..d886b88 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -223,8 +223,6 @@ static int __init omap16xx_gpio_init(void)
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
 		platform_device_register(omap16xx_gpio_dev[i]);
 
-	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
-
 	return 0;
 }
 postcore_initcall(omap16xx_gpio_init);
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 0fc2557..c7684ce 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -284,8 +284,6 @@ static int __init omap7xx_gpio_init(void)
 	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++)
 		platform_device_register(omap7xx_gpio_dev[i]);
 
-	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
-
 	return 0;
 }
 postcore_initcall(omap7xx_gpio_init);
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 6cd26b4..487b49a 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -143,7 +143,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(od);
 	}
 
-	gpio_bank_count++;
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 8014a8a..ad9e668 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -204,9 +204,6 @@ struct omap_gpio_platform_data {
 	struct omap_gpio_reg_offs *regs;
 };
 
-/* TODO: Analyze removing gpio_bank_count usage from driver code */
-extern int gpio_bank_count;
-
 extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 0ba4cdb..c6a1ec9 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -28,7 +28,10 @@
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
 
+static LIST_HEAD(omap_gpio_list);
+
 struct gpio_bank {
+	struct list_head node;
 	unsigned long pbase;
 	void __iomem *base;
 	u16 irq;
@@ -55,6 +58,7 @@ struct gpio_bank {
 	bool dbck_flag;
 	int stride;
 	u32 width;
+	u16 id;
 
 	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
 
@@ -78,15 +82,6 @@ struct omap3_gpio_regs {
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 #endif
 
-/*
- * TODO: Cleanup gpio_bank usage as it is having information
- * related to all instances of the device
- */
-static struct gpio_bank *gpio_bank;
-
-/* TODO: Analyze removing gpio_bank_count usage from driver code */
-int gpio_bank_count;
-
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
@@ -857,9 +852,8 @@ static struct platform_device omap_mpuio_device = {
 	/* could list the /proc/iomem resources */
 };
 
-static inline void mpuio_init(void)
+static inline void mpuio_init(struct gpio_bank *bank)
 {
-	struct gpio_bank *bank = &gpio_bank[0];
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
@@ -867,13 +861,13 @@ static inline void mpuio_init(void)
 }
 
 #else
-static inline void mpuio_init(void) {}
+static inline void mpuio_init(struct gpio_bank *bank) {}
 #endif	/* 16xx */
 
 #else
 
 #define bank_is_mpuio(bank)	0
-static inline void mpuio_init(void) {}
+static inline void mpuio_init(struct gpio_bank *bank) {}
 
 #endif
 
@@ -995,18 +989,6 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
  */
 static struct lock_class_key gpio_lock_class;
 
-static inline int init_gpio_info(struct platform_device *pdev)
-{
-	/* TODO: Analyze removing gpio_bank_count usage from driver code */
-	gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
-				GFP_KERNEL);
-	if (!gpio_bank) {
-		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-
 /* TODO: Cleanup cpu_is_* checks */
 static void omap_gpio_mod_init(struct gpio_bank *bank)
 {
@@ -1030,9 +1012,11 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
 		}
 	} else if (cpu_class_is_omap1()) {
-		if (bank_is_mpuio(bank))
+		if (bank_is_mpuio(bank)) {
 			__raw_writew(0xffff, bank->base +
 				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
+			mpuio_init(bank);
+		}
 		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
 			__raw_writew(0xffff, bank->base
 						+ OMAP1510_GPIO_INT_MASK);
@@ -1138,36 +1122,37 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 
 static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
-	static int gpio_init_done;
 	struct omap_gpio_platform_data *pdata;
 	struct resource *res;
-	int id;
 	struct gpio_bank *bank;
+	int ret = 0;
 
-	if (!pdev->dev.platform_data)
-		return -EINVAL;
-
-	pdata = pdev->dev.platform_data;
-
-	if (!gpio_init_done) {
-		int ret;
-
-		ret = init_gpio_info(pdev);
-		if (ret)
-			return ret;
+	if (!pdev->dev.platform_data) {
+		ret = -EINVAL;
+		goto err_exit;
 	}
 
-	id = pdev->id;
-	bank = &gpio_bank[id];
+	bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
+	if (!bank) {
+		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
+		ret = -ENOMEM;
+		goto err_exit;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n", id);
-		return -ENODEV;
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n",
+				pdev->id);
+		ret = -ENODEV;
+		goto err_free;
 	}
 
 	bank->irq = res->start;
+	bank->id = pdev->id;
+
+	pdata = pdev->dev.platform_data;
 	bank->virtual_irq_start = pdata->virtual_irq_start;
+
 	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
@@ -1187,14 +1172,18 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n", id);
-		return -ENODEV;
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n",
+				pdev->id);
+		ret = -ENODEV;
+		goto err_free;
 	}
 
 	bank->base = ioremap(res->start, resource_size(res));
 	if (!bank->base) {
-		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n", id);
-		return -ENOMEM;
+		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n",
+				pdev->id);
+		ret = -ENOMEM;
+		goto err_free;
 	}
 
 	pm_runtime_enable(bank->dev);
@@ -1204,22 +1193,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (!gpio_init_done)
-		gpio_init_done = 1;
+	list_add_tail(&bank->node, &omap_gpio_list);
 
-	return 0;
+	return ret;
+
+err_free:
+	kfree(bank);
+err_exit:
+	return ret;
 }
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
-	int i;
+	struct gpio_bank *bank;
 
 	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
 		return 0;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		void __iomem *wake_status;
 		void __iomem *wake_clear;
 		void __iomem *wake_set;
@@ -1263,13 +1255,12 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 
 static int omap_gpio_resume(struct sys_device *dev)
 {
-	int i;
+	struct gpio_bank *bank;
 
 	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
 		return 0;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		void __iomem *wake_clear;
 		void __iomem *wake_set;
 		unsigned long flags;
@@ -1325,17 +1316,17 @@ static int workaround_enabled;
 
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
-	int i, c = 0;
-	int min = 0;
-
-	if (cpu_is_omap34xx())
-		min = 1;
+	int c = 0;
+	struct gpio_bank *bank;
 
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 l1 = 0, l2 = 0;
 		int j;
 
+		/* TODO: Do not use cpu_is_omap34xx */
+		if ((cpu_is_omap34xx()) && (bank->id == 0))
+			continue;
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_disable(bank->dbck);
 
@@ -1394,16 +1385,16 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 
 void omap2_gpio_resume_after_idle(void)
 {
-	int i;
-	int min = 0;
+	struct gpio_bank *bank;
 
-	if (cpu_is_omap34xx())
-		min = 1;
-	for (i = min; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
+		/* TODO: Do not use cpu_is_omap34xx */
+		if ((cpu_is_omap34xx()) && (bank->id == 0))
+			continue;
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
@@ -1492,14 +1483,17 @@ void omap2_gpio_resume_after_idle(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-/* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
-	int i;
+	struct gpio_bank *bank;
+	int i = 0;
+
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		i++;
+
+		if (bank->id == 0)
+			continue;
 
-	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
 		gpio_context[i].irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		gpio_context[i].irqenable2 =
@@ -1523,13 +1517,17 @@ void omap_gpio_save_context(void)
 	}
 }
 
-/* restore the required registers of bank 2-6 */
 void omap_gpio_restore_context(void)
 {
-	int i;
+	struct gpio_bank *bank;
+	int i = 0;
+
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		i++;
+
+		if (bank->id == 0)
+			continue;
 
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
 		__raw_writel(gpio_context[i].irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(gpio_context[i].irqenable2,
@@ -1576,8 +1574,6 @@ static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	mpuio_init();
-
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
-- 
1.6.0.4

