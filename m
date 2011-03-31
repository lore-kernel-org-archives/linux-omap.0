From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 20:55:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103312041580.31043@localhost6.localdomain6>
References: <201103301906.42429.arnd@arndb.de> <alpine.LFD.2.00.1103311359320.22418@localhost6.localdomain6> <87d3l7jqpr.fsf@ti.com> <201103311723.02301.arnd@arndb.de> <alpine.LFD.2.00.1103311826070.22418@localhost6.localdomain6>
 <alpine.LFD.2.00.1103311400190.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103311400190.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 31 Mar 2011, Nicolas Pitre wrote:

> On Thu, 31 Mar 2011, Thomas Gleixner wrote:
> 
> > Start off with such a trivial, but immense effective cleanup and see
> > what it helps to share code even accross SoC vendors. They all glue
> > together random IP blocks from the market and there are not soo many
> > sources which are relevant. This makes sense in all aspects:
> > 
> >       1) less and better code
> >       2) faster setup for new SoCs
> >       3) shared benefit for all vendors
> 
> If this was always true.  Someone commented on the fact that the IP 
> block providing USB on OMAP is shared with a couple other platforms.  
> But about 2600 lines of pure glue is still necessary around the common 
> driver to make it work for everyone.  I'm not saying that separate 
> drivers are called for here, simply that hardware people _will_ screw it 
> up, especially when they are hooking it up to a non-standard 
> SOC-specific bus.

Right. That's a problem, but we should not ignore the places where
reusing stuff is easy possible. And making good examples out of it.

And it really _IS_ worth the trouble. Look at the git log of
drivers/spi/pxa2xx* . We could have slapped the other "x86" driver
into spi, but that does not make any sense from a software engineering
and maintainability POV. And it would have been more work in the end
to cleanup the separate driver than isolating the existing one and
reuse it.

This is a sustainability issue. And we need to become more clever
about identifying the places where we can abstract stuff into shared
drivers and infrastructure when we want to sustain Linux for another
few decades.

> And what would the hardware guys tell you?  That software is cheap.

If you can prove with simple examples that using existing software
removes 6 month of useless reinventing the wheel and another 6 month
of testing plus the fight with the kernel folks, then eventually they
start to listen as you can express this in $$$.

Thanks,

	tglx
