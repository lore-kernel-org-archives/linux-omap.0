From: Paul Walmsley <paul@pwsan.com>
Subject: DSS and USBHOST powerdomains not entering low-power states on 37xx
 EVM
Date: Fri, 3 Aug 2012 14:05:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208031355450.28888@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1890290751-1344024355=:28888"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59360 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2HCUF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 16:05:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1890290751-1344024355=:28888
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi

On v3.6-rc1 on 37xx EVM, DSS and USBHOST powerdomains aren't entering=20
low-power states.  Test log is below.


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
Hit any key to stop autoboot:  0=20
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
Bytes transferred =3D 3254088 (31a748 hex)
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-3.6.0-rc1-00005-gacbfd56
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3254024 Bytes =3D 3.1 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-rc1-00005-gacbfd56 (paul@nozomi) (gcc=20
version 4.5.1 (Sourcery G++ Lite 2010.09-50) )
 #1 SMP Fri Aug 3 10:28:26 MDT 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),=20
cr=3D10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing=20
instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e0d000 s12736 r8192 d15936=
=20
u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. =20
Total pages: 64768
[    0.000000] Kernel command line: console=3DttyO0,115200n8 earlyprintk=20
root=3D/dev/nfs nfsroot=3D192.168.57.1:/srv/nfs4/roo
tfs2 nfsrootdebug ip=3Ddhcp init=3D/bin/sh
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=20
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536=20
bytes)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 246492k/246492k available, 15652k reserved, 0K=20
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
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D1.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96=20
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=20
every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
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
[    0.000946] Calibrating delay loop... 397.57 BogoMIPS (lpj=3D1554432)
[    0.109344] pid_max: default: 32768 minimum: 301
[    0.109924] Security Framework initialized
[    0.110137] Mount-cache hash table entries: 512
[    0.115661] CPU: Testing write buffer coherency: ok
[    0.116577] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.116668] Setting up static identity map for 0x8040c0d8 - 0x8040c148
[    0.119110] Brought up 1 CPUs
[    0.119140] SMP: Total of 1 processors activated (397.57 BogoMIPS).
[    0.142242] dummy:=20
[    0.144622] NET: Registered protocol family 16
[    0.145507] DMA: preallocated 256 KiB pool for atomic coherent=20
allocations
[    0.146545] GPMC revision 5.0
[    0.146789] gpmc: irq-20 could not claim: err -22
[    0.158538] OMAP GPIO hardware version 2.5
[    0.176635] omap_mux_init: Add partition: #1: core, flags: 0
[    0.193023] _omap_mux_get_by_name: Could not find signal=20
uart4_rx.uart4_rx
[    0.202178] Reprogramming SDRC clock to 400000000 Hz
[    0.202209] dpll3_m2_clk rate change failed: -22
[    0.203704] Found NAND on CS0
[    0.203735] Registering NAND on CS0
[    0.205841] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.223083]  omap-mcbsp.2: alias fck already exists
[    0.224029]  omap-mcbsp.3: alias fck already exists
[    0.229431] OMAP DMA hardware revision 5.0
[    0.300598] bio: create slab <bio-0> at 0
[    0.304412] fixed-dummy:=20
[    0.311401] SCSI subsystem initialized
[    0.314483] usbcore: registered new interface driver usbfs
[    0.315124] usbcore: registered new interface driver hub
[    0.316009] usbcore: registered new device driver usb
[    0.318542] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.330291] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.330993] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.333770] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs=20
336..353
[    0.346771] VIO: 1800 mV normal standby
[    0.349334] vdd_mpu_iva: 600 <--> 1450 mV normal=20
[    0.352264] vdd_core: 600 <--> 1450 mV normal=20
[    0.354705] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.357757] VDAC: 1800 mV normal standby
[    0.360992] VAUX2_4030: 2800 mV normal standby
[    0.364135] VPLL2: 1800 mV normal standby
[    0.366851] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.383148] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.398590] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.408111] Switching to clocksource 32k_counter
[    0.534790] NET: Registered protocol family 2
[    0.537048] TCP established hash table entries: 8192 (order: 4, 65536=20
bytes)
[    0.537567] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.542694] TCP: Hash tables configured (established 8192 bind 8192)
[    0.542907] TCP: reno registered
[    0.542938] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.543273] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.544342] NET: Registered protocol family 1
[    0.545806] RPC: Registered named UNIX socket transport module.
[    0.545837] RPC: Registered udp transport module.
[    0.545837] RPC: Registered tcp transport module.
[    0.545867] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.547119] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.741790] VFS: Disk quotas dquot_6.5.2
[    0.742156] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.744781] NFS: Registering the id_resolver key type
[    0.745330] Key type id_resolver registered
[    0.745361] Key type id_legacy registered
[    0.745544] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
=20
Inc.
[    0.746215] msgmni has been set to 481
[    0.750946] io scheduler noop registered
[    0.750976] io scheduler deadline registered
[    0.751068] io scheduler cfq registered (default)
[    0.754852] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.762573] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
=20
UART0
[    1.425170] console [ttyO0] enabled
[    1.430816] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
=20
UART1
[    1.440368] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
=20
UART2
[    1.449676] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OMAP=
=20
UART3
[    1.495605] brd: module loaded
[    1.521331] loop: module loaded
[    1.532928] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.540679] NAND device: Manufacturer ID: 0xad, Chip ID: 0xbc (Hynix=20
NAND 512MiB 1,8V 16-bit), page size: 2048, OOB=20
size: 64
[    1.552673] Creating 5 MTD partitions on "omap2-nand.0":
[    1.558349] 0x000000000000-0x000000080000 : "X-Loader"
[    1.571746] 0x000000080000-0x000000240000 : "U-Boot"
[    1.584289] 0x000000240000-0x000000280000 : "U-Boot Env"
[    1.595031] 0x000000280000-0x000000780000 : "Kernel"
[    1.609527] 0x000000780000-0x000020000000 : "File system"
[    2.060089] OneNAND driver initializing
[    2.068786] spi spi1.0: no RX DMA engine channel for McSPI
[    2.074890] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status -11
[    2.081787] omap2_mcspi omap2_mcspi.1: can't create new device for=20
ads7846
[    2.098480] smsc911x: Driver version 2008-10-21
[    2.113037] libphy: smsc911x-mdio: probed
[    2.117523] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC=20
LAN8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    2.129089] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:7e:99:42
[    2.137329] usbcore: registered new interface driver asix
[    2.143798] usbcore: registered new interface driver cdc_ether
[    2.150512] usbcore: registered new interface driver net1080
[    2.157257] usbcore: registered new interface driver cdc_subset
[    2.164245] usbcore: registered new interface driver zaurus
[    2.170898] usbcore: registered new interface driver cdc_ncm
[    2.179290] usbcore: registered new interface driver cdc_wdm
[    2.185394] Initializing USB Mass Storage driver...
[    2.191284] usbcore: registered new interface driver usb-storage
[    2.197631] USB Mass Storage support registered.
[    2.203887] usbcore: registered new interface driver libusual
[    2.210754] usbcore: registered new interface driver usbtest
[    2.218627] mousedev: PS/2 mouse device common for all mice
[    2.227325] input: TWL4030 Keypad as=20
/devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    2.245971] input: twl4030_pwrbutton as=20
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    2.259033] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.268218] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.276367] i2c /dev entries driver
[    2.284240] Driver for 1-wire Dallas network protocol.
[    2.293426] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60=
=20
sec
[    2.302093] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.308898] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.319854] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    2.326293] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine=20
channel 62
[    2.336822] usbcore: registered new interface driver usbhid
[    2.352355] oprofile: using timer interrupt.
[    2.357788] TCP: cubic registered
[    2.361267] Initializing XFRM netlink socket
[    2.365997] NET: Registered protocol family 17
[    2.370880] NET: Registered protocol family 15
[    2.375976] Key type dns_resolver registered
[    2.380737] VFP support v0.3: implementor 41 architecture 3 part 30=20
variant c rev 3
[    2.400665] ThumbEE CPU extension supported.
[    2.441802] clock: disabling unused clocks to save power
[    2.452972] VMMC1: incomplete constraints, leaving on
[    2.461303] twl_rtc twl_rtc: setting system clock to 2000-01-01=20
00:43:40 UTC (946687420)
[    2.472717] smsc911x smsc911x.0: eth0: SMSC911x/921x identified at=20
0xd085a000, IRQ: 272
[    2.979248] Sending DHCP requests .., OK
[    5.979644] IP-Config: Got DHCP answer from 0.0.0.0, my address is=20
192.168.57.131
[    5.988281] IP-Config: Complete:
[    5.991699]      device=3Deth0, addr=3D192.168.57.131, mask=3D255.255.25=
5.0,=20
gw=3D255.255.255.255
[    6.000366]      host=3D192.168.57.131, domain=3D, nis-domain=3D(none)
[    6.006744]      bootserver=3D0.0.0.0, rootserver=3D192.168.57.1, rootpa=
th=3D
[    6.042083] VFS: Mounted root (nfs filesystem) on device 0:11.
[    6.049072] Freeing init memory: 308K
/bin/sh: can't access tty; job control turned off
# mount -t sysfs none /sys
# mount -t debugfs none /debug
#=20
# echo mem > /sys/power/state
[   35.068359] PM: Syncing filesystems ... done.
[   35.083038] Freezing user space processes ... (elapsed 0.00 seconds)=20
done.
[   35.090698] Freezing remaining freezable tasks ... (elapsed 0.02=20
seconds) done.
[   35.122833] Suspending console(s) (use no_console_suspend to debug)
[   35.144409] PM: suspend of devices complete after 11.260 msecs
[   35.147369] PM: late suspend of devices complete after 2.929 msecs
[   35.152465] PM: noirq suspend of devices complete after 5.096 msecs
[   35.152526] Disabling non-boot CPUs ...
[   36.958343] Successfully put all powerdomains to target state
[   36.960662] PM: noirq resume of devices complete after 2.166 msecs
[   36.964050] PM: early resume of devices complete after 1.892 msecs
[   36.973388] PM: resume of devices complete after 9.185 msecs
[   37.025207] Restarting tasks ... done.
# cat  /debug/pm_debug/count
usbhost_pwrdm=20
(ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm=20
(ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2=
-OFF:0
per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:673,INA:0,ON:674,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:673,INA:0,ON:674,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,=
RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-ME
MBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (22)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (24)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
#=20
--155748971-1890290751-1344024355=:28888--
