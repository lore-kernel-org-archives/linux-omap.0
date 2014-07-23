From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] arm: dts: oma3-gta04: Various updates
Date: Wed, 23 Jul 2014 02:00:47 -0700
Message-ID: <20140723090047.GD22006@atomide.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406057420-22269-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [140722 12:32]:
> Following patchset add various improvements to gta04 devicetree.
> 
> Changes from v1:
> - added description to all patches
> 
> Marek Belisko (7):
>   arm: dts: omap3-gta04: Add nand support
>   arm: dts: omap3-gta04: Fix magnetometer model
>   arm: dts: omap3-gta04: Add wifi reset node
>   arm: dts: omap3-gta04: Move spi gpio pins to pmx_core2
>   arm: dts: omap3-gta04: Add USB host support
>   arm: dts: omap3-gta04: Add display alias
>   arm: dts: omap3-gta04: Add twl4030 regulators parameters
> 
>  arch/arm/boot/dts/omap3-gta04.dts | 150 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 145 insertions(+), 5 deletions(-)

Applying into omap-for-v3.17/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
