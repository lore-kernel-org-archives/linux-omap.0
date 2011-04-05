From: Marc Zyngier <Marc.Zyngier@arm.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Tue, 05 Apr 2011 08:30:24 +0100
Message-ID: <1301988624.417.71.camel@e102391-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	 <201104031726.37420.arnd@arndb.de>
	 <20110403160324.GA8050@n2100.arm.linux.org.uk>
	 <201104040259.26601.arnd@arndb.de>
	 <1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>
	 <20110404112104.GB19854@n2100.arm.linux.org.uk>
	 <1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
	 <20110404133104.GA23266@n2100.arm.linux.org.uk>
	 <1301925445.417.54.camel@e102391-lin.cambridge.arm.com>
	 <BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:35964 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751141Ab1DEHaJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 03:30:09 -0400
In-Reply-To: <BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, david@lang.hm, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Detlef Vollmann <dv@vollmann.ch>, David Brown <davidb@codeaurora.org>

On Mon, 2011-04-04 at 22:08 +0200, Linus Walleij wrote:
> 2011/4/4 Marc Zyngier <Marc.Zyngier@arm.com>:
> > On Mon, 2011-04-04 at 14:31 +0100, Russell King - ARM Linux wrote:
> >>
> >> If ARM are going to architect a set of timers into the hardware, let's
> >> make sure that all such hardware has them so we can dig ourselves out
> >> of this crappy mess that we find ourselves in today.
> >
> > As far as I know, A15 always has a set of generic timers.
> >
> > It may be that they are not available (frequency not programmed into the
> > CNTFREQ register), or that someone decided to use a better alternative
> > (for some particular interpretation of "better").
> 
> I guess this thing is inside that A15 core?
> 
> First, what happens the day any vendors start making SoCs on this is
> they turn the A15 core off whenever it is not used, loosing all state
> including this timer, I believe.

The main counter is located in an ALWAYS_ON power domain, and should
keep going whatever happens in the system.

[...]

> Second, have you taken into account the effect of changing the
> frequency of the A15 core, which is something every vendor also
> does, as you know Colin Cross already has a patch pending
> for that on the TWD localtimer which has not yet reached
> the kernel. (Or is A15 fixed frequency? Forgive my ignorance...)

Fixed frequency, with a minimal roll-over time of 40 years.

	M.
-- 
Reality is an implementation detail.


