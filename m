From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 22:48:52 -0700
Message-ID: <20140520054852.GA12384@atomide.com>
References: <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <5379CD24.6040508@ti.com>
 <20140519160447.GB4849@atomide.com>
 <537A55EB.1080507@ti.com>
 <20140520051203.GB28812@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140520051203.GB28812-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [140519 22:13]:
> On Mon, May 19, 2014 at 10:05:15PM +0300, Tomi Valkeinen wrote:
> > On 19/05/14 19:04, Tony Lindgren wrote:
> > 
> > > In many cases however we do have multiple compatible strings that
> > > describe how the device is wired. See drivers/tty/serial/of_serial.c
> > > for example. It has "ns16550" but then it also has additional
> > > "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".
> > 
> > All those sound like SoC components. In that case it sounds fine to have
> > the device compatible contain the SoC name. We're talking here about
> > external, detachable devices.

Yes I agree it's also hackish. But playing with the compatible flags
avoids adding other custom workarounds.

> > >>> Not use what you're after with the SPI example though, but sounds
> > >>> like that's something different.
> > >>
> > >> I think Sebastien's example is just like the issue here.
> > > 
> > > Hmm is there some existing example in the kernel like that?
> > 
> > No, Sebastien's example was just a hypothetical case. Here, using your
> > way of having SoC specific data in the .dts, we would have
> > "sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
> > sensor we'd have, say, "synaptics,xyz123-omap-spi".
> 
> Yes, that's what I wanted to say :)

Hmm I think we need to add few things to the hypothetical SPI case
to get it even close to the panel example. Like assume that no SPI bus
exists, and that potentially multiple different Synaptics drivers are
trying to share the same compatible flag for a non-existing generic
binding.. I think then it's getting close to the panel example :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
