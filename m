From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v4 0/4]
Date: Fri, 14 Feb 2014 15:20:52 +0100
Message-ID: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:52168 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaBNOVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 09:21:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This set of patches adds board support for an omap36 (dm3730) system
from INCOstartec.  It's based on Linux 3.14-rc2 + patch series:
"OMAP: OMAP3 DSS related clock patches".

Due to boot order and deferring probe, IRQs for network and USB couldn't
be requested (see Bootlog below).

Changes compared to previous version (v4):
 - rebased on Linux 3.14-rc2 + series: "OMAP: OMAP3 DSS related clock patches"
 - move gpio_156 (DSS enable pin) pinctrl to &gpio5 domain
Changes compared to previous version (v3):
 - rebased on next-20140124
 - use pinctrl macros OMAP3_WKUP_IOPAD, OMAP3_CORE1_IOPAD
   and OMAP3630_CORE2_IOPAD
 - use same convention for all comments
 - dss-quirk: name twl4030 VPLL2 regulator as vdds_dsi
 - fix style
Changes compared to previous version (v2):
 - rebased on next-20140122 from next-20140115
 - using omap36xx.dtsi instead of unsupported 1ghz omap37xx100
Initial version (v1):
 - based on next-20140115

Christoph Fritz (4):
  ARM: dts: omap3: Add support for INCOstartec a83x module
  ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
  ARM: OMAP2+: add legacy display for omap3 DBB056
  ARM: OMAP2+: Add pdata quirk for sys_clkout2 for omap3 DBB056

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi  |  459 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  170 +++++++++++
 arch/arm/mach-omap2/dss-common.c         |   49 ++++
 arch/arm/mach-omap2/dss-common.h         |    1 +
 arch/arm/mach-omap2/pdata-quirks.c       |   45 ++-
 6 files changed, 724 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap3-lilly-a83x.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-lilly-dbb056.dts

