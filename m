From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: SanDisk MMC card timeouts
Date: Mon, 18 Jul 2011 01:30:22 -0500
Message-ID: <CAD=GYpaWYcvho87EMzy1Szz3=VZiU=GYApSozd4U_ELhRBtdjA@mail.gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <beagleboard+bncCK_qjoz9EhCApo_xBBoEZhXjSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "Kooi, Koen" <k-kooi-l0cyMroinI0@public.gmane.org>, "Kridner, Jason" <jdk-l0cyMroinI0@public.gmane.org>, "Kipisz, Steven" <s-kipisz2-l0cyMroinI0@public.gmane.org>, "Coley, Gerald" <g-coley1-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

We're seeing MMC timeout errors with SanDisk MMC cards and a 2.6.32
kernel (BeagleBoard Rev C5).

The suggested fix of setting dto timeout to 14
(http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg42214.html)
doesn't help. Any other suggestions with any familiar with this issue?

The errors seem to be entering logs from mmc_blk_issue_rw_rq in
drivers/mmc/card/block.c
Here is a boot log:
---
Texas Instruments X-Loader 1.5.0 (Jun 14 2011 - 22:04:07)
Beagle xM
Reading boot sector
Loading u-boot.bin from mmc



U-Boot 2011.03-rc1-00000-g9a3cc57-dirty (Apr 01 2011 - 17:41:42)

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
Die ID #73f600029ff80000015f26ad0f025029
Hit any key to stop autoboot:  3     2     1     0
The user button is currently NOT pressed.
SD/MMC found on device 0
reading uEnv.txt



622 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
Device nand0 not found!
Loading file "/boot/MLO" from mmc device 0:2 (xxa2)
23852 bytes read
Error: Can't switch ecc, no devices available


no devices available


no devices available
Loading file "/boot/u-boot.bin" from mmc device 0:2 (xxa2)
284788 bytes read

Error: Can't switch ecc, no devices available

no devices available

no devices available
Loading file "/boot/uImage" from mmc device 0:2 (xxa2)
3202868 bytes read
Error: Can't switch ecc, no devices available

no devices available

no devices available
Saving Environment to NAND...
Erasing Nand...
Attempt to erase non page aligned data
writing root fs after booting
Loading file "/boot/uImage" from mmc device 0:2 (xxa2)
3202868 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 80200000 ...
  Image Name:   Angstrom/2.6.32/beagleboard

  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    3202804 Bytes =3D 3.1 MiB
  Load Address: 80008000
  Entry Point:  80008000
  Verifying Checksum ... OK
  Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux........................................................=
...........................................................................=
...........................................................................=
...
done, booting the kernel.
[    0.000000] Linux version 2.6.32 (joel@chase-ubuntu) (gcc version
4.3.3 (GCC) ) #3 PREEMPT Fri Jul 15 17:30:31 CDT 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache

[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630/DM3730 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
[    0.000000] Reserving 12582912 bytes SDRAM for VRAM
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: console=3DttyS2,115200n8
mpurate=3Dauto buddy=3Dnone camera=3Dnone vram=3D12M
omapfb.mode=3Ddvi:640x480MR-16@60 omapdss.def_disp=3Ddvi
root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait
[    0.000000] Beagle expansionboard: none
[    0.000000] Beagle cameraboard: none
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Memory: 256MB 256MB =3D 512MB total
[    0.000000] Memory: 500352KB available (5900K code, 673K data, 204K
init, 0K highmem)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:402
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] GPMC revision 5.0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP GPIO hardware version 2.5
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 501.02 BogoMIPS (lpj=3D1957888)
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] tmpfs: No value for mount option 'mode'

[    0.000000] devtmpfs: initialized
[    0.000000] regulator: core version 0.5
[    0.000000] NET: Registered protocol family 16
[    0.000000] OMAP3 Beagle Rev: xM C
[    0.000000] Found NAND on CS0
[    0.000000] Registering NAND on CS0

