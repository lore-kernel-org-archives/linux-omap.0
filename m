From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [pandaboard] device tree does not work
Date: Fri, 21 Dec 2012 16:42:42 +0000
Message-ID: <2822D1C2B9B19F4A8261F756A13373F8C5607D@DFLE12.ent.ti.com>
References: <CANkO5KMsia5GhZTdR6mFgnhf+84SK9CJHr9gjRAEMu2uHuSm8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab2LUQmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:42:44 -0500
In-Reply-To: <CANkO5KMsia5GhZTdR6mFgnhf+84SK9CJHr9gjRAEMu2uHuSm8Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ghorai.sukumar@gmail.com" <ghorai.sukumar@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Shifting thread to linux-omap mailing list.
Regards,
Nishanth Menon
________________________________________
From: pandaboard@googlegroups.com [pandaboard@googlegroups.com] on behalf of Sukumar Ghorai [ghorai.sukumar@gmail.com]
Sent: Friday, December 21, 2012 10:33
To: pandaboard@googlegroups.com
Subject: [pandaboard] device tree does not work

Hi,
Device Tree in Panda board does not boot.

Device Tree with legacy u-boot : Appending dtb blob to kernel
        menuconfig → boot options
        select [*] Use appended device tree blob to zImage (EXPERIMENTAL)
        Used with legacy u-boot

U-Boot 2011.09 (Nov 19 2011 - 04:44:45)

CPU  : OMAP4430
Board: OMAP4 Panda
I2C:   ready
DRAM:  1 GiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
Panda # setenv bootargs 'console=ttyO2,115200n8 root=/dev/mmcblk0p3 rw
rootwait rootfstype=ext4 init=/sbin/init ignore_loglevel debug
printk.time=1 earlyprintk'
Panda # setenv bootcmd 'mmc rescan; fatload mmc 0 80200000
uImage-21dec; fatload mmc 0 80700000 omap4-panda-es.dtb; bootm
80200000 - 80700000'
Panda # boot
reading uImage-21dec

4243816 bytes read
reading omap4-panda-es.dtb

13602 bytes read
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.7.0-11091-gf01af9f-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4243752 Bytes = 4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80700000
   Booting using the fdt blob at 0x80700000
   Loading Kernel Image ... OK
OK
   reserving fdt memory region: addr=9d000000 size=3000000
   Loading Device Tree to bfef1000, end bfef7521 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.7.0-11091-gf01af9f-dirty
(sghorai@bgsxgitb03) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202)
) #15 SMP Fri Dec 21 15:50:23 IST 2012
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model:
TI OMAP4 PandaBoard
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 261888
[    0.000000] free_area_init_node: node 0, pgdat c080eec0,
node_mem_map c0d6d000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 193040 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 66800 pages, LIFO batch:15
[    0.000000] Unable to handle kernel paging request at virtual
address ffef1000
[    0.000000] pgd = c0004000
[    0.000000] [ffef1000] *pgd=af7fe821, *pte=00000000, *ppte=00000000
[    0.000000] Internal error: Oops: 17 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.7.0-11091-gf01af9f-dirty #15)
[    0.000000] PC is at __unflatten_device_tree+0x1c/0x130
[    0.000000] LR is at unflatten_device_tree+0x1c/0x34
[    0.000000] pc : [<c04558ec>]    lr : [<c0755910>]    psr: a00001d3
[    0.000000] sp : c0781f50  ip : 00000001  fp : c0788954
[    0.000000] r10: c0666de0  r9 : c157c080  r8 : 80000200
[    0.000000] r7 : c0730f64  r6 : c078d3d0  r5 : ffef1000  r4 : c0730f64
[    0.000000] r3 : d00dfeed  r2 : c0730f64  r1 : c0d666e8  r0 : ffef1000
[    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[    0.000000] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc0780240)
[    0.000000] Stack: (0xc0781f50 to 0xc0782000)
[    0.000000] 1f40:                                     80000200
c157c080 c0d666e8 00000000
[    0.000000] 1f60: c0730f64 c0d50c68 c078d3d0 c07e2c60 80000200
c0755910 c075d548 c072fc94
[    0.000000] 1f80: 00000000 10c53c7d bfffffff c0781fdc 411fc092
00000000 00000000 c052f9b0
[    0.000000] 1fa0: c06655ac ffffffff 00000001 00000000 bfffffff
8000406a 411fc092 00000000
[    0.000000] 1fc0: 00000000 c072c4ec 00000000 00000000 00000000
00000000 00000000 c075f2b0
[    0.000000] 1fe0: 00000000 10c53c7d c078898c c075f2ac c078d1c4
80008078 00000000 00000000
[    0.000000] [<c04558ec>] (__unflatten_device_tree+0x1c/0x130) from
[<c0755910>] (unflatten_device_tree+0x1c/0x34)
[    0.000000] [<c0755910>] (unflatten_device_tree+0x1c/0x34) from
[<c072fc94>] (setup_arch+0x5d4/0x7ac)
[    0.000000] [<c072fc94>] (setup_arch+0x5d4/0x7ac) from [<c072c4ec>]
(start_kernel+0x88/0x2fc)
[    0.000000] [<c072c4ec>] (start_kernel+0x88/0x2fc) from
[<80008078>] (0x80008078)
[    0.000000] Code: e1a07002 0a000035 e59f30fc e58d1008 (e5951000)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
