From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: linux-omap/master is not booting up on OMAP3EVM
Date: Thu, 7 Oct 2010 14:47:03 +0200
Message-ID: <AANLkTi=xKZH8vDUuM90461xnQ2_FRi_33U2tN_JNT+vq@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E739404AA21D110@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33750 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0JGMrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 08:47:04 -0400
Received: by qwf7 with SMTP id 7so12416qwf.19
        for <linux-omap@vger.kernel.org>; Thu, 07 Oct 2010 05:47:03 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404AA21D110@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Oct 7, 2010 at 2:33 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wro=
te:
> Hi,
>
> Latest linux-omap/master branch is not booting up on OMAP3EVM board, =
I am using omap2plus_defcofnig without any changes.
>
> I tried enableing early_printk option then found that it is hanging i=
mmediately after serial initialization, below is the log for reference =
-
>
>
> ----------------------LOG-----------------------------
>
> Bytes transferred =3D 2683824 (28f3b0 hex)
> ## Booting kernel from Legacy Image at 82000000 ...
> =A0 Image Name: =A0 Linux-2.6.36-rc7-08946-g99cf630
> =A0 Image Type: =A0 ARM Linux Kernel Image (uncompressed)
> =A0 Data Size: =A0 =A02683760 Bytes =3D =A02.6 MB
> =A0 Load Address: 80008000
> =A0 Entry Point: =A080008000
> =A0 Verifying Checksum ... OK
> =A0 Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> [ =A0 =A00.000000] Linux version 2.6.36-rc7-08946-g99cf630 (a0393758@=
psplinux051) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #9 SMP=
 Thu Oct 7 17:13:42 IST 2010
> [ =A0 =A00.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7)=
, cr=3D10c53c7f
> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing=
 instruction cache
