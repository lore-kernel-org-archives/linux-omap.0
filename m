From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Sun, 29 Apr 2012 09:48:26 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA024D6@DBDE01.ent.ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <20120427220813.GE19196@animalcreek.com> <87aa1wyfq5.fsf@ti.com>
 <20120428202047.GA7068@numbers.woodsts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33743 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2D2JtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Apr 2012 05:49:05 -0400
In-Reply-To: <20120428202047.GA7068@numbers.woodsts.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Derald D. Woods" <woods.rt@gmail.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>

On Sun, Apr 29, 2012 at 01:50:48, Derald D. Woods wrote:
> On Fri, Apr 27, 2012 at 03:25:38PM -0700, Kevin Hilman wrote:
> > "Mark A. Greer" <mgreer@animalcreek.com> writes:
> > 
> > > On Thu, Apr 26, 2012 at 04:29:45PM -0700, Kevin Hilman wrote:
> > >
> > > Hi Kevin.
> > >
> > >> This is a rebased version of this series which is ready for broader
> > >> testing.  I'd especially appreciate testing from those of you with
> > >> AM35x platforms.
> > >> 
> > >> Currently, our SoC detection is based on SoC family detection
> > >> (using die ID) and the presence of specific IP blocks (or feature.)
> > >> 
> > >> This series begins the separation of the SoC family detection and
> > >> specific IP detection by completely removing IP detection from the SoC
> > >> family detection (cpu_is_*.)
> > >> 
> > >> Applies on top of v3.4-rc4, boot tested on AM3517 EVM.
> > >
> > > Your series applied and booted without issue until the point that
> > > pm_idle is called.  At that point it hung because its doing a wfi
> > > and not getting an interrupt to wake up back up.  That's expected
> > > behaviour so your patches are good (IMHO) but I need to finish and
> > > submit a new version of my patches to fix that issue.
> > 
> > For the benefit of others wanting to test this:
> > 
> > You have to use 'nohlt' on the cmdline on AM35x in order to avoid WFI
> > and the wakeup problems that are still being worked on.
> > 
> > Kevin
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Hello Kevin,
> 
> I have a Logic PD AM3517 Zoom Experimenter [SOMAM3517-10-1780RJXR-C (REV A)].
> 
> My board booted to the Linux login on MMC rootfs.
> 

I tried to validate these patches now with latest baseline, and I am not 
getting Linux prompt though,

I am based on linux-omap/master (1e32b7eee) and applied all 8 patches from 
Kevin, it always halts at,


==================================boot log=============================

