From: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Subject: Debugging LCD and encountering NULL pointer in omap_vout_probe
Date: Thu, 8 Sep 2011 03:37:31 -0700 (PDT)
Message-ID: <968502.699.1315478251635.JavaMail.geo-discussion-forums@yqej16>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_698_15784874.1315478251630"
Return-path: <beagleboard+bncCNSPtrLdDRDvtaLzBBoEQUjIvQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_698_15784874.1315478251630
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Any ideas on debugging this crash in omap_vout_probe?  This is a 3.0.4=20
kernel with PM patches applied from Kevin's tree.

Built using:=20
https://gitorious.org/beagleboard-validation/linux/commits/ulcd-20110907

Texas Instruments X-Loader 1.5.1 (Aug 26 2011 - 21:46:42)
Beagle xM
Reading boot sector
Loading u-boot.bin from mmc


U-Boot 2011.06-00573-gd9205c3 (Sep 06 2011 - 18:57:15)

OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
OMAP3 Beagle board + LPDDR/NAND
I2C:   ready
DRAM:  512 MiB
NAND:  0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

In:    serial
Out:   serial
Err:   serial
Beagle xM Rev C
No EEPROM on expansion board
Die ID #497c00029ff80000015f26ad0f01a02e
Net:   Net Initialization Skipped
No ethernet found.
Hit any key to stop autoboot:  0=20
OMAP3 beagleboard.org # version

U-Boot 2011.06-00573-gd9205c3 (Sep 06 2011 - 18:57:15)
arm-angstrom-linux-gnueabi-gcc (GCC) 4.5.4 20110722 (prerelease)
GNU ld (GNU Binutils) 2.20.1.20100303
OMAP3 beagleboard.org # boot
The user button is currently NOT pressed.
SD/MMC found on device 0
reading uEnv.txt

606 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
Setting bus to 1
Setting bus to 0
Loading file "/boot/uImage" from mmc device 0:2 (xxa2)
3364936 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.0.4+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3364872 Bytes =3D 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.4+ (jkridner@D620) (gcc version 4.5.4=20
20110722 (prerelease) (GCC) ) #2 Tue Sep 6 19:27:55 EDT 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),=20
cr=3D10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction=
=20
cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Beagle expansionboard: none
[    0.000000] Reserving 16777216 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l=20
pages: 118528
[    0.000000] Kernel command line: console=3Dtty0 console=3DttyO2,115200n8=
=20
mem=3D99M@0x80000000 mem=3D384M@0x88000000 mpurate=3Dauto buddy=3Dnone came=
ra=3Dnone=20
vram=3D16M omapfb.mode=3Ddvi:800x480MR-24@60 omapfb.vram=3D0:8M,1:4M,2:4M=
=20
omapfb.debug=3Dy omapfbt
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=20
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072=20
bytes)
[    0.000000] allocated 2097152 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t=20
memory cgroups
[    0.000000] Memory: 99MB 368MB =3D 467MB total
[    0.000000] Memory: 464924k/464924k available, 29668k reserved, 0K=20
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc003d000   ( 212 kB)
[    0.000000]       .text : 0xc003d000 - 0xc063d130   (6145 kB)
[    0.000000]       .data : 0xc063e000 - 0xc0689600   ( 302 kB)
[    0.000000]        .bss : 0xc0689624 - 0xc06c2af0   ( 230 kB)
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96=20
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=20
every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000701] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720)
[    0.039154] pid_max: default: 32768 minimum: 301
[    0.039337] Mount-cache hash table entries: 512
[    0.039703] Initializing cgroup subsys cpuacct
[    0.039733] Initializing cgroup subsys memory
[    0.039794] Initializing cgroup subsys devices
[    0.039825] Initializing cgroup subsys freezer
[    0.039855] Initializing cgroup subsys blkio
[    0.039886] Initializing cgroup subsys perf_event
[    0.039978] CPU: Testing write buffer coherency: ok
[    0.040740] devtmpfs: initialized
[    0.042114] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
[    0.044250] print_constraints: dummy:=20
[    0.044494] NET: Registered protocol family 16
[    0.044677] GPMC revision 5.0
[    0.045989] OMAP GPIO hardware version 2.5
[    0.046173] OMAP GPIO hardware version 2.5
[    0.046386] OMAP GPIO hardware version 2.5
[    0.046569] OMAP GPIO hardware version 2.5
[    0.046752] OMAP GPIO hardware version 2.5
[    0.047058] OMAP GPIO hardware version 2.5
[    0.047546] omap_mux_init: Add partition: #1: core, flags: 0
[    0.048767] OMAP3 Beagle Rev: xM C
[    0.053070] Found NAND on CS0
[    0.053100] Registering NAND on CS0
[    0.053436] Unable to get DVI reset GPIO
[    0.053497] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.055541] omap_device: omap-mcbsp.2: alias fck already exists
[    0.055725] omap_device: omap-mcbsp.3: alias fck already exists
[    0.056671] OMAP DMA hardware revision 5.0
[    0.065063] bio: create slab <bio-0> at 0
[    0.066162] SCSI subsystem initialized
[    0.067321] usbcore: registered new interface driver usbfs
[    0.067474] usbcore: registered new interface driver hub
[    0.067657] usbcore: registered new device driver usb
[    0.068359] omap_i2c omap_i2c.1: bus 1 rev4.0 at 2600 kHz
[    0.070953] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.071014] twl4030: power (irq 373) chaining IRQs 376..383
[    0.071472] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.074554] print_constraints: VUSB1V5: 1500 mV normal standby
[    0.074981] print_constraints: VUSB1V8: 1800 mV normal standby
[    0.075378] print_constraints: VUSB3V1: 3100 mV normal standby
[    0.077117] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    0.077789] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV norma=
l=20
standby
[    0.078277] print_constraints: VDAC: 1800 mV normal standby
[    0.078704] print_constraints: VDVI: 1800 mV normal standby
[    0.079193] print_constraints: VSIM: 1800 <--> 3000 mV at 1800 mV normal=
=20
standby
[    0.093872] omap_i2c omap_i2c.3: bus 3 rev4.0 at 100 kHz
[    0.094573] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.095214] Bluetooth: Core ver 2.16
[    0.095275] NET: Registered protocol family 31
[    0.095306] Bluetooth: HCI device and connection manager initialized
[    0.095336] Bluetooth: HCI socket layer initialized
[    0.095367] Bluetooth: L2CAP socket layer initialized
[    0.095550] Bluetooth: SCO socket layer initialized
[    0.095825] Switching to clocksource 32k_counter
[    0.101837] Switched to NOHz mode on CPU #0
[    0.106628] musb-hdrc: version 6.0, musb-dma, otg (peripheral+host)
[    0.109710] musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000=20
using DMA, IRQ 92
[    0.110321] NET: Registered protocol family 2
[    0.110534] IP route cache hash table entries: 4096 (order: 2, 16384=20
bytes)
[    0.110931] TCP established hash table entries: 16384 (order: 5, 131072=
=20
bytes)
[    0.111297] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.111511] TCP: Hash tables configured (established 16384 bind 16384)
[    0.111541] TCP reno registered
[    0.111572] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.111663] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.112060] NET: Registered protocol family 1
[    0.112884] RPC: Registered named UNIX socket transport module.
[    0.112945] RPC: Registered udp transport module.
[    0.112976] RPC: Registered tcp transport module.
[    0.112976] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.114135] omap-iommu omap-iommu.0: isp registered
[    0.127838] VFS: Disk quotas dquot_6.5.2
[    0.127929] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.128509] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.128875] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.128906] JFFS2 version 2.2. (NAND) (SUMMARY)  =EF=BF=BD 2001-2006 Red=
 Hat,=20
