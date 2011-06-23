From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume support
Date: Thu, 23 Jun 2011 13:37:18 -0700
Message-ID: <87sjr08etd.fsf@ti.com>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> <874o3g9xmv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46530 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933870Ab1FWUhW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 16:37:22 -0400
In-Reply-To: <874o3g9xmv.fsf@ti.com> (Kevin Hilman's message of "Thu, 23 Jun
	2011 12:05:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

> Hi Russell,
>
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> Convert sa11x0 to use the generic CPU suspend/resume support, rather
>> than implementing its own version.  Tested on 3430 LDP.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> I tested this on 3430/n900 and 3530/Overo and it worked fine for
> retention, but not for off.
>
> Testing with off-mode, I found the MULTI_CPU path to be broken in
> cpu_suspend (jumping to zero.)  Rebuilding for only OMAP3, it worked
> fine for full-chip retention in suspend and idle as well as full-chip
> off in suspend and idle.
>
> I'm digging into the MULTI_CPU path now.

Here's a dump of the printk __log_buf using Lauterbach:

Looks like cpu_suspend is jumping to 0x0, which triggers the fault
handler which then triggers the BUG in might_sleep().

Now looking into why cpu_suspend is jumping to 0x0...

Kevin


<5>[    0.000000] Linux version 3.0.0-rc4-pm+initramfs+debug+cmdline-14=
038-g9ec291c (khilman@paris) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8u=
buntu3) ) #19 SMP Thu Jun 23 13:21:58 PDT 2011
<4>[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), c=
r=3D10c53c7f
<4>[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
<4>[    0.000000] Machine: Nokia RX-51 board
<4>[    0.000000] Ignoring unrecognised tag 0x414f4d50
<6>[    0.000000] bootconsole [earlycon0] enabled
<6>[    0.000000] Reserving 16777216 bytes SDRAM for VRAM
<4>[    0.000000] Memory policy: ECC disabled, Data cache writeback
<6>[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
<6>[    0.000000] SRAM: Mapped pa 0x40208000 to va 0xfe408000 size: 0x7=
000
<7>[    0.000000] On node 0 totalpages: 61440
<7>[    0.000000] free_area_init_node: node 0, pgdat c086de40, node_mem=
_map c0dc5000
<7>[    0.000000]   Normal zone: 512 pages used for memmap
<7>[    0.000000]   Normal zone: 0 pages reserved
<7>[    0.000000]   Normal zone: 60928 pages, LIFO batch:15
<6>[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
<6>[    0.000000] Reprogramming SDRC clock to 332000000 Hz
<6>[    0.000000] PERCPU: Embedded 7 pages/cpu @c0fca000 s7264 r8192 d1=
3216 u32768
<7>[    0.000000] pcpu-alloc: s7264 r8192 d13216 u32768 alloc=3D8*4096
<7>[    0.000000] pcpu-alloc: [0] 0=20
<4>[    0.000000] Built 1 zonelists in Zone order, mobility grouping on=
=2E  Total pages: 60928
<5>[    0.000000] Kernel command line: console=3DttyO2,115200n8 debug e=
arlyprintk
<6>[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
<6>[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131=
072 bytes)
<6>[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 6553=
6 bytes)
<6>[    0.000000] Memory: 240MB =3D 240MB total
<5>[    0.000000] Memory: 229364k/229364k available, 32780k reserved, 0=
K highmem
<5>[    0.000000] Virtual kernel memory layout:
<5>[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
<5>[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
<5>[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
<5>[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
<5>[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
<5>[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
<5>[    0.000000]       .init : 0xc0008000 - 0xc024f000   (2332 kB)
<5>[    0.000000]       .text : 0xc024f000 - 0xc07edf0c   (5756 kB)
<5>[    0.000000]       .data : 0xc07ee000 - 0xc086f260   ( 517 kB)
<5>[    0.000000]        .bss : 0xc086f284 - 0xc0dc4328   (5461 kB)
<6>[    0.000000] Hierarchical RCU implementation.
<6>[    0.000000] NR_IRQS:410
<6>[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with =
96 interrupts
<6>[    0.000000] Total of 96 interrupts on 1 active controller
<6>[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
<6>[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wr=
aps every 131071999ms
<6>[    0.000000] Console: colour dummy device 80x30
<4>[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat=
, Inc., Ingo Molnar
<4>[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
<4>[    0.000000] ... MAX_LOCK_DEPTH:          48
<4>[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
<4>[    0.000000] ... CLASSHASH_SIZE:          4096
<4>[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
<4>[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
<4>[    0.000000] ... CHAINHASH_SIZE:          16384
<4>[    0.000000]  memory used by lock dependency info: 3695 kB
<4>[    0.000000]  per task-struct memory footprint: 1152 bytes
<6>[    0.057434] Calibrating delay loop... 497.82 BogoMIPS (lpj=3D1941=
504)
<6>[    0.096252] pid_max: default: 32768 minimum: 301
<6>[    0.102050] Security Framework initialized
<6>[    0.106811] Mount-cache hash table entries: 512
<6>[    0.117370] CPU: Testing write buffer coherency: ok
<6>[    0.126129] Brought up 1 CPUs
<6>[    0.129302] SMP: Total of 1 processors activated (497.82 BogoMIPS=
).
<4>[    0.154693] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va=
 for l4_core
<4>[    0.162261] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va=
 for l4_per
<4>[    0.169677] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va=
 for l4_wkup
<4>[    0.177642] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_=
fck.
<4>[    0.200012] omap_hwmod: i2c1: softreset failed (waited 10000 usec=
)
<4>[    0.220520] omap_hwmod: i2c2: softreset failed (waited 10000 usec=
)
<4>[    0.240936] omap_hwmod: i2c3: softreset failed (waited 10000 usec=
)
<4>[    0.248260] omap_hwmod: am35x_otg_hs: cannot be enabled (3)
<6>[    0.260345] print_constraints: dummy:=20
<6>[    0.266113] NET: Registered protocol family 16
<6>[    0.272277] GPMC revision 5.0
<4>[    0.286712] omap_device: omap_gpio.0: new worst case activate lat=
ency 0: 91552
<6>[    0.297882] OMAP GPIO hardware version 2.5
<6>[    0.321319] omap_mux_init: Add partition: #1: core, flags: 0
<4>[    0.331848] omap_device: omap_uart.0: new worst case activate lat=
ency 0: 30517
<4>[    0.343688] omap_device: omap_uart.2: new worst case deactivate l=
atency 0: 30517
<6>[    0.469421] hw-breakpoint: debug architecture 0x4 unsupported.
<6>[    0.496551] Reserving DMA channels 0 and 1 for HS ROM code
<6>[    0.502716] OMAP DMA hardware revision 4.0
<6>[    0.593872] bio: create slab <bio-0> at 0
<5>[    0.609985] SCSI subsystem initialized
<4>[    0.614715] omap_device: omap2_mcspi.1: new worst case activate l=
atency 0: 61035
<4>[    0.628173] omap_device: omap2_mcspi.1: new worst case deactivate=
 latency 0: 30517
<6>[    0.645477] usbcore: registered new interface driver usbfs
<6>[    0.652923] usbcore: registered new interface driver hub
<6>[    0.659942] usbcore: registered new device driver usb
<4>[    0.667724] omap_device: omap_i2c.1: new worst case activate late=
ncy 0: 30517
<6>[    0.675598] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2200 kHz
<6>[    0.730743] twl4030: PIH (irq 7) chaining IRQs 368..375
<6>[    0.736480] twl4030: power (irq 373) chaining IRQs 376..383
<6>[    0.744873] twl4030: gpio (irq 368) chaining IRQs 384..401
<6>[    0.763610] print_constraints: VPLL: 1800 mV normal standby
<6>[    0.774322] print_constraints: VIO: 1800 mV normal standby
<6>[    0.783447] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 m=
V normal standby
<6>[    0.794433] print_constraints: VDAC: 1800 mV normal standby
<6>[    0.803253] print_constraints: VCSI: 1800 mV normal standby
<6>[    0.812744] print_constraints: VINTANA1: 1500 mV normal standby
<6>[    0.822753] print_constraints: VINTANA2: 2750 mV normal standby
<6>[    0.832489] print_constraints: VINTDIG: 1500 mV normal standby
<6>[    0.842102] print_constraints: VSDI_CSI: 1800 mV normal standby
<6>[    0.852020] print_constraints: V28_A: 2800 <--> 3000 mV at 2600 m=
V normal standby
<6>[    0.863037] print_constraints: VMMC2_IO_18: 1800 mV normal standb=
y
<6>[    0.872772] print_constraints: V28: 2800 mV normal standby
<6>[    0.881744] print_constraints: VMMC2_30: 2800 <--> 3000 mV at 280=
0 mV normal standby
<6>[    0.892974] print_constraints: VCAM_ANA_28: 2800 mV normal standb=
y
<4>[    0.900421] omap_device: omap_i2c.1: new worst case deactivate la=
tency 0: 30517
<6>[    0.908538] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 100 kHz
<6>[    0.918792] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
<6>[    0.936279] Switching to clocksource 32k_counter
<6>[    0.945373] Switched to NOHz mode on CPU #0
<6>[    1.081390] NET: Registered protocol family 2
<6>[    1.087432] IP route cache hash table entries: 2048 (order: 1, 81=
92 bytes)
<6>[    1.097198] TCP established hash table entries: 8192 (order: 4, 6=
5536 bytes)
<6>[    1.105194] TCP bind hash table entries: 8192 (order: 6, 294912 b=
ytes)
<6>[    1.117156] TCP: Hash tables configured (established 8192 bind 81=
92)
<6>[    1.123962] TCP reno registered
<6>[    1.127319] UDP hash table entries: 128 (order: 1, 10240 bytes)
<6>[    1.133941] UDP-Lite hash table entries: 128 (order: 1, 10240 byt=
es)
<6>[    1.141845] NET: Registered protocol family 1
<6>[    1.148284] RPC: Registered named UNIX socket transport module.
<6>[    1.154876] RPC: Registered udp transport module.
<6>[    1.159820] RPC: Registered tcp transport module.
<6>[    1.164825] RPC: Registered tcp NFSv4.1 backchannel transport mod=
ule.
<4>[    1.272949] NetWinder Floating Point Emulator V0.97 (double preci=
sion)
<5>[    1.475921] VFS: Disk quotas dquot_6.5.2
<4>[    1.480499] Dquot-cache hash table entries: 1024 (order 0, 4096 b=
ytes)
<6>[    1.491271] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006=
 Red Hat, Inc.
<6>[    1.500152] msgmni has been set to 447
<6>[    1.528320] io scheduler noop registered
<6>[    1.532470] io scheduler deadline registered
<6>[    1.537353] io scheduler cfq registered (default)
<6>[    1.548095] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabl=
ed
<6>[    1.564727] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is=
 a OMAP UART0
<6>[    1.575347] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is=
 a OMAP UART1
<6>[    1.584350] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is=
 a OMAP UART2
<6>[    1.592285] console [ttyO2] enabled, bootconsole disabled
<6>[    1.649993] brd: module loaded
<6>[    1.675323] loop: module loaded
<4>[    1.680358] omap_device: omap_i2c.1: new worst case activate late=
ncy 0: 122070
<3>[    1.697875] mtdoops: mtd device (mtddev=3Dname/number) must be su=
pplied
<6>[    1.705078] omap2-nand driver initializing
<6>[    1.710662] OneNAND driver initializing
<6>[    1.716064] omap2-onenand omap2-onenand: initializing on CS0, phy=
s base 0x04000000, virtual base d0880000, freq 83 MHz
<7>[    1.727447] OneNAND Manufacturer: Numonyx (0x20)
<6>[    1.732391] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
<6>[    1.737426] OneNAND version =3D 0x0031
<7>[    1.741271] Chip support all block unlock
<7>[    1.745483] Chip has 2 plane
<6>[    1.750671] Scanning device for bad blocks
<7>[    1.813232] onenand_bbt_wait: ecc 0x2222 ctrl 0x2400 intr 0x8080 =
addr1 0x22a addr8 0x0
<6>[    1.821655] OneNAND eraseblock 554 is an initial bad block
<5>[    1.981475] Creating 6 MTD partitions on "omap2-onenand":
<5>[    1.987182] 0x000000000000-0x000000020000 : "bootloader"
<5>[    2.002593] 0x000000020000-0x000000080000 : "config"
<5>[    2.014892] 0x000000080000-0x0000000c0000 : "log"
<5>[    2.026123] 0x0000000c0000-0x0000002c0000 : "kernel"
<5>[    2.037902] 0x0000002c0000-0x0000004c0000 : "initfs"
<5>[    2.049499] 0x0000004c0000-0x000010000000 : "rootfs"
<4>[    2.086059] smc91x: not found (-19).
<6>[    2.093109] usbcore: registered new interface driver asix
<6>[    2.099792] usbcore: registered new interface driver cdc_ether
<6>[    2.106903] usbcore: registered new interface driver net1080
<6>[    2.113586] usbcore: registered new interface driver cdc_subset
<6>[    2.120666] usbcore: registered new interface driver zaurus
<6>[    2.126770] cdc_ncm: 01-June-2011
<6>[    2.131042] usbcore: registered new interface driver cdc_ncm
<6>[    2.140289] usbcore: registered new interface driver cdc_wdm
<6>[    2.146423] Initializing USB Mass Storage driver...
<6>[    2.152404] usbcore: registered new interface driver usb-storage
<6>[    2.158935] USB Mass Storage support registered.
<6>[    2.165527] usbcore: registered new interface driver libusual
<6>[    2.172576] usbcore: registered new interface driver usbtest
<6>[    2.182830] mousedev: PS/2 mouse device common for all mice
<6>[    2.194427] input: gpio-keys as /devices/platform/gpio-keys/input=
/input0
<6>[    2.208007] input: TWL4030 Keypad as /devices/platform/omap/omap_=
i2c.1/i2c-1/1-004a/twl4030_keypad/input/input1
<6>[    2.230712] input: twl4030_pwrbutton as /devices/platform/omap/om=
ap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
<6>[    2.249114] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
<4>[    2.256164] twl_rtc twl_rtc: Power up reset detected.
<6>[    2.262542] twl_rtc twl_rtc: Enabling TWL-RTC.
<6>[    2.268890] i2c /dev entries driver
<6>[    2.279052] Driver for 1-wire Dallas network protocol.
<4>[    2.287200] omap_device: omap_wdt.-1: new worst case activate lat=
ency 0: 30517
<6>[    2.297027] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
<4>[    2.303619] omap_device: omap_wdt.-1: new worst case deactivate l=
atency 0: 30517
<3>[    2.312927] twl4030_wdt twl4030_wdt: Failed to register misc devi=
ce
<4>[    2.319763] twl4030_wdt: probe of twl4030_wdt failed with error -=
16
<6>[    2.327423] cpuidle: using governor ladder
<6>[    2.331756] cpuidle: using governor menu
<6>[    2.354064] usbcore: registered new interface driver usbhid
<6>[    2.360107] usbhid: USB HID core driver
<6>[    2.364227] oprofile: hardware counters not available
<6>[    2.369567] oprofile: using timer interrupt.
<6>[    2.374969] TCP cubic registered
<6>[    2.378387] Initializing XFRM netlink socket
<6>[    2.383178] NET: Registered protocol family 17
<6>[    2.388092] NET: Registered protocol family 15
<5>[    2.393157] Registering the dns_resolver key type
<6>[    2.398986] VFP support v0.3: implementor 41 architecture 3 part =
30 variant c rev 1
<6>[    2.407165] ThumbEE CPU extension supported.
<4>[    2.440399] sr_init: No PMIC hook to init smartreflex
<6>[    2.446624] smartreflex smartreflex.0: omap_sr_probe: SmartReflex=
 driver initialized
<6>[    2.455810] smartreflex smartreflex.1: omap_sr_probe: SmartReflex=
 driver initialized
<6>[    2.465698] SmartReflex Class3 initialized
<6>[    2.515441] clock: disabling unused clocks to save power
<6>[    2.528503] regulator_init_complete: VCSI: disabling
<6>[    2.536132] twl_rtc twl_rtc: setting system clock to 2000-01-01 0=
0:00:00 UTC (946684800)
<6>[    2.550109] Freeing init memory: 2332K
<6>[    2.888244] mmc1: new high speed MMC card at address 0001
<6>[    2.897979] mmcblk0: mmc1:0001 MMC32G 29.8 GiB=20
<6>[    2.903869] mmcblk0boot0: mmc1:0001 MMC32G partition 1 512 KiB
<6>[    2.910705] mmcblk0boot1: mmc1:0001 MMC32G partition 2 512 KiB
<6>[    2.925170]  mmcblk0: p1
<6>[    2.935729]  mmcblk0boot1: unknown partition table
<6>[    2.946075]  mmcblk0boot0: unknown partition table
<6>[   49.616638] PM: Syncing filesystems ... done.
<7>[   49.624084] PM: Preparing system for mem sleep
<4>[   49.635040] Freezing user space processes ... (elapsed 0.02 secon=
ds) done.
<4>[   49.663970] Freezing remaining freezable tasks ... (elapsed 0.02 =
seconds) done.
<7>[   49.695281] PM: Entering mem sleep
<4>[   49.700592] Suspending console(s) (use no_console_suspend to debu=
g)
<6>[   49.897003] PM: suspend of devices complete after 181.963 msecs
<6>[   49.900787] PM: late suspend of devices complete after 3.740 msec=
s
<4>[   49.900909] Disabling non-boot CPUs ...
<4>[   49.901641] omap_device: omap_uart.2: new worst case deactivate l=
atency 0: 122070
<3>[   49.901916] BUG: sleeping function called from invalid context at=
 /work/kernel/omap/pm/arch/arm/mm/fault.c:310
<3>[   49.901947] in_atomic(): 0, irqs_disabled(): 128, pid: 583, name:=
 sh
<4>[   49.901947] 4 locks held by sh/583:
<4>[   49.901977]  #0:  (&buffer->mutex){+.+.+.}, at: [<c039135c>] sysf=
s_write_file+0x28/0x184
<4>[   49.902038]  #1:  (s_active#3){.+.+.+}, at: [<c0391410>] sysfs_wr=
ite_file+0xdc/0x184
<4>[   49.902069]  #2:  (pm_mutex){+.+.+.}, at: [<c02dab44>] enter_stat=
e+0x28/0x128
<4>[   49.902130]  #3:  (&mm->mmap_sem){++++++}, at: [<c064e57c>] do_pa=
ge_fault+0xb8/0x258
<4>[   49.902160] irq event stamp: 24205
<4>[   49.902191] hardirqs last  enabled at (24204): [<c064a9a0>] __mut=
ex_unlock_slowpath+0xec/0x168
<4>[   49.902221] hardirqs last disabled at (24205): [<c02da93c>] suspe=
nd_enter+0xc4/0x15c
<4>[   49.902221] softirqs last  enabled at (21791): [<c029e290>] irq_e=
xit+0x94/0xb0
<4>[   49.902282] softirqs last disabled at (21778): [<c029e290>] irq_e=
xit+0x94/0xb0
<4>[   49.902343] [<c0261218>] (unwind_backtrace+0x0/0xf0) from [<c064e=
66c>] (do_page_fault+0x1a8/0x258)
<4>[   49.902374] [<c064e66c>] (do_page_fault+0x1a8/0x258) from [<c024f=
45c>] (do_PrefetchAbort+0x34/0x9c)
<4>[   49.902404] [<c024f45c>] (do_PrefetchAbort+0x34/0x9c) from [<c064=
c278>] (__pabt_svc+0x58/0xa0)
<4>[   49.902435] Exception stack(0xce2cde28 to 0xce2cde70)
<4>[   49.902435] de20:                   ce2cde84 c0000000 00000003 c0=
26e1b0 c086fd10 c0808358
<4>[   49.902465] de40: 8e2cde78 c086f5d4 00000009 000003e9 c0803870 00=
000002 c0000000 ce2cde70
<4>[   49.902496] de60: c025ef04 00000000 60000093 ffffffff
<4>[   49.902526] [<c064c278>] (__pabt_svc+0x58/0xa0) from [<c025ef04>]=
 (cpu_suspend+0x44/0x60)
<4>[   49.902557] [<c025ef04>] (cpu_suspend+0x44/0x60) from [<ce2cde84>=
] (0xce2cde84)
<1>[   49.902587] Unable to handle kernel NULL pointer dereference at v=
irtual address 00000000
<1>[   49.902618] pgd =3D ce310000
<1>[   49.902618] [00000000] *pgd=3D8e2f1831, *pte=3D00000000, *ppte=3D=
00000000
<0>[   49.902648] Internal error: Oops: 80000007 [#1] SMP
<4>[   49.902679] Modules linked in:
<4>[   49.902709] CPU: 0    Not tainted  (3.0.0-rc4-pm+initramfs+debug+=
cmdline-14038-g9ec291c #19)
<4>[   49.902709] PC is at 0x0
<4>[   49.902740] LR is at cpu_suspend+0x44/0x60
<4>[   49.902740] pc : [<00000000>]    lr : [<c025ef04>]    psr: 600000=
93
<4>[   49.902770] sp : ce2cde70  ip : c0000000  fp : 00000002
<4>[   49.902770] r10: c0803870  r9 : 000003e9  r8 : 00000009
<4>[   49.902801] r7 : c086f5d4  r6 : 8e2cde78  r5 : c0808358  r4 : c08=
6fd10
<4>[   49.902801] r3 : c026e1b0  r2 : 00000003  r1 : c0000000  r0 : ce2=
cde84
<4>[   49.902832] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM =
 Segment user
<4>[   49.902832] Control: 10c5387d  Table: 8e310019  DAC: 00000015
<0>[   49.902862] Process sh (pid: 583, stack limit =3D 0xce2cc2f8)
<0>[   49.902893] Stack: (0xce2cde70 to 0xce2ce000)
<0>[   49.902893] de60:                                     00000003 c0=
26e1b0 c0000000 ce2cde84
<0>[   49.902923] de80: c0000000 c086fd10 00000000 00000000 c086f5d4 00=
000009 000003e9 00000003
<0>[   49.902954] dea0: 00000002 c026e534 c080a394 c080a3a0 00000003 00=
000000 00000000 ce8017e0
<0>[   49.902984] dec0: c07540c0 c026e91c c0d8227c 00000000 00000003 c0=
2da9a8 00000000 00000003
<0>[   49.902984] dee0: 00000003 c0d8227c c086eacc c02daa94 00000003 c0=
7540c0 00000000 00000003
<0>[   49.903015] df00: 00000004 c02dac08 ce2e5000 00000003 c06580f0 c0=
2da15c 00000004 ce26e0c0
<0>[   49.903045] df20: ce26e0d8 ce2cdf80 ce818588 00000004 c066d8c8 c0=
464dc8 00000004 c0391434
<0>[   49.903076] df40: ce82a680 00000004 40080000 ce2cdf80 00000004 ce=
2cc000 00000000 c0339794
<0>[   49.903106] df60: 00000001 c025a108 ce82a680 40080000 00000000 00=
000000 00000004 c0339a1c
<0>[   49.903137] df80: 00000000 00000000 00000004 00000000 00000004 00=
1fbac8 00000004 00000004
<0>[   49.903137] dfa0: c025a108 c0259f40 00000004 001fbac8 00000001 40=
080000 00000004 00000000
<0>[   49.903167] dfc0: 00000004 001fbac8 00000004 00000004 40080000 00=
000000 00201000 00000002
<0>[   49.903198] dfe0: 00000000 be87b5f8 00101ffc 00008e8c 60000010 00=
000001 00000000 00000000
<4>[   49.903228] [<c025ef04>] (cpu_suspend+0x44/0x60) from [<ce2cde84>=
] (0xce2cde84)
<0>[   49.903259] Code: bad PC value
<4>[   49.903289] ---[ end trace cba5fa1741250aad ]---
<4>[   49.903991] ------------[ cut here ]------------
<4>[   49.904052] WARNING: at /work/kernel/omap/pm/kernel/time/timekeep=
ing.c:245 ktime_get+0x134/0x164()
<4>[   49.904052] Modules linked in:
<4>[   49.904113] [<c0261218>] (unwind_backtrace+0x0/0xf0) from [<c0296=
f20>] (warn_slowpath_common+0x4c/0x64)
<4>[   49.904144] [<c0296f20>] (warn_slowpath_common+0x4c/0x64) from [<=
c0296f54>] (warn_slowpath_null+0x1c/0x24)
<4>[   49.904174] [<c0296f54>] (warn_slowpath_null+0x1c/0x24) from [<c0=
2c07f8>] (ktime_get+0x134/0x164)
<4>[   49.904205] [<c02c07f8>] (ktime_get+0x134/0x164) from [<c02c7198>=
] (tick_nohz_stop_sched_tick+0x70/0x46c)
<4>[   49.904235] [<c02c7198>] (tick_nohz_stop_sched_tick+0x70/0x46c) f=
rom [<c025b1e0>] (cpu_idle+0x2c/0x104)
<4>[   49.904266] [<c025b1e0>] (cpu_idle+0x2c/0x104) from [<c0008a70>] =
(start_kernel+0x2a8/0x300)
<4>[   49.904296] [<c0008a70>] (start_kernel+0x2a8/0x300) from [<800080=
40>] (0x80008040)
<4>[   49.904327] ---[ end trace cba5fa1741250aae ]---
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
