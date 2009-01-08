From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Default MUX configuration added - GPIO140-143,
	GPIO0 and GPIO9
Date: Thu, 8 Jan 2009 14:06:07 +0200
Message-ID: <20090108120605.GA27566@atomide.com>
References: <1229405483-32438-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62365 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZAHMGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 07:06:08 -0500
Content-Disposition: inline
In-Reply-To: <1229405483-32438-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

* Manikandan Pillai <mani.pillai@ti.com> [081216 07:31]:
> Default MUX configurations for GPIO on OMAP3 EVM boards are added.
> Fixed for "_UP" naming convention for GPIOs comment.

Pushing to l-o tree, and adding to omap-upstream queue.

Tony

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c             |   13 +++++++++++++
>  arch/arm/plat-omap/include/mach/mux.h |    6 ++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index dacb41f..1556688 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -459,6 +459,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
>  MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> +MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
> +MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
> +		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> +
>  };
>  
>  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
> index f4362b8..67fddec 100644
> --- a/arch/arm/plat-omap/include/mach/mux.h
> +++ b/arch/arm/plat-omap/include/mach/mux.h
> @@ -790,6 +790,12 @@ enum omap34xx_index {
>  	 */
>  	AH8_34XX_GPIO29,
>  	J25_34XX_GPIO170,
> +	AF26_34XX_GPIO0,
> +	AF22_34XX_GPIO9,
> +	AF6_34XX_GPIO140_UP,
> +	AE6_34XX_GPIO141,
> +	AF5_34XX_GPIO142,
> +	AE5_34XX_GPIO143
>  };
>  
>  struct omap_mux_cfg {
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
