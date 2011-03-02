From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/17] omap4: Export scu base address
Date: Wed, 02 Mar 2011 13:58:43 -0800
Message-ID: <87lj0x6v70.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59248 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757791Ab1CBV6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 16:58:48 -0500
Received: by mail-iw0-f173.google.com with SMTP id 42so433324iwl.18
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 13:58:46 -0800 (PST)
In-Reply-To: <1298112158-28469-4-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The scu base address needs to be accessed in cpu hotplug
> for power management. Hence export the same

As with previous patch, rather than export the base address itself, it
should export a helper function to get the base address

Kevin

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++++
>  arch/arm/mach-omap2/omap-smp.c                  |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 5b0270b..0e5edd8 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -26,6 +26,10 @@ extern void __iomem *l2cache_base;
>  
>  extern void __iomem *gic_dist_base_addr;
>  
> +#ifdef CONFIG_SMP
> +extern void __iomem *scu_base;
> +#endif
> +
>  extern void __init gic_init_irq(void);
>  extern void omap_smc1(u32 fn, u32 arg);
>  
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index b66cfe8..b105a29 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -26,7 +26,7 @@
>  #include <mach/omap4-common.h>
>  
>  /* SCU base address */
> -static void __iomem *scu_base;
> +void __iomem *scu_base;
>  
>  static DEFINE_SPINLOCK(boot_lock);
