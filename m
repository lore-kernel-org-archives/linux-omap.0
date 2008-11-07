From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: 3430SDP crash at boot time
Date: Thu, 6 Nov 2008 21:12:21 -0600
Message-ID: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34614 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYKGDM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 22:12:28 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mA73CNKL016678
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 21:12:28 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mA73CN2W023494
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 21:12:23 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

 

Today when I attempted to boot on an 3430SDP with latest commit, I got a kernel dump, which is this:

 

<7>eth0: No PHY found
<6>i2c /dev entries driver
i2c /dev entries driver
<4>Driver 'sd' needs updating - please use bus_type methods
Driver 'sd' needs updating - please use bus_type methods
<1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xc9000020
Unhandled fault: external abort on non-linefetch (0x1028) at 0xc9000020
Internal error: : 1028 [#1]
Internal error: : 1028 [#1]
Modules linked in:Modules linked in:
 
CPU: 0    Not tainted  (2.6.28-rc3-omap1-05164-g0d272a9 #1)
CPU: 0    Not tainted  (2.6.28-rc3-omap1-05164-g0d272a9 #1)
PC is at cfi_qry_present+0x1c0/0x29c
PC is at cfi_qry_present+0x1c0/0x29c
LR is at cfi_qry_present+0x64/0x29c
LR is at cfi_qry_present+0x64/0x29c
pc : [<c01d17bc>]    lr : [<c01d1660>]    psr: 60000013
sp : c7817c38  ip : 00000006  fp : c7817c74
pc : [<c01d17bc>]    lr : [<c01d1660>]    psr: 60000013
sp : c7817c38  ip : 00000006  fp : c7817c74
r10: 00000001  r9 : 00000001  r8 : 00000000
r10: 00000001  r9 : 00000001  r8 : 00000000
r7 : 00000002  r6 : c79e9968  r5 : 00000002  r4 : 00000001
r7 : 00000002  r6 : c79e9968  r5 : 00000002  r4 : 00000001
r3 : c9000000  r2 : 00000020  r1 : 00000002  r0 : 00005959
r3 : c9000000  r2 : 00000020  r1 : 00000002  r0 : 00005959
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004018  DAC: 00000017
Control: 10c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc78162e0)
Process swapper (pid: 1, stack limit = 0xc78162e0)
Stack: (0xc7817c38 to 0xc7818000)
Stack: (0xc7817c38 to 0xc7818000)
7c20: 7c20:                                                                                                             00005151 00005151 00005252 00005252


7c40: 7c40: 00005959 00005959 c7817c50 c7817c50 00000025 00000025 00000000 00000000 00000001 00000001 c79e9968 c79e9968 00000002 00000002 00000002 00000002
 

7c60: 7c60: 00000000 00000000 c7817ce8 c7817ce8 c7817ca4 c7817ca4 c7817c78 c7817c78 c01d1a60 c01d1a60 c01d1608 c01d1608 000000ff 000000ff 00000000 00000000
 

7c80: 7c80: c79e9968 c79e9968 00000001 00000001 c7817ce8 c7817ce8 c037d5a8 c037d5a8 00000000 00000000 c79e9968 c79e9968 c7817cdc c7817cdc c7817ca8 c7817ca8
 

7ca0: 7ca0: c01d0dbc c01d0dbc c01d18a4 c01d18a4 00000006 00000006 00000004 00000004 00000007 00000007 00000001 00000001 00000002 00000002 00000001 00000001
 

7cc0: 7cc0: c0395f24 c0395f24 c037d5a8 c037d5a8 00000000 00000000 c79e9968 c79e9968 c7817d4c c7817d4c c7817ce0 c7817ce0 c01d76ec c01d76ec c01d0d60 c01d0d60
 

7ce0: 7ce0: 20000013 20000013 ffffffff ffffffff 00000000 00000000 00000000 00000000 00000002 00000002 00000001 00000001 00000000 00000000 00000000 00000000
 

7d00: 7d00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 

7d20: 7d20: c7817d50 c7817d50 c0395f0c c0395f0c c0323cd9 c0323cd9 c79e9968 c79e9968 c037d188 c037d188 c037d5a8 c037d5a8 00000000 00000000 c037d1a8 c037d1a8
 

7d40: 7d40: c7817d5c c7817d5c c7817d50 c7817d50 c01d0d4c c01d0d4c c01d7684 c01d7684 c7817d7c c7817d7c c7817d60 c7817d60 c01d0d18 c01d0d18 c01d0d44 c01d0d44
 

7d60: 7d60: c79e9960 c79e9960 04000000 04000000 04000000 04000000 c037d188 c037d188 c7817da4 c7817da4 c7817d80 c7817d80 c001ceac c001ceac c01d0cd4 c01d0cd4
 

7d80: 7d80: c037d1b0 c037d1b0 c037d25c c037d25c c039600c c039600c c039600c c039600c c0395050 c0395050 c001cdbc c001cdbc c7817db4 c7817db4 c7817da8 c7817da8
 

7da0: 7da0: c01af750 c01af750 c001cdec c001cdec c7817dd4 c7817dd4 c7817db8 c7817db8 c01ae970 c01ae970 c01af73c c01af73c c037d1b0 c037d1b0 c037d25c c037d25c
 

7dc0: 7dc0: c039600c c039600c c039600c c039600c c7817df4 c7817df4 c7817dd8 c7817dd8 c01aea84 c01aea84 c01ae8ac c01ae8ac 00000000 00000000 c7817df8 c7817df8
 

7de0: 7de0: c01aea1c c01aea1c c039600c c039600c c7817e1c c7817e1c c7817df8 c7817df8 c01adeec c01adeec c01aea28 c01aea28 c78034d8 c78034d8 c037d1f8 c037d1f8
 

7e00: 7e00: 00000000 00000000 c039600c c039600c 00000000 00000000 c78c6ea0 c78c6ea0 c7817e2c c7817e2c c7817e20 c7817e20 c01ae7b8 c01ae7b8 c01adeac c01adeac
 

7e20: 7e20: c7817e5c c7817e5c c7817e30 c7817e30 c01ae374 c01ae374 c01ae7a4 c01ae7a4 c0323cb6 c0323cb6 c039600c c039600c 00000000 00000000 c03a0400 c03a0400
 

7e40: 7e40: c039600c c039600c 00000000 00000000 00000000 00000000 00000000 00000000 c7817e84 c7817e84 c7817e60 c7817e60 c01aec78 c01aec78 c01ae2d8 c01ae2d8
 

7e60: 7e60: c03a0400 c03a0400 c0395fec c0395fec 00000000 00000000 00000000 00000000 00000000 00000000 c001cdbc c001cdbc c7817e94 c7817e94 c7817e88 c7817e88
 

7e80: 7e80: c01afae8 c01afae8 c01aebec c01aebec c7817eac c7817eac c7817e98 c7817e98 c01afb1c c01afb1c c01afa7c c01afa7c c03a0400 c03a0400 c0024a40 c0024a40
 

7ea0: 7ea0: c7817ebc c7817ebc c7817eb0 c7817eb0 c001cdd4 c001cdd4 c01afb10 c01afb10 c7817fdc c7817fdc c7817ec0 c7817ec0 c002c2d0 c002c2d0 c001cdc8 c001cdc8
 

7ec0: 7ec0: c78035a0 c78035a0 c78035a4 c78035a4 00000000 00000000 0000024e 0000024e c7817f34 c7817f34 c7817ee0 c7817ee0 c016e510 c016e510 c00998b8 c00998b8
 

7ee0: 7ee0: 00000000 00000000 c7817f54 c7817f54 000000d0 000000d0 c7811f28 c7811f28 00000000 00000000 c03aa7c4 c03aa7c4 000000d0 000000d0 c03a9324 c03a9324
 

7f00: 7f00: c7817f2c c7817f2c c7817f10 c7817f10 c016e724 c016e724 c783c0a0 c783c0a0 c038598c c038598c c783d6e0 c783d6e0 c03a9324 c03a9324 00000000 00000000
 

7f20: 7f20: 00000000 00000000 00000000 00000000 c7817f44 c7817f44 c7817f38 c7817f38 c016e544 c016e544 c016e37c c016e37c c7817f74 c7817f74 c7817f48 c7817f48
 

7f40: 7f40: c00da584 c00da584 c016e538 c016e538 c783d6e0 c783d6e0 c03275f9 c03275f9 c7817f9e c7817f9e 0000024e 0000024e c783c0a0 c783c0a0 c038598c c038598c
 

7f60: 7f60: 0000015f 0000015f c03a9324 c03a9324 c7817f94 c7817f94 c7817f78 c7817f78 c00da700 c00da700 c00da558 c00da558 c7817f94 c7817f94 c783d6e0 c783d6e0
 

7f80: 7f80: c00da8e8 c00da8e8 c7817f9e c7817f9e c7817fc4 c7817fc4 c7817f98 c7817f98 c0077e98 c0077e98 c00da778 c00da778 c7817fb4 c7817fb4 35337558 35337558
 
7fa0: 7fa0: 00000031 00000031 00000000 00000000 00000192 00000192 c0386580 c0386580 00000000 00000000 c0024cd4 c0024cd4 c0024a40 c0024a40 00000000 00000000
 
7fc0: 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c7817ff4 c7817ff4 c7817fe0 c7817fe0 c00088b8 c00088b8 c002c27c c002c27c
 
7fe0: 7fe0: 00000000 00000000 00000000 00000000 00000000 00000000 c7817ff8 c7817ff8 c00537c4 c00537c4 c0008854 c0008854 ffff0000 ffff0000 ffff0000 ffff0000


Backtrace: Backtrace:

[<c01d15fc>] [<c01d15fc>] (cfi_qry_present+0x0/0x29c) (cfi_qry_present+0x0/0x29c) from [<c01d1a60>] from [<c01d1a60>] (cfi_qry_mode_on+0x1c8/0x614)
(cfi_qry_mode_on+0x1c8/0x614)
[<c01d1898>] [<c01d1898>] (cfi_qry_mode_on+0x0/0x614) (cfi_qry_mode_on+0x0/0x614) from [<c01d0dbc>] from [<c01d0dbc>] (cfi_probe_chip+0x68/0x8a8)
(cfi_probe_chip+0x68/0x8a8)
[<c01d0d54>] [<c01d0d54>] (cfi_probe_chip+0x0/0x8a8) (cfi_probe_chip+0x0/0x8a8) from [<c01d76ec>] from [<c01d76ec>] (mtd_do_chip_probe+0x74/0x334)
(mtd_do_chip_probe+0x74/0x334)
[<c01d7678>] [<c01d7678>] (mtd_do_chip_probe+0x0/0x334) (mtd_do_chip_probe+0x0/0x334) from [<c01d0d4c>] from [<c01d0d4c>] (cfi_probe+0x14/0x1c)
(cfi_probe+0x14/0x1c)
[<c01d0d38>] [<c01d0d38>] (cfi_probe+0x0/0x1c) (cfi_probe+0x0/0x1c) from [<c01d0d18>] from [<c01d0d18>] (do_map_probe+0x50/0x70)
(do_map_probe+0x50/0x70)
[<c01d0cc8>] [<c01d0cc8>] (do_map_probe+0x0/0x70) (do_map_probe+0x0/0x70) from [<c001ceac>] from [<c001ceac>] (omapflash_probe+0xcc/0x184)
(omapflash_probe+0xcc/0x184)
 r7:c037d188 r7:c037d188 r6:04000000 r6:04000000 r5:04000000 r5:04000000 r4:c79e9960 r4:c79e9960
 [<c001cde0>] [<c001cde0>] (omapflash_probe+0x0/0x184) (omapflash_probe+0x0/0x184) from [<c01af750>] from [<c01af750>] (platform_drv_probe+0x20/0x24)
(platform_drv_probe+0x20/0x24)
[<c01af730>] [<c01af730>] (platform_drv_probe+0x0/0x24) (platform_drv_probe+0x0/0x24) from [<c01ae970>] from [<c01ae970>] (driver_probe_device+0xd0/0x17c)
(driver_probe_device+0xd0/0x17c)
[<c01ae8a0>] [<c01ae8a0>] (driver_probe_device+0x0/0x17c) (driver_probe_device+0x0/0x17c) from [<c01aea84>] from [<c01aea84>] (__driver_attach+0x68/0x8c)
(__driver_attach+0x68/0x8c)
 r7:c039600c r7:c039600c r6:c039600c r6:c039600c r5:c037d25c r5:c037d25c r4:c037d1b0 r4:c037d1b0
 
[<c01aea1c>] [<c01aea1c>] (__driver_attach+0x0/0x8c) (__driver_attach+0x0/0x8c) from [<c01adeec>] from [<c01adeec>] (bus_for_each_dev+0x4c/0x84)
(bus_for_each_dev+0x4c/0x84)
 r7:c039600c r7:c039600c r6:c01aea1c r6:c01aea1c r5:c7817df8 r5:c7817df8 r4:00000000 r4:00000000
 
[<c01adea0>] [<c01adea0>] (bus_for_each_dev+0x0/0x84) (bus_for_each_dev+0x0/0x84) from [<c01ae7b8>] from [<c01ae7b8>] (driver_attach+0x20/0x28)
(driver_attach+0x20/0x28)
 r7:c78c6ea0 r7:c78c6ea0 r6:00000000 r6:00000000 r5:c039600c r5:c039600c r4:00000000 r4:00000000
 
[<c01ae798>] [<c01ae798>] (driver_attach+0x0/0x28) (driver_attach+0x0/0x28) from [<c01ae374>] from [<c01ae374>] (bus_add_driver+0xa8/0x214)
(bus_add_driver+0xa8/0x214)
[<c01ae2cc>] [<c01ae2cc>] (bus_add_driver+0x0/0x214) (bus_add_driver+0x0/0x214) from [<c01aec78>] from [<c01aec78>] (driver_register+0x98/0x120)
(driver_register+0x98/0x120)
 r8:00000000 r8:00000000 r7:00000000 r7:00000000 r6:00000000 r6:00000000 r5:c039600c r5:c039600c r4:c03a0400 r4:c03a0400
 

[<c01aebe0>] [<c01aebe0>] (driver_register+0x0/0x120) (driver_register+0x0/0x120) from [<c01afae8>] from [<c01afae8>] (platform_driver_register+0x78/0x94)

(platform_driver_register+0x78/0x94)

[<c01afa70>] [<c01afa70>] (platform_driver_register+0x0/0x94) (platform_driver_register+0x0/0x94) from [<c01afb1c>] from [<c01afb1c>] (platform_driver_probe+0x18/0x68)
(platform_driver_probe+0x18/0x68)
[<c01afb04>] [<c01afb04>] (platform_driver_probe+0x0/0x68) (platform_driver_probe+0x0/0x68) from [<c001cdd4>] from [<c001cdd4>] (omapflash_init+0x18/0x24)
(omapflash_init+0x18/0x24)
 r5:c0024a40 r5:c0024a40 r4:c03a0400 r4:c03a0400
 
[<c001cdbc>] [<c001cdbc>] (omapflash_init+0x0/0x24) (omapflash_init+0x0/0x24) from [<c002c2d0>] from [<c002c2d0>] (do_one_initcall+0x60/0x18c)
(do_one_initcall+0x60/0x18c)
[<c002c270>] [<c002c270>] (do_one_initcall+0x0/0x18c) (do_one_initcall+0x0/0x18c) from [<c00088b8>] from [<c00088b8>] (kernel_init+0x70/0xdc)
(kernel_init+0x70/0xdc)
[<c0008848>] [<c0008848>] (kernel_init+0x0/0xdc) (kernel_init+0x0/0xdc) from [<c00537c4>] from [<c00537c4>] (do_exit+0x0/0x6c0)
(do_exit+0x0/0x6c0)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000
 
Code: Code: 0a000003 0a000003 e3550002 e3550002 1a000003 1a000003 e596300c e596300c (e19230b3) (e19230b3)
 
<4>---[ end trace f636687e6ec0770f ]---
---[ end trace f636687e6ec0770f ]---
<0>Kernel panic - not syncing: Attempted to kill init!
Kernel panic - not syncing: Attempted to kill init!

 

 

Is anybody experiencing the same issue?

 

Regards,

Sergio
