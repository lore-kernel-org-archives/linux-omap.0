From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 15:05:07 -0800
Message-ID: <20120204230507.GM20333@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61795 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab2BDXFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 18:05:10 -0500
Content-Disposition: inline
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> On Sat, Feb 04, 2012 at 11:01:09AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 10:24]:
> > > Does someone want to try building and running Linux on (eg) an OMAP34xx
> > > platform before I post my next email message on this subject, and
> > > maybe send me a bunch of patches required to fix stuff, to be applied
> > > to my tree _and_ _then_ forwarded to Linus next Friday.
> > > 
> > > So, think of this as your last chance, and you'll get the picture about
> > > how pissed off I am with the - yet again - current poor state of OMAP
> > > in mainline, which seems to happen every merge window.
> > > 
> > > Consider this: when Linus started using a PowerPC platform, the PowerPC
> > > people quickly realized that pushing patches upstream which broke stuff
> > > was a really bad idea, because they got publically flamed for such
> > > actions especially when stuff was not obviously tested.
> > > 
> > > This is no different... and this is _not_ my original email which I have
> > > queued up with the real hot flames in over this.  This is the toned down
> > > version.  The flames won't get sent if OMAP gets fixed quickly - and if
> > > testing improves to stop this constant cycle of regressions at every
> > > merge window.
> > 
> > Do you have the patches applied already queued up in arm-soc fixes
> > branch?
> 
> It really doesn't make much difference - the only improvement I see in
> the big collection of issues I have with OMAP this time around is one
> build error is gone.  There's _far_ _far_ bigger problems in the OMAP
> code this time.
> 
> I'm seriously considering requesting that all OMAP changes for the merge
> window come through me rather than arm-soc, so that I can boot and build
> test them before the merge window opens, and we can cut down on this
> repetitive cycle of build (and boot) breakage at every merge window.

I agree it would be nice to see these issues earlier. I build and boot
test every patch I merge, but mostly with omap2plus_defconfig as that
does the job for all the boards I have with a single zImage.

Looks like the issues you're seeing are related to .config settings.

How about let's plan on testing your .configs with for-next before the
next merge window?

> One problem isn't yours to solve (the requirement for regulators for
> the SMSC network driver which has appeared.)

Yes I noticed that too on booting zoom3.
 
> Another problem (some build errors for OMAP3) do seem to be solved, but
> not the section mismatch warnings.  They're easy to verify before code
> gets pushed anywhere upstream, especially if you're doing one giant OMAP
> build - just enable CONFIG_DEBUG_SECTION_MISMATCH in your build
> configuration.  Refuse patches which introduce section mismatches - at
> least without an explanation backing up why they do.
> 
> My OMAP3 and OMAP4 configurations spit out these - I've not even tried
> my OMAP2 configuration yet:

I agree these would be nice to fix, I'll take a look at these.
Or do you already have a patch for that?
 
> Another problem oopses the kernel at boot in the voltage domain code,
> which I suspect this has never been boot tested on OMAP34xx CPUs:

Boots fine here with omap2plus_defconfig. This must be some .config
option triggering this.

Kevin, can you please track down this one?
 
> And OMAP4 doesn't build.  Fixing the build error in prm44xx.c (which is
> virtually the same as the OMAP3 build error in its prm file) gets us to
> a buildable state, but... it silently fails to boot.
> 
> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)

Have not seen this one either, have to investigate.
 
> So, a slight improvement, but overall no material forward progress in
> terms of things booting.
> 
> And, compared to my previous testing, the OMAP state is worse than ever
> as this time, even with your first round of fixes, all my OMAP platforms
> are pretty broken.

Sorry to hear that. And thanks for the detailed report on what all
issues you're seeing. They all seem like pretty trivial fixes, so just
hang on for few more days and we'll get them fixed.

Regards,

Tony
