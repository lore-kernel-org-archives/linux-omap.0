From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: LDP broken in 2.6.30-rc 2
Date: Tue, 21 Apr 2009 06:22:46 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EAADB6A1@dbde02.ent.ti.com>
References: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbZDUAxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 20:53:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3L0qtux001621
	for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 19:53:01 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3L0qsTh000358
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 06:22:54 +0530 (IST)
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Christensen, Mikkel" <mlc@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Christensen, Mikkel
>Sent: Monday, April 20, 2009 3:28 PM
>To: linux-omap@vger.kernel.org
>Subject: LDP broken in 2.6.30-rc 2
>
>Hi,
>
>
>I cloned master a few days ago and when I boot up the OMAP3 LDP, the board seem to hang in the "i2c
>/dev entries driver" dialog and after a minute the kernel dumps. Have anybody else seen this problem?
>
>Log is below.
>
>Best regards,
> Mikkel

Here is the crash log after enabling all kernel debugging options on LDP with master of L-O tree.
Code base: linux-omap master
Platform: LDP
Defconfig: enabled debugging options


[   97.854797] i2c /dev entries driver
<1>Unable to handle kernel NULL pointer dereference at virtual address 0000009b
[  113.881439] Unable to handle kernel NULL pointer dereference at virtual addre
ss 0000009b
<1>pgd = c0004000
[  113.891387] pgd = c0004000
<1>[0000009b] *pgd=00000000[  113.896545] [0000009b] *pgd=00000000