Bootlog:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.14.0-rc2+ (c@c) (gcc version 4.7.3 20121106 (prerelease) (linaro-4.7-2012.11) ) #1 PREEMPT Fri Feb 14 14:50:48 CET 2014
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: INCOstartec LILLY-DBB056 (DM3730)
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: console=ttyO0,115200n8 vt.global_cursor_default=0 consoleblank=0 ip=dhcp root=/dev/nfs
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 115052K/130048K available (5686K kernel code, 415K rwdata, 1852K rodata, 216K init, 5434K bss, 14996K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0764c3c   (7540 kB)
[    0.000000]       .init : 0xc0765000 - 0xc079b3c8   ( 217 kB)
[    0.000000]       .data : 0xc079c000 - 0xc0803c40   ( 416 kB)
[    0.000000]        .bss : 0xc0803c4c - 0xc0d52814   (5435 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    9.571105] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000915] Console: colour dummy device 80x30
[    0.001007] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001007] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001007] ... MAX_LOCK_DEPTH:          48
[    0.001037] ... MAX_LOCKDEP_KEYS:        8191
[    0.001037] ... CLASSHASH_SIZE:          4096
[    0.001068] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.001068] ... MAX_LOCKDEP_CHAINS:      32768
[    0.001068] ... CHAINHASH_SIZE:          16384
[    0.001098]  memory used by lock dependency info: 3695 kB
[    0.001098]  per task-struct memory footprint: 1152 bytes
[    0.001159] Calibrating delay loop... 594.73 BogoMIPS (lpj=2973696)
[    0.107971] pid_max: default: 4096 minimum: 301
[    0.108306] Security Framework initialized
[    0.108398] Mount-cache hash table entries: 512
[    0.167358] CPU: Testing write buffer coherency: ok
[    0.168914] Setting up static identity map for 0x805650f8 - 0x80565150
[    0.174591] devtmpfs: initialized
[    0.179748] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.252075] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.254119] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.281341] omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
[    0.283538] omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
[    0.351043] pinctrl core: initialized pinctrl subsystem
[    0.354339] regulator-dummy: no parameters
[    0.356475] NET: Registered protocol family 16
[    0.357208] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.359466] cpuidle: using governor ladder
[    0.359497] cpuidle: using governor menu
[    0.365661] Reprogramming SDRC clock to 400000000 Hz
[    0.372924] omap_gpio 48310000.gpio: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_gpio1_pins, deferring probe
[    0.372985] platform 48310000.gpio: Driver omap_gpio requests probe deferral
[    0.376647] OMAP GPIO hardware version 2.5
[    0.380523] omap_gpio 49054000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_gpio4_pins, deferring probe
[    0.380554] platform 49054000.gpio: Driver omap_gpio requests probe deferral
[    0.381286] omap_gpio 49056000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_gpio5_pins, deferring probe
[    0.381317] platform 49056000.gpio: Driver omap_gpio requests probe deferral
[    0.381988] omap_gpio 49058000.gpio: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb1_pins, deferring probe
[    0.382049] platform 49058000.gpio: Driver omap_gpio requests probe deferral
[    0.393676] platform 49022000.mcbsp: alias fck already exists
[    0.394683] platform 49024000.mcbsp: alias fck already exists
[    0.406311] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.406677] gpmc_probe_nand_child: ti,elm-id property not found
[    0.406921] gpmc_read_settings_dt: page/burst-length set but not used!
[    0.406951] gpmc_read_settings_dt: read/write wait monitoring not enabled!
[    0.408020] irq: no irq domain found for /ocp/gpio@49056000 !
[    0.408050] ------------[ cut here ]------------
[    0.408081] WARNING: CPU: 0 PID: 1 at linux/drivers/of/platform.c:171 of_device_alloc+0x158/0x168()
[    0.408081] Modules linked in:
[    0.408111] CPU: 0 PID: 1 Comm: swapper Not tainted 3.14.0-rc2+ #856
[    0.408172] [<c0012fc4>] (unwind_backtrace) from [<c0010e30>] (show_stack+0x10/0x14)
[    0.408203] [<c0010e30>] (show_stack) from [<c003455c>] (warn_slowpath_common+0x64/0x84)
[    0.408203] [<c003455c>] (warn_slowpath_common) from [<c0034598>] (warn_slowpath_null+0x1c/0x24)
[    0.408233] [<c0034598>] (warn_slowpath_null) from [<c03e61d0>] (of_device_alloc+0x158/0x168)
[    0.408264] [<c03e61d0>] (of_device_alloc) from [<c03e6210>] (of_platform_device_create_pdata+0x30/0x9c)
[    0.408294] [<c03e6210>] (of_platform_device_create_pdata) from [<c001f0f4>] (gpmc_probe_generic_child+0xa4/0x2ac)
[    0.408325] [<c001f0f4>] (gpmc_probe_generic_child) from [<c001f6fc>] (gpmc_probe+0x400/0x7b0)
[    0.408325] [<c001f6fc>] (gpmc_probe) from [<c030312c>] (platform_drv_probe+0x18/0x48)
[    0.408386] [<c030312c>] (platform_drv_probe) from [<c0301d80>] (driver_probe_device+0x110/0x230)
[    0.408386] [<c0301d80>] (driver_probe_device) from [<c0300494>] (bus_for_each_drv+0x44/0x8c)
[    0.408416] [<c0300494>] (bus_for_each_drv) from [<c0301c38>] (device_attach+0x74/0x8c)
[    0.408447] [<c0301c38>] (device_attach) from [<c030132c>] (bus_probe_device+0x88/0xac)
[    0.408477] [<c030132c>] (bus_probe_device) from [<c02ff930>] (device_add+0x3e8/0x4f0)
[    0.408508] [<c02ff930>] (device_add) from [<c03e624c>] (of_platform_device_create_pdata+0x6c/0x9c)
[    0.408508] [<c03e624c>] (of_platform_device_create_pdata) from [<c03e634c>] (of_platform_bus_create+0xd0/0x29c)
[    0.408538] [<c03e634c>] (of_platform_bus_create) from [<c03e6398>] (of_platform_bus_create+0x11c/0x29c)
[    0.408569] [<c03e6398>] (of_platform_bus_create) from [<c03e6574>] (of_platform_populate+0x5c/0x9c)
[    0.408599] [<c03e6574>] (of_platform_populate) from [<c0771570>] (pdata_quirks_init+0x34/0x44)
[    0.408599] [<c0771570>] (pdata_quirks_init) from [<c0766f38>] (customize_machine+0x1c/0x40)
[    0.408630] [<c0766f38>] (customize_machine) from [<c000883c>] (do_one_initcall+0xe4/0x144)
[    0.408660] [<c000883c>] (do_one_initcall) from [<c0765af8>] (kernel_init_freeable+0xe8/0x1b0)
[    0.408691] [<c0765af8>] (kernel_init_freeable) from [<c05590f0>] (kernel_init+0x8/0xec)
[    0.408721] [<c05590f0>] (kernel_init) from [<c000e4c8>] (ret_from_fork+0x14/0x2c)
[    0.408905] ---[ end trace 2067aff632ad5d0c ]---
[    0.409851] irq: no irq domain found for /ocp/gpio@49054000 !
[    0.409851] ------------[ cut here ]------------
[    0.409881] WARNING: CPU: 0 PID: 1 at linux/drivers/of/platform.c:171 of_device_alloc+0x158/0x168()
[    0.409912] Modules linked in:
[    0.409942] CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.14.0-rc2+ #856
[    0.409973] [<c0012fc4>] (unwind_backtrace) from [<c0010e30>] (show_stack+0x10/0x14)
[    0.409973] [<c0010e30>] (show_stack) from [<c003455c>] (warn_slowpath_common+0x64/0x84)
[    0.410003] [<c003455c>] (warn_slowpath_common) from [<c0034598>] (warn_slowpath_null+0x1c/0x24)
[    0.410034] [<c0034598>] (warn_slowpath_null) from [<c03e61d0>] (of_device_alloc+0x158/0x168)
[    0.410064] [<c03e61d0>] (of_device_alloc) from [<c03e6210>] (of_platform_device_create_pdata+0x30/0x9c)
[    0.410095] [<c03e6210>] (of_platform_device_create_pdata) from [<c001f0f4>] (gpmc_probe_generic_child+0xa4/0x2ac)
[    0.410095] [<c001f0f4>] (gpmc_probe_generic_child) from [<c001f6fc>] (gpmc_probe+0x400/0x7b0)
[    0.410125] [<c001f6fc>] (gpmc_probe) from [<c030312c>] (platform_drv_probe+0x18/0x48)
[    0.410156] [<c030312c>] (platform_drv_probe) from [<c0301d80>] (driver_probe_device+0x110/0x230)
[    0.410186] [<c0301d80>] (driver_probe_device) from [<c0300494>] (bus_for_each_drv+0x44/0x8c)
[    0.410217] [<c0300494>] (bus_for_each_drv) from [<c0301c38>] (device_attach+0x74/0x8c)
[    0.410217] [<c0301c38>] (device_attach) from [<c030132c>] (bus_probe_device+0x88/0xac)
[    0.410247] [<c030132c>] (bus_probe_device) from [<c02ff930>] (device_add+0x3e8/0x4f0)
[    0.410278] [<c02ff930>] (device_add) from [<c03e624c>] (of_platform_device_create_pdata+0x6c/0x9c)
[    0.410308] [<c03e624c>] (of_platform_device_create_pdata) from [<c03e634c>] (of_platform_bus_create+0xd0/0x29c)
[    0.410308] [<c03e634c>] (of_platform_bus_create) from [<c03e6398>] (of_platform_bus_create+0x11c/0x29c)
[    0.410339] [<c03e6398>] (of_platform_bus_create) from [<c03e6574>] (of_platform_populate+0x5c/0x9c)
[    0.410369] [<c03e6574>] (of_platform_populate) from [<c0771570>] (pdata_quirks_init+0x34/0x44)
[    0.410400] [<c0771570>] (pdata_quirks_init) from [<c0766f38>] (customize_machine+0x1c/0x40)
[    0.410400] [<c0766f38>] (customize_machine) from [<c000883c>] (do_one_initcall+0xe4/0x144)
[    0.410430] [<c000883c>] (do_one_initcall) from [<c0765af8>] (kernel_init_freeable+0xe8/0x1b0)
[    0.410461] [<c0765af8>] (kernel_init_freeable) from [<c05590f0>] (kernel_init+0x8/0xec)
[    0.410491] [<c05590f0>] (kernel_init) from [<c000e4c8>] (ret_from_fork+0x14/0x2c)
[    0.410491] ---[ end trace 2067aff632ad5d0d ]---
[    0.413391] omap3_dbb056_legacy_init: Late Reparent clkout2 to 96M_FCK
[    0.413421] omap3_dbb056_legacy_init: Set clkout2 to 24MHz for internal usb hub
[    0.416900] No ATAGs?
[    0.416931] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.420379] OMAP DMA hardware revision 5.0
[    0.442382] bio: create slab <bio-0> at 0
[    0.486419] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    0.488128] VCC3: 3300 mV
[    0.490509] SCSI subsystem initialized
[    0.491394] usbcore: registered new interface driver usbfs
[    0.491577] usbcore: registered new interface driver hub
[    0.492004] usbcore: registered new device driver usb
[    0.494323] musb-omap2430 480ab000.usb_otg_hs: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb_otg_pins, deferring probe
[    0.494354] platform 480ab000.usb_otg_hs: Driver musb-omap2430 requests probe deferral
[    0.495086] omap_i2c 48070000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c1_pins, deferring probe
[    0.495147] platform 48070000.i2c: Driver omap_i2c requests probe deferral
[    0.495239] omap_i2c 48072000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c2_pins, deferring probe
[    0.495269] platform 48072000.i2c: Driver omap_i2c requests probe deferral
[    0.495361] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/pinmux@48002030/pinmux_i2c3_pins, deferring probe
[    0.495391] platform 48060000.i2c: Driver omap_i2c requests probe deferral
[    0.495788] pps_core: LinuxPPS API ver. 1 registered
[    0.495788] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.495849] PTP clock support registered
[    0.497070] Advanced Linux Sound Architecture Driver Initialized.
[    0.501129] cfg80211: Calling CRDA to update world regulatory domain
[    0.501861] Switched to clocksource 32k_counter
[    0.536651] NET: Registered protocol family 2
[    0.538818] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.539031] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    0.539581] TCP: Hash tables configured (established 1024 bind 1024)
[    0.539825] TCP: reno registered
[    0.539855] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    0.540008] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    0.541473] NET: Registered protocol family 1
[    0.543060] RPC: Registered named UNIX socket transport module.
[    0.543090] RPC: Registered udp transport module.
[    0.543090] RPC: Registered tcp transport module.
[    0.543121] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.543640] usbhs_omap 48064000.usbhshost: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_hsusb1_2_pins, deferring probe
[    0.543701] platform 48064000.usbhshost: Driver usbhs_omap requests probe deferral
[    0.544738] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    0.551605] futex hash table entries: 16 (order: -3, 640 bytes)
[    0.555389] VFS: Disk quotas dquot_6.5.2
[    0.555480] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.557891] NFS: Registering the id_resolver key type
[    0.558349] Key type id_resolver registered
[    0.558380] Key type id_legacy registered
[    0.558532] fuse init (API version 7.22)
[    0.559967] msgmni has been set to 224
[    0.565155] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.565277] io scheduler noop registered
[    0.565307] io scheduler deadline registered
[    0.565368] io scheduler cfq registered (default)
[    0.573059] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    0.574462] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    0.576599] pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
[    0.579772] OMAP DSS rev 2.0
[    0.581298] platform panel-dpi.0: Driver panel-dpi requests probe deferral
[    0.584259] omapfb omapfb: no displays
[    0.586761] omapfb omapfb: failed to setup omapfb
[    0.586791] platform omapfb: Driver omapfb requests probe deferral
[    0.587677] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.596679] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
[    2.001129] console [ttyO0] enabled
[    2.007598] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    2.019805] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    2.054382] brd: module loaded
[    2.070831] loop: module loaded
[    2.077209] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.085540] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xbc
[    2.092285] nand: Micron NAND 512MiB 1,8V 16-bit
[    2.097106] nand: 512MiB, SLC, page size: 2048, OOB size: 64
[    2.103088] nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
[    2.111755] 5 ofpart partitions found on MTD device omap2-nand.0
[    2.118133] Creating 5 MTD partitions on "omap2-nand.0":
[    2.123779] 0x000000000000-0x000000080000 : "MLO"
[    2.135009] 0x000000080000-0x000000260000 : "u-boot"
[    2.145141] 0x000000260000-0x000000280000 : "u-boot-environment"
[    2.154785] 0x000000280000-0x000000780000 : "kernel"
[    2.167388] 0x000000780000-0x000010000000 : "filesystem"
[    2.391906] irq: no irq domain found for /ocp/gpio@48310000 !
[    2.404235] CAN device driver interface
[    2.408294] sja1000 CAN netdevice driver
[    2.414245] smsc911x: Driver version 2008-10-21
[    2.418975] smsc911x: Could not allocate irq resource
[    2.424926] smsc911x: Driver version 2008-10-21
[    2.429656] smsc911x: Could not allocate irq resource
[    2.435302] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.442230] ehci-omap: OMAP-EHCI Host Controller driver
[    2.448120] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.454803] ohci-omap3: OHCI OMAP3 driver
[    2.459625] usbcore: registered new interface driver usb-storage
[    2.468322] mousedev: PS/2 mouse device common for all mice
[    2.475463] ads7846: probe of spi2.0 failed with error -22
[    2.482330] i2c /dev entries driver
[    2.488983] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.498291] platform 4809c000.mmc: Driver omap_hsmmc requests probe deferral
[    2.506469] platform 480b4000.mmc: Driver omap_hsmmc requests probe deferral
[    2.514709] platform leds.3: Driver leds-gpio requests probe deferral
[    2.522674] usbcore: registered new interface driver usbhid
[    2.528503] usbhid: USB HID core driver
[    2.544219] omap-twl4030 sound.4: ASoC: CODEC twl4030-codec not registered
[    2.551727] omap-twl4030 sound.4: devm_snd_soc_register_card() failed: -517
[    2.560516] platform sound.4: Driver omap-twl4030 requests probe deferral
[    2.568359] TCP: cubic registered
[    2.571838] Initializing XFRM netlink socket
[    2.576721] NET: Registered protocol family 17
[    2.581481] NET: Registered protocol family 15
[    2.586273] can: controller area network core (rev 20120528 abi 9)
[    2.592987] NET: Registered protocol family 29
[    2.597656] can: raw protocol (rev 20120528)
[    2.602355] can: broadcast manager protocol (rev 20120528 t)
[    2.608306] can: netlink gateway (rev 20130117) max_hops=1
[    2.614654] Key type dns_resolver registered
[    2.622222] ThumbEE CPU extension supported.
[    2.626770] Registering SWP/SWPB emulation handler
[    2.633422] registered taskstats version 1
[    2.654754] musb-omap2430 480ab000.usb_otg_hs: unable to find phy
[    2.661224] HS USB OTG: no transceiver configured
[    2.666381] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
[    2.674652] platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
[    2.698242] twl 0-0048: PIH (irq 23) chaining IRQs 338..346
[    2.704803] twl 0-0048: power (irq 343) chaining IRQs 346..353
[    2.715057] twl_rtc rtc.8: Power up reset detected.
[    2.720367] twl_rtc rtc.8: Enabling TWL-RTC
[    2.729705] twl_rtc rtc.8: rtc core: registered rtc.8 as rtc0
[    2.741180] VAUX1: at 3000 mV
[    2.747283] VAUX2_4030: 2800 mV
[    2.752990] VAUX3: at 2800 mV
[    2.758209] VAUX4: at 2800 mV
[    2.763671] VDD1: 600 <--> 1450 mV at 1200 mV
[    2.770507] VDAC: 1800 mV
[    2.775787] VIO: at 1800 mV
[    2.780944] VINTANA1: 1500 mV
[    2.786468] VINTANA2: at 2750 mV
[    2.792266] VINTDIG: 1500 mV
[    2.797485] VMMC1: 1850 <--> 3150 mV at 3000 mV
[    2.804473] VMMC2: 1850 <--> 3150 mV at 2600 mV
[    2.811157] VUSB1V5: 1500 mV
[    2.816070] VUSB1V8: 1800 mV
[    2.820800] VUSB3V1: 3100 mV
[    2.826171] VPLL1: at 1800 mV
[    2.831604] VPLL2: 1800 mV
[    2.836639] VSIM: 1800 <--> 3000 mV at 1800 mV
[    2.844085] twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs 354..371
[    2.857788] twl4030_usb twl4030-usb.29: Initialized TWL4030 USB module
[    2.869354] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    2.877777] omap_i2c 48072000.i2c: bus 1 rev4.4 at 2600 kHz
[    2.890533] omap_i2c 48060000.i2c: bus 2 rev4.4 at 2600 kHz
[    2.899658] omapdss_dpi.0 supply vdds_dsi not found, using dummy regulator
[    2.918701] Console: switching to colour frame buffer device 80x30
[    2.933471] omapfb omapfb: using display 'lcd' mode 640x480
[    2.942535] 4809c000.mmc supply vmmc_aux not found, using dummy regulator
[    2.995971] 480b4000.mmc supply vmmc_aux not found, using dummy regulator
[    3.004150] VMMC1: Restricting voltage, 3100000-1950000uV
[    3.009826] omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
[    3.143157] omap-twl4030 sound.4: twl4030-hifi <-> 49022000.mcbsp mapping ok
[    3.179931] unable to find transceiver
[    3.183959] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    3.190765] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
[    3.200500] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.207702] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.215301] usb usb1: Product: MUSB HDRC host driver
[    3.220520] usb usb1: Manufacturer: Linux 3.14.0-rc2+ musb-hcd
[    3.226654] usb usb1: SerialNumber: musb-hdrc.0.auto
[    3.236572] hub 1-0:1.0: USB hub found
[    3.240997] hub 1-0:1.0: 1 port detected
[    3.277343] twl_rtc rtc.8: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[   15.472961] ALSA device list:
[   15.476104]   #0: lilly-a83x
[   15.480895] omap_uart 4806a000.serial: no wakeirq for uart0
[   15.487518] Root-NFS: no NFS server address
[   15.491912] VFS: Unable to mount root fs via NFS, trying floppy.
[   15.499755] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
[   15.507476] Please append a correct "root=" boot option; here are the available partitions:
[   15.516479] 1f00             512 mtdblock0  (driver?)
[   15.521789] 1f01            1920 mtdblock1  (driver?)
[   15.527221] 1f02             128 mtdblock2  (driver?)
[   15.532653] 1f03            5120 mtdblock3  (driver?)
[   15.537963] 1f04          254464 mtdblock4  (driver?)
[   15.543518] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)

-- 
1.7.10.4

