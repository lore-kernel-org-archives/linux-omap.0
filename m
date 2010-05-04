From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add support for OMAP3Stalker boards
Date: Tue, 4 May 2010 15:59:52 -0700
Message-ID: <20100504225952.GQ29604@atomide.com>
References: <000501cabadc$711651a0$5342f4e0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55989 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934539Ab0EDW7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 18:59:55 -0400
Content-Disposition: inline
In-Reply-To: <000501cabadc$711651a0$5342f4e0$@com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason <lzg@ema-tech.com>
Cc: linux-omap@vger.kernel.org

Hi,

Sorry for the delay in replying. Few comments, see below.

* Jason <lzg@ema-tech.com> [100303 06:16]:
> This patche add omap3 board support for the EMA-Tech StalkerBoards. Base on
> TI's EVM. 

<snip> 

> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -82,6 +82,26 @@ config MACH_OMAP3517EVM
>  	depends on ARCH_OMAP3
>  	select OMAP_PACKAGE_CBB
> 
> +config MACH_SBC3530
> +	bool "OMAP3 SBC STALKER board"
> +	depends on ARCH_OMAP3
> +
> +choice
> +	prompt STALKER_BOARD_TYPE
> +	depends on MACH_SBC3530
> +	default STALKER_EVM
> +
> +config STALKER_BOARD_TYPE_EVM
> +	bool "Stalker EVM board"
> +	help
> +	  Select this option if you have a Stalker EVM board
> +
> +config STALKER_BOARD_TYPE_LK_S
> +	bool "Stalker LK-S board"
> +	help
> +	  Select this option if you have a Stalker LK-S board
> +endchoice
> +
>  config MACH_OMAP3_PANDORA
>  	bool "OMAP3 Pandora"
>  	depends on ARCH_OMAP3

Things like this are best done by looking at the ATAG_REVISION passed by
the bootloader. Then you can dynamically initialize the platform data
based on the revision.

> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -0,0 +1,922 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-omap3evm.c
> + *
> + * Copyright (C) 2008 Guangzhou EMA-Tech
> + *
> + * Modified from mach-omap2/board-omap3evm.c
> + *
> + * Initial code: Syed Mohammed Khasim
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/leds.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/usb/otg.h>
> +#if defined(CONFIG_STALKER_BOARD_TYPE_EVM)
> +#include <linux/dm9000.h>
> +#elif defined(CONFIG_STALKER_BOARD_TYPE_LK_S)

We should not ifdef includes, it should be OK to include them automatically.

> +#include <linux/smsc911x.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c/at24.h>
> +#endif
> +
> +#include <linux/regulator/machine.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
> +
> +#include <plat/board.h>
> +#include <plat/mux.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>
> +#include <plat/usb.h>
> +#include <plat/common.h>
> +#include <plat/control.h>
> +#include <plat/mcspi.h>
> +#include <plat/clock.h>
> +#include <plat/omap-pm.h>
> +#include <plat/display.h>
> +#include <plat/timer-gp.h>
> +
> +#include "mux.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +#include "hsmmc.h"
> +#include "pm.h"

That's a lot of include files, are they all needed?

> +static struct mtd_partition omap3stalker_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +	 .name = "X-Loader",
> +	 .offset = 0,
> +	 .size = 4 * (SZ_128K),
> +	 .mask_flags = MTD_WRITEABLE,
> +	 },
> +	{
> +	 .name = "U-Boot",
> +	 .offset = MTDPART_OFS_APPEND,
> +	 .size = 15 * (SZ_128K),
> +	 .mask_flags = MTD_WRITEABLE,
> +	 },
> +	{
> +	 .name = "U-Boot Env",
> +	 .offset = MTDPART_OFS_APPEND,
> +	 .size = 1 * (SZ_128K)},
> +	{
> +	 .name = "Kernel",
> +	 .offset = MTDPART_OFS_APPEND,
> +	 .size = 32 * (SZ_128K)},
> +	{
> +	 .name = "File System",
> +	 .size = MTDPART_SIZ_FULL,
> +	 .offset = MTDPART_OFS_APPEND,
> +	 },
> +};

Please use tabs instead of spaces.

> +void __init omap3stalker_flash_init(void)
> +{
> +	u8 cs = 0;
> +	u8 nandcs = GPMC_CS_NUM + 1;
> +	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;

Please leave out the NAND stuff for now, we need to first fix the
NAND driver before adding more of the OMAP34XX_GPMC_VIRT..

> +static struct resource omap3stalker_smsc911x_resources[] = {
> +	[0] = {
> +	       .start = OMAP3STALKER_ETHR_START,
> +	       .end =
> +	       (OMAP3STALKER_ETHR_START + OMAP3STALKER_ETHR_SIZE - 1),
> +	       .flags = IORESOURCE_MEM,
> +	       },
> +	[1] = {
> +	       .start = OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
> +	       .end = OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
> +	       .flags = (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
> +	       },
> +};

Please use tabs here too instead of spaces.

> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +	 .mmc = 1,
> +	 .wires = 4,
> +	 .gpio_cd = -EINVAL,
> +	 .gpio_wp = 23,
> +	 },
> +	{}			/* Terminator */
> +};
> +
> +#if defined(CONFIG_STALKER_BOARD_TYPE_LK_S)
> +static struct gpio_keys_button gpio_buttons[] = {
> +	{
> +	 .code = BTN_EXTRA,
> +	 .gpio = 18,
> +	 .desc = "user",
> +	 .wakeup = 1,
> +	 },
> +};

Here too.

> +	.irq_base = TWL4030_IRQ_BASE,
> +	.irq_end = TWL4030_IRQ_END,
> +
> +	/* platform_data for children goes here */
> +	.keypad = &omap3stalker_kp_data,
> +	.madc = &omap3stalker_madc_data,
> +	.usb = &omap3stalker_usb_data,
> +	.gpio = &omap3stalker_gpio_data,
> +	.codec = &omap3stalker_codec_data,
> +	.vdac = &omap3_stalker_vdac,
> +	.vpll2 = &omap3_stalker_vpll2,
> +};

Please align with tabs:

	.keypad		= &omap3stalker_kp_data,
	.madc		= &omap3stalker_madc_data,

> +static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo[] = {
> +	{
> +	 I2C_BOARD_INFO("twl4030", 0x48),
> +	 .flags = I2C_CLIENT_WAKE,
> +	 .irq = INT_34XX_SYS_NIRQ,
> +	 .platform_data = &omap3stalker_twldata,
> +	 },
> +};

Tabify

> +#ifdef CONFIG_STALKER_BOARD_TYPE_LK_S
> +static struct at24_platform_data fram_info = {
> +	.byte_len = (64 * 1024) / 8,
> +	.page_size = 8192,
> +	.flags = AT24_FLAG_ADDR16 | AT24_FLAG_IRUGO,
> +};
> +
> +static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo3[] = {
> +	{
> +	 I2C_BOARD_INFO("24c64", 0x50),
> +	 .flags = I2C_CLIENT_WAKE,
> +	 .platform_data = &fram_info,
> +	 },
> +};
> +#endif

Tabify

Anyways, mostly minor stuff except for the preference for dynamic detection
of the board.

Regards,

Tony
