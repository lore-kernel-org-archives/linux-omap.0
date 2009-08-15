From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 21:47:18 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <20090815153357.GF29616@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbZHOQRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 12:17:39 -0400
In-Reply-To: <20090815153357.GF29616@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Russell,

Thanks for the review,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, August 15, 2009 9:04 PM
> To: Syed Mohammed, Khasim
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> On Fri, Aug 14, 2009 at 04:43:21PM +0530, Syed Mohammed, Khasim wrote:
> > Unable to handle kernel paging request at virtual address c5d00000
> > pgd = cf858000
<snip>
 
> Can you rebuild your kernel yet again, this time with the unwinder
> disabled (and therefore frame pointers enabled) please, and reproduce
> yet again?

Attached below, hope this is correct.

ioremap_nocache(0x85800000, 16777216)=0xd1000000
mmap: vma->vm_start     = 0x40149000
mmap: vma->vm_pgoff     = 0x85800
mmap: vma->vm_end       = 0x41149000
mmap: size              = 0x1000000

Unable to handle kernel paging request at virtual address c5800000
pgd = cf874000
[c5800000] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in: cmemk
CPU: 0    Not tainted  (2.6.31-rc5-omap1 #1)
PC is at v7_flush_kern_dcache_page+0x14/0x2c
LR is at __flush_dcache_page+0x30/0x3c
pc : [<c002e388>]    lr : [<c002c8b4>]    psr: 00000113
sp : c1737e38  ip : c1737e48  fp : c1737e44
r10: cf874000  r9 : 00000200  r8 : 40149000
r7 : ce9b95a0  r6 : ce9b95a0  r5 : c0414000  r4 : 00005800
r3 : 00000002  r2 : 00000040  r1 : c5801000  r0 : c5800000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f874019  DAC: 00000015
Process a.out (pid: 889, stack limit = 0xc17362e8)
Stack: (0xc1737e38 to 0xc1738000)
7e20:                                                       c1737e64 c1737e48
7e40: c002c7c0 c002c890 85800383 00000000 ce9b95a0 ce9b95a0 c1737ebc c1737e68
7e60: c008611c c002c740 c1737e8c c1737e78 c01a00e0 c01a0084 00000149 00000001
7e80: ce90a7e0 00000524 cf875000 c01a00d4 00000000 c031fd38 cf864040 ce9b95a0
7ea0: ce90a814 ce90a7e0 c1737fb0 40149000 c1737efc c1737ec0 c002c098 c0085bf4
7ec0: 00000000 c1737ed0 0000081f 00000800 c1737ef4 c031fd38 c031fe28 0000081f
7ee0: c1737fb0 40149000 00000000 40023000 c1737fac c1737f00 c0025210 c002bfb8
7f00: c018e4c8 00000000 00000000 cf8f1410 00000200 00000002 00000000 cf415538
7f20: cf8f1410 0000000f c1736000 00000000 c1737f6c c1737f40 c009866c c00c0d80
7f40: 00000000 00000000 00000000 00000000 00000000 cf8dd5a0 0000000f 4001c000
7f60: c1737fa4 c1737f70 c0098744 c0098528 00000000 00000000 c002c274 00000000
7f80: ffffffff 0000000f 4001c000 ffffffff 00000000 00000000 00000000 00000000
7fa0: 00000000 c1737fb0 c0025d40 c00251e4 40149000 00000000 00fffff8 40149000
7fc0: 40022e08 00000000 00000000 00000000 00000000 00000000 40023000 bee89ce4
7fe0: 4009eac0 bee89cb8 000086dc 4009eaec 20000010 ffffffff 80566021 80566421
Backtrace:
[<c002c884>] (__flush_dcache_page+0x0/0x3c) from [<c002c7c0>] (update_mmu_cache+
0x8c/0xb0)
[<c002c734>] (update_mmu_cache+0x0/0xb0) from [<c008611c>] (handle_mm_fault+0x53
4/0x5ac)
 r7:ce9b95a0 r6:ce9b95a0 r5:00000000 r4:85800383
[<c0085be8>] (handle_mm_fault+0x0/0x5ac) from [<c002c098>] (do_page_fault+0xec/0
x234)
[<c002bfac>] (do_page_fault+0x0/0x234) from [<c0025210>] (do_DataAbort+0x38/0x98
)
[<c00251d8>] (do_DataAbort+0x0/0x98) from [<c0025d40>] (ret_from_exception+0x0/0
x10)
Exception stack(0xc1737fb0 to 0xc1737ff8)
7fa0:                                     40149000 00000000 00fffff8 40149000
7fc0: 40022e08 00000000 00000000 00000000 00000000 00000000 40023000 bee89ce4
7fe0: 4009eac0 bee89cb8 000086dc 4009eaec 20000010 ffffffff
 r8:00000000 r7:00000000 r6:00000000 r5:00000000 r4:ffffffff
Code: e2033007 e3a02010 e1a02312 e2801a01 (ee070f3e)
---[ end trace b534dcb6339fe900 ]---

Regards,
Khasim