> [ =A0 =A00.000000] Machine: OMAP3 EVM
> [ =A0 =A00.000000] bootconsole [earlycon0] enabled
> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeback
> [ =A0 =A00.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
> [ =A0 =A00.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: =
0x10000
> [ =A0 =A00.000000] PERCPU: Embedded 7 pages/cpu @c0bc1000 s5984 r8192=
 d14496 u65536
> [ =A0 =A00.000000] pcpu-alloc: s5984 r8192 d14496 u65536 alloc=3D16*4=
096
> [ =A0 =A00.000000] pcpu-alloc: [0] 0
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping=
 on. =A0Total pages: 32512
> [ =A0 =A00.000000] Kernel command line: root=3D/dev/ram0 rw mem=3D128=
M console=3DttyS0,115200n8 initrd=3D0x83600000,16M ip=3Ddhcp earlyprint=
k=3Dserial
> [ =A0 =A00.000000] PID hash table entries: 512 (order: -1, 2048 bytes=
)
> [ =A0 =A00.000000] Dentry cache hash table entries: 16384 (order: 4, =
65536 bytes)
> [ =A0 =A00.000000] Inode-cache hash table entries: 8192 (order: 3, 32=
768 bytes)
> [ =A0 =A00.000000] Memory: 128MB =3D 128MB total
> [ =A0 =A00.000000] Memory: 102524k/102524k available, 28548k reserved=
, 0K highmem
> [ =A0 =A00.000000] Virtual kernel memory layout:
> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000 =A0 ( =
=A0 4 kB)
> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 ( =
896 kB)
> [ =A0 =A00.000000] =A0 =A0 DMA =A0 =A0 : 0xffc00000 - 0xffe00000 =A0 =
( =A0 2 MB)
> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xc8800000 - 0xf8000000 =A0 ( 76=
0 MB)
> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xc8000000 =A0 ( =
128 MB)
> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0 ( =A0=
16 MB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0008000 - 0xc0047000 =A0 ( =
252 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc0047000 - 0xc04e2000 =A0 (4=
716 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc0500000 - 0xc0565760 =A0 ( =
406 kB)
> [ =A0 =A00.000000] Hierarchical RCU implementation.
> [ =A0 =A00.000000] =A0RCU-based detection of stalled CPUs is disabled=
=2E
> [ =A0 =A00.000000] =A0Verbose stalled-CPUs detection is disabled.
> [ =A0 =A00.000000] NR_IRQS:402
> [ =A0 =A00.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
> [ =A0 =A00.000000] Reprogramming SDRC clock to 332000000 Hz
> [ =A0 =A00.000000] GPMC revision 5.0
> [ =A0 =A00.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) wi=
th 96 interrupts
> [ =A0 =A00.000000] Total of 96 interrupts on 1 active controller
> [ =A0 =A00.000000] Could not get gpios_ick
> [ =A0 =A00.000000] Could not get gpios_fck
> [ =A0 =A00.000000] OMAP GPIO hardware version 2.5
> [ =A0 =A00.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [ =A0 =A00.000000] Console: colour dummy device 80x30
> [ =A0 =A00.000000] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
> [ =A0 =A00.000000] ... MAX_LOCKDEP_SUBCLASSES: =A08
> [ =A0 =A00.000000] ... MAX_LOCK_DEPTH: =A0 =A0 =A0 =A0 =A048
> [ =A0 =A00.000000] ... MAX_LOCKDEP_KEYS: =A0 =A0 =A0 =A08191
> [ =A0 =A00.000000] ... CLASSHASH_SIZE: =A0 =A0 =A0 =A0 =A04096
> [ =A0 =A00.000000] ... MAX_LOCKDEP_ENTRIES: =A0 =A0 16384
> [ =A0 =A00.000000] ... MAX_LOCKDEP_CHAINS: =A0 =A0 =A032768
> [ =A0 =A00.000000] ... CHAINHASH_SIZE: =A0 =A0 =A0 =A0 =A016384
> [ =A0 =A00.000000] =A0memory used by lock dependency info: 3695 kB
> [ =A0 =A00.000000] =A0per task-struct memory footprint: 1152 bytes
> [ =A0 =A00.000000] Calibrating delay loop... 498.87 BogoMIPS (lpj=3D1=
945600)
> [ =A0 =A00.000000] pid_max: default: 32768 minimum: 301
> [ =A0 =A00.000000] Security Framework initialized
> [ =A0 =A00.000000] Mount-cache hash table entries: 512
> [ =A0 =A00.000000] CPU: Testing write buffer coherency: ok
> [ =A0 =A00.000000] Brought up 1 CPUs
> [ =A0 =A00.000000] SMP: Total of 1 processors activated (498.87 BogoM=
IPS).
> [ =A0 =A00.000000] regulator: core version 0.5
> [ =A0 =A00.000000] NET: Registered protocol family 16
> [ =A0 =A00.000000] OMAP DMA hardware revision 4.0
> [ =A0 =A00.052703] bio: create slab <bio-0> at 0
> [ =A0 =A00.066741] SCSI subsystem initialized
> [ =A0 =A00.083923] omap_device: i2c_omap.1: new worst case activate l=
atency 0: 91552
> [ =A0 =A00.101776] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> [ =A0 =A00.118988] twl4030: PIH (irq 7) chaining IRQs 368..375
> [ =A0 =A00.124847] twl4030: power (irq 373) chaining IRQs 376..383
> [ =A0 =A00.132843] twl4030: gpio (irq 368) chaining IRQs 384..401
> [ =A0 =A00.154357] regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV nor=
mal standby
> [ =A0 =A00.164520] regulator: VDAC: 1800 mV normal standby
> [ =A0 =A00.172851] regulator: VPLL2: 1800 mV normal standby
> [ =A0 =A00.180755] regulator: VSIM: 1800 <--> 3000 mV at 1800 mV norm=
al standby
> [ =A0 =A00.188446] omap_device: i2c_omap.1: new worst case deactivate=
 latency 0: 30517
> [ =A0 =A00.210754] i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
> [ =A0 =A00.226409] i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> [ =A0 =A00.242767] Switching to clocksource 32k_counter
> [ =A0 =A00.358764] NET: Registered protocol family 2
> [ =A0 =A00.364349] IP route cache hash table entries: 1024 (order: 0,=
 4096 bytes)
> [ =A0 =A00.374298] TCP established hash table entries: 4096 (order: 3=
, 32768 bytes)
> [ =A0 =A00.382080] TCP bind hash table entries: 4096 (order: 5, 13107=
2 bytes)
> [ =A0 =A00.391815] TCP: Hash tables configured (established 4096 bind=
 4096)
> [ =A0 =A00.398620] TCP reno registered
> [ =A0 =A00.401977] UDP hash table entries: 64 (order: 0, 5120 bytes)
> [ =A0 =A00.408447] UDP-Lite hash table entries: 64 (order: 0, 5120 by=
tes)
> [ =A0 =A00.416198] NET: Registered protocol family 1
> [ =A0 =A00.422210] RPC: Registered udp transport module.
> [ =A0 =A00.427154] RPC: Registered tcp transport module.
> [ =A0 =A00.432342] RPC: Registered tcp NFSv4.1 backchannel transport =
module.
> [ =A0 =A00.440216] Trying to unpack rootfs image as initramfs...
> [ =A0 =A00.447235] rootfs image is not initramfs (junk in compressed =
archive); looks like an initrd
> [ =A0 =A00.697875] Freeing initrd memory: 16384K
> [ =A0 =A00.707366] NetWinder Floating Point Emulator V0.97 (double pr=
ecision)
> [ =A0 =A00.893859] VFS: Disk quotas dquot_6.5.2
> [ =A0 =A00.898529] Dquot-cache hash table entries: 1024 (order 0, 409=
6 bytes)
> [ =A0 =A00.908569] JFFS2 version 2.2. (NAND) (SUMMARY) =A0=A9 2001-20=
06 Red Hat, Inc.
> [ =A0 =A00.917541] msgmni has been set to 232
> [ =A0 =A00.927093] io scheduler noop registered
> [ =A0 =A00.931365] io scheduler deadline registered
> [ =A0 =A00.936218] io scheduler cfq registered (default)
> [ =A0 =A00.945587] Serial: 8250/16550 driver, 4 ports, IRQ sharing en=
abled
> [ =A0 =A00.960083] omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 7=
2) is a OMAP UART0

You need to use ttyO0 for the console, since the new omap-hsuart is
now used instead of the 8250 driver.

I hope this helps!

Jean

> ; =A0=AE=B6=B6V=3D=AF=B0=A1=B3
> =A0 =A0 =A0 =A0 =A0 =A02s14?=A04=AD=A5/0400=A8=C91=3D=B7=A0?=A0=B5!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0-=D5; =A0=AE7=A34=3D=AF=B0=A1=B3
>
> <Serial console goes for toss and dumps garbage here after>
>
>
> Does anybody has seen such issues; any suggestion/help is helpful?
>
> Thanks,
> Vaibhav
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
