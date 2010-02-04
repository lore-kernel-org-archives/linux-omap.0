From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode
Date: Thu, 04 Feb 2010 13:51:41 -0800
Message-ID: <87r5p01xg2.fsf@deeprootsystems.com>
References: <1265299623-30124-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:34887 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882Ab0BDVvo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 16:51:44 -0500
Received: by pxi12 with SMTP id 12so3369580pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Feb 2010 13:51:43 -0800 (PST)
In-Reply-To: <1265299623-30124-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Thu\,  4 Feb 2010 21\:37\:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch allows wakeup from TWL4030 keypad when
> OFF mode is hit during suspend.
>
> Tested on OMAP3EVM.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

The idea here looks good, but there is nothing realy EVM specific here
AFAICT, and this exact code could be used on any other board using
the T2 keypad, right?  How about a common location?

Also, after looking at this patch, I think the 'void *pstate' member
of struct twl4030_keypad_data should be renamed to 'void *data' to
be more clear that it's just a pointer.

Kevin


> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   86 ++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 00bfe9b..b89fa29 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -40,12 +40,15 @@
>  #include <plat/board.h>
>  #include <plat/usb.h>
>  #include <plat/common.h>
> +#include <plat/control.h>
>  #include <plat/mcspi.h>
>  
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mmc-twl4030.h"
>  
> +#include "prm-regbits-34xx.h"
> +
>  #define OMAP3_EVM_TS_GPIO	175
>  #define OMAP3_EVM_EHCI_VBUS	22
>  #define OMAP3_EVM_EHCI_SELECT	61
> @@ -218,6 +221,84 @@ static struct platform_device leds_gpio = {
>  	},
>  };
>  
> +#ifdef CONFIG_PM
> +/*
> + * Save the state of keypad
> + *
> + * TODO: This definition should ideally be in a header file, but
> + *       matrix_keypad.h is not the right one. Also, plat/keypad.h
> + *       is no longer used.
> + */
> +struct omap_keypad_pm_state {
> +	void __iomem *wk_st;
> +	void __iomem *wk_en;
> +	u32 wk_mask;
> +	u32 padconf;
> +};
> +
> +/*
> + * Board specific hook for keypad suspend
> + */
> +void omap3_evm_kp_suspend(void *ptr)
> +{
> +	struct omap_keypad_pm_state *pstate =
> +			(struct omap_keypad_pm_state *)ptr;
> +
> +	if (pstate) {
> +		/*
> +		 * Set wake-enable bit
> +		 */
> +		if (pstate->wk_en && pstate->wk_mask) {
> +			u32 v = __raw_readl(pstate->wk_en);
> +			v |= pstate->wk_mask;
> +			__raw_writel(v, pstate->wk_en);
> +		}
> +		/*
> +		 * Set corresponding IOPAD wakeup-enable
> +		 */
> +		if (cpu_is_omap34xx() && pstate->padconf) {
> +			u16 v = omap_ctrl_readw(pstate->padconf);
> +			v |= OMAP3_PADCONF_WAKEUPENABLE0;
> +			omap_ctrl_writew(v, pstate->padconf);
> +		}
> +	}
> +}
> +
> +/*
> + * Board specific hook for keypad resume
> + */
> +void omap3_evm_kp_resume(void *ptr)
> +{
> +	struct omap_keypad_pm_state *pstate =
> +			(struct omap_keypad_pm_state *)ptr;
> +
> +	if (pstate) {
> +		/*
> +		 * Clear wake-enable bit
> +		 */
> +		if (pstate->wk_en && pstate->wk_mask) {
> +			u32 v = __raw_readl(pstate->wk_en);
> +			v &= ~pstate->wk_mask;
> +			__raw_writel(v, pstate->wk_en);
> +		}
> +		/*
> +		 * Clear corresponding IOPAD wakeup-enable
> +		 */
> +		if (cpu_is_omap34xx() && pstate->padconf) {
> +			u16 v = omap_ctrl_readw(pstate->padconf);
> +			v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
> +			omap_ctrl_writew(v, pstate->padconf);
> +		}
> +	}
> +}
> +
> +static struct omap_keypad_pm_state omap3evm_kp_pm_state = {
> +	.wk_st		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKEN1),
> +	.wk_en		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKST1),
> +	.wk_mask	= OMAP3430_EN_GPIO1,
> +	.padconf	= 0x1e0,
> +};
> +#endif	/* CONFIG_PM */
>  
>  static int omap3evm_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
> @@ -288,6 +369,11 @@ static struct twl4030_keypad_data omap3evm_kp_data = {
>  	.rows		= 4,
>  	.cols		= 4,
>  	.rep		= 1,
> +#ifdef CONFIG_PM
> +	.pm_state	= (void *)&omap3evm_kp_pm_state,
> +	.on_suspend	= omap3_evm_kp_suspend,
> +	.on_resume	= omap3_evm_kp_resume,
> +#endif	/* CONFIG_PM */
>  };
>  
>  static struct twl4030_madc_platform_data omap3evm_madc_data = {
> -- 
> 1.6.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
