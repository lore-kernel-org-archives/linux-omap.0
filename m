From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states
	list
Date: Wed, 5 Nov 2008 19:33:28 -0800
Message-ID: <20081106033327.GQ21736@atomide.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64374 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbYKFDdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 22:33:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

* Paul Walmsley <paul@pwsan.com> [081105 11:39]:
> 
> The SGX device on OMAP3 does not support retention, so remove RET from the 
> list of possible SGX power states.  Problem debugged by Richard Woodruff 
> <r-woodruff2@ti.com>.

Pushing.

Tony

> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
> index 446a1ed..edfad42 100644
> --- a/arch/arm/mach-omap2/powerdomains34xx.h
> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
> @@ -255,6 +255,11 @@ static struct powerdomain dss_pwrdm = {
>  	},
>  };
>  
> +/*
> + * Although the 34XX TRM Rev K Table 4-371 notes that retention is a
> + * possible SGX powerstate, the SGX device itself does not support
> + * retention.
> + */
>  static struct powerdomain sgx_pwrdm = {
>  	.name		  = "sgx_pwrdm",
>  	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
> @@ -262,7 +267,7 @@ static struct powerdomain sgx_pwrdm = {
>  	.wkdep_srcs	  = gfx_sgx_wkdeps,
>  	.sleepdep_srcs	  = cam_gfx_sleepdeps,
>  	/* XXX This is accurate for 3430 SGX, but what about GFX? */
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	  = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