Inc.
[    0.129577] msgmni has been set to 908
[    0.131011] Block layer SCSI generic (bsg) driver version 0.4 loaded=20
(major 253)
[    0.131195] io scheduler noop registered
[    0.131225] io scheduler deadline registered
[    0.131286] io scheduler cfq registered (default)
[    0.189788] OMAP DSS rev 2.0
[    0.191925] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.193145] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
=20
UART0
[    0.193450] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
=20
UART1
[    0.193725] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
=20
UART2
[    0.941345] console [ttyO2] enabled
[    0.945312] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OMAP=
=20
UART3
[    0.960327] brd: module loaded
[    0.967254] loop: module loaded
[    0.971984] omap2-nand driver initializing
[    0.976715] No NAND device found.
[    0.980499] No NAND device found.
[    0.984954] usbcore: registered new interface driver catc
[    0.990692] catc: v2.8:CATC EL1210A NetMate USB Ethernet driver
[    0.997009] usbcore: registered new interface driver kaweth
[    1.002929] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB=20
Ethernet driver
[    1.011077] usbcore: registered new interface driver pegasus
[    1.017028] rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet=20
driver
[    1.024383] usbcore: registered new interface driver rtl8150
[    1.030426] usbcore: registered new interface driver asix
[    1.036193] usbcore: registered new interface driver cdc_ether
[    1.042419] usbcore: registered new interface driver dm9601
[    1.048370] usbcore: registered new interface driver smsc95xx
[    1.054504] usbcore: registered new interface driver gl620a
[    1.060455] usbcore: registered new interface driver net1080
[    1.066497] usbcore: registered new interface driver plusb
[    1.072326] usbcore: registered new interface driver rndis_host
[    1.078643] usbcore: registered new interface driver cdc_subset
[    1.084960] usbcore: registered new interface driver zaurus
[    1.090911] usbcore: registered new interface driver MOSCHIP usb-etherne=
t=20
driver
[    1.099060] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.106079] _regulator_get: ehci-omap.0 supply hsusb0 not found, using=
=20
dummy regulator
[    1.114501] _regulator_get: ehci-omap.0 supply hsusb1 not found, using=
=20
dummy regulator
[    3.135040] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.141448] ehci-omap ehci-omap.0: new USB bus registered, assigned bus=
=20
number 1
[    3.149414] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    3.166320] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    3.172454] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.179626] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=20
SerialNumber=3D1
[    3.187255] usb usb1: Product: OMAP-EHCI Host Controller
[    3.192871] usb usb1: Manufacturer: Linux 3.0.4+ ehci_hcd
[    3.198547] usb usb1: SerialNumber: ehci-omap.0
[    3.203948] hub 1-0:1.0: USB hub found
[    3.207946] hub 1-0:1.0: 3 ports detected
[    3.236663] Initializing USB Mass Storage driver...
[    3.241943] usbcore: registered new interface driver usb-storage
[    3.248321] USB Mass Storage support registered.
[    3.253692] mousedev: PS/2 mouse device common for all mice
[    3.260070] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    3.268524] input: twl4030_pwrbutton as=20
/devices/platform/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/inpu=
t1
[    3.280242] i2c /dev entries driver
[    3.284393] Linux media interface: v0.10
[    3.288604] Linux video capture interface: v2.00
[    3.293701] vpfe_init
[    3.296691] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    3.303131] Bluetooth: HCI UART driver ver 2.2
[    3.307830] Bluetooth: HCI H4 protocol initialized
[    3.312866] Bluetooth: HCI BCSP protocol initialized
[    3.318115] Bluetooth: HCILL protocol initialized
[    3.323089] Bluetooth: HCIATH3K protocol initialized
[    3.328308] Bluetooth: Generic Bluetooth USB driver ver 0.6
[    3.334381] usbcore: registered new interface driver btusb
[    3.340270] cpuidle: using governor ladder
[    3.344573] cpuidle: using governor menu
[    3.351043] omap_hsmmc: probe of omap_hsmmc.1 failed with error -16
[    3.360168] usbcore: registered new interface driver usbhid
[    3.366088] usbhid: USB HID core driver
[    3.370635] usbcore: registered new interface driver snd-usb-audio
[    3.378021] OMAP3 Beagle/Devkit8000 SoC init
[    3.462554] asoc: twl4030-hifi <-> omap-mcbsp-dai.1 mapping ok
[    3.472076] ALSA device list:
[    3.475219]   #0: omap3beagle
[    3.478332] oprofile: hardware counters not available
[    3.483673] oprofile: using timer interrupt.
[    3.488677] TCP cubic registered
[    3.492126] NET: Registered protocol family 17
[    3.496887] hub 1-0:1.0: unable to enumerate USB device on port 2
[    3.503387] NET: Registered protocol family 15
[    3.508117] lib80211: common routines for IEEE802.11 drivers
[    3.514190] Registering the dns_resolver key type
[    3.519256] VFP support v0.3: implementor 41 architecture 3 part 30=20
variant c rev 3
[    3.528411] ThumbEE CPU extension supported.
[    3.537292] omap_voltage_get_voltdata: Unable to match the current=20
voltage with the voltagetable for vdd_mpu_iva
[    3.553222] sr_init: No PMIC hook to init smartreflex
[    3.558807] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver=
=20
initialized
[    3.567199] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver=
=20
initialized
[    3.575500] SmartReflex Class3 initialized
[    3.584259] clock: disabling unused clocks to save power
[    3.590789] registered taskstats version 1
[    3.595855] omapfb omapfb: no driver for display
[    3.600830] omapfb omapfb: failed to setup omapfb
[    3.606445] regulator_init_complete: VDVI: incomplete constraints,=20
leaving on
[    3.614288] regulator_init_complete: VDAC: incomplete constraints,=20
leaving on
[    3.622558] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.629730] omapdss DPI: Could not find exact pixel clock. Requested=20
23500 kHz, got 24000 kHz
[    3.669006] omap_vout omap_vout: : registered and initialized video=20
device 0
[    3.676513] Unable to handle kernel NULL pointer dereference at virtual=
=20
address 0000005c
[    3.685058] pgd =3D c0004000
[    3.687896] [0000005c] *pgd=3D00000000
[    3.691680] Internal error: Oops: 5 [#1]
[    3.695831] Modules linked in:
[    3.699066] CPU: 0    Not tainted  (3.0.4+ #2)
[    3.703735] PC is at omap_vout_probe+0x6b8/0x7e0
[    3.708618] LR is at omap_vout_probe+0x684/0x7e0
[    3.713470] pc : [<c00297bc>]    lr : [<c0029788>]    psr: 80000013
[    3.713500] sp : de82bec0  ip : 00000000  fp : 00000004
[    3.725585] r10: dea87bc8  r9 : dea87bc4  r8 : 00000186
[    3.731109] r7 : 00000184  r6 : dea87bc0  r5 : 00000000  r4 : 00000002
[    3.737976] r3 : 00000000  r2 : de82be7c  r1 : c05bb360  r0 : c0651f40
[    3.744842] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
=20
kernel
[    3.752532] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    3.758605] Process swapper (pid: 1, stack limit =3D 0xde82a2f0)
[    3.764739] Stack: (0xde82bec0 to 0xde82c000)
[    3.769317] bec0: 00000000 de819a40 00000030 dea87bc0 deb10c00 00000003=
=20
00000003 dea87bdc
[    3.777954] bee0: dea87bc0 00000001 deb10c00 dea87bc0 de879878 00000004=
=20
c064580c c06457d8
[    3.786560] bf00: c064580c c067be4c c067be4c 00000000 00000000 00000000=
=20
00000000 c02a79b4
[    3.795196] bf20: c02a79a0 c02a6944 00000000 c06457d8 c064580c c067be4c=
=20
00000000 c02a6a60
[    3.803802] bf40: c067be4c de82bf50 c02a6a00 c02a5bf4 de8076b8 de8736f0=
=20
c067be4c c067be4c
[    3.812408] bf60: dea86440 c0671618 00000000 c02a6264 c058901c c0589021=
=20
0000005f c067be4c
[    3.821044] bf80: c0031924 c0042cd4 c00290d8 00000000 00000000 c02a6f6c=
=20
00000000 c0031914
[    3.829650] bfa0: c0031924 c0042cd4 c00290d8 00000000 00000000 c00290e4=
=20
de82a000 c003d45c
[    3.838287] bfc0: c00290d8 c05ce3b4 c0689640 00000000 c0031914 c0031924=
=20
c0042cd4 00000013
[    3.846893] bfe0: 00000000 c000894c 00000000 00000000 c00088c4 c0042cd4=
=20
01100800 00000008
[    3.855529] [<c00297bc>] (omap_vout_probe+0x6b8/0x7e0) from [<c02a79b4>]=
=20
(platform_drv_probe+0x14/0x18)
[    3.865447] [<c02a79b4>] (platform_drv_probe+0x14/0x18) from [<c02a6944>=
]=20
(driver_probe_device+0xc8/0x184)
[    3.875610] [<c02a6944>] (driver_probe_device+0xc8/0x184) from=20
[<c02a6a60>] (__driver_attach+0x60/0x84)
[    3.885528] [<c02a6a60>] (__driver_attach+0x60/0x84) from [<c02a5bf4>]=
=20
(bus_for_each_dev+0x4c/0x78)
[    3.895050] [<c02a5bf4>] (bus_for_each_dev+0x4c/0x78) from [<c02a6264>]=
=20
(bus_add_driver+0x98/0x210)
[    3.904602] [<c02a6264>] (bus_add_driver+0x98/0x210) from [<c02a6f6c>]=
=20
(driver_register+0xa0/0x120)
[    3.914154] [<c02a6f6c>] (driver_register+0xa0/0x120) from [<c00290e4>]=
=20
(omap_vout_init+0xc/0x2c)
[    3.923492] [<c00290e4>] (omap_vout_init+0xc/0x2c) from [<c003d45c>]=20
(do_one_initcall+0x90/0x160)
[    3.932861] [<c003d45c>] (do_one_initcall+0x90/0x160) from [<c000894c>]=
=20
(kernel_init+0x88/0x130)
[    3.942138] [<c000894c>] (kernel_init+0x88/0x130) from [<c0042cd4>]=20
(kernel_thread_exit+0x0/0x8)
[    3.951416] Code: e3e05012 ea000016 e59a0094 e5903200 (e593c05c)=20
[    3.957885] ---[ end trace cbb5c332507f77c9 ]---
[    3.962890] Kernel panic - not syncing: Attempted to kill init!

--=20
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.
To view this discussion on the web visit https://groups.google.com/d/msg/be=
agleboard/-/DpkSFJYB3g4J.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.
For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.


------=_Part_698_15784874.1315478251630
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Any ideas on debugging this crash in omap_vout_probe?&nbsp; This is a 3.0.4=
 kernel with PM patches applied from Kevin's tree.<br><br>Built using: http=
s://gitorious.org/beagleboard-validation/linux/commits/ulcd-20110907<br><br=
>Texas Instruments X-Loader 1.5.1 (Aug 26 2011 - 21:46:42)<br>Beagle xM<br>=
Reading boot sector<br>Loading u-boot.bin from mmc<br><br><br>U-Boot 2011.0=
6-00573-gd9205c3 (Sep 06 2011 - 18:57:15)<br><br>OMAP3630/3730-GP ES2.1, CP=
U-OPP2, L3-165MHz, Max CPU Clock 1 Ghz<br>OMAP3 Beagle board + LPDDR/NAND<b=
r>I2C:&nbsp;&nbsp; ready<br>DRAM:&nbsp; 512 MiB<br>NAND:&nbsp; 0 MiB<br>MMC=
:&nbsp;&nbsp; OMAP SD/MMC: 0<br>*** Warning - readenv() failed, using defau=
lt environment<br><br>In:&nbsp;&nbsp;&nbsp; serial<br>Out:&nbsp;&nbsp; seri=
al<br>Err:&nbsp;&nbsp; serial<br>Beagle xM Rev C<br>No EEPROM on expansion =
board<br>Die ID #497c00029ff80000015f26ad0f01a02e<br>Net:&nbsp;&nbsp; Net I=
nitialization Skipped<br>No ethernet found.<br>Hit any key to stop autoboot=
:&nbsp; 0 <br>OMAP3 beagleboard.org # version<br><br>U-Boot 2011.06-00573-g=
d9205c3 (Sep 06 2011 - 18:57:15)<br>arm-angstrom-linux-gnueabi-gcc (GCC) 4.=
5.4 20110722 (prerelease)<br>GNU ld (GNU Binutils) 2.20.1.20100303<br>OMAP3=
 beagleboard.org # boot<br>The user button is currently NOT pressed.<br>SD/=
MMC found on device 0<br>reading uEnv.txt<br><br>606 bytes read<br>Loaded e=
nvironment from uEnv.txt<br>Importing environment from mmc ...<br>Running u=
envcmd ...<br>Setting bus to 1<br>Setting bus to 0<br>Loading file "/boot/u=
Image" from mmc device 0:2 (xxa2)<br>3364936 bytes read<br>Booting from mmc=
 ...<br>## Booting kernel from Legacy Image at 80200000 ...<br>&nbsp;&nbsp;=
 Image Name:&nbsp;&nbsp; Linux-3.0.4+<br>&nbsp;&nbsp; Image Type:&nbsp;&nbs=
p; ARM Linux Kernel Image (uncompressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&n=
bsp;&nbsp; 3364872 Bytes =3D 3.2 MiB<br>&nbsp;&nbsp; Load Address: 80008000=
<br>&nbsp;&nbsp; Entry Point:&nbsp; 80008000<br>&nbsp;&nbsp; Verifying Chec=
ksum ... OK<br>&nbsp;&nbsp; Loading Kernel Image ... OK<br>OK<br><br>Starti=
ng kernel ...<br><br>Uncompressing Linux... done, booting the kernel.<br>[&=
nbsp;&nbsp;&nbsp; 0.000000] Initializing cgroup subsys cpuset<br>[&nbsp;&nb=
sp;&nbsp; 0.000000] Initializing cgroup subsys cpu<br>[&nbsp;&nbsp;&nbsp; 0=
.000000] Linux version 3.0.4+ (jkridner@D620) (gcc version 4.5.4 20110722 (=
prerelease) (GCC) ) #2 Tue Sep 6 19:27:55 EDT 2011<br>[&nbsp;&nbsp;&nbsp; 0=
.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7f<=
br>[&nbsp;&nbsp;&nbsp; 0.000000] CPU: VIPT nonaliasing data cache, VIPT ali=
asing instruction cache<br>[&nbsp;&nbsp;&nbsp; 0.000000] Machine: OMAP3 Bea=
gle Board<br>[&nbsp;&nbsp;&nbsp; 0.000000] Beagle expansionboard: none<br>[=
&nbsp;&nbsp;&nbsp; 0.000000] Reserving 16777216 bytes SDRAM for VRAM<br>[&n=
bsp;&nbsp;&nbsp; 0.000000] Memory policy: ECC disabled, Data cache writebac=
k<br>[&nbsp;&nbsp;&nbsp; 0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp=
 192mhz_clk )<br>[&nbsp;&nbsp;&nbsp; 0.000000] SRAM: Mapped pa 0x40200000 t=
o va 0xfe400000 size: 0x10000<br>[&nbsp;&nbsp;&nbsp; 0.000000] Clocking rat=
e (Crystal/Core/MPU): 26.0/332/600 MHz<br>[&nbsp;&nbsp;&nbsp; 0.000000] Rep=
rogramming SDRC clock to 332000000 Hz<br>[&nbsp;&nbsp;&nbsp; 0.000000] Buil=
t 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 11852=
8<br>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=3Dtty0 cons=
ole=3DttyO2,115200n8 mem=3D99M@0x80000000 mem=3D384M@0x88000000 mpurate=3Da=
uto buddy=3Dnone camera=3Dnone vram=3D16M omapfb.mode=3Ddvi:800x480MR-24@60=
 omapfb.vram=3D0:8M,1:4M,2:4M omapfb.debug=3Dy omapfbt<br>[&nbsp;&nbsp;&nbs=
p; 0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)<br>[&nbsp;=
&nbsp;&nbsp; 0.000000] Dentry cache hash table entries: 65536 (order: 6, 26=
2144 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.000000] Inode-cache hash table entries=
: 32768 (order: 5, 131072 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.000000] allocated=
 2097152 bytes of page_cgroup<br>[&nbsp;&nbsp;&nbsp; 0.000000] please try '=
cgroup_disable=3Dmemory' option if you don't want memory cgroups<br>[&nbsp;=
&nbsp;&nbsp; 0.000000] Memory: 99MB 368MB =3D 467MB total<br>[&nbsp;&nbsp;&=
nbsp; 0.000000] Memory: 464924k/464924k available, 29668k reserved, 0K high=
mem<br>[&nbsp;&nbsp;&nbsp; 0.000000] Virtual kernel memory layout:<br>[&nbs=
p;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; vector&nbsp; : 0xffff0000 =
- 0xffff1000&nbsp;&nbsp; (&nbsp;&nbsp; 4 kB)<br>[&nbsp;&nbsp;&nbsp; 0.00000=
0]&nbsp;&nbsp;&nbsp;&nbsp; fixmap&nbsp; : 0xfff00000 - 0xfffe0000&nbsp;&nbs=
p; ( 896 kB)<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; DMA&n=
bsp;&nbsp;&nbsp;&nbsp; : 0xffc00000 - 0xffe00000&nbsp;&nbsp; (&nbsp;&nbsp; =
2 MB)<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; vmalloc : 0x=
e0800000 - 0xf8000000&nbsp;&nbsp; ( 376 MB)<br>[&nbsp;&nbsp;&nbsp; 0.000000=
]&nbsp;&nbsp;&nbsp;&nbsp; lowmem&nbsp; : 0xc0000000 - 0xe0000000&nbsp;&nbsp=
; ( 512 MB)<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; module=
s : 0xbf000000 - 0xc0000000&nbsp;&nbsp; (&nbsp; 16 MB)<br>[&nbsp;&nbsp;&nbs=
p; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init : 0xc0008000 - 0xc00=
3d000&nbsp;&nbsp; ( 212 kB)<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .text : 0xc003d000 - 0xc063d130&nbsp;&nbsp; (6145 kB)=
<br>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .data=
 : 0xc063e000 - 0xc0689600&nbsp;&nbsp; ( 302 kB)<br>[&nbsp;&nbsp;&nbsp; 0.0=
00000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bss : 0xc0689624 - 0xc06c=
2af0&nbsp;&nbsp; ( 230 kB)<br>[&nbsp;&nbsp;&nbsp; 0.000000] NR_IRQS:410<br>=
[&nbsp;&nbsp;&nbsp; 0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.=
0) with 96 interrupts<br>[&nbsp;&nbsp;&nbsp; 0.000000] Total of 96 interrup=
ts on 1 active controller<br>[&nbsp;&nbsp;&nbsp; 0.000000] OMAP clockevent =
source: GPTIMER1 at 32768 Hz<br>[&nbsp;&nbsp;&nbsp; 0.000000] sched_clock: =
32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms<br>[&nbsp;&nb=
sp;&nbsp; 0.000000] Console: colour dummy device 80x30<br>[&nbsp;&nbsp;&nbs=
p; 0.000000] console [tty0] enabled<br>[&nbsp;&nbsp;&nbsp; 0.000701] Calibr=
ating delay loop... 597.64 BogoMIPS (lpj=3D2334720)<br>[&nbsp;&nbsp;&nbsp; =
0.039154] pid_max: default: 32768 minimum: 301<br>[&nbsp;&nbsp;&nbsp; 0.039=
337] Mount-cache hash table entries: 512<br>[&nbsp;&nbsp;&nbsp; 0.039703] I=
nitializing cgroup subsys cpuacct<br>[&nbsp;&nbsp;&nbsp; 0.039733] Initiali=
zing cgroup subsys memory<br>[&nbsp;&nbsp;&nbsp; 0.039794] Initializing cgr=
oup subsys devices<br>[&nbsp;&nbsp;&nbsp; 0.039825] Initializing cgroup sub=
sys freezer<br>[&nbsp;&nbsp;&nbsp; 0.039855] Initializing cgroup subsys blk=
io<br>[&nbsp;&nbsp;&nbsp; 0.039886] Initializing cgroup subsys perf_event<b=
r>[&nbsp;&nbsp;&nbsp; 0.039978] CPU: Testing write buffer coherency: ok<br>=
[&nbsp;&nbsp;&nbsp; 0.040740] devtmpfs: initialized<br>[&nbsp;&nbsp;&nbsp; =
0.042114] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.<br>[&nb=
sp;&nbsp;&nbsp; 0.044250] print_constraints: dummy: <br>[&nbsp;&nbsp;&nbsp;=
 0.044494] NET: Registered protocol family 16<br>[&nbsp;&nbsp;&nbsp; 0.0446=
77] GPMC revision 5.0<br>[&nbsp;&nbsp;&nbsp; 0.045989] OMAP GPIO hardware v=
ersion 2.5<br>[&nbsp;&nbsp;&nbsp; 0.046173] OMAP GPIO hardware version 2.5<=
br>[&nbsp;&nbsp;&nbsp; 0.046386] OMAP GPIO hardware version 2.5<br>[&nbsp;&=
nbsp;&nbsp; 0.046569] OMAP GPIO hardware version 2.5<br>[&nbsp;&nbsp;&nbsp;=
 0.046752] OMAP GPIO hardware version 2.5<br>[&nbsp;&nbsp;&nbsp; 0.047058] =
OMAP GPIO hardware version 2.5<br>[&nbsp;&nbsp;&nbsp; 0.047546] omap_mux_in=
it: Add partition: #1: core, flags: 0<br>[&nbsp;&nbsp;&nbsp; 0.048767] OMAP=
3 Beagle Rev: xM C<br>[&nbsp;&nbsp;&nbsp; 0.053070] Found NAND on CS0<br>[&=
nbsp;&nbsp;&nbsp; 0.053100] Registering NAND on CS0<br>[&nbsp;&nbsp;&nbsp; =
0.053436] Unable to get DVI reset GPIO<br>[&nbsp;&nbsp;&nbsp; 0.053497] hw-=
breakpoint: debug architecture 0x4 unsupported.<br>[&nbsp;&nbsp;&nbsp; 0.05=
5541] omap_device: omap-mcbsp.2: alias fck already exists<br>[&nbsp;&nbsp;&=
nbsp; 0.055725] omap_device: omap-mcbsp.3: alias fck already exists<br>[&nb=
sp;&nbsp;&nbsp; 0.056671] OMAP DMA hardware revision 5.0<br>[&nbsp;&nbsp;&n=
bsp; 0.065063] bio: create slab &lt;bio-0&gt; at 0<br>[&nbsp;&nbsp;&nbsp; 0=
.066162] SCSI subsystem initialized<br>[&nbsp;&nbsp;&nbsp; 0.067321] usbcor=
e: registered new interface driver usbfs<br>[&nbsp;&nbsp;&nbsp; 0.067474] u=
sbcore: registered new interface driver hub<br>[&nbsp;&nbsp;&nbsp; 0.067657=
] usbcore: registered new device driver usb<br>[&nbsp;&nbsp;&nbsp; 0.068359=
] omap_i2c omap_i2c.1: bus 1 rev4.0 at 2600 kHz<br>[&nbsp;&nbsp;&nbsp; 0.07=
0953] twl4030: PIH (irq 7) chaining IRQs 368..375<br>[&nbsp;&nbsp;&nbsp; 0.=
071014] twl4030: power (irq 373) chaining IRQs 376..383<br>[&nbsp;&nbsp;&nb=
sp; 0.071472] twl4030: gpio (irq 368) chaining IRQs 384..401<br>[&nbsp;&nbs=
p;&nbsp; 0.074554] print_constraints: VUSB1V5: 1500 mV normal standby<br>[&=
nbsp;&nbsp;&nbsp; 0.074981] print_constraints: VUSB1V8: 1800 mV normal stan=
dby<br>[&nbsp;&nbsp;&nbsp; 0.075378] print_constraints: VUSB3V1: 3100 mV no=
rmal standby<br>[&nbsp;&nbsp;&nbsp; 0.077117] twl4030_usb twl4030_usb: Init=
ialized TWL4030 USB module<br>[&nbsp;&nbsp;&nbsp; 0.077789] print_constrain=
ts: VMMC1: 1850 &lt;--&gt; 3150 mV at 3000 mV normal standby<br>[&nbsp;&nbs=
p;&nbsp; 0.078277] print_constraints: VDAC: 1800 mV normal standby<br>[&nbs=
p;&nbsp;&nbsp; 0.078704] print_constraints: VDVI: 1800 mV normal standby<br=
>[&nbsp;&nbsp;&nbsp; 0.079193] print_constraints: VSIM: 1800 &lt;--&gt; 300=
0 mV at 1800 mV normal standby<br>[&nbsp;&nbsp;&nbsp; 0.093872] omap_i2c om=
ap_i2c.3: bus 3 rev4.0 at 100 kHz<br>[&nbsp;&nbsp;&nbsp; 0.094573] Advanced=
 Linux Sound Architecture Driver Version 1.0.24.<br>[&nbsp;&nbsp;&nbsp; 0.0=
95214] Bluetooth: Core ver 2.16<br>[&nbsp;&nbsp;&nbsp; 0.095275] NET: Regis=
tered protocol family 31<br>[&nbsp;&nbsp;&nbsp; 0.095306] Bluetooth: HCI de=
vice and connection manager initialized<br>[&nbsp;&nbsp;&nbsp; 0.095336] Bl=
uetooth: HCI socket layer initialized<br>[&nbsp;&nbsp;&nbsp; 0.095367] Blue=
tooth: L2CAP socket layer initialized<br>[&nbsp;&nbsp;&nbsp; 0.095550] Blue=
tooth: SCO socket layer initialized<br>[&nbsp;&nbsp;&nbsp; 0.095825] Switch=
ing to clocksource 32k_counter<br>[&nbsp;&nbsp;&nbsp; 0.101837] Switched to=
 NOHz mode on CPU #0<br>[&nbsp;&nbsp;&nbsp; 0.106628] musb-hdrc: version 6.=
0, musb-dma, otg (peripheral+host)<br>[&nbsp;&nbsp;&nbsp; 0.109710] musb-hd=
rc musb-hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92<br>[&nb=
sp;&nbsp;&nbsp; 0.110321] NET: Registered protocol family 2<br>[&nbsp;&nbsp=
;&nbsp; 0.110534] IP route cache hash table entries: 4096 (order: 2, 16384 =
bytes)<br>[&nbsp;&nbsp;&nbsp; 0.110931] TCP established hash table entries:=
 16384 (order: 5, 131072 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.111297] TCP bind h=
ash table entries: 16384 (order: 4, 65536 bytes)<br>[&nbsp;&nbsp;&nbsp; 0.1=
11511] TCP: Hash tables configured (established 16384 bind 16384)<br>[&nbsp=
;&nbsp;&nbsp; 0.111541] TCP reno registered<br>[&nbsp;&nbsp;&nbsp; 0.111572=
] UDP hash table entries: 256 (order: 0, 4096 bytes)<br>[&nbsp;&nbsp;&nbsp;=
 0.111663] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>[&nbs=
p;&nbsp;&nbsp; 0.112060] NET: Registered protocol family 1<br>[&nbsp;&nbsp;=
&nbsp; 0.112884] RPC: Registered named UNIX socket transport module.<br>[&n=
bsp;&nbsp;&nbsp; 0.112945] RPC: Registered udp transport module.<br>[&nbsp;=
&nbsp;&nbsp; 0.112976] RPC: Registered tcp transport module.<br>[&nbsp;&nbs=
p;&nbsp; 0.112976] RPC: Registered tcp NFSv4.1 backchannel transport module=
.<br>[&nbsp;&nbsp;&nbsp; 0.114135] omap-iommu omap-iommu.0: isp registered<=
br>[&nbsp;&nbsp;&nbsp; 0.127838] VFS: Disk quotas dquot_6.5.2<br>[&nbsp;&nb=
sp;&nbsp; 0.127929] Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)<br>[&nbsp;&nbsp;&nbsp; 0.128509] squashfs: version 4.0 (2009/01/31) Phi=
llip Lougher<br>[&nbsp;&nbsp;&nbsp; 0.128875] nfs4filelayout_init: NFSv4 Fi=
le Layout Driver Registering...<br>[&nbsp;&nbsp;&nbsp; 0.128906] JFFS2 vers=
ion 2.2. (NAND) (SUMMARY)&nbsp; =EF=BF=BD 2001-2006 Red Hat, Inc.<br>[&nbsp=
;&nbsp;&nbsp; 0.129577] msgmni has been set to 908<br>[&nbsp;&nbsp;&nbsp; 0=
.131011] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 25=
3)<br>[&nbsp;&nbsp;&nbsp; 0.131195] io scheduler noop registered<br>[&nbsp;=
&nbsp;&nbsp; 0.131225] io scheduler deadline registered<br>[&nbsp;&nbsp;&nb=
sp; 0.131286] io scheduler cfq registered (default)<br>[&nbsp;&nbsp;&nbsp; =
0.189788] OMAP DSS rev 2.0<br>[&nbsp;&nbsp;&nbsp; 0.191925] Serial: 8250/16=
550 driver, 4 ports, IRQ sharing enabled<br>[&nbsp;&nbsp;&nbsp; 0.193145] o=
map_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP UART0<br>[&nbsp=
;&nbsp;&nbsp; 0.193450] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) =
is a OMAP UART1<br>[&nbsp;&nbsp;&nbsp; 0.193725] omap_uart.2: ttyO2 at MMIO=
 0x49020000 (irq =3D 74) is a OMAP UART2<br>[&nbsp;&nbsp;&nbsp; 0.941345] c=
onsole [ttyO2] enabled<br>[&nbsp;&nbsp;&nbsp; 0.945312] omap_uart.3: ttyO3 =
at MMIO 0x49042000 (irq =3D 80) is a OMAP UART3<br>[&nbsp;&nbsp;&nbsp; 0.96=
0327] brd: module loaded<br>[&nbsp;&nbsp;&nbsp; 0.967254] loop: module load=
ed<br>[&nbsp;&nbsp;&nbsp; 0.971984] omap2-nand driver initializing<br>[&nbs=
p;&nbsp;&nbsp; 0.976715] No NAND device found.<br>[&nbsp;&nbsp;&nbsp; 0.980=
499] No NAND device found.<br>[&nbsp;&nbsp;&nbsp; 0.984954] usbcore: regist=
ered new interface driver catc<br>[&nbsp;&nbsp;&nbsp; 0.990692] catc: v2.8:=
CATC EL1210A NetMate USB Ethernet driver<br>[&nbsp;&nbsp;&nbsp; 0.997009] u=
sbcore: registered new interface driver kaweth<br>[&nbsp;&nbsp;&nbsp; 1.002=
929] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver<=
br>[&nbsp;&nbsp;&nbsp; 1.011077] usbcore: registered new interface driver p=
egasus<br>[&nbsp;&nbsp;&nbsp; 1.017028] rtl8150: v0.6.2 (2004/08/27):rtl815=
0 based usb-ethernet driver<br>[&nbsp;&nbsp;&nbsp; 1.024383] usbcore: regis=
tered new interface driver rtl8150<br>[&nbsp;&nbsp;&nbsp; 1.030426] usbcore=
: registered new interface driver asix<br>[&nbsp;&nbsp;&nbsp; 1.036193] usb=
core: registered new interface driver cdc_ether<br>[&nbsp;&nbsp;&nbsp; 1.04=
2419] usbcore: registered new interface driver dm9601<br>[&nbsp;&nbsp;&nbsp=
; 1.048370] usbcore: registered new interface driver smsc95xx<br>[&nbsp;&nb=
sp;&nbsp; 1.054504] usbcore: registered new interface driver gl620a<br>[&nb=
sp;&nbsp;&nbsp; 1.060455] usbcore: registered new interface driver net1080<=
br>[&nbsp;&nbsp;&nbsp; 1.066497] usbcore: registered new interface driver p=
lusb<br>[&nbsp;&nbsp;&nbsp; 1.072326] usbcore: registered new interface dri=
ver rndis_host<br>[&nbsp;&nbsp;&nbsp; 1.078643] usbcore: registered new int=
erface driver cdc_subset<br>[&nbsp;&nbsp;&nbsp; 1.084960] usbcore: register=
ed new interface driver zaurus<br>[&nbsp;&nbsp;&nbsp; 1.090911] usbcore: re=
gistered new interface driver MOSCHIP usb-ethernet driver<br>[&nbsp;&nbsp;&=
nbsp; 1.099060] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver<=
br>[&nbsp;&nbsp;&nbsp; 1.106079] _regulator_get: ehci-omap.0 supply hsusb0 =
not found, using dummy regulator<br>[&nbsp;&nbsp;&nbsp; 1.114501] _regulato=
r_get: ehci-omap.0 supply hsusb1 not found, using dummy regulator<br>[&nbsp=
;&nbsp;&nbsp; 3.135040] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller<br=
>[&nbsp;&nbsp;&nbsp; 3.141448] ehci-omap ehci-omap.0: new USB bus registere=
d, assigned bus number 1<br>[&nbsp;&nbsp;&nbsp; 3.149414] ehci-omap ehci-om=
ap.0: irq 77, io mem 0x48064800<br>[&nbsp;&nbsp;&nbsp; 3.166320] ehci-omap =
ehci-omap.0: USB 2.0 started, EHCI 1.00<br>[&nbsp;&nbsp;&nbsp; 3.172454] us=
b usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002<br>[&nbsp;&=
nbsp;&nbsp; 3.179626] usb usb1: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1<br>[&nbsp;&nbsp;&nbsp; 3.187255] usb usb1: Product: OMA=
P-EHCI Host Controller<br>[&nbsp;&nbsp;&nbsp; 3.192871] usb usb1: Manufactu=
rer: Linux 3.0.4+ ehci_hcd<br>[&nbsp;&nbsp;&nbsp; 3.198547] usb usb1: Seria=
lNumber: ehci-omap.0<br>[&nbsp;&nbsp;&nbsp; 3.203948] hub 1-0:1.0: USB hub =
found<br>[&nbsp;&nbsp;&nbsp; 3.207946] hub 1-0:1.0: 3 ports detected<br>[&n=
bsp;&nbsp;&nbsp; 3.236663] Initializing USB Mass Storage driver...<br>[&nbs=
p;&nbsp;&nbsp; 3.241943] usbcore: registered new interface driver usb-stora=
ge<br>[&nbsp;&nbsp;&nbsp; 3.248321] USB Mass Storage support registered.<br=
>[&nbsp;&nbsp;&nbsp; 3.253692] mousedev: PS/2 mouse device common for all m=
ice<br>[&nbsp;&nbsp;&nbsp; 3.260070] input: gpio-keys as /devices/platform/=
gpio-keys/input/input0<br>[&nbsp;&nbsp;&nbsp; 3.268524] input: twl4030_pwrb=
utton as /devices/platform/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/i=
nput/input1<br>[&nbsp;&nbsp;&nbsp; 3.280242] i2c /dev entries driver<br>[&n=
bsp;&nbsp;&nbsp; 3.284393] Linux media interface: v0.10<br>[&nbsp;&nbsp;&nb=
sp; 3.288604] Linux video capture interface: v2.00<br>[&nbsp;&nbsp;&nbsp; 3=
.293701] vpfe_init<br>[&nbsp;&nbsp;&nbsp; 3.296691] OMAP Watchdog Timer Rev=
 0x31: initial timeout 60 sec<br>[&nbsp;&nbsp;&nbsp; 3.303131] Bluetooth: H=
CI UART driver ver 2.2<br>[&nbsp;&nbsp;&nbsp; 3.307830] Bluetooth: HCI H4 p=
rotocol initialized<br>[&nbsp;&nbsp;&nbsp; 3.312866] Bluetooth: HCI BCSP pr=
otocol initialized<br>[&nbsp;&nbsp;&nbsp; 3.318115] Bluetooth: HCILL protoc=
ol initialized<br>[&nbsp;&nbsp;&nbsp; 3.323089] Bluetooth: HCIATH3K protoco=
l initialized<br>[&nbsp;&nbsp;&nbsp; 3.328308] Bluetooth: Generic Bluetooth=
 USB driver ver 0.6<br>[&nbsp;&nbsp;&nbsp; 3.334381] usbcore: registered ne=
w interface driver btusb<br>[&nbsp;&nbsp;&nbsp; 3.340270] cpuidle: using go=
vernor ladder<br>[&nbsp;&nbsp;&nbsp; 3.344573] cpuidle: using governor menu=
<br>[&nbsp;&nbsp;&nbsp; 3.351043] omap_hsmmc: probe of omap_hsmmc.1 failed =
with error -16<br>[&nbsp;&nbsp;&nbsp; 3.360168] usbcore: registered new int=
erface driver usbhid<br>[&nbsp;&nbsp;&nbsp; 3.366088] usbhid: USB HID core =
driver<br>[&nbsp;&nbsp;&nbsp; 3.370635] usbcore: registered new interface d=
river snd-usb-audio<br>[&nbsp;&nbsp;&nbsp; 3.378021] OMAP3 Beagle/Devkit800=
0 SoC init<br>[&nbsp;&nbsp;&nbsp; 3.462554] asoc: twl4030-hifi &lt;-&gt; om=
ap-mcbsp-dai.1 mapping ok<br>[&nbsp;&nbsp;&nbsp; 3.472076] ALSA device list=
:<br>[&nbsp;&nbsp;&nbsp; 3.475219]&nbsp;&nbsp; #0: omap3beagle<br>[&nbsp;&n=
bsp;&nbsp; 3.478332] oprofile: hardware counters not available<br>[&nbsp;&n=
bsp;&nbsp; 3.483673] oprofile: using timer interrupt.<br>[&nbsp;&nbsp;&nbsp=
; 3.488677] TCP cubic registered<br>[&nbsp;&nbsp;&nbsp; 3.492126] NET: Regi=
stered protocol family 17<br>[&nbsp;&nbsp;&nbsp; 3.496887] hub 1-0:1.0: una=
ble to enumerate USB device on port 2<br>[&nbsp;&nbsp;&nbsp; 3.503387] NET:=
 Registered protocol family 15<br>[&nbsp;&nbsp;&nbsp; 3.508117] lib80211: c=
ommon routines for IEEE802.11 drivers<br>[&nbsp;&nbsp;&nbsp; 3.514190] Regi=
stering the dns_resolver key type<br>[&nbsp;&nbsp;&nbsp; 3.519256] VFP supp=
ort v0.3: implementor 41 architecture 3 part 30 variant c rev 3<br>[&nbsp;&=
nbsp;&nbsp; 3.528411] ThumbEE CPU extension supported.<br>[&nbsp;&nbsp;&nbs=
p; 3.537292] omap_voltage_get_voltdata: Unable to match the current voltage=
 with the voltagetable for vdd_mpu_iva<br>[&nbsp;&nbsp;&nbsp; 3.553222] sr_=
init: No PMIC hook to init smartreflex<br>[&nbsp;&nbsp;&nbsp; 3.558807] sma=
rtreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized<br>[&=
nbsp;&nbsp;&nbsp; 3.567199] smartreflex smartreflex.1: omap_sr_probe: Smart=
Reflex driver initialized<br>[&nbsp;&nbsp;&nbsp; 3.575500] SmartReflex Clas=
s3 initialized<br>[&nbsp;&nbsp;&nbsp; 3.584259] clock: disabling unused clo=
cks to save power<br>[&nbsp;&nbsp;&nbsp; 3.590789] registered taskstats ver=
sion 1<br>[&nbsp;&nbsp;&nbsp; 3.595855] omapfb omapfb: no driver for displa=
y<br>[&nbsp;&nbsp;&nbsp; 3.600830] omapfb omapfb: failed to setup omapfb<br=
>[&nbsp;&nbsp;&nbsp; 3.606445] regulator_init_complete: VDVI: incomplete co=
nstraints, leaving on<br>[&nbsp;&nbsp;&nbsp; 3.614288] regulator_init_compl=
ete: VDAC: incomplete constraints, leaving on<br>[&nbsp;&nbsp;&nbsp; 3.6225=
58] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)<br>[&nbsp;&nbsp=
;&nbsp; 3.629730] omapdss DPI: Could not find exact pixel clock. Requested =
23500 kHz, got 24000 kHz<br>[&nbsp;&nbsp;&nbsp; 3.669006] omap_vout omap_vo=
ut: : registered and initialized video device 0<br>[&nbsp;&nbsp;&nbsp; 3.67=
6513] Unable to handle kernel NULL pointer dereference at virtual address 0=
000005c<br>[&nbsp;&nbsp;&nbsp; 3.685058] pgd =3D c0004000<br>[&nbsp;&nbsp;&=
nbsp; 3.687896] [0000005c] *pgd=3D00000000<br>[&nbsp;&nbsp;&nbsp; 3.691680]=
 Internal error: Oops: 5 [#1]<br>[&nbsp;&nbsp;&nbsp; 3.695831] Modules link=
ed in:<br>[&nbsp;&nbsp;&nbsp; 3.699066] CPU: 0&nbsp;&nbsp;&nbsp; Not tainte=
d&nbsp; (3.0.4+ #2)<br>[&nbsp;&nbsp;&nbsp; 3.703735] PC is at omap_vout_pro=
be+0x6b8/0x7e0<br>[&nbsp;&nbsp;&nbsp; 3.708618] LR is at omap_vout_probe+0x=
684/0x7e0<br>[&nbsp;&nbsp;&nbsp; 3.713470] pc : [&lt;c00297bc&gt;]&nbsp;&nb=
sp;&nbsp; lr : [&lt;c0029788&gt;]&nbsp;&nbsp;&nbsp; psr: 80000013<br>[&nbsp=
;&nbsp;&nbsp; 3.713500] sp : de82bec0&nbsp; ip : 00000000&nbsp; fp : 000000=
04<br>[&nbsp;&nbsp;&nbsp; 3.725585] r10: dea87bc8&nbsp; r9 : dea87bc4&nbsp;=
 r8 : 00000186<br>[&nbsp;&nbsp;&nbsp; 3.731109] r7 : 00000184&nbsp; r6 : de=
a87bc0&nbsp; r5 : 00000000&nbsp; r4 : 00000002<br>[&nbsp;&nbsp;&nbsp; 3.737=
976] r3 : 00000000&nbsp; r2 : de82be7c&nbsp; r1 : c05bb360&nbsp; r0 : c0651=
f40<br>[&nbsp;&nbsp;&nbsp; 3.744842] Flags: Nzcv&nbsp; IRQs on&nbsp; FIQs o=
n&nbsp; Mode SVC_32&nbsp; ISA ARM&nbsp; Segment kernel<br>[&nbsp;&nbsp;&nbs=
p; 3.752532] Control: 10c5387d&nbsp; Table: 80004019&nbsp; DAC: 00000015<br=
>[&nbsp;&nbsp;&nbsp; 3.758605] Process swapper (pid: 1, stack limit =3D 0xd=
e82a2f0)<br>[&nbsp;&nbsp;&nbsp; 3.764739] Stack: (0xde82bec0 to 0xde82c000)=
<br>[&nbsp;&nbsp;&nbsp; 3.769317] bec0: 00000000 de819a40 00000030 dea87bc0=
 deb10c00 00000003 00000003 dea87bdc<br>[&nbsp;&nbsp;&nbsp; 3.777954] bee0:=
 dea87bc0 00000001 deb10c00 dea87bc0 de879878 00000004 c064580c c06457d8<br=
>[&nbsp;&nbsp;&nbsp; 3.786560] bf00: c064580c c067be4c c067be4c 00000000 00=
000000 00000000 00000000 c02a79b4<br>[&nbsp;&nbsp;&nbsp; 3.795196] bf20: c0=
2a79a0 c02a6944 00000000 c06457d8 c064580c c067be4c 00000000 c02a6a60<br>[&=
nbsp;&nbsp;&nbsp; 3.803802] bf40: c067be4c de82bf50 c02a6a00 c02a5bf4 de807=
6b8 de8736f0 c067be4c c067be4c<br>[&nbsp;&nbsp;&nbsp; 3.812408] bf60: dea86=
440 c0671618 00000000 c02a6264 c058901c c0589021 0000005f c067be4c<br>[&nbs=
p;&nbsp;&nbsp; 3.821044] bf80: c0031924 c0042cd4 c00290d8 00000000 00000000=
 c02a6f6c 00000000 c0031914<br>[&nbsp;&nbsp;&nbsp; 3.829650] bfa0: c0031924=
 c0042cd4 c00290d8 00000000 00000000 c00290e4 de82a000 c003d45c<br>[&nbsp;&=
nbsp;&nbsp; 3.838287] bfc0: c00290d8 c05ce3b4 c0689640 00000000 c0031914 c0=
031924 c0042cd4 00000013<br>[&nbsp;&nbsp;&nbsp; 3.846893] bfe0: 00000000 c0=
00894c 00000000 00000000 c00088c4 c0042cd4 01100800 00000008<br>[&nbsp;&nbs=
p;&nbsp; 3.855529] [&lt;c00297bc&gt;] (omap_vout_probe+0x6b8/0x7e0) from [&=
lt;c02a79b4&gt;] (platform_drv_probe+0x14/0x18)<br>[&nbsp;&nbsp;&nbsp; 3.86=
5447] [&lt;c02a79b4&gt;] (platform_drv_probe+0x14/0x18) from [&lt;c02a6944&=
gt;] (driver_probe_device+0xc8/0x184)<br>[&nbsp;&nbsp;&nbsp; 3.875610] [&lt=
;c02a6944&gt;] (driver_probe_device+0xc8/0x184) from [&lt;c02a6a60&gt;] (__=
driver_attach+0x60/0x84)<br>[&nbsp;&nbsp;&nbsp; 3.885528] [&lt;c02a6a60&gt;=
] (__driver_attach+0x60/0x84) from [&lt;c02a5bf4&gt;] (bus_for_each_dev+0x4=
c/0x78)<br>[&nbsp;&nbsp;&nbsp; 3.895050] [&lt;c02a5bf4&gt;] (bus_for_each_d=
ev+0x4c/0x78) from [&lt;c02a6264&gt;] (bus_add_driver+0x98/0x210)<br>[&nbsp=
;&nbsp;&nbsp; 3.904602] [&lt;c02a6264&gt;] (bus_add_driver+0x98/0x210) from=
 [&lt;c02a6f6c&gt;] (driver_register+0xa0/0x120)<br>[&nbsp;&nbsp;&nbsp; 3.9=
14154] [&lt;c02a6f6c&gt;] (driver_register+0xa0/0x120) from [&lt;c00290e4&g=
t;] (omap_vout_init+0xc/0x2c)<br>[&nbsp;&nbsp;&nbsp; 3.923492] [&lt;c00290e=
4&gt;] (omap_vout_init+0xc/0x2c) from [&lt;c003d45c&gt;] (do_one_initcall+0=
x90/0x160)<br>[&nbsp;&nbsp;&nbsp; 3.932861] [&lt;c003d45c&gt;] (do_one_init=
call+0x90/0x160) from [&lt;c000894c&gt;] (kernel_init+0x88/0x130)<br>[&nbsp=
;&nbsp;&nbsp; 3.942138] [&lt;c000894c&gt;] (kernel_init+0x88/0x130) from [&=
lt;c0042cd4&gt;] (kernel_thread_exit+0x0/0x8)<br>[&nbsp;&nbsp;&nbsp; 3.9514=
16] Code: e3e05012 ea000016 e59a0094 e5903200 (e593c05c) <br>[&nbsp;&nbsp;&=
nbsp; 3.957885] ---[ end trace cbb5c332507f77c9 ]---<br>[&nbsp;&nbsp;&nbsp;=
 3.962890] Kernel panic - not syncing: Attempted to kill init!<br>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msg/beagleboard/-/DpkSFJYB3g4J">https://groups.google.com/d/msg/beagle=
board/-/DpkSFJYB3g4J</a>.<br />=20
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.<br />

For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.<br />



------=_Part_698_15784874.1315478251630--
