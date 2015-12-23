From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
Date: Wed, 23 Dec 2015 07:44:56 -0800
Message-ID: <20151223154455.GL2793@atomide.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-6-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450868319-20513-6-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> [151223 03:00]:
> The LG Optimus Black (P970) codename sniper is a smartphone that was designed
> and manufactured by LG Electronics (LGE) and released back in 2011.
> It is using an OMAP3630 SoC, GP version.
> 
> This adds devicetree support for the device, with only a few basic features
> supported, such as debug uart, i2c, internal emmc and external mmc.

Cool :)

> +&gpio1 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio2 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio3 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio4 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio5 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio6 {
> +	ti,no-reset-on-init;
> +};

Care to try to narrow down exactly which GPIO(s) need to be preserved?
Chances are this will unnecessarily block deeper idle states in hardware
otherwise.

My guess is that the GPIO pins that need to be preserved if any are in
the GPIO bank 1 as that's always powered..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
