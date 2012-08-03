From: Paul Walmsley <paul@pwsan.com>
Subject: nfsroot problems with v3.6-rc1 on 37xx EVM and dynamic off-mode
Date: Fri, 3 Aug 2012 14:20:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208031340310.28888@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34220 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2HCUUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 16:20:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com


NFS is broken on 37xx EVM with v3.6-rc1 after return from off-mode with 
dynamic idle.  System suspend ("echo mem > /sys/power/state") with 
off-mode enabled seems to work fine.

No obvious ideas here as to what could have broken this.  It worked in 
v3.5-rc2 + my omap_fixes_a_3.5rc at least:

http://www.pwsan.com/omap/bootlogs/20120617/omap_fixes_a_3.5rc__52a5ae406dadef781bfcf3a641dae2064e9697ff/37xxevm_bootlog.txt

After that, it's hard to tell when this problem started occurring, since 
CORE stopped entering low-power states on OMAP3 on >= v3.5-rc3.

Test log is below.


- Paul



Texas Instruments X-Loader 1.47 (Jan 14 2011 - 15:43:28)
Starting X-loader on MMC
Reading boot sector

212836 Bytes Read from MMC
Starting OS Bootloader from MMC...
Starting OS Bootloader...


U-Boot 2010.06 (Jan 14 2011 - 15:43:45)

OMAP34xx/35xx-GP ES2.1, CPU-OPP2 L3-165MHz
OMAP3 EVM board + LPDDR/NAND
I2C:   ready
DRAM:  256 MiB
NAND:  512 MiB
In:    serial
Out:   serial
Err:   serial
Read back SMSC id 0x92200000
Die ID #368000229ff80000016071640902c013
Net:   smc911x-0
Hit any key to stop autoboot:  0 
smc911x: detected LAN9220 controller
smc911x: phy initialized
smc911x: MAC 00:50:c2:7e:99:42
BOOTP broadcast 1
DHCP client bound to address 192.168.57.131
Using smc911x-0 device
TFTP from server 192.168.57.1; our IP address is 192.168.57.131
Filename 'uImage.37xevm'.
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
         ###################################################
done
Bytes transferred = 3254088 (31a748 hex)
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-3.6.0-rc1-00005-gacbfd56
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3254024 Bytes = 3.1 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-rc1-00005-gacbfd56 (paul@nozomi) (gcc 
version 4.5.1 (Sourcery G++ Lite 2010.09-50) )
 #1 SMP Fri Aug 3 10:28:26 MDT 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e0d000 s12736 r8192 d15936 
