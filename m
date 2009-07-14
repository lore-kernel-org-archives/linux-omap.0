From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM: off mode
Date: Tue, 14 Jul 2009 09:58:01 -0700
Message-ID: <87r5wj9p7q.fsf@deeprootsystems.com>
References: <4A5C7391.5050604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:45864 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbZGNQ6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 12:58:06 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1048956wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2009 09:58:04 -0700 (PDT)
In-Reply-To: <4A5C7391.5050604@nokia.com> (Roger Quadros's message of "Tue\, 14 Jul 2009 15\:01\:21 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> Hi Kevin,
>
>  Off mode does not seem to work on RX51 on latest PM branch. I get a
> reboot if I set enable_off_mode and sleep_while_idle and I wait for
> timeout.
>
>  Does it work on other platforms?
>

Yes, I tested on SDP, omap3evm, Beagle, Overo and RX51.

On RX51, I'm using omap3_pm_defconfig with the debug UART changed to
UART3 and things work fine here.

I using rootfs from latest fiasco image, and it drops me into an early
shell because /sbin/preinit fails in various ways. Note that I'm using
an S2.0 GP board.  Note also that I modified /sbin/preinit to launch
another getty on ttyS2 so I get a shell since newer kernels ignore the
ATAGs passed by nolo.

Below is a console log of my boot so you can see what is going on.
Because /sbin/preinit enables off-mode and sleep_while_idle, I just
let it boot and it seems to work.

Kevin


40VNOLO X-Loader (v1.4.1, Mar 25 2009)
Secondary image size 94388
Booting secondary
[   0.001] Nokia OMAP Loader v1.4.1 (Mar 25 2009) running on Nokia N00 S2.0 (RX-51)
[   0.011] I2C v3.12
[   0.016] System DMA v4.0
[   0.020] OneNAND device ID 0040, version ID 0121 (256 MiB, 66 MHz)
[   0.054]   OneNAND blocks unlocked in 28034 us
[   0.059]   Flash id: ec4021
[   0.073] Partition table successfully read
[   0.081] Forcing power key boot reason (R&D flag set)
[   0.086] Reset reason: pwr_key
[   0.089] McSPI v2.1
[   0.092] LP5523 found at I2C bus 2, address 0x32
[   0.099] SMB138C: Not loading driver (version reg. 0x4a)
[   0.104] BQ24150 (rev. 2) found on I2C bus 1, address 0x6b
[   0.110] SSI version 1.0
[   0.116] Battery voltage 3.668 V, BSI: 56
[   0.122] Disabling charging (no battery present)
[   0.128] Initializing LCD panel
[   0.131]   Detecting LCD panel moscow
[   0.135]     Panel ID: 298b5c
[   0.138]   Detected LCD panel: l4f00311
[   0.142] DISPC: version 3.0
[   0.147]   LCD pixel clock 19200 kHz
[   0.178]   Logo drawn in 5 ms (11700 kB/s)
[   0.286] Initializing USB
[   0.290]   USB host detected
[   0.293]   Entering USB loop
[   0.345] USB suspend signaling detected
[   0.497] USB reset received
[   0.569] SETUP: RD STD DEVICE    GET_DESCRIPTOR     DEVICE (value 00, index 0000, length 64 bytes)
[   0.583] USB reset received
[   0.653] SETUP: WR STD DEVICE    SET_ADDRESS        value 002d index 0000 length 0000
[   0.680] SETUP: RD STD DEVICE    GET_DESCRIPTOR     DEVICE (value 00, index 0000, length 18 bytes)
[   0.689] SETUP: RD STD DEVICE    GET_DESCRIPTOR     CONFIGURATION (value 00, index 0000, length 9 bytes)
[   0.700] SETUP: RD STD DEVICE    GET_DESCRIPTOR     CONFIGURATION (value 00, index 0000, length 94 bytes)
[   0.710] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 00, index 0000, length 255 bytes)
[   0.720] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 02, index 0409, length 255 bytes)
[   0.730] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 01, index 0409, length 255 bytes)
[   0.741] SETUP: WR STD DEVICE    SET_CONFIGURATION  value 0001 index 0000 length 0000
[   0.749] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 03, index 0409, length 255 bytes)
[   0.760] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 04, index 0409, length 255 bytes)
[   0.774] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 04, index 0409, length 255 bytes)
[   0.787] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 04, index 0409, length 255 bytes)
[   0.801] SETUP: WR STD INTERFACE SET_INTERFACE      value 0001 index 0002 length 0000
[   0.809] Flashing interface selected
[   0.813] SETUP: RD STD DEVICE    GET_DESCRIPTOR     STRING (value 04, index 0409, length 255 bytes)
[   0.823] SETUP: RD VND DEVICE    req 01 value 0000 index 0000 length 0004
[   0.830] Flashing mode entered
[   0.833] SETUP: RD VND DEVICE    req 01 value 0000 index 0000 length 0004
[   0.840] SETUP: RD VND DEVICE    req 04 value 0000 index 0000 length 0200
[   0.848] SETUP: RD VND DEVICE    req 03 value 0000 index 0000 length 0004
[   0.856] SETUP: WR VND DEVICE    req 12 value 0000 index 0000 length 0012
[   0.864] SETUP: RD VND DEVICE    req 14 value 0000 index 0000 length 0200
[   0.872] SETUP: WR VND DEVICE    req 42 value 0000 index 0000 length 001b
[   0.879] Receiving kernel (length 1822976)
[   0.941] Image successfully received
[   1.042] SETUP: WR VND DEVICE    req 82 value 0000 index 0000 length 0092
[   1.050] SETUP: WR STD INTERFACE SET_INTERFACE      value 0000 index 0002 length 0000
[   1.100] Boot requested (normal mode)
Kernel command line: init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=ttyS2,115200
[   1.120] Serial console disabled
Uncompressing Linux....................................................................................................................... done, booting the kernel.
Linux version 2.6.30-omap1-sdp-pm-default-06222-ge0cffc2 (khilman@vence) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-66) ) #6 PREEMPT Tue Jul 14 09:48:13 PDT 2009
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Nokia RX-51 board
Ignoring unrecognised tag 0x414f4d50
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=ttyS2,115200
NR_IRQS:402
Clocking rate (Crystal/DPLL/ARM core): 19.2/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
dpll3_m2_clk rate change failed: -22
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 1024 (order: 10, 4096 bytes)
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255744KB available (3376K code, 349K data, 120K init, 0K highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 544 bytes
regulator: core version 0.5
NET: Registered protocol family 16
MUX: setup U8_34XX_GPIO54_DOWN (0xd80020b4): 0x0007 -> 0x010c
MUX: setup G25_34XX_GPIO86_OUT (0xd80020fc): 0x0007 -> 0x0004
MUX: setup H19_34XX_GPIO164_OUT (0xd800219c): 0x0007 -> 0x0004
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
twl4030_mmc_init:332
twl4030_mmc_init:347
twl4030_mmc_init:347
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VAUX2: 1800 mV normal standby
regulator: VSIM: 1800 mV normal standby
regulator: VAUX1: 2800 mV normal standby
regulator: VAUX3: 2800 <--> 3000 mV normal standby
regulator: VAUX4: 2800 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev3.12 at 100 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
console [ttyMTD0] enabled
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 500
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at d0860300 IRQ 214 [nowait]
eth0: Invalid ethernet MAC address.  Please set using ifconfig
OneNAND driver initializing
omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000
Muxed OneNAND 256MB 1.8V 16-bit (0x40)
OneNAND version = 0x0121
Scanning device for bad blocks
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 247 at 0x01ee0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 287 at 0x023e0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 294 at 0x024c0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 311 at 0x026e0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 405 at 0x032a0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 711 at 0x058e0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 784 at 0x06200000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 1310 at 0x0a3c0000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 1424 at 0x0b200000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 1432 at 0x0b300000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 1624 at 0x0cb00000
onenand_bbt_wait: ecc error = 0x2222, controller error 0x2400
Bad eraseblock 1670 at 0x0d0c0000
Creating 6 MTD partitions on "omap2-onenand":
0x000000000000-0x000000020000 : "bootloader"
0x000000020000-0x000000080000 : "config"
0x000000080000-0x0000000c0000 : "log"
mtdoops: Attached to MTD device 2
0x0000000c0000-0x0000002c0000 : "kernel"
0x0000002c0000-0x0000004c0000 : "initfs"
0x0000004c0000-0x000010000000 : "rootfs"
UBI: attaching mtd5 to ubi0
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
UBI: attached mtd5 to ubi0
UBI: MTD device name:            "rootfs"
UBI: MTD device size:            251 MiB
UBI: number of good PEBs:        1998
UBI: number of bad PEBs:         12
UBI: max. allowed volumes:       128
UBI: wear-leveling threshold:    4096
UBI: number of internal volumes: 1
UBI: number of user volumes:     1
UBI: available PEBs:             0
UBI: total number of reserved PEBs: 1998
UBI: number of PEBs reserved for bad PEB handling: 19
UBI: max/mean erase counter: 27/11
cpuidle: using governor ladder
cpuidle: using governor menu
UBI: background thread "ubi_bgt0d" started, PID 378
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
SmartReflex driver initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VCAM_ANA_28 on
regulator_init_complete: incomplete constraints, leaving VMMC2_30 on
regulator_init_complete: incomplete constraints, leaving V28 on
regulator_init_complete: incomplete constraints, leaving VCSI on
regulator_init_complete: incomplete constraints, leaving VDAC on
regulator_init_complete: incomplete constraints, leaving VMMC1 on
UBIFS: recovery needed
UBIFS: recovery completed
UBIFS: mounted UBI device 0, volume 0, name "rootfs"
UBIFS: file system size:   253403136 bytes (247464 KiB, 241 MiB, 1964 LEBs)
UBIFS: journal size:       9033728 bytes (8822 KiB, 8 MiB, 71 LEBs)
UBIFS: media format:       w4/r0 (latest is w4/r0)
UBIFS: default compressor: lzo
UBIFS: reserved for root:  4190434 bytes (4092 KiB)
VFS: Mounted root (ubifs filesystem) on device 254:1.
Freeing init memory: 120K
BusyBox v1.10.2 (Debian 3:1.10.2.legal-1osso26+0m5) multi-call binary

Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

getbootstate: R&D mode enabled
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.30-omap1-sdp-pm-default-06222-ge0cffc2/modules.dep: No such file or directory

Unable to open frame buffer device /dev/fb0
Unable to initialize. Exiting
/sbin/preinit: line 320: cannot open /proc/component_version: no such file
/sbin/preinit: line 320: cannot create /sys/devices/platform/gpio-switch/sleep_ind/state: nonexistent directory
/sbin/preinit: line 324: cannot create /sys/devices/platform/gpio-switch/cmt_bsi/state: nonexistent directory
getbootstate: Could not open /proc/component_version - No such file or directory
getbootstate: Could not open /proc/bootreason - No such file or directory
getbootstate: Bootreason could not be read
getbootstate: Entering state 'MALF'.
Starting shell



BusyBox v1.10.2 (Debian 3:1.10.2.legal-1osso26+0m5) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ # cat /debug/pm_debug/count 
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
neon_pwrdm (ON),OFF:0,RET:0,INA:4,ON:5
mpu_pwrdm (ON),OFF:0,RET:0,INA:4,ON:5
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (5)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ # echo mem > /sys/power/state 
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
Successfully put all powerdomains to target state
Restarting tasks ... done.
/ # cat /sys/power/enable_off_mode 
1
/ # cat /sys/power/sleep_while_idle 
1

[ *** here I waited about 10-15 seconds *** ]

/ # cat /debug/pm_debug/count 
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
per_pwrdm (ON),OFF:6,RET:0,INA:0,ON:7
dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
core_pwrdm (ON),OFF:6,RET:0,INA:0,ON:7
neon_pwrdm (ON),OFF:6,RET:0,INA:7,ON:14
mpu_pwrdm (ON),OFF:6,RET:0,INA:7,ON:14
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (5)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)
/ # 
