From: Marc Zyngier <Marc.Zyngier@arm.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Mon, 04 Apr 2011 14:57:25 +0100
Message-ID: <1301925445.417.54.camel@e102391-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	 <201104031726.37420.arnd@arndb.de>
	 <20110403160324.GA8050@n2100.arm.linux.org.uk>
	 <201104040259.26601.arnd@arndb.de>
	 <1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>
	 <20110404112104.GB19854@n2100.arm.linux.org.uk>
	 <1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
	 <20110404133104.GA23266@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110404133104.GA23266@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: david@lang.hm, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Detlef Vollmann <dv@vollmann.ch>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-04-04 at 14:31 +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2011 at 02:24:17PM +0100, Marc Zyngier wrote:
> > On Mon, 2011-04-04 at 12:21 +0100, Russell King - ARM Linux wrote:
> > > Whether its worth it or not is questionable - the above is more lines
> > > of code than many of the existing implementations, and we're not going
> > > to shrink the existing implementations by much (maybe one to three
> > > lines.)  The only thing we gain is the ability to select an implementation
> > > at runtime.
> > 
> > I believe this last point to be rather important if we plan to have this
> > mythical single kernel covering several architectures. It's also nice
> > for the A15 to be able to use some default sched_clock() implementation
> > as a fallback if the generic timers are not available for some reason.
> 
> If ARM are going to architect a set of timers into the hardware, let's
> make sure that all such hardware has them so we can dig ourselves out
> of this crappy mess that we find ourselves in today.

As far as I know, A15 always has a set of generic timers.

It may be that they are not available (frequency not programmed into the
CNTFREQ register), or that someone decided to use a better alternative
(for some particular interpretation of "better").

Overall, it seems like we need some degree of flexibility to have
several sched_clock() implementations within a single image, whether it
is to support multiple platforms, or to allow a single architecture to
pick the best alternative given a set of initial conditions.

	M.
-- 
Reality is an implementation detail.
