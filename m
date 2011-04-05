From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Tue, 05 Apr 2011 15:15:51 +0100
Message-ID: <1302012951.1866.144.camel@e102109-lin.cambridge.arm.com>
References: <201104031726.37420.arnd@arndb.de>
	 <20110403160324.GA8050@n2100.arm.linux.org.uk>
	 <201104040259.26601.arnd@arndb.de>
	 <1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>
	 <20110404112104.GB19854@n2100.arm.linux.org.uk>
	 <1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
	 <20110404133104.GA23266@n2100.arm.linux.org.uk>
	 <1301925445.417.54.camel@e102391-lin.cambridge.arm.com>
	 <BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com>
	 <4D9AB958.5010304@ti.com>  <20110405074510.GA4699@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110405074510.GA4699@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, david@lang.hm, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Detlef Vollmann <dv@vollmann.ch>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-04-05 at 08:45 +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2011 at 12:10:24PM +0530, Santosh Shilimkar wrote:
> > The only issue I see is the clock-events implemented using
> > local timers capabilities in low power modes. The local timers
> > won't be able wakeup CPU from DORMANT or OFF state and hence
> > you will need an additional wakeup capable clock-event
> > working together with the local timers using clock-notifiers.
> 
> So yet again, we have something that almost works but doesn't, and
> we're going to have to have board-specific hacks to work around this.
> 
> This makes the architected timers totally *pointless*.

The point of architected timers is that you now get fast access to a
stable clock source with a fixed frequency that doesn't change with
cpufreq. You can also configure the clock source to be accessible from
user space (via another kuser helper) so that you have a fast
gettimeofday implementation (useful in the graphics world). Virtual
counters are another advantage.

The architecture doesn't say much about the power domains, so
implementations are allowed to vary here. Of course it would have been
better if it did but this doesn't make the architected timers totally
pointless (compare them with the A9 timers).

-- 
Catalin
