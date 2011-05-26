From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 26 May 2011 15:38:08 +0200
Message-ID: <20110526133807.GA1664@ucw.cz>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <201104020008.16795.arnd@arndb.de>
 <alpine.LFD.2.00.1104012129320.28032@xanadu.home>
 <201104031726.37420.arnd@arndb.de>
 <20110403160324.GA8050@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110403160324.GA8050@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Detlef Vollmann <dv@vollmann.ch>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi!

> There's a number of down-counting clocksources using various methods to
> convert to an up-counting value - sometimes -readl(), sometimes
> cs->mask - readl() and sometimes ~readl().
> 
> Then there's those which are either 16-bit or 32-bit, and some of those
> 16-bit implementations must use readw() to avoid bus faults.
> 
> Combining all those together you end up with something pretty disgusting,
> and an initialization function taking 7 arguments (iomem pointer, name,
> rating, tick rate, size, up/down counter, clocksource flags).

Having structure with 7 fields describing the clock source  seems
completely sane...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
