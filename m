From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 01/19] ARM: OMAP4: PM: powerdomain: Add HWSAR flag to L3INIT
Date: Wed, 16 May 2012 11:27:20 -0700
Message-ID: <874nrgf0c7.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34744 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754161Ab2EPS1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 14:27:23 -0400
Received: by dajt11 with SMTP id t11so1640198daj.38
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 11:27:21 -0700 (PDT)
In-Reply-To: <1336990730-26892-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:32 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> L3INIT powerdomain has USB HOST and USB TLL modules which support
> hardware save-and-restore (HW SAR) mechanism.
> This patch updates the L3INIT power domain to mark them as capable
> of doing H/w save and restore and provides functions to do them
> explicitly.
>
> Note: Eventually, these custom function implementation will be
> abstracted and might be done in hwmod or in other layer.

Why not do it the right way now?

Also, these new functions need kerneldoc.

Kevin

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain44xx.c       |   41 +++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
>  2 files changed, 42 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
> index ab00736..37f7e12 100644
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ b/arch/arm/mach-omap2/powerdomain44xx.c
> @@ -23,6 +23,10 @@
>  #include "prm44xx.h"
>  #include "prminst44xx.h"
>  #include "prm-regbits-44xx.h"
> +#include "cm-regbits-44xx.h"
> +#include "prcm44xx.h"
> +#include "cm2_44xx.h"
> +#include "cminst44xx.h"
>  
>  static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  {
> @@ -238,6 +242,41 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
>  	return 0;
>  }
>  
> +static int omap4_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +	/*
> +	 * FIXME: This should be fixed right way by moving it into HWMOD
> +	 * or clock framework since sar control is moved to module level
> +	 */
> +	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
> +		1 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
> +		OMAP4430_CM2_L3INIT_INST,
> +		OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET);
> +	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
> +		1 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
> +		OMAP4430_CM2_L3INIT_INST,
> +		OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET);
> +	return 0;
> +}
> +
> +static int omap4_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +	/*
> +	 * FIXME: This should be fixed right way by moving it into HWMOD
> +	 * or clock framework since sar control is moved to module level
> +	 */
> +	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
> +		0 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
> +		OMAP4430_CM2_L3INIT_INST,
> +		OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET);
> +	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
> +		0 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
> +		OMAP4430_CM2_L3INIT_INST,
> +		OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET);
> +
> +	return 0;
> +}
> +
>  struct pwrdm_ops omap4_pwrdm_operations = {
>  	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
>  	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
> @@ -255,4 +294,6 @@ struct pwrdm_ops omap4_pwrdm_operations = {
>  	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
>  	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
>  	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
> +	.pwrdm_enable_hdwr_sar	= omap4_pwrdm_enable_hdwr_sar,
> +	.pwrdm_disable_hdwr_sar	= omap4_pwrdm_disable_hdwr_sar,
>  };
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index 704664c..d8701ce 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -276,7 +276,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
>  	.pwrsts_mem_on	= {
>  		[0] = PWRSTS_ON,	/* l3init_bank1 */
>  	},
> -	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
> +	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE | PWRDM_HAS_HDWR_SAR,
>  };
>  
>  /* l4per_44xx_pwrdm: Target peripherals power domain */
