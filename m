From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Problems with 3.4-rc5
Date: Fri, 04 May 2012 15:09:43 +0100
Message-ID: <WC20120504140943.7604D0@terrafix.co.uk>
References: <WC20120502115251.8503FF@terrafix.co.uk> <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk> <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk> <1336050442.14378.10.camel@deskari> <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari> <1336140072.2552.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:60906 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755634Ab2EDOJz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 10:09:55 -0400
In-Reply-To: <1336140072.2552.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org



-----Original Message-----
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
Date: Fri, 04 May 2012 17:01:12 +0300
Subject: Re: Problems with 3.4-rc5

> On Fri, 2012-05-04 at 16:50 +0300, Tomi Valkeinen wrote:
> > On Fri, 2012-05-04 at 10:19 +0100, Joe Woodward wrote:
> > > -----Original Message-----
> > >  From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > >  To: Joe Woodward <jw@terrafix.co.uk>
> > >  Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
> > >  Date: Thu, 03 May 2012 16:07:22 +0300
> > >  Subject: Re: Problems with 3.4-rc5
> > >  
> > > > On Thu, 2012-05-03 at 09:49 +0100, Joe Woodward wrote:
> > >  > 
> > > > > Both patches together results in slightly different behaviour,
> the
> > >  > display is still broken- 
> > > > > it flickers on and off with occassional underflows before
> breaking
> > >  > completely.
> > >  > 
> > > > Beagle works fine for me with omap2plus based config, and I think
> overo
> > >  > also although I can't test it now as I broke my micro mmc
> adapter.
> > >  > 
> > > > Can you send your panel definition? Any other things that could
> affect
> > >  > display? Do you have PM enabled? Can you share your kernel
> config?
> > >  > 
> > > >  Tomi
> > >  > 
> > > 
> > > I've gone back to a test setup others can replicate.
> > 
> > Ok, I can replicate it now. It seems to be somehow PM related. I
> > normally have USB gadget stuff compiled into kernel so that I can
> boot
> > via nfsroot with usb. After disabling USB support from the kernel, I
> can
> > see synclosts.
> > 
> > I have no idea yet what could be causing this. I've also tried adding
> > the couple of DSS patches which are in queue for next merge window,
> that
> > force OPP100 when DSS is enabled. They don't seem to help.
> 
> Also, at least on my setup, the sync lost doesn't happen very quickly
> after starting the video output, but (I think) only when the system
> starts to idle. My init scripts generate keys for sshd and some other
> stuff, and no sync lost there, only just before the shell prompt do I
> get a sync lost.
> 
>  Tomi
> 

That sounds like the same as I'm seeing. It seems that the sync lost jumps 
around a bit, from almost immediately (when the graphics are enabled), to 
up to 3 or 4 seconds later (still just before the shell prompt).

I'm assuming that setting the FIFO low and high points fixes your sync losts 
as well (as in the first patch you sent)?

I've also noted that doing things in different orders can sometimes fix the 
sync lost (such as disabling or enabling DVI output), but this all seems a bit 
random.

I'm just glad someone else has been able to replicate the problem :p

Cheers,
Joe



