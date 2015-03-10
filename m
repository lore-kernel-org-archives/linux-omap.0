From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Tue, 10 Mar 2015 08:55:30 -0700
Message-ID: <20150310155529.GP5264@atomide.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <2223973.a64rBcZvaA@wuerfel>
 <20150310142805.GN5264@atomide.com>
 <2300824.dcEMS7aYJa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2300824.dcEMS7aYJa@wuerfel>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [150310 08:48]:
> On Tuesday 10 March 2015 07:28:05 Tony Lindgren wrote:
> > 
> > Oops I forgot about the omap3-sbc-t3730, so yes we have to keep the
> > platform data a little bit longer. But nothing stopping us moving
> > all the other ones to use a proper device tree based configuration.
> > 
> 
> For all I can tell, the t3730 board file does not support wl12xx
> at the moment, only the dts file does.

Hmm strange, it seems to configure the wlan_rst pin. Maybe there
are variants with different WLAN module. But yeah, seems to be
unused.

That still leaves configuring all the dts users of the
pdata-quirks.c legacy_init_wl12xx() with proper dts before
removing it:

$ git grep legacy_init_wl12xx pdata-quirks.c
pdata-quirks.c:static void __init __used legacy_init_wl12xx(unsigned ref_clock,
pdata-quirks.c:static inline void legacy_init_wl12xx(unsigned ref_clock,
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 136);
pdata-quirks.c: legacy_init_wl12xx(0, 0, 177);
pdata-quirks.c: legacy_init_wl12xx(0, 0, 136);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 145);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_26,
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 41);
pdata-quirks.c: legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 31);

> If we do what Sekhar suggested and drop wl12xx support from
> the DA850 EVM board file, we can fix all wlcore users.

I guess Sekhar knows the da850 evm status the best. So up to
you guys if wl12xx is not being used on legacy da850.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
