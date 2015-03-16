From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] ARM: dts: add openpandora device support
Date: Mon, 16 Mar 2015 15:04:29 -0700
Message-ID: <20150316220429.GM12397@atomide.com>
References: <1425072399-23152-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425072399-23152-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [150227 13:30]:
> changes from v2:
> - fix missing PIN_INPUT for penirq node
> - added Reviewed-by and Tested-by
> 
> changes from v1:
> - add new boards to makefile in patch 2,3 (don't add them
> in separate commit together), fix gpmc issues (reported by Tony Lindgren)
> 
> - fix various issues reported by Grazvydas Ignotas
> (drop internal pullups from pinmux as external are in place,
> fix gpio buttons active state ...)
> 
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
> Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.
> 
> First patch add common dtsi file which is then used in 600mhz and 1ghz
> variants of openpandora which support is added in patches 2 and 3.
> 
> H. Nikolaus Schaller (3):
>   ARM: dts: omap3-pandora: add common device tree
>   ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
>   ARM: dts: omap3-pandora: add DM3730 1 GHz version

Thanks everybody for doing this, applying into omap-for-v4.1/dt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
