From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 1/5] ARM: dts: LG Optimus Black codename sniper basic
 support
Date: Mon, 29 Feb 2016 13:51:37 -0800
Message-ID: <20160229215136.GO13417@atomide.com>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-2-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456663185-14170-2-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> [160228 04:40]:
> The LG Optimus Black codename sniper is a smartphone that was designed and
> manufactured by LG Electronics (LGE) and released back in 2011.
> It is using an OMAP3630 SoC, GP version.
> 
> This adds devicetree support for the device, with only a few basic features
> supported, such as debug uart, i2c, internal emmc and external mmc.
...
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		power {
> +			compatible = "ti,twl4030-power";
> +			ti,use_poweroff;
> +		};
> +	};
> +};

Chances are this devices supports cutting off the voltages and
the high frequency oscillator during idle. So you may want to
at some point set compatible = "ti,twl4030-power-idle-osc-off"
here.

Anyways, applying the dts changes into omap-for-v4.6/dt thanks.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
