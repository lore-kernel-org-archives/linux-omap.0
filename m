From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 01 Apr 2011 17:30:22 +0200
Message-ID: <4D95EF8E.9080902@vollmann.ch>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011554.07924.arnd@arndb.de> <4D95E112.4020400@vollmann.ch>
	<201104011659.40443.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201104011659.40443.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/01/11 16:59, Arnd Bergmann wrote:
> On Friday 01 April 2011, Detlef Vollmann wrote:
>> On 04/01/11 15:54, Arnd Bergmann wrote:
>
>>> 9. All interesting work is going into a handful of platforms, all of which
>>>      are ARMv7 based.
>> Define interesting.
>
> The ones that are causing the churn that we're talking about.
> Platforms that have been working forever and only need to get
> the occasional bug fix are boring, i.e. not the problem.
In the ARM tree I only know mach-at91.
Atmel still introduces new SOCs based on ARM926EJ-S, and that makes
perfect sense for lots of applications.
And if they add support for a new SOC, they just copy an existing one,
change some GPIOs, and submit it as new files (sorry, I'm over-
simplifying here).
And if you happen to wire your board a bit differently than they do,
you have to patch theur generic file (in addidtion to add your own
board file).
And though I only know the mach-at91 closely, I'm pretty sure quite
a number of other mach-* are not better.
So this is actually why the ARM tree has such a bad reputation:
lot's of code repetition, and still more of that.

>>> 12. Supporting many different boards with a single kernel binary is a
>>>       useful goal.
>> Generally not for embedded systems (for me, a mobile PDA/phone is just a
>> small computer with a crappy keyboard, but not an embedded system).
>
> True. For embedded, this would not be an important thing to do, but
> also not hurt.
It costs you flash space.

>>> * Strictly no crap
>>>    * No board files
>> Where do you put code that needs to run very early (e.g. pinging the
>> watchdog)?
>
> Don't know. I'd hope we can get fast enough to the phase where device
> drivers get initialized.
Nope, never happened for me :-(
(Watchdog timeouts are often 1s or less.)

>>> * All board specific information must come from a device tree and
>>>     be run-time detected.
>> What do you mean by "run-time detected"?
>> For powerpc, we currently have the device tree as DTS in the kernel
>> and compile and bundle it together with the kernel.
>> As you wrote above: "Discoverable hardware [...] is not going to happen"
>
> I mean writing
>
> 	if (device_is_compatible(dev, SOMETHING))
> 		do_something();
>
> instead of
>
> #ifdef CONFIG_SOMETHING
> 	do_something();
> #endif
>
> The run-time information could come from anywhere (device tree, hardware
> registers, today one might use the board number), the important point is
> not to assume that hardware is present just because someone enabled
> a Kconfig option.
Understood and I agree.

> I believe that rule is generally accepted today, but we don't always
> enforce it.
Without device tree, Kconfig option is the only way that really
works today (no runtime HW detection, and same board ID with different
setups).
Device tree in my world is just one big Kconfig option instead of
many small...

   Detlef
