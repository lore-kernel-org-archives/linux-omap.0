From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Tue, 5 Sep 2017 13:13:15 -0700
Message-ID: <20170905201314.GE5024@atomide.com>
References: <20170903203737.GA12475@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170903203737.GA12475@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [170903 13:38]:
> Hi!
>
> It compiles ok, but it hangs on boot; black screen, so sometime before
> display is initialized.

Thanks for reporting it. Based on git bisect, the regression causing
commit is 9caf25f996e8 ("mm/cma: manage the memory of the CMA area
by using the ZONE_MOVABLE"). With this path applied, booting hangs
with an error in omap3_save_secure_ram_context() after a call to
_omap_save_secure_sram() that calls the related assembly code
save_secure_ram_context.

However, looks like there is also some other commit causing issue.

Just reverting 9caf25f996e8 on Linux next causes the oops below.

Anybody got ideas why this now happens?

Regards,

Tony

8< --------------------
Unable to handle kernel paging request at virtual address ce800000
pgd = c0004000 [ce800000] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-next-20170905+ #662
Hardware name: Nokia RX-51 board
task: ce0a0040 task.stack: ce0a4000
PC is at __memzero+0x24/0x7c
LR is at 0x0
pc : [<c084fa84>]    lr : [<00000000>]    psr: 20000013
sp : ce0a5e84  ip : 00000000  fp : c0c005a8
r10: 00040000  r9 : cfc95000  r8 : 00000247
r7 : ce0a5ef4  r6 : 00000000  r5 : 00000001  r4 : ce800000
r3 : 00000000  r2 : 00000000  r1 : 0003ffc0  r0 : ce800000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 80004019  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xce0a4218)
Stack: (0xce0a5e84 to 0xce0a6000)
5e80:          c0116718 00000040 00000006 c01a1470 00040000 00000001 00000040
5ea0: ce0a5ef4 00000247 cfc95000 00000000 c0c005a8 c0116844 c0dce000 c01a1484
5ec0: 00000247 c0d0e2e0 c0dce29c c0b5cbbc c0dce000 00000003 c0c5389c c0c06c54
5ee0: c0c06bd8 00000001 00000000 014000c0 00000000 c0b5cbbc ffffe000 c0c06bd8
5f00: 00000000 c0101ef8 000000aa 00000000 cfdfcbdb cfdfcbe7 c0b5d904 000000aa
5f20: 000000aa c015cf54 c0b5cbbc 00000000 00000002 00000002 cfdfcbe7 cfdfcbec
5f40: c0c6c59c 00000002 c0dce000 c0c53880 c0c6c66c c0dce000 c0c53884 c0dce000
5f60: 00000003 c0c00ecc 00000002 00000002 00000000 c0c005a8 c0864f3c 000000aa
5f80: 00000000 00000000 c0864f3c 00000000 00000000 00000000 00000000 00000000
5fa0: 00000000 c0864f44 00000000 c0107e98 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c084fa84>] (__memzero) from [<c0116718>] (__dma_clear_buffer+0x140/0x154)
[<c0116718>] (__dma_clear_buffer) from [<c0116844>] (__alloc_from_contiguous+0x50/0xdc)
[<c0116844>] (__alloc_from_contiguous) from [<c0c06c54>] (atomic_pool_init+0x7c/0x178)
[<c0c06c54>] (atomic_pool_init) from [<c0101ef8>] (do_one_initcall+0x3c/0x170)
[<c0101ef8>] (do_one_initcall) from [<c0c00ecc>] (kernel_init_freeable+0x1fc/0x2c4)
[<c0c00ecc>] (kernel_init_freeable) from [<c0864f44>] (kernel_init+0x8/0x110)
[<c0864f44>] (kernel_init) from [<c0107e98>] (ret_from_fork+0x14/0x3c)
Code: e52de004 e1a0c002 e1a0e002 e2511040 (a8a0500c)
