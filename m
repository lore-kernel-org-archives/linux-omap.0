From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 2 May 2012 01:47:18 -0700
Message-ID: <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41569 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab2EBIrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 04:47:20 -0400
In-Reply-To: <CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

On Mon, Mar 19, 2012 at 6:34 AM, Raja, Govindraj <govindraj.raja@ti.com=
> wrote:
> On Mon, Mar 19, 2012 at 12:12 PM, Keshava Munegowda
> <keshava_mgowda@ti.com> wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> It is observed that the echi ports of 3430 sdp board
>> are not working due to the random timing of programming
>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> If the PHYs are reset at during usbhs core driver, host ports will
>> not work because EHCI driver is loaded after the resetting PHYs.
>> The PHYs should be in reset state while initializing the EHCI
>> controller.
>> The code which does the GPIO pins associated with the PHYs
>> are programmed to reset is moved from the USB host core driver
>> to EHCI driver.
>
> I tested on beagle xm where gpio nreset is requested from
> board file.
> (Basic enumertaion after gpio nreset seems to work fine,
> Hub and smsc lan chip get detected afetr boot up)
>

What base did you test this on top of? my xM is failing USB-wise when
I apply this on v3.3.3 (with the UART mux fix patch) and where it is
applied within master (3.4-rc4, again, with the UART mux fix patch).
Additionally, reverting this patch from 3.4-rc5 causes rc5 to work
properly.

3.4-rc5 with 1fcb57d0f6e11 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY
reset issue' reverted:

## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.4.0-rc5-ktest-00001-g433
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3398392 Bytes =3D 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc5-ktest-00001-g433e357
(russ@russ-laptop) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#92 SMP Wed May 2 01:39:19 MST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Reserving 25165824 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c101b000 s11520 r8192 d130=
56 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 123648
[    0.000000] Kernel command line: tty1 console=3Dtty0
console=3DttyO2,115200n8 consoleblank=3D0 mpurate=3D1000000 vram=3D24M
omapfb.mode=3Dhd720 omapfb.vram=3D0:8M,1:4M,2:4M root=3D/dev/mmcblk0p2
ip=3Doff rw rootwait
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 487MB =3D 487MB total
[    0.000000] Memory: 481768k/481768k available, 42520k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05dd28c   (5973 kB)
[    0.000000]       .init : 0xc05de000 - 0xc062bd00   ( 312 kB)
[    0.000000]       .data : 0xc062c000 - 0xc06bdb58   ( 583 kB)
[    0.000000]        .bss : 0xc06bdb7c - 0xc0c12060   (5458 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
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
[    0.003601] Calibrating delay loop... 515.72 BogoMIPS (lpj=3D2015232=
)
[    0.074249] pid_max: default: 32768 minimum: 301
[    0.074981] Security Framework initialized
[    0.075256] Mount-cache hash table entries: 512
[    0.080139] CPU: Testing write buffer coherency: ok
[    0.081085] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.081176] Setting up static identity map for 0x8042ed60 - 0x8042ed=
d0
[    0.082763] Brought up 1 CPUs
[    0.082824] SMP: Total of 1 processors activated (515.72 BogoMIPS).
[    0.135711] dummy:
[    0.137725] NET: Registered protocol family 16
[    0.139007] GPMC revision 5.0
[    0.148895] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.149414] OMAP GPIO hardware version 2.5
[    0.150421] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.151855] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.153228] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.154571] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.156280] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.162872] omap_mux_init: Add partition: #1: core, flags: 0
[    0.165527] OMAP3 Beagle Rev: xM C
[    0.177917] Reprogramming SDRC clock to 400000000 Hz
[    0.178009] dpll3_m2_clk rate change failed: -22
[    0.180725]  usbhs_omap: alias fck already exists
[    0.181457] Found NAND on CS0
[    0.181518] Registering NAND on CS0
[    0.182800] Unable to get DVI reset GPIO
[    0.183319] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.197448]  omap-mcbsp.2: alias fck already exists
[    0.198272]  omap-mcbsp.3: alias fck already exists
[    3.461212] clock: dpll1_ck failed transition to 'locked'
[    3.462677] Switched to new clocking rate (Crystal/Core/MPU): 26.0/4=
00/2 MHz
[    3.465911] OMAP DMA hardware revision 5.0
[    3.653411] bio: create slab <bio-0> at 0
[    3.677307] SCSI subsystem initialized
[    3.682403] omap2_mcspi omap2_mcspi.1: master is unqueued, this is d=
eprecated
[    3.686370] omap2_mcspi omap2_mcspi.2: master is unqueued, this is d=
eprecated
[    3.689453] omap2_mcspi omap2_mcspi.3: master is unqueued, this is d=
eprecated
[    3.692993] omap2_mcspi omap2_mcspi.4: master is unqueued, this is d=
eprecated
[    3.702117] usbcore: registered new interface driver usbfs
[    3.705566] usbcore: registered new interface driver hub
[    3.707672] usbcore: registered new device driver usb
[    3.716003] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    3.740356] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    3.742095] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    3.748657] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs =
336..353
[    3.752899] gpiochip_add: registered GPIOs 192 to 211 on device: twl=
4030
[    3.766815] VUSB1V5: 1500 mV normal standby
[    3.772735] VUSB1V8: 1800 mV normal standby
[    3.778320] VUSB3V1: 3100 mV normal standby
[    3.792083] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    3.804321] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
[    3.809936] VDAC: 1800 mV normal standby
[    3.816040] VDVI: 1800 mV normal standby
[    3.822448] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    3.825469] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    3.851684] Switching to clocksource 32k_counter
[    4.168640] usbhs_omap usbhs_omap: xclk60mhsp1_ck set parentfailed e=
rror:-22
[    4.168823] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed e=
rror:-22
[    4.178253] NET: Registered protocol family 2
[    4.181365] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
[    4.187133] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    4.189575] TCP bind hash table entries: 16384 (order: 7, 589824 byt=
es)
[    4.217346] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    4.217681] TCP: reno registered
[    4.217834] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    4.218841] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    4.221954] NET: Registered protocol family 1
[    4.225921] RPC: Registered named UNIX socket transport module.
[    4.226074] RPC: Registered udp transport module.
[    4.226165] RPC: Registered tcp transport module.
[    4.226287] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    4.229858] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    4.709686] VFS: Disk quotas dquot_6.5.2
[    4.710815] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    4.715942] NFS: Registering the id_resolver key type
[    4.720886] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    4.724212] msgmni has been set to 940
[    4.733642] io scheduler noop registered
[    4.733795] io scheduler deadline registered
[    4.734558] io scheduler cfq registered (default)
[    4.741333] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.760803] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    4.765533] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    4.769805] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    5.555999] console [ttyO2] enabled
[    5.564483] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a =
OMAP UART3
[    5.669647] brd: module loaded
[    5.729187] loop: module loaded
[    5.753723] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    5.762939] No NAND device found
[    5.767425] No NAND device found
[    5.772857] OneNAND driver initializing
[    5.798919] usbcore: registered new interface driver asix
[    5.807006] usbcore: registered new interface driver cdc_ether
[    5.815399] usbcore: registered new interface driver smsc95xx
[    5.823486] usbcore: registered new interface driver net1080
[    5.831420] usbcore: registered new interface driver cdc_subset
[    5.839599] usbcore: registered new interface driver zaurus
[    5.847534] usbcore: registered new interface driver cdc_ncm
[    5.858032] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    5.866607] ehci-omap.0 supply hsusb0 not found, using dummy regulat=
or
[    5.875183] ehci-omap.0 supply hsusb1 not found, using dummy regulat=
or
[    7.892333] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    7.909912] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 1
[    7.919586] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    7.939056] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    7.948822] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    7.956512] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    7.964630] usb usb1: Product: OMAP-EHCI Host Controller
[    7.970642] usb usb1: Manufacturer: Linux
3.4.0-rc5-ktest-00001-g433e357 ehci_hcd
[    7.979064] usb usb1: SerialNumber: ehci-omap.0
[    7.995330] hub 1-0:1.0: USB hub found
[    7.999969] hub 1-0:1.0: 3 ports detected
[    8.043548] usbcore: registered new interface driver cdc_wdm
[    8.050079] Initializing USB Mass Storage driver...
[    8.057678] usbcore: registered new interface driver usb-storage
[    8.064666] USB Mass Storage support registered.
[    8.073242] usbcore: registered new interface driver libusual
[    8.081512] usbcore: registered new interface driver usbtest
[    8.092224] mousedev: PS/2 mouse device common for all mice
[    8.115417] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input=
0
[    8.134277] twl_rtc twl_rtc: Power up reset detected.
[    8.140258] twl_rtc twl_rtc: Enabling TWL-RTC
[    8.154174] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    8.164550] i2c /dev entries driver
[    8.176605] Driver for 1-wire Dallas network protocol.
[    8.191101] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    8.201721] twl4030_wdt twl4030_wdt: Failed to register misc device
[    8.209136] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    8.337707] usb 1-2: new high-speed USB device number 2 using ehci-o=
map
[    8.477539] usbcore: registered new interface driver usbhid
[    8.484039] usbhid: USB HID core driver
[    8.488464] oprofile: hardware counters not available
[    8.494171] oprofile: using timer interrupt.
[    8.501373] TCP: cubic registered
[    8.505065] Initializing XFRM netlink socket
[    8.510406] NET: Registered protocol family 17
[    8.515563] NET: Registered protocol family 15
[    8.521453] Registering the dns_resolver key type
[    8.527557] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    8.536437] ThumbEE CPU extension supported.
[    8.664184] clock: disabling unused clocks to save power
[    8.681579] VDVI: incomplete constraints, leaving on
[    8.687438] VDAC: incomplete constraints, leaving on
[    8.700775] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put1
[    8.722259] twl_rtc twl_rtc: setting system clock to 2000-01-01
00:00:00 UTC (946684800)
[    8.741424] Waiting for root device /dev/mmcblk0p2...
[    8.753967] usb 1-2: New USB device found, idVendor=3D0424, idProduc=
t=3D9514
[    8.761810] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    8.778442] hub 1-2:1.0: USB hub found
[    8.783599] hub 1-2:1.0: 5 ports detected
[    8.911285] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    8.924072] mmc0: new high speed SDHC card at address 1234
[    8.937072] mmcblk0: mmc0:1234 SA04G 3.63 GiB
[    8.957885]  mmcblk0: p1 p2
[    9.088958] usb 1-2.1: new high-speed USB device number 3 using ehci=
-omap
[    9.214874] usb 1-2.1: New USB device found, idVendor=3D0424, idProd=
uct=3Dec00
[    9.222686] usb 1-2.1: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    9.240386] smsc95xx v1.0.4
[    9.369812] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
usb-ehci-omap.0-2.1, smsc95xx USB 2.0 Ethernet, ee:f3:7e:27:c8:39
[    9.471527] usb 1-2.4: new high-speed USB device number 4 using ehci=
-omap
[    9.600006] usb 1-2.4: New USB device found, idVendor=3D05e3, idProd=
uct=3D0608
[    9.607757] usb 1-2.4: New USB device strings: Mfr=3D0, Product=3D1,
SerialNumber=3D0
[    9.616058] usb 1-2.4: Product: USB2.0 Hub
[    9.628112] hub 1-2.4:1.0: USB hub found
[    9.633483] hub 1-2.4:1.0: 4 ports detected
[    9.932373] usb 1-2.4.3: new high-speed USB device number 5 using eh=
ci-omap
[    9.999145] kjournald starting.  Commit interval 5 seconds
[   10.006774] EXT3-fs (mmcblk0p2): warning: maximal mount count
reached, running e2fsck is recommended
[   10.021759] EXT3-fs (mmcblk0p2): using internal journal
[   10.034179] EXT3-fs (mmcblk0p2): recovery complete
[   10.039611] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[   10.048889] VFS: Mounted root (ext3 filesystem) on device 179:2.
[   10.057708] Freeing init memory: 308K
[   10.092803] usb 1-2.4.3: New USB device found, idVendor=3D0cf3, idPr=
oduct=3D9271
[   10.100982] usb 1-2.4.3: New USB device strings: Mfr=3D16,
Product=3D32, SerialNumber=3D48
[   10.109832] usb 1-2.4.3: Product: USB2.0 WLAN
[   10.114807] usb 1-2.4.3: Manufacturer: ATHEROS
[   10.119842] usb 1-2.4.3: SerialNumber: 12345
[   10.236907] usb 1-2.4.4: new high-speed USB device number 6 using eh=
ci-omap
INIT: version 2.86 booting
[   10.365600] usb 1-2.4.4: New USB device found, idVendor=3D05e3, idPr=
oduct=3D0608
[   10.373718] usb 1-2.4.4: New USB device strings: Mfr=3D0, Product=3D=
1,
SerialNumber=3D0
[   10.382293] usb 1-2.4.4: Product: USB2.0 Hub
[   10.395843] hub 1-2.4.4:1.0: USB hub found
[   10.403198] hub 1-2.4.4:1.0: 4 ports detected
[   10.705535] usb 1-2.4.4.3: new full-speed USB device number 7 using =
ehci-omap
Please wait: booting...
[   10.852996] usb 1-2.4.4.3: New USB device found, idVendor=3D067b,
idProduct=3D2303
[   10.861328] usb 1-2.4.4.3: New USB device strings: Mfr=3D1,
Product=3D2, SerialNumber=3D0
[   10.869903] usb 1-2.4.4.3: Product: USB-Serial Controller
[   10.875946] usb 1-2.4.4.3: Manufacturer: Prolific Technology Inc.
Starting udev
WARNING: -e needs -E or -F
[   11.565704] udevd (587): /proc/587/oom_adj is deprecated, please
use /proc/587/oom_score_adj instead.
[   34.282623] alignment: ignoring faults is unsafe on this CPU.
Defaulting to fixup mode.
Remounting root file system...
Caching udev devnodes
ALSA: Restoring mixer settings...
/usr/sbin/alsactl: load_state:1625: No soundcards found...
Configuring network interfaces... udhcpc (v1.13.2) started
Sending discover...
[   40.445281] smsc95xx 1-2.1:1.0: eth0: link up, 100Mbps,
full-duplex, lpa 0xC5E1
Sending discover...
Sending select for 192.168.1.62...
Lease of 192.168.1.62 obtained, lease time 864000
adding dns 68.105.28.13
adding dns 68.105.29.13
adding dns 68.105.28.15
done.
Setting up IP spoofing protection: rp_filter.
Sat Apr 14 22:03:00 UTC 2012
INIT: Entering runlevel: 5
Starting telnet daemon.
Starting syslogd/klogd: done
Starting thttpd.

 _____                    _____           _         _
