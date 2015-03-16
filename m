From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
Date: Mon, 16 Mar 2015 08:29:39 -0700
Message-ID: <20150316152939.GP5264@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313151301.GJ5264@atomide.com>
 <CAB3XZEdFMQexA69JEuw=VnqsNOEkWAM0+oWWmt6DaN9+hZ+vdw@mail.gmail.com>
 <2070859.WcMooC33YH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2070859.WcMooC33YH@wuerfel>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Luciano Coelho <luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [150315 05:10]:
> On Sunday 15 March 2015 10:50:42 Eliad Peller wrote:
> > yeah, i missed it :/
> > 
> > looks like there's no platform that defines platform data for it.
> > i'll replace the dev_get_platdata() with a function that only parses
> > the clock-frequency properties (the irq is taken in this case from the
> > spi_device).
> > (or maybe i should just drop it, as no one actually uses it?)
> 
> I don't think we should drop the driver, but dropping the platform_data
> support sounds reasonable. New users of this driver should all be using
> DT, and if there is a good reason to use platform_data, it's easily
> put back.

Well we have n8x0 and n900 using the spi driver. For those, n8x0 boot
all in dts mode, but n900 still also boots in legacy mode. It seems the
board-rx51-peripherals.c only passes the power_gpio though, so that
should be easy to keep around.

We should keep things still working for n900 in legacy mode until the
pending regressions with device tree based booting have been cleared
for at least one merge cycle. I believe the last pending issues is the
support for ATAG_REVISION in device tree mode as posted by Pali.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
