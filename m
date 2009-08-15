From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 16:33:57 +0100
Message-ID: <20090815153357.GF29616@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55478 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZHOPeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 11:34:06 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 14, 2009 at 04:43:21PM +0530, Syed Mohammed, Khasim wrote:
> Unable to handle kernel paging request at virtual address c5d00000
> pgd = cf858000
> [c5d00000] *pgd=00000000
> Internal error: Oops: 805 [#1]
> Modules linked in: cmemk
> CPU: 0    Not tainted  (2.6.31-rc5-omap1 #2)
> PC is at v7_flush_kern_dcache_page+0x14/0x2c
> LR is at __flush_dcache_page+0x28/0x34
> pc : [<c002c268>]    lr : [<c002a8b0>]    psr: 00000113
> sp : c1d1de70  ip : c0356000  fp : ce8ce060
> r10: cf858000  r9 : 00000200  r8 : 40168000
> r7 : ce95b8b8  r6 : ce95b8b8  r5 : c0410000  r4 : 00005d00
> r3 : 00000002  r2 : 00000040  r1 : c5d01000  r0 : c5d00000
> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8f858019  DAC: 00000015
> Process a.out (pid: 889, stack limit = 0xc1d1c2e8)
> Stack: (0xc1d1de70 to 0xc1d1e000)
> de60:                                     00005d00 c002a7e4 85d00383 00000000
> de80: ce95b8b8 c007e680 c031a3f0 e94f704f 00000011 00165a0c c1d1debc 00000168
> dea0: 00000001 000005a0 cf859000 c1d1dee0 00000726 c0311d20 cf8d9360 ce95b8b8
> dec0: ce8ce094 ce8ce060 c1d1dfb0 40168000 0000081f c002a118 1405ffdc 00000017
> dee0: 13920cdc 00000800 c0312aa0 c0311d20 c0311e10 0000081f c1d1dfb0 40168000
> df00: 00000000 40023000 beeafce4 c00231e8 139195a6 00000017 c031c3f8 c005f6f4
> df20: 00000000 00000017 c0341820 00000100 00000004 00000081 00000001 c004ce30
> df40: c1d1df40 c1d1df40 00000013 c1d1c000 c0324924 c0324958 00000020 c006b67c
> df60: c1d1c000 00000100 00000020 c0049478 80000000 c0312b20 0000005f 00000000
> df80: 00000000 00000000 00000000 c1d1c000 beeafce4 c0049544 ffffffff 00000000
> dfa0: 00000000 00000000 00000000 c0023c9c 40149000 00000000 002e0ff4 40168000
> dfc0: 40022e08 00000000 00000000 00000000 00000000 00000000 40023000 beeafce4
> dfe0: 4009eac0 beeafce0 000098c4 4009eaec 20000010 ffffffff 47d63e68 9cfcabf3

Okay, this is perfect, up until here:

> [<c002c268>] (v7_flush_kern_dcache_page+0x14/0x2c) from [<e94f704f>] (0xe94f704f
> )

where we don't have the full backtrace, and therefore don't know how we
got to this function.  Gah, this is intensely frustrating.

As Catalin has recently pointed out, this could be because of a toolchain
which doesn't know how to emit the unwind information.  I'm sure there's
other reasons.  But, at the end of the day, if this is the kind of oops
dump we can now expect, bug hunting is going to become a very frustrating
business.

Can you rebuild your kernel yet again, this time with the unwinder
disabled (and therefore frame pointers enabled) please, and reproduce
yet again?
