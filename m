From: Peter Barada <peterb@logicpd.com>
Subject: Trouble getting Logic OMAp35x modules to boot
Date: Mon, 22 Nov 2010 21:20:50 -0500
Message-ID: <4CEB2502.9000300@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:42495
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750945Ab0KWCUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 21:20:22 -0500
Received: from [10.1.249.2] (unknown [10.1.249.2])
	by edprlnx06.logicpd.com (Postfix) with ESMTP id 8220260009B
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 20:19:48 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've pulled the latest linux-2.6.37-rc3 kernel from kernel.org, and=20
using the arch/arm/configs/omap3plus_defconfig as .config, and turning =
on:

CONFIG_MACH_OMAP35CONFIG_MACH_OMAP3530_LV_SOM=3Dy
CONFIG_MACH_OMAP3_TORPEDO=3Dy

to run on the Logic OMAP35x boards, it failed to boot (no output from=20
the serial console).

I added:

CONFIG_DEBUG_LL=3Dy
CONFIG_EARLY_PRINTK=3Dy

to turn on early debigging (and adding earlyprintk to the command line)=
,=20
and see all looks fine up to the end of:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.37-rc3-svn12998 (peter@blitz) (gcc version 4.3.3=20
(Sourcery G++
  Lite 2009q1-203) ) #5 SMP Mon Nov 22 17:09:07 EST 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Logic OMAP3 Torpedo board
debug: ignoring loglevel setting.
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c05450a0, node_mem_map c0579000
   Normal zone: 512 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 65024 pages, LIFO batch:15
PERCPU: Embedded 7 pages/cpu @c077c000 s4928 r8192 d15552 u32768
pcpu-alloc: s4928 r8192 d15552 u32768 alloc=3D8*4096
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65=
024
Kernel command line: display=3D15 console=3DttyS0,115200 root=3D/dev/nf=
s rw=20
nfsroot=3D19
2.168.3.5:/opt/nfs-exports/ltib-omap,wsize=3D1500,rsize=3D1500 ip=3Ddhc=
p=20
no_console_su
spend ignore_loglevel earlyprintk
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 254252k/254252k available, 7892k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .init : 0xc0008000 - 0xc0048000   ( 256 kB)
       .text : 0xc0048000 - 0xc04e9c50   (4744 kB)
       .data : 0xc04ea000 - 0xc0545880   ( 367 kB)
Hierarchical RCU implementation.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/166/500 MHz
Reprogramming SDRC clock to 166000000 Hz
dpll3_m2_clk rate change failed: -22
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
Could not get gpios_ick
Could not get gpios_fck
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 499.92 BogoMIPS (lpj=3D1949696)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Brought up 1 CPUs
SMP: Total of 1 processors activated (499.92 BogoMIPS).
regulator: core version 0.5
regulator: dummy:
NET: Registered protocol family 16
mux: Setting signal sdmmc1_dat5.gpio_127 0x0118 -> 0x0004
mux: Setting signal sdmmc1_dat5.gpio127 0x0004 -> 0x011c
mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0018 -> 0x0118
mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat7.gpio_129 0x0118 -> 0x0104
mux: Setting signal sdrc_cke0.sdrc_cke0 0x0118 -> 0x0000
mux: Setting signal sdrc_cke1.sdrc_cke1 0x0118 -> 0x0000
hw-breakpoint: debug architecture 0x4 unsupported.
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 128 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 496
io scheduler noop registered
io scheduler deadline registered

where the output turns to trash on the serial console.

1) Is omap2plus_defconfig the default kernel configuration I should use=
=20
for the Logic OMAP35x boards?
2) If so, any suggestions on where/why the console serial port is going=
=20
south?

--=20
Peter Barada
peterb@logicpd.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
