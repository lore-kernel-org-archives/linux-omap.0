From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 15:07:23 -0800
Message-ID: <20131210230722.GZ13171@atomide.com>
References: <pull-1386643347-596413>
 <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
 <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33190 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3LJXH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 18:07:29 -0500
Content-Disposition: inline
In-Reply-To: <20131210192726.GR13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131210 11:28]:
> * Tony Lindgren <tony@atomide.com> [131210 11:00]:
> > * Paul Walmsley <paul@pwsan.com> [131210 10:47]:
> > > On Mon, 9 Dec 2013, Tony Lindgren wrote:
> > > 
> > > > The following changes since commit f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:
> > > > 
> > > >   ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-signed
> > > > 
> > > > for you to fetch changes up to 736e812636ea72be444b85fa7e92554967459069:
> > > > 
> > > >   ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)
> > > 
> > > The description in Tony's pull request below alludes to what regressions 
> > > will occur when this is pulled.  But just to state it in terms of what 
> > > happened on the local testbed here when I tried it:
> > > 
> > > - CM-T3517 booting will break since there's no .dts file for it.  Are
> > >   there other boards that will be affected here too?
> > 
> > Yeah the cm-t3770 is on my todo list, but I've left it last as it's my
> > home router and has been behaving quite nicely.
> > 
> > That should then cover:
> > 
> > SBC-T3530
> > http://compulab.co.il/products/sbcs/sbc-t3530/
> > 
> > SBC-T3517
> > http://compulab.co.il/products/sbcs/sbc-t3517/
> > 
> > SBC-T3730
> > http://compulab.co.il/products/sbcs/sbc-t3730/
> > 
> > They all seem to have the same baseboard, and the CPU module is
> > different. So getting the 3530 and 3517 variants working should
> > be trivial. I don't have 3530 or 3517 variants, so somebody else
> > will need to do those two.
> > 
> > And Nishant just posted a .dts file for the 3517 craneboard.
> 
> And here's a list of other boards we don't have .dts file for if
> people have these:
> 
> board-devkit8000.c		omap3-ldp.dts or omap3-beagle.dts is a good starting point

Oops, sorry this one we already have covered with omap3-devkit8000.dts.
And please ignore the multiple comments, they all are pretty close to
omap3-ldp and omap3-beagle.

> board-omap3logic.c		omap3-ldp.dts or omap3-beagle.dts is a good starting point
> board-omap3pandora.c		omap3-ldp.dts or omap3-beagle.dts is a good starting point
> board-omap3stalker.c
> board-omap3touchbook.c
> 
> For the ones above, omap3-ldp.dts or omap3-beagle.dts are good starting
> points. There's the DPI display pdata patch too, but it seems we want to
> wait to see if Tomi gets his display changes done before applying that.
> 
> I don't have any of the ones above, so people using those please
> do the .dts files ASAP.
> 
> Or send me those boards with working boot loaders and I'll do them at
> a rate of one board per day or so.. And then you're stuck with my
> criteria of "usable" which is usually serial port and NFS root unless
> I really like the board, mhuwahuaaaahh!
> 
> board-ti8168evm.c
> 
> I doubt ti8168evm has even worked for a long time.. It's in pretty
> sorry state unfortunately with missing clock support and missing
> handle_irq entry in the board-ti8168evm.c.
> 
> Regards,
> 
> Tony
