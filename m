From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: OMAP34xx
Date: Tue, 14 Feb 2012 09:59:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202140956060.1544-100000@iolanthe.rowland.org>
References: <20120214084854.GB24201@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35920 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751007Ab2BNO7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 09:59:30 -0500
In-Reply-To: <20120214084854.GB24201@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rex Feany <rfeany@laeos.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Tue, 14 Feb 2012, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Feb 09, 2012 at 11:34:42AM -0800, Rex Feany wrote:
> > I also get these warnings when compiling:
> > 
> >   CC      arch/arm/mach-omap2/usb-host.o
> > arch/arm/mach-omap2/usb-host.c: In function 'usbhs_init':
> > arch/arm/mach-omap2/usb-host.c:528: warning: assignment from incompatible pointer type
> 
> yeah, I'll send a patch for that.
> 
> >   CC      drivers/usb/host/ehci-hcd.o
> > drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' defined but not used
> > drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' defined but not used
> 
> This can't really be "fixed" without some extra trickery. The fact is
> that OMAP can't handle port handoff (go figure) and if we use those
> functions, we might end up in a situation where USB doesn't work just
> because you connected a full speed device.
> 
> By not using those functions, we guarantee that the full speed device
> won't get enumerated but USB will still be functional after you
> disconnect such device.
> 
> We could add a bunch of __maybe_unused annotation to all those ehci_*
> functions. What do you say Alan ?

Yes, that makes sense for now.  In the future we'll probably rearrange
things so that the annotations aren't needed, but at the moment this
seems like the best solution.

An alternative would be to add a quirks flag for controllers that don't 
support port handoff.  But that would just create more code for all 
architectures and the end result wouldn't be any better.

Alan Stern

