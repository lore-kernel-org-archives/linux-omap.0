From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 10:39:48 +0100
Message-ID: <20171128093948.GA21766@lenoch>
References: <20171127220833.GA10070@lenoch>
 <20171128073328.GF10757@kroah.com>
 <20171128085751.GA28256@lenoch>
 <20171128093054.GA20720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171128093054.GA20720-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 10:30:54AM +0100, Greg KH wrote:
> On Tue, Nov 28, 2017 at 09:57:51AM +0100, Ladislav Michl wrote:
> > Hi Greg,
> > 
> > On Tue, Nov 28, 2017 at 08:33:28AM +0100, Greg KH wrote:
> > > On Mon, Nov 27, 2017 at 11:08:33PM +0100, Ladislav Michl wrote:
> > > > Hi there,
> > > > 
> > > > USB hosts do not discover any connected device on OMAP3 based board
> > > > with CONFIG_PM=n. Just enabling this option is enough to restore working
> > > > behaviour. Nothing unusual in log. Tested 4.14.2 and 4.15-rc1. I know
> > > > a lot of stuff depends on CONFIG_PM, but is this expected behaviour?
> > > > Neither EHCI nor MUSB is working without CONFIG_PM.
> > > 
> > > What bus type is your controllers on?  PCI?  platform?  Something else?
> > 
> > Platform controllers inside OMAP3630 Soc.
> > 
> > > And yes, perhaps this is to be expected, why would you not want
> > > CONFIG_PM to be enabled?  :)
> > 
> > For a start, I know Linux is general purpose OS and I know I cannot expect
> > low latency or low jitter when dealing with interrupts.
> 
> Well, it's the best latency of any other OS out there :)

Indeed, with CONFIG_PM=n... And that makes it the only OS without USB support
out there :)

> Anyway, if you want guaranteed response time, you are going to have to
> use the RT patchset, no matter what.  Otherwise you have the potential
> to have bad jitter at times.

That will not help, as jitter is comming from some part of SoC sleeping...

> > Original problem is described here:
> > https://www.spinics.net/lists/linux-omap/msg140081.html
> > 
> > Shortly, with CONFIG_PM jitter of GPIO interrupt is about 350us which
> > renders IR receiver unuseable - is cannot reliably decode IR protocol
> > (gpio-ir-recv is used). With CONFIG_PM disabled, jitter is around 30us
> > and that's enough to make IR decoders work.
> 
> bit-banging an ir decoder, ugh, you are in for a world of hurt.  Can't
> you put a chip on the device that does this for you in hardware?

OMAP has DM timer which can be externally trigered on edge. Perfect for
that purpose. But I cannot pinmux its input as hw designers did poor job.
And there are thousands of devices deployed.

So it is about a lot of soldering or providing software solution.

> Anyway, good luck!

A little pointer would increase "luck" by several order of magnitudes.

Thank you,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
