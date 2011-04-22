From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 11/18] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Fri, 22 Apr 2011 16:38:25 +0530
Message-ID: <1303470512-19671-12-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60448 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043Ab1DVLEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:52 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

gpio_bank_count is the count of number of GPIO devices
in a SoC. Remove this dependency from the driver. Also remove
the dependency on array of pointers to gpio_bank struct of
all GPIO devices.

The cpu_is*() checks used in omap2_gpio_prepare_for_idle() and
omap2_gpio_resume_after_idle() would be removed in one of the
patches in this series

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    1 -
 arch/arm/mach-omap1/gpio16xx.c         |    2 -
 arch/arm/mach-omap1/gpio7xx.c          |    2 -
 arch/arm/mach-omap2/gpio.c             |    1 +
 arch/arm/plat-omap/gpio.c              |  165 ++++++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h |    3 -
 6 files changed, 83 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 7a7a123..3763db3 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -189,7 +189,6 @@ static int __init omap15xx_gpio_init(void)
 	omap15xx_mpu_gpio_config.gpio_fn = &gpio_fn;
 	platform_device_register(&omap15xx_gpio);
 
-	gpio_bank_count = 2;
 	return 0;
 }
 postcore_initcall(omap15xx_gpio_init);
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index f05e0c7..6a99b01 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -316,8 +316,6 @@ static int __init omap16xx_gpio_init(void)
 		platform_device_register(omap16xx_gpio_dev[i]);
 	}
 
-	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
-
 	return 0;
 }
 postcore_initcall(omap16xx_gpio_init);
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 1103efc..cd6bad7 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -355,8 +355,6 @@ static int __init omap7xx_gpio_init(void)
 		platform_device_register(omap7xx_gpio_dev[i]);
 	}
 
-	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
-
 	return 0;
 }
 postcore_initcall(omap7xx_gpio_init);
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 25fe8a4..a46f4a5 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -28,6 +28,7 @@
 #define OMAP2_GPIO_INDEX_MASK		0x1f
 #define OMAP2_GPIO_IRQENA_MASK		0xffffffff
 
