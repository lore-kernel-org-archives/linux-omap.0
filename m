From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
Date: Fri, 7 Oct 2011 02:19:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110070217000.4611@utopia.booyaka.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com> <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46784 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758795Ab1JGITo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 04:19:44 -0400
In-Reply-To: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi

a few comments:

On Tue, 4 Oct 2011, Vishwanath BS wrote:

> As per OMAP3630 TRM Section 3.5.7.2.2, the right sequence for enabling IO Daisy
> chain is "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
> control (Wu clock) by programming a dedicated register
> (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in the PRCM module.Software must wait for
> the I/O daisy chain to complete before it transitions the PER domain to a
> nonfunctional state. This is done by polling a dedicated status bit in the PRCM
> module (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared by
> software when the bit is read to  1".
> 
> The original code was polling on a wrong register which is fixed in this patch.
> Also omap3_enable_io_chain is made non static as it's going to be used in
> subsequent patches.

This patch should be split into a fix (for the WKEN/WKST bug) and then a 
new patch that drops the 'static'.  The new patch should also move this 
function to prm2xxx_3xxx.c for the same reason that the OMAP4 version of 
this function should be in prminst44xx.c.

In the medium-term, a bunch of the functions from prm2xxx_3xxx.c, 
prminst44xx.c, etc. that are only used by the mach-omap2/pm*.c code should 
be moved into the PRM driver that Tero is working on that will live in 
drivers/.

>  
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/pm.h     |    1 +
>  arch/arm/mach-omap2/pm34xx.c |    6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 4e166ad..9a36a7c 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -21,6 +21,7 @@ extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> +extern void omap3_enable_io_chain(void);
>  
>  #if defined(CONFIG_PM_OPP)
>  extern int omap3_opp_init(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7255d9b..61f1a5b 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -95,7 +95,7 @@ static inline void omap3_per_restore_context(void)
>  	omap_gpio_restore_context();
>  }
>  
> -static void omap3_enable_io_chain(void)
> +void omap3_enable_io_chain(void)
>  {
>  	int timeout = 0;
>  
> @@ -105,7 +105,7 @@ static void omap3_enable_io_chain(void)
>  		/* Do a readback to assure write has been done */
>  		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>  
> -		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> +		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
>  			 OMAP3430_ST_IO_CHAIN_MASK)) {
>  			timeout++;
>  			if (timeout > 1000) {
> @@ -114,7 +114,7 @@ static void omap3_enable_io_chain(void)
>  				return;
>  			}
>  			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKEN);
> +					     WKUP_MOD, PM_WKST);
>  		}
>  	}
>  }
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
