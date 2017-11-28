From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 13:09:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1711281307250.1467-100000@iolanthe.rowland.org>
References: <20171128160517.GA9691@lenoch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171128160517.GA9691@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Nov 2017, Ladislav Michl wrote:

> On Tue, Nov 28, 2017 at 10:00:32AM -0500, Alan Stern wrote:
> > On Tue, 28 Nov 2017, Greg KH wrote:
> > 
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
> > > 
> > > And yes, perhaps this is to be expected, why would you not want
> > > CONFIG_PM to be enabled?  :)
> > 
> > Well, no, it's not expected.  Systems are supposed to work correctly 
> > with CONFIG_PM=n -- just not at an optimum power level.
> 
> Here's relevant part of bootlog:
...

> > EHCI certainly should work without CONFIG_PM.  When a device is plugged 
> > in to the EHCI controller, what shows up in 
> > /sys/kernel/debug/usb/ehci/*/registers (fill in the '*' with the 
> > correct bus ID)?
> 
> $ ls /sys/kernel/debug/usb
> devices  ohci
> 
> So no ehci.
...

> For ohci it is the same. Any hint why there's no ehco file?

The EHCI debugging files require CONFIG_DYNAMIC_DEBUG to be enabled.  
Oddly enough, the OHCI debugging files do not have the same 
requirement.  I don't know the reason for this difference.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