|  _  |___ ___ ___ ___   |  _  |___ ___  |_|___ ___| |_
|     |  _| .'| . | . |  |   __|  _| . | | | -_|  _|  _|
|__|__|_| |__,|_  |___|  |__|  |_| |___|_| |___|___|_|
              |___|                    |___|

Arago Project http://arago-project.org beagleboard ttyO2

Arago 2011.09 beagleboard ttyO2

beagleboard login:

3.4-rc5 with omap-usb-host.c compile fix:


## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.4.0-rc5-ktest-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3398584 Bytes =3D 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc5-ktest-dirty (russ@russ-laptop)
(gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #93 SMP Wed May 2
01:43:11 MST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Reserving 25165824 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c101b000 s11520 r8192 d130=
56 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 123648
[    0.000000] Kernel command line: tty1 console=3Dtty0
console=3DttyO2,115200n8 consoleblank=3D0 mpurate=3D1000000 vram=3D24M
omapfb.mode=3Dhd720 omapfb.vram=3D0:8M,1:4M,2:4M root=3D/dev/mmcblk0p2
ip=3Doff rw rootwait
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 487MB =3D 487MB total
[    0.000000] Memory: 481768k/481768k available, 42520k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05dd28c   (5973 kB)
[    0.000000]       .init : 0xc05de000 - 0xc062bd00   ( 312 kB)
[    0.000000]       .data : 0xc062c000 - 0xc06bdb58   ( 583 kB)
[    0.000000]        .bss : 0xc06bdb7c - 0xc0c12060   (5458 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
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
[    0.003570] Calibrating delay loop... 512.57 BogoMIPS (lpj=3D2002944=
)
[    0.074096] pid_max: default: 32768 minimum: 301
[    0.074829] Security Framework initialized
[    0.075134] Mount-cache hash table entries: 512
[    0.080017] CPU: Testing write buffer coherency: ok
[    0.080963] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.081054] Setting up static identity map for 0x8042ed60 - 0x8042ed=
d0
[    0.082641] Brought up 1 CPUs
[    0.082672] SMP: Total of 1 processors activated (512.57 BogoMIPS).
[    0.124206] dummy:
[    0.126220] NET: Registered protocol family 16
[    0.127502] GPMC revision 5.0
[    0.137237] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.137756] OMAP GPIO hardware version 2.5
[    0.138763] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.140197] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.141906] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.143280] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.144653] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.151184] omap_mux_init: Add partition: #1: core, flags: 0
[    0.153839] OMAP3 Beagle Rev: xM C
[    0.165924] Reprogramming SDRC clock to 400000000 Hz
[    0.165985] dpll3_m2_clk rate change failed: -22
[    0.169128]  usbhs_omap: alias fck already exists
[    0.169891] Found NAND on CS0
[    0.169921] Registering NAND on CS0
[    0.170867] Unable to get DVI reset GPIO
[    0.171356] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.185516]  omap-mcbsp.2: alias fck already exists
[    0.186309]  omap-mcbsp.3: alias fck already exists
[    3.439697] clock: dpll1_ck failed transition to 'locked'
[    3.440338] Switched to new clocking rate (Crystal/Core/MPU): 26.0/4=
00/2 MHz
[    3.444610] OMAP DMA hardware revision 5.0
[    3.632202] bio: create slab <bio-0> at 0
[    3.655456] SCSI subsystem initialized
[    3.661163] omap2_mcspi omap2_mcspi.1: master is unqueued, this is d=
eprecated
[    3.665130] omap2_mcspi omap2_mcspi.2: master is unqueued, this is d=
eprecated
[    3.668243] omap2_mcspi omap2_mcspi.3: master is unqueued, this is d=
eprecated
[    3.671722] omap2_mcspi omap2_mcspi.4: master is unqueued, this is d=
eprecated
[    3.680847] usbcore: registered new interface driver usbfs
[    3.684356] usbcore: registered new interface driver hub
[    3.686492] usbcore: registered new device driver usb
[    3.694824] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    3.719329] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    3.721099] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    3.727478] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs =
336..353
[    3.731567] gpiochip_add: registered GPIOs 192 to 211 on device: twl=
4030
[    3.745574] VUSB1V5: 1500 mV normal standby
[    3.751403] VUSB1V8: 1800 mV normal standby
[    3.756622] VUSB3V1: 3100 mV normal standby
[    3.770874] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    3.782653] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
[    3.788726] VDAC: 1800 mV normal standby
[    3.794647] VDVI: 1800 mV normal standby
[    3.801055] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    3.803588] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    3.830108] Switching to clocksource 32k_counter
[    4.147186] usbhs_omap usbhs_omap: xclk60mhsp1_ck set parentfailed e=
rror:-22
[    4.147399] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed e=
rror:-22
[    4.156249] NET: Registered protocol family 2
[    4.158813] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
[    4.165252] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    4.167510] TCP bind hash table entries: 16384 (order: 7, 589824 byt=
es)
[    4.195465] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    4.195800] TCP: reno registered
[    4.195922] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    4.196960] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    4.200103] NET: Registered protocol family 1
[    4.204040] RPC: Registered named UNIX socket transport module.
[    4.204193] RPC: Registered udp transport module.
[    4.204284] RPC: Registered tcp transport module.
[    4.204406] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    4.207885] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    4.687866] VFS: Disk quotas dquot_6.5.2
[    4.688995] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    4.694122] NFS: Registering the id_resolver key type
[    4.699035] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    4.702392] msgmni has been set to 940
[    4.711822] io scheduler noop registered
[    4.711944] io scheduler deadline registered
[    4.712646] io scheduler cfq registered (default)
[    4.719604] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.739074] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    4.743804] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    4.748077] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    5.531280] console [ttyO2] enabled
[    5.539428] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a =
OMAP UART3
[    5.645355] brd: module loaded
[    5.704345] loop: module loaded
[    5.728515] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    5.738098] No NAND device found
[    5.742370] No NAND device found
[    5.747894] OneNAND driver initializing
[    5.773742] usbcore: registered new interface driver asix
[    5.781738] usbcore: registered new interface driver cdc_ether
[    5.790191] usbcore: registered new interface driver smsc95xx
[    5.798278] usbcore: registered new interface driver net1080
[    5.806243] usbcore: registered new interface driver cdc_subset
[    5.814422] usbcore: registered new interface driver zaurus
[    5.822357] usbcore: registered new interface driver cdc_ncm
[    5.833251] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    5.841766] ehci-omap.0 supply hsusb0 not found, using dummy regulat=
or
[    5.850372] ehci-omap.0 supply hsusb1 not found, using dummy regulat=
or
[    7.871185] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    7.888702] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 1
[    7.898345] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    7.917938] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    7.927764] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    7.935424] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    7.943511] usb usb1: Product: OMAP-EHCI Host Controller
[    7.949523] usb usb1: Manufacturer: Linux 3.4.0-rc5-ktest-dirty ehci=
_hcd
[    7.957061] usb usb1: SerialNumber: ehci-omap.0
[    7.973297] hub 1-0:1.0: USB hub found
[    7.977935] hub 1-0:1.0: 3 ports detected
[    8.022735] usbcore: registered new interface driver cdc_wdm
[    8.029296] Initializing USB Mass Storage driver...
[    8.036804] usbcore: registered new interface driver usb-storage
[    8.043792] USB Mass Storage support registered.
[    8.052337] usbcore: registered new interface driver libusual
[    8.060577] usbcore: registered new interface driver usbtest
[    8.071258] mousedev: PS/2 mouse device common for all mice
[    8.094451] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input=
0
[    8.113281] twl_rtc twl_rtc: Power up reset detected.
[    8.119232] twl_rtc twl_rtc: Enabling TWL-RTC
[    8.132781] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    8.143127] i2c /dev entries driver
[    8.155212] Driver for 1-wire Dallas network protocol.
[    8.169738] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    8.180358] twl4030_wdt twl4030_wdt: Failed to register misc device
[    8.187774] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    8.455230] usbcore: registered new interface driver usbhid
[    8.461639] usbhid: USB HID core driver
[    8.466033] oprofile: hardware counters not available
[    8.471649] oprofile: using timer interrupt.
[    8.478637] TCP: cubic registered
[    8.482543] Initializing XFRM netlink socket
[    8.487731] NET: Registered protocol family 17
[    8.493103] NET: Registered protocol family 15
[    8.498931] Registering the dns_resolver key type
[    8.505035] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    8.513885] ThumbEE CPU extension supported.
[    8.641448] clock: disabling unused clocks to save power
[    8.658538] VDVI: incomplete constraints, leaving on
[    8.664703] VDAC: incomplete constraints, leaving on
[    8.678039] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put1
[    8.702392] twl_rtc twl_rtc: setting system clock to 2000-01-01
00:00:00 UTC (946684800)
[    8.721496] Waiting for root device /dev/mmcblk0p2...
[    8.849761] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    8.862335] mmc0: new high speed SDHC card at address 1234
[    8.875610] mmcblk0: mmc0:1234 SA04G 3.63 GiB
[    8.896301]  mmcblk0: p1 p2
[   15.413574] kjournald starting.  Commit interval 5 seconds
[   15.421203] EXT3-fs (mmcblk0p2): warning: maximal mount count
reached, running e2fsck is recommended
[   16.144378] EXT3-fs (mmcblk0p2): using internal journal
[   16.155944] EXT3-fs (mmcblk0p2): recovery complete
[   16.161529] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[   16.170410] VFS: Mounted root (ext3 filesystem) on device 179:2.
[   16.179046] Freeing init memory: 308K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
[   17.388397] udevd (564): /proc/564/oom_adj is deprecated, please
use /proc/564/oom_score_adj instead.
[   38.766174] alignment: ignoring faults is unsafe on this CPU.
Defaulting to fixup mode.
Remounting root file system...
Caching udev devnodes
ALSA: Restoring mixer settings...
/usr/sbin/alsactl: load_state:1625: No soundcards found...
Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such devic=
e
done.
Setting up IP spoofing protection: rp_filter.
Sat Apr 14 22:03:00 UTC 2012
INIT: Entering runlevel: 5
Starting telnet daemon.
Starting syslogd/klogd: done
Starting thttpd.

 _____                    _____           _         _
|  _  |___ ___ ___ ___   |  _  |___ ___  |_|___ ___| |_
|     |  _| .'| . | . |  |   __|  _| . | | | -_|  _|  _|
|__|__|_| |__,|_  |___|  |__|  |_| |___|_| |___|___|_|
              |___|                    |___|

Arago Project http://arago-project.org beagleboard ttyO2

Arago 2011.09 beagleboard ttyO2

beagleboard login:
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
