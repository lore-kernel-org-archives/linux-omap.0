From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: am57xx-beagle-x15: Fixes for RTC
Date: Mon, 4 May 2015 09:17:37 -0700
Message-ID: <20150504161737.GK24469@atomide.com>
References: <1428537387-18776-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428537387-18776-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Grygorii Strashko <Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150408 16:57]:
> Couple of fixes for MCP79410 RTC on BeagleBoard-X15 platform. This is
> not urgent enough for 4.0 material, but will be good to have it on one
> of 4.1 rcs. tested on next-20150407:
> http://pastebin.ubuntu.com/10777733/
> (NOTE: I believe DRA7 rtc still needs reset driver to be done before it can be fully functional).
> 
> Grygorii Strashko (1):
>   ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x
> 
> Nishanth Menon (1):
>   ARM: dts: am57xx-beagle-x15: Fix RTC aliases
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
>  arch/arm/boot/dts/dra7.dtsi             |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applying both into omap-for-v4.1/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
