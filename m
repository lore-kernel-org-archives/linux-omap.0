From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Tue, 10 Jan 2012 09:56:07 -0800
Message-ID: <87mx9vqw5k.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39491 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab2AJR4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:56:10 -0500
Received: by mail-yx0-f177.google.com with SMTP id l2so2260550yen.36
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:56:09 -0800 (PST)
In-Reply-To: <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
>
> Now devices can idle independent of the powerdomain, there can be a window where device
> is idled and corresponding powerdomain can be ON/INACTIVE state. In such situations,
> since both module wake up is enabled at padlevel as well as io daisychain sequence is
> triggered, there will be 2 PRCM interrupts (Module async wake up via swakeup and IO Pad
> interrupt). But as PRCM Interrupt handler clears the Module Padlevel WKST bit in the
> first interrupt, module specific interrupt handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
>  arch/arm/mach-omap2/pm.c         |   11 +++++++++++
>  arch/arm/mach-omap2/pm.h         |    1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index f7f22da..1a72463 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -151,6 +151,7 @@
>  #include "prm44xx.h"
>  #include "prminst44xx.h"
>  #include "mux.h"
> +#include "pm.h"
>  
>  /* Maximum microseconds to wait for OMAP module to softreset */
>  #define MAX_MODULE_SOFTRESET_WAIT	10000
> @@ -1462,8 +1463,10 @@ static int _enable(struct omap_hwmod *oh)
>  	/* Mux pins for device runtime if populated */
>  	if (oh->mux && (!oh->mux->enabled ||
>  			((oh->_state == _HWMOD_STATE_IDLE) &&
> -			 oh->mux->pads_dynamic)))
> +			 oh->mux->pads_dynamic))) {
>  		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
> +		omap_trigger_wuclk_ctrl();
> +	}

Why is the IO chain enabled during hwmod _enable()?

>  	_add_initiator_dep(oh, mpu_oh);
>  
> @@ -1553,8 +1556,10 @@ static int _idle(struct omap_hwmod *oh)
>  		clkdm_hwmod_disable(oh->clkdm, oh);
>  
>  	/* Mux pins for device idle if populated */
> -	if (oh->mux && oh->mux->pads_dynamic)
> +	if (oh->mux && oh->mux->pads_dynamic) {
>  		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
> +		omap_trigger_wuclk_ctrl();
> +	}

Since this is now happening in idle for every hwmod with dynamic pads,
the underlying function should probably cache the current value so it
doesn't have to do a multiple PRCM register accesses it's only
going to set a bit that's already set.

Kevin

>  	oh->_state = _HWMOD_STATE_IDLE;
>  
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1881fe9..4d8ca28 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -25,6 +25,8 @@
>  #include "clockdomain.h"
>  #include "pm.h"
>  #include "twl-common.h"
> +#include "prm2xxx_3xxx.h"
> +#include "prm44xx.h"
>  
>  static struct omap_device_pm_latency *pm_lats;
>  
> @@ -64,6 +66,15 @@ static void omap2_init_processor_devices(void)
>  	}
>  }
>  
> +void omap_trigger_wuclk_ctrl(void)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_trigger_wuclk_ctrl();
> +
> +	if (cpu_is_omap44xx())
> +		omap4_trigger_wuclk_ctrl();
> +}
> +
>  /* Types of sleep_switch used in omap_set_pwrdm_state */
>  #define FORCEWAKEUP_SWITCH	0
>  #define LOWPOWERSTATE_SWITCH	1
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 4e166ad..05c2da2 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -21,6 +21,7 @@ extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> +void omap_trigger_wuclk_ctrl(void);
>  
>  #if defined(CONFIG_PM_OPP)
>  extern int omap3_opp_init(void);
