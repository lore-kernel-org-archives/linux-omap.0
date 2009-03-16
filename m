From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] twl4030-regulator: expose VPLL2
Date: Mon, 16 Mar 2009 11:43:35 +0000
Message-ID: <1237203815.6781.294.camel@vega.slimlogic.co.uk>
References: <200903131754.54997.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:36247 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZCPLnk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 07:43:40 -0400
In-Reply-To: <200903131754.54997.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net, Samuel Ortiz <sameo@openedhand.com>
Cc: Mark Brown <broonie@sirena.org.uk>, OMAP <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, 2009-03-13 at 17:54 -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Add VPLL2 to the set of twl4030-family regulators exposed for
> use by various drivers.  It's commonly used to power the digital
> video outputs (e.g. LCD or DVI displays) on OMAP3 systems.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Please apply to regulator-next and linux-omap ... I'll send
> some patches configuring various OMAP boards to use this.
> 
>  drivers/mfd/twl4030-core.c            |    2 --
>  drivers/regulator/twl4030-regulator.c |    2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -613,11 +613,9 @@ add_children(struct twl4030_platform_dat
>  
>  	/* maybe add LDOs that are omitted on cost-reduced parts */
>  	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
> -		/*
>  		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
>  		if (IS_ERR(child))
>  			return PTR_ERR(child);
> -		*/
>  
>  		child = add_regulator(TWL4030_REG_VMMC2, pdata->vmmc2);
>  		if (IS_ERR(child))
> --- a/drivers/regulator/twl4030-regulator.c
> +++ b/drivers/regulator/twl4030-regulator.c
> @@ -404,8 +404,8 @@ static struct twlreg_info twl4030_regs[]
>  	TWL_ADJUSTABLE_LDO(VMMC2, 0x2b, 6),
>  	/*
>  	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, 7),
> -	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
>  	*/
> +	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
>  	TWL_ADJUSTABLE_LDO(VSIM, 0x37, 9),
>  	TWL_ADJUSTABLE_LDO(VDAC, 0x3b, 10),
>  	/*
> 

Samuel, I'm fine putting this through regulator if its fine with you ?

Thanks

Liam