+int gpio_bank_count;
 int bank_width;
 static u16 *reg_map;
 static u16 omap2_gpio_reg_offsets[] = {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index df2414d..f2cd2dd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -14,6 +14,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -135,7 +136,10 @@
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 
+static LIST_HEAD(omap_gpio_list);
+
 struct gpio_bank {
+	struct list_head node;
 	unsigned long pbase;
 	void __iomem *base;
 	u16 irq;
@@ -145,7 +149,7 @@ struct gpio_bank {
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
-
+	u16 id;
 	u32 saved_datain;
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
@@ -178,18 +182,10 @@ struct omap3_gpio_regs {
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 #endif
 
-/*
- * TODO: Cleanup gpio_bank usage as it is having information
- * related to all instances of the device
- */
-static struct gpio_bank *gpio_bank;
 static struct omap_gpio_func gpio_fn;
 
 static int bank_width;
 
-/* TODO: Analyze removing gpio_bank_count usage from driver code */
-int gpio_bank_count;
-
 static int check_gpio(int gpio)
 {
 	if (unlikely(gpio_fn.gpio_valid(gpio) < 0)) {
@@ -634,7 +630,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
-					(bank - gpio_bank) * 32 + gpio);
+					bank->id * 32 + gpio);
 			return -EINVAL;
 		}
 	case METHOD_MPUIO:
@@ -991,17 +987,23 @@ static struct platform_device omap_mpuio_device = {
 	/* could list the /proc/iomem resources */
 };
 
-static inline void mpuio_init(void)
+static inline void mpuio_init(struct gpio_bank *bank)
 {
-	struct gpio_bank *bank = &gpio_bank[0];
+	static int mpuio_init_done;
+
+	if (mpuio_init_done || (bank->method != METHOD_MPUIO))
+		return;
+
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
-	if (platform_driver_register(&omap_mpuio_driver) == 0)
-		(void) platform_device_register(&omap_mpuio_device);
+	if (!platform_driver_register(&omap_mpuio_driver))
+		platform_device_register(&omap_mpuio_device);
+
+	mpuio_init_done = 1;
 }
 
 #else
-static inline void mpuio_init(void) {}
+static inline void mpuio_init(struct gpio_bank *bank) {}
 #endif	/* 16xx */
 
 #else
@@ -1009,7 +1011,7 @@ static inline void mpuio_init(void) {}
 extern struct irq_chip mpuio_irq_chip;
 
 #define bank_is_mpuio(bank)	0
-static inline void mpuio_init(void) {}
+static inline void mpuio_init(struct gpio_bank *bank) {}
 
 #endif
 
@@ -1137,18 +1139,6 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
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
 static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 {
@@ -1264,83 +1254,83 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	static int gpio_init_done;
 	struct omap_gpio_platform_data *pdata;
 	struct resource *res;
-	int id;
 	struct gpio_bank *bank;
 
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
-		if (cpu_class_is_omap1())
-			mpuio_init();
-
-		gpio_fn.get_index = pdata->gpio_fn->get_index;
-		gpio_fn.gpio_valid = pdata->gpio_fn->gpio_valid;
-		gpio_fn.gpio_read = pdata->gpio_fn->gpio_read;
-		gpio_fn.gpio_write = pdata->gpio_fn->gpio_write;
-		gpio_fn.gpio_set_trigger = pdata->gpio_fn->gpio_set_trigger;
-		gpio_fn.gpio_is_irqena = pdata->gpio_fn->gpio_is_irqena;
-		gpio_fn.gpio_enable_irq = pdata->gpio_fn->gpio_enable_irq;
+	bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
+	if (!bank) {
+		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
+		return -ENOMEM;
 	}
 
-	id = pdev->id;
-	bank = &gpio_bank[id];
-
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n", id);
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n",
+				pdev->id);
 		return -ENODEV;
 	}
 
 	bank->irq = res->start;
+
+	pdata = pdev->dev.platform_data;
 	bank->virtual_irq_start = pdata->virtual_irq_start;
+
+	bank->id = pdev->id;
 	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank_width = pdata->bank_width;
 
+	if (!gpio_init_done) {
+		if (cpu_class_is_omap1())
+			mpuio_init(bank);
+	}
+
 	spin_lock_init(&bank->lock);
 
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n", id);
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n",
+				bank->id);
 		return -ENODEV;
 	}
 
 	bank->base = ioremap(res->start, resource_size(res));
 	if (!bank->base) {
-		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n", id);
+		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n",
+				bank->id);
 		return -ENOMEM;
 	}
 
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	omap_gpio_mod_init(bank, id);
+	omap_gpio_mod_init(bank, pdev->id);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (!gpio_init_done)
+	list_add_tail(&bank->node, &omap_gpio_list);
+
+	if (!gpio_init_done) {
+		gpio_fn.get_index = pdata->gpio_fn->get_index;
+		gpio_fn.gpio_valid = pdata->gpio_fn->gpio_valid;
+		gpio_fn.gpio_read = pdata->gpio_fn->gpio_read;
+		gpio_fn.gpio_write = pdata->gpio_fn->gpio_write;
+		gpio_fn.gpio_set_trigger = pdata->gpio_fn->gpio_set_trigger;
+		gpio_fn.gpio_is_irqena = pdata->gpio_fn->gpio_is_irqena;
+		gpio_fn.gpio_enable_irq = pdata->gpio_fn->gpio_enable_irq;
 		gpio_init_done = 1;
+	}
 
 	return 0;
 }
 
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
-	int i;
+	struct gpio_bank *bank;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 wake_status;
 		u32 wake_clear;
 		u32 wake_set;
@@ -1372,10 +1362,9 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 
 static int omap_gpio_resume(struct sys_device *dev)
 {
-	int i;
+	struct gpio_bank *bank;
 
-	for (i = 0; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
 		u32 wake_clear;
 		u32 wake_set;
 		unsigned long flags;
@@ -1419,17 +1408,17 @@ static int workaround_enabled;
 
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
 
@@ -1488,16 +1477,16 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 
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
 
@@ -1589,11 +1578,16 @@ void omap2_gpio_resume_after_idle(void)
 /* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
-	int i;
+	struct gpio_bank *bank;
+	int i = 0;
 
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	for (i = 1; i < gpio_bank_count; i++) {
-		struct gpio_bank *bank = &gpio_bank[i];
+	list_for_each_entry(bank, &omap_gpio_list, node) {
+		i++;
+
+		if (bank->id == 0)
+			continue;
+
 		gpio_context[i].irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		gpio_context[i].irqenable2 =
@@ -1620,10 +1614,15 @@ void omap_gpio_save_context(void)
 /* restore the required registers of bank 2-6 */
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
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index c21f2e9..331ee4c 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -127,9 +127,6 @@ struct omap_gpio_platform_data {
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 };
 
-/* TODO: Analyze removing gpio_bank_count usage from driver code */
-extern int gpio_bank_count;
-
 extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
-- 
1.7.1

