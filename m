From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] OMAP4: hwmod: enable mcpdm hwmod device.
Date: Fri, 19 Aug 2011 16:02:24 +0300
Message-ID: <20110819130224.GE4996@atomide.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
 <1312284857-1774-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13270 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279Ab1HSNCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 09:02:30 -0400
Content-Disposition: inline
In-Reply-To: <1312284857-1774-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110802 14:28]:
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria
> Signed-off-by: Margarita Olaya Cabrera
> Signed-off-by: Liam Girdwood <lrg@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e1c69ff..63e7c41 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5121,7 +5121,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	&omap44xx_mcbsp4_hwmod,
>  
>  	/* mcpdm class */
> -/*	&omap44xx_mcpdm_hwmod, */
> +	&omap44xx_mcpdm_hwmod,
>  
>  	/* mcspi class */
>  	&omap44xx_mcspi1_hwmod,
> -- 
> 1.7.6
> 
