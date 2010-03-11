From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Fix EHCI port for IGEP v2 board.
Date: Thu, 11 Mar 2010 14:04:20 -0800
Message-ID: <20100311220420.GL2900@atomide.com>
References: <1267442288-3106-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55896 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758231Ab0CKWDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:03:00 -0500
Content-Disposition: inline
In-Reply-To: <1267442288-3106-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

* Enric Balletbo i Serra <eballetbo@gmail.com> [100303 09:34]:
> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> 
> IGEP v2 uses EHCI port 1 instead of EHCI port 2.

This does not seem to apply, can you please refresh please?

Tony
 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 9958987..26f65ca 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -443,13 +443,13 @@ static struct omap_musb_board_data musb_board_data = {
>  };
>  
>  static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
> -	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> -	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>  	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>  
>  	.phy_reset = true,
> -	.reset_gpio_port[0] = -EINVAL,
> -	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
> +	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
> +	.reset_gpio_port[1] = -EINVAL,
>  	.reset_gpio_port[2] = -EINVAL,
>  };
>  
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
