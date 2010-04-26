From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: add omap_device_has_lost_context()
Date: Mon, 26 Apr 2010 01:58:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004260129320.1546@utopia.booyaka.com>
References: <1270588214-27790-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55533 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0DZH6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:58:51 -0400
In-Reply-To: <1270588214-27790-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

a few comments:

On Tue, 6 Apr 2010, Kevin Hilman wrote:

> Add new function omap_device_has_lost_context() as a simple check
> to be used after omap_device_enable() to determine if device has
> lost context (and thus needs context restore.)
> 
> Motivation: Currently, each driver needs to read the context-loss
> count before suspend, and again upon resume to determine if
> device context needs to be restored.  Rather than duplicating
> this process across all drivers, move it into omap_device.  After
> omap_device_enable(), omap_device_has_lost_context() can be called
> to determine if context was lost.
> 
> The hard work is done inside the powerdomain layer where a simple flag
> is checked.  The flag is cleared in the pre-transition call back,
> and conditionally set post-transition based on either an off-mode
> transition or a memory or logic off transition.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Wouldn't this need to be set/cleared on a per-device basis?  Certainly the 
process of setting the flag to true is most efficiently done on a 
per-powerdomain basis, but clearing the flag to false can only be done 
after the driver reloads the device context.  The powerdomain layer won't 
know about that.

Similarly, based on a quick glance, it looks like this code could miss a 
situation where a powerdomain goes off, loses context, then comes back on 
and does another transition from ON to CSWR or something similar that 
causes pwrdm->lost_context to be set to false.  If a driver calls 
omap_device_has_lost_context(), wouldn't it return false, even though the 
device context may still be lost?

Thinking about the problem naively, I'd guess that it would be best to 
iterate over all the struct omap_devices in that powerdomain when the 
system notices that the device context has been lost and set a per-device 
context loss flag to true.  Then the driver's context-restore code would 
also need to call into another function after the restore is complete, 
something like omap_device_context_restored(), which would set the 
per-device flag to true.  There might need to be an exception flag set in 
some hwmods that would indicate that the hardware restores some contexts 
by itself, such as SDRC, etc.

Also, is it possible for a completely idle powerdomain with clockdomains 
in hardware-supervised idle and with a next-power-state of OSWR or OFF to 
lose its context at any point, e.g., even if the MPU hasn't hit WFI?  If 
so, then this context-loss flag would pretty much need to be set the 
moment that the last functional clock goes off in that powerdomain 
(assuming that there are no modules in no-idle).  I guess we could also 
check the powerdomain's previous power state flag when the first clock is 
switched back on in the powerdomain.

> ---
>  arch/arm/mach-omap2/powerdomain.c             |   11 +++++++-
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/include/plat/powerdomain.h |    2 +-
>  arch/arm/plat-omap/omap_device.c              |   29 +++++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9a0fb38..ac54607 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -145,15 +145,19 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>  
>  	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
>  	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
> -	    (prev_logic_pwrst == PWRDM_POWER_OFF))
> +	    (prev_logic_pwrst == PWRDM_POWER_OFF)) {
>  		pwrdm->ret_logic_off_counter++;
> +		pwrdm->lost_context = true;
> +	}
>  
>  	for (i = 0; i < pwrdm->banks; i++) {
>  		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
>  
>  		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
> -		    (prev_mem_pwrst == PWRDM_POWER_OFF))
> +		    (prev_mem_pwrst == PWRDM_POWER_OFF)) {
>  			pwrdm->ret_mem_off_counter[i]++;
> +			pwrdm->lost_context = true;
> +		}
>  	}
>  }
>  
> @@ -176,6 +180,8 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>  		prev = pwrdm_read_prev_pwrst(pwrdm);
>  		if (pwrdm->state != prev)
>  			pwrdm->state_counter[prev]++;
> +		if (prev == PWRDM_POWER_OFF)
> +			pwrdm->lost_context = true;
>  		if (prev == PWRDM_POWER_RET)
>  			_update_logic_membank_counters(pwrdm);
>  		break;
> @@ -197,6 +203,7 @@ static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm, void *unused)
>  {
>  	pwrdm_clear_all_prev_pwrst(pwrdm);
>  	_pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
> +	pwrdm->lost_context = false;
>  	return 0;
>  }
>  
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 3694b62..b6ef94c 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -79,6 +79,7 @@ struct omap_device {
>  int omap_device_enable(struct platform_device *pdev);
>  int omap_device_idle(struct platform_device *pdev);
>  int omap_device_shutdown(struct platform_device *pdev);
> +bool omap_device_has_lost_context(struct platform_device *pdev);
>  
>  /* Core code interface */
>  
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index d82b2c0..bd5ab48 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -102,7 +102,7 @@ struct powerdomain {
>  	unsigned state_counter[PWRDM_MAX_PWRSTS];
>  	unsigned ret_logic_off_counter;
>  	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
> -
> +	bool     lost_context;
>  #ifdef CONFIG_PM_DEBUG
>  	s64 timer;
>  	s64 state_timer[PWRDM_MAX_PWRSTS];
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 5904358..0340b40 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -84,6 +84,7 @@
>  
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/powerdomain.h>
>  
>  /* These parameters are passed to _omap_device_{de,}activate() */
>  #define USE_WAKEUP_LAT			0
> @@ -579,6 +580,34 @@ int omap_device_shutdown(struct platform_device *pdev)
>  }
>  
>  /**
> + * omap_device_has_lost_context() - check if omap_device has lost context
> + * @od: struct omap_device *
> + *
> + * When an omap_device has been deactivated via omap_device_idle() or
> + * omap_device_shutdown() and then (re)activated using omap_device_enable()
> + * This function should be used to determine if the omap_device has
> + * lost context (due to an off-mode transistion)
> + */
> +bool omap_device_has_lost_context(struct platform_device *pdev)
> +{
> +	struct omap_device *od;
> +	struct powerdomain *pwrdm;
> +
> +	od = _find_by_pdev(pdev);
> +
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: has_lost_context() called "
> +		     "from invalid state\n", od->pdev.name, od->pdev.id);
> +		return -EINVAL;
> +	}
> +	pwrdm = omap_device_get_pwrdm(od);
> +	if (pwrdm)
> +		return pwrdm->lost_context;
> +
> +	return false;
> +}
> +
> +/**
>   * omap_device_align_pm_lat - activate/deactivate device to match wakeup lat lim
>   * @od: struct omap_device *
>   *
> -- 
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
