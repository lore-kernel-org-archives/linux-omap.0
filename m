From: David Brownell <david-b@pacbell.net>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 13:30:01 -0700
Message-ID: <200809121330.02192.david-b@pacbell.net>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912192809.GF7132@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:25275 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752541AbYILUaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 16:30:04 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Friday 12 September 2008, Gadiyar, Anand wrote:
> 1. TLL vs PHY mode needs to be set somewhere. Me thinks this information ought
> to come from board-specific data and the driver would need to set things up
> accordingly. What would be a good way to do this?

Define an ehci_omap_platform_data struct and use it for
the stuff that shouldn't be in mach-omap2 ... I seem to
not understand why there would be a question here.


> 2. The OHCI driver (not yet in linux-omap and not in a shape to go ought at the
> moment either) would need to touch a lot of common registers during init/exit/re-init.
> Any ideas where to put this code such that we can have the EHCI driver, or the
> OHCI driver, or both loaded and unloaded at will and still working without interfering
> with each other.

Sounds like code that can live in mach-omap2 and be called
when the drivers start or stop.


> 3. For OHCI, the transceiver used on the expansion board happens to be an ISP1301
> for which there currently exists a driver (drivers/i2c/chips/isp1301_omap.c). Since this is
> meant to be an OTG transceiver, the driver does otg_set_transceiver.

And does OMAP2 have the OMAP1 OTG controller?  If not, then
you can't use that driver.


> But MUSB is the OTG controller and has it's own transceiver... and we can't have two of 
> those, right? :) Ideas welcome.

You'll need a new driver; since it's host only, it would only
need to be a little stub.  The interface shouldn't matter much;
just make it general enough that other hardware could use it.
(Nothing OMAP-specific, etc.)

- Dave

