From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3 v5] arm: omap: am335x: enable phy controls
Date: Fri, 10 Feb 2012 10:31:43 -0800
Message-ID: <20120210183143.GS1426@atomide.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <1328675212-29693-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328675212-29693-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> [120207 19:55]:
> Switch on the phy for am335x.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index 4c90477..7129408 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -266,7 +266,11 @@ void ti81xx_musb_phy_power(u8 on)
>  	void __iomem *scm_base = NULL;
>  	u32 usbphycfg;
>  
> -	scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> +	if (cpu_is_ti81xx())
> +		scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> +	else if (cpu_is_am33xx())
> +		scm_base = ioremap(AM33XX_SCM_BASE, SZ_2K);
> +
>  	if (!scm_base) {
>  		pr_err("system control module ioremap failed\n");
>  		return;
> @@ -278,16 +282,19 @@ void ti81xx_musb_phy_power(u8 on)
>  		if (cpu_is_ti816x()) {
>  			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
>  			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> -		} else if (cpu_is_ti814x()) {
> -			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> -			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> +		} else if (cpu_is_ti814x() || cpu_is_am33xx()) {
> +			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
> +			usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
> +			if (cpu_is_ti814x()) {
> +				usbphycfg &= ~(USBPHY_DPINPUT | USBPHY_DMINPUT);
> +				usbphycfg |= USBPHY_DPOPBUFCTL
> +					| USBPHY_DMOPBUFCTL;
> +			}
>  		}
>  	} else {
>  		if (cpu_is_ti816x())
>  			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
> -		else if (cpu_is_ti814x())
> +		else if (cpu_is_ti814x() || cpu_is_am33xx())
>  			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
>  

Please remove all the cpu_is_xxxx calls from the *_phy_power functions.
You should need those only in *_phy_init to set the right flags once,
not every time you enable or disable the phy.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
