From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/10] ARM: OMAP2/3: Add generic onenand support when
	connected to GPMC
Date: Mon, 25 May 2009 10:43:45 +0100
Message-ID: <20090525094345.GE28195@n2100.arm.linux.org.uk>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234123.12760.11671.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55424 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZEYJnv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 05:43:51 -0400
Content-Disposition: inline
In-Reply-To: <20090519234123.12760.11671.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, May 19, 2009 at 04:41:23PM -0700, Tony Lindgren wrote:
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> +	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
...
> +static void __init board_onenand_init(void)
> +{
> +	gpmc_onenand_init(&board_onenand_data);
> +}
> +
> +#endif
>  
>  void __init rx51_peripherals_init(void)
>  {
> @@ -415,5 +466,6 @@ void __init rx51_peripherals_init(void)
>  				ARRAY_SIZE(rx51_peripherals_devices));
>  	rx51_i2c_init();
>  	rx51_init_smc91x();
> +	board_onenand_init();

This breaks without onenand support.

> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> new file mode 100644
> index 0000000..712af59
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -0,0 +1,340 @@
> +/*
> + * linux/arch/arm/mach-omap2/gpmc-onenand.c
> + *
> + * Copyright (C) 2006 - 2009 Nokia Corporation
> + * Contacts:	Juha Yrjola
> + *		Tony Lindgren
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <asm/mach/flash.h>
> +#include <linux/mtd/onenand_regs.h>
> +
> +#include <linux/io.h>

linux/ includes together please (without asm/ includes mixed in).

> +static unsigned short omap2_onenand_readw(void __iomem *addr)
> +{
> +	return readw(addr);
> +}
> +
> +static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
> +{
> +	writew(value, addr);
> +}

These two are pointless.  Just use readw/writew directly.

> diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
> index 4649d30..94cde73 100644
> --- a/arch/arm/plat-omap/include/mach/onenand.h
> +++ b/arch/arm/plat-omap/include/mach/onenand.h
> @@ -9,8 +9,14 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  
> +#ifndef __ASM_ARCH_OMAP_ONENAND_H__

This provides no protection against multiple includes on its own.  You're
missing a #define of this symbol.

> +
> +#define ONENAND_SYNC_READ	(1 << 0)
> +#define ONENAND_SYNC_READWRITE	(1 << 1)
> +
>  struct omap_onenand_platform_data {
>  	int			cs;
>  	int			gpio_irq;
> @@ -18,8 +24,27 @@ struct omap_onenand_platform_data {
>  	int			nr_parts;
>  	int                     (*onenand_setup)(void __iomem *, int freq);
>  	int			dma_channel;
> +	u8			flags;
>  };
>  
> -int omap2_onenand_rephase(void);
> -
>  #define ONENAND_MAX_PARTITIONS 8
> +
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> +	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> +
> +extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
> +
> +#else
> +
> +#define board_onenand_data	NULL
> +
> +static inline void board_onenand_init(void)
> +{
> +}

Eww, you put it in a different file.  Disgusting.  Please put it in the
_same_ file as the place it's used.

> +
> +static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
> +{
> +}
> +
> +#endif
> +#endif
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
