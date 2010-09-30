From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 29 Sep 2010 19:18:19 -0700
Message-ID: <20100930021819.GD3117@atomide.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com>
 <87tyl8rxwp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63380 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab0I3CSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 22:18:22 -0400
Content-Disposition: inline
In-Reply-To: <87tyl8rxwp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Charulatha Varadarajan <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj R." <govindraj.raja@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100929 15:15]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100928 11:25]:
> >> Tony,
> >> 
> >> The following pull request will bring hwmod driver conversions for
> >> watchdog, UART and i2c drivers.  It is based on your omap-for-linus
> >> branch.
> >> 
> >> The i2c driver is waiting for final signoff/ack from the upstream
> >> subsystem maintainers, but are otherwise ready to go for broader
> >> testing.  After I get the final ack, I will update the branch for a
> >> final pull.
> >> 
> >> In the meantime, I'd like to get them into l-o master (or omap-testing)
> >> for broader testing.
> >
> > Tried pulling it but I'm getting tons of these errors on omap2:
> 
> Tony, 
> 
> Can you pull the latest version of my pm-hwmods branch from:
> ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-hwmods
> 
> This version has the updated patch from Rajendra for i2c as well as some
> UART3 fixes for a problem he noticed on 2430 as well.

Getting closer.. Now 2430sdp boots OK. But on N800 (2420) I get the following
very early on:

...
[    0.000000] Calibrating delay loop... 318.27 BogoMIPS (lpj=1245184)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Security Framework initialized
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] Unhandled fault: imprecise external abort (0xc06) at 0x00000000
[    0.000000] Internal error: : c06 [#1] SMP
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (2.6.36-rc6-08801-g332f930 #395)
[    0.000000] PC is at kernel_thread_helper+0x0/0x14
[    0.000000] LR is at kernel_thread_helper+0x0/0x14
[    0.000000] pc : [<c004cc94>]    lr : [<c004cc94>]    psr: 00000093
[    0.000000] sp : c7825ff8  ip : 00000000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 00000000  r8 : 00000000
[    0.000000] r7 : 00000013  r6 : c004cca8  r5 : c00a4dc0  r4 : 00000000
[    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
[    0.000000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 00c5387f  Table: 80004000  DAC: 00000017
[    0.000000] Process swapper (pid: 2, stack limit = 0xc78242f8)
[    0.000000] Stack: (0xc7825ff8 to 0xc7826000)
[    0.000000] 5fe0:                                                       ffffffff ffffffff
[    0.000000] [<c004cc94>] (kernel_thread_helper+0x0/0x14) from [<ffffffff>] (0xffffffff)
[    0.000000] Code: c04d9ba8 c04de459 c05ca0a0 c04caf13 (eb01ac97)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---

Then trying to build for omap1 OSK fails with:

In file included from arch/arm/plat-omap/common.c:35:
arch/arm/plat-omap/include/plat/control.h:20:40: error: mach/ctrl_module_core_44xx.h: No such file or directory
arch/arm/plat-omap/include/plat/control.h:21:40: error: mach/ctrl_module_wkup_44xx.h: No such file or directory
arch/arm/plat-omap/include/plat/control.h:22:44: error: mach/ctrl_module_pad_core_44xx.h: No such file or directory
arch/arm/plat-omap/include/plat/control.h:23:44: error: mach/ctrl_module_pad_wkup_44xx.h: No such file or directory
 
> Before this is final, I'm still waiting on two things:
> 
> 1) ack from Ben Dooks for the drivers/i2c change
> 2) additional patch from Charu to prevent reset when
>    CONFIG_OMAP_WATCHDOG=n

OK, sounds like we may be able to merge this then after the remaining
issues are sorted out.

Tony
