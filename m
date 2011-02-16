From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/6] OMAP2+: musb: hwmod adaptation for musb registration
Date: Wed, 16 Feb 2011 15:49:54 +0300
Message-ID: <4D5BC7F2.9000804@ru.mvista.com>
References: <1297859298-27861-1-git-send-email-hemahk@ti.com> <1297859298-27861-6-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297859298-27861-6-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 16-02-2011 15:28, Hema HK wrote:

> Using omap_device_build API instead of platform_device_register for
> OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
> The device specific resources defined in centralized
> database will be used.

> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley<paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
[...]

> Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
> +++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
[...]
> @@ -115,8 +88,35 @@ void __init usb_musb_init(struct omap_mu
>   	musb_plat.mode = board_data->mode;
>   	musb_plat.extvbus = board_data->extvbus;
>
> -	if (platform_device_register(&musb_device)<  0)
> -		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
> +	if (cpu_is_omap3517() || cpu_is_omap3505()) {
> +		oh_name = "am35x_otg_hs";
> +		name = "musb-am35x";
> +	} else {
> +		oh_name = "usb_otg_hs";
> +		name = "musb-omap2430";
> +	}

    The following code is over-indented...

> +		oh = omap_hwmod_lookup(oh_name);
> +		if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name);
> +			return;
> +		}
> +
> +		od = omap_device_build(name, bus_id, oh, &musb_plat,
> +				       sizeof(*pdata), omap_musb_latency,
> +				       ARRAY_SIZE(omap_musb_latency), false);
> +		if (IS_ERR(od)) {
> +			pr_err("Could not build omap_device for %s %s\n",
> +							name, oh_name);
> +			return;
> +

    Empty line not needed here...

> +		}
> +		pdev =&od->pdev;
> +		dev =&pdev->dev;
> +		get_device(dev);
> +		dev->dma_mask = &musb_dmamask;
> +		dev->coherent_dma_mask = musb_dmamask;
> +		put_device(dev);
> +

    And here...

>   }
>
>   #else

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
