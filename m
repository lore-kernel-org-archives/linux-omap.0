From: Charulatha V <charu@ti.com>
Subject: [PATCH 6/8] OMAP1:GPIO:Support for OMAP1 specific gpio
Date: Wed, 31 Mar 2010 17:53:57 +0530
Message-ID: <1270038239-1090-7-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53193 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932585Ab0CaMTb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:31 -0400
In-Reply-To: <1270038239-1090-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP1 specific GPIO operations
including gpio_init

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio.c |  404 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 404 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio.c

diff --git a/arch/arm/mach-omap1/gpio.c b/arch/arm/mach-omap1/gpio.c
new file mode 100644
index 0000000..e54ce07
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio.c
@@ -0,0 +1,404 @@
+/*
+ * gpio.c - OMAP1 architecture specific common gpio code
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Charulatha V <charu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <plat/gpio.h>
+
+static struct gpio_bank omap1610_gpio_bank[5] = {
+	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP1610_GPIO1_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO2_BASE, NULL, INT_1610_GPIO_BANK2, IH_GPIO_BASE + 16,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO3_BASE, NULL, INT_1610_GPIO_BANK3, IH_GPIO_BASE + 32,
+		METHOD_GPIO_1610 },
+	{ OMAP1610_GPIO4_BASE, NULL, INT_1610_GPIO_BANK4, IH_GPIO_BASE + 48,
+		METHOD_GPIO_1610 },
+};
+
+static struct gpio_bank omap1510_gpio_bank[2] = {
+	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP1510_GPIO_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_1510 }
+};
+
+static struct gpio_bank omap7xx_gpio_bank[7] = {
+	{ OMAP1_MPUIO_VBASE, NULL, INT_7XX_MPUIO, IH_MPUIO_BASE,
+		METHOD_MPUIO },
+	{ OMAP7XX_GPIO1_BASE, NULL, INT_7XX_GPIO_BANK1, IH_GPIO_BASE,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO2_BASE, NULL, INT_7XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO3_BASE, NULL, INT_7XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO4_BASE, NULL, INT_7XX_GPIO_BANK4,  IH_GPIO_BASE + 96,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO5_BASE, NULL, INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
+		METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO6_BASE, NULL, INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
+		METHOD_GPIO_7XX },
+};
+
+static struct gpio_reg_offset omap1610_gpio_reg = {
+	.data_in	= OMAP1610_GPIO_DATAIN,
+	.data_out	= OMAP1610_GPIO_DATAOUT,
+	.data_out_set	= OMAP1610_GPIO_SET_DATAOUT,
+	.data_out_clear	= OMAP1610_GPIO_CLEAR_DATAOUT,
+	.dir_ctrl	= OMAP1610_GPIO_DIRECTION,
+	.irq_status0	= OMAP1610_GPIO_IRQSTATUS1,
+	.irq_mask	= OMAP1610_GPIO_IRQENABLE1,
+	.irq_set	= OMAP1610_GPIO_SET_IRQENABLE1,
+	.irq_clear	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
+	.irq_mask_bits	= 0xffff,
+	.irq_inv	= 0,
+	.wkup_enable	= OMAP1610_GPIO_WAKEUPENABLE,
+	.wkup_clear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
+	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
+	.syscfg		= OMAP1610_GPIO_SYSCONFIG,
+};
+
+static struct gpio_reg_offset omap1510_gpio_reg = {
+	.data_in	= OMAP1510_GPIO_DATA_INPUT,
+	.data_out	= OMAP1510_GPIO_DATA_OUTPUT,
+	.dir_ctrl	= OMAP1510_GPIO_DIR_CONTROL,
+	.irq_status0	= OMAP1510_GPIO_INT_STATUS,
+	.irq_mask	= OMAP1510_GPIO_INT_MASK,
+	.irq_mask_bits	= 0xffff,
+	.irq_inv	= 1,
+	.ctrl		= OMAP1510_GPIO_PIN_CONTROL,
+};
+
+static struct gpio_reg_offset omap7xx_gpio_reg = {
+	.data_in	= OMAP7XX_GPIO_DATA_INPUT,
+	.data_out	= OMAP7XX_GPIO_DATA_OUTPUT,
+	.dir_ctrl	= OMAP7XX_GPIO_DIR_CONTROL,
+	.irq_status0	= OMAP7XX_GPIO_INT_STATUS,
+	.irq_mask	= OMAP7XX_GPIO_INT_MASK,
+	.irq_mask_bits	= 0xffffffff,
+	.irq_inv	= 1,
+};
+
+static struct mpu_gpio_reg_off omap1_gpio_mpureg = {
+	.mpu_io_ctrl		= OMAP_MPUIO_IO_CNTL,
+	.mpu_data_out		= OMAP_MPUIO_OUTPUT,
+	.mpu_data_in		= OMAP_MPUIO_INPUT_LATCH,
+	.mpu_isr		= OMAP_MPUIO_GPIO_INT,
+	.mpu_irq_mask		= OMAP_MPUIO_GPIO_MASKIT,
+	.mpu_irq_mask_bits	= 0xffff,
+	.mpu_irq_inv		= 1,
+};
+
+static struct gpio_bank *omap1_get_gpio_bank(int gpio,
+				struct gpio_bank *gpio_bank)
+{
+	if (cpu_is_omap15xx()) {
+		if (OMAP_GPIO_IS_MPUIO(gpio))
+			return &gpio_bank[0];
+		return &gpio_bank[1];
+	} else if (cpu_is_omap16xx()) {
+		if (OMAP_GPIO_IS_MPUIO(gpio))
+			return &gpio_bank[0];
+		return &gpio_bank[1 + (gpio >> 4)];
+	} else if (cpu_is_omap7xx()) {
+		if (OMAP_GPIO_IS_MPUIO(gpio))
+			return &gpio_bank[0];
+		return &gpio_bank[1 + (gpio >> 5)];
+	}
+	BUG();
+	return NULL;
+}
+
+/*
+ * This only applies to chips that can't do both rising and falling edge
+ * detection at once.  For all other chips, this function is a noop.
+ */
+static void omap1_toggle_edge_triggering(struct gpio_bank *bank, int gpio)
+{
+	void __iomem *reg = bank->base;
+	u32 l = 0;
+
+	switch (bank->method) {
+	case METHOD_MPUIO:
+		reg += OMAP_MPUIO_GPIO_INT_EDGE;
+		break;
+	case METHOD_GPIO_1510:
+		reg += OMAP1510_GPIO_INT_CONTROL;
+		break;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_CONTROL;
+		break;
+	default:
+		return;
+	}
+
+	l = __raw_readl(reg);
+	if ((l >> gpio) & 1)
+		l &= ~(1 << gpio);
+	else
+		l |= 1 << gpio;
+
+	__raw_writel(l, reg);
+}
+
+static int set_omap1_gpio_triggering(struct gpio_bank *bank, int gpio,
+						int trigger)
+{
+	void __iomem *reg = bank->base;
+	u32 l = 0;
+
+	switch (bank->method) {
+	case METHOD_MPUIO:
+		reg += OMAP_MPUIO_GPIO_INT_EDGE;
+		l = __raw_readl(reg);
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
+			bank->toggle_mask |= 1 << gpio;
+		if (trigger & IRQ_TYPE_EDGE_RISING)
+			l |= 1 << gpio;
+		else if (trigger & IRQ_TYPE_EDGE_FALLING)
+			l &= ~(1 << gpio);
+		else
+			goto bad;
+		break;
+	case METHOD_GPIO_1510:
+		reg += OMAP1510_GPIO_INT_CONTROL;
+		l = __raw_readl(reg);
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
+			bank->toggle_mask |= 1 << gpio;
+		if (trigger & IRQ_TYPE_EDGE_RISING)
+			l |= 1 << gpio;
+		else if (trigger & IRQ_TYPE_EDGE_FALLING)
+			l &= ~(1 << gpio);
+		else
+			goto bad;
+		break;
+	case METHOD_GPIO_1610:
+		if (gpio & 0x08)
+			reg += OMAP1610_GPIO_EDGE_CTRL2;
+		else
+			reg += OMAP1610_GPIO_EDGE_CTRL1;
+		gpio &= 0x07;
+		l = __raw_readl(reg);
+		l &= ~(3 << (gpio << 1));
+		if (trigger & IRQ_TYPE_EDGE_RISING)
+			l |= 2 << (gpio << 1);
+		if (trigger & IRQ_TYPE_EDGE_FALLING)
+			l |= 1 << (gpio << 1);
+		if (trigger)
+			/* Enable wake-up during idle for dynamic tick */
+			__raw_writel(1 << gpio, bank->base +
+						OMAP1610_GPIO_SET_WAKEUPENA);
+		else
+			__raw_writel(1 << gpio, bank->base +
+						OMAP1610_GPIO_CLEAR_WAKEUPENA);
+		break;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_CONTROL;
+		l = __raw_readl(reg);
+		if (trigger & IRQ_TYPE_EDGE_BOTH)
+			bank->toggle_mask |= 1 << gpio;
+		if (trigger & IRQ_TYPE_EDGE_RISING)
+			l |= 1 << gpio;
+		else if (trigger & IRQ_TYPE_EDGE_FALLING)
+			l &= ~(1 << gpio);
+		else
+			goto bad;
+		break;
+	default:
+		goto bad;
+	}
+	__raw_writel(l, reg);
+	return 0;
+bad:
+	return -EINVAL;
+}
+
+#ifdef CONFIG_ARCH_OMAP16XX
+static int omap_mpuio_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(mask_reg);
+	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static int omap_mpuio_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	__raw_writel(bank->saved_wakeup, mask_reg);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static const struct dev_pm_ops omap_mpuio_dev_pm_ops = {
+	.suspend_noirq = omap_mpuio_suspend_noirq,
+	.resume_noirq = omap_mpuio_resume_noirq,
+};
+
+/* use platform_driver for this, now that there's no longer any
+ * point to sys_device (other than not disturbing old code).
+ */
+static struct platform_driver omap_mpuio_driver = {
+	.driver		= {
+		.name	= "mpuio",
+		.pm	= &omap_mpuio_dev_pm_ops,
+	},
+};
+
+static struct platform_device omap_mpuio_device = {
+	.name		= "mpuio",
+	.id		= -1,
+	.dev = {
+		.driver = &omap_mpuio_driver.driver,
+	}
+	/* could list the /proc/iomem resources */
+};
+
+void mpuio_init(void)
+{
+	platform_set_drvdata(&omap_mpuio_device, &omap1610_gpio_bank[0]);
+
+	if (platform_driver_register(&omap_mpuio_driver) == 0)
+		(void) platform_device_register(&omap_mpuio_device);
+}
+#else
+static struct platform_device omap_mpuio_device;
+void mpuio_init(void) {}
+#endif
+
+/*
+ * OMAP1 GPIO function pointers, reg offset pointer and other info
+ */
+static struct omap_gpio_info omap1_gpio_data = {
+	.get_gpio_bank		= omap1_get_gpio_bank,
+	.set_gpio_triggering	= set_omap1_gpio_triggering,
+	.toggle_edge_triggering = omap1_toggle_edge_triggering,
+	.mpu_reg		= &omap1_gpio_mpureg,
+};
+
+static void __init omap1_init_gpio(struct gpio_bank *gpio_bank)
+{
+	int i;
+	struct gpio_bank *bank;
+
+	if (cpu_is_omap15xx()) {
+		struct clk *gpio_ick;
+		gpio_ick = clk_get(NULL, "arm_gpio_ck");
+		if (IS_ERR(gpio_ick))
+			printk(KERN_ERR "Could not get arm_gpio_ck\n");
+		else
+			clk_enable(gpio_ick);
+	}
+
+	for (i = 0; i < omap1_gpio_data.bank_count; i++) {
+		bank = &gpio_bank[i];
+		spin_lock_init(&bank->lock);
+
+		/* Static mapping, never released */
+		bank->base = ioremap(bank->pbase, SZ_2K);
+		if (!bank->base) {
+			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
+			continue;
+		}
+	}
+
+	if (bank_is_mpuio(bank))
+		__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
+	else if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
+		__raw_writew(0xffff, bank->base + OMAP1510_GPIO_INT_MASK);
+		__raw_writew(0x0000, bank->base + OMAP1510_GPIO_INT_STATUS);
+	} else if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
+		__raw_writew(0x0000, bank->base + OMAP1610_GPIO_IRQENABLE1);
+		__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
+		__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
+	} else if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
+		__raw_writel(0xffffffff, bank->base + OMAP7XX_GPIO_INT_MASK);
+		__raw_writel(0x00000000, bank->base + OMAP7XX_GPIO_INT_STATUS);
+	}
+
+	if (cpu_is_omap16xx()) {
+		u32 rev;
+		/* Enable system clock for GPIO module.
+		 * The CAM_CLK_CTRL *is* really the right place.
+		 */
+		bank->chip.dev = &omap_mpuio_device.dev;
+		if (bank_is_mpuio(bank))
+			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) |
+						0x04, ULPD_CAM_CLK_CTRL);
+		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
+		printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
+					(rev >> 4) & 0x0f, rev & 0x0f);
+	}
+}
+
+static void __init omap1_gpio_init(void)
+{
+	if (cpu_is_omap16xx()) {
+		omap1_gpio_data.reg_off	= &omap1610_gpio_reg;
+		omap1_gpio_data.index_mask = 0x0f;
+		omap1_gpio_data.no_of_gpio = 64;
+		omap1_gpio_data.bank_count = 5;
+		omap1_gpio_data.bank_bits = 16;
+		omap1_gpio_data.gpio_bank = omap1610_gpio_bank;
+	} else if (cpu_is_omap15xx()) {
+		omap1_gpio_data.reg_off	= &omap1510_gpio_reg;
+		omap1_gpio_data.index_mask = 0x0f;
+		omap1_gpio_data.no_of_gpio = 16;
+		omap1_gpio_data.bank_count = 2;
+		omap1_gpio_data.bank_bits = 16;
+		omap1_gpio_data.gpio_bank = omap1510_gpio_bank;
+	} else if (cpu_is_omap7xx()) {
+		omap1_gpio_data.reg_off	= &omap7xx_gpio_reg;
+		omap1_gpio_data.index_mask = 0x1f;
+		omap1_gpio_data.no_of_gpio = 192;
+		omap1_gpio_data.bank_count = 7;
+		omap1_gpio_data.bank_bits = 32;
+		omap1_gpio_data.gpio_bank = omap7xx_gpio_bank;
+	}
+	omap1_init_gpio(omap1_gpio_data.gpio_bank);
+	gpio_init(&omap1_gpio_data);
+}
+
+/*
+ * This may get called early from board specific init
+ * for boards that have interrupts routed via FPGA.
+ */
+int __init omap_gpio_init(void)
+{
+	int i;
+	static int initialized;
+
+	if ((!initialized) && cpu_class_is_omap1()) {
+			omap1_gpio_init();
+			for (i = 0; i < omap1_gpio_data.bank_count; i++)
+				init_gpio_chip_irq(omap1_gpio_data.gpio_bank);
+
+			mpuio_init();
+	}
+	initialized = 1;
+
+	return 0;
+}
-- 
1.6.3.3

