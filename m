From: Charulatha V <charu@ti.com>
Subject: [PATCH 3/8] OMAP2:GPIO:Add support for early platform gpio device
Date: Wed, 31 Mar 2010 17:53:54 +0530
Message-ID: <1270038239-1090-4-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555Ab0CaMT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:29 -0400
In-Reply-To: <1270038239-1090-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch adds support for implementing OMAP2 GPIO as an
early platform device and adds gpio_init specific to OMAP2

This patch adds device structures for each GPIO device in
OMAP2 architecture. These strutures are not created in a
separate *_data.c file because these structures would be
removed once the driver gets adapted to HWMOD way.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio2xxx.c          |  472 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/gpio.h |    2 +
 2 files changed, 474 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio2xxx.c

diff --git a/arch/arm/mach-omap2/gpio2xxx.c b/arch/arm/mach-omap2/gpio2xxx.c
new file mode 100644
index 0000000..830bb55
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio2xxx.c
@@ -0,0 +1,472 @@
+/*
+ * gpio2xxx.c - OMAP2-specific gpio code
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
+ * OMAP24XX GPIO reg offsets
+ */
+static struct gpio_reg_offset omap2_gpio_reg = {
+	.data_in	= OMAP24XX_GPIO_DATAIN,
+	.data_out	= OMAP24XX_GPIO_DATAOUT,
+	.data_out_set	= OMAP24XX_GPIO_SETDATAOUT,
+	.data_out_clear	= OMAP24XX_GPIO_CLEARDATAOUT,
+	.dir_ctrl	= OMAP24XX_GPIO_OE,
+	.irq_status0	= OMAP24XX_GPIO_IRQSTATUS1,
+	.irq_status1	= OMAP24XX_GPIO_IRQSTATUS2,
+	.irq_mask	= OMAP24XX_GPIO_IRQENABLE1,
+	.irq_ena2	= OMAP24XX_GPIO_IRQENABLE2,
+	.irq_set	= OMAP24XX_GPIO_SETIRQENABLE1,
+	.irq_clear	= OMAP24XX_GPIO_CLEARIRQENABLE1,
+	.irq_mask_bits	= 0xffffffff,
+	.irq_inv	= 0,
+	.wkup_enable	= OMAP24XX_GPIO_WAKE_EN,
+	.wkup_clear	= OMAP24XX_GPIO_CLEARWKUENA,
+	.wkup_set	= OMAP24XX_GPIO_SETWKUENA,
+	.debounce_ena	= OMAP24XX_GPIO_DEBOUNCE_EN,
+	.debounce_val	= OMAP24XX_GPIO_DEBOUNCE_VAL,
+	.ctrl		= OMAP24XX_GPIO_CTRL,
+	.syscfg		= OMAP24XX_GPIO_SYSCONFIG,
+	.leveldetect0	= OMAP24XX_GPIO_LEVELDETECT0,
+	.leveldetect1	= OMAP24XX_GPIO_LEVELDETECT1,
+	.rise_detect	= OMAP24XX_GPIO_RISINGDETECT,
+	.fall_detect	= OMAP24XX_GPIO_FALLINGDETECT,
+	.rev_reg	= OMAP24XX_GPIO_REVISION,
+};
+
+/*
+ * OMAP242X GPIO1 interface data
+ */
+static struct __initdata resource omap242x_gpio1_resources[] = {
+	{
+		.start	= OMAP242X_GPIO1_BASE,
+		.end	= OMAP242X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio1_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap242x_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap242x_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio1_resources),
+	.resource = omap242x_gpio1_resources,
+};
+
+/*
+ * OMAP242X GPIO2 interface data
+ */
+static struct __initdata resource omap242x_gpio2_resources[] = {
+	{
+		.start	= OMAP242X_GPIO2_BASE,
+		.end	= OMAP242X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio2_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap242x_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap242x_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio2_resources),
+	.resource = omap242x_gpio2_resources,
+};
+
+/*
+ * OMAP242X GPIO3 interface data
+ */
+static struct __initdata resource omap242x_gpio3_resources[] = {
+	{
+		.start	= OMAP242X_GPIO3_BASE,
+		.end	= OMAP242X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio3_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap242x_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap242x_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio3_resources),
+	.resource = omap242x_gpio3_resources,
+};
+
+/*
+ * OMAP242X GPIO4 interface data
+ */
+static struct __initdata resource omap242x_gpio4_resources[] = {
+	{
+		.start	= OMAP242X_GPIO4_BASE,
+		.end	= OMAP242X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio4_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap242x_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap242x_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio4_resources),
+	.resource = omap242x_gpio4_resources,
+};
+
+/*
+ * OMAP243X GPIO1 interface data
+ */
+static struct __initdata resource omap243x_gpio1_resources[] = {
+	{
+		.start	= OMAP243X_GPIO1_BASE,
+		.end	= OMAP243X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio1_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap243x_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap243x_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio1_resources),
+	.resource = omap243x_gpio1_resources,
+};
+
+/*
+ * OMAP243X GPIO2 interface data
+ */
+static struct __initdata resource omap243x_gpio2_resources[] = {
+	{
+		.start	= OMAP243X_GPIO2_BASE,
+		.end	= OMAP243X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio2_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap243x_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap243x_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio2_resources),
+	.resource = omap243x_gpio2_resources,
+};
+
+/*
+ * OMAP243X GPIO3 interface data
+ */
+static struct __initdata resource omap243x_gpio3_resources[] = {
+	{
+		.start	= OMAP243X_GPIO3_BASE,
+		.end	= OMAP243X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio3_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap243x_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap243x_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio3_resources),
+	.resource = omap243x_gpio3_resources,
+};
+
+/*
+ * OMAP243X GPIO4 interface data
+ */
+static struct __initdata resource omap243x_gpio4_resources[] = {
+	{
+		.start	= OMAP243X_GPIO4_BASE,
+		.end	= OMAP243X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio4_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap243x_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap243x_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio4_resources),
+	.resource = omap243x_gpio4_resources,
+};
+
+/*
+ * OMAP243X GPIO5 interface data
+ */
+static struct __initdata resource omap243x_gpio5_resources[] = {
+	{
+		.start	= OMAP243X_GPIO5_BASE,
+		.end	= OMAP243X_GPIO5_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio5_config = {
+	.ick_name = "gpio5_ick",
+	.fck_name = "gpio5_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+	.method	= METHOD_GPIO_OMAP2PLUS,
+};
+
+static struct __initdata platform_device omap243x_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap243x_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio5_resources),
+	.resource = omap243x_gpio5_resources,
+};
+
+static struct __initdata platform_device * omap242x_gpio_early_dev[] = {
+	&omap242x_gpio1,
+	&omap242x_gpio2,
+	&omap242x_gpio3,
+	&omap242x_gpio4
+};
+
+static struct __initdata platform_device * omap243x_gpio_early_dev[] = {
+	&omap243x_gpio1,
+	&omap243x_gpio2,
+	&omap243x_gpio3,
+	&omap243x_gpio4,
+	&omap243x_gpio5
+};
+
+static inline struct gpio_bank *omap2_get_gpio_bank(int gpio,
+					struct gpio_bank *gpio_bank)
+{
+	if (cpu_is_omap24xx())
+		return &gpio_bank[gpio >> 5];
+	BUG();
+	return NULL;
+};
+
+static int set_omap2_gpio_triggering(struct gpio_bank *bank, int gpio,
+						int trigger)
+{
+	void __iomem *base = bank->base;
+	u32 gpio_bit = 1 << gpio;
+
+	if (!cpu_is_omap24xx())
+		return -EINVAL;
+
+	MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
+				trigger & IRQ_TYPE_LEVEL_LOW);
+	MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
+				trigger & IRQ_TYPE_LEVEL_HIGH);
+	MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
+				trigger & IRQ_TYPE_EDGE_RISING);
+	MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
+				trigger & IRQ_TYPE_EDGE_FALLING);
+	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
+		if (trigger != 0)
+			__raw_writel(1 << gpio, bank->base
+					+ OMAP24XX_GPIO_SETWKUENA);
+		else
+			__raw_writel(1 << gpio, bank->base
+					+ OMAP24XX_GPIO_CLEARWKUENA);
+	} else {
+		if (trigger != 0)
+			bank->enabled_non_wakeup_gpios |= gpio_bit;
+		else
+			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
+	}
+
+	bank->level_mask =
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
+			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+
+	return 0;
+}
+
+void __init omap2_gpio_mod_init(struct gpio_bank *bank, int i)
+{
+	static const u32 non_wakeup_gpios[] = {
+		0xe203ffc0, 0x08700040
+	};
+
+	/*
+	 * Initialize interface clock ungated,
+	 * module enabled
+	 */
+	__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
+	__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
+	__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
+	__raw_writew(0x00000000, bank->base + OMAP24XX_GPIO_DEBOUNCE_EN);
+	__raw_writew(0x0, bank->base + OMAP24XX_GPIO_CTRL);
+
+	if (i < ARRAY_SIZE(non_wakeup_gpios))
+		bank->non_wakeup_gpios = non_wakeup_gpios[i];
+}
+
+/*
+ * OMAP2 GPIO function pointers, reg offset pointer and other info
+ */
+static struct omap_gpio_info omap2_gpio_data = {
+	.reg_off		= &omap2_gpio_reg,
+	.index_mask		= 0x1f,
+	.no_of_gpio		= 128,
+	.bank_bits		= 32,
+	.gpio_mod_init		= omap2_gpio_mod_init,
+	.get_gpio_bank		= omap2_get_gpio_bank,
+	.set_gpio_triggering	= set_omap2_gpio_triggering,
+};
+
+void __init omap2_gpio_init_data(void)
+{
+	if (cpu_is_omap242x())
+		omap2_gpio_data.bank_count = 4;
+	else if (cpu_is_omap243x())
+		omap2_gpio_data.bank_count = 5;
+
+	gpio_init(&omap2_gpio_data);
+}
+
+int __init omap2_early_init_gpio(struct platform_device ***pdev)
+{
+	int no_of_dev = 0;
+
+	if (cpu_is_omap242x()) {
+		*pdev = omap242x_gpio_early_dev;
+		no_of_dev = 4;
+	} else if (cpu_is_omap243x()) {
+		*pdev = omap243x_gpio_early_dev;
+		no_of_dev = 5;
+	}
+
+	return no_of_dev;
+}
+
+int __init omap2_gpio_dev_reg(void)
+{
+	if (cpu_is_omap242x()) {
+		platform_device_register(&omap242x_gpio1);
+		platform_device_register(&omap242x_gpio2);
+		platform_device_register(&omap242x_gpio3);
+		platform_device_register(&omap242x_gpio4);
+	} else if (cpu_is_omap243x()) {
+		platform_device_register(&omap243x_gpio1);
+		platform_device_register(&omap243x_gpio2);
+		platform_device_register(&omap243x_gpio3);
+		platform_device_register(&omap243x_gpio4);
+		platform_device_register(&omap243x_gpio5);
+	}
+
+	return 0;
+}
+arch_initcall(omap2_gpio_dev_reg);
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
index 07bfa0f..e822a41 100644
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -110,6 +110,8 @@
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 
+extern void omap2_gpio_init_data(void);
 extern void omap3_gpio_init_data(void);
+extern int omap2_early_init_gpio(struct platform_device ***pdev);
 extern int omap3_early_init_gpio(struct platform_device ***pdev);
 #endif
-- 
1.6.3.3

