From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 09:30:45 +0100
Message-ID: <20110331083044.GB14323@n2100.arm.linux.org.uk>
References: <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com> <alpine.LFD.2.00.1103301531420.28032@xanadu.home> <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com> <alpine.LFD.2.00.1103301814250.28032@xanadu.home> <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm> <alpine.LFD.2.00.1103302255280.28032@xanadu.home> <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm> <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <20110331080634.GA18022@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110331080634.GA18022@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Nicolas Pitre <nico@fluxnic.net>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 31, 2011 at 10:06:34AM +0200, Ingo Molnar wrote:
> Having strong, effective platform abstractions inside the kernel really helps 
> even if the hardware space itself is inevitably fragmented: both powerpc and 
> x86 has shown that. Until you realize and appreciate that you really have not 
> understood the problem i think.

No, I think it is the other way around.  Folk like me and Nicolas over
the last ten years have put considerable amounts of effort into trying
to keep the ARM support code as clean and maintainable as possible.

That is true of the common ARM stuff, but there's no way we can do this
for all SoC support - there aren't the hours in the day to provide such
a wide oversight.  That's why we have SoC maintainers, and the SoC
maintainers have the responsibility to sort out their own sub-trees.
