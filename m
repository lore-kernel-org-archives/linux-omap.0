From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 13:30:32 -0500
Message-ID: <20150511183032.GA8085@deathray>
References: <5550DDCB.8010303@ti.com>
 <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5550F47C.1030902-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-next <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 11, 2015 at 01:27:08PM -0500, Nishanth Menon wrote:
> On 05/11/2015 12:07 PM, Michael Welling wrote:
> > On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
> >> Hi,
> >>
> >> SDP4430 uses a SPI based network chip ks8851.
> >>
> >> next-20150508:
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
> >>
> >> However, next-20150511:
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
> >>
> > 
> > I will look into this but it is going to be difficult to debug with access to the hardware.
> > This is what I get for changing a driver that effects so many SoCs.
> > 
> 
> Let me know if there is any test patch you'd want me to run. The board
> is on a remote "board farm" which most of TI folks have access to as
> well.. So, if you need anything run, just send out a debug patch OR a
> potential fix and we can help try it out and provide logs back for
> your debug.

Okay.

It looks like you revert the patches in the wrong order above.

The GPIO patch should apply after the transfer_one patch so it should
logically be reverted in the reverse order.

> 
> 
> -- 
> Regards,
> Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
