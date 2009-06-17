From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] SDRC: Remove SDRC_POWER register configuration from SDRC
 init.
Date: Wed, 17 Jun 2009 10:25:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
References: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42700 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZFQQZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 12:25:03 -0400
In-Reply-To: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Samu, Artem,

On Wed, 17 Jun 2009, Artem Bityutskiy wrote:

> From: Samu Onkalo <samu.p.onkalo@nokia.com>
> 
> Bootloader must configure proper settings for SDRC before starting
> kernel from SDRAM. Furthermore, removed lines violated omap3430 and
> omap2420 SDRC errata (see errata 1.150)

The 2420 and 3430 errata data here seems to be old; neither one contains 
1.150.  While I wait for a new version to arrive, can you provide some 
more context on this errata?  Does it imply any restrictions on 
programming SDRC_POWER from SRAM, e.g., the CORE DVFS code?


- Paul

> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> ---
>  arch/arm/mach-omap2/sdrc.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index 2045441..0874687 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -86,8 +86,8 @@ void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
>   * @sp: pointer to a null-terminated list of struct omap_sdrc_params
>   *
>   * Turn on smart idle modes for SDRAM scheduler and controller.
> - * Program a known-good configuration for the SDRC to deal with buggy
> - * bootloaders.
> + * Bootloaders should make proper configuration for SDRC since kernel
> + * is running from SDRAM.
>   */
>  void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
>  {
> @@ -104,10 +104,4 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
>  	sdrc_write_reg(l, SDRC_SYSCONFIG);
>  
>  	sdrc_init_params = sp;
> -
> -	/* XXX Enable SRFRONIDLEREQ here also? */
> -	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
> -		(1 << SDRC_POWER_PWDENA_SHIFT) |
> -		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
> -	sdrc_write_reg(l, SDRC_POWER);
>  }
> -- 
> 1.6.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
