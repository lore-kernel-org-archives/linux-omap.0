From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: Requirement for DSI video mode support
Date: Wed, 27 Oct 2010 10:17:56 +0300
Message-ID: <1288163876.2580.160.camel@tubuntu>
References: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
	 <1286532774.28499.1088.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034BD6BBEE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17252 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0J0HRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 03:17:43 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BD6BBEE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: ext Jorge Bustamante <jbustamante.init@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Iovescu, Magdalena" <m-iovescu1@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Qassid, Youcef" <y-qassid@ti.com>, "Aguirre, Alberto" <a-aguirre@ti.com>

On Wed, 2010-10-27 at 08:34 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > Hi,
> > 
> > On Mon, 2010-09-20 at 22:18 +0200, ext Jorge Bustamante wrote:
> >> Hi,
> >> 
> >> We (TI) have been working on a DSI video mode driver for OMAP4 and I
> > 
> > I hope it's also for OMAP3?
> > 
> >> am aware that other people are working with similar drivers. We had to
> >> tweak the code to make the drivers work with current code but we would
> >> like to make it the correct way, that is, introducing a proper
> >> functionality instead of inserting tweaks in the present command mode
> >> driver. Therefore, there is an initiative from us to modify current
> >> dss/dsi code to support DSI video mode.
> >> 
> >> We have collected a list of requirements and ideas (with the help of
> >> ppl copied) from our experience working with these drivers, but it
> >> would be great if you can discuss/comment further on this.
> >> 
> >> Requirements:
> >> 
> >> - A better way of exposing VC's to a panel driver, since most panels
> >> use more than one VC. Currently the design supports only one per
> >> panel. Perhaps a VC resource pool could be created.
> > 
> > Hmm, why would most panels use more than one VC? I haven't
> > seen a single one =).
> 
> Command mode panels will work fine with a single VC, I don't think video mode
> can run by using only one VC.

Okay, I think we're talking about different VCs =). It's rather
confusing in the TRM. A VC (in DSI packet sense) refers to the channel
ID sent in the packet, and a VC (in OMAP DSS register sense) refers to a
set of configurations used to send DSI packets. I think we need to come
up with terms that clearly make the distinction between these, because
they really don't have anything in common. (I'd like to hear the
rationale for naming OMAP's config registers as VCs... =).

> Also, for command mode, there isn't a restriction to use a single VC. If you
> configure one VC to have slave port as source and the other as video port, the need
> to switch the VC source between L4 and VP would go away.

This was what I had at some point. However, I was unsure how
transmissions are synchronized in that case. If there's transmission
going on from VP via, say, VC0, and I send a message from L4 via VC1,
what happens? Does VC1 wait until VC0 is done? Or does it send the
packet between VC0's packets?

But I agree, different VCs for L4 and VP usage would make some things a
bit simpler.

> The most optimal way would be to use one VC for each peripheral, but I don't think
> the usecase of connecting 4 panels to the same DSI lanes would ever be needed.

Yes, that is quite unlikely. But it's difficult to say what kind of
devices one needs to connect (see below), but it could be that we may
come up with some kind of rules that fit to all cases.

For example, is there ever need to have to OMAP VCs configured as VP at
the same time? If not, we know that there will always be 3 OMAP VCs free
for L4 use. Etc. (I didn't think this really, just throwing ideas =).

> > 
> > Nevertheless, it should be possible to use multiple VCs in one driver.
> > I've implemented a driver for a buffer chip that used all 4 channels.
> 
> So did you connect more than one panel to DSI? I am curious about how it works

The chip had it's own framebuffer memory, and you could connect two
displays to the chip. The virtual channel mapping was something like
this:
0 - routed to first panel
1 - routed to second panel
2 - buffer chip config
3 - buffer chip framebuffer config

> [snip]
> 
> >> 
> >> - If we want a user to switch between modes, we may need to have a
> > 
> > While I don't see any reason to forbid changing modes, I
> > don't see any real reason to implement switching between the
> > modes either. If it comes for free, sure, but if it means
> > lots of implementation, I'd rather leave it out. Or do you
> > have some use cases where switching modes is important?
> > 
> 
> There isn't any use case where we would use a panel for video mode and
> command mode at different points in time. But if the panel supports both
> video and command mode there should be some option (compile time/ boot time)
> to choose which mode is to be used. I guess its more for the sake of completeness
> of the panels capabilities.

I agree.

 Tomi


