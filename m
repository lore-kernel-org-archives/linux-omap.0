From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM restore observability settings after off mode
Date: Tue, 13 Oct 2009 12:23:36 -0700
Message-ID: <87skdnjdxj.fsf@deeprootsystems.com>
References: <1255359790-10407-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:58188 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbZJMTYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:24:15 -0400
Received: by pxi10 with SMTP id 10so169478pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:23:38 -0700 (PDT)
In-Reply-To: <1255359790-10407-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 12 Oct 2009 18\:03\:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch restores the observability settings after resuming from off mode.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Thanks, pulling this into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/debobs.c             |    9 +++++++++
>  arch/arm/mach-omap2/pm34xx.c             |    4 ++++
>  arch/arm/plat-omap/include/mach/debobs.h |    1 +
>  3 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/debobs.c b/arch/arm/mach-omap2/debobs.c
> index 4fbabef..d25b9a2 100644
> --- a/arch/arm/mach-omap2/debobs.c
> +++ b/arch/arm/mach-omap2/debobs.c
> @@ -190,6 +190,15 @@ static inline int __init _new_debobs_pad(struct debobs_pad *pad, char *name,
>  
>  /* Public functions */
>  
> +void debobs_restore(void)
> +{
> +	struct debobs_pad *p = &debobs_pads[0];
> +	int i;
> +
> +	for (i = 0; i < NUM_OF_DEBOBS_PADS; i++, p++)
> +		debobs_set(&p->core_obs, p->core_obs.value);
> +}
> +
>  void debug_gpio_set(unsigned gpio, int value)
>  {
>  	if (!debobs_initialized)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 553fe02..20c7ea2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -42,6 +42,7 @@
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
>  #include <mach/dma.h>
> +#include <mach/debobs.h>
>  #include <asm/tlbflush.h>
>  
>  #include "cm.h"
> @@ -124,6 +125,9 @@ static void omap3_core_restore_context(void)
>  	/* Restore the interrupt controller context */
>  	omap3_intc_restore_context();
>  	omap_dma_global_context_restore();
> +	/* restore debobs context */
> +	debobs_restore();
> +
>  }
>  
>  static void omap3_save_secure_ram_context(u32 target_mpu_state)
> diff --git a/arch/arm/plat-omap/include/mach/debobs.h b/arch/arm/plat-omap/include/mach/debobs.h
> index 67f765d..1e04bcd 100644
> --- a/arch/arm/plat-omap/include/mach/debobs.h
> +++ b/arch/arm/plat-omap/include/mach/debobs.h
> @@ -3,5 +3,6 @@
>  
>  void debug_gpio_set(unsigned gpio, int value);
>  int debug_gpio_get(unsigned gpio);
> +void debobs_restore(void);
>  
>  #endif
> -- 
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
