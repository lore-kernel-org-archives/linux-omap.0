From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: PM/serial: fix console semaphore acquire during
 suspend
Date: Tue, 7 Dec 2010 15:46:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071544210.13430@utopia.booyaka.com>
References: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32938 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab0LGWql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 17:46:41 -0500
In-Reply-To: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Two comments:

On Tue, 7 Dec 2010, Kevin Hilman wrote:

> commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
> hold console semaphore while OMAP UARTs are disabled) added use of the
> console semaphore to protect UARTs from being accessed after disabled
> during idle, but this causes problems in suspend.
> 
> During suspend, the console semaphore is already held by the time we reach
> the OMAP suspend path, so the try_acquire_console_sem() will always fail and
> suspend will be aborted.
> 
> To fix, introduce a check so the console semaphore is only attempted
> during idle, and not during suspend.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Applies to Tony's omap-fixes branch.
> 
>  arch/arm/mach-omap2/pm34xx.c |   24 ++++++++++++++++++------
>  1 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0ec8a04..122ef3c 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -50,6 +50,19 @@
>  #include "sdrc.h"
>  #include "control.h"
>  
> +#ifdef CONFIG_SUSPEND
> +static suspend_state_t suspend_state = PM_SUSPEND_ON;
> +static inline bool is_suspending(void)
> +{
> +	return (suspend_state != PM_SUSPEND_ON);
> +}
> +#else
> +static inline bool is_suspending(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  /* Scratchpad offsets */
>  #define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
>  #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
> @@ -387,10 +400,11 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Block console output in case it is on one of the OMAP UARTs */
> -	if (per_next_state < PWRDM_POWER_ON ||
> -	    core_next_state < PWRDM_POWER_ON)
> -		if (try_acquire_console_sem())
> -			goto console_still_active;
> +	if (!is_suspending())
> +		if (per_next_state < PWRDM_POWER_ON ||
> +		    core_next_state < PWRDM_POWER_ON)
> +			if (try_acquire_console_sem())
> +				goto console_still_active;

This same is_suspending() test needs to be applied to the 
release_console_sem() later in the pm34xx.c, otherwise the console 
semaphore will be released before the Linux suspend code expects it to be.

Also, I'd assume that a similar patch to the above needs to be applied to 
pm24xx.c.


- Paul
