From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Thu, 13 Aug 2009 22:51:43 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494AbZHMRWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 13:22:12 -0400
In-Reply-To: <20090808170300.GA23481@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell,

I have attached the dump below, 

Summary, we have latest kernel 2.6.31-rc5-omap1 running on beagle with ARCH_HAS_HOLES_MEMORYMODEL enabled for OMAP architecture.

80000000 to 857FFFFF - (88M for kernel)
85800000 to 8c3FFFFF - (108M hole)
8c400000 to 8FFFFFFF - (60M for kernel)

After booting the kernel and a kernel module uses request_mem_region and ioremap to create some pool of memory in the hole region. A user application mmap s this space and uses memset to fill 0s in one of the pool. This results in a crash.

When we don't create the hole (kernel has only 88M) and run same kernel module and app then it passes.

I am doing some clean up to my test driver and app, I can pass these later this week.

Thanks

Regards,
Khasim

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, August 08, 2009 10:33 PM
> To: Syed Mohammed, Khasim
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> On Sat, Aug 08, 2009 at 08:45:44PM +0530, Syed Mohammed, Khasim wrote:
> > Hi Russell,
> >
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Sent: Saturday, August 08, 2009 3:30 AM
> > > To: Syed Mohammed, Khasim
> > > Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> > > Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> > >
> > > On Sat, Aug 08, 2009 at 01:46:35AM +0530, Syed Mohammed, Khasim wrote:
> > > > On OMAP3 we are creating a space for DSP components to have shared
> > > > buffers using the boot arguments.
> > > >
> > > > mem=88M@0x80000000 mem=128M@0x88000000
> > >
> > > Ensure that you have ARCH_HAS_HOLES_MEMORYMODEL enabled in the
> > > configuration - you need OMAP3 to select this symbol.
> >
> > We are on 2.6.29 on beagleboard, this kernel doesn't support ARCH_HAS_HOLES_MEMORYMODEL so I
> applied the patch from
> >
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commitdiff;h=eb33575cf67d3f35fa2510210ef92631266e2465
> >
> > Didn't help, still fails, do you suggest us to move to latest kernel and try the same instead of
> patch alone?
> 
> In which case, please supply a full bug report with a _full_ oops dump.

root@beagleboard:/media/mmcblk0p1# ./a.out
mmap: vma->vm_start     = 0x40137000
mmap: vma->vm_pgoff     = 0x85ce1
mmap: vma->vm_end       = 0x404a6000
mmap: size              = 0x36f000

<1>Unable to handle kernel paging request at virtual address c5cef000 Unable to handle kernel paging request at virtual address c5cef000

Internal error: Oops: 805 [#4]
Internal error: Oops: 805 [#4]
<d>Modules linked in:Modules linked in: cmemk cmemk

CPU: 0    Tainted: G      D     (2.6.31-rc5-omap1 #7)
CPU: 0    Tainted: G      D     (2.6.31-rc5-omap1 #7)
PC is at v7_flush_kern_dcache_page+0x14/0x2c
PC is at v7_flush_kern_dcache_page+0x14/0x2c
LR is at __flush_dcache_page+0x28/0x34
LR is at __flush_dcache_page+0x28/0x34
pc : [<c002c348>]    lr : [<c002a950>]    psr: 00000113
sp : ce97be80  ip : c0415de0  fp : 0000081f
pc : [<c002c348>]    lr : [<c002a950>]    psr: 00000113
sp : ce97be80  ip : c0415de0  fp : 0000081f
r10: 00000514  r9 : 00001000  r8 : 40145000
r10: 00000514  r9 : 00001000  r8 : 40145000
r7 : c1daec80  r6 : 85cef383  r5 : cf8b39a0  r4 : c1daec80
r7 : c1daec80  r6 : 85cef383  r5 : cf8b39a0  r4 : c1daec80
r3 : 00000002  r2 : 00000040  r1 : c5cf0000  r0 : c5cef000
r3 : 00000002  r2 : 00000040  r1 : c5cf0000  r0 : c5cef000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f850019  DAC: 00000015
Control: 10c5387d  Table: 8f850019  DAC: 00000015 Process a.out (pid: 893, stack limit = 0xce97a2e8) Process a.out (pid: 893, stack limit = 0xce97a2e8)
Stack: (0xce97be80 to 0xce97c000)
Stack: (0xce97be80 to 0xce97c000)
be80: be80: c1daec80 c1daec80 c002a88c c002a88c 00000000 00000000 c007eaa4 c007e
aa4 c0320890 c0320890 c03203f0 c03203f0 b954fd20 b954fd20 000002cc 000002cc

bea0: bea0: 00000001 00000001 ce8ed7e0 ce8ed7e0 07735940 07735940 cf851000
cf851
000 ce97bee0 ce97bee0 c0317d20 c0317d20 cf8b39a0 cf8b39a0 c1daec80 c1daec80

bec0: bec0: ce8ed814 ce8ed814 ce8ed7e0 ce8ed7e0 ce97bfb0 ce97bfb0 40145000
40145
000 0000081f 0000081f c002a1b0 c002a1b0 07735940 07735940 00000bd3 00000bd3

bee0: bee0: 07735940 07735940 00000800 00000800 06feeec9 06feeec9 c0317d20
c0317
d20 c0317e10 c0317e10 0000081f 0000081f ce97bfb0 ce97bfb0 40145000 40145000

bf00: bf00: 00000000 00000000 40023000 40023000 be859ce4 be859ce4 c00231ec
c0023
1ec 00000bd3 00000bd3 c03223f8 c03223f8 00000001 00000001 06feeec8 06feeec8

bf20: bf20: 00000060 00000060 c035060c c035060c 00000001 00000001 c018f458 c018f
458 c035060c c035060c 00000008 00000008 c03506b0 c03506b0 c035060c c035060c

bf40: bf40: 00000001 00000001 00000000 00000000 00000000 00000000 0000004a 00000 04a c1d85340 c1d85340 c018f4d0 c018f4d0 ce9e8420 ce9e8420 0000004a 0000004a

bf60: bf60: 00000000 00000000 00000000 00000000 00000000 00000000 ce97a000 ce97a 000 40023000 40023000 c00692b0 c00692b0 c03241d8 c03241d8 0000004a 0000004a

bf80: bf80: 00000000 00000000 00000000 00000000 00000000 00000000 c006aeb8 c006a
eb8 be859ce4 be859ce4 c0049b40 c0049b40 ffffffff ffffffff 00000000 00000000

bfa0: bfa0: 00000000 00000000 00000000 00000000 00000000 00000000 c0023c7c
c0023
c7c 40137000 40137000 00000000 00000000 002f1ff4 002f1ff4 40145000 40145000

bfc0: bfc0: 40022e08 40022e08 00000000 00000000 00000000 00000000 00000000 00000 000 00000000 00000000 00000000 00000000 40023000 40023000 be859ce4 be859ce4

bfe0: bfe0: 4008cac0 4008cac0 be859ce0 be859ce0 000099dc 000099dc 4008caec 4008c aec 20000010 20000010 ffffffff ffffffff 00000000 00000000 00000000 00000000

[<c002c348>] [<c002c348>] (v7_flush_kern_dcache_page+0x14/0x2c)
(v7_flush_kern_d
cache_page+0x14/0x2c) from [<c1daec80>] from [<c1daec80>] (0xc1daec80)
(0xc1daec80)
Code: Code: e2033007 e2033007 e3a02010 e3a02010 e1a02312 e1a02312 e2801a01
e2801
a01 (ee070f3e) (ee070f3e)

00

