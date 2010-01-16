From: Paul Walmsley <paul@booyaka.com>
Subject: overo_defconfig missing MUSB transceiver definition?
Date: Fri, 15 Jan 2010 20:06:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001152003160.11569@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50704 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822Ab0APDGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 22:06:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org


Hi,

Overo crashes on boot with an overo_defconfig kernel; looks like the 
reason why is a missing MUSB transceiver definition.

It would be nice if the MUSB init would simply fail if no transceiver was 
defined, that would avoid what seems to be an unnecessary crash.

regards

- Paul

musb_hdrc: version 6.0, pio, host, debug=0
HS USB OTG: no transceiver configured
musb_hdrc musb_hdrc: musb_init_controller failed with status -19
Unable to handle kernel NULL pointer dereference at virtual address 
00000040
pgd = c0004000
[00000040] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file: 
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc3-07237-g445c4a9 #210)
PC is at musb_platform_suspend+0x40/0x88
LR is at musb_platform_suspend+0x3c/0x88
pc : [<c02321bc>]    lr : [<c02321b8>]    psr: a0000013
sp : cf823e30  ip : 00000000  fp : 00000000
r10: cf862000  r9 : 00000000  r8 : c04cc4f8
r7 : cf880300  r6 : cf8620f8  r5 : cf8620f8  r4 : cf8620f8
r3 : c04abd3c  r2 : cf855b70  r1 : fa0ab404  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xcf8222f0)
Stack: (0xcf823e30 to 0xcf824000)
3e20:                                     cf8620f8 c0232210 00000000 c02315b0
3e40: ffffffed 00000000 cf8620f8 c001c644 00000000 c04bbfec 00000000 00000000
3e60: c0362c9c c04aefc8 c04aefd0 0000005c fa0ab000 c04aefac cf862194 00000002
3e80: cf8f6880 00000000 cf8f6880 00000002 00000000 c051bc8c cf823eec c019e19c
3ea0: 00000000 cf806850 00000000 000000d0 c01013d8 00000007 cf8f71b0 cf8f7210
3ec0: cf823f08 c01011cc cf823f08 cf8f7210 00000000 c0363310 00000000 cf823f08
3ee0: cf823f08 c0101718 cf823f08 00000000 cf823f08 cf8f7210 00000000 cf823f08
3f00: cf8f7210 c0101c5c cf855b70 c04aefd0 c04aefd0 c04d1ac0 cf880300 c04cc4f8
3f20: 00000000 00000000 00000000 c01d2fcc c04aefd0 c01d2090 c04aefd0 c04af004
3f40: c04d1ac0 cf880300 c04cc4f8 c01d219c 00000000 c01d213c c04d1ac0 c01d1900
3f60: cf80d1b8 cf880cb0 c00240f8 00000080 c04d1ac0 c01d1254 c0386210 c0386210
3f80: 00000001 c00240f8 c04d1aac c04d1ac0 00000000 00000000 00000000 c01d246c
3fa0: c00240f8 c04d1aac c001ba90 00000000 00000000 c01d3240 c00240f8 00000000
3fc0: c001ba90 c002a334 00000031 00000000 00000000 00000170 00000000 c00240f8
3fe0: 00000000 00000000 00000000 c0008578 00000000 c002b870 00ffed00 0077ef58
[<c02321bc>] (musb_platform_suspend+0x40/0x88) from [<c0232210>] (musb_platform_exit+0xc/0x20)
[<c0232210>] (musb_platform_exit+0xc/0x20) from [<c02315b0>] (musb_free+0x60/0x94)
[<c02315b0>] (musb_free+0x60/0x94) from [<c001c644>] (musb_probe+0xa14/0xaf8)
[<c001c644>] (musb_probe+0xa14/0xaf8) from [<c01d2fcc] (platform_drv_probe+0x18/0x1c)
[<c01d2fcc>] (platform_drv_probe+0x18/0x1c) from [<c01d2090>] (driver_probe_device+0xa0/0x14c)
[<c01d2090>] (driver_probe_device+0xa0/0x14c) from [<c01d219c>] (__driver_attach+0x60/0x84)
[<c01d219c>] (__driver_attach+0x60/0x84) from [<c01d1900>] (bus_for_each_dev+0x44/0x74)
[<c01d1900>] (bus_for_each_dev+0x44/0x74) from [<c01d1254>] (bus_add_driver+0xf4/0x284)
[<c01d1254>] (bus_add_driver+0xf4/0x284) from [<c01d246c>] (driver_register+0xa8/0x130)
[<c01d246c>] (driver_register+0xa8/0x130) from [<c01d3240>] (platform_driver_probe+0x18/0x68)
[<c01d3240>] (platform_driver_probe+0x18/0x68) from [<c002a334>] (do_one_initcall+0x5c/0x1b4)
[<c002a334>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>] (kernel_init+0x90/0x10c)
[<c0008578>] (kernel_init+0x90/0x10c) from [<c002b870>] (kernel_thread_exit+0x0/0x8)
Code: e59f104c e3800004 ebf82651 e5940090 (e5903040) 
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill init!
INFO: RCU detected CPU 0 stall (t=1280 jiffies)

