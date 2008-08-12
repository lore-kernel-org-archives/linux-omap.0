From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Tue, 12 Aug 2008 17:31:20 +0300
Message-ID: <20080812143119.GL6705@atomide.com>
References: <20080811152620.GO25784@atomide.com> <20080812101332.a321e783.jarkko.nikula@nokia.com> <20080812114446.GG6705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58082 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbYHLO3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 10:29:22 -0400
Content-Disposition: inline
In-Reply-To: <20080812114446.GG6705@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

* Tony Lindgren <tony@atomide.com> [080812 14:42]:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [080812 10:13]:
> > On Mon, 11 Aug 2008 18:26:21 +0300
> > "ext Tony Lindgren" <tony@atomide.com> wrote:
> > 
> > > Hi all,
> > > 
> > > I've updated our git tree to v2.6.27-rc2, and looks like we still
> > > have a bunch of issues to solve:
> > > 
> > > - Booting fails early on 3430sdp for some reason
> > > 
> > > - Alignment error on omap2/3. This seems to happen also with
> > >   718fc6cd4db902aa2242a736cc3feb8744a4c71a reverted?
> > > 
> > - N800 boots up to UI with "gcc version 3.4.4 (release) (CodeSourcery
> >   ARM 2005q3-2" and with DEBUG_LL=y. Without DEBUG_LL it hangs somewhere
> >   before serial is initialized
> > 
> > - With "gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-53)"
> >   there is alignment exception in early booting independently of
> >   718fc6cd4db902aa2242a736cc3feb8744a4c71a
> 
> Weird that this alignment exception only happens on 24xx, not on 34xx.

For me reverting 0e5194e1a84c219bebbb78f305b7a8eabc4a3656 fixes this.
Reverting 718fc6cd4db902aa2242a736cc3feb8744a4c71a like Felipe mentioned
does not help for me with gcc version 4.2.3 (Sourcery G++ Lite
2008q1-126).

> Tony
> 
> 
> > <5>Kernel command line: root=1f03 rootfstype=jffs2
> > <6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
> > <1>Unhandled fault: alignment exception (0x001) at 0xc02bf695
> > Internal error: : 1 [#1]
> > Modules linked in:
> > CPU: 0    Not tainted  (2.6.27-rc2-omap1 #9)
> > PC is at omap2_clkdm_clk_enable+0x2c/0x74
> > LR is at omap2_clk_enable+0x54/0x9c
> > pc : [<c0034ed8>]    lr : [<c0033738>]    psr: a00001d3
> > sp : c0303e90  ip : c0303ea8  fp : c0303ea4
> > r10: 800252c0  r9 : 4107b362  r8 : 00000013
> > r7 : c03261ac  r6 : 00000002  r5 : 00000000  r4 : c02bf689
> > r3 : c02bf695  r2 : 00000000  r1 : c03072c8  r0 : c02bf689
> > Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> > Control: 00c5387f  Table: 80004000  DAC: 00000017
> > Process swapper (pid: 0, stack limit = 0xc0302260)
> > Stack: (0xc0303e90 to 0xc0304000)
> > 3e80:                                     c03072c8 c0306d24 c0303ebc
> > c0303ea8 3ea0: c0033738 c0034eb8 c0306d7c c0306d24 c0303ed4 c0303ec0
> > c003371c c00336f0 3ec0: c03071f4 c0306d24 c0303eec c0303ed8 c003371c
> > c00336f0 c03073f0 c0306d24 3ee0: c0303f04 c0303ef0 c003371c c00336f0
> > c0307d90 c0306d24 c0303f1c c0303f08 3f00: c003371c c00336f0 c03099c0
> > c0306d24 c0303f34 c0303f20 c003371c c00336f0 3f20: 800001d3 c0306d24
> > c0303f4c c0303f38 c00432e4 c00336f0 c03099c0 c0306d24 3f40: c0303f64
> > c0303f50 c00433c4 c00432b0 00000292 c0306d24 c0303f94 c0303f68 3f60:
> > c001144c c00433a4 00000149 c0305cb8 c0303f94 00000000 c03255c0 c0026f0c
> > 3f80: c0305cb8 800252f4 c0303fac c0303f98 c0010818 c0011288 c0026f10
> > c03255c0 3fa0: c0303fbc c0303fb0 c0011aec c00107fc c0303fcc c0303fc0
> > c000e438 c0011ae4 3fc0: c0303ff4 c0303fd0 c0008c14 c000e40c c00086bc
> > 00000000 00000000 c0026f10 3fe0: 00c5387d c0325f4c 00000000 c0303ff8
> > 80008034 c0008ad0 00000000 00000000 Backtrace: [<c0034eac>]
> > (omap2_clkdm_clk_enable+0x0/0x74) from [<c0033738>] (omap2_clk_enable
> > +0x54/0x9c) r5:c0306d24 r4:c03072c8 [<c00336e4>] (omap2_clk_enable
> > +0x0/0x9c) from [<c003371c>] (omap2_clk_enable+0x38/0x9c) r5:c0306d24
> > r4:c0306d7c [<c00336e4>] (omap2_clk_enable+0x0/0x9c) from [<c003371c>]
> > (omap2_clk_enable+0x38/0x9c) r5:c0306d24 r4:c03071f4
> > [<c00336e4>] (omap2_clk_enable+0x0/0x9c) from [<c003371c>]
> > (omap2_clk_enable+0x38/0x9c) r5:c0306d24 r4:c03073f0
> > [<c00336e4>] (omap2_clk_enable+0x0/0x9c) from [<c003371c>]
> > (omap2_clk_enable+0x38/0x9c) r5:c0306d24 r4:c0307d90
> > [<c00336e4>] (omap2_clk_enable+0x0/0x9c) from [<c003371c>]
> > (omap2_clk_enable+0x38/0x9c) r5:c0306d24 r4:c03099c0
> > [<c00336e4>] (omap2_clk_enable+0x0/0x9c) from [<c00432e4>] (clk_enable
> > +0x40/0x54) r5:c0306d24 r4:800001d3
> > [<c00432a4>] (clk_enable+0x0/0x54) from [<c00433c4>]
> > (clk_enable_init_clocks+0x2c/0x4c) r5:c0306d24 r4:c03099c0
> > [<c0043398>] (clk_enable_init_clocks+0x0/0x4c) from [<c001144c>]
> > (omap2_clk_init+0x1d0/0x23c) r5:c0306d24 r4:00000292
> > [<c001127c>] (omap2_clk_init+0x0/0x23c) from [<c0010818>]
> > (omap2_init_common_hw+0x28/0x40) r8:800252f4 r7:c0305cb8 r6:c0026f0c
> > r5:c03255c0 r4:00000000 [<c00107f0>] (omap2_init_common_hw+0x0/0x40)
> > from [<c0011aec>] (nokia_n800_init_irq+0x14/0x5c) r5:c03255c0
> > r4:c0026f10 [<c0011ad8>] (nokia_n800_init_irq+0x0/0x5c) from
> > [<c000e438>] (init_IRQ+0x38/0x48) [<c000e400>] (init_IRQ+0x0/0x48) from
> > [<c0008c14>] (start_kernel+0x150/0x2b8) [<c0008ac4>] (start_kernel
> > +0x0/0x2b8) from [<80008034>] (0x80008034) r5:c0325f4c r4:00c5387d
> > Code: 03a05001 03e00015 089da830 e284300c (e1931f9f) 
> > <4>---[ end trace 1b75b31a2719ed1c ]---
> > <0>Kernel panic - not syncing: Attempted to kill the idle task!
> > 
> > 
> > Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