[    0.000000] Unable to get DVI reset GPIO
[    0.000000] omap_init_mbox: platform not supported
[   11.337036] OMAP DMA hardware revision 5.0
[   11.343322] bio: create slab <bio-0> at 0
[   11.344573] SCSI subsystem initialized
[   11.345855] usbcore: registered new interface driver usbfs
[   11.345977] usbcore: registered new interface driver hub
[   11.346221] usbcore: registered new device driver usb
[   11.346557] i2c_omap i2c_omap.1: bus 1 rev4.0 at 2600 kHz
[   11.349212] twl4030: PIH (irq 7) chaining IRQs 368..375
[   11.349243] twl4030: power (irq 373) chaining IRQs 376..383
[   11.349517] twl4030: gpio (irq 368) chaining IRQs 384..401
[   11.351226] regulator: VUSB1V5: 1500 mV normal standby
[   11.351440] regulator: VUSB1V8: 1800 mV normal standby
[   11.351654] regulator: VUSB3V1: 3100 mV normal standby
[   11.352935] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[   11.353332] regulator: VMMC1: 1850 <--> 3150 mV normal standby
[   11.353576] regulator: VDAC: 1800 mV normal standby
[   11.353790] regulator: VPLL2: 1800 mV normal standby
[   11.354034] regulator: VSIM: 1800 <--> 3000 mV normal standby
[   11.354339] regulator: VAUX3: 1800 mV normal standby
[   11.354675] regulator: VAUX4: 1800 mV normal standby
[   11.354858] i2c_omap i2c_omap.2: bus 2 rev4.0 at 400 kHz
[   11.365631] i2c_omap i2c_omap.3: bus 3 rev4.0 at 100 kHz
[   11.366790] Switching to clocksource 32k_counter
[   11.375854] musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), deb=
ug=3D0
[   11.379516] musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IR=
Q 92
[   11.379547] musb_hdrc musb_hdrc: MUSB HDRC host driver
[   11.379669] musb_hdrc musb_hdrc: new USB bus registered, assigned
bus number 1
[   11.379791] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   11.379791] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[   11.379821] usb usb1: Product: MUSB HDRC host driver
[   11.379821] usb usb1: Manufacturer: Linux 2.6.32 musb-hcd
[   11.379852] usb usb1: SerialNumber: musb_hdrc
[   11.380462] hub 1-0:1.0: USB hub found
[   11.380493] hub 1-0:1.0: 1 port detected
[   11.381530] NET: Registered protocol family 2
[   11.381744] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[   11.382263] TCP established hash table entries: 16384 (order: 5,
131072 bytes)

[   11.382720] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   11.382934] TCP: Hash tables configured (established 16384 bind 16384)
[   11.382965] TCP reno registered
[   11.382965] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   11.382995] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   11.383270] NET: Registered protocol family 1
[   11.383666] RPC: Registered udp transport module.
[   11.383697] RPC: Registered tcp transport module.
[   11.383697] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   11.384582] omap-iommu omap-iommu.0: isp registered
[   11.386260] VFS: Disk quotas dquot_6.5.2

[   11.386383] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   11.387420] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   11.388214] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Ha=
t, Inc.
[   11.389007] msgmni has been set to 977
[   11.392791] alg: No test for stdrng (krng)
[   11.393066] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 254)
[   11.393096] io scheduler noop registered
[   11.393096] io scheduler deadline registered
[   11.393249] io scheduler cfq registered (default)
[   11.452972] OMAP DSS rev 2.0
[   11.453033] OMAP DISPC rev 3.0
[   11.453094] OMAP VENC rev 2
[   11.453338] OMAP DSI rev 1.0
[   11.789886] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   11.807800] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST1=
6654
[   11.825103] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST1=
6654
[   11.842315] serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST1=
6654
[   12.402343] console [ttyS2] enabled
[   12.412506] brd: module loaded
[   12.418823] loop: module loaded
[   12.423370] omap2-nand driver initializing
[   12.427734] No NAND device found431427] No NAND device found!!!
[   12.435943] usbcore: registered new interface driver catc

[   12.441436] catc: v2.8:CATC EL1210A NetMate USB Ethernet driver
[   12.447509] usbcore: registered new interface driver kaweth
[   12.453155] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB
Ethernet driver
[   12.460784] usbcore: registered new interface driver pegasus
[   12.466461] rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driv=
er
[   12.473480] usbcore: registered new interface driver rtl8150
[   12.479278] usbcore: registered new interface driver asix
[   12.484802] usbcore: registered new interface driver cdc_ether
[   12.490722] usbcore: registered new interface driver dm9601
[   12.496459] usbcore: registered new interface driver smsc95xx
[   12.502319] usbcore: registered new interface driver gl620a
[   12.508026] usbcore: registered new interface driver net1080
[   12.513793] usbcore: registered new interface driver plusb
[   12.519409] usbcore: registered new interface driver rndis_host
[   12.525451] usbcore: registered new interface driver cdc_subset
[   12.531524] usbcore: registered new interface driver zaurus
[   12.537170] usbcore: registered new interface driver MOSCHIP
usb-ethernet driver
[   12.545227] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.552062] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[   12.558074] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 2
[   12.565673] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[   12.585662] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[   12.591552] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   12.598419] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[   12.605712] usb usb2: Product: OMAP-EHCI Host Controller
[   12.611083] usb usb2: Manufacturer: Linux 2.6.32 ehci_hcd
[   12.616516] usb usb2: SerialNumber: ehci-omap.0
[   12.621734] hub 2-0:1.0: USB hub found
[   12.625579] hub 2-0:1.0: 3 ports detected
[   12.656097] Initializing USB Mass Storage driver...
[   12.661163] usbcore: registered new interface driver usb-storage
[   12.667266] USB Mass Storage support registered.
[   12.672271] mice: PS/2 mouse device common for all mice

