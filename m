From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Thu, 11 Aug 2011 11:19:18 +0300
Message-ID: <1313050758.2407.808.camel@cumari>
References: <1307356643.23002.413.camel@cumari>
	 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	 <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
	 <1307358348.23002.419.camel@cumari> <1312889168.2407.148.camel@cumari>
	 <CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-08-11 at 11:07 +0300, Ohad Ben-Cohen wrote: 
> > Any clues?
> 
> Reverting 665d001338b494d6d62810aa99b4c0fa1a0884b9 "OMAP2+: hwmod:
> Follow the recommended PRCM module enable sequence" fixes this for me.
> 
> More specifically, this hunk alone seems to do the trick:
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44x
> index 2af0e3f..12d22a8 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3379,7 +3379,6 @@ int __init omap4xxx_clk_init(void)
>         }
> 
>         clk_init(&omap2_clk_functions);
> -       omap2_clk_disable_clkdm_control();
> 
>         for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
>                                                                           c++)
> 
> I'm not suggesting this is anyway near a real fix, but hopefully it
> will help pin-point the problem (clock44xx_data.c changes ?).

This solves (or works around?) the problem for me too.  Thanks, Ohad!

-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
