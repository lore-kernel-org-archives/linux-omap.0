From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Mon, 04 Apr 2011 11:27:41 +0200
Message-ID: <4D998F0D.8070300@atmel.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>	<201104011554.07924.arnd@arndb.de> <4D95E112.4020400@vollmann.ch>	<201104011659.40443.arnd@arndb.de> <4D95EF8E.9080902@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D95EF8E.9080902@vollmann.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Detlef Vollmann <dv@vollmann.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: linux-omap@vger.kernel.org

Le 01/04/2011 17:30, Detlef Vollmann :
> On 04/01/11 16:59, Arnd Bergmann wrote:
>> On Friday 01 April 2011, Detlef Vollmann wrote:
>>> On 04/01/11 15:54, Arnd Bergmann wrote:
>>
>>>> 9. All interesting work is going into a handful of platforms, all of
>>>> which
>>>>      are ARMv7 based.
>>> Define interesting.
>>
>> The ones that are causing the churn that we're talking about.
>> Platforms that have been working forever and only need to get
>> the occasional bug fix are boring, i.e. not the problem.
> In the ARM tree I only know mach-at91.
> Atmel still introduces new SOCs based on ARM926EJ-S, and that makes
> perfect sense for lots of applications.
> And if they add support for a new SOC, they just copy an existing one,
> change some GPIOs, and submit it as new files (sorry, I'm over-
> simplifying here).
> And if you happen to wire your board a bit differently than they do,
> you have to patch theur generic file (in addidtion to add your own
> board file).
> And though I only know the mach-at91 closely, I'm pretty sure quite
> a number of other mach-* are not better.
> So this is actually why the ARM tree has such a bad reputation:
> lot's of code repetition, and still more of that.

Yes, certainly time has come for a change.

Note however that AT91 community is making great effort to:
- publish and maintain every single chip/board support since more than 5
years (and far before for first venerable at91rm9200) : if you recall
well, it was before most of code that appeared in arch/arm/mach-*
directories ;-)
- integrate ideas and patches from contributors for simplifying and
reducing board duplication
- try to conform to new infrastructures that are appearing on ARM Linux
for better convergence of code: gpiolib, leds, buttons, clocks (work in
progress)...

We know that work has to be done and we will for sure follow this effort
of consolidation. And remember: contributions welcomed ;-).

Best regards,
-- 
Nicolas Ferre
