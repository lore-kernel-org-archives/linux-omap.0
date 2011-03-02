From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/17] omap4: pm: Add WakeupGen save/restore support
Date: Wed, 02 Mar 2011 14:34:40 -0800
Message-ID: <87k4gh40e7.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-10-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54641 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932097Ab1CBWep (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 17:34:45 -0500
Received: by yic15 with SMTP id 15so201154yic.22
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 14:34:43 -0800 (PST)
In-Reply-To: <1298112158-28469-10-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> WakeupGen is lost only when device hits off-mode. Though the register
> context is retained in MPUSS OFF/OSWR state, hardware recommondation is
> to save/restore WakeupGen along with GIC to have consistent interrupt
> state at both the blocks. The ROM code restore mechinism also does
> restore of wakeupgen on mpu OFF/OSWR

Changelog needs some clarification...

The way I read the above is that "save is not needed, but we do it
anyways for consistency"

It's not terribly clear (to me) how "consistent state" would be lost
if this does not happen.

IOW, describing a potential inconsistent state would be helpful for the
changelog (and code.)

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    1 +
>  arch/arm/mach-omap2/omap-wakeupgen.c              |   74 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap4-mpuss-lowpower.c        |    2 +
>  arch/arm/mach-omap2/omap4-sar-layout.h            |   11 +++
>  4 files changed, 88 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> index f10d106..66f31c3 100644
> --- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> +++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> @@ -37,4 +37,5 @@
>  
>  extern int __init omap_wakeupgen_init(void);
>  extern void omap_wakeupgen_irqmask_all(unsigned int cpu, unsigned int set);
> +extern void omap_wakeupgen_save(void);
>  #endif
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index e26a0ed..0f0a5ed 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -24,6 +24,9 @@
>  #include <asm/hardware/gic.h>
>  
>  #include <mach/omap-wakeupgen.h>
> +#include <mach/omap4-common.h>
> +
> +#include "omap4-sar-layout.h"
>  
>  #define NR_BANKS		4
>  #define MAX_IRQS		128
> @@ -54,6 +57,11 @@ static inline void cpu_writel(u32 val, u8 idx, u32 cpu)
>  				(cpu * CPU_ENA_OFFSET) + (idx * 4));
>  }
>  
> +static inline void sar_writel(u32 val, u32 offset, u8 idx)
> +{
> +	__raw_writel(val, sar_ram_base + offset + (idx * 4));
> +}
> +

aha, another function that belongs in the SAR code.

[...]

Kevin
