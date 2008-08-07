From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check
	and repost
Date: Thu, 7 Aug 2008 13:57:26 +0300
Message-ID: <20080807105725.GJ27799@atomide.com>
References: <20080805143519.GS7193@atomide.com> <200808061630.09530.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50766 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYHGNeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 09:34:08 -0400
Content-Disposition: inline
In-Reply-To: <200808061630.09530.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080807 02:30]:
> On Tuesday 05 August 2008, Tony Lindgren wrote:
> > Also please check that things work for your board,
> > let's try to tag v2.6.26-omap1 within next few days so we can
> > move on again.
> 
> Two problems on the OSK5912:
> 
>  - cpufreq oopses on boot
>  - continuous i2c overflow errors
> 
> ISTR both of these bugs are in mainline too.  I'd say the
> I2C regression is higher priority.

Hmm, I wonder what has broken I2C?

Anyways, let's fix these regressions before tagging.

Tony


> 
> - Dave
> 
> 
> ================	CPUFREQ oopsing
> <5>Linux version 2.6.26-omap1 (db@blackbox) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-53)) #186 PREEMPT Wed Aug 6 16:12:29 PDT 2008
> CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
> Machine: TI-OSK
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 8192
> <7>  DMA zone: 64 pages used for memmap
> <7>  DMA zone: 0 pages reserved
> <7>  DMA zone: 8128 pages, LIFO batch:0
> <7>  Normal zone: 0 pages used for memmap
> <7>  Movable zone: 0 pages used for memmap
> OMAP1611b revision 2 handled as 16xx id: 26058c80eb051c15
> <6>SRAM: Mapped pa 0x20000000 to va 0xd7000000 size: 0x100000
> CPU0: D VIVT write-back cache
> CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
> CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
> <5>Kernel command line: console=ttyS0,115200 mem=32M ip=dhcp root=/dev/nfs i2c_omap.clock=400
> <3>Unknown boot option `i2c_omap.clock=400': ignoring
> Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
> <6>Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
> Total of 128 interrupts in 4 interrupt banks
> <6>OMAP GPIO hardware version 1.0
> <4>MUX: initialized M7_1610_GPIO62
> PID hash table entries: 128 (order: 7, 512 bytes)
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:    8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        2048
> ... CLASSHASH_SIZE:           1024
> ... MAX_LOCKDEP_ENTRIES:     8192
> ... MAX_LOCKDEP_CHAINS:      16384
> ... CHAINHASH_SIZE:          8192
>  memory used by lock dependency info: 992 kB
>  per task-struct memory footprint: 1920 bytes
> <6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> <6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> <6>Memory: 32MB = 32MB total
> <5>Memory: 26936KB available (2476K code, 2919K data, 104K init)
> <6>SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> <7>Calibrating delay loop... 94.82 BogoMIPS (lpj=474112)
> Mount-cache hash table entries: 512
> <6>CPU: Testing write buffer coherency: ok
> <6>net_namespace: 256 bytes
> <6>NET: Registered protocol family 16
> <4>MUX: initialized M19_1610_CAM_RSTZ
> <4>MUX: initialized Y15_1610_CAM_OUTCLK
> <4>MUX: initialized H19_1610_CAM_EXCLK
> <4>MUX: initialized W13_1610_CCP_CLKM
> <4>MUX: initialized Y12_1610_CCP_CLKP
> <4>MUX: initialized W14_1610_CCP_DATAP
> <4>MUX: initialized N20_1610_GPIO11
> <4>MUX: initialized P20_1610_GPIO4
> <4>MUX: initialized PWL
> <6>OMAP DMA hardware version 1
> <6>DMA capabilities: 000c0000:00000000:01ff:003f:007f
> <6>omap_dsp_init() done
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> <1>pgd = c0004000
> <1>[00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT
> Modules linked in:
> CPU: 0    Not tainted  (2.6.26-omap1 #186)
> PC is at wq_per_cpu+0xc/0x14
> LR is at queue_delayed_work_on+0x90/0x124
> pc : [<c005068c>]    lr : [<c00510f0>]    psr: 60000013
> sp : c1c21dbc  ip : c1c21dcc  fp : c1c21dc8
> r10: 00000292  r9 : 00000001  r8 : 00000000
> r7 : 00000000  r6 : c0561c20  r5 : 00000000  r4 : c0561c04
> r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0005317f  Table: 10004000  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xc1c20260)
> Stack: (0xc1c21dbc to 0xc1c22000)
> 1da0:                                                                c1c21df0 
> 1dc0: c1c21dcc c00510f0 c0050690 c0561be0 00000292 c02aa654 c0561be0 c1c38840 
> 1de0: 00000000 c1c21e1c c1c21df4 c0175358 c0051070 00000000 00000000 c1c38840 
> 1e00: 00000001 00000000 00000000 c001c818 c1c21e38 c1c21e20 c0172e00 c017514c 
> 1e20: c1c21e5c c1c38840 00000000 c1c21e58 c1c21e3c c0173454 c0172d30 c02980f0 
> 1e40: c1c38840 00000000 c0561ad0 c1c21f28 c1c21e5c c0174428 c0173348 00000001 
> 1e60: 00000000 00000000 00000000 0002ee00 00005dc0 00989680 0002ee00 0002ee00 
> 1e80: 0002ee00 00000000 c02aa654 00000000 c1c38874 c1c38874 c0173dd4 c0561bb0 
> 1ea0: 00000000 c02704f9 00005dc0 0002ee00 00000000 00000000 00000000 00000000 
> 1ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 1ee0: 00000001 dead4ead ffffffff ffffffff c02d1f40 00000000 c02592d4 c1c388e0 
> 1f00: c1c388e0 00000000 c02aa3d0 c02a7680 c02af8c0 c02af8c8 00000000 c1c21f54 
> 1f20: c1c21f2c c0137920 c0174204 c1c04098 00000000 c02af8c0 00000000 00000000 
> 1f40: c0009d28 c1c20000 c1c21f68 c1c21f58 c001c228 c01378a8 c001d000 c1c21f78 
> 1f60: c1c21f6c c0009d4c c001c20c c1c21ff4 c1c21f7c c0008930 c0009d38 00000000 
> 1f80: 00000000 00000000 00000000 c1c21f00 c1c21f9c c003bcbc c003a888 00000000 
> 1fa0: 00000000 c1c21fb0 c0022b84 c003bcac 00000000 00000000 c0008884 c00423c8 
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 1fe0: 00000000 00000000 00000000 c1c21ff8 c00423c8 c0008894 00000000 00000000 
> Backtrace: 
> [<c0050680>] (wq_per_cpu+0x0/0x14) from [<c00510f0>] (queue_delayed_work_on+0x90/0x124)
> [<c0051060>] (queue_delayed_work_on+0x0/0x124) from [<c0175358>] (cpufreq_governor_dbs+0x21c/0x30c)
> [<c017513c>] (cpufreq_governor_dbs+0x0/0x30c) from [<c0172e00>] (__cpufreq_governor+0xe0/0x124)
> [<c0172d20>] (__cpufreq_governor+0x0/0x124) from [<c0173454>] (__cpufreq_set_policy+0x11c/0x164)
>  r6:00000000 r5:c1c38840 r4:c1c21e5c
> [<c0173338>] (__cpufreq_set_policy+0x0/0x164) from [<c0174428>] (cpufreq_add_dev+0x234/0x304)
>  r7:c0561ad0 r6:00000000 r5:c1c38840 r4:c02980f0
> [<c01741f4>] (cpufreq_add_dev+0x0/0x304) from [<c0137920>] (sysdev_register+0x88/0xd0)
>  r8:00000000 r7:c02af8c8 r6:c02af8c0 r5:c02a7680 r4:c02aa3d0
> [<c0137898>] (sysdev_register+0x0/0xd0) from [<c001c228>] (register_cpu+0x2c/0x44)
>  r8:c1c20000 r7:c0009d28 r6:00000000 r5:00000000 r4:c02af8c0
> [<c001c1fc>] (register_cpu+0x0/0x44) from [<c0009d4c>] (topology_init+0x24/0x30)
>  r4:c001d000
> [<c0009d28>] (topology_init+0x0/0x30) from [<c0008930>] (kernel_init+0xac/0x250)
> [<c0008884>] (kernel_init+0x0/0x250) from [<c00423c8>] (do_exit+0x0/0x644)
> Code: c02d1bd8 e1a0c00d e92dd800 e24cb004 (e5900000) 
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <0>Kernel panic - not syncing: Attempted to kill init!
> 
> 
> 
> ========================	#2 i2c overflows (after disabling cpufreq)
> <5>Linux version 2.6.26-omap1 (db@blackbox) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-53)) #187 PREEMPT Wed Aug 6 16:20:02 PDT 2008
> CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
> Machine: TI-OSK
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 8192
> <7>  DMA zone: 64 pages used for memmap
> <7>  DMA zone: 0 pages reserved
> <7>  DMA zone: 8128 pages, LIFO batch:0
> <7>  Normal zone: 0 pages used for memmap
> <7>  Movable zone: 0 pages used for memmap
> OMAP1611b revision 2 handled as 16xx id: 26058c80eb051c15
> <6>SRAM: Mapped pa 0x20000000 to va 0xd7000000 size: 0x100000
> CPU0: D VIVT write-back cache
> CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
> CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
> <5>Kernel command line: console=ttyS0,115200 mem=32M ip=dhcp root=/dev/nfs i2c_omap.clock=400
> <3>Unknown boot option `i2c_omap.clock=400': ignoring
> Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
> <6>Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
> Total of 128 interrupts in 4 interrupt banks
> <6>OMAP GPIO hardware version 1.0
> <4>MUX: initialized M7_1610_GPIO62
> PID hash table entries: 128 (order: 7, 512 bytes)
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:    8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        2048
> ... CLASSHASH_SIZE:           1024
> ... MAX_LOCKDEP_ENTRIES:     8192
> ... MAX_LOCKDEP_CHAINS:      16384
> ... CHAINHASH_SIZE:          8192
>  memory used by lock dependency info: 992 kB
>  per task-struct memory footprint: 1920 bytes
> <6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> <6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> <6>Memory: 32MB = 32MB total
> <5>Memory: 26952KB available (2460K code, 2918K data, 104K init)
> <6>SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> <7>Calibrating delay loop... 95.02 BogoMIPS (lpj=475136)
> Mount-cache hash table entries: 512
> <6>CPU: Testing write buffer coherency: ok
> <6>net_namespace: 256 bytes
> <6>NET: Registered protocol family 16
> <4>MUX: initialized M19_1610_CAM_RSTZ
> <4>MUX: initialized Y15_1610_CAM_OUTCLK
> <4>MUX: initialized H19_1610_CAM_EXCLK
> <4>MUX: initialized W13_1610_CCP_CLKM
> <4>MUX: initialized Y12_1610_CCP_CLKP
> <4>MUX: initialized W14_1610_CCP_DATAP
> <4>MUX: initialized N20_1610_GPIO11
> <4>MUX: initialized P20_1610_GPIO4
> <4>MUX: initialized PWL
> <6>OMAP DMA hardware version 1
> <6>DMA capabilities: 000c0000:00000000:01ff:003f:007f
> <6>omap_dsp_init() done
> <4>MUX: initialized W4_USB_PUEN
> USB: hmc 0, usb2 alt 0 wires
> <6>i2c_omap i2c_omap.1: bus 1 rev2.2 at 400 kHz
> <6>tps65010: version 2 May 2005
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <6>tps65010: power off button
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>tps65010: Failed to write vdcdc1 register
> <3>i2c_omap i2c_omap.1: Transmit overflow
> <3>tps65010: Failed to write vregs1 register
> <5>SCSI subsystem initialized
> <7>Switched to high resolution mode on CPU 0
> <6>NET: Registered protocol family 2
> <6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> <6>TCP established hash table entries: 1024 (order: 1, 8192 bytes)
> <6>TCP bind hash table entries: 1024 (order: 3, 32768 bytes)
> <6>TCP: Hash tables configured (established 1024 bind 1024)
> <6>TCP reno registered
> <6>NET: Registered protocol family 1
> Power Management for TI OMAP.
> <4>MUX: initialized T20_1610_LOW_PWR
> 
> 	... etc
