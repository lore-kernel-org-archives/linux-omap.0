From: "Mohammed, Afzal" <afzal@ti.com>
Subject: OMAP3EVM not booting on l-o master
Date: Wed, 4 Apr 2012 05:36:39 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2DDFgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 01:36:42 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q345ae5v031253
	for <linux-omap@vger.kernel.org>; Wed, 4 Apr 2012 00:36:41 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q345adom016634
	for <linux-omap@vger.kernel.org>; Wed, 4 Apr 2012 11:06:40 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

OMAP3EVM is not booting on l-o master, with default configuration, HEAD
@33fc21e Linux-omap rebuilt: Updated to v3.4-rc1, merged in most of pen=
ding branches.

It was booting on l-o master two weeks old with same setup.

Any clues on resolving this issue ?

Regards
Afzal

Logs as follows,

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc1-11705-g33fc21e (afzal@linux-psp-=
server.india.ext.ti.com) (gcc version 4.5.3 20110311 (prerelease) (GCC)=
 ) #1 SMP Wed Apr 4 10:27:23 IST 2012
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d0e000 s11456 r8192 d131=
20 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32256
[    0.000000] Kernel command line: console=3DttyO0,115200n8 root/dev/r=
am rw earlyprintk mem=3D128M initrd=3D0x81338000,0x1f6c2f
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 127MB =3D 127MB total
[    0.000000] Memory: 114536k/114536k available, 16536k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05d2e34   (5932 kB)
[    0.000000]       .init : 0xc05d3000 - 0xc0621cc0   ( 316 kB)
[    0.000000]       .data : 0xc0622000 - 0xc06b5958   ( 591 kB)
[    0.000000]        .bss : 0xc06b597c - 0xc0c09be0   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001129] Calibrating delay loop... 497.82 BogoMIPS (lpj=3D1941504=
)
[    0.085906] pid_max: default: 32768 minimum: 301
[    0.086883] Security Framework initialized
[    0.087249] Mount-cache hash table entries: 512
[    0.093780] CPU: Testing write buffer coherency: ok
[    0.094970] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.095092] Setting up static identity map for 0x804278b8 - 0x804279=
28
[    0.097442] Brought up 1 CPUs
[    0.097473] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.124389] dummy:
[    0.127258] NET: Registered protocol family 16
[    0.128936] GPMC revision 5.0
[    0.143035] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.143737] OMAP GPIO hardware version 2.5
[    0.145141] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.147125] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.149536] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.151428] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.153320] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.163635] omap_mux_init: Add partition: #1: core, flags: 0
[    0.182525] Reprogramming SDRC clock to 332000000 Hz
[    0.290496] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.310638]  omap-mcbsp.2: alias fck already exists
[    0.311676]  omap-mcbsp.3: alias fck already exists
[    0.318115] OMAP DMA hardware revision 4.0
[    0.409606] bio: create slab <bio-0> at 0
[    0.414764] dummy:
[    0.414947] dummy: Failed to create debugfs directory
[    0.422912] SCSI subsystem initialized
[    0.425506] omap2_mcspi omap2_mcspi.1: master is unqueued, this is d=
eprecated
[    0.429168] omap2_mcspi omap2_mcspi.2: master is unqueued, this is d=
eprecated
[    0.431213] omap2_mcspi omap2_mcspi.3: master is unqueued, this is d=
eprecated
[    0.432708] omap2_mcspi omap2_mcspi.4: master is unqueued, this is d=
eprecated
[    0.437194] usbcore: registered new interface driver usbfs
[    0.439025] usbcore: registered new interface driver hub
[    0.439971] usbcore: registered new device driver usb
[    0.453674] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.466003] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.466857] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.470428] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs =
336..353
[    0.472412] gpiochip_add: registered GPIOs 192 to 211 on device: twl=
4030
[    0.486389] VIO: 1800 mV normal standby
[    0.489349] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.491973] vdd_core: 600 <--> 1450 mV normal
[    0.495452] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.498474] VDAC: 1800 mV normal standby
[    0.501953] VPLL2: 1800 mV normal standby
[    0.505065] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.515991] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
[    0.531494] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[    0.542846] Switching to clocksource 32k_counter
[    0.698089] NET: Registered protocol family 2
[    0.699310] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.702606] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.703002] TCP bind hash table entries: 4096 (order: 5, 147456 byte=
s)
[    0.705718] TCP: Hash tables configured (established 4096 bind 4096)
[    0.705841] TCP: reno registered
[    0.705871] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.706268] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.707641] NET: Registered protocol family 1
[    0.709625] RPC: Registered named UNIX socket transport module.
[    0.709655] RPC: Registered udp transport module.
[    0.709686] RPC: Registered tcp transport module.
[    0.709716] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.710906] Trying to unpack rootfs image as initramfs...
[    0.713623] rootfs image is not initramfs (no cpio magic); looks lik=
e an initrd
[    0.736907] Freeing initrd memory: 2008K
[    0.737091] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.937377] VFS: Disk quotas dquot_6.5.2
[    0.937805] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.940093] NFS: Registering the id_resolver key type
[    0.942779] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    0.944396] msgmni has been set to 227
[    0.949035] io scheduler noop registered
[    0.949096] io scheduler deadline registered
[    0.949432] io scheduler cfq registered (default)
[    0.953063] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.962341] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    1.666015] console [ttyO0] enabled
[    1.672515] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    1.682159] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    1.736358] brd: module loaded
[    1.766479] loop: module loaded
[    1.780883] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.789276] OneNAND driver initializing
[    1.802429] smsc911x: Driver version 2008-10-21
[    1.819610] smsc911x-mdio: probed
[    1.823425] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN=
8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    1.835083] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:7e:90:f=
c
[    1.843719] usbcore: registered new interface driver asix
[    1.850372] usbcore: registered new interface driver cdc_ether
[    1.857482] usbcore: registered new interface driver net1080
[    1.864349] usbcore: registered new interface driver cdc_subset
[    1.871276] usbcore: registered new interface driver zaurus
[    1.878112] usbcore: registered new interface driver cdc_ncm
[    1.887359] usbcore: registered new interface driver cdc_wdm
[    1.893341] Initializing USB Mass Storage driver...
[    1.899383] usbcore: registered new interface driver usb-storage
[    1.905944] USB Mass Storage support registered.
[    1.912384] usbcore: registered new interface driver libusual
[    1.919433] usbcore: registered new interface driver usbtest
[    1.927856] mousedev: PS/2 mouse device common for all mice
[    1.937499] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2=
c-1/1-004a/twl4030_keypad/input/input0
[    1.958282] ads7846 spi1.0: touchscreen, irq 271
[    1.967041] input: ADS7846 Touchscreen as /devices/platform/omap2_mc=
spi.1/spi_master/spi1/spi1.0/input/input1
[    1.984100] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1=
/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    1.997650] twl_rtc twl_rtc: Power up reset detected.
[    2.003173] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.013977] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.022430] i2c /dev entries driver
[    2.031341] Driver for 1-wire Dallas network protocol.
[    2.041229] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.050140] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.057098] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.081634] usbcore: registered new interface driver usbhid
[    2.087768] usbhid: USB HID core driver
[    2.091918] oprofile: hardware counters not available
[    2.097229] oprofile: using timer interrupt.
[    2.102966] TCP: cubic registered
[    2.106597] Initializing XFRM netlink socket
[    2.111297] NET: Registered protocol family 17
[    2.116271] NET: Registered protocol family 15
[    2.121368] Registering the dns_resolver key type
[    2.126708] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 1
[    2.135009] ThumbEE CPU extension supported.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
