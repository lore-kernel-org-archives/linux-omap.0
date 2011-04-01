From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 13:32:35 +0200
Message-ID: <201104011332.35618.arnd@arndb.de>
References: <201103301906.42429.arnd@arndb.de> <201103311723.02301.arnd@arndb.de> <alpine.LFD.2.00.1103311826070.22418@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103311826070.22418@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@fluxnic.net>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 31 March 2011, Thomas Gleixner wrote:
> On Thu, 31 Mar 2011, Arnd Bergmann wrote:
>
> Right, but the problem starts in way simpler areas like irq chips and
> gpio stuff, where lots of the IP cores are similar and trivial enough
> to be shared across many SoC families.

Yes, I'm sure that there are more obvious examples than the ones I've
given, those were just the ones that I had noticed myself.
 
> Even the OMAP "consolidated" code is silly:
>
> But the code above has 6 cases in the switch because nobody abstracted
> it out consequently. Not to talk about the ifdef mess.

Nice illustration.

	Arnd
