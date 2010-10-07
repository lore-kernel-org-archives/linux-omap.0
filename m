From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: linux-omap/master is not booting up on OMAP3EVM
Date: Thu, 7 Oct 2010 18:03:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D110@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58062 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760407Ab0JGMd1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 08:33:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o97CXOp3023006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Oct 2010 07:33:26 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o97CXNkC011319
	for <linux-omap@vger.kernel.org>; Thu, 7 Oct 2010 18:03:23 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Latest linux-omap/master branch is not booting up on OMAP3EVM board, I =
am using omap2plus_defcofnig without any changes.

I tried enableing early_printk option then found that it is hanging imm=
ediately after serial initialization, below is the log for reference -


----------------------LOG-----------------------------

Bytes transferred =3D 2683824 (28f3b0 hex)
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-2.6.36-rc7-08946-g99cf630
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2683760 Bytes =3D  2.6 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.36-rc7-08946-g99cf630 (a0393758@psplin=
ux051) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #9 SMP Thu O=
ct 7 17:13:42 IST 2010
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instr=
uction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x1000=
0
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0bc1000 s5984 r8192 d1449=
6 u65536
[    0.000000] pcpu-alloc: s5984 r8192 d14496 u65536 alloc=3D16*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32512
[    0.000000] Kernel command line: root=3D/dev/ram0 rw mem=3D128M cons=
ole=3DttyS0,115200n8 initrd=3D0x83600000,16M ip=3Ddhcp earlyprintk=3Dse=
rial
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 128MB =3D 128MB total
[    0.000000] Memory: 102524k/102524k available, 28548k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0047000   ( 252 kB)
[    0.000000]       .text : 0xc0047000 - 0xc04e2000   (4716 kB)
[    0.000000]       .data : 0xc0500000 - 0xc0565760   ( 406 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:402
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] GPMC revision 5.0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Could not get gpios_ick
[    0.000000] Could not get gpios_fck
[    0.000000] OMAP GPIO hardware version 2.5
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000000] Calibrating delay loop... 498.87 BogoMIPS (lpj=3D1945600=
)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Security Framework initialized
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] Brought up 1 CPUs
[    0.000000] SMP: Total of 1 processors activated (498.87 BogoMIPS).
[    0.000000] regulator: core version 0.5
[    0.000000] NET: Registered protocol family 16
[    0.000000] OMAP DMA hardware revision 4.0
[    0.052703] bio: create slab <bio-0> at 0
[    0.066741] SCSI subsystem initialized
[    0.083923] omap_device: i2c_omap.1: new worst case activate latency=
 0: 91552
[    0.101776] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
[    0.118988] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.124847] twl4030: power (irq 373) chaining IRQs 376..383
[    0.132843] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.154357] regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal st=
andby
[    0.164520] regulator: VDAC: 1800 mV normal standby
[    0.172851] regulator: VPLL2: 1800 mV normal standby
[    0.180755] regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal sta=
ndby
[    0.188446] omap_device: i2c_omap.1: new worst case deactivate laten=
cy 0: 30517
[    0.210754] i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
[    0.226409] i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
[    0.242767] Switching to clocksource 32k_counter
[    0.358764] NET: Registered protocol family 2
[    0.364349] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.374298] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.382080] TCP bind hash table entries: 4096 (order: 5, 131072 byte=
s)
[    0.391815] TCP: Hash tables configured (established 4096 bind 4096)
[    0.398620] TCP reno registered
[    0.401977] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.408447] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.416198] NET: Registered protocol family 1
[    0.422210] RPC: Registered udp transport module.
[    0.427154] RPC: Registered tcp transport module.
[    0.432342] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.440216] Trying to unpack rootfs image as initramfs...
[    0.447235] rootfs image is not initramfs (junk in compressed archiv=
e); looks like an initrd
[    0.697875] Freeing initrd memory: 16384K
[    0.707366] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.893859] VFS: Disk quotas dquot_6.5.2
[    0.898529] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.908569] JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red H=
at, Inc.
[    0.917541] msgmni has been set to 232
[    0.927093] io scheduler noop registered
[    0.931365] io scheduler deadline registered
[    0.936218] io scheduler cfq registered (default)
[    0.945587] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.960083] omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is =
a OMAP UART0
;  =AE=B6=B6V=3D=AF=B0=A1=B3
            2s14?=A04=AD=A5/0400=A8=C91=3D=B7=A0?=A0=B5!=A0
                                     2
                                      -=D5;  =AE7=A34=3D=AF=B0=A1=B3

<Serial console goes for toss and dumps garbage here after>


Does anybody has seen such issues; any suggestion/help is helpful?

Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
