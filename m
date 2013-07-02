From: Ambresh K <ambresh@ti.com>
Subject: [3.10] [AM335x-EVMSK] BUG: spinlock bad magic on CPU#0
Date: Tue, 2 Jul 2013 17:53:41 +0530
Message-ID: <51D2C64D.5000500@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070906060101080109080007"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38626 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab3GBMYG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 08:24:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap <linux-omap@vger.kernel.org>

--------------070906060101080109080007
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi, 
While booting 3.10 on AM355x-evmsk with following steps seeing race condition leading to SPIN BUG:
Attached  log for reference.

Config: omap2plus_defconfig. 
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- uImage -j 8 LOADADDR=0x80008000
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- am335x-evmsk.dtb
cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-evmsk.dtb > zImage
mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d zImage uImage  


[    2.359689] cpsw: platform data missing
[    2.364835] BUG: spinlock bad magic on CPU#0, swapper/0/1
[    2.370537]  lock: 0xce11021c, .magic: 00000000, .owner: /0, .owner_cpu: 3
[    2.377767] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-dirty #10
[    2.384662] [<c001bf38>] (unwind_backtrace+0x0/0xf4) from [<c0018650>] (show_stack+0x10/0x14)
[    2.393639] [<c0018650>] (show_stack+0x10/0x14) from [<c02ec380>] (do_raw_spin_lock+0x1b8/0x1f8)
[    2.402896] [<c02ec380>] (do_raw_spin_lock+0x1b8/0x1f8) from [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58)
[    2.413243] [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c035d3d0>] (devres_remove+0x20/0x80)
[    2.423125] [<c035d3d0>] (devres_remove+0x20/0x80) from [<c035d440>] (devres_release+0x10/0x38)
[    2.432273] [<c035d440>] (devres_release+0x10/0x38) from [<c02fa718>] (devm_pinctrl_put+0x18/0x40)
[    2.441699] [<c02fa718>] (devm_pinctrl_put+0x18/0x40) from [<c0370470>] (pinctrl_bind_pins+0x84/0xb8)
[    2.451397] [<c0370470>] (pinctrl_bind_pins+0x84/0xb8) from [<c035a588>] (driver_probe_device+0x60/0x224)
[    2.461462] [<c035a588>] (driver_probe_device+0x60/0x224) from [<c035a7e0>] (__driver_attach+0x94/0x98)
[    2.471343] [<c035a7e0>] (__driver_attach+0x94/0x98) from [<c0358dd0>] (bus_for_each_dev+0x68/0x8c)
[    2.480857] [<c0358dd0>] (bus_for_each_dev+0x68/0x8c) from [<c0359714>] (bus_add_driver+0x208/0x2a4)
[    2.490462] [<c0359714>] (bus_add_driver+0x208/0x2a4) from [<c035adb4>] (driver_register+0x78/0x194)
[    2.500067] [<c035adb4>] (driver_register+0x78/0x194) from [<c0008684>] (do_one_initcall+0x30/0x168)
[    2.509682] [<c0008684>] (do_one_initcall+0x30/0x168) from [<c075c308>] (kernel_init_freeable+0xf4/0x1c0)
[    2.519745] [<c075c308>] (kernel_init_freeable+0xf4/0x1c0) from [<c05454cc>] (kernel_init+0x8/0xe4)
[    2.529268] [<c05454cc>] (kernel_init+0x8/0xe4) from [<c00142e8>] (ret_from_fork+0x14/0x2c)
[   11.974206] BUG: spinlock lockup suspected on CPU#0, swapper/0/1
[   11.980519]  lock: 0xce11021c, .magic: 00000000, .owner: /0, .owner_cpu: 3
[   11.987744] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-dirty #10
[   11.994612] [<c001bf38>] (unwind_backtrace+0x0/0xf4) from [<c0018650>] (show_stack+0x10/0x14)
[   12.003577] [<c0018650>] (show_stack+0x10/0x14) from [<c02ec338>] (do_raw_spin_lock+0x170/0x1f8)
[   12.012818] [<c02ec338>] (do_raw_spin_lock+0x170/0x1f8) from [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58)
[   12.023155] [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c035d3d0>] (devres_remove+0x20/0x80)
[   12.033033] [<c035d3d0>] (devres_remove+0x20/0x80) from [<c035d440>] (devres_release+0x10/0x38)
[   12.042179] [<c035d440>] (devres_release+0x10/0x38) from [<c02fa718>] (devm_pinctrl_put+0x18/0x40)
[   12.051600] [<c02fa718>] (devm_pinctrl_put+0x18/0x40) from [<c0370470>] (pinctrl_bind_pins+0x84/0xb8)
[   12.061294] [<c0370470>] (pinctrl_bind_pins+0x84/0xb8) from [<c035a588>] (driver_probe_device+0x60/0x224)
[   12.071352] [<c035a588>] (driver_probe_device+0x60/0x224) from [<c035a7e0>] (__driver_attach+0x94/0x98)
[   12.081228] [<c035a7e0>] (__driver_attach+0x94/0x98) from [<c0358dd0>] (bus_for_each_dev+0x68/0x8c)
[   12.090738] [<c0358dd0>] (bus_for_each_dev+0x68/0x8c) from [<c0359714>] (bus_add_driver+0x208/0x2a4)
[   12.100339] [<c0359714>] (bus_add_driver+0x208/0x2a4) from [<c035adb4>] (driver_register+0x78/0x194)
[   12.109940] [<c035adb4>] (driver_register+0x78/0x194) from [<c0008684>] (do_one_initcall+0x30/0x168)
[   12.119545] [<c0008684>] (do_one_initcall+0x30/0x168) from [<c075c308>] (kernel_init_freeable+0xf4/0x1c0)
[   12.129602] [<c075c308>] (kernel_init_freeable+0xf4/0x1c0) from [<c05454cc>] (kernel_init+0x8/0xe4)
[   12.139112] [<c05454cc>] (kernel_init+0x8/0xe4) from [<c00142e8>] (ret_from_fork+0x14/0x2c)

