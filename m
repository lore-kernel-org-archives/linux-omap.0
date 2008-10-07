From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: kernel oops for 3430sdp
Date: Tue, 7 Oct 2008 13:07:44 -0500
Message-ID: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34636 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbYJGSHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 14:07:51 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m97I7j9F020075
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 13:07:50 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m97I7jVs013964
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 13:07:45 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I attempted to run a kernel image in my 3430sdp compiled with the latest commit. I performed these steps:

1.- Loaded omap_3430sdp_defconfig
2.- Entered menuconfig and I added the option:

Device Drivers --->
	GPIO support --->
		<*>   TWL4030/TPS659x0 GPIO Driver

3.- compiled it and loaded in my 3430SDP with u-boot

4.- Booted and got a kernel Oops:

<6>musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27-rc8-omap1-05072-gf9ceca7 #6)
PC is at musb_platform_init+0x24/0x120
LR is at 0x0
pc : [<c001df5c>]    lr : [<00000000>]    psr: a0000013
sp : c681dd50  ip : c68281b4  fp : c681dd64
r10: c001d288  r9 : 00000000  r8 : c0374b08
r7 : c037950c  r6 : c68280d8  r5 : 00000000  r4 : c68280d8
r3 : c035fba4  r2 : 00000000  r1 : c681dcf8  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc681c2e0)
Stack: (0xc681dd50 to 0xc681e000)
dd40:                                     c0362d34 00000000 c681de44 c681dd68
dd60: c001d634 c001df44 00000000 c036d050 c681dd9c c681dd80 c029c10c c0362b90
dd80: c0362b98 0000005c d80ab000 c0362cb8 c681ddac c681dda0 c029c16c c029c07c
dda0: c681ddec c681ddb0 c00dd55c c029c168 c00dd294 c00dd170 c68621b8 c6862158
ddc0: c681ddf0 c6832548 c681ddec 00000000 c6862158 c681ddf0 c6832548 00000001
dde0: c681de24 c681ddf0 c00de1d0 c00dd54c c6832548 00000000 00000000 00000001
de00: c681de44 c0362b98 00000000 c0362c00 c037950c c0374b08 c681de34 c0362b98
de20: c0362c44 c037950c c037950c c0374b08 00000000 c001d288 c681de54 c681de48
de40: c01a7298 c001d438 c681de74 c681de58 c01a6530 c01a7284 c0362b98 c0362c44
de60: c037950c c037950c c681de94 c681de78 c01a6628 c01a646c 00000000 c681de9c
de80: c01a65dc c037950c c681dec4 c681de98 c01a5ba8 c01a65e8 00000000 c6803d58
dea0: c6803d58 c0362be0 00000000 c037950c 00000000 c684c660 c681ded4 c681dec8
dec0: c01a6378 c01a5b68 c681df04 c681ded8 c01a6034 c01a6364 c02afc98 c037950c
dee0: 00000000 c037f380 c037950c 00000000 00000000 00000000 c681df2c c681df08
df00: c01a681c c01a5f98 c037f380 c03794ec 00000000 00000000 00000000 c001d288
df20: c681df3c c681df30 c01a7630 c01a6790 c681df54 c681df40 c01a7664 c01a75c4
df40: c037f380 c0025454 c681df64 c681df58 c001d2c4 c01a7658 c681dfdc c681df68
df60: c002d298 c001d294 c681df94 c681df78 c00d7800 c00d75bc c681df94 c683e260
df80: c00d7944 c681df9e c681dfc4 c681df98 c0077dfc c00d77d4 c681dfb4 3533cd28
dfa0: 00000031 00000000 00000192 c0025454 00000000 c0025524 c0025454 00000000
dfc0: 00000000 00000000 00000000 00000000 c681dff4 c681dfe0 c00088d4 c002d254
dfe0: 00000000 00000000 00000000 c681dff8 c005468c c0008870 124a023d 8e0b1e5e
Backtrace:
[<c001df38>] (musb_platform_init+0x0/0x120) from [<c001d634>] (musb_probe+0x208/0xb0c)
 r5:00000000 r4:c0362d34
[<c001d42c>] (musb_probe+0x0/0xb0c) from [<c01a7298>] (platform_drv_probe+0x20/0x24)
[<c01a7278>] (platform_drv_probe+0x0/0x24) from [<c01a6530>] (driver_probe_device+0xd0/0x17c)
[<c01a6460>] (driver_probe_device+0x0/0x17c) from [<c01a6628>] (__driver_attach+0x4c/0x70)
 r7:c037950c r6:c037950c r5:c0362c44 r4:c0362b98
[<c01a65dc>] (__driver_attach+0x0/0x70) from [<c01a5ba8>] (bus_for_each_dev+0x4c/0x84)
 r7:c037950c r6:c01a65dc r5:c681de9c r4:00000000
[<c01a5b5c>] (bus_for_each_dev+0x0/0x84) from [<c01a6378>] (driver_attach+0x20/0x28)
 r7:c684c660 r6:00000000 r5:c037950c r4:00000000
[<c01a6358>] (driver_attach+0x0/0x28) from [<c01a6034>] (bus_add_driver+0xa8/0x214)
[<c01a5f8c>] (bus_add_driver+0x0/0x214) from [<c01a681c>] (driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:00000000 r5:c037950c r4:c037f380
[<c01a6784>] (driver_register+0x0/0x120) from [<c01a7630>] (platform_driver_register+0x78/0x94)
[<c01a75b8>] (platform_driver_register+0x0/0x94) from [<c01a7664>] (platform_driver_probe+0x18/0x68)
[<c01a764c>] (platform_driver_probe+0x0/0x68) from [<c001d2c4>] (musb_init+0x3c/0x54)
 r5:c0025454 r4:c037f380
[<c001d288>] (musb_init+0x0/0x54) from [<c002d298>] (__exception_text_end+0x50/0x17c)
[<c002d248>] (__exception_text_end+0x0/0x17c) from [<c00088d4>] (kernel_init+0x70/0xdc)
[<c0008864>] (kernel_init+0x0/0xdc) from [<c005468c>] (do_exit+0x0/0x6b8)
 r5:00000000 r4:00000000
Code: e5943000 e284c0dc e3530000 e1a0e000 (e8be000f)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill init!

Is someone else seeing this?

Regards,
Sergio