[   12.677886] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   12.685729] input: twl4030_pwrbutton as
/devices/platform/i2c_omap.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[   12.696411] i2c /dev entries driver
[   12.700500] Linux video capture interface: v2.00

[   12.705444] omap-iommu omap-iommu.0: isp: version 1.1
[   12.712158] vpfe_init
[   12.714996] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[   12.721740] cpuidle: using governor ladder
[   12.725891] cpuidle: using governor menu
[   12.835968] mmci-omap-hs mmci-omap-hs.1: err -16 configuring card detect
[   12.842987] Registered led device: beagleboard::usr0
[   12.848175] Registered led device: beagleboard::usr1
[   12.854736] Registered led device: beagleboard::pmu_stat
[   12.861816] usbcore: registered new interface driver usbhid
[   12.867492] usbhid: USB HID core driver
[   12.871520] Advanced Linux Sound Architecture Driver Version 1.0.21.
[   12.878417] usbcore: registered new interface driver snd-usb-audio
[   12.952972] usb 2-2: new high speed USB device using ehci-omap and addre=
ss 2
[   12.962677] No device for DAI omap-mcbsp-dai-0
[   12.967163] No device for DAI omap-mcbsp-dai-1
[   12.971649] No device for DAI omap-mcbsp-dai-2

[   12.976135] No device for DAI omap-mcbsp-dai-3
[   12.980651] No device for DAI omap-mcbsp-dai-4
[   12.985137] OMAP3 Beagle SoC init
[   12.989257] asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
[   13.000762] ALSA device list:
[   13.003753]   #0: omap3beagle (twl4030)
[   13.007751] oprofile: using arm/armv7
[   13.011657] TCP cubic registered
[   13.014923] NET: Registered protocol family 17

[   13.019470] NET: Registered protocol family 15
[   13.024047] lib80211: common routines for IEEE802.11 drivers
[   13.029785] ThumbEE CPU extension supported.
[   13.034088] Power Management for TI OMAP3.
[   13.039489] SmartReflex driver initialized
[   13.043731] omap3beaglelmb: Driver registration complete
[   13.057495] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[   13.065704] registered taskstats version 1
[   13.070587] fbcvt: 640x480@60: CVT Name - .307M3-R
[   13.084320] Console: switching to colour frame buffer device 80x30
[   13.098815] regulator_init_complete: incomplete constraints, leaving VAU=
X3 on
[ 13.106445] regulator_init_complete: incomplete constraints, leaving VDAC =
on
[   13.114349] omap_vout omap_vout: probed for an unknown device
[   13.120483] Waiting for root device /dev/mmcblk0p2...
[   13.133178] usb 2-2: New USB device found, idVendor=3D0424, idProduct=3D=
9514
[   13.139923] usb 2-2: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0

[   13.147766] hub 2-2:1.0: USB hub found
[   13.151763] hub 2-2:1.0: 5 ports detected
[   13.359344] mmc0: host does not support reading read-only switch.
assuming write-enable.

[   13.367553] mmc0: new SDHC card at address b368
[   13.372497] mmcblk0: mmc0:b368 SDC   3.84 GiB

[   13.377258]  mmcblk0:
[   13.380462] mmcblk0: error -110 transferring data, sector 0, nr 8,
card status 0xb00
[   13.388519] end_request: I/O error, dev mmcblk0, sector 0
[   13.397277] Buffer I/O error on device mmcblk0, logical block 0
[   13.404266] mmcblk0: error -110 transferring data, sector 0, nr 8,
card status 0xb00
[   13.412109] end_request: I/O error, dev mmcblk0, sector 0
[   13.420806] Buffer I/O error on device mmcblk0, logical block 0
[   13.427856] mmcblk0: error -110 transferring data, sector 0, nr 8,
card status 0xb00
[   13.435668] end_request: I/O error, dev mmcblk0, sector 0
[   13.444335] Buffer I/O error on device mmcblk0, logical block 0
[   13.450347] ldm_validate_partition_table(): Disk read failed.
[   13.456481] usb 2-2.1: new high speed USB device using ehci-omap
and address 3
[   13.464263] mmcblk0: error -110 transferring data, sector 0, nr 8,
card status 0xb00
[   13.472106] end_request: I/O error, dev mmcblk0, sector 0
[   13.480834] Buffer I/O error on device mmcblk0, logical block 0
[   13.487792] mmcblk0: error -110 transferring data, sector 0, nr 8,
card status 0xb00
[   13.495666] end_request: I/O error, dev mmcblk0, sector 0

[   13.504364] Buffer I/O error on device mmcblk0, logical block 0
[   13.510375]  unable to read partition table

[   13.562469] VFS: Cannot open root device "mmcblk0p2" or unknown-block(17=
9,2)
[   13.569549] Please append a correct "root=3D" boot option; here are
the available partitions:
[   13.578002] b300         4027392 mmcblk0 driver: mmcblk
[   13.583251] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(179,2)

--=20
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.
For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.