Regards,
Ambresh

--------------070906060101080109080007
Content-Type: text/plain; charset="UTF-8"; name="log.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="log.txt"

U-Boot 2012.10 (Jul 02 2013 - 10:41:19)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0 
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0 
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  0 
U-Boot# 
U-Boot# 
U-Boot# 
U-Boot# 
U-Boot# setenv bootargs console=ttyO0,115200n8 root=/dev/ram0 rw ramdisk_size=64413 initrd=0x81600000,64M no_console_suspend
U-Boot# fatload mmc 0 0x81600000 ramdisk-pm.gz; fatload mmc 0 0x80300000 uimage; bootm 0x80300000
reading ramdisk-pm.gz

2022580 bytes read
reading uimage

4390952 bytes read
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4390888 Bytes = 4.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.10.0-dirty (a0393775@ula0393775) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #10 SMP Tue Jul 2 17:19:30 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x EVM-SK
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES2.1 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0fc8000 s13632 r8192 d15040 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/ram0 rw ramdisk_size=64413 initrd=0x81600000,64M no_console_suspend
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 162768k/162768k available, 99376k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc075b260   (7501 kB)
[    0.000000]       .init : 0xc075c000 - 0xc07be540   ( 394 kB)
[    0.000000]       .data : 0xc07c0000 - 0xc0856408   ( 602 kB)
[    0.000000]        .bss : 0xc0856408 - 0xc0dba8e0   (5522 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] OMAP clocksource: timer1 at 24000000 Hz
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
[    0.001046] Calibrating delay loop... 476.77 BogoMIPS (lpj=2383872)
[    0.119668] pid_max: default: 32768 minimum: 301
[    0.120181] Security Framework initialized
[    0.120341] Mount-cache hash table entries: 512
[    0.131989] CPU: Testing write buffer coherency: ok
[    0.133549] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.133633] Setting up static identity map for 0xc0554688 - 0xc05546f8
[    0.136755] Brought up 1 CPUs
[    0.136780] SMP: Total of 1 processors activated (476.77 BogoMIPS).
[    0.136792] CPU: All CPU(s) started in SVC mode.
[    0.140055] devtmpfs: initialized
[    0.214310] pinctrl core: initialized pinctrl subsystem
[    0.218999] regulator-dummy: no parameters
[    0.222983] NET: Registered protocol family 16
[    0.231414] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.254858] OMAP GPIO hardware version 0.1
[    0.279489] No ATAGs?
[    0.279520] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.346184] bio: create slab <bio-0> at 0
[    0.351901] vbat: 5000 mV 
[    0.353124] lis3_reg: no parameters
[    0.360906] SCSI subsystem initialized
[    0.363224] usbcore: registered new interface driver usbfs
[    0.363722] usbcore: registered new interface driver hub
[    0.364567] usbcore: registered new device driver usb
[    0.366632] omap_i2c 44e0b000.i2c: did not get pins for i2c error: -19
[    0.368841] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.371673] tps65910 0-002d: No interrupt support, no core IRQ
[    0.377529] vrtc: 1800 mV 
[    0.377955] vrtc: supplied by vbat
[    0.381841] vio: at 1500 mV 
[    0.382002] vio: supplied by vbat
[    0.385095] vdd_mpu: 912 <--> 1312 mV at 1262 mV 
[    0.385249] vdd_mpu: supplied by vbat
[    0.388273] vdd_core: 912 <--> 1150 mV at 1137 mV 
[    0.388420] vdd_core: supplied by vbat
[    0.391229] vdd3: 5000 mV 
[    0.393699] vdig1: at 1800 mV 
[    0.393843] vdig1: supplied by vbat
[    0.396566] vdig2: at 1800 mV 
[    0.396705] vdig2: supplied by vbat
[    0.399416] vpll: at 1800 mV 
[    0.399553] vpll: supplied by vbat
[    0.402455] vdac: at 1800 mV 
[    0.402618] vdac: supplied by vbat
[    0.405242] vaux1: at 1800 mV 
[    0.405382] vaux1: supplied by vbat
[    0.408105] vaux2: at 3300 mV 
[    0.408271] vaux2: supplied by vbat
[    0.411267] vaux33: at 3300 mV 
[    0.411415] vaux33: supplied by vbat
[    0.414092] vmmc: at 3300 mV 
[    0.414254] vmmc: supplied by vbat
[    0.426233] Switching to clocksource timer1
[    0.568841] NET: Registered protocol family 2
[    0.571034] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.571258] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.572213] TCP: Hash tables configured (established 2048 bind 2048)
[    0.572436] TCP: reno registered
[    0.572475] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.572738] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.574107] NET: Registered protocol family 1
[    0.575708] RPC: Registered named UNIX socket transport module.
[    0.575733] RPC: Registered udp transport module.
[    0.575746] RPC: Registered tcp transport module.
[    0.575758] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.577019] Trying to unpack rootfs image as initramfs...
[    0.579171] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    1.021655] Freeing initrd memory: 65536K (c1600000 - c5600000)
[    1.021842] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.219409] VFS: Disk quotas dquot_6.5.2
[    1.219665] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.222489] NFS: Registering the id_resolver key type
[    1.222980] Key type id_resolver registered
[    1.223003] Key type id_legacy registered
[    1.223156] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    1.223756] msgmni has been set to 477
[    1.227535] io scheduler noop registered
[    1.227562] io scheduler deadline registered
[    1.227666] io scheduler cfq registered (default)
[    1.229234] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.233961] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.241344] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    1.242262] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.948967] console [ttyO0] enabled
[    1.987501] brd: module loaded
[    2.012066] loop: module loaded
[    2.021427] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.035971] usbcore: registered new interface driver asix
[    2.042657] usbcore: registered new interface driver ax88179_178a
[    2.051197] usbcore: registered new interface driver cdc_ether
[    2.058131] usbcore: registered new interface driver smsc95xx
[    2.064644] usbcore: registered new interface driver net1080
[    2.071323] usbcore: registered new interface driver cdc_subset
[    2.078228] usbcore: registered new interface driver zaurus
[    2.084675] usbcore: registered new interface driver cdc_ncm
[    2.093084] usbcore: registered new interface driver cdc_wdm
[    2.099788] usbcore: registered new interface driver usb-storage
[    2.106758] usbcore: registered new interface driver usbtest
[    2.115100] mousedev: PS/2 mouse device common for all mice
[    2.127933] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc as rtc0
[    2.135460] 44e3e000.rtc: already running
[    2.141107] i2c /dev entries driver
[    2.147561] Driver for 1-wire Dallas network protocol.
[    2.158055] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.169434] leds-gpio leds.5: pins are not configured from the driver
[    2.182533] ledtrig-cpu: registered to indicate activity on CPUs
[    2.190918] usbcore: registered new interface driver usbhid
[    2.196941] usbhid: USB HID core driver
[    2.202582] oprofile: no performance counters
[    2.209988] oprofile: using timer interrupt.
[    2.215285] TCP: cubic registered
[    2.218980] Initializing XFRM netlink socket
[    2.223692] NET: Registered protocol family 17
[    2.228531] NET: Registered protocol family 15
[    2.233631] Key type dns_resolver registered
[    2.238346] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.246518] ThumbEE CPU extension supported.
[    2.316768] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.323207] davinci_mdio 4a101000.mdio: detected phy mask fffffffc
[    2.333722] libphy: 4a101000.mdio: probed
[    2.338091] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver unknown
[    2.346510] davinci_mdio 4a101000.mdio: phy[1]: device 4a101000.mdio:01, driver unknown
[    2.355135] Missing slave[0] phy_id property
[    2.359689] cpsw: platform data missing
[    2.364835] BUG: spinlock bad magic on CPU#0, swapper/0/1
[    2.370537]  lock: 0xce11021c, .magic: 00000000, .owner: /0, .owner_cpu: 3
[    2.377767] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-dirty #10
[    2.384662] [<c001bf38>] (unwind_backtrace+0x0/0xf4) from [<c0018650>] (show_stack+0x10/0x14)
[    2.393639] [<c0018650>] (show_stack+0x10/0x14) from [<c02ec380>] (do_raw_spin_lock+0x1b8/0x1f8)
[    2.402896] [<c02ec380>] (do_raw_spin_lock+0x1b8/0x1f8) from [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58)
[    2.413243] [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c035d3d0>] (devres_remove+0x20/0x80)
[    2.423125] [<c035d3d0>] (devres_remove+0x20/0x80) from [<c035d440>] (devres_release+0x10/0x38)
[    2.432273] [<c035d440>] (devres_release+0x10/0x38) from [<c02fa718>] (devm_pinctrl_put+0x18/0x40)
[    2.441699] [<c02fa718>] (devm_pinctrl_put+0x18/0x40) from [<c0370470>] (pinctrl_bind_pins+0x84/0xb8)
[    2.451397] [<c0370470>] (pinctrl_bind_pins+0x84/0xb8) from [<c035a588>] (driver_probe_device+0x60/0x224)
[    2.461462] [<c035a588>] (driver_probe_device+0x60/0x224) from [<c035a7e0>] (__driver_attach+0x94/0x98)
[    2.471343] [<c035a7e0>] (__driver_attach+0x94/0x98) from [<c0358dd0>] (bus_for_each_dev+0x68/0x8c)
[    2.480857] [<c0358dd0>] (bus_for_each_dev+0x68/0x8c) from [<c0359714>] (bus_add_driver+0x208/0x2a4)
[    2.490462] [<c0359714>] (bus_add_driver+0x208/0x2a4) from [<c035adb4>] (driver_register+0x78/0x194)
[    2.500067] [<c035adb4>] (driver_register+0x78/0x194) from [<c0008684>] (do_one_initcall+0x30/0x168)
[    2.509682] [<c0008684>] (do_one_initcall+0x30/0x168) from [<c075c308>] (kernel_init_freeable+0xf4/0x1c0)
[    2.519745] [<c075c308>] (kernel_init_freeable+0xf4/0x1c0) from [<c05454cc>] (kernel_init+0x8/0xe4)
[    2.529268] [<c05454cc>] (kernel_init+0x8/0xe4) from [<c00142e8>] (ret_from_fork+0x14/0x2c)
[   11.974206] BUG: spinlock lockup suspected on CPU#0, swapper/0/1
[   11.980519]  lock: 0xce11021c, .magic: 00000000, .owner: /0, .owner_cpu: 3
[   11.987744] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-dirty #10
[   11.994612] [<c001bf38>] (unwind_backtrace+0x0/0xf4) from [<c0018650>] (show_stack+0x10/0x14)
[   12.003577] [<c0018650>] (show_stack+0x10/0x14) from [<c02ec338>] (do_raw_spin_lock+0x170/0x1f8)
[   12.012818] [<c02ec338>] (do_raw_spin_lock+0x170/0x1f8) from [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58)
[   12.023155] [<c054e7a8>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c035d3d0>] (devres_remove+0x20/0x80)
[   12.033033] [<c035d3d0>] (devres_remove+0x20/0x80) from [<c035d440>] (devres_release+0x10/0x38)
[   12.042179] [<c035d440>] (devres_release+0x10/0x38) from [<c02fa718>] (devm_pinctrl_put+0x18/0x40)
[   12.051600] [<c02fa718>] (devm_pinctrl_put+0x18/0x40) from [<c0370470>] (pinctrl_bind_pins+0x84/0xb8)
[   12.061294] [<c0370470>] (pinctrl_bind_pins+0x84/0xb8) from [<c035a588>] (driver_probe_device+0x60/0x224)
[   12.071352] [<c035a588>] (driver_probe_device+0x60/0x224) from [<c035a7e0>] (__driver_attach+0x94/0x98)
[   12.081228] [<c035a7e0>] (__driver_attach+0x94/0x98) from [<c0358dd0>] (bus_for_each_dev+0x68/0x8c)
[   12.090738] [<c0358dd0>] (bus_for_each_dev+0x68/0x8c) from [<c0359714>] (bus_add_driver+0x208/0x2a4)
[   12.100339] [<c0359714>] (bus_add_driver+0x208/0x2a4) from [<c035adb4>] (driver_register+0x78/0x194)
[   12.109940] [<c035adb4>] (driver_register+0x78/0x194) from [<c0008684>] (do_one_initcall+0x30/0x168)
[   12.119545] [<c0008684>] (do_one_initcall+0x30/0x168) from [<c075c308>] (kernel_init_freeable+0xf4/0x1c0)
[   12.129602] [<c075c308>] (kernel_init_freeable+0xf4/0x1c0) from [<c05454cc>] (kernel_init+0x8/0xe4)
[   12.139112] [<c05454cc>] (kernel_init+0x8/0xe4) from [<c00142e8>] (ret_from_fork+0x14/0x2c)



--------------070906060101080109080007--
