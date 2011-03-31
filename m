From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 12:11:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103310928240.22418@localhost6.localdomain6>
References: <20110317183048.GW7258@atomide.com> <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com> <20110318101512.GA15375@n2100.arm.linux.org.uk> <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <20110331001502.GB6680@n2100.arm.linux.org.uk> <AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com> <alpine.LFD.2.00.1103302319290.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103302319290.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

B1;2401;0cOn Thu, 31 Mar 2011, Nicolas Pitre wrote:
> On Wed, 30 Mar 2011, Linus Torvalds wrote:
> > And ARM fanbois can say "oh, but arm is special" all they want, but
> > they need to realize that the lack of common platform for ARM is a
> > real major issue. It's not a "feature", and I'm sorry, but anybody who
> > calls x86 "peanuts" is a moron and should be ashamed of himself.
> > Instead of trying to feel superior, those people should feel like
> > pariah.
> 
> Oh come on.  You just provided actual numbers above showing that ARM is 
> simply fscked up (your words) compared to X86.  I would be curious to 
> know what people like tglx who did significant work on both 
> architectures actually think of X86 relative to ARM when it comes to 
> kernel maintenance.

To be honest both suck in their own way. The only reason why x86 is
slightly less horrible is the fact that it's better architectured at
the hardware level.

But I see the same mess coming in with all those wonderful Atom based
SoCs on the horizon, which are nothing else than any other random ARM
SoC, just that they glue an x86 core into the same cheepo random IP
peripherals conglomerate. In fact some of those chip have been ARM
powered before they got an x86 injected.

And worse: the Intel folks went there and wrote a new driver for an IP
block which had already an "ARM associated" driver.

So I say that it is not only an ARM problem, it's a general problem
that people do not realize that the IP cores are reused all over the
place and across architectures.

I'm pretty sure after I went through all the irq code recently that
lots of those ARM SoCs from vendors across the board could share a lot
of driver code if someone would actually sit down and analyse the
situation. Right now we have nobody who has the time and the stomach
to go through this and at the same time prevent that more copied
crappola is hitting the tree.

I'm sure that device tree is part of the solution, but that only helps
if we find a way to prevent duplicate drivers in the first place.

Thanks,

	tglx
