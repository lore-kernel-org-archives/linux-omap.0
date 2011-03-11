From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Fri, 11 Mar 2011 18:56:14 +0530
Message-ID: <4D7A22F6.5050806@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36999 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab1CKN0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 08:26:24 -0500
Received: by mail-yx0-f181.google.com with SMTP id 8so1365978yxm.26
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 05:26:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 3/10/2011 8:09 PM, Paul Walmsley wrote:
> On Thu, 10 Mar 2011, Paul Walmsley wrote:
>
>> On Wed, 9 Mar 2011, Rajendra Nayak wrote:
>>
>>> On Wednesday 09 March 2011 09:20 AM, Paul Walmsley wrote:
>>>> On Fri, 4 Mar 2011, Rajendra Nayak wrote:
>>>>
>>>>> On OMAP4, the PRCM recommended sequence for enabling
>>>>> a module after power-on-reset is
>>>>> -1- Force clkdm to SW_WKUP
>>>>> -2- Configure desired module mode to "enable" or "auto"
>>>>> -3- Wait for the desired module idle status to be FUNC
>>>>> -4- Program clkdm in HW_AUTO(if supported)
>>>>>
>>>>> This sequence applies to all older OMAPs' as well,
>>>>> however since they use autodeps, it makes sure that
>>>>> no clkdm is in IDLE, and hence not requiring a force
>>>>> SW_WKUP when a module is being enabled.
>>
>> This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
>> so I've dropped it from the integration branch until it can be
>> debugged.  Could you check it, please?
>
> It's also breaking boot on OMAP35xx BeagleBoard rev C2.  The kernel
> boot messages are below - omap2plus_defconfig + DEBUG_LL.  Reverting
> the patch fixes it.  Could you please take a look?

I got hold of a Beagle, a sticker on which says rev C1D.
Not sure if there is a better way to identify the rev, but
this one seems to boot fine for me even with this patch.
I just applied this one patch on top of the the tag
'integration-2.6.39-20110310-008' of git://git.pwsan.com/linux-
integration.

Would a board rev make a difference?

