From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/3] ARM: OMAP: Introduce SoC specific early_init
Date: Wed, 24 Aug 2011 15:48:00 +0300
Message-ID: <4E54F300.308@compulab.co.il>
References: <20110824115048.2985.24230.stgit@kaulin> <20110824115436.2985.14338.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:34172
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755977Ab1HXMsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 08:48:03 -0400
In-Reply-To: <20110824115436.2985.14338.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

On 08/24/11 14:54, Tony Lindgren wrote:
> Introduce them for each omap variant and just make them all call
> omap2_init_common_infrastructure for now. Do this for each board-*.c
> file except for board-generic and board-omap3beagle as they use
> the same machine ID for multiple SoCs.
> 
> No functional changes.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

[...]

> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -471,11 +471,6 @@ static void __init cm_t35_init_i2c(void)
>  	omap3_pmic_init("tps65930", &cm_t35_twldata);
>  }
>  
> -static void __init cm_t35_init_early(void)
> -{
> -	omap2_init_common_infrastructure();
> -}
> -
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>  	/* nCS and IRQ for CM-T35 ethernet */
> @@ -637,7 +632,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
>  	.boot_params	= 0x80000100,
>  	.reserve	= omap_reserve,
>  	.map_io		= omap3_map_io,
> -	.init_early	= cm_t35_init_early,
> +	.init_early	= omap35xx_init_early,
>  	.init_irq	= omap3_init_irq,
>  	.init_machine	= cm_t35_init,
>  	.timer		= &omap3_timer,
> @@ -647,7 +642,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
>  	.boot_params    = 0x80000100,
>  	.reserve        = omap_reserve,
>  	.map_io         = omap3_map_io,
> -	.init_early     = cm_t35_init_early,
> +	.init_early     = am35xx_init_early,

Although this does not meter with the current implementation,
but for the sake of completeness, this should be omap3630_init_early.


-- 
Regards,
Igor.
