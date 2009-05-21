From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: SDRC: ensure mux of SDRC clock enable pins
 for self-refresh
Date: Thu, 21 May 2009 16:37:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905211635560.26015@utopia.booyaka.com>
References: <1242835699-11113-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43457 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbZEUWhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 18:37:16 -0400
In-Reply-To: <1242835699-11113-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, mikechan@google.com

Hi Kevin

On Wed, 20 May 2009, Kevin Hilman wrote:

> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index c832d83..d7807e2 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -136,5 +136,13 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
>  		(1 << SDRC_POWER_PWDENA_SHIFT) |
>  		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
>  	sdrc_write_reg(l, SDRC_POWER);
> +
> +	/* Ensure SDRC pins for both chip selcts are mux'd properly
> +	 * for self-refresh */
> +	if (cpu_is_omap34xx()) {
> +		omap_cfg_reg(H16_34XX_SDRC_CKE0);
> +		omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +	}
> +
>  	omap2_sms_save_context();
>  }

would suggest keeping pin remuxing in board-*.c or maybe chip-*.c files; 
ideally this file would only pertain to the SDRC IP block itself.


- Paul
