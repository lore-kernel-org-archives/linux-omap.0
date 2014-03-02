From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] ARM: dts: omap3-gta04: Various devicetree updates
Date: Sun, 2 Mar 2014 09:43:37 -0800
Message-ID: <20140302174336.GC18496@atomide.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393682334-26805-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [140301 06:02]:
> This updated series fix issue with proper gta04 booting in 3.14 kernel
> and add various devices to devicetree.
> 
> Changes from V1: 
> - removed fixes which was merged to 3.14 already
> - add bma180 accelerometer + booting fix
> 
> Marek Belisko (2):
>   ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid
>     problems with booting
>   ARM: dts: omap3-gta04: Add touchscreen properties
> 
> NeilBrown (5):
>   ARM: dts: omap3-gta04: Add support for magnetometer
>   ARM: dts: omap3-gta04: Add twl4030 charger
>   ARM: dts: omap3-gta04: Add basic sound support
>   ARM: dts: omap3-gta04: Enable mmc2 for wifi
>   ARM: dts: omap3-gta04: Add bma180 accelerometer
> 
>  arch/arm/boot/dts/omap3-gta04.dts | 53 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)

Thanks for updating these, I'll take the first one into
omap-for-v3.14/fixes and the rest into omap-for-v3.15/dt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
