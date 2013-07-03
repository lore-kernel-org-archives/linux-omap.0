From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Wed, 3 Jul 2013 10:30:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307031023060.1241-100000@iolanthe.rowland.org>
References: <20130703131513.GH15056@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130703131513.GH15056-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ruslan.bilovol-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 3 Jul 2013, Felipe Balbi wrote:

> On Wed, Jul 03, 2013 at 04:06:04PM +0300, Roger Quadros wrote:
> > On 07/03/2013 03:57 PM, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Tue, Jul 02, 2013 at 01:17:58PM -0400, Alan Stern wrote:
> > >> A PCI-based EHCI controller has two power sources: the core well (which
> > >> is turned off during suspend) and the auxiliary well (which remains
> > >> powered).  That's how remote wakeup works; it uses the auxiliary well.
> > > 
> > > This, kinda, matches what OMAP tries to do with pad wakeup. Just that
> > > pad wakeup sits outside of the device itself. Perhaps we could look into
> > > how PCI handles the aux well and take some inspiration from there.
> > > 
> > > Any pointers under drivers/pci/ would be great :-)
> > > 
> > From what I understood, auxiliary well is just a power source, and it keeps
> > the EHCI controller powered even during suspend.
> > 
> > If that is true then it is different from our situation as we power down the
> > EHCI controller completely.
> 
> right but our "auxiliary well" keeps PRCM powered which can wake EHCI up
> ;-)
> 
> What I'm saying is that from ehci-omap's perspective, there's very
> little difference, specially since we route the wakeup through the same
> IRQ line anyway. Perhaps we could take some inspiration from the PCI
> land to make our hwmod/omap_device a little easier from driver
> perspective.
> 
> Or maybe it doesn't make sense ;-)

This idea probably won't lead anywhere.  To the best of my knowledge 
(and I'm not an expert on PCI), these different power wells are simply 
part of the PCI bus.  The bus controller knows to turn off one of them 
when the device (or maybe when all the devices on a bus segment) goes 
into D3.

One big difference with respect to OMAP is the way PCI handles wakeup
messages.  There's a separate bus signal, PME# (which stands for Power
Management Event), that a device asserts when it wants to send a wakeup
request.  When the ACPI driver sees the PME# signal, it searches
through the entire PCI tree to find the device or devices which need to
be resumed.  Or maybe when ACPI sees the signal, it tells the PCI core 
to do this -- I'm not sure of the details.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
