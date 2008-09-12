From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Sat, 13 Sep 2008 01:31:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
 <200809121216.27116.david-b@pacbell.net>
 <20080912192158.GG10675@atomide.com>,<20080912192809.GF7132@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51523 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbYILUBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 16:01:43 -0400
In-Reply-To: <20080912192809.GF7132@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> On Behalf Of Felipe Balbi [me@felipebalbi.com]
> On Fri, Sep 12, 2008 at 12:21:59PM -0700, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [080912 12:18]:
> > > On Friday 12 September 2008, Felipe Balbi wrote:
> > > >         /* Enusre bit is set */
> > >
> > > My Cortex Mark-I (cerebral, humanoid) treats that as a compile error ... :)
> >
> > Have you tried preprocessing with squint? :)
> 
> ehehe, it's not in my diff, so it wasn't me. :-p
> I'll fix it in the final clean up

Was planning on cleaning up this driver and sending to linux-omap as Tony
suggested, but I'm afraid I won't be able to look at it for a while.

So if you're going to be doing this anyway, then could you please meld in
Vikram's other patch from [1] as well?

By the way, how do you propose to test this driver? Do you have the
expansion board for the SDP, or some other hardware that can be used?

Also, while we're discussing this driver, a few points to be resolved:

1. TLL vs PHY mode needs to be set somewhere. Me thinks this information ought
to come from board-specific data and the driver would need to set things up
accordingly. What would be a good way to do this?

2. The OHCI driver (not yet in linux-omap and not in a shape to go ought at the
moment either) would need to touch a lot of common registers during init/exit/re-init.
Any ideas where to put this code such that we can have the EHCI driver, or the
OHCI driver, or both loaded and unloaded at will and still working without interfering
with each other.

3. For OHCI, the transceiver used on the expansion board happens to be an ISP1301
for which there currently exists a driver (drivers/i2c/chips/isp1301_omap.c). Since this is
meant to be an OTG transceiver, the driver does otg_set_transceiver.
But MUSB is the OTG controller and has it's own transceiver... and we can't have two of 
those, right? :) Ideas welcome.

Regards,
Anand

[1] http://marc.info/?l=linux-omap&m=121483462926647&w=2