From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Fri, 21 May 2010 23:15:57 +0100
Message-ID: <20100521221557.GM11042@n2100.arm.linux.org.uk>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com> <20100521215730.GK11042@n2100.arm.linux.org.uk> <AANLkTin03gFY1uc9__lGO8lHiKMjuSBRSYcFDhLYDIMD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35887 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758710Ab0EUWQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 18:16:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin03gFY1uc9__lGO8lHiKMjuSBRSYcFDhLYDIMD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@nokia.com>

On Sat, May 22, 2010 at 01:09:12AM +0300, Felipe Contreras wrote:
> On Sat, May 22, 2010 at 12:57 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The only reason 3 would be loaded due to that dependency is if 2 were
> > being modprobed, which means it's going to be inserted after 3 anyway.
> >
> > I don't see anything else in 3 which would trigger it to be loaded.
> >
> > The "platform:omap2-mailbox" module alias of 2 should result in 2
> > being modprobed,
> 
> I see, at initialization?

That's the theory - and it should be that same mechanism which allows
things like already plugged in PCMCIA and the like cards to be properly
dealt with at boot time.

> > causing 3 to be loaded to satisfy the dependency.
> > As already pointed out, this should happen as a result of udev or
> > (older) hotplug initialization.
> 
> Well, in the minimal system I have in my beagleboard it doesn't
> happen. I load bridgedriver, which loads mailbox, but fails
> immediately because mailbox_mach is not there.

I assume that having the MMC host driver built in, but the MMC block
driver as a module also doesn't work on your setup?

I don't see this as something that should be worked around in the
kernel by making things non-modular - I view the missing userspace
functionality causing the problem.
