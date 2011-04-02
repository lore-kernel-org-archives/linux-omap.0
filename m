From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Sat, 2 Apr 2011 06:38:04 +0200
Message-ID: <20110402043804.GB3989@riccoc20.at.omicron.at>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <201104011554.07924.arnd@arndb.de>
 <1301671655.28467.52.camel@e102144-lin.cambridge.arm.com>
 <201104011755.57412.arnd@arndb.de>
 <alpine.LFD.2.00.1104011557080.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104011557080.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 01, 2011 at 04:19:31PM -0400, Nicolas Pitre wrote:
> 
> In a perfect world the bootloader would be bug free and always up to 
> date with the best DT data.  In practice I'm very skeptical this will 
> always be the case and painless.  At least the above makes it very 
> simple to have a self contained kernel when (not if) need be.

Yes, my experience with DT on powerpc teaches me that, although DT
sounds wonderful in theory, in practice kernel/dtb/uboot form a love
triangle (or perhaps a hate triangle) where all three points must be
exactly up to date with each other. If one part is even just a month
or two too old/new, then your kernel might not boot.

Richard
