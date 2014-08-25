From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] pinctrl: single: Add DRA7 pinctrl compatibility
Date: Mon, 25 Aug 2014 10:26:02 -0700
Message-ID: <20140825172602.GN17254@atomide.com>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
 <1408716062-26055-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408716062-26055-3-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140822 07:03]:
> DRA7 pinctrl definitions now differ from traditional 16 bit OMAP pin
> ctrl definitions, in that all 32 bits are used to describe a single pin
> 
> Also the location of wakeupenable and event bits have changed.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  .../bindings/pinctrl/ti,omap-pinctrl.txt           |    1 +
>  drivers/pinctrl/pinctrl-single.c                   |    7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> index 156d964..d45386d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> @@ -5,5 +5,6 @@ Required properties:
>    "ti,omap3-padconf" - OMAP3 compatible pinctrl
>    "ti,omap4-padconf" - OMAP4 compatible pinctrl
>    "ti,omap5-padconf" - OMAP5 compatible pinctrl
> +  "ti,dra7-padconf" - DRA7 compatible pinctrl
>  
>  See Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt for further details.
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 95dd9cf..598d600 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1981,6 +1981,12 @@ static const struct pcs_soc_data pinctrl_single_omap_wkup = {
>  	.irq_status_mask = (1 << 15),	/* OMAP_WAKEUP_EVENT */
>  };
>  
> +static const struct pcs_soc_data pinctrl_single_dra7 = {
> +	.flags = PCS_QUIRK_SHARED_IRQ,
> +	.irq_enable_mask = (1 << 24),	/* WAKEUPENABLE */
> +	.irq_status_mask = (1 << 25),	/* WAKEUPEVENT */
> +};
> +
>  static const struct pcs_soc_data pinctrl_single = {
>  };
>  
> @@ -1992,6 +1998,7 @@ static struct of_device_id pcs_of_match[] = {
>  	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
> +	{ .compatible = "ti,dra7-padconf", .data = &pinctrl_single_dra7 },
>  	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
>  	{ .compatible = "pinconf-single", .data = &pinconf_single },
>  	{ },
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
