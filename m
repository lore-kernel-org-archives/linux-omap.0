From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.15-rc8
Date: Mon, 02 Jun 2014 11:45:47 +0300
Message-ID: <538C39BB.9020809@compulab.co.il>
References: <alpine.DEB.2.02.1406020749100.21503@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080308020107020906030006"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:43202 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbaFBIp4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jun 2014 04:45:56 -0400
In-Reply-To: <alpine.DEB.2.02.1406020749100.21503@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.infradead.org

This is a multi-part message in MIME format.
--------------080308020107020906030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

CM-T3517 is a bare-bone CoM without MMC/SD card slot (NAND option).
MMC/SD card interface (and some other peripherals) are properties of the 
carrier base board SB-T35, which turns this CoM into fully functional 
board SBC-T3517.

Please, use omap3-sbc-t3517.dtb target.

Attached Linux v3.15-rc8 boot log using omap2plus_defconfig.

On 06/02/2014 10:50 AM, Paul Walmsley wrote:
>
> Boot to userspace:
>      FAIL ( 2/13): 2430sdp, cmt3517
>      skip ( 2/13): 5912osk, 4460varsomom
>      Pass ( 9/13): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
> 		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
> 		  am335xbonelt
>
>

Regards,

Dmitry

--------------080308020107020906030006
Content-Type: text/plain; charset=UTF-8;
 name="sbc_t3517_log_mmc_boot.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="sbc_t3517_log_mmc_boot.txt"

U-Boot 2009.11-cm-t3517-1 (Dec 10 2010 - 23:25:02)

AM35xx-GP ES2.0, L3-165MHz
CM-T3517 Module + LPDDR/NAND 128/512M
I2C:   ready
DRAM:  256 MB
NAND:  512 MiB
In:    serial
Out:   serial
Err:   serial
PCB:   1.2
Die ID #7a64000100000000016b29c60d00c020
Net:   DaVinci EMAC, smc911x-0
Hit any key to stop autoboot:  0 
CM-T3517 # sete bootargs 'console=ttyO2,115200n8 debug ignore_loglevel earlyprintk root=/dev/mmcblk0p2 rootwait init=/bin/sh nohlt'
CM-T3517 # sete bootcmd 'tftp 0x82000000  uImage-cm-t3517_wdt.bin && bootm 0x82000000'
CM-T3517 # boot
Using DaVinci EMAC device
TFTP from server 192.168.11.10; our IP address is 192.168.6.204
Filename 'uImage-cm-t3517_wdt.bin'.
Load address: 0x82000000
Loading: #################################################################
	 #################################################################
	 ################################################T #################
	 #################################################################
	 #################################################################
	 ##########################################T #######################
	 #################################################################
	 ######T ###########################################################
	 ###################################T ##############################
	 ################################################################T #
	 #################################################################
	 #############################T ####################################
	 ##########################################################T #######
	 #################################################################
	 ######################
