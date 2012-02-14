From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: host: ehci: allow ehci_* symbols to be unused
Date: Tue, 14 Feb 2012 15:11:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202141505400.1544-100000@iolanthe.rowland.org>
References: <20120214160114.GA11841@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36078 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757060Ab2BNULn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 15:11:43 -0500
In-Reply-To: <20120214160114.GA11841@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 14 Feb 2012, Felipe Balbi wrote:

> > The others are questionable.  What reason could there be for not 
> > implementing ehci_bus_suspend and ehci_bus_resume?  Neither of those 
> > should involve much platform-specific work, if any.
> 
> you never know what kind of silicon erratas might come up, right ? :-)

Well, when they come up we can annotate those routines.

> > ehci_hub_status_data, ehci_hub_descriptor, and ehci_hub_control are 
> > even more puzzling.  These are things that _have_ to be implemented for 
> > the driver to work at all.  Platform code shouldn't replace them; it 
> > most it should call them as subroutines and override the results when 
> > necessary.
> 
> There's no doubt it needs to be implemented, but the fact is that in
> some situations we might need to implement it differently because of
> whatever reason.
> 
> See for example that I have a pending workaround to implement for
> OMAP3 EHCI where we need to reparent a clock before handling
> SetFeature(port_suspend) so I would need to reimplement
> echi_hub_control() in order not to expose that detail to core ehci.
> 
> Because clock reparenting is something so ARCH-specific it makes no
> sense to come up with a "quirk" flag for that.
> 
> Granted, the way I had envisioned, I would reimplement the particular
> request that needs special handling and call the generic
> ehci_hub_control() otherwise, but still. Like I said, you never know
> what kind of erratas could pop up.

It's hard to imagine what sort of errata could require you not to call
the generic routine.  Besides, it's a big routine, and duplicating it
in platform-specific code would be a big waste.

For now I think you should annotate just the three routines that really
need it.  This is analogous to patches that add new features with no
usages in the kernel; we just don't do such things.

Alan Stern

