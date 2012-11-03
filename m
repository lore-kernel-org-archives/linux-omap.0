From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 3 Nov 2012 22:39:26 +0100
Message-ID: <CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
	<CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
	<87fw4u3oh5.fsf@deeprootsystems.com>
	<CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
	<alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
	<CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33439 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2KCVj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 17:39:27 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4821924vbb.19
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 14:39:26 -0700 (PDT)
In-Reply-To: <CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Thu, Nov 1, 2012 at 8:51 AM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> Hi Paul,
>
> On Wed, Oct 31, 2012 at 10:44 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> Hi
>>
>> On Wed, 31 Oct 2012, Jean Pihet wrote:
>>
>>> Paul,
>>> Could you please check with the 2 calls to PM QoS from the I2C code
>>> commented out? This will rule out the PM QoS impact.
>>
>> Will be happy to do a test run for you, after the boot log from your=
 local
>> test run is posted:
>>
>> http://marc.info/?l=3Dlinux-arm-kernel&m=3D135167153510814&w=3D2

Here are some more details after investigation.

The setup is as identical as possible to yours:
- U-Boot 2011.06-dirty (Sep 04 2012 - 17:06:58) from
http://www.pwsan.com/tmp/3530es3beagle-MLO-u-boot-20121023.tar.bz2.
  Please note that the MLO image does not run on my board and so I had
to use my known-to-work image.
- 3.7.0-rc1 kernel, omap2plus_defconfig,
- same kernel parameters,
- Angstrom rootfs from
http://www.pwsan.com/tmp/20121023-beagleboard-angstrom-userspace.tar.bz=
2

The differences are:
- OMAP revision (ES2.1 vs ES3.0),
- Beagleboard revision (B5 vs Cx),
- RAM amount (128 vs 256MB),
- compiler: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) vs 4.5.2
(Sourcery G++ Lite 2011.03-41)

The result is that I could reproduce the issue but it happens much
more rarely on my side (only once vs quasi 100% on ~50 boot cycles).
The issue is triggered by running 'hwclock --systohc'  while the
system is heavily loaded (running depmod etc.). The system recovers
nicely after the issue, the RTC can be used correctly later on.

Here is the log:

U-Boot 2011.06-dirty (Sep 04 2012 - 17:06:58)

OMAP3530-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
OMAP3 Beagle board + LPDDR/NAND
I2C:   ready
DRAM:  128 MiB
NAND:  256 MiB
MMC:   OMAP SD/MMC: 0
In:    serial
Out:   serial
Err:   serial
Beagle Rev Ax/Bx
timed out in wait_for_pin: I2C_STAT=3D0
I2C read: I/O error
Unrecognized expansion board: 0
Die ID #0f6000020000000004013ef109008009
Hit any key to stop autoboot:  0
reading uimage

