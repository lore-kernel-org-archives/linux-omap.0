From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 17:50:17 +0200
Message-ID: <201104011750.17344.arnd@arndb.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <201104011659.40443.arnd@arndb.de> <4D95EF8E.9080902@vollmann.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D95EF8E.9080902@vollmann.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Detlef Vollmann <dv@vollmann.ch>
Cc: Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 01 April 2011, Detlef Vollmann wrote:
> On 04/01/11 16:59, Arnd Bergmann wrote:
> > On Friday 01 April 2011, Detlef Vollmann wrote:
> >> On 04/01/11 15:54, Arnd Bergmann wrote:
> >
> >>> 9. All interesting work is going into a handful of platforms, all of which
> >>>      are ARMv7 based.
> >> Define interesting.
> >
> > The ones that are causing the churn that we're talking about.
> > Platforms that have been working forever and only need to get
> > the occasional bug fix are boring, i.e. not the problem.
> In the ARM tree I only know mach-at91.
> Atmel still introduces new SOCs based on ARM926EJ-S, and that makes
> perfect sense for lots of applications.

I thought new ones were generally Cortex-M3 based. Either way, even
if there are exceptions, focusing on ARMv7 at first should give
a good representation of the new development.

> >>> 12. Supporting many different boards with a single kernel binary is a
> >>>       useful goal.
> >> Generally not for embedded systems (for me, a mobile PDA/phone is just a
> >> small computer with a crappy keyboard, but not an embedded system).
> >
> > True. For embedded, this would not be an important thing to do, but
> > also not hurt.
> It costs you flash space.

Well, the idea was not to force everyone to enable all options. When this
is done right, the kernel would not be any bigger.

> >>> * Strictly no crap
> >>>    * No board files
> >> Where do you put code that needs to run very early (e.g. pinging the
> >> watchdog)?
> >
> > Don't know. I'd hope we can get fast enough to the phase where device
> > drivers get initialized.
> Nope, never happened for me :-(
> (Watchdog timeouts are often 1s or less.)

1s is a long time. Most of the boot process is drivers anyway, so we
just need to make sure that the watchdog is early enough.

> > I believe that rule is generally accepted today, but we don't always
> > enforce it.
> Without device tree, Kconfig option is the only way that really
> works today (no runtime HW detection, and same board ID with different
> setups).

I believe that has never been an accepted way of doing things, you are
supposed to get a new board ID for every new board, hence the name ;-).

	ARnd
