From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Mon, 18 Oct 2010 16:10:52 +0300
Message-ID: <1287407452.6781.64.camel@tubuntu>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	 <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:21431 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab0JRNLi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 09:11:38 -0400
In-Reply-To: <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, Russell King <linux@arm.linux.org.uk>, "mike@compulab.co.il" <mike@compulab.co.il>

Hi,

On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
> So that we can ioremap happily.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/video/omap2/vram.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> index f6fdc20..1a99777 100644
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblock(void=
)
>  		}
>  	} else {
>  		paddr =3D memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT=
);
> +		memblock_free(paddr, size);
> +		memblock_remove(paddr, size);
>  	}
> =20
>  	omap_vram_add_region(paddr, size);

I tested this on OMAP3 SDP board, on top of my DSS2 tree. I can boot up
fine, but my test program crashes the kernel (dump below).

This crash doesn't happen if I have the "HACK: OMAP: DSS2: OMAPFB: use
phys_to_virt for RAM mappings" patch in (I removed that during testing
this patch).

I don't know yet what is crashing the kernel, but I'd guess it's the
fact that my test program reallocates the framebuffer memory with
OMAPFB_SETUP_MEM ioctl.

 Tomi


[   53.131591] Unable to handle kernel NULL pointer dereference at virt=
ual address 00000048
[   53.140350] pgd =3D c7038000
[   53.143096] [00000048] *pgd=3D87058031, *pte=3D00000000, *ppte=3D000=
00000
[   53.149749] Internal error: Oops: 17 [#1]
[   53.153808] last sysfs file: /sys/devices/platform/serial8250.2/slee=
p_timeout
[   53.161010] Modules linked in:
[   53.164123] CPU: 0    Tainted: G        W    (2.6.36-rc8-00016-g0897=
fa9 #1216)
[   53.171417] PC is at filemap_fault+0x2c/0x380
[   53.175842] LR is at __do_fault+0x50/0x41c
[   53.179962] pc : [<c00d8d90>]    lr : [<c00ee2e4>]    psr: a0000113
[   53.179992] sp : c7ff9db8  ip : 00000062  fp : c7fce040
[   53.191528] r10: c7fce040  r9 : c796ee18  r8 : 00000062
[   53.196807] r7 : 00000000  r6 : c7fcd280  r5 : c7fe68a0  r4 : c704ac=
28
[   53.203369] r3 : 00000000  r2 : 00000fff  r1 : 00000000  r0 : c704ac=
28
[   53.209960] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment user
[   53.217163] Control: 10c5387d  Table: 87038019  DAC: 00000015
[   53.222961] Process db (pid: 649, stack limit =3D 0xc7ff82f0)
[   53.228576] Stack: (0xc7ff9db8 to 0xc7ffa000)
[   53.232971] 9da0:                                                   =
    00000183 00000001
[   53.241241] 9dc0: c7ff9e00 00000000 00000001 c7039008 c7fe68a0 00000=
000 00000000 c704ac28
[   53.249481] 9de0: 40228000 c7fce040 c7fce040 c00ee2e4 40228000 00000=
000 c0481e04 c02283b8
[   53.257720] 9e00: 00000000 00000062 40228000 00000000 60000113 c7fe6=
800 c7fe68a0 c7ff9fb0
[   53.265960] 9e20: 00000000 c704ac28 40228000 c7fce040 c7038000 c00ef=
750 00000062 00000000
[   53.274200] 9e40: 00000000 60000113 c04845e4 00000028 00000201 00000=
000 000000a0 c7039008
[   53.282470] 9e60: c7fce040 c7ff3080 80000007 c704ac28 00000005 c7ff9=
fb0 40228ef4 c7fce074
[   53.290710] 9e80: c7fce040 c7ff3080 80000007 c0484684 00000000 87600=
000 004b0000 00000000
[   53.298950] 9ea0: 00000000 00000002 00010001 00000000 00000780 00000=
000 00000000 00000000
[   53.307189] 9ec0: 00000000 00000000 00000000 c7feb000 00000000 c7feb=
000 ffffff9c 00000000
[   53.315429] 9ee0: 60000013 00000000 00000000 c0630d64 00000005 00000=
007 c7ff9fb0 40228ef4
[   53.323669] 9f00: 402e3600 400922c0 bea93a8c c00451fc 00000003 00000=
003 bea93c3c c01117f0
[   53.331909] 9f20: 00000000 c0111ef4 00000000 00000000 00000000 00000=
000 c7ff3080 c00a8030
[   53.340179] 9f40: c7ff3080 c0100b90 60000013 c7feb000 c0102b10 c00a7=
f5c c7c05bc0 c7c0ed40
[   53.348419] 9f60: 60000013 c0100b90 00000000 bea93c3c c7ff3080 c0482=
cc4 00000000 00000001
[   53.356658] 9f80: 402e4008 c00a7f5c c07fdf68 00000005 00000000 c0482=
cc4 c07fdf68 00000005
[   53.364898] 9fa0: 00000000 00000001 402e4008 c0482cd4 402e3600 00009=
5b8 00000005 402e2c68
[   53.373138] 9fc0: 00000000 00000005 00000000 00000001 402e4008 402e3=
600 400922c0 bea93a8c
[   53.381378] 9fe0: 402e3000 bea934e0 402022e0 40228ef4 60000010 fffff=
fff 00000000 00000000
[   53.389678] [<c00d8d90>] (filemap_fault+0x2c/0x380) from [<c00ee2e4>=
] (__do_fault+0x50/0x41c)
[   53.398284] [<c00ee2e4>] (__do_fault+0x50/0x41c) from [<c00ef750>] (=
handle_mm_fault+0x31c/0x760)
[   53.407165] [<c00ef750>] (handle_mm_fault+0x31c/0x760) from [<c04846=
84>] (do_page_fault+0x124/0x2
c0)
[   53.416381] [<c0484684>] (do_page_fault+0x124/0x2c0) from [<c00451fc=
>] (do_PrefetchAbort+0x34/0x9
4)
[   53.425567] [<c00451fc>] (do_PrefetchAbort+0x34/0x94) from [<c0482cd=
4>] (ret_from_exception+0x0/0
x10)
[   53.434844] Exception stack(0xc7ff9fb0 to 0xc7ff9ff8)
[   53.439941] 9fa0:                                     402e3600 00009=
5b8 00000005 402e2c68
[   53.448181] 9fc0: 00000000 00000005 00000000 00000001 402e4008 402e3=
600 400922c0 bea93a8c
[   53.456420] 9fe0: 402e3000 bea934e0 402022e0 40228ef4 60000010 fffff=
fff
[   53.463104] Code: e59f2348 e5991000 e3a03000 e58d100c (e1c104d8)=20
[   53.469482] ---[ end trace fe98055867aed1db ]---
[   59.962432] BUG: spinlock lockup on CPU#0, db/649, c796c378
[   59.968231] [<c004b5b4>] (unwind_backtrace+0x0/0xec) from [<c022e9a4=
>] (do_raw_spin_lock+0x110/0x
14c)
[   59.977722] [<c022e9a4>] (do_raw_spin_lock+0x110/0x14c) from [<c0481=
c84>] (_raw_spin_lock+0x5c/0x
70)
[   59.987121] [<c0481c84>] (_raw_spin_lock+0x5c/0x70) from [<c00f3c54>=
] (unlink_file_vma+0x24/0x40)
[   59.996246] [<c00f3c54>] (unlink_file_vma+0x24/0x40) from [<c00f1aa0=
>] (free_pgtables+0x60/0x9c)
[   60.005279] [<c00f1aa0>] (free_pgtables+0x60/0x9c) from [<c00f37b4>]=
 (exit_mmap+0xc8/0x160)
[   60.013885] [<c00f37b4>] (exit_mmap+0xc8/0x160) from [<c0079728>] (m=
mput+0x48/0x104)
[   60.021850] [<c0079728>] (mmput+0x48/0x104) from [<c007d4a8>] (exit_=
mm+0x120/0x128)
[   60.029754] [<c007d4a8>] (exit_mm+0x120/0x128) from [<c007edc0>] (do=
_exit+0x198/0x620)
[   60.037902] [<c007edc0>] (do_exit+0x198/0x620) from [<c0049750>] (di=
e+0x2c8/0x30c)
[   60.045715] [<c0049750>] (die+0x2c8/0x30c) from [<c004c6b0>] (__do_k=
ernel_fault+0x64/0x84)
[   60.054229] [<c004c6b0>] (__do_kernel_fault+0x64/0x84) from [<c04847=
f4>] (do_page_fault+0x294/0x2
c0)
[   60.063598] [<c04847f4>] (do_page_fault+0x294/0x2c0) from [<c0045290=
>] (do_DataAbort+0x34/0x94)
[   60.072570] [<c0045290>] (do_DataAbort+0x34/0x94) from [<c04826f4>] =
(__dabt_svc+0x54/0x80)
[   60.081054] Exception stack(0xc7ff9d70 to 0xc7ff9db8)
[   60.086273] 9d60:                                     c704ac28 00000=
000 00000fff 00000000
[   60.094665] 9d80: c704ac28 c7fe68a0 c7fcd280 00000000 00000062 c796e=
e18 c7fce040 c7fce040
[   60.103027] 9da0: 00000062 c7ff9db8 c00ee2e4 c00d8d90 a0000113 fffff=
fff
[   60.109863] [<c04826f4>] (__dabt_svc+0x54/0x80) from [<c00d8d90>] (f=
ilemap_fault+0x2c/0x380)
[   60.118560] [<c00d8d90>] (filemap_fault+0x2c/0x380) from [<c00ee2e4>=
] (__do_fault+0x50/0x41c)
[   60.127319] [<c00ee2e4>] (__do_fault+0x50/0x41c) from [<c00ef750>] (=
handle_mm_fault+0x31c/0x760)
[   60.136352] [<c00ef750>] (handle_mm_fault+0x31c/0x760) from [<c04846=
84>] (do_page_fault+0x124/0x2
c0)
[   60.145751] [<c0484684>] (do_page_fault+0x124/0x2c0) from [<c00451fc=
>] (do_PrefetchAbort+0x34/0x9
4)
[   60.155059] [<c00451fc>] (do_PrefetchAbort+0x34/0x94) from [<c0482cd=
4>] (ret_from_exception+0x0/0
x10)
[   60.164520] Exception stack(0xc7ff9fb0 to 0xc7ff9ff8)
[   60.169738] 9fa0:                                     402e3600 00009=
5b8 00000005 402e2c68
[   60.178131] 9fc0: 00000000 00000005 00000000 00000001 402e4008 402e3=
600 400922c0 bea93a8c
[   60.186492] 9fe0: 402e3000 bea934e0 402022e0 40228ef4 60000010 fffff=
fff
=C3=BB



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
