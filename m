From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 14:28:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F29C@dbde02.ent.ti.com>
References: <20100401072324.GD16297@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47636 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab0DAI6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 04:58:13 -0400
In-Reply-To: <20100401072324.GD16297@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>



> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, April 01, 2010 12:53 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com
> Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio device
> 
> On Wed, Mar 31, 2010 at 02:23:53PM +0200, ext Charulatha V wrote:
> >This patch adds support for implementing OMAP3 GPIO as an
> >early platform device and adds gpio_init specific to OMAP3
> >
> >This patch adds device structures for each GPIO device in
> >OMAP3 architecture. These strutures are not created in a
> >separate *_data.c file because these structures would be
> >removed once the driver gets adapted to HWMOD way.
> >
> >Signed-off-by: Charulatha V <charu@ti.com>
> >---
> > arch/arm/mach-omap2/gpio3xxx.c          |  351 +++++++++++++++++++++++++++++++
> > arch/arm/mach-omap2/include/mach/gpio.h |   13 +-
> > 2 files changed, 363 insertions(+), 1 deletions(-)
> > create mode 100644 arch/arm/mach-omap2/gpio3xxx.c
> >
> >diff --git a/arch/arm/mach-omap2/gpio3xxx.c b/arch/arm/mach-omap2/gpio3xxx.c
> >new file mode 100644
> >index 0000000..8f404e7
> >--- /dev/null
> >+++ b/arch/arm/mach-omap2/gpio3xxx.c
> >@@ -0,0 +1,351 @@
> >+/*
> >+ * gpio3xxx.c - OMAP3-specific gpio code
> >+ *
> >+ * Copyright (C) 2010 Texas Instruments, Inc.
> >+ *
> >+ * Author:
> >+ *	Charulatha V <charu@ti.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2 as
> >+ * published by the Free Software Foundation.
> >+ */
> >+
> >+#include <plat/gpio.h>
> >+
> >+/*
> >+ * OMAP3 GPIO reg offsets
> >+ */
> >+static struct gpio_reg_offset omap3_gpio_reg = {
> >+	.data_in	= OMAP24XX_GPIO_DATAIN,
> >+	.data_out	= OMAP24XX_GPIO_DATAOUT,
> >+	.data_out_set	= OMAP24XX_GPIO_SETDATAOUT,
> >+	.data_out_clear	= OMAP24XX_GPIO_CLEARDATAOUT,
> >+	.dir_ctrl	= OMAP24XX_GPIO_OE,
> >+	.irq_status0	= OMAP24XX_GPIO_IRQSTATUS1,
> >+	.irq_status1	= OMAP24XX_GPIO_IRQSTATUS2,
> >+	.irq_mask	= OMAP24XX_GPIO_IRQENABLE1,
> >+	.irq_set	= OMAP24XX_GPIO_SETIRQENABLE1,
> >+	.irq_clear	= OMAP24XX_GPIO_CLEARIRQENABLE1,
> >+	.irq_mask_bits	= 0xffffffff,
> >+	.irq_inv	= 0,
> >+	.wkup_enable	= OMAP24XX_GPIO_WAKE_EN,
> >+	.wkup_clear	= OMAP24XX_GPIO_CLEARWKUENA,
> >+	.wkup_set	= OMAP24XX_GPIO_SETWKUENA,
> >+	.debounce_ena	= OMAP24XX_GPIO_DEBOUNCE_EN,
> >+	.debounce_val	= OMAP24XX_GPIO_DEBOUNCE_VAL,
> >+	.ctrl		= OMAP24XX_GPIO_CTRL,
> >+	.syscfg		= OMAP24XX_GPIO_SYSCONFIG,
> >+	.leveldetect0	= OMAP24XX_GPIO_LEVELDETECT0,
> >+	.leveldetect1	= OMAP24XX_GPIO_LEVELDETECT1,
> >+	.rise_detect	= OMAP24XX_GPIO_RISINGDETECT,
> >+	.fall_detect	= OMAP24XX_GPIO_FALLINGDETECT,
> >+	.rev_reg	= OMAP24XX_GPIO_REVISION,
> >+};
> >+
> >+/*
> >+ * OMAP3 GPIO1 interface data
> >+ */
> >+static struct __initdata resource omap3_gpio1_resources[] = {
> >+	{
> >+		.start	= OMAP34XX_GPIO1_BASE,
> >+		.end	= OMAP34XX_GPIO1_BASE + OMAP3_GPIO_AS_LEN - 1,
> 
> OMAP34XX_GPIO1_BASE + SZ_4K - 1
> 
> >+		.flags	= IORESOURCE_MEM,
> >+	},
> >+	{
> >+		.start	= INT_34XX_GPIO_BANK1,
> >+		.flags	= IORESOURCE_IRQ,
> >+	},
> >+};
> >+
> >+static struct __initdata omap_gpio_platform_data omap3_gpio1_config = {
> >+	.ick_name = "gpio1_ick",
> >+	.dbck_name = "gpio1_dbck",
> 
> do not pass clock names. Update the clkdev entries clk*_data.c

Agreed. These patches are in preparation for HWMOD. Once GPIO driver gets
adapted to HWMOD, this would be removed.

> 
> >+int __init omap3_early_init_gpio(struct platform_device ***pdev)
> 
> I don't see the point in passing ***pdev.

It is required to get the early init device structure which is SoC specific.

> 
> >+int __init omap3_gpio_dev_reg(void)
> >+{
> >+	if (cpu_is_omap34xx()) {
> >+		platform_device_register(&omap3_gpio1);
> >+		platform_device_register(&omap3_gpio2);
> >+		platform_device_register(&omap3_gpio3);
> >+		platform_device_register(&omap3_gpio4);
> >+		platform_device_register(&omap3_gpio5);
> >+		platform_device_register(&omap3_gpio6);
> >+	}
> 
> platform_add_devices(omap3_gpio_early_dev,
> 		ARRAY_SIZE(omap3_gpio_early_dev);
> 
> --
> balbi