4148008 bytes read
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-3.7.0-rc1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4147944 Bytes =3D 4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc1 (def@rachael) (gcc version
4.5.2 (Sourcery G++ Lite 2011.03-41) ) #2 SMP Sat Nov 3 21:56:11 CET
2012
[    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT
nonaliasing instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e40000 s12928 r8192 d157=
44 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32256
[    0.000000] Kernel command line: console=3DttyO2,230400n8
root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 127MB =3D 127MB total
[    0.000000] Memory: 115316k/115316k available, 15756k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07037dc   (7150 kB)
[    0.000000]       .init : 0xc0704000 - 0xc0754280   ( 321 kB)
[    0.000000]       .data : 0xc0756000 - 0xc07e15a0   ( 558 kB)
[    0.000000]        .bss : 0xc07e15c4 - 0xc0d3bfac   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
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
[    0.001190] Calibrating delay loop... 324.52 BogoMIPS (lpj=3D1265664=
)
[    0.106964] pid_max: default: 32768 minimum: 301
[    0.107757] Security Framework initialized
[    0.108001] Mount-cache hash table entries: 512
[    0.114196] CPU: Testing write buffer coherency: ok
[    0.115478] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.115600] Setting up static identity map for 0x8051ebe0 - 0x8051ec=
50
[    0.119537] Brought up 1 CPUs
[    0.119567] SMP: Total of 1 processors activated (324.52 BogoMIPS).
[    0.142547] pinctrl core: initialized pinctrl subsystem
[    0.151123] regulator-dummy: no parameters
[    0.154083] NET: Registered protocol family 16
[    0.155853] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.158386] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.175537] OMAP GPIO hardware version 2.5
[    0.202301] omap_mux_init: Add partition: #1: core, flags: 0
[    0.205810] OMAP3 Beagle Rev: Ax/Bx
[    0.236938] Reprogramming SDRC clock to 332000000 Hz
[    0.238708] Found NAND on CS0
[    0.238739] Registering NAND on CS0
[    0.240417] find_device_opp: Invalid parameters
[    0.240661] find_device_opp: Invalid parameters
[    0.240722] find_device_opp: Invalid parameters
[    0.240783] find_device_opp: Invalid parameters
[    0.240844] find_device_opp: Invalid parameters
[    0.241149] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.262451]  omap-mcbsp.2: alias fck already exists
[    0.263702]  omap-mcbsp.3: alias fck already exists
[    0.269287] OMAP DMA hardware revision 4.0
[    0.275695]  arm-pmu: alias fck already exists
[    0.372833] bio: create slab <bio-0> at 0
[    0.504943] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.513244] SCSI subsystem initialized
[    0.517700] usbcore: registered new interface driver usbfs
[    0.518524] usbcore: registered new interface driver hub
[    0.519470] usbcore: registered new device driver usb
[    0.542327] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.543212] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.547882] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs =
354..371
[    0.560913] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.564697] vdd_core: 600 <--> 1450 mV normal
[    0.568145] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.572204] VDAC: 1800 mV normal standby
[    0.575622] VDVI: 1800 mV normal standby
[    0.579803] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.581176] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.584350] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 100 kHz
[    0.595794] Switching to clocksource 32k_counter
[    0.784149] NET: Registered protocol family 2
[    0.787017] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.787414] TCP bind hash table entries: 4096 (order: 5, 147456 byte=
s)
[    0.790130] TCP: Hash tables configured (established 4096 bind 4096)
[    0.790435] TCP: reno registered
[    0.790496] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.790863] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.792205] NET: Registered protocol family 1
[    0.794158] RPC: Registered named UNIX socket transport module.
[    0.794189] RPC: Registered udp transport module.
[    0.794219] RPC: Registered tcp transport module.
[    0.794219] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.795715] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.796173] CPU PMU: probing PMU on CPU 0
[    0.796386] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver,
5 counters available
[    1.017608] VFS: Disk quotas dquot_6.5.2
[    1.018005] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.022155] NFS: Registering the id_resolver key type
[    1.022857] Key type id_resolver registered
[    1.022888] Key type id_legacy registered
[    1.023101] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red =
Hat, Inc.
[    1.023986] msgmni has been set to 225
[    1.029388] io scheduler noop registered
[    1.029449] io scheduler deadline registered
[    1.029571] io scheduler cfq registered (default)
[    1.034118] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.044128] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a =
OMAP UART0
[    1.047027] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 89) is a =
OMAP UART1
[    1.049133] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a =
OMAP UART2
[    1.408569] console [ttyO2] enabled
[    1.459045] brd: module loaded
[    1.491302] loop: module loaded
[    1.504882] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.509094] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba
(Micron NAND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64
[    1.515777] Creating 5 MTD partitions on "omap2-nand.0":
[    1.518737] 0x000000000000-0x000000080000 : "X-Loader"
[    1.531433] 0x000000080000-0x000000260000 : "U-Boot"
[    1.542541] 0x000000260000-0x000000280000 : "U-Boot Env"
[    1.551788] 0x000000280000-0x000000680000 : "Kernel"
[    1.564239] 0x000000680000-0x000010000000 : "File System"
[    1.793273] OneNAND driver initializing
[    1.812469] usbcore: registered new interface driver asix
[    1.816345] usbcore: registered new interface driver cdc_ether
[    1.820343] usbcore: registered new interface driver smsc95xx
[    1.824310] usbcore: registered new interface driver net1080
[    1.828124] usbcore: registered new interface driver cdc_subset
[    1.832153] usbcore: registered new interface driver zaurus
[    1.835937] usbcore: registered new interface driver cdc_ncm
[    1.842102] usbcore: registered new interface driver cdc_wdm
[    1.845184] Initializing USB Mass Storage driver...
[    1.848754] usbcore: registered new interface driver usb-storage
[    1.852020] USB Mass Storage support registered.
[    1.855407] usbcore: registered new interface driver usbtest
[    1.860931] mousedev: PS/2 mouse device common for all mice
[    1.872131] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input=
0
[    1.882110] twl_rtc twl_rtc: Enabling TWL-RTC
[    1.890533] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.897399] i2c /dev entries driver
[    1.903747] Driver for 1-wire Dallas network protocol.
[    1.911224] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    1.916412] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.920318] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    1.929351] omap_hsmmc omap_hsmmc.0: multiblock reads disabled due
to 35xx erratum 2.1.1.128; MMC read performance may suffer
[    1.936065] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    1.939361] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    1.943084] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    2.332794] usbcore: registered new interface driver usbhid
[    2.335906] usbhid: USB HID core driver
[    2.343688] oprofile: using arm/armv7
[    2.346954] TCP: cubic registered
[    2.348754] Initializing XFRM netlink socket
[    2.351257] NET: Registered protocol family 17
[    2.353790] NET: Registered protocol family 15
[    2.356872] Key type dns_resolver registered
[    2.359313] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 1
[    2.376007] omap2_set_init_voltage: unable to find boot up OPP for
vdd_mpu_iva
[    2.380218] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    2.384307] PM: no software I/O chain control; some wakeups may be l=
ost
[    2.388549] ThumbEE CPU extension supported.
[    2.435852] clock: disabling unused clocks to save power
[    2.445678] VDVI: incomplete constraints, leaving on
[    2.448852] VDAC: incomplete constraints, leaving on
[    2.456817] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put1
[    2.465118] twl_rtc twl_rtc: setting system clock to 2010-07-22
02:43:19 UTC (1279766599)
[    2.475555] Waiting for root device /dev/mmcblk0p2...
[    2.499633] mmc0: new SD card at address e624
[    2.506134] mmcblk0: mmc0:e624 SD01G 968 MiB
[    2.520111]  mmcblk0: p1 p2
[    4.051177] kjournald starting.  Commit interval 5 seconds
[    4.059448] EXT3-fs (mmcblk0p2): using internal journal
[    4.067016] EXT3-fs (mmcblk0p2): recovery complete
[    4.069641] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[    4.074005] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    4.078399] Freeing init memory: 320K
INIT: version 2.86 booting
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
Remounting root file system...
mount: according to mtab, /proc is already mounted on /proc

