From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/6] TI816X: Create board support for TI816X_EVM
Date: Thu, 05 Aug 2010 07:32:26 -0700
Message-ID: <87bp9h2kqt.fsf@deeprootsystems.com>
References: <1280523118-25118-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49385 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933301Ab0HEOcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 10:32:42 -0400
Received: by pwj7 with SMTP id 7so83934pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 07:32:41 -0700 (PDT)
In-Reply-To: <1280523118-25118-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Sat, 31 Jul 2010 02:21:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimal support for TI816X EVM to enable kernel boot.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
> new file mode 100644
> index 0000000..2271624
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -0,0 +1,71 @@
> +/*
> + * Code for TI8168 EVM.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/flash.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/pcf857x.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/phy.h>

Looks like most of these headers are not needed for this minimal
support.  It's preferred to have a minimal set of headers here and add
them later as needed when the devices are added.

> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <plat/irqs.h>
> +#include <plat/mux.h>
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/timer-gp.h>
> +
> +static void __init ti8168_evm_init_irq(void)
> +{
> +	omap2_gp_clockevent_set_gptimer(2);

Just curious why GPT2 is used here.

> +	omap2_init_common_hw(NULL, NULL);
> +	omap_init_irq();
> +}

Kevin
