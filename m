From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 13:05:01 -0700
Message-ID: <AANLkTi=kbozPcWEk9wVZb7emSWx48BJQS=7Uzaya9Lor@mail.gmail.com>
References: <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
 <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
 <alpine.LFD.2.00.1103301814250.28032@xanadu.home> <alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
 <alpine.LFD.2.00.1103302255280.28032@xanadu.home> <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
 <alpine.LFD.2.00.1103310145390.28032@xanadu.home> <20110331080634.GA18022@elte.hu>
 <20110331083044.GB14323@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1103310855450.29543@asgard.lang.hm>
 <20110331164539.GB19452@n2100.arm.linux.org.uk> <AANLkTi=tyifvJU-hhdd7gT74GMctrCbQBdUAoEaRXOCy@mail.gmail.com>
 <alpine.LFD.2.00.1103311429590.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103311429590.28032@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, david@lang.hm, Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 31, 2011 at 12:25 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>
> So we need help! =A0If core kernel people could get off their X86 sto=
ol
> and get down in the ARM mud to help sort out this mess that would be
> really nice (thanks tglx). =A0Until then all that the few of us can d=
o is
> to contain the flood and hope for the best, and so far things being a=
s
> they are have still worked surprisingly well in practice for users. =A0=
If
> compensation is a concern then I think Linaro might be able to arrang=
e
> something.

The thing is, maintainers don't scale.

The only way to get quality code is to try to improve the quality from
the "leaf nodes", because otherwise you'll always end up playing
catch-up. You'll get new bad code faster than you can clean it up.

I've told people this before, and I'll tell it again: when I flame
submaintainers, they should try to push the pain down. I'm not really
asking those submaintainers to clean up all the stuff they are
getting: I'm basically asking people to say "no", or at least push
back a lot, and argue with the people who send you code. Tell them
what you don't like about the code, and tell them that you can't take
it any more.

> And we can't count on vendor people doing this work. =A0They are all =
busy
> porting the kernel to their next SOC version so they can win the next
> big Android hardware design, and doing so with our kernel quality
> standards is already quite a struggle for them.

This really isn't the argument. The argument should be that if they
want their code up-stream, they need to do a good job. If they don't,
why should you take it at all?

> What is going on at the moment is some effort to introduce DT support=
 to
> ARM. =A0The core support is there, but that is useless until platform=
 code
> is moved to it, and corresponding work is put into bootloaders, etc.
> That is progressing... slowly.

How about not moving platform code TO it, but at least saying that you
won't accept new platform code that doesn't use it? When somebody
sends you a new platform, just say "no" if it's another copy-paste job
or another "add yet another #ifdef or conditional to a messy driver".

> But we also need some slack wrt number of lines changed. =A0An increa=
sed
> consolidation effort will create more churn not less, at least for a
> while. =A0The OMAP clock merge conflict was the result of some cleanu=
p
> which will make further consolidation easier.

Umm. The whole "number of lines of code" thing has become a total red h=
erring.

THAT IS NOT WHY I STARTED TO COMPLAIN!

The reason I point out the number of lines of code is because it's one
of the more obvious _symptoms_ of the problem.

But trust me, if you start doing a better job at platform code, I
won't be complaining when I get lots of deleted code, or when I start
getting devicetree descriptions instead of new drivers.

So "number of lines of code" and "massive churn" is a problem, but
look at how I'm not complaining about the drivers/ subdirectory, which
is still the bulk of all lines in the kernel by far. I may complain
about particular subsystems in drivers (gpu..) for other reasons, but
it's not "lines of code" per se.

In the case of ARM, the reason I point out the size of the arch/arm is
because it's illustrative of just how _different_ ARM is from the
other architectures.  And those differences are pretty much all about
the board/platform issues.

                          Linus
