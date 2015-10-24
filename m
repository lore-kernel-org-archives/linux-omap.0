From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/5] Export am35x helper functions
Date: Fri, 23 Oct 2015 18:28:46 -0700
Message-ID: <20151024012845.GC3078@atomide.com>
References: <562A557B.4090501@imms.de>
 <562A5655.3000406@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <562A5655.3000406-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org> [151023 08:46]:
> To be able to call these four helper functions from a M-USB AM35x driver
> module, their name symbols need to be exported.

I'd rather get rid of this file completely.. How about just do a minimal
drivers/phy driver? Maybe take a look at the drivers/phy/phy-dm816x-usb.c
for an example. Then you probably want to use the musb_dsps.c driver if
possible instead of the legacy am35x.c :)

Regards,

Tony

> Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> b/arch/arm/mach-omap2/omap_phy_internal.c
> index 8e90356..648a60f 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -82,6 +82,7 @@ void am35x_musb_reset(void)
> 
>  	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
>  }
> +EXPORT_SYMBOL(am35x_musb_reset);
> 
>  void am35x_musb_phy_power(u8 on)
>  {
> @@ -120,6 +121,7 @@ void am35x_musb_phy_power(u8 on)
>  		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>  	}
>  }
> +EXPORT_SYMBOL(am35x_musb_phy_power);
> 
>  void am35x_musb_clear_irq(void)
>  {
> @@ -130,6 +132,7 @@ void am35x_musb_clear_irq(void)
>  	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
>  	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
>  }
> +EXPORT_SYMBOL(am35x_musb_clear_irq);
> 
>  void am35x_set_mode(u8 musb_mode)
>  {
> @@ -152,3 +155,4 @@ void am35x_set_mode(u8 musb_mode)
> 
>  	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>  }
> +EXPORT_SYMBOL(am35x_set_mode);
> -- 
> 2.4.10
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
