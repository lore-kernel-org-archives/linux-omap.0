From: Archit Taneja <a0393947@ti.com>
Subject: Re: NFS mount issue with OMAP4 on linux-next
Date: Tue, 24 Jul 2012 11:48:54 +0530
Message-ID: <500E3E4E.1060809@ti.com>
References: <500E3B9B.9080702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab2GXGUM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 02:20:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6O6KACt009624
	for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:20:11 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6O6K96T004402
	for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 11:50:09 +0530 (IST)
In-Reply-To: <500E3B9B.9080702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Comparing with working logs, I see this difference:

[    1.502166] spi spi1.0: no RX DMA engine channel for McSPI
[    1.507904] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status -1=
1
[    1.514862] omap2_mcspi omap2_mcspi.1: can't create new device for k=
s8851

I guess that's why it isn't working?

Archit

On Tuesday 24 July 2012 11:37 AM, Archit Taneja wrote:
> Hi,
>
> I am not able to mount a filesyatem via NFS on OMAP4 SDP with the
> current linux-next kernel. The same thing works fine with OMAP3 SDP.
>
> Some more info:
>
> - initramfs works fine with OMAP4 SDP.
> - NFS mount on OMAP4 SDP works fine with mainline kernel.
> - Logs below (No output on console after the last print, but console
> takes input)
>
> Thanks,
> Archit
>
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Linux version 3.5.0-next-20120723 (a0393947@a0393947pc=
)
> (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #68 SMP Tue Jul 2=
4
> 11:30:19 IST 2012
> [    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7),
> cr=3D10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine: OMAP4430 4430SDP board
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> [    0.000000] OMAP4430 ES2.1
> [    0.000000] PERCPU: Embedded 9 pages/cpu @c1526000 s12736 r8192
> d15936 u36864
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 259840
> [    0.000000] Kernel command line: mem=3D1G console=3DttyO2,115200n8
> noinitrd root=3D/dev/nfs rw
> nfsroot=3D172.24.137.248:/nfs-share/mnt/,nolock,tcp,rsize=3D2048,wsiz=
e=3D2048,tcp
> ip=3D172.24.190.136 no_console_suspend
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524=
288
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 26214=
4
> bytes)
> [    0.000000] Memory: 759MB 264MB =3D 1023MB total
> [    0.000000] Memory: 1025032k/1025032k available, 23544k reserved,
> 270336K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc06ca0c4   (6921 kB)
> [    0.000000]       .init : 0xc06cb000 - 0xc071a1c0   ( 317 kB)
> [    0.000000]       .data : 0xc071c000 - 0xc07b8000   ( 624 kB)
> [    0.000000]        .bss : 0xc07b8024 - 0xc0d1260c   (5482 kB)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] NR_IRQS:474
> [    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for
> dpll_mpu_m2_ck.
> [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [    0.000000] omap_hwmod: sys_32k_ck: missing clockdomain for sys_32=
k_ck.
> [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wra=
ps
> every 131071999ms
> [    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
> Inc., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.000000] ... CHAINHASH_SIZE:          16384
> [    0.000000]  memory used by lock dependency info: 3695 kB
> [    0.000000]  per task-struct memory footprint: 1152 bytes
> [    0.000823] Calibrating delay loop... 2007.19 BogoMIPS (lpj=3D7839=
744)
> [    0.054565] pid_max: default: 32768 minimum: 301
> [    0.055084] Security Framework initialized
> [    0.055267] Mount-cache hash table entries: 512
> [    0.059051] CPU: Testing write buffer coherency: ok
> [    0.059936] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.060272] Setting up static identity map for 0x804f96a0 - 0x804f=
9710
> [    0.060363] L310 cache controller enabled
> [    0.060363] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e47000=
0,
> Cache size: 1048576 B
> [    0.063385] CPU1: Booted secondary processor
> [    0.130554] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.130615] CPU1: Unknown IPI message 0x0
> [    0.131103] Brought up 2 CPUs
> [    0.131103] SMP: Total of 2 processors activated (4022.78 BogoMIPS=
).
> [    0.139221] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_=
ck.
> [    0.143218] omap_hwmod: sl2if: cannot be enabled for reset (3)
> [    0.147216] omap_hwmod: mcpdm: cannot be enabled for reset (3)
> [    0.147338] omap_hwmod: cm_core_aon: cannot be enabled for reset (=
3)
> [    0.147369] omap_hwmod: cm_core: cannot be enabled for reset (3)
> [    0.151733] dummy:
> [    0.152709] NET: Registered protocol family 16
> [    0.154144] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> [    0.154571] GPMC revision 6.0
> [    0.154693] gpmc: irq-52 could not claim: err -22
> [    0.159576] OMAP GPIO hardware version 0.1
> [    0.166137] omap_mux_init: Add partition: #1: core, flags: 2
> [    0.167541] omap_mux_init: Add partition: #2: wkup, flags: 2
> [    0.171203] _omap_mux_get_by_name: Could not find signal
> uart1_rx.uart1_rx
> [    0.171203] _omap_mux_get_by_name: Could not find signal
> uart1_rx.uart1_rx
> [    0.217803] Error setting wl12xx data: -38
> [    0.223114] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> watchpoint registers.
> [    0.223114] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.231445] OMAP DMA hardware revision 0.0
> [    0.258178] bio: create slab <bio-0> at 0
> [    0.259674] VBAT: 3750 mV
> [    0.260223] vwl1271: 1800 mV
> [    0.262603] SCSI subsystem initialized
> [    0.263702] usbcore: registered new interface driver usbfs
> [    0.263916] usbcore: registered new interface driver hub
> [    0.264221] usbcore: registered new device driver usb
> [    0.279205] omap_i2c omap_i2c.1: bus 1 rev2.4.0 at 400 kHz
> [    0.281311] Skipping twl internal clock init and using bootloader
> value (unknown osc rate)
> [    0.282257] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
> [    0.283721] VUSB: 3300 mV normal standby
> [    0.284545] vdd_mpu: 500 <--> 1500 mV normal
> [    0.285400] vdd_iva: 500 <--> 1500 mV normal
> [    0.286224] vdd_core: 500 <--> 1500 mV normal
> [    0.287750] V1V8: 1800 mV normal standby
> [    0.288574] V2V1: 2100 mV normal standby
> [    0.289520] VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
> [    0.290710] VPP: 1800 <--> 2500 mV at 1900 mV normal standby
> [    0.291839] VUSIM: 1200 <--> 2900 mV at 1800 mV normal standby
> [    0.293090] VCXIO: 1800 mV normal standby
> [    0.293151] VCXIO: supplied by V2V1
> [    0.295013] VDAC: 1800 mV normal standby
> [    0.295043] VDAC: supplied by V2V1
> [    0.296447] VAUX1_6030: 1000 <--> 3000 mV at 2800 mV normal standb=
y
> [    0.297546] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standb=
y
> [    0.298706] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standb=
y
> [    0.300201] VANA: 2100 mV normal standby
> [    0.310333] omap_i2c omap_i2c.2: bus 2 rev2.4.0 at 400 kHz
> [    0.325927] omap_i2c omap_i2c.3: bus 3 rev2.4.0 at 400 kHz
> [    0.341522] omap_i2c omap_i2c.4: bus 4 rev2.4.0 at 400 kHz
> [    0.345489] Switching to clocksource 32k_counter
> [    0.404449] NET: Registered protocol family 2
> [    0.405761] TCP established hash table entries: 131072 (order: 8,
> 1048576 bytes)
> [    0.407989] TCP bind hash table entries: 65536 (order: 9, 2359296 =
bytes)
> [    0.423126] TCP: Hash tables configured (established 131072 bind 6=
5536)
> [    0.423431] TCP: reno registered
> [    0.423461] UDP hash table entries: 512 (order: 3, 40960 bytes)
> [    0.423706] UDP-Lite hash table entries: 512 (order: 3, 40960 byte=
s)
> [    0.424468] NET: Registered protocol family 1
> [    0.425262] RPC: Registered named UNIX socket transport module.
> [    0.425292] RPC: Registered udp transport module.
> [    0.425292] RPC: Registered tcp transport module.
> [    0.425292] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.
> [    0.425811] NetWinder Floating Point Emulator V0.97 (double precis=
ion)
> [    0.550140] bounce pool size: 64 pages
> [    0.550537] VFS: Disk quotas dquot_6.5.2
> [    0.550689] Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
> [    0.552185] NFS: Registering the id_resolver key type
> [    0.552490] Key type id_resolver registered
> [    0.552581] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006=
 Red