u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk 
root=/dev/nfs nfsroot=192.168.57.1:/srv/nfs4/roo
tfs2 nfsrootdebug ip=dhcp init=/bin/sh
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 
bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 246492k/246492k available, 15652k reserved, 0K 
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05c6bbc   (5883 kB)
[    0.000000]       .init : 0xc05c7000 - 0xc06141c0   ( 309 kB)
[    0.000000]       .data : 0xc0616000 - 0xc06ae3e8   ( 609 kB)
[    0.000000]        .bss : 0xc06ae40c - 0xc0c06acc   (5474 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps 
every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, 
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
[    0.000915] Calibrating delay loop... 397.57 BogoMIPS (lpj=1554432)
[    0.109344] pid_max: default: 32768 minimum: 301
[    0.109924] Security Framework initialized
[    0.110137] Mount-cache hash table entries: 512
[    0.115661] CPU: Testing write buffer coherency: ok
[    0.116577] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.116638] Setting up static identity map for 0x8040c0d8 - 0x8040c148
[    0.119110] Brought up 1 CPUs
[    0.119140] SMP: Total of 1 processors activated (397.57 BogoMIPS).
[    0.142211] dummy: 
[    0.144622] NET: Registered protocol family 16
[    0.145507] DMA: preallocated 256 KiB pool for atomic coherent 
allocations
[    0.146545] GPMC revision 5.0
[    0.146789] gpmc: irq-20 could not claim: err -22
[    0.158538] OMAP GPIO hardware version 2.5
[    0.176635] omap_mux_init: Add partition: #1: core, flags: 0
[    0.192993] _omap_mux_get_by_name: Could not find signal 
uart4_rx.uart4_rx
[    0.202178] Reprogramming SDRC clock to 400000000 Hz
[    0.202209] dpll3_m2_clk rate change failed: -22
[    0.203704] Found NAND on CS0
[    0.203704] Registering NAND on CS0
[    0.205810] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.222991]  omap-mcbsp.2: alias fck already exists
[    0.223937]  omap-mcbsp.3: alias fck already exists
[    0.229370] OMAP DMA hardware revision 5.0
[    0.300506] bio: create slab <bio-0> at 0
[    0.304321] fixed-dummy: 
[    0.311279] SCSI subsystem initialized
[    0.314392] usbcore: registered new interface driver usbfs
[    0.315002] usbcore: registered new interface driver hub
[    0.315734] usbcore: registered new device driver usb
[    0.328735] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.339294] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.339996] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.342773] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 
336..353
[    0.355865] VIO: 1800 mV normal standby
[    0.358428] vdd_mpu_iva: 600 <--> 1450 mV normal 
[    0.361389] vdd_core: 600 <--> 1450 mV normal 
[    0.363830] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.366851] VDAC: 1800 mV normal standby
[    0.370178] VAUX2_4030: 2800 mV normal standby
[    0.373321] VPLL2: 1800 mV normal standby
[    0.376525] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.390838] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.406402] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.415954] Switching to clocksource 32k_counter
[    0.542602] NET: Registered protocol family 2
[    0.544891] TCP established hash table entries: 8192 (order: 4, 65536 
bytes)
[    0.545379] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.550506] TCP: Hash tables configured (established 8192 bind 8192)
[    0.550720] TCP: reno registered
[    0.550750] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.551086] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.552154] NET: Registered protocol family 1
[    0.553619] RPC: Registered named UNIX socket transport module.
[    0.553649] RPC: Registered udp transport module.
[    0.553649] RPC: Registered tcp transport module.
[    0.553680] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.554931] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.749359] VFS: Disk quotas dquot_6.5.2
[    0.749725] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.752044] NFS: Registering the id_resolver key type
[    0.752746] Key type id_resolver registered
[    0.752777] Key type id_legacy registered
[    0.752960] jffs2: version 2.2. (NAND) (SUMMARY)   2001-2006 Red Hat, 
Inc.
[    0.753662] msgmni has been set to 481
[    0.758728] io scheduler noop registered
[    0.758758] io scheduler deadline registered
[    0.758819] io scheduler cfq registered (default)
[    0.762573] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.770294] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP 
UART0
[    1.432830] console [ttyO0] enabled
[    1.438476] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP 
UART1
[    1.448181] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP 
UART2
[    1.457275] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP 
UART3
[    1.503082] brd: module loaded
[    1.528717] loop: module loaded
[    1.540435] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.548156] NAND device: Manufacturer ID: 0xad, Chip ID: 0xbc (Hynix 
NAND 512MiB 1,8V 16-bit), page size: 2048, OOB 
size: 64
[    1.560150] Creating 5 MTD partitions on "omap2-nand.0":
[    1.565826] 0x000000000000-0x000000080000 : "X-Loader"
[    1.579254] 0x000000080000-0x000000240000 : "U-Boot"
[    1.591735] 0x000000240000-0x000000280000 : "U-Boot Env"
[    1.602478] 0x000000280000-0x000000780000 : "Kernel"
[    1.616943] 0x000000780000-0x000020000000 : "File system"
[    2.067474] OneNAND driver initializing
[    2.076110] spi spi1.0: no RX DMA engine channel for McSPI
[    2.082214] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status -11
[    2.089111] omap2_mcspi omap2_mcspi.1: can't create new device for 
ads7846
[    2.105773] smsc911x: Driver version 2008-10-21
[    2.120208] libphy: smsc911x-mdio: probed
[    2.124725] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC 
LAN8700] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
[    2.150573] usbcore: registered new interface driver cdc_ether
[    2.157684] usbcore: registered new interface driver net1080
[    2.164428] usbcore: registered new interface driver cdc_subset
[    2.171447] usbcore: registered new interface driver zaurus
[    2.178070] usbcore: registered new interface driver cdc_ncm
[    2.186462] usbcore: registered new interface driver cdc_wdm
[    2.192596] Initializing USB Mass Storage driver...
[    2.198455] usbcore: registered new interface driver usb-storage
[    2.204803] USB Mass Storage support registered.
[    2.211059] usbcore: registered new interface driver libusual
[    2.217926] usbcore: registered new interface driver usbtest
[    2.225769] mousedev: PS/2 mouse device common for all mice
[    2.234466] input: TWL4030 Keypad as 
/devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    2.253112] input: twl4030_pwrbutton as 
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    2.266174] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.275146] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.283325] i2c /dev entries driver
[    2.291229] Driver for 1-wire Dallas network protocol.
[    2.300628] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 
sec
[    2.309265] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.316101] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.327056] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    2.333496] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine 
channel 62
[    2.343994] usbcore: registered new interface driver usbhid
[    2.350128] usbhid: USB HID core driver
[    2.354217] oprofile: hardware counters not available
[    2.359558] oprofile: using timer interrupt.
[    2.364959] TCP: cubic registered
[    2.368469] Initializing XFRM netlink socket
[    2.373199] NET: Registered protocol family 17
[    2.378082] NET: Registered protocol family 15
[    2.383178] Key type dns_resolver registered
[    2.387939] VFP support v0.3: implementor 41 architecture 3 part 30 
variant c rev 3
[    2.407867] ThumbEE CPU extension supported.
[    2.449066] clock: disabling unused clocks to save power
[    2.460235] VMMC1: incomplete constraints, leaving on
[    2.468933] twl_rtc twl_rtc: setting system clock to 2000-01-01 
00:18:45 UTC (946685925)
[    2.480316] smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 
0xd085a000, IRQ: 272
[    2.987060] Sending DHCP requests ..., OK
[    8.823425] IP-Config: Got DHCP answer from 0.0.0.0, my address is 
192.168.57.131
[    8.832122] IP-Config: Complete:
[    8.835540]      device=eth0, addr=192.168.57.131, mask=255.255.255.0, 
gw=255.255.255.255
[    8.844238]      host=192.168.57.131, domain=, nis-domain=(none)
[    8.850616]      bootserver=0.0.0.0, rootserver=192.168.57.1, rootpath=
[    8.884765] VFS: Mounted root (nfs filesystem) on device 0:11.
[    8.891906] Freeing init memory: 308K
/bin/sh: can't access tty; job control turned off
# 
mount -t sysfs none # /sys
mount -t debugfs none /debug
#
echo 1 > /debug/pm_debug/enable_off_mode
#
     echo 1000 > 
/sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 1000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
# # # # # # # # # 
#   cat /debug/pm_debug/count
[   64.363189] nfs: server 192.168.57.1 not responding, still trying