done
Bytes transferred = 4769379 (48c663 hex)
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4769315 Bytes =  4.5 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.15.0-rc8 (lifshitz@compulab.co.il) (gcc version 4.6.1 (Sourcery CodeBench Lite 2011.09-70) ) #4 SMP Mon Jun 2 11:19:33 IDT 2014
[    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine model: CompuLab SBC-T3517 with CM-T3517
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c092e8c0, node_mem_map cfcf2000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM3517 ES1.1 (l2cache sgx neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @cfcaf000 s14080 r8192 d14592 u36864
[    0.000000] pcpu-alloc: s14080 r8192 d14592 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO2,115200n8 debug ignore_loglevel earlyprintk root=/dev/mmcblk0p2 rootwait init=/bin/sh nohlt
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 227188K/261120K available (6111K kernel code, 664K rwdata, 2216K rodata, 393K init, 5522K bss, 33932K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0829e10   (8328 kB)
[    0.000000]       .init : 0xc082a000 - 0xc088c700   ( 394 kB)
[    0.000000]       .data : 0xc088e000 - 0xc09340c0   ( 665 kB)
[    0.000000]        .bss : 0xc09340c0 - 0xc0e98c48   (5523 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] OMAP clockevent source: timer2 at 13000000 Hz
[    0.000033] sched_clock: 32 bits at 13MHz, resolution 76ns, wraps every 330382100403ns
[    0.000144] OMAP clocksource: timer1 at 13000000 Hz
[    0.001575] Console: colour dummy device 80x30
[    0.001674] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001693] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001708] ... MAX_LOCK_DEPTH:          48
[    0.001722] ... MAX_LOCKDEP_KEYS:        8191
[    0.001736] ... CLASSHASH_SIZE:          4096
[    0.001750] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.001764] ... MAX_LOCKDEP_CHAINS:      32768
[    0.001777] ... CHAINHASH_SIZE:          16384
[    0.001792]  memory used by lock dependency info: 3695 kB
[    0.001806]  per task-struct memory footprint: 1152 bytes
[    0.001885] Calibrating delay loop... 594.73 BogoMIPS (lpj=2973696)
[    0.106203] pid_max: default: 32768 minimum: 301
[    0.106962] Security Framework initialized
[    0.107205] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.107234] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.111655] CPU: Testing write buffer coherency: ok
[    0.113814] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.113955] Setting up static identity map for 0x805c88c8 - 0x805c8938
[    0.120143] Brought up 1 CPUs
[    0.120176] SMP: Total of 1 processors activated.
[    0.120194] CPU: All CPU(s) started in SVC mode.
[    0.125353] devtmpfs: initialized
[    0.139166] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    0.213542] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.215672] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.294681] omap_hwmod: uart4: cannot be enabled for reset (3)
[    0.314698] pinctrl core: initialized pinctrl subsystem
[    0.319801] regulator-dummy: no parameters
[    0.418889] NET: Registered protocol family 16
[    0.429888] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.434387] In-band Error seen by USB_OTG  at address 0
[    0.434417] ------------[ cut here ]------------
[    0.434469] WARNING: CPU: 0 PID: 1 at /home/lifshitz/workroot/git-repo/linux-cm-t3x/drivers/bus/omap_l3_smx.c:162 omap3_l3_app_irq+0x100/0x128()
[    0.434487] Modules linked in:
[    0.434524] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc8 #4
[    0.434586] [<c001590c>] (unwind_backtrace) from [<c0012618>] (show_stack+0x10/0x14)
[    0.434625] [<c0012618>] (show_stack) from [<c05b9744>] (dump_stack+0x78/0x94)
[    0.434661] [<c05b9744>] (dump_stack) from [<c004323c>] (warn_slowpath_common+0x6c/0x8c)
[    0.434691] [<c004323c>] (warn_slowpath_common) from [<c0043278>] (warn_slowpath_null+0x1c/0x24)
[    0.434720] [<c0043278>] (warn_slowpath_null) from [<c0329ad4>] (omap3_l3_app_irq+0x100/0x128)
[    0.434760] [<c0329ad4>] (omap3_l3_app_irq) from [<c0095ddc>] (handle_irq_event_percpu+0x58/0x20c)
[    0.434789] [<c0095ddc>] (handle_irq_event_percpu) from [<c0095fcc>] (handle_irq_event+0x3c/0x5c)
[    0.434821] [<c0095fcc>] (handle_irq_event) from [<c0098838>] (handle_level_irq+0xac/0x148)
[    0.434849] [<c0098838>] (handle_level_irq) from [<c00956a8>] (generic_handle_irq+0x20/0x30)
[    0.434879] [<c00956a8>] (generic_handle_irq) from [<c000f53c>] (handle_IRQ+0x4c/0xac)
[    0.434906] [<c000f53c>] (handle_IRQ) from [<c0008600>] (omap3_intc_handle_irq+0x80/0x9c)
[    0.434933] [<c0008600>] (omap3_intc_handle_irq) from [<c05c2ba4>] (__irq_svc+0x44/0x5c)
[    0.434953] Exception stack(0xce055d68 to 0xce055db0)
[    0.434978] 5d60:                   00030b84 ce053070 00000000 ce052b00 60000153 ce005454
[    0.435002] 5d80: ce005454 00000021 0000001a ce005434 60000153 00000000 00000000 ce055db0
[    0.435021] 5da0: 00030b85 c05c25a0 20000153 ffffffff
[    0.435058] [<c05c2ba4>] (__irq_svc) from [<c05c25a0>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[    0.435089] [<c05c25a0>] (_raw_spin_unlock_irqrestore) from [<c0097670>] (__setup_irq+0x2d8/0x4c0)
[    0.435118] [<c0097670>] (__setup_irq) from [<c0097910>] (request_threaded_irq+0xb8/0x13c)
[    0.435154] [<c0097910>] (request_threaded_irq) from [<c085d88c>] (omap3_l3_probe+0x10c/0x16c)
[    0.435195] [<c085d88c>] (omap3_l3_probe) from [<c0397fd4>] (platform_drv_probe+0x18/0x48)
[    0.435225] [<c0397fd4>] (platform_drv_probe) from [<c03962c0>] (really_probe+0x78/0x218)
[    0.435254] [<c03962c0>] (really_probe) from [<c0396574>] (driver_probe_device+0x30/0x48)
[    0.435280] [<c0396574>] (driver_probe_device) from [<c0396620>] (__driver_attach+0x94/0x98)
[    0.435306] [<c0396620>] (__driver_attach) from [<c0394ca4>] (bus_for_each_dev+0x54/0x88)
[    0.435332] [<c0394ca4>] (bus_for_each_dev) from [<c0395ba8>] (bus_add_driver+0xdc/0x1d4)
[    0.435359] [<c0395ba8>] (bus_add_driver) from [<c0396c5c>] (driver_register+0x78/0xf4)
[    0.435386] [<c0396c5c>] (driver_register) from [<c0397818>] (platform_driver_probe+0x20/0xa4)
[    0.435415] [<c0397818>] (platform_driver_probe) from [<c00088b8>] (do_one_initcall+0x34/0x160)
[    0.435449] [<c00088b8>] (do_one_initcall) from [<c082abd4>] (do_basic_setup+0x90/0xc8)
[    0.435477] [<c082abd4>] (do_basic_setup) from [<c082ac80>] (kernel_init_freeable+0x74/0x110)
[    0.435510] [<c082ac80>] (kernel_init_freeable) from [<c05aaae4>] (kernel_init+0x8/0xe4)
[    0.435537] [<c05aaae4>] (kernel_init) from [<c000ec08>] (ret_from_fork+0x14/0x2c)
[    0.435803] ---[ end trace 06d1ca61a08dd8b8 ]---
[    0.448829] Reprogramming SDRC clock to 332000000 Hz
[    0.453158] platform 480c5000.aes: Cannot lookup hwmod 'aes'
[    0.464408] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.465960] OMAP GPIO hardware version 2.5
[    0.468276] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.471524] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.474778] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.478038] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.481191] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.496039] platform 480c3000.sham: Cannot lookup hwmod 'sham'
[    0.497128] platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
[    0.509289] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.512135] platform 480ab000.usb_otg_hs: Cannot lookup hwmod 'usb_otg_hs'
[    0.667512] No ATAGs?
[    0.667564] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.672304] OMAP DMA hardware revision 4.0
[    0.712718] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
[    0.712847] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
[    0.780155] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    0.781570] of_get_named_gpiod_flags: can't parse gpios property of node '/hsusb1_power_reg[0]'
[    0.782713] hsusb1_vbus: 3300 mV 
[    0.783396] of_get_named_gpiod_flags: can't parse gpios property of node '/hsusb2_power_reg[0]'
[    0.784100] hsusb2_vbus: 3300 mV 
[    0.784742] of_get_named_gpiod_flags: can't parse gpios property of node '/regulator-vmmc[0]'
[    0.785406] vmmc: 3300 mV 
[    0.786167] reg-fixed-voltage wl12xx_vmmc2.8: could not find pctldev for node /ocp/pinmux@48002a00/pinmux_wl12xx_wkup_pins, deferring probe
[    0.786360] platform wl12xx_vmmc2.8: Driver reg-fixed-voltage requests probe deferral
[    0.786604] of_get_named_gpiod_flags: can't parse gpios property of node '/wl12xx_vaux2[0]'
[    0.787360] vwl1271_vaux2: 1800 mV 
[    0.787989] of_get_named_gpiod_flags: can't parse gpios property of node '/regulator-vddvario-sb-t35[0]'
[    0.788641] vddvario: no parameters
[    0.789171] of_get_named_gpiod_flags: can't parse gpios property of node '/regulator-vdd33a-sb-t35[0]'
[    0.789808] vdd33a: no parameters
[    0.796762] SCSI subsystem initialized
[    0.798296] usbcore: registered new interface driver usbfs
[    0.798632] usbcore: registered new interface driver hub
[    0.799376] usbcore: registered new device driver usb
[    0.800027] usb_phy_gen_xceiv hsusb1_phy.5: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb1_phy_reset_pins, deferring probe
[    0.800097] platform hsusb1_phy.5: Driver usb_phy_gen_xceiv requests probe deferral
[    0.800234] usb_phy_gen_xceiv hsusb2_phy.6: could not find pctldev for node /ocp/pinmux@48002030/pinmux_hsusb2_phy_reset_pins, deferring probe
[    0.800286] platform hsusb2_phy.6: Driver usb_phy_gen_xceiv requests probe deferral
[    0.804125] omap_i2c 48070000.i2c: bus 0 rev3.3 at 400 kHz
[    0.806475] omap_i2c 48072000.i2c: bus 1 rev3.3 at 100 kHz
[    0.808303] omap_i2c 48060000.i2c: bus 2 rev3.3 at 400 kHz
[    0.816220] Switched to clocksource timer1
[    1.114162] NET: Registered protocol family 2
[    1.117580] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    1.117847] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    1.119015] TCP: Hash tables configured (established 2048 bind 2048)
[    1.119376] TCP: reno registered
[    1.119431] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.119760] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.121593] NET: Registered protocol family 1
[    1.125013] RPC: Registered named UNIX socket transport module.
[    1.125052] RPC: Registered udp transport module.
[    1.125073] RPC: Registered tcp transport module.
[    1.125091] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.127629] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    1.137137] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.378968] VFS: Disk quotas dquot_6.5.2
[    1.379206] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.382752] NFS: Registering the id_resolver key type
[    1.383492] Key type id_resolver registered
[    1.383529] Key type id_legacy registered
[    1.383737] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    1.384583] msgmni has been set to 475
[    1.395561] io scheduler noop registered
[    1.395603] io scheduler deadline registered
[    1.395751] io scheduler cfq registered (default)
[    1.401578] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    1.402477] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    1.407239] pbias_mmc_omap2430: 1800 <--> 3000 mV at 3000 mV 
[    1.409639] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.423830] omap_uart 4806a000.serial: no wakeirq for uart0
[    1.423896] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@4806a000[0]'
[    1.427808] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
[    1.431028] omap_uart 4806c000.serial: no wakeirq for uart0
[    1.431087] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@4806c000[0]'
[    1.432632] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    1.434973] omap_uart 49020000.serial: no wakeirq for uart0
[    1.435029] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/serial@49020000[0]'
[    1.437090] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    2.756411] console [ttyO2] enabled
[    2.815596] brd: module loaded
[    2.849957] loop: module loaded
[    2.858675] mtdoops: mtd device (mtddev=name/number) must be supplied
[    3.064914] libphy: smsc911x-mdio: probed
[    3.146917] smsc911x 2d000000.ethernet eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=2d000000.etherne:01, irq=-1)
[    3.159520] smsc911x 2d000000.ethernet eth0: MAC Address: 36:94:5b:1b:64:70
[    3.216032] davinci_mdio davinci_mdio.0: davinci mdio revision 1.5
[    3.222557] davinci_mdio davinci_mdio.0: detected phy mask fffffffc
[    3.233324] libphy: davinci_mdio.0: probed
[    3.237857] davinci_mdio davinci_mdio.0: phy[0]: device davinci_mdio.0:00, driver unknown
[    3.246535] davinci_mdio davinci_mdio.0: phy[1]: device davinci_mdio.0:01, driver unknown
[    3.256506] usbcore: registered new interface driver asix
[    3.262425] usbcore: registered new interface driver ax88179_178a
[    3.269147] usbcore: registered new interface driver cdc_ether
[    3.275616] usbcore: registered new interface driver smsc95xx
[    3.281954] usbcore: registered new interface driver net1080
[    3.288192] usbcore: registered new interface driver cdc_subset
[    3.294627] usbcore: registered new interface driver zaurus
[    3.300910] usbcore: registered new interface driver cdc_ncm
[    3.309776] usbcore: registered new interface driver cdc_wdm
[    3.316300] usbcore: registered new interface driver usb-storage
[    3.322942] usbcore: registered new interface driver usbtest
[    3.332885] mousedev: PS/2 mouse device common for all mice
[    3.344451] spi1.0 supply vcc not found, using dummy regulator
[    3.353902] ads7846 spi1.0: touchscreen, irq 169
[    3.361909] input: ADS7846 Touchscreen as /devices/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input0
[    3.383110] i2c /dev entries driver
[    3.392899] Driver for 1-wire Dallas network protocol.
[    3.407144] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    3.417626] of_get_named_gpiod_flags exited with status 0
[    3.423356] of_get_named_gpiod_flags exited with status 0
[    3.466861] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    3.476164] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    3.486326] omap_hsmmc 480b4000.mmc: unable to get vmmc regulator -517
[    3.494138] platform 480b4000.mmc: Driver omap_hsmmc requests probe deferral
[    3.503138] usbcore: registered new interface driver usbhid
[    3.509126] usbhid: USB HID core driver
[    3.515226] oprofile: using arm/armv7
[    3.520174] TCP: cubic registered
[    3.523679] Initializing XFRM netlink socket
[    3.528495] NET: Registered protocol family 17
[    3.533298] NET: Registered protocol family 15
[    3.538631] Key type dns_resolver registered
[    3.545290] PM: no software I/O chain control; some wakeups may be lost
[    3.552883] ThumbEE CPU extension supported.
[    3.557542] Registering SWP/SWPB emulation handler
[    3.576523] vwl1271_vaux2: disabling
[    3.580320] vmmc: disabling
[    3.583267] hsusb2_vbus: disabling
[    3.587002] hsusb1_vbus: disabling
[    3.593871] of_get_named_gpiod_flags exited with status 0
[    3.601214] vw1271: 1800 mV 
[    3.605733] of_get_named_gpiod_flags exited with status 0
[    3.613238] of_get_named_gpiod_flags exited with status 0
[    3.620577] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    3.629852] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@480b4000[0]'
[    3.741010] /home/lifshitz/workroot/git-repo/linux-cm-t3x/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.835073] Waiting for root device /dev/mmcblk0p2...
[    3.847356] omap_hsmmc 480b4000.mmc: card claims to support voltages below defined range
[    3.871505] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    3.881628] mmc1: new SDIO card at address 0001
[   17.337245] mmc0: new SDHC card at address e624
[   17.346375] mmcblk0: mmc0:e624 SU08G 7.40 GiB 
[   17.367618]  mmcblk0: p1 p2
[   17.482047] EXT3-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (240)
[   17.496648] EXT2-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (240)
[   17.540713] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   17.549636] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[   17.561280] devtmpfs: mounted
[   17.565783] Freeing unused kernel memory: 392K (c082a000 - c088c000)
/bin/sh: can't access tty; job control turned off
# ls
bin   dev  home  media	opt   root  selinux  sys  usr
boot  etc  lib	 mnt	proc  sbin  srv      tmp  var
# 


--------------080308020107020906030006--