> Hat, Inc.
> [    0.552978] msgmni has been set to 1474
> [    0.554565] io scheduler noop registered
> [    0.554565] io scheduler deadline registered
> [    0.554626] io scheduler cfq registered (default)
> [    0.555755] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d
> [    0.558868] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 104) is=
 a
> OMAP UART0
> [    0.559814] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 105) is=
 a
> OMAP UART1
> [    0.560424] omap_uart.2: ttyO2 at MMIO 0x48020000 (irq =3D 106) is=
 a
> OMAP UART2
> [    1.334014] console [ttyO2] enabled
> [    1.338409] omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq =3D 102) is=
 a
> OMAP UART3
> [    1.360443] brd: module loaded
> [    1.372375] loop: module loaded
> [    1.378295] mtdoops: mtd device (mtddev=3Dname/number) must be sup=
plied
> [    1.385589] OneNAND driver initializing
> [    1.391540] spi spi1.0: no RX DMA engine channel for McSPI
> [    1.397460] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status =
-11
> [    1.404296] omap2_mcspi omap2_mcspi.1: can't create new device for
> ks8851
> [    1.415222] usbcore: registered new interface driver asix
> [    1.421142] usbcore: registered new interface driver cdc_ether
> [    1.427490] usbcore: registered new interface driver smsc95xx
> [    1.433715] usbcore: registered new interface driver net1080
> [    1.439849] usbcore: registered new interface driver cdc_subset
> [    1.446228] usbcore: registered new interface driver zaurus
> [    1.452331] usbcore: registered new interface driver cdc_ncm
> [    1.459197] usbcore: registered new interface driver cdc_wdm
> [    1.465118] Initializing USB Mass Storage driver...
> [    1.470458] usbcore: registered new interface driver usb-storage
> [    1.476745] USB Mass Storage support registered.
> [    1.482116] usbcore: registered new interface driver libusual
> [    1.488403] usbcore: registered new interface driver usbtest
> [    1.495025] mousedev: PS/2 mouse device common for all mice
> [    1.503112] twl_rtc twl_rtc: Power up reset detected.
> [    1.509063] twl_rtc twl_rtc: Enabling TWL-RTC
> [    1.516632] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
> [    1.523498] i2c /dev entries driver
> [    1.529113] Driver for 1-wire Dallas network protocol.
> [    1.536254] omap_wdt: OMAP Watchdog Timer Rev 0x00: initial timeou=
t
> 60 sec
> [    1.545135] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> [    1.551361] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engin=
e
> channel 48
> [    1.559234] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> [    1.565460] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engin=
e
> channel 62
> [    1.573181] omap_hsmmc omap_hsmmc.4: Failed to get debounce clk
> [    1.579376] omap_hsmmc omap_hsmmc.4: unable to obtain RX DMA engin=
e
> channel 60
> [    1.588012] usbcore: registered new interface driver usbhid
> [    1.593841] usbhid: USB HID core driver
> [    1.597869] oprofile: hardware counters not available
> [    1.603118] oprofile: using timer interrupt.
> [    1.608032] TCP: cubic registered
> [    1.611511] Initializing XFRM netlink socket
> [    1.616027] NET: Registered protocol family 17
> [    1.620910] NET: Registered protocol family 15
> [    1.625793] Key type dns_resolver registered
> [    1.630371] VFP support v0.3: implementor 41 architecture 3 part 3=
0
> variant 9 rev 1
> [    1.643066] omap_vc_i2c_init: I2C config for vdd_iva does not matc=
h
> other channels (0).
> [    1.651275] omap_vc_i2c_init: I2C config for vdd_mpu does not matc=
h
> other channels (0).[    1.660583] Power Management for TI OMAP4.
> [    1.664978] ThumbEE CPU extension supported.
> [    1.685333] clock: disabling unused clocks to save power
> [    1.693359] VANA: incomplete constraints, leaving on
> [    1.699554] VAUX1_6030: incomplete constraints, leaving on
> [    1.705627] VDAC: incomplete constraints, leaving on
> [    1.711791] VMMC: incomplete constraints, leaving on
> [    1.718444] input: gpio-keys as /devices/platform/gpio-keys/input/=
input0
> [    1.727539] twl_rtc twl_rtc: setting system clock to 2000-01-01
> 00:00:00 UTC (946684800)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
