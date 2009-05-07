From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Thu, 7 May 2009 13:46:54 -0700
Message-ID: <20090507204653.GD5593@atomide.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50967 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbZEGUrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:47:03 -0400
Content-Disposition: inline
In-Reply-To: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090507 00:29]:
> This patch adds SMP platform files support for OMAP4430SDP. TI's OMAP4430
> SOC is based on ARM Cortex-A9 SMP architecture. It's a dual core SOC
> with GIC used for interrupt handling and SCU for cache coherency.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-headsmp.S    |   49 +++++++
>  arch/arm/mach-omap2/omap-smp.c        |  238 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/scu.h |   28 ++++
>  arch/arm/plat-omap/include/mach/smp.h |   56 ++++++++
>  4 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
>  create mode 100644 arch/arm/mach-omap2/omap-smp.c
>  create mode 100644 arch/arm/plat-omap/include/mach/scu.h
>  create mode 100644 arch/arm/plat-omap/include/mach/smp.h

<snip snip>
 
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -0,0 +1,238 @@
> +/*
> + * OMAP4 SMP source file. It contains platform specific fucntions
> + * needed for the linux smp kernel.
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + *
> + * Author:
> + *      Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * Platform file needed for the OMAP4 SMP. This file is based on arm
> + * realview smp platform.
> + * * Copyright (c) 2002 ARM Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/jiffies.h>
> +#include <linux/smp.h>
> +#include <linux/io.h>
> +
> +#include <asm/cacheflush.h>
> +#include <mach/scu.h>
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +
> +/* Registers used for communicating startup information */
> +#define OMAP4_AUXCOREBOOT_REG0		(OMAP44XX_VA_WKUPGEN_BASE + 0x800)
> +#define OMAP4_AUXCOREBOOT_REG1		(OMAP44XX_VA_WKUPGEN_BASE + 0x804)
> +
> +/* FIXME: Move to a common header file */
> +extern void omap_secondary_startup(void);

How about move this to cpu.h?

Regards,

Tony