AM3517_EVM # setenv bootargs root=/dev/ram0 rw mem=128M console=ttyS2,115200n8 console=ttyO2,115200n8 initrd=0x81600000,16M
AM3517_EVM # setenv bootcmd 'dhcp; tftp 82000000 uImage; tftp 81600000 ramdisk-pm.gz; bootm 0x82000000'
AM3517_EVM # boot
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 150
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 150
DHCP client bound to address 172.24.133.170
Using DaVinci EMAC device
TFTP from server 172.24.133.105; our IP address is 172.24.133.170
Filename 'uImage'.
Load address: 0x82000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #############
done
Bytes transferred = 3391048 (33be48 hex)
Using DaVinci EMAC device
TFTP from server 172.24.133.105; our IP address is 172.24.133.170
Filename 'ramdisk-pm.gz'.
Load address: 0x81600000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ######
done
Bytes transferred = 2022580 (1edcb4 hex)
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-3.4.0-rc3-11794-gbbc91ff
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3390984 Bytes =  3.2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc3-11794-gbbc91ff (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Sun Apr 29 14:52:26 IST 2012
[    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: OMAP3517/AM3517 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM3517 ES1.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d1f000 s11456 r8192 d13120 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: root=/dev/ram0 rw mem=128M console=ttyS2,115200n8 console=ttyO2,115200n8 initrd=0x81600000,16M
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 127MB = 127MB total
[    0.000000] Memory: 100096k/100096k available, 30976k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05e3ca0   (6000 kB)
[    0.000000]       .init : 0xc05e4000 - 0xc0631cc0   ( 312 kB)
[    0.000000]       .data : 0xc0632000 - 0xc06c6898   ( 595 kB)
[    0.000000]        .bss : 0xc06c68bc - 0xc0c1ac60   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001220] Calibrating delay loop... 497.82 BogoMIPS (lpj=1941504)
[    0.085906] pid_max: default: 32768 minimum: 301
[    0.086914] Security Framework initialized
[    0.087280] Mount-cache hash table entries: 512
[    0.094543] CPU: Testing write buffer coherency: ok
[    0.095886] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.096008] Setting up static identity map for 0x80433d68 - 0x80433dd8
[    0.098541] Brought up 1 CPUs
[    0.098571] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.118988] omap_hwmod: am35x_otg_hs: cannot be enabled for reset (3)
[    0.133148] omap_hwmod: uart4: softreset failed (waited 10000 usec)
[    0.143005] dummy:
[    0.146087] NET: Registered protocol family 16
[    0.147888] GPMC revision 5.0
[    0.148223] gpmc: irq-20 could not claim: err -22
[    0.149719] ------------[ cut here ]------------
[    0.149780] WARNING: at arch/arm/mach-omap2/pm.c:48 _init_omap_device+0x30/0xa8()
[    0.149810] _init_omap_device: could not find omap_hwmod for iva
[    0.149810] Modules linked in:
[    0.149902] [<c001a5c4>] (unwind_backtrace+0x0/0xf0) from [<c003cd84>] (warn_slowpath_common+0x4c/0x64)
[    0.149932] [<c003cd84>] (warn_slowpath_common+0x4c/0x64) from [<c003ce30>] (warn_slowpath_fmt+0x30/0x40)
[    0.149993] [<c003ce30>] (warn_slowpath_fmt+0x30/0x40) from [<c05edef0>] (_init_omap_device+0x30/0xa8)
[    0.150024] [<c05edef0>] (_init_omap_device+0x30/0xa8) from [<c05edf9c>] (omap2_common_pm_init+0x34/0x90)
[    0.150054] [<c05edf9c>] (omap2_common_pm_init+0x34/0x90) from [<c0008718>] (do_one_initcall+0x34/0x180)
[    0.150115] [<c0008718>] (do_one_initcall+0x34/0x180) from [<c05e48f4>] (kernel_init+0xf0/0x1bc)
[    0.150146] [<c05e48f4>] (kernel_init+0xf0/0x1bc) from [<c00142d8>] (kernel_thread_exit+0x0/0x8)
[    0.150482] ---[ end trace 1b75b31a2719ed1c ]---
[    0.163085] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.163787] OMAP GPIO hardware version 2.5
[    0.165893] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.168060] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.170043] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.172332] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.174346] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.182769] ------------[ cut here ]------------
[    0.182830] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:161 omap3_l3_app_irq+0xd0/0x128()
[    0.182861] Address Hole seen by USB_OTG  at address 5ae89a58
[    0.182861] Modules linked in:
[    0.182952] [<c001a5c4>] (unwind_backtrace+0x0/0xf0) from [<c003cd84>] (warn_slowpath_common+0x4c/0x64)
[    0.182983] [<c003cd84>] (warn_slowpath_common+0x4c/0x64) from [<c003ce30>] (warn_slowpath_fmt+0x30/0x40)
[    0.183044] [<c003ce30>] (warn_slowpath_fmt+0x30/0x40) from [<c003135c>] (omap3_l3_app_irq+0xd0/0x128)
[    0.183074] [<c003135c>] (omap3_l3_app_irq+0xd0/0x128) from [<c0097ff8>] (handle_irq_event_percpu+0x5c/0x248)
[    0.183135] [<c0097ff8>] (handle_irq_event_percpu+0x5c/0x248) from [<c0098220>] (handle_irq_event+0x3c/0x5c)
[    0.183166] [<c0098220>] (handle_irq_event+0x3c/0x5c) from [<c009a604>] (handle_level_irq+0xac/0x138)
[    0.183197] [<c009a604>] (handle_level_irq+0xac/0x138) from [<c0097838>] (generic_handle_irq+0x30/0x48)
[    0.183258] [<c0097838>] (generic_handle_irq+0x30/0x48) from [<c0014078>] (handle_IRQ+0x4c/0xac)
[    0.183288] [<c0014078>] (handle_IRQ+0x4c/0xac) from [<c000857c>] (omap3_intc_handle_irq+0x54/0x68)
[    0.183349] [<c000857c>] (omap3_intc_handle_irq+0x54/0x68) from [<c042ebe4>] (__irq_svc+0x44/0x60)
[    0.183380] Exception stack(0xc7825df8 to 0xc7825e40)
[    0.183380] 5de0:                                                       00000001 00000004
[    0.183410] 5e00: 00000000 c78233c0 60000013 c0634994 0000000a c0634994 60000013 00000000
[    0.183441] 5e20: c0634974 00000000 00000001 c7825e40 c00895b8 c042e984 20000013 ffffffff
[    0.183502] [<c042ebe4>] (__irq_svc+0x44/0x60) from [<c042e984>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[    0.183532] [<c042e984>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c009944c>] (__setup_irq+0x158/0x398)
[    0.183563] [<c009944c>] (__setup_irq+0x158/0x398) from [<c0099764>] (request_threaded_irq+0xd8/0x150)
[    0.183624] [<c0099764>] (request_threaded_irq+0xd8/0x150) from [<c05f2b14>] (omap3_l3_probe+0x10c/0x16c)
[    0.183685] [<c05f2b14>] (omap3_l3_probe+0x10c/0x16c) from [<c02914f0>] (platform_drv_probe+0x18/0x1c)
[    0.183715] [<c02914f0>] (platform_drv_probe+0x18/0x1c) from [<c02901b0>] (really_probe+0x64/0x1d8)
[    0.183746] [<c02901b0>] (really_probe+0x64/0x1d8) from [<c0290468>] (driver_probe_device+0x48/0x60)
[    0.183776] [<c0290468>] (driver_probe_device+0x48/0x60) from [<c0290514>] (__driver_attach+0x94/0x98)
[    0.183837] [<c0290514>] (__driver_attach+0x94/0x98) from [<c028ebac>] (bus_for_each_dev+0x50/0x7c)
[    0.183868] [<c028ebac>] (bus_for_each_dev+0x50/0x7c) from [<c028f9fc>] (bus_add_driver+0xa0/0x248)
[    0.183898] [<c028f9fc>] (bus_add_driver+0xa0/0x248) from [<c0290a48>] (driver_register+0x78/0x12c)
[    0.183929] [<c0290a48>] (driver_register+0x78/0x12c) from [<c0291850>] (platform_driver_probe+0x18/0x9c)
[    0.183990] [<c0291850>] (platform_driver_probe+0x18/0x9c) from [<c0008718>] (do_one_initcall+0x34/0x180)
[    0.184020] [<c0008718>] (do_one_initcall+0x34/0x180) from [<c05e48f4>] (kernel_init+0xf0/0x1bc)
[    0.184051] [<c05e48f4>] (kernel_init+0xf0/0x1bc) from [<c00142d8>] (kernel_thread_exit+0x0/0x8)
[    0.184082] ---[ end trace 1b75b31a2719ed1d ]---
[    0.185882] omap_mux_init: Add partition: #1: core, flags: 0
[    0.203979] omap_uart.3: failed to claim resource 58
[    0.204040] omap_device: omap_uart: build failed (-16)
[    0.204040] ------------[ cut here ]------------
[    0.204101] WARNING: at arch/arm/mach-omap2/serial.c:265 omap_serial_init_port+0x1b4/0x294()
[    0.204132] Could not build omap_device for omap_uart: uart4.
[    0.204132] Modules linked in:
[    0.204223] [<c001a5c4>] (unwind_backtrace+0x0/0xf0) from [<c003cd84>] (warn_slowpath_common+0x4c/0x64)
[    0.204254] [<c003cd84>] (warn_slowpath_common+0x4c/0x64) from [<c003ce30>] (warn_slowpath_fmt+0x30/0x40)
[    0.204284] [<c003ce30>] (warn_slowpath_fmt+0x30/0x40) from [<c05ed4c4>] (omap_serial_init_port+0x1b4/0x294)
[    0.204345] [<c05ed4c4>] (omap_serial_init_port+0x1b4/0x294) from [<c05ed608>] (omap_serial_board_init+0x64/0x84)
[    0.204376] [<c05ed608>] (omap_serial_board_init+0x64/0x84) from [<c05f60e4>] (am3517_evm_init+0x74/0x150)
[    0.204437] [<c05f60e4>] (am3517_evm_init+0x74/0x150) from [<c05e76d4>] (customize_machine+0x1c/0x28)
[    0.204467] [<c05e76d4>] (customize_machine+0x1c/0x28) from [<c0008718>] (do_one_initcall+0x34/0x180)
[    0.204528] [<c0008718>] (do_one_initcall+0x34/0x180) from [<c05e48f4>] (kernel_init+0xf0/0x1bc)
[    0.204559] [<c05e48f4>] (kernel_init+0xf0/0x1bc) from [<c00142d8>] (kernel_thread_exit+0x0/0x8)
[    0.204589] ---[ end trace 1b75b31a2719ed1e ]---
[    0.216186] Reprogramming SDRC clock to 332000000 Hz
[    0.216247] dpll3_m2_clk rate change failed: -22
[    0.218627] _omap_mux_init_gpio: Multiple gpio paths (2) for gpio126
[    0.222930] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.244750]  omap-mcbsp.2: alias fck already exists
[    0.245849]  omap-mcbsp.3: alias fck already exists
[    0.252624] OMAP DMA hardware revision 4.0
[    0.347473] bio: create slab <bio-0> at 0
[    0.360321] SCSI subsystem initialized
[    0.363342] omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
[    0.365264] omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
[    0.366882] omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
[    0.369171] omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
[    0.373840] usbcore: registered new interface driver usbfs
[    0.375793] usbcore: registered new interface driver hub
[    0.377075] usbcore: registered new device driver usb
[    0.391448] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 400 kHz
[    0.406555] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
[    0.422180] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[    0.436157] Switching to clocksource 32k_counter
[    0.598144] NET: Registered protocol family 2
[    0.599212] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.602813] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.603210] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.605926] TCP: Hash tables configured (established 4096 bind 4096)
[    0.606048] TCP: reno registered
[    0.606079] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.606475] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.607818] NET: Registered protocol family 1
[    0.610351] RPC: Registered named UNIX socket transport module.
[    0.610382] RPC: Registered udp transport module.
[    0.610412] RPC: Registered tcp transport module.
[    0.610443] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.611724] Trying to unpack rootfs image as initramfs...
[    0.614685] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.803588] Freeing initrd memory: 16384K
[    0.803741] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.011138] VFS: Disk quotas dquot_6.5.2
[    1.011596] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.014068] NFS: Registering the id_resolver key type
[    1.016967] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    1.018646] msgmni has been set to 227
[    1.024047] io scheduler noop registered
[    1.024078] io scheduler deadline registered
[    1.024444] io scheduler cfq registered (default)
[    1.028167] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.037933] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.040985] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.043060] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    2.246429] console [ttyO2] enabled
[    2.299285] brd: module loaded
[    2.331420] loop: module loaded
[    2.343841] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.351928] OneNAND driver initializing
[    2.367126] usbcore: registered new interface driver asix
[    2.373626] usbcore: registered new interface driver cdc_ether
[    2.381042] usbcore: registered new interface driver net1080
[    2.388000] usbcore: registered new interface driver cdc_subset
[    2.395202] usbcore: registered new interface driver zaurus
[    2.402099] usbcore: registered new interface driver cdc_ncm
[    2.411407] usbcore: registered new interface driver cdc_wdm
[    2.417602] Initializing USB Mass Storage driver...
[    2.423706] usbcore: registered new interface driver usb-storage
[    2.430297] USB Mass Storage support registered.
[    2.437011] usbcore: registered new interface driver libusual
[    2.444000] usbcore: registered new interface driver usbtest
[    2.452667] mousedev: PS/2 mouse device common for all mice
[    2.466339] i2c /dev entries driver
[    2.475616] Driver for 1-wire Dallas network protocol.
[    2.486267] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.513214] usbcore: registered new interface driver usbhid
[    2.519348] usbhid: USB HID core driver
[    2.523468] oprofile: hardware counters not available
[    2.528808] oprofile: using timer interrupt.
[    2.534667] TCP: cubic registered
[    2.538177] Initializing XFRM netlink socket
[    2.542999] NET: Registered protocol family 17
[    2.547973] NET: Registered protocol family 15
[    2.553100] Registering the dns_resolver key type
[    2.558410] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    2.566741] ThumbEE CPU extension supported.
[    2.582977] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
[    2.590332] voltdm_scale: No voltage scale API registered for vdd_core
[    2.597503] PM: no software I/O chain control; some wakeups may be lost
[    2.645935] clock: disabling unused clocks to save power
[    2.659515] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.671844] RAMDISK: gzip image found at block 0

<Halt>

