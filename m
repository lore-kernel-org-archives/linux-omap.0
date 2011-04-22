From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 14/18] OMAP: GPIO: Remove CONFIG_ARCH_OMAP16XX/OMAP2+ defines
Date: Fri, 22 Apr 2011 16:38:28 +0530
Message-ID: <1303470512-19671-15-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38681 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1DVLEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:46 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Suspend/resume/wakeup capabilities are supported only in
OMAP16xx and OMAP2PLUS SoCs. Handle this by using a flag
"suspend_resume_support" in pdata.

This requires calling omap_gpio_sysinit() as part of probe
instead of having this function as an arch_initcall

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio16xx.c         |    5 ++
 arch/arm/mach-omap2/gpio.c             |    1 +
 arch/arm/plat-omap/gpio.c              |   96 ++++++++++++++------------------
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 4 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 6a99b01..cbac063 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -76,6 +76,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
 	.bank_stride		= 1,
+	.suspend_resume_support	= true,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
@@ -105,6 +106,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
+	.suspend_resume_support	= true,
 };
 
 static struct __initdata platform_device omap16xx_gpio1 = {
@@ -134,6 +136,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
+	.suspend_resume_support	= true,
 };
 
 static struct __initdata platform_device omap16xx_gpio2 = {
@@ -163,6 +166,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
+	.suspend_resume_support	= true,
 };
 
 static struct __initdata platform_device omap16xx_gpio3 = {
@@ -192,6 +196,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
+	.suspend_resume_support	= true,
 };
 
 static struct __initdata platform_device omap16xx_gpio4 = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index a7bb005..73b5705 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -467,6 +467,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->dbck_flag = dev_attr->dbck_flag;
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
 	pdata->gpio_fn = &gpio_fn;
+	pdata->suspend_resume_support = true;
 
 	switch (oh->class->rev) {
 	case 0:
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index fd710cd..0f48364 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -158,11 +158,13 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
+	bool suspend_resume_support;
 };
 
 static struct omap_gpio_func gpio_fn;
 static int bank_width;
 
+static int omap_gpio_sysinit(void);
 static int check_gpio(int gpio)
 {
 	if (unlikely(gpio_fn.gpio_valid(gpio) < 0)) {
@@ -829,8 +831,6 @@ static struct irq_chip gpio_irq_chip = {
 
 /*---------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP1
-
 /* MPUIO uses the always-on 32k clock */
 
 static void mpuio_ack_irq(struct irq_data *d)
@@ -860,20 +860,8 @@ static struct irq_chip mpuio_irq_chip = {
 	.irq_mask	= mpuio_mask_irq,
 	.irq_unmask	= mpuio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
-#ifdef CONFIG_ARCH_OMAP16XX
-	/* REVISIT: assuming only 16xx supports MPUIO wake events */
-	.irq_set_wake	= gpio_wake_enable,
-#endif
 };
 
-
-#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
-
-
-#ifdef CONFIG_ARCH_OMAP16XX
-
-#include <linux/platform_device.h>
-
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -944,19 +932,6 @@ static inline void mpuio_init(struct gpio_bank *bank)
 	mpuio_init_done = 1;
 }
 
-#else
-static inline void mpuio_init(struct gpio_bank *bank) {}
-#endif	/* 16xx */
-
-#else
-
-extern struct irq_chip mpuio_irq_chip;
-
-#define bank_is_mpuio(bank)	0
-static inline void mpuio_init(struct gpio_bank *bank) {}
-
-#endif
-
 /*---------------------------------------------------------------------*/
 
 /* REVISIT these are stupid implementations!  replace by ones that
@@ -1104,7 +1079,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 				bank->non_wakeup_gpios = non_wakeup_gpios[id];
 		}
 	} else if (cpu_class_is_omap1()) {
-		if (bank_is_mpuio(bank))
+		if (bank->method == METHOD_MPUIO)
 			__raw_writew(0xffff, bank->base +
 				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
 		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
@@ -1155,11 +1130,10 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
 	bank->chip.to_irq = gpio_2irq;
-	if (bank_is_mpuio(bank)) {
+	if (bank->method == METHOD_MPUIO) {
 		bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP16XX
-		bank->chip.dev = &omap_mpuio_device.dev;
-#endif
+		if (bank->suspend_resume_support)
+			bank->chip.dev = &omap_mpuio_device.dev;
 		bank->chip.base = OMAP_MPUIO(0);
 	} else {
 		bank->chip.label = "gpio";
@@ -1174,8 +1148,16 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank_width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank_is_mpuio(bank))
+		if (bank->method == METHOD_MPUIO) {
+			if (bank->suspend_resume_support)
+				/*
+				 * REVISIT: assuming only 16xx supports
+				 * MPUIO wake events
+				 */
+				mpuio_irq_chip.irq_set_wake = gpio_wake_enable;
+
 			irq_set_chip(j, &mpuio_irq_chip);
+		}
 		else
 			irq_set_chip(j, &gpio_irq_chip);
 		irq_set_handler(j, handle_simple_irq);
@@ -1215,11 +1197,23 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
+	bank->suspend_resume_support = pdata->suspend_resume_support;
 	bank_width = pdata->bank_width;
 
-	if (!gpio_init_done) {
-		if (cpu_class_is_omap1())
-			mpuio_init(bank);
+	if (pdata->suspend_resume_support) {
+		mpuio_init(bank);
+
+		if (!gpio_init_done) {
+			int ret = 0;
+
+			ret = omap_gpio_sysinit();
+			if (ret) {
+				dev_err(&pdev->dev,
+					"omap_gpio_sysinit failed with error"
+					" %d\n", ret);
+				return ret;
+			}
+		}
 	}
 
 	spin_lock_init(&bank->lock);
@@ -1343,6 +1337,17 @@ static struct sys_device omap_gpio_device = {
 	.cls		= &omap_gpio_sysclass,
 };
 
+static inline int omap_gpio_sysinit(void)
+{
+	int ret = 0;
+
+	ret = sysdev_class_register(&omap_gpio_sysclass);
+	if (!ret)
+		ret = sysdev_register(&omap_gpio_device);
+
+	return ret;
+}
+
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	struct gpio_bank *bank;
@@ -1408,22 +1413,3 @@ static int __init omap_gpio_drv_reg(void)
 	return platform_driver_register(&omap_gpio_driver);
 }
 postcore_initcall(omap_gpio_drv_reg);
-
-static int __init omap_gpio_sysinit(void)
-{
-	int ret = 0;
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		if (ret == 0) {
-			ret = sysdev_class_register(&omap_gpio_sysclass);
-			if (ret == 0)
-				ret = sysdev_register(&omap_gpio_device);
-		}
-	}
-#endif
-
-	return ret;
-}
-
-arch_initcall(omap_gpio_sysinit);
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 0925a6c..5a0d946 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -133,6 +133,7 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+	bool suspend_resume_support; /* True for OMAP16XX, OMAP2PLUS */
 };
 
 extern void omap2_gpio_prepare_for_idle(int off_mode);
-- 
1.7.1

