From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 12:41:52 +0200
Message-ID: <20110331104152.GB3723@elte.hu>
References: <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
 <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
 <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
 <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
 <alpine.LFD.2.00.1103302255280.28032@xanadu.home>
 <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
 <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <20110331080634.GA18022@elte.hu>
 <20110331083044.GB14323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110331083044.GB14323@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org


* Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Mar 31, 2011 at 10:06:34AM +0200, Ingo Molnar wrote:
> > Having strong, effective platform abstractions inside the kernel really helps 
> > even if the hardware space itself is inevitably fragmented: both powerpc and 
> > x86 has shown that. Until you realize and appreciate that you really have not 
> > understood the problem i think.
> 
> No, I think it is the other way around.  Folk like me and Nicolas over the 
> last ten years have put considerable amounts of effort into trying to keep 
> the ARM support code as clean and maintainable as possible.

Absolutely no argument about that, whenever i have read core ARM code it was 
always a pleasure. You guys are doing a fine job there.

What i argued with was what Nicolas said:

  > > > back in the early days of the PCs, different systems from different 
  > > > vendors had different bus types, peripherals at different addresses, 
  > > > etc. that didn't make all of those vendors systems different 
  > > > architectures, instead those things were varients of the x86 
  > > > architecture.
  > >
  > > Most of them didn't survive.  That really helps.

It does not matter whether hardware survives or not - most pieces of hardware 
do not survive. What matters is whether the inevitable hardware-churn is 
allowed to litter the kernel tree with unmaintainable pieces of crap.

You even mention that it's not maintainable to you:

> That is true of the common ARM stuff, but there's no way we can do this for 
> all SoC support - there aren't the hours in the day to provide such a wide 
> oversight. [...]

The problem is the solution:

> That's why we have SoC maintainers, and the SoC maintainers have the 
> responsibility to sort out their own sub-trees.

... which sets the wolves to mind the sheep, so to say. Self-oversight never 
worked very well (unless you believe in perpetual bank bailouts).

So Linus and Thomas (with the genirq hat on) are pushing back, because both of 
them feel affected negatively by crap.

"All is fine" or "it's just natural" do not seem like the right answers to 
those concerns.

Thanks,

	Ingo
