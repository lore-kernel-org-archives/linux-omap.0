From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Mon, 14 May 2012 08:36:42 +0100
Message-ID: <WC20120514073642.6306D7@terrafix.co.uk>
References: <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk> <1336050442.14378.10.camel@deskari> <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari> <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk> <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari> <1336483598.5761.45.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:44325 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483Ab2ENHhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 03:37:04 -0400
In-Reply-To: <1336483598.5761.45.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Any news on this?

This thread seems to have gone a little quiet...

Cheers,
Joe

-----Original Message-----
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Paul Walmsley <paul@pwsan.com>, khilman@ti.com
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, Joe Woodward <jw@terrafix.co.uk>
Date: Tue, 08 May 2012 16:26:38 +0300
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)

> On Fri, 2012-05-04 at 17:58 +0300, Tomi Valkeinen wrote:
> > On Fri, 2012-05-04 at 17:54 +0300, Tomi Valkeinen wrote:
> > > Hi Kevin, Paul,
> > > 
> > > On Fri, 2012-05-04 at 15:09 +0100, Joe Woodward wrote:
> > > 
> > > > > > Ok, I can replicate it now. It seems to be somehow PM
> related. I
> > > > > > normally have USB gadget stuff compiled into kernel so that I
> can
> > > > > boot
> > > > > > via nfsroot with usb. After disabling USB support from the
> kernel, I
> > > > > can
> > > > > > see synclosts.
> > > > > > 
> > > > > > I have no idea yet what could be causing this. I've also
> tried adding
> > > > > > the couple of DSS patches which are in queue for next merge
> window,
> > > > > that
> > > > > > force OPP100 when DSS is enabled. They don't seem to help.
> > > > > 
> > > > > Also, at least on my setup, the sync lost doesn't happen very
> quickly
> > > > > after starting the video output, but (I think) only when the
> system
> > > > > starts to idle. My init scripts generate keys for sshd and some
> other
> > > > > stuff, and no sync lost there, only just before the shell
> prompt do I
> > > > > get a sync lost.
> > > > > 
> > > > >  Tomi
> > > > > 
> > > > 
> > > > That sounds like the same as I'm seeing. It seems that the sync
> lost jumps 
> > > > around a bit, from almost immediately (when the graphics are
> enabled), to 
> > > > up to 3 or 4 seconds later (still just before the shell prompt).
> > > > 
> > > > I'm assuming that setting the FIFO low and high points fixes your
> sync losts 
> > > > as well (as in the first patch you sent)?
> > > > 
> > > > I've also noted that doing things in different orders can
> sometimes fix the 
> > > > sync lost (such as disabling or enabling DVI output), but this
> all seems a bit 
> > > > random.
> > > > 
> > > > I'm just glad someone else has been able to replicate the problem
> :p
> > > 
> > > Kevin, Paul, there seems to be a problem with DSS on v3.4-rc4
> running on
> > > omap3, causing DSS losing sync. I didn't notice this earlier as I
> have
> > > USB gadget compiled into my kernel. Removing USB support from the
> kernel
> > > causes the problem to appear, which more or less hints at a PM
> related
> > > issue.
> > 
> > Sorry, not sync lost, but FIFO underflow. So DSS is unable to fetch
> > enough pixels to update the panel. And in this case the pixel clock
> is
> > very low (small panel), so it's nowhere near any limit.
> 
> And two more interesting points about the problem:
> 
> Setting DISPC's SIDLEMODE to no-idle seems to remove the issue.
> 
> With some DISPC's fifo high/low threshold values things seem to work,
> while with others we get underflows. And as the required bandwidth here
> is quite small, and the threshold values I tested are close to each
> other, I don't think it's really a proper bandwidth issue.
> 
> I'm guessing that certain threshold values cause somehow un-optimal
> accesses to the memory, and with smart-idle this somehow causes
> problems.
> 
> Archit, you looked into the thresholds some time ago. I recall that
> some
> threshold values were "bad" in some way? Were those only for OMAP4?
> 
>  Tomi
> 


