From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 2/7] OMAP4: Create board support for
	OMAP_4430SDP.
Date: Sat, 16 May 2009 10:27:07 +0100
Message-ID: <20090516092707.GF15328@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33289 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbZEPJ1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:27:16 -0400
Content-Disposition: inline
In-Reply-To: <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, May 07, 2009 at 11:59:11AM +0530, Santosh Shilimkar wrote:
> This patch creates the bare minimal board files  to support
> OMAP_4430SDP. Additinaly new omap44xx.h is created which contains
> the base addresses for OMAP4430.File omap34xx.h is adapted to avoid

A space after a full stop (after "OMAP4430.") would be nice.

> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> new file mode 100644
> index 0000000..157e9e4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -0,0 +1,91 @@
> +/*
> + * Board support file for OMAP4430 SDP.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * Based on mach-omap2/board-3430sdp.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/gpio.h>

Please use linux/gpio.h instead.

> +#include <mach/board.h>
> +#include <mach/common.h>
> +#include <mach/control.h>
> +#include <asm/hardware/gic.h>
> +
> +static struct platform_device sdp4430_lcd_device = {
> +	.name		= "sdp4430_lcd",
> +	.id		= -1,
> +};
> +
> +static struct platform_device *sdp4430_devices[] __initdata = {
> +	&sdp4430_lcd_device,
> +};
> +
> +static struct omap_uart_config sdp4430_uart_config __initdata = {
> +	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),

Additional parens not required.
	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
would be sufficient.

> +};
> +
> +static struct omap_lcd_config sdp4430_lcd_config __initdata = {
> +	.ctrl_name	= "internal",
> +};
> +
> +static struct omap_board_config_kernel sdp4430_config[] __initdata = {
> +	{ OMAP_TAG_UART,	&sdp4430_uart_config },
> +	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
> +};
> +
> +static void __init gic_init_irq(void)
> +{
> +	gic_dist_init(0, IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
> +	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
> +}
> +
> +static void __init omap_4430sdp_init_irq(void)
> +{
> +	omap2_init_common_hw(NULL);
> +	gic_init_irq();
> +	omap_gpio_init();
> +}
> +
> +
> +static void __init omap_4430sdp_init(void)
> +{
> +	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
> +	omap_board_config = sdp4430_config;
> +	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
> +	omap_serial_init();
> +

Needless blank line.

> diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
> new file mode 100644
> index 0000000..fb3c1b4
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/omap44xx.h
> @@ -0,0 +1,61 @@
> +/*
> + * Address mappings and base address for OMAP4 interconnects
> + * and peripherals.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_ARCH_OMAP44XX_H
> +#define __ASM_ARCH_OMAP44XX_H
> +
> +/*
> + * Please place only base defines here and put the rest in device
> + * specific headers.
> + */
> +#define L4_44XX_BASE			0x4A000000
> +#define L4_WK_44XX_BASE			0x4A300000
> +#define L4_PER_44XX_BASE		0x48000000
> +#define L4_EMU_44XX_BASE		0x54000000
> +#define L3_44XX_BASE			0x44000000
> +#define OMAP4430_32KSYNCT_BASE		0x4A304000
> +#define OMAP4430_CM_BASE		0x4A004000
> +#define OMAP4430_PRM_BASE		0x48306000
> +#define OMAP44XX_GPMC_BASE		0x50000000
> +#define OMAP443X_SCM_BASE		0x4A002000
> +#define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
> +#define OMAP44XX_IC_BASE		0x48200000
> +#define OMAP44XX_IVA_INTC_BASE		0x40000000
> +#define IRQ_SIR_IRQ			0x0040
> +#define	OMAP44XX_GIC_DIST_BASE		0x48241000

Can we have the use of tabs vs spaces consistent here (preferably one
space after #define) ?

> +#define OMAP44XX_GIC_CPU_BASE		0x48240100
> +#define	OMAP44XX_VA_GIC_CPU_BASE	IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)

Ditto.

> +#define OMAP44XX_SCU_BASE		0x48240000
> +#define OMAP44XX_VA_SCU_BASE		IO_ADDRESS(OMAP44XX_SCU_BASE)
> +#define OMAP44XX_LOCAL_TWD_BASE		0x48240600
> +#define OMAP44XX_VA_LOCAL_TWD_BASE	IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
> +#define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
> +#define OMAP44XX_WKUPGEN_BASE		0x48281000
> +#define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
> +
> +/* Common macros between OMAPs */
> +
> +#if defined(CONFIG_ARCH_OMAP4)
> +
> +#define L4_WK_OMAP_BASE			L4_WK_44XX_BASE
> +#define L4_PER_OMAP_BASE		L4_PER_44XX_BASE
> +#define L4_EMU_BASE			L4_EMU_44XX_BASE
> +#define L3_OMAP_BASE			L3_44XX_BASE
> +#define OMAP2_32KSYNCT_BASE		OMAP4430_32KSYNCT_BASE
> +#define OMAP2_CM_BASE			OMAP4430_CM_BASE
> +#define OMAP2_PRM_BASE			OMAP4430_PRM_BASE
> +#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP44XX_IC_BASE)
> +
> +#endif
> +
> +#endif /* __ASM_ARCH_OMAP44XX_H */
> +
