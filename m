From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv4 2/14] OMAP: dmtimer: infrastructure to support hwmod
Date: Tue, 23 Nov 2010 15:48:52 +0100
Message-ID: <4CEBD454.8070003@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com> <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab0KWOsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 09:48:55 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oANEmsDh020418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 08:48:54 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id oANEmshr015332
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 08:48:54 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id oANEmsWK026642
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 08:48:54 -0600 (CST)
In-Reply-To: <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

On 11/20/2010 3:39 AM, DebBarma, Tarun Kanti wrote:
> (1) Add new fields and data structures to support dmtimer conversion
> to platform driver.
> (2) Constants to identify IP revision so that Highlander IP in OMAP 4
> can be distinguished.
> (3) field to identify OMAP4 abe timers.
> (4) Interface function to support early boot.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> ---
>   arch/arm/mach-omap2/dmtimer.h             |   32 +++++++++++++++++++++++++++++
>   arch/arm/plat-omap/dmtimer.c              |    8 +++++++
>   arch/arm/plat-omap/include/plat/dmtimer.h |   19 +++++++++++++++++
>   3 files changed, 59 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/dmtimer.h
>
> diff --git a/arch/arm/mach-omap2/dmtimer.h b/arch/arm/mach-omap2/dmtimer.h
> new file mode 100644
> index 0000000..4d4493b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.h
> @@ -0,0 +1,32 @@
> +/**
> + * OMAP Dual-Mode Timers - early initialization interface
> + *
> + * function interface called first to start dmtimer early initialization.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * Tarun Kanti DebBarma<tarun.kanti@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated
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
> +#ifndef __ASM_ARCH_DMTIMER_H
> +#define __ASM_ARCH_DMTIMER_H
> +
> +/*
> + * dmtimer is required during early part of boot sequence even before
> + * device model and pm_runtime if fully up and running. this function
> + * provides hook to omap2_init_common_hw() which is triggered from
> + * start_kernel()->init_irq() of kernel initialization sequence.
> + */
> +void __init omap2_dm_timer_early_init(void);
> +
> +#endif
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 1d706cf..10daa9d 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -3,6 +3,12 @@
>    *
>    * OMAP Dual-Mode Timers
>    *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * Tarun Kanti DebBarma<tarun.kanti@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated
> + * Thara Gopinath<thara@ti.com>

You can remove the copyright and put Thara's name below yours.
It should be the case for other field as well.

> + *
>    * Copyright (C) 2005 Nokia Corporation
>    * OMAP2 support by Juha Yrjola
>    * API improvements and OMAP2 clock framework support by Timo Teras
> @@ -151,6 +157,7 @@
>   		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR<<  WPSHIFT))
>
>   struct omap_dm_timer {
> +	int id;
>   	unsigned long phys_base;
>   	int irq;
>   #ifdef CONFIG_ARCH_OMAP2PLUS
> @@ -160,6 +167,7 @@ struct omap_dm_timer {
>   	unsigned reserved:1;
>   	unsigned enabled:1;
>   	unsigned posted:1;
> +	struct platform_device *pdev;
>   };

What that structure is used for? Is it some legacy structure that will 
be removed in next patches? It seems to be a wrapper on top of the 
device that should not be used anymore after platform_driver migration.

>
>   static int dm_timer_count;
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index dfa3aff..2bb837e 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -3,6 +3,11 @@
>    *
>    * OMAP Dual-Mode Timers
>    *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * Tarun Kanti DebBarma<tarun.kanti@ti.com>
> + * Thara Gopinath<thara@ti.com>

Add a blank line here.

> + * Platform device conversion and hwmod support.
> + *
>    * Copyright (C) 2005 Nokia Corporation
>    * Author: Lauri Leukkunen<lauri.leukkunen@nokia.com>
>    * PWM and clock framwork support by Timo Teras.
> @@ -29,6 +34,8 @@
>   #ifndef __ASM_ARCH_DMTIMER_H
>   #define __ASM_ARCH_DMTIMER_H
>
> +#include<linux/platform_device.h>
> +
>   /* clock sources */
>   #define OMAP_TIMER_SRC_SYS_CLK			0x00
>   #define OMAP_TIMER_SRC_32_KHZ			0x01
> @@ -44,11 +51,23 @@
>   #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
>   #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPAR	0x02
>
> +/* timer ip constants */

Maybe you should have a better comment here?
Something closer to your changelog: IP revision identifier so that 
Highlander IP in OMAP 4 can be distinguished.

> +#define OMAP_TIMER_IP_VERSION_1			0x1
> +#define OMAP_TIMER_IP_VERSION_2			0x2
> +
>   struct omap_dm_timer;
>   extern struct omap_dm_timer *gptimer_wakeup;
>   extern struct sys_timer omap_timer;
>   struct clk;
>
> +struct dmtimer_platform_data {
> +	int (*set_timer_src) (struct platform_device *pdev, int source);
> +	int timer_ip_type;
> +	u8 func_offst;
> +	u8 intr_offst;

You can probably keep "offset" since you save only one character...

Regards,
Benoit

> +	u32 is_early_init:1;
> +};
> +
>   int omap_dm_timer_init(void);
>
>   struct omap_dm_timer *omap_dm_timer_request(void);

