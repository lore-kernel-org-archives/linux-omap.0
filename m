From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: dts: Changes for Gumstix Pepper dts
Date: Tue, 14 Jul 2015 05:25:12 -0700
Message-ID: <7hegkbgc47.fsf@deeprootsystems.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433441299-18887-1-git-send-email-arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org> (Arun
	Bharadwaj's message of "Thu, 4 Jun 2015 11:08:16 -0700")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org> writes:

> These 3 patches are included to fix the following issues
> with pepper device tree source. The patches are based against
> linux-omap/master.

I tested this series on top of linus/master with omap2plus_defconfig and
it seems to successfully boot now (used to hang after disabling
vdd_mpu.)

However, it still hangs during boot when testing with multi_v7_defconfig
(boot log below.)

Anyways, it's a step in the right direction.  Feel free to add 

Tested-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kevin


[1] full console log: linus/master, mutli_v7_defconfig + $SUBJECT series:

Connected to pepper console [channel connected] (~$quit to exit)
(user:khilman) is already connected


# PYBOOT: console: connected.
~$hardreset

Command(pepper console)> hardreset
(user:khilman) Reboot pepper

U-Boot SPL 2014.10 (Feb 24 2015 - 21:56:40)
Booting with DDR
reading u-boot.img
reading u-boot.img


U-Boot 2014.10 (Feb 24 2015 - 21:56:40)

AM335X-GP rev 1.0
       Watchdog enabled
I2C:   ready
DRAM:  512 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  1 

# PYBOOT: u-boot: taking control.
 0 
pepper# 
pepper# version
version

U-Boot 2014.10 (Feb 24 2015 - 21:56:40)
arm-poky-linux-gnueabi-gcc (GCC) 4.9.1
GNU ld (GNU Binutils) 2.24
pepper# if test -n ${initenv}; then run initenv; fi
if test -n ${initenv}; then run initenv; fi
pepper# if test -n ${preboot}; then run preboot; fi
if test -n ${preboot}; then run preboot; fi
pepper# setenv autoload no; setenv autoboot no
setenv autoload no; setenv autoboot no
pepper# dhcp
dhcp
cpsw Waiting for PHY auto negotiation to complete... done
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address 192.168.1.190 (322 ms)
pepper# setenv serverip 192.168.1.2
setenv serverip 192.168.1.2
pepper# if test -n ${netargs}; then run netargs; fi
if test -n ${netargs}; then run netargs; fi
pepper# tftp 0x81000000 192.168.1.2:tmp/pepper-B3cJIV/zImage
tftp 0x81000000 192.168.1.2:tmp/pepper-B3cJIV/zImage
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.1.2; our IP address is 192.168.1.190
Filename 'tmp/pepper-B3cJIV/zImage'.
Load address: 0x81000000
Loading: *#################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #############################
 2.8 MiB/s
done
Bytes transferred = 6146272 (5dc8e0 hex)
pepper# tftp 0x82000000 192.168.1.2:tmp/pepper-B3cJIV/rootfs.cpio.gz
tftp 0x82000000 192.168.1.2:tmp/pepper-B3cJIV/rootfs.cpio.gz
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.1.2; our IP address is 192.168.1.190
Filename 'tmp/pepper-B3cJIV/rootfs.cpio.gz'.
Load address: 0x82000000
Loading: *#################################################################
 #################################################################
 #################################################################
 #################################################################
 #################################################################
 #############
 2.7 MiB/s
done
Bytes transferred = 4956631 (4ba1d7 hex)
pepper#tftp 0x81f00000 192.168.1.2:tmp/pepper-B3cJIV/tmpW6fNjj.dtb
 tftp 0x81f00000 192.168.1.2:tmp/pepper-B3cJIV/tmpW6fNjj.dtb
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.1.2; our IP address is 192.168.1.190
Filename 'tmp/pepper-B3cJIV/tmpW6fNjj.dtb'.
Load address: 0x81f00000
Loading: *###
 2.5 MiB/s
done
Bytes transferred = 33734 (83c6 hex)
pepper# printenv bootargs
printenv bootargs
## Error: "bootargs" not defined
pepper# bootz 0x81000000 - 0x81f00000

# PYBOOT: u-boot: jumping to kernel image
bootz 0x81000000 - 0x81f00000
Kernel image @ 0x81000000 [ 0x000000 - 0x5dc8e0 ]
## Flattened Device Tree blob at 81f00000
   Booting using the fdt blob at 0x81f00000
   Loading Device Tree to 8fff4000, end 8ffff3c5 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.2.0-rc2-00080-g9ea52aaed426 (khilman@paris) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #6 SMP Tue Jul 14 05:13:16 PDT 2015
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Gumstix Pepper
[    0.000000] cma: Reserved 64 MiB at 0x9b800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES1.0 (sgx neon )
[    0.000000] PERCPU: Embedded 11 pages/cpu @dfaa4000 s14784 r8192 d22080 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129792
[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 434372K/523264K available (7778K kernel code, 1038K rwdata, 3512K rodata, 944K init, 327K bss, 23356K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0d0f960   (11295 kB)
[    0.000000]       .init : 0xc0d10000 - 0xc0dfc000   ( 944 kB)
[    0.000000]       .data : 0xc0dfc000 - 0xc0effa80   (1039 kB)
[    0.000000]        .bss : 0xc0f02000 - 0xc0f53c28   ( 328 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] Additional per-CPU info printed with stalls.
[    0.000000] Build-time adjustment of leaf fanout to 32.
[    0.000000] RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000018] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000048] clocksource: timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000064] OMAP clocksource: timer1 at 24000000 Hz
[    0.000335] Console: colour dummy device 80x30
[    0.000384] Calibrating delay loop... 548.04 BogoMIPS (lpj=1370112)
[    0.073895] pid_max: default: 32768 minimum: 301
[    0.074102] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.074121] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.075253] CPU: Testing write buffer coherency: ok
[    0.075706] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.075846] Setting up static identity map for 0x80209000 - 0x80209098
[    0.079622] Brought up 1 CPUs
[    0.079648] SMP: Total of 1 processors activated (548.04 BogoMIPS).
[    0.079660] CPU: All CPU(s) started in SVC mode.
[    0.080426] devtmpfs: initialized
[    0.096971] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.116040] omap_hwmod: tptc0 using broken dt data from edma
[    0.116258] omap_hwmod: tptc1 using broken dt data from edma
[    0.116456] omap_hwmod: tptc2 using broken dt data from edma
[    0.122224] omap_hwmod: debugss: _wait_target_disable failed
[    0.180068] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.186095] pinctrl core: initialized pinctrl subsystem
[    0.189457] NET: Registered protocol family 16
[    0.192853] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.196065] cpuidle: using governor ladder
[    0.196099] cpuidle: using governor menu
[    0.202031] OMAP GPIO hardware version 0.1
[    0.220615] No ATAGs?
[    0.220659] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.227077] Serial: AMBA PL011 UART driver
[    0.258804] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
[    0.265009] vgaarb: loaded
[    0.266352] SCSI subsystem initialized
[    0.267328] usbcore: registered new interface driver usbfs
[    0.267457] usbcore: registered new interface driver hub
[    0.267559] usbcore: registered new device driver usb
[    0.268790] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c0, deferring probe
[    0.268959] omap_i2c 4802a000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c1, deferring probe
[    0.270056] pps_core: LinuxPPS API ver. 1 registered
[    0.270072] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.270117] PTP clock support registered
[    0.270442] EDAC MC: Ver: 3.0.0
[    0.274823] clocksource: Switched to clocksource timer1
[    0.292941] NET: Registered protocol family 2
[    0.293934] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.294018] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.294122] TCP: Hash tables configured (established 4096 bind 4096)
[    0.294223] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.294259] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.294528] NET: Registered protocol family 1
[    0.295194] RPC: Registered named UNIX socket transport module.
[    0.295216] RPC: Registered udp transport module.
[    0.295227] RPC: Registered tcp transport module.
[    0.295237] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.296124] Unpacking initramfs...
[    0.867384] Freeing initrd memory: 4844K (c2000000 - c24bb000)
[    0.867971] hw perfevents: Failed to parse /pmu/interrupt-affinity[0]
[    0.868064] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.871465] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.892259] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.893967] NFS: Registering the id_resolver key type
[    0.894059] Key type id_resolver registered
[    0.894071] Key type id_legacy registered
[    0.894172] ntfs: driver 2.1.32 [Flags: R/O].
[    0.896531] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.896570] io scheduler noop registered
[    0.896589] io scheduler deadline registered
[    0.896928] io scheduler cfq registered (default)
[    0.902490] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.016905] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.020887] SuperH (H)SCI(F) driver initialized
[    1.022138] msm_serial: driver initialized
[    1.023049] omap_uart 44e09000.serial: no wakeirq for uart0
[    1.023302] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 154, base_baud = 3000000) is a OMAP UART0
[    1.697628] console [ttyO0] enabled
[    1.702156] omap_uart 48022000.serial: no wakeirq for uart1
[    1.708250] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 155, base_baud = 3000000) is a OMAP UART1
[    1.718793] STMicroelectronics ASC driver initialized
[    1.726659] [drm] Initialized drm 1.1.0 20060810
[    1.743793] loop: module loaded
[    1.759192] CAN device driver interface
[    1.765030] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.18-k
[    1.772471] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.782274] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    1.790237] usbcore: registered new interface driver pegasus
[    1.796342] usbcore: registered new interface driver asix
[    1.802141] usbcore: registered new interface driver ax88179_178a
[    1.808655] usbcore: registered new interface driver cdc_ether
[    1.814930] usbcore: registered new interface driver smsc75xx
[    1.821131] usbcore: registered new interface driver smsc95xx
[    1.827285] usbcore: registered new interface driver net1080
[    1.833344] usbcore: registered new interface driver cdc_subset
[    1.839675] usbcore: registered new interface driver zaurus
[    1.845730] usbcore: registered new interface driver cdc_ncm
[    1.854413] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.861369] ehci-pci: EHCI PCI platform driver
[    1.866188] ehci-platform: EHCI generic platform driver
[    1.872014] ehci-omap: OMAP-EHCI Host Controller driver
[    1.877761] ehci-orion: EHCI orion driver
[    1.882209] SPEAr-ehci: EHCI SPEAr driver
[    1.886657] ehci-st: EHCI STMicroelectronics driver
[    1.892010] ehci-exynos: EHCI EXYNOS driver
[    1.896662] ehci-atmel: EHCI Atmel driver
[    1.901111] tegra-ehci: Tegra EHCI driver
[    1.905583] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.912149] ohci-pci: OHCI PCI platform driver
[    1.916965] ohci-platform: OHCI generic platform driver
[    1.922742] ohci-omap3: OHCI OMAP3 driver
[    1.927201] SPEAr-ohci: OHCI SPEAr driver
[    1.931672] ohci-st: OHCI STMicroelectronics driver
[    1.937037] ohci-atmel: OHCI Atmel driver
[    1.941626] usbcore: registered new interface driver usb-storage
[    1.950401] mousedev: PS/2 mouse device common for all mice
[    1.962268] i2c /dev entries driver
[    1.975426] sdhci: Secure Digital Host Controller Interface driver
[    1.981972] sdhci: Copyright(c) Pierre Ossman
[    1.988073] omap_hsmmc 48060000.mmc: Got CD GPIO
[    1.993857] omap_hsmmc 48060000.mmc: unable to get vmmc regulator -517
[    2.001590] 47810000.mmc supply vmmc not found, using dummy regulator
[    2.008803] omap_hsmmc 47810000.mmc: could not set regulator OCR (-22)
[    2.046285] Synopsys Designware Multimedia Card Interface Driver
[    2.054141] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.063095] ledtrig-cpu: registered to indicate activity on CPUs
[    2.070026] usbcore: registered new interface driver usbhid
[    2.075915] usbhid: USB HID core driver
[    2.084966] NET: Registered protocol family 17
[    2.089686] can: controller area network core (rev 20120528 abi 9)
[    2.096359] NET: Registered protocol family 29
[    2.101079] can: raw protocol (rev 20120528)
[    2.105597] can: broadcast manager protocol (rev 20120528 t)
[    2.111580] can: netlink gateway (rev 20130117) max_hops=1
[    2.118189] Key type dns_resolver registered
[    2.122966] omap_voltage_late_init: Voltage driver support not added
[    2.131238] ThumbEE CPU extension supported.
[    2.135876] Registering SWP/SWPB emulation handler
[    2.150362] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
[    2.158333] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    2.166392] omap_i2c 4802a000.i2c: bus 1 rev0.11 at 400 kHz
[    2.174730] omap_hsmmc 48060000.mmc: Got CD GPIO
[    2.180169] omap_hsmmc 48060000.mmc: unable to get vmmc regulator -517
[    2.229100] mmc0: new high speed SDIO card at address 0001
[    2.244872] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.251312] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    2.266864] libphy: 4a101000.mdio: probed
[    2.271233] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver Micrel KSZ9021 Gigabit PHY
[    2.283796] cpsw 4a100000.ethernet: Detected MACID = 00:18:31:e1:31:00
[    2.293974] input: user_buttons as /devices/platform/user_buttons/input/input0
[    2.304363] omap_hsmmc 48060000.mmc: Got CD GPIO
[    2.309858] omap_hsmmc 48060000.mmc: unable to get vmmc regulator -517
[    2.318674] hctosys: unable to open rtc device (rtc0)
[    2.331330] platform 48060000.mmc: omap_device_late_idle: enabled but no driver.  Idling
[    2.340126] vdd5_reg: disabling
[    2.343433] v3v3c_reg: disabling
[    2.346879] vbat: disabling
[    2.353231] omap_hsmmc 48060000.mmc: Got CD GPIO
[    2.358457] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06012c
[    2.
# PYBOOT: kernel: Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06012c

366499] pgd = c0204000
[    2.369339] [fa06012c] *pgd=48011452(bad)
[    2.373571] Internal error: : 1028 [#1] SMP ARM
[    2.378327] Modules linked in:
[    2.381548] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.2.0-rc2-00080-g9ea52aaed426 #6
[    2.390127] Hardware name: Generic AM33XX (Flattened Device Tree)
[    2.396547] Workqueue: deferwq deferred_probe_work_func
[    2.402036] task: db0597c0 ti: db074000 task.ti: db074000
[    2.407711] PC is at omap_hsmmc_probe+0x2b8/0xa14
[    2.412665] LR is at rpm_idle+0x10/0x11c
[    2.416784] pc : [<c081703c>]    lr : [<c06170d0>]    psr: a0000013
[    2.416784] sp : db075e40  ip : 00000064  fp : fa060100
[    2.428826] r10: db4e1300  r9 : 0000009e  r8 : 00000000
[    2.434308] r7 : db0e0410  r6 : db0e0400  r5 : 00000000  r4 : db4e1000
[    2.441155] r3 : fa060100  r2 : 00000001  r1 : 00000008  r0 : fffffff5
[    2.448006] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.455674] Control: 10c5387d  Table: 9b4e8019  DAC: 00000015
[    2.461703] Process kworker/u2:0 (pid: 6, stack limit = 0xdb074220)
[    2.468278] Stack: (0xdb075e40 to 0xdb076000)
[    2.472856] 5e40: db4737d0 db0e15f0 00000001 00000009 db0e15f0 db4737d0 c0c0a274 db0e15f0
[    2.481441] 5e60: 00000001 ffffffef db0e0410 fffffdfb c0ec14dc 00000009 db02d000 00000001
[    2.490026] 5e80: 00000002 c0610564 c061051c db0e0410 c0f41e24 00000000 c0ec14dc c060efa8
[    2.498610] 5ea0: 00000000 db075ed0 c060f238 00000001 00000000 c060d6ac db02a970 db4740b8
[    2.507195] 5ec0: db0e0410 db0e0444 c0ea13f0 c060ed68 db0e0410 00000001 00000000 db0e0410
[    2.515780] 5ee0: db0e0410 c0ea13f0 db423b00 c060e524 db0e0410 c0ea1390 c0ea1378 c060e8fc
[    2.524365] 5f00: db02d000 c0ea13ac db04f400 c025f260 dfaa43c0 db04f400 00000001 db04f414
[    2.532951] 5f20: 00000001 db04f400 db02d018 00000088 db02d000 db04f400 00000002 c025f4c0
[    2.541535] 5f40: db0597c0 db02b640 00000000 db02d000 c025f498 00000000 00000000 00000000
[    2.550120] 5f60: 00000000 c0264618 db059300 00000000 ffa4e9fc db02d000 00000000 00000000
[    2.558705] 5f80: db075f80 db075f80 00000000 00000000 db075f90 db075f90 db075fac db02b640
[    2.567289] 5fa0: c0264540 00000000 00000000 c02109a8 00000000 00000000 00000000 00000000
[    2.575873] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.584458] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 d79d5c5b baafffaa
[    2.593070] [<c081703c>] (omap_hsmmc_probe) from [<c0610564>] (platform_drv_probe+0x48/0xa4)
[    2.601936] [<c0610564>] (platform_drv_probe) from [<c060efa8>] (driver_probe_device+0x1c8/0x26c)
[    2.611254] [<c060efa8>] (driver_probe_device) from [<c060d6ac>] (bus_for_each_drv+0x44/0x8c)
[    2.620205] [<c060d6ac>] (bus_for_each_drv) from [<c060ed68>] (__device_attach+0x88/0xd8)
[    2.628793] [<c060ed68>] (__device_attach) from [<c060e524>] (bus_probe_device+0x84/0x8c)
[    2.637381] [<c060e524>] (bus_probe_device) from [<c060e8fc>] (deferred_probe_work_func+0x5c/0x88)
[    2.646799] [<c060e8fc>] (deferred_probe_work_func) from [<c025f260>] (process_one_work+0x134/0x338)
[    2.656393] [<c025f260>] (process_one_work) from [<c025f4c0>] (worker_thread+0x28/0x4cc)
[    2.664891] [<c025f4c0>] (worker_thread) from [<c0264618>] (kthread+0xd8/0xf4)
[    2.672485] [<c0264618>] (kthread) from [<c02109a8>] (ret_from_fork+0x14/0x2c)
[    2.680070] Code: e5940300 e3a01001 ebf80383 e594332c (e593202c) 
[    2.686469] ---[ end trace 2bc5564f7a786282 ]---
[    2.691516] Unable to handle kernel paging request at virtual address ffffffec
[    2.699101] pgd = c0204000
[    2.701939] [ffffffec] *pgd=9fede821, *pte=00000000, *ppte=00000000
[    2.708543] Internal error: Oops: 17 [#2] SMP ARM
[    2.713477] Modules linked in:
[    2.716693] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G      D         4.2.0-rc2-00080-g9ea52aaed426 #6
[    2.726546] Hardware name: Generic AM33XX (Flattened Device Tree)
[    2.732949] task: db0597c0 ti: db074000 task.ti: db074000
[    2.738618] PC is at kthread_data+0x4/0xc
[    2.742829] LR is at wq_worker_sleeping+0xc/0xd0
[    2.747674] pc : [<c0264b60>]    lr : [<c026041c>]    psr: 20000193
[    2.747674] sp : db075c50  ip : dfaa7040  fp : db075c9c
[    2.759716] r10: c0dfe6a8  r9 : db0597c0  r8 : c0dfa040
[    2.765196] r7 : 00000000  r6 : db059a54  r5 : c0dfa040  r4 : 00000000
[    2.772042] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : db0597c0
[    2.778891] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    2.786468] Control: 10c5387d  Table: 9b4e8019  DAC: 00000015
[    2.792496] Process kworker/u2:0 (pid: 6, stack limit = 0xdb074220)
[    2.799071] Stack: (0xdb075c50 to 0xdb076000)
[    2.803645] 5c40:                                     dfaa7040 c0958060 00000001 c0f04794
[    2.812231] 5c60: db0597c0 c024d248 c0df7280 00000001 c09583e0 1ecad000 db0599d0 db075a84
[    2.820816] 5c80: db058000 db0599d0 db075cb0 0000000b 00000001 00000001 db075ca4 c09583e0
[    2.829401] 5ca0: db0597c0 c024e688 c0bac160 db075ccc db075cb0 db075cb0 db075df8 c0f02604
[    2.837986] 5cc0: db075df8 c0e02ce4 60000193 0000000b 00000001 c081703e c0817040 c0213a04
[    2.846571] 5ce0: db074220 0000000b 00000000 c0e02ce4 00000000 00000008 65000000 30343935
[    2.855156] 5d00: 20303033 30613365 31303031 66626520 38333038 35652033 33333439 28206332
[    2.863741] 5d20: 33393565 63323032 c0002029 db075d4c 00000000 00001028 00000007 fa06012c
[    2.872327] 5d40: c0e0309c db075df8 0000009e db4e1300 fa060100 c020a2ac 00000000 80000000
[    2.880912] 5d60: 00000007 00000000 00000000 fa06012c db0e1820 db4f3eb0 db4f3eb0 c035a628
[    2.889496] 5d80: 00000002 db4f3eb0 00000000 00000000 db0e1820 c035a8a4 c096add8 c0ea1af4
[    2.898080] 5da0: db0e1820 00000000 db0e1820 db4f3eb0 c096add8 c0ea1af4 db0e1820 c035bcb8
[    2.906664] 5dc0: 00000000 00000000 00000000 c035c454 00001000 00000000 db0de9cd 0000000d
[    2.915248] 5de0: c081703c a0000013 ffffffff db075e2c 00000000 c0214118 fffffff5 00000008
[    2.923833] 5e00: 00000001 fa060100 db4e1000 00000000 db0e0400 db0e0410 00000000 0000009e
[    2.932419] 5e20: db4e1300 fa060100 00000064 db075e40 c06170d0 c081703c a0000013 ffffffff
[    2.941003] 5e40: db4737d0 db0e15f0 00000001 00000009 db0e15f0 db4737d0 c0c0a274 db0e15f0
[    2.949588] 5e60: 00000001 ffffffef db0e0410 fffffdfb c0ec14dc 00000009 db02d000 00000001
[    2.958172] 5e80: 00000002 c0610564 c061051c db0e0410 c0f41e24 00000000 c0ec14dc c060efa8
[    2.966757] 5ea0: 00000000 db075ed0 c060f238 00000001 00000000 c060d6ac db02a970 db4740b8
[    2.975342] 5ec0: db0e0410 db0e0444 c0ea13f0 c060ed68 db0e0410 00000001 00000000 db0e0410
[    2.983927] 5ee0: db0e0410 c0ea13f0 db423b00 c060e524 db0e0410 c0ea1390 c0ea1378 c060e8fc
[    2.992512] 5f00: db02d000 c0ea13ac db04f400 c025f260 dfaa43c0 db04f400 00000001 db04f414
[    3.001098] 5f20: 00000001 db04f400 db02d018 00000088 db02d000 db04f400 00000002 c025f4c0
[    3.009683] 5f40: db0597c0 db02b640 00000000 db02d000 c025f498 00000000 00000000 00000000
[    3.018269] 5f60: 00000000 c0264618 db059300 00000000 ffa4e9fc db02d000 00000000 00000000
[    3.026854] 5f80: db075f80 db075f80 00000001 00010001 db075f90 db075f90 db075fac db02b640
[    3.035438] 5fa0: c0264540 00000000 00000000 c02109a8 00000000 00000000 00000000 00000000
[    3.044021] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.052605] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 d79d5c5b baafffaa
[    3.061195] [<c0264b60>] (kthread_data) from [<c026041c>] (wq_worker_sleeping+0xc/0xd0)
[    3.069606] [<c026041c>] (wq_worker_sleeping) from [<c0958060>] (__schedule+0x298/0x51c)
[    3.078102] [<c0958060>] (__schedule) from [<c09583e0>] (schedule+0x34/0x98)
[    3.085507] [<c09583e0>] (schedule) from [<c024e688>] (do_exit+0x5c8/0x8f0)
[    3.092825] [<c024e688>] (do_exit) from [<c0213a04>] (die+0x3e0/0x428)
[    3.099683] [<c0213a04>] (die) from [<c020a2ac>] (do_DataAbort+0xa4/0xb4)
[    3.106812] [<c020a2ac>] (do_DataAbort) from [<c0214118>] (__dabt_svc+0x38/0x60)
[    3.114570] Exception stack(0xdb075df8 to 0xdb075e40)
[    3.119870] 5de0:                                                       fffffff5 00000008
[    3.128455] 5e00: 00000001 fa060100 db4e1000 00000000 db0e0400 db0e0410 00000000 0000009e
[    3.137040] 5e20: db4e1300 fa060100 00000064 db075e40 c06170d0 c081703c a0000013 ffffffff
[    3.145629] [<c0214118>] (__dabt_svc) from [<c081703c>] (omap_hsmmc_probe+0x2b8/0xa14)
[    3.153949] [<c081703c>] (omap_hsmmc_probe) from [<c0610564>] (platform_drv_probe+0x48/0xa4)
[    3.162813] [<c0610564>] (platform_drv_probe) from [<c060efa8>] (driver_probe_device+0x1c8/0x26c)
[    3.172129] [<c060efa8>] (driver_probe_device) from [<c060d6ac>] (bus_for_each_drv+0x44/0x8c)
[    3.181080] [<c060d6ac>] (bus_for_each_drv) from [<c060ed68>] (__device_attach+0x88/0xd8)
[    3.189668] [<c060ed68>] (__device_attach) from [<c060e524>] (bus_probe_device+0x84/0x8c)
[    3.198256] [<c060e524>] (bus_probe_device) from [<c060e8fc>] (deferred_probe_work_func+0x5c/0x88)
[    3.207665] [<c060e8fc>] (deferred_probe_work_func) from [<c025f260>] (process_one_work+0x134/0x338)
[    3.217255] [<c025f260>] (process_one_work) from [<c025f4c0>] (worker_thread+0x28/0x4cc)
[    3.225752] [<c025f4c0>] (worker_thread) from [<c0264618>] (kthread+0xd8/0xf4)
[    3.233337] [<c0264618>] (kthread) from [<c02109a8>] (ret_from_fork+0x14/0x2c)
[    3.240920] Code: e513001c e7e00150 e12fff1e e5903268 (e5130014) 
[    3.247317] ---[ end trace 2bc5564f7a786283 ]---
[    3.252159] Fixing recursive fault but reboot is needed!
~$off
# PYBOOT: Exception: kernel: Unable to handle kernel paging request at virtual address ffffffec

#
# PYBOOT: cmdline: pyboot pepper
# PYBOOT: Time: 17.30 (bootloader: 12.60, setup: 0.22, kernel: 0.00)
# PYBOOT: Warnings: 1
# PYBOOT: Result: FAIL
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
