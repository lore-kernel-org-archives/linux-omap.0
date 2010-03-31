From: Charulatha V <charu@ti.com>
Subject: [PATCH 4/8] OMAP4:GPIO:Add support for early platform gpio device
Date: Wed, 31 Mar 2010 17:53:55 +0530
Message-ID: <1270038239-1090-5-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45002 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566Ab0CaMT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:29 -0400
In-Reply-To: <1270038239-1090-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch adds support for implementing OMAP4 GPIO as an
early platform device and adds gpio_init specific to OMAP4

This patch adds device structures for each GPIO device in
OMAP4 architecture. These strutures are not created in a
separate *_data.c file because these structures would be
removed once the driver gets adapted to HWMOD way.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio44xx.c          |  350 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/gpio.h |    3 +-
 2 files changed, 352 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio44xx.c

diff --git a/arch/arm/mach-omap2/gpio44xx.c b/arch/arm/mach-omap2/gpio44xx.c
new file mode 100644
index 0000000..6133251
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio44xx.c
@@ -0,0 +1,350 @@
+/*
+ * gpio44xx.c - OMAP4-specific gpio code
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
+/*
+ * OMAP4 GPIO reg offsets
+ */
+static struct gpio_reg_offset omap4_gpio_reg = {
+	.data_in	= OMAP4_GPIO_DATAIN,
+	.data_out	= OMAP4_GPIO_DATAOUT,
+	.data_out_set	= OMAP4_GPIO_SETDATAOUT,
+	.data_out_clear	= OMAP4_GPIO_CLEARDATAOUT,
+	.dir_ctrl	= OMAP4_GPIO_OE,
+	.irq_status0	= OMAP4_GPIO_IRQSTATUS0,
+	.irq_status1	= OMAP4_GPIO_IRQSTATUS1,
+	.irq_mask	= OMAP4_GPIO_IRQSTATUSSET0,
+	.irq_set	= OMAP4_GPIO_IRQSTATUSSET0,
+	.irq_clear	= OMAP4_GPIO_IRQSTATUSCLR0,
+	.irq_mask_bits	= 0xffffffff,
+	.irq_inv	= 0,
+	.wkup_enable	= OMAP4_GPIO_IRQWAKEN0,
+	.wkup_clear	= OMAP4_GPIO_IRQWAKEN0,
+	.wkup_set	= OMAP4_GPIO_IRQWAKEN0,
+	.debounce_ena	= OMAP4_GPIO_DEBOUNCENABLE,
+	.debounce_val	= OMAP4_GPIO_DEBOUNCINGTIME,
+	.ctrl		= OMAP4_GPIO_CTRL,
+	.syscfg		= OMAP4_GPIO_SYSCONFIG,
+	.leveldetect0	= OMAP4_GPIO_LEVELDETECT0,
+	.leveldetect1	= OMAP4_GPIO_LEVELDETECT1,
+	.rise_detect	= OMAP4_GPIO_RISINGDETECT,
+	.fall_detect	= OMAP4_GPIO_FALLINGDETECT,
+	.rev_reg	= OMAP4_GPIO_REVISION,
+};
+
+/*
+ * OMAP4 GPIO1 interface data
+ */
+static struct __initdata resource omap4_gpio1_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO1_BASE,
+		.end	= OMAP44XX_GPIO1_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio1_config = {
+	.ick_name = "gpio1_ick",
+	.dbck_name = "gpio1_dbck",
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap4_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio1_resources),
+	.resource = omap4_gpio1_resources,
+};
+
+/*
+ * OMAP4 GPIO2 interface data
+ */
+static struct __initdata resource omap4_gpio2_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO2_BASE,
+		.end	= OMAP44XX_GPIO2_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio2_config = {
+	.ick_name = "gpio2_ick",
+	.dbck_name = "gpio2_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap4_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio2_resources),
+	.resource = omap4_gpio2_resources,
+};
+
+/*
+ * OMAP4 GPIO3 interface data
+ */
+static struct __initdata resource omap4_gpio3_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO3_BASE,
+		.end	= OMAP44XX_GPIO3_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio3_config = {
+	.ick_name = "gpio3_ick",
+	.dbck_name = "gpio3_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap4_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio3_resources),
+	.resource = omap4_gpio3_resources,
+};
+
+/*
+ * OMAP4 GPIO4 interface data
+ */
+static struct __initdata resource omap4_gpio4_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO4_BASE,
+		.end	= OMAP44XX_GPIO4_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio4_config = {
+	.ick_name = "gpio4_ick",
+	.dbck_name = "gpio4_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap4_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio4_resources),
+	.resource = omap4_gpio4_resources,
+};
+
+/*
+ * OMAP4 GPIO5 interface data
+  */
+static struct __initdata resource omap4_gpio5_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO5_BASE,
+		.end	= OMAP44XX_GPIO5_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio5_config = {
+	.ick_name = "gpio5_ick",
+	.dbck_name = "gpio5_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap4_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio5_resources),
+	.resource = omap4_gpio5_resources,
+};
+
+/*
+ * OMAP4 GPIO6 interface data
+  */
+static struct __initdata resource omap4_gpio6_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO6_BASE,
+		.end	= OMAP44XX_GPIO6_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP44XX_IRQ_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio6_config = {
+	.ick_name = "gpio6_ick",
+	.dbck_name = "gpio6_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 160,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap4_gpio6 = {
+	.name           = "omap-gpio",
+	.id             = 5,
+	.dev            = {
+		.platform_data = &omap4_gpio6_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio6_resources),
+	.resource = omap4_gpio6_resources,
+};
+
+static struct __initdata platform_device * omap4_gpio_early_dev[] = {
+	&omap4_gpio1,
+	&omap4_gpio2,
+	&omap4_gpio3,
+	&omap4_gpio4,
+	&omap4_gpio5,
+	&omap4_gpio6
+};
+
+static struct gpio_bank *omap4_get_gpio_bank(int gpio,
+				struct gpio_bank *gpio_bank)
+{
+	if (cpu_is_omap44xx())
+		return &gpio_bank[gpio >> 5];
+	BUG();
+	return NULL;
+}
+
+static int set_omap4_gpio_triggering(struct gpio_bank *bank, int gpio,
+						int trigger)
+{
+	void __iomem *base = bank->base;
+	u32 gpio_bit = 1 << gpio;
+	u32 val;
+
+	if (!cpu_is_omap44xx())
+		return -EINVAL;
+
+	MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
+				trigger & IRQ_TYPE_LEVEL_LOW);
+	MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
+				trigger & IRQ_TYPE_LEVEL_HIGH);
+	MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
+				trigger & IRQ_TYPE_EDGE_RISING);
+	MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
+				trigger & IRQ_TYPE_EDGE_FALLING);
+	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
+		if (trigger != 0)
+			__raw_writel(1 << gpio, bank->base +
+						OMAP4_GPIO_IRQWAKEN0);
+		else {
+			val = __raw_readl(bank->base + OMAP4_GPIO_IRQWAKEN0);
+			__raw_writel(val & (~(1 << gpio)), bank->base +
+						 OMAP4_GPIO_IRQWAKEN0);
+		}
+	} else {
+		if (trigger != 0)
+			bank->enabled_non_wakeup_gpios |= gpio_bit;
+		else
+			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
+	}
+
+	bank->level_mask = __raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
+				__raw_readl(bank->base +
+						OMAP4_GPIO_LEVELDETECT1);
+
+	return 0;
+}
+
+void __init omap4_gpio_mod_init(struct gpio_bank *bank, int i)
+{
+	static const u32 non_wakeup_gpios[] = {
+		0xe203ffc0, 0x08700040
+	};
+
+	__raw_writel(0xffffffff, bank->base + OMAP4_GPIO_IRQSTATUSCLR0);
+	__raw_writew(0x0015, bank->base + OMAP4_GPIO_SYSCONFIG);
+	__raw_writel(0x00000000, bank->base + OMAP4_GPIO_DEBOUNCENABLE);
+	/* Initialize interface clock ungated, module enabled */
+	__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
+
+	if (i < ARRAY_SIZE(non_wakeup_gpios))
+		bank->non_wakeup_gpios = non_wakeup_gpios[i];
+}
+
+/*
+ * OMAP4 GPIO function pointers, reg offset pointer and other info
+ */
+static struct omap_gpio_info omap4_gpio_data = {
+	.reg_off		= &omap4_gpio_reg,
+	.index_mask		= 0x1f,
+	.no_of_gpio		= 192,
+	.bank_count		= OMAP4_NR_GPIOS,
+	.bank_bits		= 32,
+	.get_gpio_bank		= omap4_get_gpio_bank,
+	.gpio_mod_init		= omap4_gpio_mod_init,
+	.set_gpio_triggering	= set_omap4_gpio_triggering,
+};
+
+void __init omap4_gpio_init_data(void)
+{
+	gpio_init(&omap4_gpio_data);
+}
+
+int __init omap4_early_init_gpio(struct platform_device ***pdev)
+{
+	*pdev = omap4_gpio_early_dev;
+	return OMAP4_NR_GPIOS;
+}
+
+int __init omap4_gpio_dev_reg(void)
+{
+	if (cpu_is_omap44xx()) {
+		platform_device_register(&omap4_gpio1);
+		platform_device_register(&omap4_gpio2);
+		platform_device_register(&omap4_gpio3);
+		platform_device_register(&omap4_gpio4);
+		platform_device_register(&omap4_gpio5);
+		platform_device_register(&omap4_gpio6);
+	}
+	return 0;
+}
+arch_initcall(omap4_gpio_dev_reg);
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
index e822a41..d2d9d17 100644
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -89,7 +89,6 @@
 #define OMAP4_GPIO_IRQWAKEN0		0x0044
 #define OMAP4_GPIO_IRQWAKEN1		0x0048
 #define OMAP4_GPIO_SYSSTATUS		0x0114
-#define OMAP4_GPIO_SYSSTATUS		0x0114
 #define OMAP4_GPIO_IRQENABLE1		0x011c
 #define OMAP4_GPIO_WAKE_EN		0x0120
 #define OMAP4_GPIO_IRQSTATUS2		0x0128
@@ -112,6 +111,8 @@
 
 extern void omap2_gpio_init_data(void);
 extern void omap3_gpio_init_data(void);
+extern void omap4_gpio_init_data(void);
 extern int omap2_early_init_gpio(struct platform_device ***pdev);
 extern int omap3_early_init_gpio(struct platform_device ***pdev);
+extern int omap4_early_init_gpio(struct platform_device ***pdev);
 #endif
-- 
1.6.3.3

