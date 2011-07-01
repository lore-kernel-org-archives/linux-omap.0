From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address
 with offset macros
Date: Fri, 1 Jul 2011 03:39:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010337120.27025@utopia.booyaka.com>
References: <1309189641-25010-1-git-send-email-b-cousson@ti.com> <1309189641-25010-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35080 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab1GAJkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:40:00 -0400
In-Reply-To: <1309189641-25010-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

Hi

On Mon, 27 Jun 2011, Benoit Cousson wrote:

> The CLKCTRL register was accessed using an absolute address.
> The usage of hardcoded macros to calculate virtual address from physical
> one should be avoided as much as possible.
> The usage of a offset will allow future improvement like migration from
> the current architecture code toward a module driver.

one minor comment below:

> 
> Update cm_xxx accessor, move definition to the proper header file and
> update copyrights.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cm44xx.h                 |    3 +-
>  arch/arm/mach-omap2/cminst44xx.c             |   23 +++-
>  arch/arm/mach-omap2/cminst44xx.h             |    4 +-
>  arch/arm/mach-omap2/omap_hwmod.c             |   10 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  182 ++++++++++++++++---------
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
>  6 files changed, 145 insertions(+), 79 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
> index 0b87ec8..cdda756 100644
> --- a/arch/arm/mach-omap2/cm44xx.h
> +++ b/arch/arm/mach-omap2/cm44xx.h
> @@ -1,7 +1,7 @@
>  /*
>   * OMAP4 Clock Management (CM) definitions
>   *
> - * Copyright (C) 2007-2009 Texas Instruments, Inc.
> + * Copyright (C) 2007-2011 Texas Instruments, Inc.
>   * Copyright (C) 2007-2009 Nokia Corporation
>   *
>   * Written by Paul Walmsley
> @@ -26,7 +26,6 @@
>  /* Function prototypes */
>  # ifndef __ASSEMBLER__
>  
> -extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
>  
>  # endif
>  #endif
> diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
> index a482bfa..1df740e 100644
> --- a/arch/arm/mach-omap2/cminst44xx.c
> +++ b/arch/arm/mach-omap2/cminst44xx.c
> @@ -2,6 +2,7 @@
>   * OMAP4 CM instance functions
>   *
>   * Copyright (C) 2009 Nokia Corporation
> + * Copyright (C) 2011 Texas Instruments, Inc.
>   * Paul Walmsley
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -199,9 +200,20 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
>   *
>   */
>  
> +static u32 _clkctrl_idlest(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)

Maybe call this _read_clkctrl_idlest() to identify what it's doing?


- Paul
