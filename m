From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 03/12] OMAP1: dmtimer: conversion to platform
 devices
Date: Fri, 26 Aug 2011 19:56:25 +0530
Message-ID: <4E57AD11.7080406@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47660 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714Ab1HZO0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 10:26:35 -0400
Received: by mail-gx0-f169.google.com with SMTP id 23so3430867gxk.14
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 07:26:34 -0700 (PDT)
In-Reply-To: <1310731501-13078-4-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> From: Thara Gopinath<thara@ti.com>
>
> Convert OMAP1 dmtimers into a platform devices and then registers with
> device model framework so that it can be bound to corresponding driver.
>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap1/Makefile              |    2 +-
>   arch/arm/mach-omap1/timer.c               |  174 +++++++++++++++++++++++++++++
>   arch/arm/plat-omap/dmtimer.c              |   56 ++-------
>   arch/arm/plat-omap/include/plat/dmtimer.h |    8 ++
>   4 files changed, 195 insertions(+), 45 deletions(-)
>   create mode 100644 arch/arm/mach-omap1/timer.c
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 5b114d1..11c85cd 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -4,7 +4,7 @@
>
>   # Common support
>   obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
> -obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o
> +obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
>
>   obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>
> diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
> new file mode 100644
> index 0000000..980b23b
> --- /dev/null
> +++ b/arch/arm/mach-omap1/timer.c
> @@ -0,0 +1,174 @@
> +/**
> + * OMAP1 Dual-Mode Timers - platform device registration
> + *
> + * Contains first level initialization routines which internally
> + * generates timer device information and registers with linux
> + * device model. It also has low level function to chnage the timer
> + * input clock source.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
/s/2010 /2011

> + * Tarun Kanti DebBarma<tarun.kanti@ti.com>
> + * Thara Gopinath<thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +#include<linux/err.h>
> +#include<linux/slab.h>
> +#include<linux/platform_device.h>
> +
> +#include<mach/irqs.h>
> +
> +#include<plat/dmtimer.h>
> +
> +#define OMAP1610_GPTIMER1_BASE		0xfffb1400
> +#define OMAP1610_GPTIMER2_BASE		0xfffb1c00
> +#define OMAP1610_GPTIMER3_BASE		0xfffb2400
> +#define OMAP1610_GPTIMER4_BASE		0xfffb2c00
> +#define OMAP1610_GPTIMER5_BASE		0xfffb3400
> +#define OMAP1610_GPTIMER6_BASE		0xfffb3c00
> +#define OMAP1610_GPTIMER7_BASE		0xfffb7400
> +#define OMAP1610_GPTIMER8_BASE		0xfffbd400
> +
> +#define OMAP1_DM_TIMER_COUNT		8
> +
> +static int omap1_dm_timer_set_src(struct platform_device *pdev,
> +				int source)
> +{
> +	int n = (pdev->id - 1)<<  1;
> +	u32 l;
> +
> +	l = omap_readl(MOD_CONF_CTRL_1)&  ~(0x03<<  n);
> +	l |= source<<  n;
> +	omap_writel(l, MOD_CONF_CTRL_1);

Stop using omap_readl/omap_writel. Use standard readl/writel

rest looks ok to me.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh


