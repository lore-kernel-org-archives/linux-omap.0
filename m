From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: USB slightly broken
Date: Fri, 19 Dec 2008 14:28:58 +0200
Message-ID: <1229689738.18039.15.camel@tubuntu>
References: <1229682316.18039.12.camel@tubuntu>
	 <20081219115838.GB7125@gandalf.research.nokia.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23625 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYLSM3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 07:29:18 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBJCSvDF002941
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 14:29:15 +0200
In-Reply-To: <20081219115838.GB7125@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap <linux-omap@vger.kernel.org>

On Fri, 2008-12-19 at 13:58 +0200, Felipe Balbi wrote:
> On Fri, Dec 19, 2008 at 12:25:16PM +0200, ext Tomi Valkeinen wrote:
> > Yesterday's "Merge branch 'musb'" broke the USB slightly on our board. I
> > use NFS root via USB gadget ethernet and if I have the usb cable
> > connected when the device boots up, the network does not go up
> > correctly. If I disconnect and connect the cable the USB starts working.
> > 
> > I can't currently test this on other boards, but I will test it on
> > beagle later. 
> > 
> > g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> > IP-Config: Guessing netmask 255.255.255.0
> > IP-Config: Complete:
> >      device=usb0, addr=192.168.2.15, mask=255.255.255.0, gw=255.255.255.255,
> >      host=192.168.2.15, domain=, nis-domain=(none),
> >      bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
> > Looking up port of RPC 100003/2 on 192.168.2.14
> > 
> > (at this point the interface is up on PC side, but pings don't go through)
> 
> Could you try this patch: (untested)

This patch randomly fixes the problem and randomly crashes (usually
crashes):

g_ether gadget: high speed config #1: CDC Ethernet (ECM)
kernel BUG at drivers/usb/musb/musbhsdma.c:168!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.28-rc9-omap1 #19)
PC is at __bug+0x20/0x2c
LR is at release_console_sem+0x190/0x1a8
pc : [<c002fb70>]    lr : [<c004cdd4>]    psr: 60000193
sp : cf81fb20  ip : cf81fa50  fp : cf81fb2c
r10: c039fa8c  r9 : 00003ffe  r8 : 8f949002
r7 : 00000200  r6 : cf951068  r5 : cf951068  r4 : 00002003
r3 : 00000000  r2 : c0354a8c  r1 : 000029af  r0 : 00000033
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xcf81e2e0)
Stack: (0xcf81fb20 to 0xcf820000)
fb20: cf81fb7c cf81fb30 c01d691c c002fb5c cf96a160 00000600 cf81b338 00000020 
fb40: cf81fb74 cf81fb50 c01d767c 00000001 cf948ba0 00002003 cf96a160 cf81b338 
fb60: 00003ffe 00002003 d80ab110 00003ffe cf81fbbc cf81fb80 c01d20a8 c01d6898 
fb80: 00003ffe cf96a160 cf81fbbc cf81fb98 c01d1c4c 00002003 cf81b338 cf951068 
fba0: cf96a160 00000003 cf81b0f0 d80ab110 cf81fc04 cf81fbc0 c01d3510 c01d1ff4 
fbc0: 00000000 00000000 00000000 00000000 00000001 d80ab116 00000000 cf956720 
fbe0: cf951068 0000005a 8f948002 8f94805c 00000193 d80ab000 cf81fc14 cf81fc08 
fc00: c01cf130 c01d3220 cf81fc6c cf81fc18 c01d6bd8 c01cf0d0 00000000 00000000 
fc20: 00000000 00000000 00000000 00000000 cf951000 cf81b0f0 00000004 00000002 
fc40: c01714ec cf956720 00000000 00000000 0000005d cf81b338 00000000 000000d0 
fc60: cf81fc8c cf81fc70 c0072828 c01d6a98 c035809c 0000005d cf96a160 00000000 
fc80: cf81fca4 cf81fc90 c0074320 c00727f8 0000005d 00000000 cf81fcbc cf81fca8 
fca0: c002c068 c0074258 ffffffff d8200000 cf81fd2c cf81fcc0 c0285f70 c002c00c 
fcc0: 00000000 00000000 0000022c 0000061d cf843bc0 cf948ba0 cf96a160 00000000 
fce0: cf81b338 00000000 000000d0 cf81fd2c 00000224 cf81fd08 c01d20a8 c01d769c 
fd00: 00000013 ffffffff cf948ba0 000000d0 00001003 00001002 c002b194 c0024364 
fd20: cf81fd44 cf81fd30 c01d7748 c01d75b0 cf948ba0 000000d0 cf81fd5c cf81fd48 
fd40: c01d7824 c01d770c cf948ba0 cf948800 cf81fd74 cf81fd60 c01da2c0 c01d7800 
fd60: cf948800 cf948830 cf81fd8c cf81fd78 c02052dc c01da28c cf948800 00000001 
fd80: cf81fdac cf81fd90 c02043ac c020524c c03a04c0 cf948800 00000003 00001002 
fda0: cf81fe5c cf81fdb0 c00244c8 c0204320 00000000 c0368638 cf81fdec cf81fdc8 
fdc0: c0055644 c0054bbc cf81fdee a0000013 c039c36c c0368628 00000000 c0368638 
fde0: cf81fe14 cf81fdf0 c005c8d0 c00555b0 c039bca0 c039c340 00000000 00000000 
fe00: 00000000 c001ac14 cf81fe24 cf81fe18 cf81fe34 cf81fe20 c0238f80 c015f118 
fe20: c0327255 c00270bc cf81fe4c cf81fe38 c0238fcc c0375b00 c00270bc 00000000 
fe40: 00000000 00000000 00000000 c0024364 cf81ffdc cf81fe60 c002c314 c0024370 
fe60: 00000000 cf812cc0 00000000 000000d0 cf81fedc cf81fe80 c007b594 c007b0d4 
fe80: 00000000 00000044 c007b594 00000000 00000000 cf81fedc 00000010 ffffffff 
fea0: 00000000 cf81feec 00000000 ffffffff cf8035a0 00000000 00000000 cf83d6e0 
fec0: cf8035a0 cf8035a4 00000000 0000024e cf81ff34 cf81fee0 c015b05c c0096714 
fee0: cf81ff0c cf81ff54 c0096d4c cf811e30 00000000 c038cb20 000000d0 c038b66c 
ff00: cf81ff2c cf81ff10 c015b270 cf83c0a0 c035bd14 cf83d6e0 c038b66c 00000000 
ff20: 00000000 00000000 cf81ff44 cf81ff38 c015b090 c015aec8 cf81ff74 cf81ff48 
ff40: c00d82d0 c015b084 cf83d6e0 c0305643 cf81ff9e 0000024e cf83c0a0 c035bd14 
ff60: 0000015f c038b66c cf81ff94 cf81ff78 c00d8500 c00d82a4 cf81ff94 cf83d6e0 
ff80: c00d8634 cf81ff9e cf81ffc4 cf81ff98 c0074824 c00d84c4 cf81ffb4 3533d9e8 
ffa0: 00000031 00000000 00000192 c035c908 00000000 c0027434 c00270bc 00000000 
ffc0: 00000000 00000000 00000000 00000000 cf81fff4 cf81ffe0 c000871c c002c2bc 
ffe0: 00000000 00000000 00000000 cf81fff8 c004f030 c00086b8 00000000 00000000 
Backtrace: 
[<c002fb50>] (__bug+0x0/0x2c) from [<c01d691c>] (dma_channel_program+0x90/0x16c)
[<c01d688c>] (dma_channel_program+0x0/0x16c) from [<c01d20a8>] (rxstate+0xc0/0x18c)
[<c01d1fe8>] (rxstate+0x0/0x18c) from [<c01d3510>] (musb_g_rx+0x2fc/0x370)
[<c01d3214>] (musb_g_rx+0x0/0x370) from [<c01cf130>] (musb_dma_completion+0x6c/0x70)
[<c01cf0c4>] (musb_dma_completion+0x0/0x70) from [<c01d6bd8>] (dma_controller_irq+0x14c/0x184)
[<c01d6a8c>] (dma_controller_irq+0x0/0x184) from [<c0072828>] (handle_IRQ_event+0x3c/0x74)
[<c00727ec>] (handle_IRQ_event+0x0/0x74) from [<c0074320>] (handle_level_irq+0xd4/0xf0)
 r7:00000000 r6:cf96a160 r5:0000005d r4:c035809c
[<c007424c>] (handle_level_irq+0x0/0xf0) from [<c002c068>] (__exception_text_start+0x68/0x88)
 r5:00000000 r4:0000005d
[<c002c000>] (__exception_text_start+0x0/0x88) from [<c0285f70>] (__irq_svc+0x30/0x80)
Exception stack(0xcf81fcc0 to 0xcf81fd08)
fcc0: 00000000 00000000 0000022c 0000061d cf843bc0 cf948ba0 cf96a160 00000000 
fce0: cf81b338 00000000 000000d0 cf81fd2c 00000224 cf81fd08 c01d20a8 c01d769c 
fd00: 00000013 ffffffff                                                       
 r5:d8200000 r4:ffffffff
[<c01d75a4>] (rx_submit+0x0/0x15c) from [<c01d7748>] (rx_fill+0x48/0x88)
[<c01d7700>] (rx_fill+0x0/0x88) from [<c01d7824>] (eth_start+0x30/0x84)
 r5:000000d0 r4:cf948ba0
[<c01d77f4>] (eth_start+0x0/0x84) from [<c01da2c0>] (eth_open+0x40/0x74)
 r5:cf948800 r4:cf948ba0
[<c01da280>] (eth_open+0x0/0x74) from [<c02052dc>] (dev_open+0x9c/0xf8)
 r5:cf948830 r4:cf948800
[<c0205240>] (dev_open+0x0/0xf8) from [<c02043ac>] (dev_change_flags+0x98/0x168)
 r5:00000001 r4:cf948800
[<c0204314>] (dev_change_flags+0x0/0x168) from [<c00244c8>] (ip_auto_config+0x164/0xebc)
 r7:00001002 r6:00000003 r5:cf948800 r4:c03a04c0
[<c0024364>] (ip_auto_config+0x0/0xebc) from [<c002c314>] (__exception_text_end+0x64/0x198)
[<c002c2b0>] (__exception_text_end+0x0/0x198) from [<c000871c>] (kernel_init+0x70/0xdc)
[<c00086ac>] (kernel_init+0x0/0xdc) from [<c004f030>] (do_exit+0x0/0x6a8)
 r5:00000000 r4:00000000
Code: e1a01000 e59f000c eb007605 e3a03000 (e5833000) 
Kernel panic - not syncing: Fatal exception in interrupt