-------
Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.38-rc7-dirty (rnayak@a0131687pc) (gcc=20
version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #10 SMP Fri Mar 11=20
17:55:24 IST 2011
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7),=20
cr=3D10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing=20
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x1000=
0
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0d59000 s8032 r8192 d1244=
8=20
u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=20
Total pages: 65024
[    0.000000] Kernel command line: console=3DttyO2,115200n8=20
root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait rootflags=3Dbarrier=
=3D1=20
earlyprintk init=3D/bin/sh
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
=20
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 256MB =3D 256MB total
[    0.000000] Memory: 248248k/248248k available, 13896k reserved, 0K=20
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0051000   ( 292 kB)
[    0.000000]       .text : 0xc0051000 - 0xc05830dc   (5321 kB)
[    0.000000]       .data : 0xc0584000 - 0xc05fc420   ( 482 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:409
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96=20
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck=
=2E
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
=20
every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,=20
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.057373] Calibrating delay loop... 488.41 BogoMIPS (lpj=3D1908736=
)
[    0.232391] pid_max: default: 32768 minimum: 301
[    0.238067] Security Framework initialized
[    0.242767] Mount-cache hash table entries: 512
[    0.253082] CPU: Testing write buffer coherency: ok
[    0.261932] Brought up 1 CPUs
[    0.265075] SMP: Total of 1 processors activated (488.41 BogoMIPS).
[    0.288421] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r=20
l4_core
[    0.295989] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r=20
l4_per
[    0.303375] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r=20
l4_wkup
[    0.327484] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.348358] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.369201] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.382751] print_constraints: dummy:
[    0.388580] NET: Registered protocol family 16
[    0.394805] GPMC revision 5.0
[    0.398101] Trying to install interrupt handler for IRQ402
[    0.404052] Trying to install interrupt handler for IRQ403
[    0.409851] Trying to install interrupt handler for IRQ404
[    0.415649] Trying to install interrupt handler for IRQ405
[    0.421447] Trying to install interrupt handler for IRQ406
[    0.427215] Trying to install interrupt handler for IRQ407
[    0.433044] Trying to install interrupt handler for IRQ408
[    0.438812] Trying to install type control for IRQ409
[    0.444122] Trying to set irq flags for IRQ409
[    0.458343] omap_device: omap_gpio.0: new worst case activate latenc=
y=20
0: 122070
[    0.466979] OMAP GPIO hardware version 2.5
[    0.472015] OMAP GPIO hardware version 2.5
[    0.476959] OMAP GPIO hardware version 2.5
[    0.481811] OMAP GPIO hardware version 2.5
[    0.486755] OMAP GPIO hardware version 2.5
[    0.491668] OMAP GPIO hardware version 2.5
[    0.515655] omap_mux_init: Add partition: #1: core, flags: 0
[    0.525390] OMAP3 Beagle Rev: C1/C2/C3
[    0.534912] omap_device: omap_uart.0: new worst case activate latenc=
y=20
0: 30517
[    0.546813] omap_device: omap_uart.2: new worst case deactivate=20
latency 0: 30517
[    0.554901] Found NAND on CS0
[    0.558044] Registering NAND on CS0
[    0.563262] Unable to get DVI reset GPIO
[    0.567657] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.596466] OMAP DMA hardware revision 4.0
[    0.677093] bio: create slab <bio-0> at 0
[    0.693084] SCSI subsystem initialized
[    0.698181] omap_device: omap2_mcspi.1: new worst case activate=20
latency 0: 30517
[    0.716827] usbcore: registered new interface driver usbfs
[    0.724304] usbcore: registered new interface driver hub
[    0.731079] usbcore: registered new device driver usb
[    0.739105] omap_device: omap_i2c.1: new worst case activate latency=
=20
0: 61035
[    0.746948] omap_i2c omap_i2c.1: bus 1 rev3.12 at 2600 kHz
[    0.765686] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.771545] twl4030: power (irq 373) chaining IRQs 376..383
[    0.779876] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.801025] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV=20
normal standby
[    0.812499] print_constraints: VDAC: 1800 mV normal standby
[    0.821655] print_constraints: VDVI: 1800 mV normal standby
[    0.831024] print_constraints: VSIM: 1800 <--> 3000 mV at 1800 mV=20
normal standby
[    0.839874] omap_device: omap_i2c.1: new worst case deactivate=20
latency 0: 30517
[    0.848022] omap_i2c omap_i2c.3: bus 3 rev3.12 at 100 kHz
[    0.867095] Switching to clocksource 32k_counter
[    0.873657] Switched to NOHz mode on CPU #0
[    1.019775] NET: Registered protocol family 2
[    1.025787] IP route cache hash table entries: 2048 (order: 1, 8192=20
bytes)
[    1.035400] TCP established hash table entries: 8192 (order: 4, 6553=
6=20
bytes)
[    1.043457] TCP bind hash table entries: 8192 (order: 6, 294912 byte=
s)
[    1.056030] TCP: Hash tables configured (established 8192 bind 8192)
[    1.062835] TCP reno registered
[    1.066192] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.072845] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.080871] NET: Registered protocol family 1
[    1.087158] RPC: Registered udp transport module.
[    1.092468] RPC: Registered tcp transport module.
[    1.097412] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.105438] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    1.320373] VFS: Disk quotas dquot_6.5.2
[    1.324951] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.334991] JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red H=
at,=20
Inc.
[    1.343444] msgmni has been set to 484
[    1.353393] io scheduler noop registered
[    1.357666] io scheduler deadline registered
[    1.362365] io scheduler cfq registered (default)
[    1.373229] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.389556] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a=20
OMAP UART0
[    1.399383] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a=20
OMAP UART1
[    1.408508] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a=20
OMAP UART2
[    1.416625] console [ttyO2] enabled, bootconsole disabled
[    1.416625] console [ttyO2] enabled, bootconsole disabled
[    1.478668] brd: module loaded
[    1.506439] loop: module loaded
[    1.511108] omap_device: omap_i2c.1: new worst case activate latency=
=20
0: 152587
[    1.529266] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.536132] omap2-nand driver initializing
[    1.541107] ONFI flash detected
[    1.544769] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micro=
n=20
NAND 256MiB 1,8V 16-bit)
[    1.553955] Creating 5 MTD partitions on "omap2-nand.0":
[    1.559539] 0x000000000000-0x000000080000 : "X-Loader"
[    1.576385] 0x000000080000-0x000000260000 : "U-Boot"
[    1.589569] 0x000000260000-0x000000280000 : "U-Boot Env"
[    1.602081] 0x000000280000-0x000000680000 : "Kernel"
[    1.616058] 0x000000680000-0x000010000000 : "File System"
[    1.746307] OneNAND driver initializing
[    1.762634] usbcore: registered new interface driver asix
[    1.769317] usbcore: registered new interface driver cdc_ether
[    1.776580] usbcore: registered new interface driver net1080
[    1.783386] usbcore: registered new interface driver cdc_subset
[    1.790496] usbcore: registered new interface driver zaurus
[    1.796508] cdc_ncm: 7-Feb-2011
[    1.800537] usbcore: registered new interface driver cdc_ncm
[    1.809814] usbcore: registered new interface driver cdc_wdm
[    1.815887] Initializing USB Mass Storage driver...
[    1.821929] usbcore: registered new interface driver usb-storage
[    1.828399] USB Mass Storage support registered.
[    1.834960] usbcore: registered new interface driver libusual
[    1.841979] usbcore: registered new interface driver usbtest
[    1.847930] udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma=
)
[    1.859130] mousedev: PS/2 mouse device common for all mice
[    1.869018] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put0
[    1.887878] input: twl4030_pwrbutton as=20
/devices/platform/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/=
input1
[    1.904266] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.914123] i2c /dev entries driver
[    1.923553] Driver for 1-wire Dallas network protocol.
[    1.931701] omap_device: omap_wdt.-1: new worst case activate latenc=
y=20
0: 30517
[    1.941497] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    1.949462] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.956481] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    1.981750] usbcore: registered new interface driver usbhid
[    1.987792] usbhid: USB HID core driver
[    1.991882] oprofile: hardware counters not available
[    1.997161] oprofile: using timer interrupt.
[    2.002471] TCP cubic registered
[    2.005950] Initializing XFRM netlink socket
[    2.010620] NET: Registered protocol family 17
[    2.015502] NET: Registered protocol family 15
[    2.020874] Registering the dns_resolver key type
[    2.026580] VFP support v0.3: implementor 41 architecture 3 part 30=20
variant c rev 1
[    2.036193] ThumbEE CPU extension supported.
[    2.054840] Power Management for TI OMAP3.
[    2.106384] clock: disabling unused clocks to save power
[    2.119476] regulator_init_complete: VDVI: incomplete constraints,=20
leaving on
[    2.127502] regulator_init_complete: VDAC: incomplete constraints,=20
leaving on
[    2.137084] twl_rtc twl_rtc: setting system clock to 2000-01-01=20
00:44:33 UTC (946687473)
[    2.150207] Waiting for root device /dev/mmcblk0p2...
[    2.466430] mmc0: new SDHC card at address aaaa
[    2.475067] mmcblk0: mmc0:aaaa SD04G 3.69 GiB
[    2.488464]  mmcblk0: p1 p2

[    3.158355] kjournald starting.  Commit interval 5 seconds
[    3.165069] EXT3-fs (mmcblk0p2): warning: mounting fs with errors,=20
running e2fsck is recommended
[    3.178955] EXT3-fs (mmcblk0p2): using internal journal
[    3.184448] EXT3-fs (mmcblk0p2): recovery complete
[    3.193359] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a=20
mode
[    3.201263] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    3.207885] Freeing init memory: 292K

/bin/sh: can't access tty; job control turned off
#
#
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
