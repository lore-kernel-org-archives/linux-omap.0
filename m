From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Fri, 1 Oct 2010 18:58:43 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48636 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab0JAN27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 09:28:59 -0400
In-Reply-To: <877hi3gqq7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, September 30, 2010 9:37 PM
> To: Tony Lindgren; Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja, Govindraj
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> >> Tony Lindgren <tony@atomide.com> writes:
> >>
> >>> * Kevin Hilman <khilman@deeprootsystems.com> [100929 15:15]:
> >>>> Tony Lindgren <tony@atomide.com> writes:
> >>>>
> >>>> > * Kevin Hilman <khilman@deeprootsystems.com> [100928 11:25]:
> >>>> >> Tony,
> >>>> >>
> >>>> >> The following pull request will bring hwmod driver conversions for
> >>>> >> watchdog, UART and i2c drivers.  It is based on your omap-for-linus
> >>>> >> branch.
> >>>> >>
> >>>> >> The i2c driver is waiting for final signoff/ack from the upstream
> >>>> >> subsystem maintainers, but are otherwise ready to go for broader
> >>>> >> testing.  After I get the final ack, I will update the branch for a
> >>>> >> final pull.
> >>>> >>
> >>>> >> In the meantime, I'd like to get them into l-o master (or omap-testing)
> >>>> >> for broader testing.
> >>>> >
> >>>> > Tried pulling it but I'm getting tons of these errors on omap2:
> >>>>
> >>>> Tony,
> >>>>
> >>>> Can you pull the latest version of my pm-hwmods branch from:
> >>>> ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-hwmods
> >>>>
> >>>> This version has the updated patch from Rajendra for i2c as well as some
> >>>> UART3 fixes for a problem he noticed on 2430 as well.
> >>>
> >>> Getting closer.. Now 2430sdp boots OK. But on N800 (2420) I get the following
> >>> very early on:
> >>
> >>> ...
> >>> [    0.000000] Calibrating delay loop... 318.27 BogoMIPS (lpj=1245184)
> >>> [    0.000000] pid_max: default: 32768 minimum: 301
> >>> [    0.000000] Security Framework initialized
> >>> [    0.000000] Mount-cache hash table entries: 512
> >>> [    0.000000] CPU: Testing write buffer coherency: ok
> >>> [    0.000000] Unhandled fault: imprecise external abort (0xc06) at 0x00000000
> >>> [    0.000000] Internal error: : c06 [#1] SMP
> >>> [    0.000000] last sysfs file:
> >>> [    0.000000] Modules linked in:
> >>> [    0.000000] CPU: 0    Not tainted  (2.6.36-rc6-08801-g332f930 #395)
> >>> [    0.000000] PC is at kernel_thread_helper+0x0/0x14
> >>> [    0.000000] LR is at kernel_thread_helper+0x0/0x14
> >>> [    0.000000] pc : [<c004cc94>]    lr : [<c004cc94>]    psr: 00000093
> >>> [    0.000000] sp : c7825ff8  ip : 00000000  fp : 00000000
> >>> [    0.000000] r10: 00000000  r9 : 00000000  r8 : 00000000
> >>> [    0.000000] r7 : 00000013  r6 : c004cca8  r5 : c00a4dc0  r4 : 00000000
> >>> [    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
> >>> [    0.000000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> >>> [    0.000000] Control: 00c5387f  Table: 80004000  DAC: 00000017
> >>> [    0.000000] Process swapper (pid: 2, stack limit = 0xc78242f8)
> >>> [    0.000000] Stack: (0xc7825ff8 to 0xc7826000)
> >>> [    0.000000] 5fe0:                                                       ffffffff ffffffff
> >>> [    0.000000] [<c004cc94>] (kernel_thread_helper+0x0/0x14) from [<ffffffff>] (0xffffffff)
> >>> [    0.000000] Code: c04d9ba8 c04de459 c05ca0a0 c04caf13 (eb01ac97)
> >>> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
> >>>
> >>
> >> Hmm, this fault is very early and long before any PM code has
> >> initialzed.  I suspect this happens with the master branch too ??
> >
> > I've reproduced this now, and it doesn't happen on the master branch and
> > only happens after merge pm-hwmods.
> >
> > Debugging now...
> 
> OK, so this failure is (somehow) related to the i2c hwmods, but I did
> not figure out how.  Rajendra, can you dig into this?  It only seems to
> happen on 2420/n800, and all other platforms seem OK.

Hi Kevin,

I was able to reproduce the crash on the n800 and have been debugging it for a while.
Like you said putting a HWMOD_INIT_NO_RESET did not seem to fix it for me, and the
only way I can get the n800 to completely bootup is by removing the sysc completely 
for i2c. 
That is quite surprising since the only thing that can be done using the sysconfig
on omap2420 is a softreset.

I verified that its not the sysc read itself that causes a crash (clocks seem to be enabled,
idlest seems fine) but somehow just these sysc reads (if I have HWMOD_INIT_NO_RESET set)
seem to be enough to cause the crash. 
Nothing gets written back to the sysc register either.
I was suspecting the omap_readl's done in hmwod framework on the 16bit 2420 registers
to be an issue, but I am yet to figure out how.

I am debugging this further, but in the meantime since this is gating all other patches to get merged
in omap-testing, should I just remove the sysc for i2c on 2420? The only
thing it will prevent is a i2c softreset at boot, which anyway does not seem to be causing any
issues on n800.

Regards,
Rajendra

> 
> I tried
> 
> +	.flags          = HWMOD_INIT_NO_RESET | HWMOD_INIT_NO_IDLE,
> 
> for the i2c hwmods, and that didn't help either.  The only thing that
> made the system boot further was commenting out the i2c hwmods in the
> omap2420_hwmod array.
> 
> Attached is the defconfig I used to get a kernel small enough for nolo
> to load it on my n810.
> 
> Kevin
> 