Internal error: Oops: 5 [#1]
[  113.903076] Internal error: Oops: 5 [#1]
Modules linked in:[  113.908630] Modules linked in:

CPU: 0    Not tainted  (2.6.30-rc2-omap1-05650-gdc1ac9c-dirty #5)
[  113.917877] CPU: 0    Not tainted  (2.6.30-rc2-omap1-05650-gdc1ac9c-dirty #5)
PC is at device_add+0x2d8/0x630
[  113.928039] PC is at device_add+0x2d8/0x630
LR is at __mutex_unlock_slowpath+0x70/0x10c
[  113.936279] LR is at __mutex_unlock_slowpath+0x70/0x10c
pc : [<c01bdf58>]    lr : [<c02ba844>]    psr: 20000013
sp : c7817e80  ip : c78b8674  fp : 00000000
[  113.950653] pc : [<c01bdf58>]    lr : [<c02ba844>]    psr: 20000013
[  113.950653] sp : c7817e80  ip : c78b8674  fp : 00000000
r10: 00000000  r9 : c7840928  r8 : c7841a60
[  113.966217] r10: 00000000  r9 : c7840928  r8 : c7841a60
r7 : c03b8d04  r6 : c7802be0  r5 : c7840920  r4 : 00000000
[  113.976837] r7 : c03b8d04  r6 : c7802be0  r5 : c7840920  r4 : 00000000
r3 : 00000007  r2 : c7840aa8  r1 : 00000007  r0 : c7840aa8
[  113.988739] r3 : 00000007  r2 : c7840aa8  r1 : 00000007  r0 : c7840aa8
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[  114.001464] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kern
el
Control: 10c5387d  Table: 80004019  DAC: 00000017
[  114.013366] Control: 10c5387d  Table: 80004019  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc78162e0)
[  114.023803] Process swapper (pid: 1, stack limit = 0xc78162e0)
Stack: (0xc7817e80 to 0xc7818000)
[  114.032806] Stack: (0xc7817e80 to 0xc7818000)
7e80: [  114.037719] 7e80: 00000000 00000000 c785e090 c785e090 3a393800 3a393800
 c7840033 c7840033 00000021 00000021 00000000 00000000 00000000 00000000 c784092
0 c7840920

7ea0: [  114.053222] 7ea0: c7841a60 c7841a60 05900003 05900003 c785e090 c785e090
 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c01be36
4 c01be364

7ec0: [  114.068756] 7ec0: c03570f4 c03570f4 c78513c0 c78513c0 c03c86dc c03c86dc
 c785e038 c785e038 c03e1dc0 c03e1dc0 c01be394 c01be394 c03570f4 c03570f4 c7817ef
4 c7817ef4

7ee0: [  114.084259] 7ee0: c03c86f8 c03c86f8 c7817ef4 c7817ef4 c01ca380 c01ca380
 c01c9918 c01c9918 c03570f4 c03570f4 00000003 00000003 c03c86f8 c03c86f8 c785e03
8 c785e038

7f00: [  114.099792] 7f00: c03c86f8 c03c86f8 c01c9330 c01c9330 c01ca380 c01ca380
 c01c9358 c01c9358 00000000 00000000 c7817f2c c7817f2c c03c86f8 c03c86f8 c01c0af
4 c01c0af4

7f20: [  114.115295] 7f20: c03c8584 c03c8584 c03c85c0 c03c85c0 c03c8584 c03c8584
 c784b6b0 c784b6b0 c785e114 c785e114 00000000 00000000 00000000 00000000 c03c86f
8 c03c86f8

7f40: [  114.130828] 7f40: c03c8584 c03c8584 00000000 00000000 00000000 00000000
 c01c8b0c c01c8b0c c03e1dc0 c03e1dc0 00000000 00000000 c03d0760 c03d0760 c01ca41
0 c01ca410

7f60: [  114.146331] 7f60: c002391c c002391c c00239ec c00239ec c03d0760 c03d0760
 c002e2dc c002e2dc 00000000 00000000 c00e9338 c00e9338 c03d880c c03d880c c033ee2
4 c033ee24

7f80: [  114.161865] 7f80: 00000100 00000100 0000024e 0000024e c78370a0 c78370a0
 c03d880c c03d880c c03b6908 c03b6908 0000015f 0000015f 00000000 00000000 c00e958
8 c00e9588

7fa0: [  114.177368] 7fa0: c007e594 c007e594 c7838680 c7838680 c7817fb6 c7817fb6
 c007e5b8 c007e5b8 c7810f60 c7810f60 353339ec 353339ec 00000031 00000031 0000000
0 00000000

7fc0: [  114.192901] 7fc0: 00000000 00000000 c002391c c002391c c00239ec c00239ec
 c002366c c002366c 00000000 00000000 00000000 00000000 00000000 00000000 0000000
0 00000000

7fe0: [  114.208404] 7fe0: 00000000 00000000 c0008554 c0008554 00000000 00000000
 00000000 00000000 00000000 00000000 c005795c c005795c 107fff11 107fff11 00fbff2
0 00fbff20

[<c01bdf58>] [  114.224578] [<c01bdf58>] (device_add+0x2d8/0x630) (device_add+0x
2d8/0x630) from [<c01be364>] from [<c01be364>] (device_create_vargs+0x9c/0xac)
(device_create_vargs+0x9c/0xac)
[<c01be364>] [  114.241668] [<c01be364>] (device_create_vargs+0x9c/0xac) (device
_create_vargs+0x9c/0xac) from [<c01be394>] from [<c01be394>] (device_create+0x20
/0x28)
(device_create+0x20/0x28)
[<c01be394>] [  114.258941] [<c01be394>] (device_create+0x20/0x28) (device_creat
e+0x20/0x28) from [<c01c9918>] from [<c01c9918>] (i2cdev_attach_adapter+0xa0/0x1
1c)
(i2cdev_attach_adapter+0xa0/0x11c)
[<c01c9918>] [  114.276763] [<c01c9918>] (i2cdev_attach_adapter+0xa0/0x11c) (i2c
dev_attach_adapter+0xa0/0x11c) from [<c01c9358>] from [<c01c9358>] (__attach_ada
pter+0x28/0x30)
(__attach_adapter+0x28/0x30)
[<c01c9358>] [  114.295074] [<c01c9358>] (__attach_adapter+0x28/0x30) (__attach_
adapter+0x28/0x30) from [<c01c0af4>] from [<c01c0af4>] (class_for_each_device+0x
64/0xb8)
(class_for_each_device+0x64/0xb8)
[<c01c0af4>] [  114.313232] [<c01c0af4>] (class_for_each_device+0x64/0xb8) (clas
s_for_each_device+0x64/0xb8) from [<c01c8b0c>] from [<c01c8b0c>] (i2c_register_d
river+0xb8/0xdc)
(i2c_register_driver+0xb8/0xdc)
[<c01c8b0c>] [  114.331909] [<c01c8b0c>] (i2c_register_driver+0xb8/0xdc) (i2c_re
gister_driver+0xb8/0xdc) from [<c01ca410>] from [<c01ca410>] (i2c_dev_init+0x90/
0xa8)
(i2c_dev_init+0x90/0xa8)
[<c01ca410>] [  114.348968] [<c01ca410>] (i2c_dev_init+0x90/0xa8) (i2c_dev_init+
0x90/0xa8) from [<c002e2dc>] from [<c002e2dc>] (do_one_initcall+0x34/0x1a8)
(do_one_initcall+0x34/0x1a8)
[<c002e2dc>] [  114.365539] [<c002e2dc>] (do_one_initcall+0x34/0x1a8) (do_one_in
itcall+0x34/0x1a8) from [<c0008554>] from [<c0008554>] (kernel_init+0x9c/0xf8)
(kernel_init+0x9c/0xf8)
[<c0008554>] [  114.381927] [<c0008554>] (kernel_init+0x9c/0xf8) (kernel_init+0x
9c/0xf8) from [<c005795c>] from [<c005795c>] (do_exit+0x0/0x5ec)
(do_exit+0x0/0x5ec)
[<c005795c>] [  114.396728] [<c005795c>] (do_exit+0x0/0x5ec) (do_exit+0x0/0x5ec)
 from [<00000003>] from [<00000003>] (0x3)
(0x3)
Code: [  114.407714] Code: e5913000 e5913000 e3530000 e3530000 0a000003 0a000003
 e1a01003 e1a01003 (e5913094) (e5913094)

<4>---[ end trace 452756dfc4a6fe7e ]---
[  114.422058] ---[ end trace 452756dfc4a6fe7e ]---
<0>Kernel panic - not syncing: Attempted to kill init!
[  114.431823] Kernel panic - not syncing: Attempted to kill init!



>
>
>
>Bytes transferred = 1851164 (1c3f1c hex)
>
>## Booting image at 80000000 ...
>
>   Image Name:   Linux-2.6.30-rc2-omap1-05648-g8e
>
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>
>   Data Size:    1851100 Bytes =  1.8 MB
>
>   Load Address: 80008000
>
>   Entry Point:  80008000
>
>   Verifying Checksum ... OK
>
>OK
>
>
>
>Starting kernel ...
>
>
>
>Uncompressing
>Linux................................................................................................
>...........
>
><5>Linux version 2.6.30-rc2-omap1-05648-g8e58316-dirty (a0389005@a0389005-desktop) (gcc version 4.2.3
>(Sourcery G++ Lite 20089
>
>CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
>
>CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>
>Machine: OMAP LDP board
>
>Memory policy: ECC disabled, Data cache writeback
>
><7>On node 0 totalpages: 28672
>
><7>free_area_init_node: node 0, pgdat c0391ac8, node_mem_map c03ad000
>
><7>  Normal zone: 224 pages used for memmap
>
><7>  Normal zone: 0 pages reserved
>
><7>  Normal zone: 28448 pages, LIFO batch:7
>
><6>OMAP3430 ES2.1
>
><6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
>
>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 28448
>
><5>Kernel command line: console=ttyS2,115200n8 noinitrd mem=112M root=/dev/nfs rw
>nfsroot=128.247.85.60:/home/a0389051/omap34p
>
><6>NR_IRQS:402
>
><6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
>
><6>GPMC revision 5.0
>
><6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
>
><6>Total of 96 interrupts on 1 active controller
>
><6>OMAP34xx GPIO hardware version 2.5
>
>PID hash table entries: 512 (order: 9, 2048 bytes)
>
><6>OMAP clockevent source: GPTIMER1 at 32768 Hz
>
>Console: colour dummy device 80x30
>
><6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>
><6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>
><6>Memory: 112MB = 112MB total
>
><5>Memory: 109780KB available (3176K code, 292K data, 144K init, 0K highmem)
>
><6>Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
>
>Mount-cache hash table entries: 512
>
><6>CPU: Testing write buffer coherency: ok
>
><6>net_namespace: 520 bytes
>
><6>regulator: core version 0.5
>
><6>NET: Registered protocol family 16
>
><3>mmci-omap-hs.0: use which platform_data?
>
><6>OMAP DMA hardware revision 4.0
>
>bio: create slab <bio-0> at 0
>
><6>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
>
><6>twl4030: PIH (irq 7) chaining IRQs 368..375
>
><6>twl4030: power (irq 373) chaining IRQs 376..383
>
><3>twl4030_bci: use which platform_data?
>
><3>twl4030_gpio: use which platform_data?
>
><6>twl4030: gpio (irq 368) chaining IRQs 384..401
>
><3>twl4030_keypad: use which platform_data?
>
><3>twl4030_madc: use which platform_data?
>
><3>twl4030_usb: use which platform_data?
>
><3>twl4030_reg.17: use which platform_data?
>
><3>set_machine_constraints: invalid 'VUSB1V5' voltage constraints
>
><3>twl4030_reg twl4030_reg.17: can't register VUSB1V5, -22
>
><4>twl4030_reg: probe of twl4030_reg.17 failed with error -22
>
><3>twl4030_reg.18: use which platform_data?
>
><3>set_machine_constraints: invalid 'VUSB1V8' voltage constraints
>
><3>twl4030_reg twl4030_reg.18: can't register VUSB1V8, -22
>
><4>twl4030_reg: probe of twl4030_reg.18 failed with error -22
>
><3>twl4030_reg.19: use which platform_data?
>
><3>set_machine_constraints: invalid 'VUSB3V1' voltage constraints
>
><3>twl4030_reg twl4030_reg.19: can't register VUSB3V1, -22
>
><4>twl4030_reg: probe of twl4030_reg.19 failed with error -22
>
><6>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
>
><6>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
>
><5>SCSI subsystem initialized
>
><3>twl4030_usb twl4030_usb: ldo init failed
>
><6>usbcore: registered new interface driver usbfs
>
><6>usbcore: registered new interface driver hub
>
><6>usbcore: registered new device driver usb
>
><6>musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
>
><7>Switched to high resolution mode on CPU 0
>
><7>musb_hdrc: ConfigData=0x55 (UTMI-16, dyn FIFOs, bulk split (X), HB-ISO Rx (X))
>
><7>musb_hdrc: MHDRC RTL version 1.400
>
><7>musb_hdrc: setup fifo_mode 4
>
><7>musb_hdrc: 29/31 max ep, 15424/16384 memory
>
><7>musb_hdrc: hw_ep 0shared, max 64
>
><7>musb_hdrc: hw_ep 1tx, max 512
>
><7>musb_hdrc: hw_ep 1rx, max 512
>
><7>musb_hdrc: hw_ep 2tx, max 512
>
><7>musb_hdrc: hw_ep 2rx, max 512
>
><7>musb_hdrc: hw_ep 3tx, max 512
>
><7>musb_hdrc: hw_ep 3rx, max 512
>
><7>musb_hdrc: hw_ep 4tx, max 512
>
><7>musb_hdrc: hw_ep 4rx, max 512
>
><7>musb_hdrc: hw_ep 5tx, max 512
>
><7>musb_hdrc: hw_ep 5rx, max 512
>
><7>musb_hdrc: hw_ep 6tx, max 512
>
><7>musb_hdrc: hw_ep 6rx, max 512
>
><7>musb_hdrc: hw_ep 7tx, max 512
>
><7>musb_hdrc: hw_ep 7rx, max 512
>
><7>musb_hdrc: hw_ep 8tx, max 512
>
><7>musb_hdrc: hw_ep 8rx, max 512
>
><7>musb_hdrc: hw_ep 9tx, max 512
>
><7>musb_hdrc: hw_ep 9rx, max 512
>
><7>musb_hdrc: hw_ep 10tx, max 512
>
><7>musb_hdrc: hw_ep 10rx, max 512
>
><7>musb_hdrc: hw_ep 11tx, max 512
>
><7>musb_hdrc: hw_ep 11rx, max 512
>
><7>musb_hdrc: hw_ep 12tx, max 512
>
><7>musb_hdrc: hw_ep 12rx, max 512
>
><7>musb_hdrc: hw_ep 13tx, max 512
>
><7>musb_hdrc: hw_ep 13rx, max 512
>
><7>musb_hdrc: hw_ep 14shared, max 1024
>
><7>musb_hdrc: hw_ep 15shared, max 1024
>
><6>musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
>
><6>NET: Registered protocol family 2
>
><6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>
><6>TCP established hash table entries: 4096 (order: 3, 32768 bytes)
>
><6>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
>
><6>TCP: Hash tables configured (established 4096 bind 4096)
>
><6>TCP reno registered
>
><6>NET: Registered protocol family 1
>
><4>NetWinder Floating Point Emulator V0.97 (double precision)
>
><5>VFS: Disk quotas dquot_6.5.2
>
>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>
><6>msgmni has been set to 214
>
><6>alg: No test for stdrng (krng)
>
><6>io scheduler noop registered
>
><6>io scheduler anticipatory registered (default)
>
><6>io scheduler deadline registered
>
><6>io scheduler cfq registered
>
><6>omapfb: configured for panel ldp
>
><6>omapfb: DISPC version 3.0 initialized
>
>Console: switching to colour frame buffer device 60x40
>
><6>omapfb: Framebuffer initialized. Total vram 614400 planes 1
>
><6>omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
>
><6>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>
><6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>
><6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
>
><6>serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
>
><6>console [ttyS2] enabled
>
>Linux version 2.6.30-rc2-omap1-05648-g8e58316-dirty (a0389005@a0389005-desktop) (gcc version 4.2.3
>(Sourcery G++ Lite 2008q1-9
>
>CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
>
>CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>
>Machine: OMAP LDP board
>
>Memory policy: ECC disabled, Data cache writeback
>
>OMAP3430 ES2.1
>
>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
>
>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 28448
>
>Kernel command line: console=ttyS2,115200n8 noinitrd mem=112M root=/dev/nfs rw
>nfsroot=128.247.85.60:/home/a0389051/omap3430/p
>
>NR_IRQS:402
>
>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
>
>GPMC revision 5.0
>
>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
>
>Total of 96 interrupts on 1 active controller
>
>OMAP34xx GPIO hardware version 2.5
>
>PID hash table entries: 512 (order: 9, 2048 bytes)
>
>OMAP clockevent source: GPTIMER1 at 32768 Hz
>
>Console: colour dummy device 80x30
>
>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>
>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>
>Memory: 112MB = 112MB total
>
>Memory: 109780KB available (3176K code, 292K data, 144K init, 0K highmem)
>
>Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
>
>Mount-cache hash table entries: 512
>
>CPU: Testing write buffer coherency: ok
>
>net_namespace: 520 bytes
>
>regulator: core version 0.5
>
>NET: Registered protocol family 16
>
>mmci-omap-hs.0: use which platform_data?
>
>OMAP DMA hardware revision 4.0
>
>bio: create slab <bio-0> at 0
>
>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
>
>twl4030: PIH (irq 7) chaining IRQs 368..375
>
>twl4030: power (irq 373) chaining IRQs 376..383
>
>twl4030_bci: use which platform_data?
>
>twl4030_gpio: use which platform_data?
>
>twl4030: gpio (irq 368) chaining IRQs 384..401
>
>twl4030_keypad: use which platform_data?
>
>twl4030_madc: use which platform_data?
>
>twl4030_usb: use which platform_data?
>
>twl4030_reg.17: use which platform_data?
>
>set_machine_constraints: invalid 'VUSB1V5' voltage constraints
>
>twl4030_reg twl4030_reg.17: can't register VUSB1V5, -22
>
>twl4030_reg: probe of twl4030_reg.17 failed with error -22
>
>twl4030_reg.18: use which platform_data?
>
>set_machine_constraints: invalid 'VUSB1V8' voltage constraints
>
>twl4030_reg twl4030_reg.18: can't register VUSB1V8, -22
>
>twl4030_reg: probe of twl4030_reg.18 failed with error -22
>
>twl4030_reg.19: use which platform_data?
>
>set_machine_constraints: invalid 'VUSB3V1' voltage constraints
>
>twl4030_reg twl4030_reg.19: can't register VUSB3V1, -22
>
>twl4030_reg: probe of twl4030_reg.19 failed with error -22
>
>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
>
>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
>
>SCSI subsystem initialized
>
>twl4030_usb twl4030_usb: ldo init failed
>
>usbcore: registered new interface driver usbfs
>
>usbcore: registered new interface driver hub
>
>usbcore: registered new device driver usb
>
>musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
>
>musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
>
>NET: Registered protocol family 2
>
>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>
>TCP established hash table entries: 4096 (order: 3, 32768 bytes)
>
>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
>
>TCP: Hash tables configured (established 4096 bind 4096)
>
>TCP reno registered
>
>NET: Registered protocol family 1
>
>NetWinder Floating Point Emulator V0.97 (double precision)
>
>VFS: Disk quotas dquot_6.5.2
>
>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>
>msgmni has been set to 214
>
>alg: No test for stdrng (krng)
>
>io scheduler noop registered
>
>io scheduler anticipatory registered (default)
>
>io scheduler deadline registered
>
>io scheduler cfq registered
>
>omapfb: configured for panel ldp
>
>omapfb: DISPC version 3.0 initialized
>
>Console: switching to colour frame buffer device 60x40
>
>omapfb: Framebuffer initialized. Total vram 614400 planes 1
>
>omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
>
>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>
>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
>
>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
>
>serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
>
>console [ttyS2] enabled
>
><6>brd: module loaded
>
>brd: module loaded
>
><6>loop: module loaded
>
>loop: module loaded
>
><6>i2c /dev entries driver
>
>i2c /dev entries driver
>
><4>swapper: page allocation failure. order:0, mode:0x20
>
>swapper: page allocation failure. order:0, mode:0x20
>
>[<c0032254>] [<c0032254>] (unwind_backtrace+0x0/0xe0) (unwind_backtrace+0x0/0xe0) from [<c007b324>]
>from [<c007b324>] (__allo)
>
>(__alloc_pages_internal+0x37c/0x394)
>
>[<c007b324>] [<c007b324>] (__alloc_pages_internal+0x37c/0x394) (__alloc_pages_internal+0x37c/0x394)
>from [<c009578c>] from [<)
>
>(cache_alloc_refill+0x268/0x500)
>
>[<c009578c>] [<c009578c>] (cache_alloc_refill+0x268/0x500) (cache_alloc_refill+0x268/0x500) from
>[<c0095b54>] from [<c0095b54)
>
>(kmem_cache_alloc+0x5c/0x94)
>
>[<c0095b54>] [<c0095b54>] (kmem_cache_alloc+0x5c/0x94) (kmem_cache_alloc+0x5c/0x94) from [<c005d454>]
>from [<c005d454>] (call)
>
>(call_usermodehelper_setup+0x20/0x78)
>
>[<c005d454>] [<c005d454>] (call_usermodehelper_setup+0x20/0x78) (call_usermodehelper_setup+0x20/0x78)
>from [<c0158ff4>] from )
>
>(kobject_uevent_env+0x304/0x384)
>
>[<c0158ff4>] [<c0158ff4>] (kobject_uevent_env+0x304/0x384) (kobject_uevent_env+0x304/0x384) from
>[<c0197270>] from [<c0197270)
>
>(device_add+0x4e4/0x540)
>
>[<c0197270>] [<c0197270>] (device_add+0x4e4/0x540) (device_add+0x4e4/0x540) from [<c0197358>] from
>[<c0197358>] (device_creat)
>
>(device_create_vargs+0x74/0xa4)
>
>[<c0197358>] [<c0197358>] (device_create_vargs+0x74/0xa4) (device_create_vargs+0x74/0xa4) from
>[<c01973a4>] from [<c01973a4>])
>
>(device_create+0x1c/0x24)
>
>[<c01973a4>] [<c01973a4>] (device_create+0x1c/0x24) (device_create+0x1c/0x24) from [<c01a22b4>] from
>[<c01a22b4>] (i2cdev_att)
>
>(i2cdev_attach_adapter+0x90/0xe8)
>
>[<c01a22b4>] [<c01a22b4>] (i2cdev_attach_adapter+0x90/0xe8) (i2cdev_attach_adapter+0x90/0xe8) from
>[<c01a0de8>] from [<c01a0d)
>
>(__attach_adapter+0x28/0x30)
>
>[<c01a0de8>] [<c01a0de8>] (__attach_adapter+0x28/0x30) (__attach_adapter+0x28/0x30) from [<c0199ae0>]
>from [<c0199ae0>] (clas)
>
>(class_for_each_device+0x70/0xac)
>
>[<c0199ae0>] [<c0199ae0>] (class_for_each_device+0x70/0xac) (class_for_each_device+0x70/0xac) from
>[<c01a0920>] from [<c01a09)
>
>(i2c_register_driver+0xb8/0xec)
>
>[<c01a0920>] [<c01a0920>] (i2c_register_driver+0xb8/0xec) (i2c_register_driver+0xb8/0xec) from
>[<c00180b4>] from [<c00180b4>])
>
>(i2c_dev_init+0x50/0xa0)
>
>[<c00180b4>] [<c00180b4>] (i2c_dev_init+0x50/0xa0) (i2c_dev_init+0x50/0xa0) from [<c002c280>] from
>[<c002c280>] (do_one_initc)
>
>(do_one_initcall+0x50/0x17c)
>
>[<c002c280>] [<c002c280>] (do_one_initcall+0x50/0x17c) (do_one_initcall+0x50/0x17c) from [<c0008834>]
>from [<c0008834>] (kern)
>
>(kernel_init+0x70/0xe0)
>
>[<c0008834>] [<c0008834>] (kernel_init+0x70/0xe0) (kernel_init+0x70/0xe0) from [<c0051e54>] from
>[<c0051e54>] (do_exit+0x0/0x)
>
>(do_exit+0x0/0x57c)
>
>[<c0051e54>] [<c0051e54>] (do_exit+0x0/0x57c) (do_exit+0x0/0x57c) from [<00000001>] from [<00000001>]
>(0x1)
>
>(0x1)
>
>Mem-info:
>
>Mem-info:
>
>Normal per-cpu:
>
>Normal per-cpu:
>
>CPU    0: hi:   42, btch:   7 usd:   6
>
>CPU    0: hi:   42, btch:   7 usd:   6
>
>Active_anon:0 active_file:0 inactive_anon:0
>
> inactive_file:0 unevictable:0 dirty:0 writeback:0 unstable:0
>
> free:125 slab:27112 mapped:0 pagetables:0 bounce:0
>
>Active_anon:0 active_file:0 inactive_anon:0
>
> inactive_file:0 unevictable:0 dirty:0 writeback:0 unstable:0
>
> free:125 slab:27112 mapped:0 pagetables:0 bounce:0
>
>Normal free:500kB min:1348kB low:1684kB high:2020kB active_anon:0kB inactive_anon:0kB active_file:0kB
>inactive_file:0kB unevio
>
>Normal free:500kB min:1348kB low:1684kB high:2020kB active_anon:0kB inactive_anon:0kB active_file:0kB
>inactive_file:0kB unevio
>
>lowmem_reserve[]:lowmem_reserve[]: 0 0 0 0
>
>
>
>Normal: Normal: 1*4kB 1*4kB 0*8kB 0*8kB 1*16kB 1*16kB 1*32kB 1*32kB 1*64kB 1*64kB 1*128kB 1*128kB
>1*256kB 1*256kB 0*512kB 0*5B
>
>= 500kB
>
>0 total pagecache pages
>
>0 total pagecache pages
>
>0 pages in swap cache
>
>0 pages in swap cache
>
>Swap cache stats: add 0, delete 0, find 0/0
>
>Swap cache stats: add 0, delete 0, find 0/0
>
>Free swap  = 0kB
>
>Free swap  = 0kB
>
>Total swap = 0kB
>
>Total swap = 0kB
>
>28672 pages of RAM
>
>28672 pages of RAM
>
>158 free pages
>
>158 free pages
>
>1341 reserved pages
>
>1341 reserved pages
>
>27112 slab pages
>
>27112 slab pages
>
>0 pages shared
>
>0 pages shared
>
>0 pages swap cached
>
>0 pages swap cached
>
><4>swapper: page allocation failure. order:0, mode:0x20
>
>swapper: page allocation failure. order:0, mode:0x20
>
>[<c0032254>] [<c0032254>] (unwind_backtrace+0x0/0xe0) (unwind_backtrace+0x0/0xe0) from [<c007b324>]
>from [<c007b324>] (__allo)
>
>(__alloc_pages_internal+0x37c/0x394)
>
>[<c007b324>] [<c007b324>] (__alloc_pages_internal+0x37c/0x394) (__alloc_pages_internal+0x37c/0x394)
>from [<c009578c>] from [<)
>
>(cache_alloc_refill+0x268/0x500)
>
>[<c009578c>] [<c009578c>] (cache_alloc_refill+0x268/0x500) (cache_alloc_refill+0x268/0x500) from
>[<c0095b54>] from [<c0095b54)
>
>(kmem_cache_alloc+0x5c/0x94)
>
>[<c0095b54>] [<c0095b54>] (kmem_cache_alloc+0x5c/0x94) (kmem_cache_alloc+0x5c/0x94) from [<c005d454>]
>from [<c005d454>] (call)
>
>(call_usermodehelper_setup+0x20/0x78)
>
>[<c005d454>] [<c005d454>] (call_usermodehelper_setup+0x20/0x78) (call_usermodehelper_setup+0x20/0x78)
>from [<c0158ff4>] from )
>
>(kobject_uevent_env+0x304/0x384)
>
>[<c0158ff4>] [<c0158ff4>] (kobject_uevent_env+0x304/0x384) (kobject_uevent_env+0x304/0x384) from
>[<c0197270>] from [<c0197270)
>
>(device_add+0x4e4/0x540)
>
>[<c0197270>] [<c0197270>] (device_add+0x4e4/0x540) (device_add+0x4e4/0x540) from [<c0197358>] from
>[<c0197358>] (device_creat)
>
>(device_create_vargs+0x74/0xa4)
>
>[<c0197358>] [<c0197358>] (device_create_vargs+0x74/0xa4) (device_create_vargs+0x74/0xa4) from
>[<c01973a4>] from [<c01973a4>])
>
>(device_create+0x1c/0x24)
>
>[<c01973a4>] [<c01973a4>] (device_create+0x1c/0x24) (device_create+0x1c/0x24) from [<c01a22b4>] from
>[<c01a22b4>] (i2cdev_att)
>
>(i2cdev_attach_adapter+0x90/0xe8)
>
>[<c01a22b4>] [<c01a22b4>] (i2cdev_attach_adapter+0x90/0xe8) (i2cdev_attach_adapter+0x90/0xe8) from
>[<c01a0de8>] from [<c01a0d)
>
>(__attach_adapter+0x28/0x30)
>
>[<c01a0de8>] [<c01a0de8>] (__attach_adapter+0x28/0x30) (__attach_adapter+0x28/0x30) from [<c0199ae0>]
>from [<c0199ae0>] (clas)
>
>(class_for_each_device+0x70/0xac)
>
>[<c0199ae0>] [<c0199ae0>] (class_for_each_device+0x70/0xac) (class_for_each_device+0x70/0xac) from
>[<c01a0920>] from [<c01a09)
>
>(i2c_register_driver+0xb8/0xec)
>
>[<c01a0920>] [<c01a0920>] (i2c_register_driver+0xb8/0xec) (i2c_register_driver+0xb8/0xec) from
>[<c00180b4>] from [<c00180b4>])
>
>(i2c_dev_init+0x50/0xa0)
>
>[<c00180b4>] [<c00180b4>] (i2c_dev_init+0x50/0xa0) (i2c_dev_init+0x50/0xa0) from [<c002c280>] from
>[<c002c280>] (do_one_initc)
>
>(do_one_initcall+0x50/0x17c)
>
>[<c002c280>] [<c002c280>] (do_one_initcall+0x50/0x17c) (do_one_initcall+0x50/0x17c) from [<c0008834>]
>from [<c0008834>] (kern)
>
>(kernel_init+0x70/0xe0)
>
>[<c0008834>] [<c0008834>] (kernel_init+0x70/0xe0) (kernel_init+0x70/0xe0) from [<c0051e54>] from
>[<c0051e54>] (do_exit+0x0/0x)
>
>(do_exit+0x0/0x57c)
>
>[<c0051e54>] [<c0051e54>] (do_exit+0x0/0x57c) (do_exit+0x0/0x57c) from [<00000001>] from [<00000001>]
>(0x1)
>
>(0x1)
>
>
>
>Best regards
>
>
>
>Mikkel L. Christensen M.Sc.E.E
>
>
>OMAP Modem Control and Adaptation - Linux
>
>--
>Wireless Terminals Software Development
>
>Texas Instruments Inc.
>
>Phone (+1)(214)567-5476
>
>Cell     (+1)(214)606-4710
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

