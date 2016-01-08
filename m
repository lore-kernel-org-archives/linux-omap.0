From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular
 host/pci*
Date: Fri, 8 Jan 2016 14:31:02 -0600
Message-ID: <20160108203102.GH5354@localhost>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
 <20151214091940.GA15126@ulmo.nvidia.com>
 <3302340.SIljl1qYTl@wuerfel>
 <20151215151624.GB2772@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151215151624.GB2772-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni@fr>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 15, 2015 at 10:16:24AM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*] On 14/12/2015 (Mon 11:27) Arnd Bergmann wrote:
> 
> > On Monday 14 December 2015 10:19:40 Thierry Reding wrote:
> > > > PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> > > > Fixup region is in kernel region and this region if not updated when
> > > > loading a module.
> > > 
> > > Interesting, I hadn't thought about that. I suppose this means that the
> > > module will end up containing an unused section with the fixup code. It
> > > might be useful to add a way for that to trigger a warning at build
> > > time.
> > > 
> > > Perhaps to fix this a mechanism could be introduced to add a table of
> > > fixups to a host controller driver and that will get applied to all
> > > children of the bridge. It could be problematic to cover all of the
> > > different fixup stages, though.
> > 
> > I think a lot of the fixups shouldn't really be there in the first place,
> > they are about stuff that we can fix up in the probe function, or that should
> > be fixed up in the probe function with some appropriate core support added.
> 
> So, the feedback on this is a bit all over the map, leaving me unsure
> what to do next.  And is the choice we make on a per board/bsp basis or
> ideally across all platforms?  I see the choices as:
> 
> 1) do nothing; which IMHO is least desirable as it leaves the code
> misrepresenting itself as modular; one of the key issues I wanted to fix
> 
> 2) use the patches I've sent ; then as they are genuinely made modular,
> the person doing so essentially "patch -R" or reverts the change as
> step one.  This has the advantage of solving the "we'll get to it
> someday" issue if someday never comes.
> 
> 3) make them all tristate;  beat it with a stick until it compiles [M]
> and modposts -- leaving the fixups and functional testing to people with
> the boards and low level knowledge to make it _work_ as a module.  The
> downside here is the code is still kind of misrepresenting itself as
> modularly functional -- a ban of unloading might mitigate that some.

I'd like to preserve the mind-set that host controller drivers are
*expected* to be modular, even if we aren't there yet.  I guess that
means I'm in favor of option 3, at least for drivers that don't use
fixups.

Bjorn
