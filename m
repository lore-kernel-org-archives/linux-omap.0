From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2 0/8] introduce 3630 boards
Date: Wed, 11 Nov 2009 20:49:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A705CA4@dbde02.ent.ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47319 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000AbZKKPTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 10:19:22 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABFJPFg006440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:19:27 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABFJOBu020971
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 20:49:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Vikram,
> 
> I'm afraid current linux-omap master + these patches does not boot
> on my 3630SDP.
> 
> The bootargs used were:
> mem=256M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw 
> nfsroot=172.24.162.66:/vol/vol2/swcoe_omapsw_linux1/anand/targ
> et,nolock,tcp 
> ip=172.24.190.229:172.24.162.66:172.24.188.1:255.255.252.0:myomap::off
> 
> The image hangs after "Uncompressing kernel...... done, 
> booting the kernel."
> 

And I just remembered we now need to patch kernel/printk.c to see
low-level printks. And here's what I get:

<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<7>PM: Adding info for platform:serial8250
<7>PM: Adding info for No Bus:ttyS0
<7>PM: Adding info for No Bus:ttyS1
<7>PM: Adding info for No Bus:ttyS2
<7>PM: Adding info for No Bus:ttyS3
<7>PM: Removing info for No Bus:ttyS0
<1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a000
<0>Internal error: : 1028 [#1]
<0>last sysfs file:
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.32-rc6-06432-ge7e7a61-dirty #13)
PC is at mem_serial_in+0xc/0x14
LR is at serial8250_config_port+0x86c/0xb1c
pc : [<c018c82c>]    lr : [<c018e184>]    psr: 00000093
sp : cf823d80  ip : c018c834  fp : 00000003
r10: 00000003  r9 : 00000001  r8 : 20000013
r7 : c03b3650  r6 : 00000060  r5 : 00000700  r4 : 00000700
r3 : 00000002  r2 : fa06a000  r1 : 00000000  r0 : c03b3650
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000017
<0>Process swapper (pid: 1, stack limit = 0xcf8222e8)
<0>Stack: (0xcf823d80 to 0xcf824000)
<0>3d80: c03b3650 fffffffe 10000000 02dc6c00 00000000 00000002 c03b3650 4806a000
<0>3da0: cf872000 c0377dc0 c039b1c4 c018a444 cf8dd488 cf8ab548 cf8ab560 c00e3400
<0>3dc0: cf8ab548 cf87202c cf8ac0c0 c039b300 cf8a9308 c039b300 cf8aed80 c01639e4
<0>3de0: cf8a9324 c0163984 cf872000 c0164648 cf8a9300 c03b3650 00000000 c0281a70
<0>3e00: 00000000 c03b3650 cf872000 02dc6c00 00000000 00000002 00000002 4806a000
<0>3e20: c03b3650 c0377dc0 cf823e78 c018f8f0 00000000 c037813c 00000000 4806a000
<0>3e40: c0377e10 c0377e18 00000000 10000000 fa06a000 c027f2ec cf847a80 cf8a90c0
<0>3e60: cf823e9c 00000001 cf872174 ffffffff cf823eac c0377e18 00000000 fa06a000
<0>3e80: 00000000 00000000 00000048 00000080 02dc6c00 00000000 00020200 00000000
<0>3ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
<0>3ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 10000000
<0>3ee0: 00000000 00000000 00000000 00000000 00000000 00000000 4806a000 c0377e18
<0>3f00: 00000000 c0377dc0 00000000 c0377e18 c0377e18 c039b2b0 cf8f6dc0 c039b4f8
<0>3f20: 00000000 00000000 00000000 c0193ab8 c0377e18 c0192cb4 c0377e18 c0377e4c
<0>3f40: c039b2b0 cf8f6dc0 c039b4f8 c0192dc0 00000000 c0192d60 c039b2b0 c0192588
<0>3f60: cf803af8 cf8457f0 c03b3970 c039b2b0 c039b2b0 c0191ee8 c0304289 c0304289
<0>3f80: 00000001 c03b3970 00000005 c039b2b0 00000000 00000000 00000000 c0193090
<0>3fa0: c03b3970 00000005 cf8dd488 00000000 00000000 c00181e0 c0022dd4 00000000
<0>3fc0: c00180f0 c0028334 00000031 00000000 00000000 00000192 00000000 c0022dd4
<0>3fe0: 00000000 00000000 00000000 c0008578 00000000 c0029dbc 00000000 00000000
[<c018c82c>] (mem_serial_in+0xc/0x14) from [<c018e184>] (serial8250_config_port+0x86c/0xb1c)
[<c018e184>] (serial8250_config_port+0x86c/0xb1c) from [<c018a444>] (uart_add_one_port+0xf4/0x2f0)
[<c018a444>] (uart_add_one_port+0xf4/0x2f0) from [<c018f8f0>] (serial8250_register_port+0x1bc/0x1ec)
[<c018f8f0>] (serial8250_register_port+0x1bc/0x1ec) from [<c027f2ec>] (serial8250_probe+0xb4/0x130)
[<c027f2ec>] (serial8250_probe+0xb4/0x130) from [<c0193ab8>] (platform_drv_probe+0x18/0x1c)
[<c0193ab8>] (platform_drv_probe+0x18/0x1c) from [<c0192cb4>] (driver_probe_device+0xa0/0x14c)
[<c0192cb4>] (driver_probe_device+0xa0/0x14c) from [<c0192dc0>] (__driver_attach+0x60/0x84)
[<c0192dc0>] (__driver_attach+0x60/0x84) from [<c0192588>] (bus_for_each_dev+0x44/0x74)
[<c0192588>] (bus_for_each_dev+0x44/0x74) from [<c0191ee8>] (bus_add_driver+0x9c/0x220)
[<c0191ee8>] (bus_add_driver+0x9c/0x220) from [<c0193090>] (driver_register+0xa8/0x130)
[<c0193090>] (driver_register+0xa8/0x130) from [<c00181e0>] (serial8250_init+0xf0/0x140)
[<c00181e0>] (serial8250_init+0xf0/0x140) from [<c0028334>] (do_one_initcall+0x5c/0x1b4)
[<c0028334>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>] (kernel_init+0x90/0x10c)
[<c0008578>] (kernel_init+0x90/0x10c) from [<c0029dbc>] (kernel_thread_exit+0x0/0x8)
<0>Code: e8bd8010 e5d03021 e5902004 e1a01311 (e7d20001)
<4>---[ end trace 04a098cdbfa0583b ]---
<0>Kernel panic - not syncing: Attempted to kill init!