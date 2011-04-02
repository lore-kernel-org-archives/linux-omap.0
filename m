From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Sat, 2 Apr 2011 04:27:33 +0100
Message-ID: <20110402032733.GC13341@sirena.org.uk>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <201104011554.07924.arnd@arndb.de> <1301671655.28467.52.camel@e102144-lin.cambridge.arm.com> <201104011755.57412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201104011755.57412.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 01, 2011 at 05:55:57PM +0200, Arnd Bergmann wrote:
> On Friday 01 April 2011, Will Deacon wrote:

> > I don't understand how you can handle `early quirks' without board
> > files. Does this follow on from Linus' suggestion about moving code out
> > of the kernel and into the bootloader?

> There are multiple ways of dealing with this. One way would be to
> mandate that the boot loader does the quirks, ideally as little
> as possible.

Though we then get into the issues with bootloader quality and risk 

> Another option is to have a boot wrapper with board specific code,
> which gets run between the regular boot loader and the common
> kernel entry point. We might need such a wrapper anyway to pass the
> device tree to the kernel.

This sounds an awful lot like a board file which doesn't get to use any
of the in-kernel infrastructure like bus controller drivers or chip
drivers to help which feels retrograde.  I understand where you're
coming from on this but an absolute ban feels overly restrictive here,
it seems like we'd be better off allowing board files but pushing back
strongly on anything that should be data...

> > Realistically, I don't think you will ever get away from board files.
> > The trick is probably to make them as small as possible and common to as
> > many boards as possible (like the platforms directory for PowerPC).

> Perhaps. But we can start out with strict rules and add exceptions
> later when we run out of options.

...which is pretty much what you're saying here.
