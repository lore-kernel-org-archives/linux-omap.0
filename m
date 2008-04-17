From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 3/4] Adding support for OMAP3 Beagle Board
Date: Thu, 17 Apr 2008 16:32:06 +0200
Message-ID: <48075F66.8020408@googlemail.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:10322 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbYDQOcO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:32:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so57101nfb.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 07:32:10 -0700 (PDT)
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org, Koen Kooi <k.kooi@student.utwente.nl>

Syed Mohammed, Khasim wrote:
> Adding support for OMAP3 Beagle Board
> 
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig                   |    4 +
>  arch/arm/mach-omap2/Makefile                  |    1
>  arch/arm/mach-omap2/board-omap3beagle.c       |   79 ++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/board-omap3beagle.h |   53 +++++++++++++++++
>  include/asm-arm/arch-omap/hardware.h          |    4 +
>  5 files changed, 141 insertions(+)
> 
> Index: my_branch/arch/arm/mach-omap2/Kconfig
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-16 14:41:28.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-16 14:45:38.000000000 +0530
> @@ -109,3 +109,7 @@
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +
> +config MACH_OMAP3_BEAGLE
> +	bool "OMAP3 BEAGLE board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> Index: my_branch/arch/arm/mach-omap2/Makefile
> ===================================================================
> --- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-16 14:41:28.000000000 +0530
> +++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-16 14:45:38.000000000 +0530
> @@ -35,6 +35,7 @@
>  					   board-3430sdp-usb.o \
>  					   board-3430sdp-flash.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
> +obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
>  					   board-apollon-mmc.o	\
>  					   board-apollon-keys.o
> 
> Index: my_branch/arch/arm/mach-omap2/board-omap3beagle.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ my_branch/arch/arm/mach-omap2/board-omap3beagle.c	2008-04-16 14:45:52.000000000 +0530
> @@ -0,0 +1,79 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-omap3beagle.c
> + *
> + * Copyright (C) 2008 Texas Instruments
> + *
> + * Modified from mach-omap2/board-3430sdp.c
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
> +#include <linux/io.h>
> +
> +#include <asm/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/board.h>
> +#include <asm/arch/common.h>
> +
> +static struct omap_uart_config omap3_beagle_uart_config __initdata = {
> +	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> +};
> +
> +static int __init omap3_beagle_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 2600, NULL, 0);
> +	omap_register_i2c_bus(2, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	return 0;
> +}
> +
> +static void __init omap3_beagle_init_irq(void)
> +{
> +	omap2_init_common_hw();
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
> +	{OMAP_TAG_UART,	&omap3_beagle_uart_config },
> +};
> +
> +static void __init omap3_beagle_init(void)
> +{
> +	omap_board_config = omap3_beagle_config;
> +	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
> +	omap_serial_init();

Do you like to add here MMC and USB init like recently proposed by 
Koen Kooi?

If I understand correctly, these patches currently won't boot on 
BeagleBoard if MMC and USB are missing?

Many thanks

Dirk
