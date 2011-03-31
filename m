From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 10:06:34 +0200
Message-ID: <20110331080634.GA18022@elte.hu>
References: <20110318101512.GA15375@n2100.arm.linux.org.uk>
 <201103301906.42429.arnd@arndb.de>
 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
 <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
 <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
 <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
 <alpine.LFD.2.00.1103302255280.28032@xanadu.home>
 <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
 <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org


* Nicolas Pitre <nico@fluxnic.net> wrote:

> On Wed, 30 Mar 2011, david@lang.hm wrote:
> 
> > back in the early days of the PCs, different systems from different vendors
> > had different bus types, peripherals at different addresses, etc. that didn't
> > make all of those vendors systems different architectures, instead those
> > things were varients of the x86 architecture.
> 
> Most of them didn't survive.  That really helps.

That's not the point, 99% of the current ARM boards will not 'survive' either, 
10-20 years down the road.

I think you missed David's main point: life inevitably went on and few of the 
old x86 hardware 'survived' physically, but past hardware versions have not 
littered the kernel source with half a million lines of source code in the 
process ...

Having strong, effective platform abstractions inside the kernel really helps 
even if the hardware space itself is inevitably fragmented: both powerpc and 
x86 has shown that. Until you realize and appreciate that you really have not 
understood the problem i think.

Thanks,

	Ingo
