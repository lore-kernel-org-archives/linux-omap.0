From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Tue, 5 Apr 2011 08:45:10 +0100
Message-ID: <20110405074510.GA4699@n2100.arm.linux.org.uk>
References: <201104031726.37420.arnd@arndb.de> <20110403160324.GA8050@n2100.arm.linux.org.uk> <201104040259.26601.arnd@arndb.de> <1301915022.15819.28.camel@e102109-lin.cambridge.arm.com> <20110404112104.GB19854@n2100.arm.linux.org.uk> <1301923457.417.34.camel@e102391-lin.cambridge.arm.com> <20110404133104.GA23266@n2100.arm.linux.org.uk> <1301925445.417.54.camel@e102391-lin.cambridge.arm.com> <BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com> <4D9AB958.5010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D9AB958.5010304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, david@lang.hm, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Detlef Vollmann <dv@vollmann.ch>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2011 at 12:10:24PM +0530, Santosh Shilimkar wrote:
> The only issue I see is the clock-events implemented using
> local timers capabilities in low power modes. The local timers
> won't be able wakeup CPU from DORMANT or OFF state and hence
> you will need an additional wakeup capable clock-event
> working together with the local timers using clock-notifiers.

So yet again, we have something that almost works but doesn't, and
we're going to have to have board-specific hacks to work around this.

This makes the architected timers totally *pointless*.
