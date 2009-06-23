From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: musb otg changes break booting on omaps
Date: Tue, 23 Jun 2009 18:50:19 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404327A1514@dbde02.ent.ti.com>
References: <20090623125700.GM7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38687 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbZFWNUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 09:20:43 -0400
In-Reply-To: <20090623125700.GM7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-usb@atomide.com" <linux-usb@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> Looks like commit 84e250ffa76dddc1bad84e04248a27f442c25986
> "musb: proper hookup to transceiver drivers" breaks booting on omaps
> if no transceiver is configured. Got any patches for that?

Tony,

Is this on OMAP35x EVM? If so then the below patch should help.

http://marc.info/?l=linux-omap&m=123907915211910&w=2

Regards,
Ajay

> 
> Regards,
> 
> Tony
> 
> <6>musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
> <4>Platform driver 'musb_hdrc' needs updating - please use dev_pm_ops
> <3>HS USB OTG: no transceiver configured
> <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> <1>Unable to handle kernel NULL pointer dereference at virtual address
> 00000028
> <1>pgd = c0004000
> <1>[00000028] *pgd=00000000
> Internal error: Oops: 5 [#1]
> <d>Modules linked in:
> CPU: 0    Not tainted  (2.6.30-08336-ge9ef5af #417)
> PC is at musb_platform_suspend+0x40/0x88
> LR is at musb_platform_suspend+0x3c/0x88
> pc : [<c027905c>]    lr : [<c0279058>]    psr: a0000013
> sp : cf823de8  ip : 22222222  fp : c050b1a0
> r10: 00000000  r9 : 00000000  r8 : c052e5b0
> r7 : c0534bdc  r6 : cf8190e8  r5 : cf8190e8  r4 : cf8190e8
> r3 : c0505ce0  r2 : cf822000  r1 : d80ab404  r0 : 00000000
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 80004019  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xcf8222f0)
> Stack: (0xcf823de8 to 0xcf824000)
> 3de0:                   cf8190e8 c02790b0 00000000 c0277aec ffffffed
> 00000000
> 3e00: cf8190e8 c001d8b8 00000001 cf804184 00000001 cf804180 00000000
> c050b198
> 3e20: 0000005c d80ab000 c050b17c c01ca068 00000000 cf823e84 00000000
> c03acff4
> 3e40: 00000000 cf8741e0 cf823ea8 cf8537e0 cf823ea8 c0106be8 00000001
> 00000000
> 3e60: cf874180 cf823ea8 cf8741e0 c01067b8 cf874180 cf8741e0 cf823ea8
> c0106890
> 3e80: cf823ea8 cf8741e0 cf874180 cf8741e0 00000000 cf8741e0 cf823ea8
> cf8537e0
> 3ea0: 00000001 c0107834 cf8537e0 00000000 00000000 c050b1a0 c050b1d4
> c0534bdc
> 3ec0: c0534bdc c052e5b0 00000000 00000000 00000000 c0200e28 c050b1a0
> c0200004
> 3ee0: c050b1a0 c050b1d4 c0534bdc c0534bdc c052e5b0 c0200110 00000000
> cf823f08
> 3f00: c02000b0 c01ff3ec cf802d08 cf852f40 c0534bdc c04fe0c4 c0534bdc
> cf91f9c0
> 3f20: 00000060 c01ffa1c c03d0200 c03d0200 cf824000 c0026034 c0534bdc
> c05445c0
> 3f40: 00000000 00000000 c001cd44 c02003e0 c0026034 c0534bc0 c05445c0
> 00000000
> 3f60: 00000000 00000000 c001cd44 c020120c c0026034 00000000 c05445c0
> c002b290
> 3f80: 00000000 c01007d4 cf823fb4 c0468f1c 00008100 0000024e c0519018
> cf84ed80
> 3fa0: c0519018 0000015f c055bec8 c0100928 c0468f1c cf84ed00 cf823fc6
> c0083690
> 3fc0: 00000000 35334d80 00000031 00000000 c0026034 00000000 00000000
> 00000000
> 3fe0: 00000000 00000000 00000000 c0008860 00000000 c002cd84 ffffffff
> ffffffff
> [<c027905c>] (musb_platform_suspend+0x40/0x88) from [<c02790b0>]
> (musb_platform)
> [<c02790b0>] (musb_platform_exit+0xc/0x20) from [<c0277aec>]
> (musb_free+0x74/0x)
> [<c0277aec>] (musb_free+0x74/0xb8) from [<c001d8b8>]
> (musb_probe+0x9d4/0xbac)
> [<c001d8b8>] (musb_probe+0x9d4/0xbac) from [<c0200e28>]
> (platform_drv_probe+0x1)
> [<c0200e28>] (platform_drv_probe+0x18/0x1c) from [<c0200004>]
> (driver_probe_dev)
> [<c0200004>] (driver_probe_device+0xa0/0x14c) from [<c0200110>]
> (__driver_attac)
> [<c0200110>] (__driver_attach+0x60/0x84) from [<c01ff3ec>]
> (bus_for_each_dev+0x)
> [<c01ff3ec>] (bus_for_each_dev+0x44/0x78) from [<c01ffa1c>]
> (bus_add_driver+0xf)
> [<c01ffa1c>] (bus_add_driver+0xf0/0x274) from [<c02003e0>]
> (driver_register+0xa)
> [<c02003e0>] (driver_register+0xa8/0x130) from [<c020120c>]
> (platform_driver_pr)
> [<c020120c>] (platform_driver_probe+0x10/0x88) from [<c002b290>]
> (do_one_initca)
> [<c002b290>] (do_one_initcall+0x50/0x17c) from [<c0008860>]
> (kernel_init+0x8c/0)
> [<c0008860>] (kernel_init+0x8c/0x104) from [<c002cd84>]
> (kernel_thread_exit+0x0)
> Code: e59f104c e3800004 ebf712f8 e594009c (e5903028)
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <0>Kernel panic - not syncing: Attempted to kill init!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

