From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 14:04:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103311359320.22418@localhost6.localdomain6>
References: <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com> <alpine.LFD.2.00.1103301531420.28032@xanadu.home> <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com> <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
 <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm> <alpine.LFD.2.00.1103302255280.28032@xanadu.home> <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm> <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <20110331080634.GA18022@elte.hu>
 <20110331083044.GB14323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331083044.GB14323@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@fluxnic.net>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 31 Mar 2011, Russell King - ARM Linux wrote:

> On Thu, Mar 31, 2011 at 10:06:34AM +0200, Ingo Molnar wrote:
> > Having strong, effective platform abstractions inside the kernel really helps 
> > even if the hardware space itself is inevitably fragmented: both powerpc and 
> > x86 has shown that. Until you realize and appreciate that you really have not 
> > understood the problem i think.
> 
> No, I think it is the other way around.  Folk like me and Nicolas over
> the last ten years have put considerable amounts of effort into trying
> to keep the ARM support code as clean and maintainable as possible.
> 
> That is true of the common ARM stuff, but there's no way we can do this
> for all SoC support - there aren't the hours in the day to provide such

That's what I said. You and Nicholas wont scale.

> a wide oversight.  That's why we have SoC maintainers, and the SoC
> maintainers have the responsibility to sort out their own sub-trees.

But the current SoC maintainer model does not work either. The SoC
maintainers care about their sandbox and have exactly zero incentive
to look at the overall picture, e.g reuse of code for the same IP
blocks, better abstraction mechanisms etc. 

Therefor you need a team of experienced kernel developers which are
NOT associated with a particular vendor who are able to tame that SoC
crowd and work closely with you and Nicholas to keep stuff in sync.

Thanks,

	tglx
