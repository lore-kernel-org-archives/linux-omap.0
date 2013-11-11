From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] arm: am335x: am335x evm sk: add touchscreen DT node
Date: Sun, 10 Nov 2013 23:59:37 -0800
Message-ID: <20131111075937.GH7645@core.coreip.homeip.net>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382386404-6659-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 21, 2013 at 03:13:22PM -0500, Felipe Balbi wrote:
> Hi,
> 
> the following patches fix a typo on TSC/ADC DT binding while
> maintaining backwards compatibility and add support for the
> touchscreen available on am335x-evm-sk.
> 
> Patches have been tested with am335x-evm-sk with a couple patches
> (already floating around the mailing lists) to get that board
> booting in mainline.
> 
> cheers

Applied, thank you.

> 
> Felipe Balbi (2):
>   input: touchscreen: fix spelling mistake in TSC/ADC DT binding
>   arm: dts: am335x sk: add touchscreen support
> 
>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt       |  2 +-
>  arch/arm/boot/dts/am335x-evm.dts                               |  2 +-
>  arch/arm/boot/dts/am335x-evmsk.dts                             | 10 ++++++++++
>  drivers/input/touchscreen/ti_am335x_tsc.c                      |  9 ++++++++-
>  4 files changed, 20 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.4.GIT
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