WARNING: Couldn't open directory /lib/modules/3.7.0-rc1: No such file
or directory
=46ATAL: Could not open /lib/modules/3.7.0-rc1/modules.dep.temp for
writing: No such file or directory
root: mount: mount point /proc/bus/usb does not exist
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... modprobe: FATAL: Could not load
/lib/modules/3.7.0-rc1/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

ifconfig: SIOCGIFFLAGS: No such device
modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

eth0      No such device

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

udhcpc: SIOCGIFINDEX: No such device
done.
Starting portmap daemon: portmap.
=46ri Jul 22 02:12:00 UTC 2011
[   33.424743] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   34.440338] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   34.443603] twl: i2c_read failed to transfer all messages
[   34.446533] twl_rtc: Could not read TWLregister D - error -110
[   34.449768] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, er=
ror -110
INIT: Entering runlevel: 5
ALSA: Restoring mixer settings...
/usr/sbin/alsactl: load_state:1327: No soundcards found...
Starting Dropbear SSH server: modprobe: FATAL: Could not load
/lib/modules/3.7.0-rc1/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc1/modules.dep: No
such file or directory

dropbear.
Starting advanced power management daemon: No APM support in kernel
(failed.)
Starting system message bus: dbus.
Starting syslogd/klogd: start-stop-daemon: lseek: Invalid argument
 * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
[ ok ]
Starting Bluetooth subsystem:modprobe: FATAL: Could not load
/lib/modules/3.7.0-rc1/modules.dep: No such file or directory
 hcid
 hid2hci.

=2E-------.
|       |                  .-.
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution beagleboard ttyO2

Angstrom 2008.1-test-20080712 beagleboard ttyO2

beagleboard login: root
login[2013]: root login  on `ttyO2'

root@beagleboard:~# hwclock -s
root@beagleboard:~# cat
/sys/devices/platform/omap_i2c.1/i2c-1/1-004b/twl_rtc/rtc/rtc0/date
2011-07-22
root@beagleboard:~# cat
/sys/devices/platform/omap_i2c.1/i2c-1/1-004b/twl_rtc/rtc/rtc0/time
02:12:00
root@beagleboard:~#

>>
>>
>> - Paul

More investigation on-going, so more to come!

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
