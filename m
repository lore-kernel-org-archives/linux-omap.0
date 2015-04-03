From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
Date: Fri, 3 Apr 2015 11:39:42 -0700
Message-ID: <20150403183942.GV10805@atomide.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41656 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbDCSnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 14:43:37 -0400
Content-Disposition: inline
In-Reply-To: <20150403163553.GA16247@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

* Sebastian Reichel <sre@kernel.org> [150403 09:37]:
> Hi,
> 
> On Wed, Apr 01, 2015 at 12:47:36PM -0700, Tony Lindgren wrote:
> > > > OK I think debian is using v3.16 kernel
> > > 
> > > Yes. It will be used for Debian jessie (not yet released) and the
> > > N900 related drivers are enabled in the armmp flavour. Unfortunately
> > > it does not work together with thumb using userland because the
> > > errata 430973 workaround is not enabled.
> > > 
> > > See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=768890
> > 
> > Hmm I believe many ARMv8 boards will be randomly oopsing
> > with armhf without that. I sort of recall random oopses just
> > with running apt-get update on ARMv8 omaps on armhf without that:
> 
> Since I don't know of any ARMv8 omaps, I will read ARMv8 as ARMv7.

Sorry right, s/ARMv8/Cortex-A8/ :)
 
> And yes, for armhf userland one gets random oopses at least on the
> Nokia N900. AFAIK this is not true for all ARMv7 processors
> (especially non omaps), though.
> 
> > http://www.spinics.net/lists/linux-omap/msg108511.html
> > 
> > See also 5c86c5339c56 ("ARM: omap2plus_defconfig: Enable ARM erratum
> > 430973 for omap3").
> 
> For me the random oopses occur without this config flag and are
> fixed by it. The workaround is not very suitable for multi platform
> kernels, though, since its enabled also for unaffected platforms.
> 
> As far as I can see the CONFIG_ARM_ERRATA_430973 flag is checked
> in proc-v7.S and in proc-v7-2level.S. I think the first file is
> irrelevant, since it can be fixed later (see workaround in
> nokia_n900_legacy_init in pdata-quirks.c).

Yes so it seems, and the bootloaders should really set it. It's
also disabled for multiplatform builds.
 
> So basically the problem comes down to proc-v7-2level.S
> 
> > I wonder if the ARMv8 revision range might be wrong 430973 in
> > kernel or errata?
> 
> what revision range? I think the errata is enabled unconditionally
> or disabled completly.

The Cortex-A8 range claimed to be affected in Kconfig is listed
as r1p0..r1p2. But I recall seeing this also on omap3 (37xx)
which is r3p2. Also searching for r3p2 430973 produces:

http://e2e.ti.com/support/arm/sitara_arm/f/791/p/254742/891611

And that points to Siarhei's test program that should expose it
run together with other processes:

https://cloud.github.com/downloads/ssvb/ssvb.github.com/ssvb-cpuburn-a8.S

> > Also I recall that 430973 change to the
> > arch/arm/mm/proc-v7-2level.S fixed the issue, this should be
> > verified though.
> 
> If I understand the errata correctly the BTAC/BTB flushing is
> important. It would be nice if it could be limited to affected
> devices, though.

Agreed.

> > > I guess it should be tried to change the workaround, so that it does
> > > only change the behaviour of affected platforms. Otherwise its a
> > > hard decision for distributions to enable the workaround.
> > 
> > Well we should figure out first why flush BTAC/BTB is needed in
> > cpu_v7_switch_mm.. And if what I'm describing above is still
> > reproducable.
> 
> Reading the help text in the kernel the flushing is the actual
> workaround. The other changes only make it possible to do the
> flushing.
> 
> Maybe an option would be to provide two cpu_v7_switch_mm
> implementations (one with the errata and one without). Then
> the system can start with the simple implementation. Once
> the boot as progressed far enough to know, that the hardware
> is affected by the errata, it could switch to the implementation
> with the flushing.

That seems like a good way to deal with it but we should first
verify it Siarhei's test program.

Also, I think that the armel distro did not have these issue
while armhf did, so there may something more to this bug.

Regards,

Tony
