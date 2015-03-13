From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
Date: Fri, 13 Mar 2015 08:27:52 -0700
Message-ID: <20150313152751.GK5264@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-6-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426162154-8716-6-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> [150312 05:09]:
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
>  
> -static void __init omap3_evm_legacy_init(void)
> -{
> -	legacy_init_wl12xx(38400000, 0, 149);
> -}

FYI, at least this part conflicts with the fixes in the arm-soc
tree for the v4.0-rc series as omap3 evm also needs the copy clock
quirk.

> @@ -419,20 +351,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
>  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
>  	{ "isee,omap3-igep0020-rev-f", omap3_igep0020_rev_f_legacy_init, },
>  	{ "isee,omap3-igep0030-rev-g", omap3_igep0030_rev_g_legacy_init, },
> -	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },

So this function cannot be yet removed.

With that fixed, I was able to iw dev wlan0 scan with series on
omap3 evm :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
