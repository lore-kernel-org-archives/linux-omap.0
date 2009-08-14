From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Fri, 14 Aug 2009 16:43:21 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57868 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbZHNLNw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 07:13:52 -0400
In-Reply-To: <20090813173327.GA14872@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, August 13, 2009 11:03 PM
> To: Syed Mohammed, Khasim
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> On Thu, Aug 13, 2009 at 10:51:43PM +0530, Syed Mohammed, Khasim wrote:
> > <1>Unable to handle kernel paging request at virtual address c5cef000 Unable to handle kernel
> paging request at virtual address c5cef000
> >
> > Internal error: Oops: 805 [#4]
> > Internal error: Oops: 805 [#4]
> > <d>Modules linked in:Modules linked in: cmemk cmemk
> 
> Please.  If you've got the kernel booting.  Turn off printascii support.
> This oops dump is almost unreadable as a result of keeping printascii
> support enabled.

Sorry, here is the one with out DEBUG_LL

root@beagleboard:/media/mmcblk0p1# ./a.out
mmap: vma->vm_start     = 0x40149000
mmap: vma->vm_pgoff     = 0x85ce1
mmap: vma->vm_end       = 0x404b8000
mmap: size              = 0x36f000
mmap: calling set_noncached(ce95b8b8) ...
mmap: vma->vm_start     = 0x404b8000
mmap: vma->vm_pgoff     = 0x85972
mmap: vma->vm_end       = 0x40827000
mmap: size              = 0x36f000
mmap: calling set_noncached(ce95bc28) ...


Unable to handle kernel paging request at virtual address c5d00000
pgd = cf858000
[c5d00000] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in: cmemk
CPU: 0    Not tainted  (2.6.31-rc5-omap1 #2)
PC is at v7_flush_kern_dcache_page+0x14/0x2c
LR is at __flush_dcache_page+0x28/0x34
pc : [<c002c268>]    lr : [<c002a8b0>]    psr: 00000113
sp : c1d1de70  ip : c0356000  fp : ce8ce060
r10: cf858000  r9 : 00000200  r8 : 40168000
r7 : ce95b8b8  r6 : ce95b8b8  r5 : c0410000  r4 : 00005d00
r3 : 00000002  r2 : 00000040  r1 : c5d01000  r0 : c5d00000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f858019  DAC: 00000015
Process a.out (pid: 889, stack limit = 0xc1d1c2e8)
Stack: (0xc1d1de70 to 0xc1d1e000)
de60:                                     00005d00 c002a7e4 85d00383 00000000
de80: ce95b8b8 c007e680 c031a3f0 e94f704f 00000011 00165a0c c1d1debc 00000168
dea0: 00000001 000005a0 cf859000 c1d1dee0 00000726 c0311d20 cf8d9360 ce95b8b8
dec0: ce8ce094 ce8ce060 c1d1dfb0 40168000 0000081f c002a118 1405ffdc 00000017
dee0: 13920cdc 00000800 c0312aa0 c0311d20 c0311e10 0000081f c1d1dfb0 40168000
df00: 00000000 40023000 beeafce4 c00231e8 139195a6 00000017 c031c3f8 c005f6f4
df20: 00000000 00000017 c0341820 00000100 00000004 00000081 00000001 c004ce30
df40: c1d1df40 c1d1df40 00000013 c1d1c000 c0324924 c0324958 00000020 c006b67c
df60: c1d1c000 00000100 00000020 c0049478 80000000 c0312b20 0000005f 00000000
df80: 00000000 00000000 00000000 c1d1c000 beeafce4 c0049544 ffffffff 00000000
dfa0: 00000000 00000000 00000000 c0023c9c 40149000 00000000 002e0ff4 40168000
dfc0: 40022e08 00000000 00000000 00000000 00000000 00000000 40023000 beeafce4
dfe0: 4009eac0 beeafce0 000098c4 4009eaec 20000010 ffffffff 47d63e68 9cfcabf3
[<c002c268>] (v7_flush_kern_dcache_page+0x14/0x2c) from [<e94f704f>] (0xe94f704f
)
Code: e2033007 e3a02010 e1a02312 e2801a01 (ee070f3e)
---[ end trace 58a066cdb6c0f78c ]---
Segmentation fault

Regards,
Khasim
