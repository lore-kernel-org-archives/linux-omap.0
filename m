From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Wed, 14 Jan 2009 14:14:13 -0800
Message-ID: <87wscxk022.fsf@deeprootsystems.com>
References: <87iqoij2me.fsf@deeprootsystems.com>
	<84166B96-7874-4B6D-B86E-659250F62558@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:50060 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954AbZANWOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 17:14:33 -0500
Received: by ewy10 with SMTP id 10so949269ewy.13
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 14:14:28 -0800 (PST)
In-Reply-To: <84166B96-7874-4B6D-B86E-659250F62558@student.utwente.nl> (Koen Kooi's message of "Wed\, 14 Jan 2009 08\:35\:30 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Koen Kooi <k.kooi@student.utwente.nl> writes:

> Op 13 jan 2009, om 22:51 heeft Kevin Hilman het volgende geschreven:
>
>> Hello,
>>
>> The latest PM branch is now available[1].
>>
>> I've done basic testing of retention and off-mode (suspend and dynam=
ic
>> idle) on Beagle and custom HW.  My SDP has something still keeping
>> CORE active that others have not seen, but I have yet to debug.  Any
>> other reports from SDP testing would be appreciated.
>>
>> Notable changes/updates
>> - rebased on latest clock updates and fixes from Paul
>> - clockfw pre- and post- notifiers
>> - DVFS for VDD2
>
> The bootlog on my rev C1D beagle looks suspicious:
>

Hi Koen,

Hmm, it looks like you're tree is missing the McBSP fix from Paul[1].
This patch made it in before v2.6.28-omap1 which the latest PM branch
is based on, so I'm guessing you're not testing the latest PM branch.

Kevin


> Texas Instruments X-Loader 1.4.2 (Dec  3 2008 - 23:20:13)
> Reading boot sector
> Booting from mmc
>
>
> U-Boot 2009.01-rc1-00102-g8ecaab3 (Jan 10 2009 - 13:56:28)
>
> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
> OMAP3 Beagle board + LPDDR/NAND
> DRAM:  256 MB
> NAND:  256 MiB
> musb: using high speed
> In:    serial
> Out:   serial
> Err:   serial
> Board revision: Cx
> Debug (GPIO6 datain): 0x04800000
> Hit any key to stop autoboot:  1 =08=08=08 0
> reading boot.scr
>
> ** Unable to read "boot.scr" from mmc 0:1 **
> reading uImage
>
> 2556572 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   Angstrom/2.6.28-pm1+gitrb5d11429
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2556508 Bytes =3D  2.4 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
>
> Uncompressing  Linux
> .....................................................................=
=2E....................................................................=
=2E......................... done
> , booting the kernel.
> Linux version 2.6.28-omap1 (koen@dominion) (gcc version 4.2.1) #1 Sun
> Jan 11 18:52:51 CET 2009
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> Memory policy: ECC disabled, Data cache writeback
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c050be14, node_mem_map c0540000
>   Normal zone: 512 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 65024 pages, LIFO batch:15
>   Movable zone: 0 pages used for memmap
> OMAP3430 ES3.0
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> 65024
> Kernel command line: console=3DttyS2,115200n8 video=3Domapfb:vram:2M,=
vram:
> 4M,mode:640x480@60 omapfb.debug=3Dy omap-dss.debug=3Dy loglevel=3D10
> omapfb.vram=3D4M,4M root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwa=
it
> Unknown boot option `omapfb.debug=3Dy': ignoring
> Unknown boot option `omap-dss.debug=3Dy': ignoring
> Unknown boot option `omapfb.vram=3D4M,4M': ignoring
> Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> OMAP clockevent source: GPTIMER12 at 32768 Hz
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128MB 128MB =3D 256MB total
> Memory: 254336KB available (4712K code, 428K data, 188K init)
> Calibrating delay loop... 478.91 BogoMIPS (lpj=3D1867776)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 532 bytes
> regulator: core version 0.5
> NET: Registered protocol family 16
> Found NAND on CS0
> Registering NAND on CS0
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpat=
h
> +0x4c/0x68)
> [<c005b134>] (warn_on_slowpath+0x0/0x68) from [<c00416a8>]
> (omap2_clk_register+0x24/0x3c)
>  r6:c04de968 r5:c04d82d8 r4:c04d8270
> [<c0041684>] (omap2_clk_register+0x0/0x3c) from [<c0048854>]
> (clk_register+0x44/0xc8)
> [<c0048810>] (clk_register+0x0/0xc8) from [<c00113ec>]
> (omap2_mcbsp_init+0xc8/0x130)
>  r7:c0469ded r6:00000008 r5:c04d82d8 r4:c04d8270
> [<c0011324>] (omap2_mcbsp_init+0x0/0x130) from [<c00372d4>]
> (do_one_initcall+0x64/0x198)
> [<c0037270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
> (kernel_init +0x70/0xdc)
> [<c00086a8>] (kernel_init+0x0/0xdc) from [<c005db54>] (do_exit
> +0x0/0x6b4)
>  r5:00000000 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpat=
h
> +0x4c/0x68)
> [<c005b134>] (warn_on_slowpath+0x0/0x68) from [<c00416a8>]
> (omap2_clk_register+0x24/0x3c)
>  r6:c04de968 r5:c04d8340 r4:c04d82d8
> [<c0041684>] (omap2_clk_register+0x0/0x3c) from [<c0048854>]
> (clk_register+0x44/0xc8)
> [<c0048810>] (clk_register+0x0/0xc8) from [<c00113ec>]
> (omap2_mcbsp_init+0xc8/0x130)
>  r7:c0469ded r6:00000008 r5:c04d8340 r4:c04d8270
> [<c0011324>] (omap2_mcbsp_init+0x0/0x130) from [<c00372d4>]
> (do_one_initcall+0x64/0x198)
> [<c0037270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
> (kernel_init +0x70/0xdc)
> [<c00086a8>] (kernel_init+0x0/0xdc) from [<c005db54>] (do_exit
> +0x0/0x6b4)
>  r5:00000000 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpat=
h
> +0x4c/0x68)
> [<c005b134>] (warn_on_slowpath+0x0/0x68) from [<c00416a8>]
> (omap2_clk_register+0x24/0x3c)
>  r6:c04de968 r5:c04d83a8 r4:c04d8340
> [<c0041684>] (omap2_clk_register+0x0/0x3c) from [<c0048854>]
> (clk_register+0x44/0xc8)
> [<c0048810>] (clk_register+0x0/0xc8) from [<c00113ec>]
> (omap2_mcbsp_init+0xc8/0x130)
>  r7:c0469ded r6:00000008 r5:c04d83a8 r4:c04d8270
> [<c0011324>] (omap2_mcbsp_init+0x0/0x130) from [<c00372d4>]
> (do_one_initcall+0x64/0x198)
> [<c0037270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
> (kernel_init +0x70/0xdc)
> [<c00086a8>] (kernel_init+0x0/0xdc) from [<c005db54>] (do_exit
> +0x0/0x6b4)
>  r5:00000000 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpat=
h
> +0x4c/0x68)
> [<c005b134>] (warn_on_slowpath+0x0/0x68) from [<c00416a8>]
> (omap2_clk_register+0x24/0x3c)
>  r6:c04de968 r5:c04d8410 r4:c04d83a8
> [<c0041684>] (omap2_clk_register+0x0/0x3c) from [<c0048854>]
> (clk_register+0x44/0xc8)
> [<c0048810>] (clk_register+0x0/0xc8) from [<c00113ec>]
> (omap2_mcbsp_init+0xc8/0x130)
>  r7:c0469ded r6:00000008 r5:c04d8410 r4:c04d8270
> [<c0011324>] (omap2_mcbsp_init+0x0/0x130) from [<c00372d4>]
> (do_one_initcall+0x64/0x198)
> [<c0037270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
> (kernel_init +0x70/0xdc)
> [<c00086a8>] (kernel_init+0x0/0xdc) from [<c005db54>] (do_exit
> +0x0/0x6b4)
>  r5:00000000 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpat=
h
> +0x4c/0x68)
> [<c005b134>] (warn_on_slowpath+0x0/0x68) from [<c00416a8>]
> (omap2_clk_register+0x24/0x3c)
>  r6:c04de968 r5:c04d8478 r4:c04d8410
> [<c0041684>] (omap2_clk_register+0x0/0x3c) from [<c0048854>]
> (clk_register+0x44/0xc8)
> [<c0048810>] (clk_register+0x0/0xc8) from [<c00113ec>]
> (omap2_mcbsp_init+0xc8/0x130)
>  r7:c0469ded r6:00000008 r5:c04d8478 r4:c04d8270
> [<c0011324>] (omap2_mcbsp_init+0x0/0x130) from [<c00372d4>]
> (do_one_initcall+0x64/0x198)
> [<c0037270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
> (kernel_init +0x70/0xdc)
> [<c00086a8>] (kernel_init+0x0/0xdc) from [<c005db54>] (do_exit
> +0x0/0x6b4)
>  r5:00000000 r4:00000000
> ---[ end trace 1b75b31a2719ed1c ]---
> omap-mcbsp omap-mcbsp.1: Invalid clock configuration for McBSP1.
> omap-mcbsp: probe of omap-mcbsp.1 failed with error -2
> omap-mcbsp omap-mcbsp.2: Invalid clock configuration for McBSP2.
> omap-mcbsp: probe of omap-mcbsp.2 failed with error -2
> omap-mcbsp omap-mcbsp.3: Invalid clock configuration for McBSP3.
> omap-mcbsp: probe of omap-mcbsp.3 failed with error -2
> omap-mcbsp omap-mcbsp.4: Invalid clock configuration for McBSP4.
> omap-mcbsp: probe of omap-mcbsp.4 failed with error -2
> omap-mcbsp omap-mcbsp.5: Invalid clock configuration for McBSP5.
> omap-mcbsp: probe of omap-mcbsp.5 failed with error -2
> OMAP DMA hardware revision 4.0
> USB: No board-specific platform config found
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030: gpio (irq 368) chaining IRQs 384..401
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> SCSI subsystem initialized
> twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
> musb_hdrc: ConfigData=3D0x33 (UTMI-16, HB-ISO Rx (X), SoftConn)
> musb_hdrc: MHDRC RTL version 1.400
> musb_core_init 1405: reconfigure software for static FIFOs
> musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> regulator: VDAC: 1800 mV normal standby
> regulator: VUSB1V5: 1500 mV normal standby
> regulator: VUSB1V8: 1800 mV normal standby
> regulator: VUSB3V1: 3100 mV normal standby
> regulator: VSIM: 1800 <--> 3000 mV normal standby
> Bluetooth: Core ver 2.13
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> cfg80211: Using static regulatory domain info
> cfg80211: Regulatory domain: US
> 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
> 	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
> cfg80211: Calling CRDA for country: US
> NET: Registered protocol family 2
> Switched to high resolution mode on CPU 0
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 497
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver cdc_ether
> usbcore: registered new interface driver rndis_host
> usbcore: registered new interface driver zd1211rw
> usbcore: registered new interface driver rndis_wlan
> usbcore: registered new interface driver zd1201
> usbcore: registered new interface driver usb8xxx
> usbcore: registered new interface driver rtl8187
> usbcore: registered new interface driver rt2500usb
> usbcore: registered new interface driver rt73usb
> usbcore: registered new interface driver p54usb
> i2c /dev entries driver
> input: triton2-pwrbutton as /class/input/input0
> triton2 power button driver initialized
> Driver 'sd' needs updating - please use bus_type methods
> Driver 'sr' needs updating - please use bus_type methods
> omap2-nand driver initializing
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
> 1,8V 16-bit)
> cmdlinepart partition parsing not available
> Creating 5 MTD partitions on "omap2-nand":
> 0x00000000-0x00080000 : "X-Loader"
> 0x00080000-0x00260000 : "U-Boot"
> 0x00260000-0x00280000 : "U-Boot Env"
> 0x00280000-0x00680000 : "Kernel"
> 0x00680000-0x10000000 : "File System"
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
> ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> input: gpio-keys as /class/input/input1
> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
> twl4030_rtc twl4030_rtc: Power up reset detected.
> twl4030_rtc twl4030_rtc: Enabling TWL4030-RTC.
> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> Bluetooth: HCI USB driver ver 2.10
> usbcore: registered new interface driver hci_usb
> Bluetooth: Broadcom Blutonium firmware driver ver 1.2
> usbcore: registered new interface driver bcm203x
> Bluetooth: Digianswer Bluetooth USB driver ver 0.10
> usbcore: registered new interface driver bpa10x
> Bluetooth: Generic Bluetooth SDIO driver ver 0.1
> cpuidle: using governor ladder
> cpuidle: using governor menu
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> Registered led device: beagleboard::usr0
> Registered led device: beagleboard::usr1
> Registered led device: beagleboard::pmu_stat
> usbcore: registered new interface driver usbhid
> usbhid: v2.6:USB HID core driver
> Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
> usbcore: registered new interface driver snd-usb-audio
> ASoC version 0.13.2
> OMAP3 Beagle SoC init
> TWL4030 Audio Codec init
> asoc: twl4030 <-> omap-mcbsp-dai-(link_id) mapping ok
> ALSA device list:
>   #0: omap3beagle (twl4030)
> oprofile: using arm/armv7
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Bluetooth: L2CAP ver 2.11
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO (Voice Link) ver 0.6
> Bluetooth: SCO socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.10
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> ieee80211: 802.11 data/management/control stack, git-1.1.13
> ieee80211: Copyright (C) 2004-2005 Intel Corporation
> <jketreno@linux.intel.com=20
>>
> ieee80211_crypt: registered algorithm 'NULL'
> ieee80211_crypt: registered algorithm 'WEP'
> ieee80211_crypt: registered algorithm 'CCMP'
> ieee80211_crypt: registered algorithm 'TKIP'
> ThumbEE CPU extension supported.
> Power Management for TI OMAP3.
> pm_dbg_init()
> SmartReflex driver initialized
> Disabling unused clock "sr2_fck"
> Disabling unused clock "sr1_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt3_ick"
> Disabling unused clock "gpt4_ick"
> Disabling unused clock "gpt5_ick"
> Disabling unused clock "gpt6_ick"
> Disabling unused clock "gpt7_ick"
> Disabling unused clock "gpt8_ick"
> Disabling unused clock "gpt9_ick"
> Disabling unused clock "wdt3_ick"
> Disabling unused clock "wdt3_fck"
> Disabling unused clock "gpio2_dbck"
> Disabling unused clock "gpio3_dbck"
> Disabling unused clock "gpio4_dbck"
> Disabling unused clock "gpio5_dbck"
> Disabling unused clock "gpio6_dbck"
> Disabling unused clock "gpt9_fck"
> Disabling unused clock "gpt8_fck"
> Disabling unused clock "gpt7_fck"
> Disabling unused clock "gpt6_fck"
> Disabling unused clock "gpt5_fck"
> Disabling unused clock "gpt4_fck"
> Disabling unused clock "gpt3_fck"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "gpt1_ick"
> Disabling unused clock "wdt1_ick"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "gpio1_dbck"
> Disabling unused clock "gpt1_fck"
> Disabling unused clock "cam_ick"
> Disabling unused clock "cam_mclk"
> Disabling unused clock "dss_ick"
> Disabling unused clock "dss_96m_fck"
> Disabling unused clock "dss1_alwon_fck"
> Disabling unused clock "des1_ick"
> Disabling unused clock "sha11_ick"
> Disabling unused clock "rng_ick"
> Disabling unused clock "aes1_ick"
> Disabling unused clock "ssi_ick"
> Disabling unused clock "mailboxes_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt10_ick"
> Disabling unused clock "gpt11_ick"
> Disabling unused clock "i2c_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "hdq_ick"
> Disabling unused clock "mspro_ick"
> Disabling unused clock "des2_ick"
> Disabling unused clock "sha12_ick"
> Disabling unused clock "aes2_ick"
> Disabling unused clock "icr_ick"
> Disabling unused clock "pka_ick"
> Disabling unused clock "ssi_ssr_fck"
> Disabling unused clock "hdq_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "i2c_fck"
> Disabling unused clock "mspro_fck"
> Disabling unused clock "gpt11_fck"
> Disabling unused clock "gpt10_fck"
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m3x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 1
> twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00
> UTC (946684800)
> Waiting for root device /dev/mmcblk0p2...
> mmc0: new high speed SDHC card at address 8fe4
> mmcblk0: mmc0:8fe4 SD08G 7.40 GiB
>  mmcblk0: p1 p2 p3
> EXT3-fs warning: maximal mount count reached, running e2fsck is
> recommended
> EXT3 FS on mmcblk0p2, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem).
> Freeing init memory: 188K
> INIT: version 2.86 booting
> v/rules.d: time stamp 2009-01-13 21:05:30 is 285195917.614868154 s in
> the future
> udevd[596]: lookup_group: specified group 'scanner' unknown
>
> udevd[596]: lookup_group: specified group 'scanner' unknown
>
> udevd[596]: lookup_group: specified group 'scanner' unknown
>
> udevd[596]: lookup_group: specified group 'scanner' unknown
>
> udevd[596]: lookup_group: specified group 'nvram' unknown
>
> udevd[596]: lookup_user: specified user 'tss' unknown
>
> udevd[596]: lookup_group: specified group 'tss' unknown
>
> udevd[596]: lookup_group: specified group 'fuse' unknown
>
> udevd[596]: lookup_group: specified group 'kvm' unknown
>
> udevd[596]: lookup_group: specified group 'rdma' unknown
>
> udevd[596]: lookup_group: specified group 'rdma' unknown
>
> udevd[596]: lookup_group: specified group 'rdma' unknown
>
>
> Adding 160640k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:
> 160640k
> Remounting root file system...
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 0
> Buffer I/O error on device mtdblock0, logical block 0
> end_request: I/O error, dev mtdblock0, sector 8
> Buffer I/O error on device mtdblock0, logical block 1
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r
> 16
> Buffer I/O error on device mtdblock0, logical block 2
> uncorrectable error : <3>uncorrectable error : <3>end_request: I/O
> error, dev mtdblock0, sector 24
> Buffer I/O error on device mtdblock0, logical block 3
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 0
> Buffer I/O error on device mtdblock0, logical block 0
> WARNING: Couldn't open directory /lib/modules/2.6.28-omap1: No such
> file or directory
> FATAL: Could not open /lib/modules/2.6.28-omap1/modules.dep.temp for
> writing: No such file or directory
> modprobe: FATAL: Could not load /lib/modules/2.6.28-omap1/modules.dep=
:
> No such file or directory
>
> Setting up IP spoofing protection: rp_filter.
> Configuring network interfaces... modprobe: FATAL: Could not load
> /lib/ modules/2.6.28-omap1/modules.dep: No such file or directory
>
> eth0: unknown interface: No such device
> modprobe: FATAL: Could not load /lib/modules/2.6.28-omap1/modules.dep=
:
> No such file or directory
>
> modprobe: FATAL: Could not load /lib/modules/2.6.28-omap1/modules.dep=
:
> No such file or directory
>
> eth0      No such device
>
> modprobe: FATAL: Could not load /lib/modules/2.6.28-omap1/modules.dep=
:
> No such file or directory
>
> udhcpc: SIOCGIFINDEX: No such device
> done.
> Tue Jan 13 21:06:00 GMT 2009
> INIT: Entering runlevel: 5
> Configuring leds:
>   beagleboard::pmu_st: none
>   beagleboard::usr0: heartbeat
>   beagleboard::usr1: mmc0
> ALSA: Restoring mixer settings...
>
> modprobe: FATAL: Could not load /lib/modules/2.6.28-omap1/modules.dep=
:
> No such file or directory
>
> dropbear.
> (failed.)
> [ ok ]
> Running ntpdate to synchronize clockError : Temporary failure in name
> resolution
> .
>
> .-------.
> |       |                  .-.
> |   |   |-----.-----.-----.| |   .----..-----.-----.
> |       |     | __  |  ---'| '--.|  .-'|     |     |
> |   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
> '---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
>                 -'  |
>                 '---'
>
> The Angstrom Distribution beagleboard ttyS2
>
> Angstrom 2009.X-test-20090102 beagleboard ttyS2
>
> beagleboard login: root
> root@beagleboard:~# ls /de=08=08=08root@beagleboard:~# ls /dev/fb=07=08
> =08root@beagleboard:~# ls /dev/full root@beagleboard:~# ls /dev/full
> pm-=20
> kernel
> root@beagleboard:~# find /sy=08=08=08root@beagleboard:~# find /sys/| =
grep CPU
> root@beagleboard:~# root@beagleboard:~# find /sys/| grep CPU=08 =08=08
> =08=08  =08pcu=08 =08=08 =08=08 =08cpu
> /sys/devices/system/cpu
> /sys/devices/system/cpu/online
> /sys/devices/system/cpu/possible
> /sys/devices/system/cpu/present
> /sys/devices/system/cpu/cpuidle
> /sys/devices/system/cpu/cpuidle/current_driver
> /sys/devices/system/cpu/cpuidle/current_governor_ro
> /sys/devices/system/cpu/cpu0
> /sys/devices/system/cpu/cpu0/crash_notes
> /sys/devices/system/cpu/cpu0/cpuidle
> /sys/devices/system/cpu/cpu0/cpuidle/state0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time
> /sys/devices/system/cpu/cpu0/cpuidle/state1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time
> /sys/devices/system/cpu/cpu0/cpuidle/state2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name
> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time
> /sys/devices/system/cpu/cpu0/cpuidle/state3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time
> /sys/devices/system/cpu/cpu0/cpuidle/state4
> /sys/devices/system/cpu/cpu0/cpuidle/state4/name
> /sys/devices/system/cpu/cpu0/cpuidle/state4/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state4/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state4/power
> /sys/devices/system/cpu/cpu0/cpuidle/state4/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state4/time
> /sys/devices/system/cpu/cpu0/cpuidle/state5
> /sys/devices/system/cpu/cpu0/cpuidle/state5/name
> /sys/devices/system/cpu/cpu0/cpuidle/state5/desc
> /sys/devices/system/cpu/cpu0/cpuidle/state5/latency
> /sys/devices/system/cpu/cpu0/cpuidle/state5/power
> /sys/devices/system/cpu/cpu0/cpuidle/state5/usage
> /sys/devices/system/cpu/cpu0/cpuidle/state5/time
> /sys/class/misc/cpu_dma_latency
> /sys/class/misc/cpu_dma_latency/uevent
> /sys/class/misc/cpu_dma_latency/dev
> /sys/class/misc/cpu_dma_latency/subsystem
> /sys/class/misc/cpu_dma_latency/power
> /sys/class/misc/cpu_dma_latency/power/wakeup
> /sys/kernel/uids/0/cpu_share
> /sys/kernel/uids/1/cpu_share
> /sys/kernel/uids/46/cpu_share
> /sys/kernel/uids/47/cpu_share
> /sys/kernel/uids/42/cpu_share
> /sys/module/cpufreq
> /sys/module/cpufreq/parameters
> /sys/module/cpufreq/parameters/debug_ratelimit
> /sys/module/cpufreq/parameters/debug
> root@beagleboard:~# ls /sys/devices/system/cpu/cpu0/
> cpuidle  crash_notes
> root@beagleboard:~# cd /me=08=08=08root@beagleboard:~# cd /media/
> mm=07root@beagleboard:~# cd /media/mmcb=07root@beagleboard:~# cd /med=
ia/
> mmcblk0p1root@beagleboard:~# cd /media/mmcblk0p1/
> root@beagleboard:/media/mmcblk0p1# ls
> broken	picodlp-control_0.1-r1.1_armv7a.ipk  uImage    working
> mlo	u-boot.bin			     untested
> root@beagleboard:/media/mmcblk0p1# cp wo=08=08root@beagleboard:/media=
/
> mmcblk0p1# cp working/uI=08 =08=08
> =082=07root@beagleboard:/media/mmcblk0p1# cp  working/2.6.2
> working/2.6.26       working/2.6.28-ehci
> working/2.6.27       working/2.6.28rc7
> root@beagleboard:/media/mmcblk0p1# cp working/2.6.2
> working/2.6.26       working/2.6.28-ehci
> working/2.6.27       working/2.6.28rc7
> root@beagleboard:/media/mmcblk0p1# cp working/2.6.28-=20
> eroot@beagleboard:/media/mmcblk0p1# cp working/2.6.28-ehci
> uI=08=08root@beagleboard:/media/mmcblk0p1# cp working/2.6.28-ehci uIm=
age
> ;  sync ; rebootred new interface driver cdc_ether
> usbcore: registered new interface driver rndis_host
> usbcore: registered new interface driver zd1211rw
> usbcore: registered new interface driver rndis_wlan
> usbcore: registered new interface driver zd1201
> usbcore: registered new interface driver usb8xxx
> usbcore: registered new interface driver rtl8187
> usbcore: registered new interface driver rt2500usb
> usbcore: registered new interface driver rt73usb
> usbcore: registered new interface driver p54usb
> i2c /dev entries driver
> input: triton2-pwrbutton as /class/input/input0
> triton2 power button driver initialized
> Driver 'sd' needs updating - please use bus_type methods
> Driver 'sr' needs updating - please use bus_type methods
> omap2-nand driver initializing
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
> 1,8V 16-bit)
> cmdlinepart partition parsing not available
> Creating 5 MTD partitions on "omap2-nand":
> 0x00000000-0x00080000 : "X-Loader"
> 0x00080000-0x00260000 : "U-Boot"
> 0x00260000-0x00280000 : "U-Boot Env"
> 0x00280000-0x00680000 : "Kernel"
> 0x00680000-0x10000000 : "File System"
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
> ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> input: gpio-keys as /class/input/input1
> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> Bluetooth: HCI USB driver ver 2.10
> usbcore: registered new interface driver hci_usb
> Bluetooth: Broadcom Blutonium firmware driver ver 1.2
> usbcore: registered new interface driver bcm203x
> Bluetooth: Digianswer Bluetooth USB driver ver 0.10
> usbcore: registered new interface driver bpa10x
> Bluetooth: Generic Bluetooth SDIO driver ver 0.1
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> Registered led device: beagleboard::usr0
> Registered led device: beagleboard::usr1
> leds-gpio: probe of leds-gpio failed with error -22
> usbcore: registered new interface driver usbhid
> usbhid: v2.6:USB HID core driver
> Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
> usbcore: registered new interface driver snd-usb-audio
> ASoC version 0.13.2
> OMAP3 Beagle SoC init
> TWL4030 Audio Codec init
> asoc: twl4030 <-> omap-mcbsp-dai-(link_id) mapping ok
> ALSA device list:
>   #0: omap3beagle (twl4030)
> oprofile: using arm/armv7
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Bluetooth: L2CAP ver 2.11
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO (Voice Link) ver 0.6
> Bluetooth: SCO socket layer initialized
> usb 1-2: new high speed USB device using ehci-omap and address 2
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.10
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> ieee80211: 802.11 data/management/control stack, git-1.1.13
> ieee80211: Copyright (C) 2004-2005 Intel Corporation
> <jketreno@linux.intel.com=20
>>
> ieee80211_crypt: registered algorithm 'NULL'
> ieee80211_crypt: registered algorithm 'WEP'
> ieee80211_crypt: registered algorithm 'CCMP'
> ieee80211_crypt: registered algorithm 'TKIP'
> ThumbEE CPU extension supported.
> Power Management for TI OMAP3.
> SmartReflex driver initialized
> Disabling unused clock "sr2_fck"
> Disabling unused clock "sr1_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt3_ick"
> Disabling unused clock "gpt4_ick"
> Disabling unused clock "gpt5_ick"
> Disabling unused clock "gpt6_ick"
> Disabling unused clock "gpt7_ick"
> Disabling unused clock "gpt8_ick"
> Disabling unused clock "gpt9_ick"
> Disabling unused clock "wdt3_ick"
> Disabling unused clock "wdt3_fck"
> Disabling unused clock "gpio2_dbck"
> Disabling unused clock "gpio3_dbck"
> Disabling unused clock "gpio4_dbck"
> Disabling unused clock "gpio5_dbck"
> Disabling unused clock "gpio6_dbck"
> Disabling unused clock "gpt9_fck"
> Disabling unused clock "gpt8_fck"
> Disabling unused clock "gpt7_fck"
> Disabling unused clock "gpt6_fck"
> Disabling unused clock "gpt5_fck"
> Disabling unused clock "gpt4_fck"
> Disabling unused clock "gpt3_fck"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "gpt1_ick"
> Disabling unused clock "wdt1_ick"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "gpio1_dbck"
> Disabling unused clock "gpt1_fck"
> Disabling unused clock "cam_ick"
> Disabling unused clock "cam_mclk"
> Disabling unused clock "des1_ick"
> Disabling unused clock "sha11_ick"
> Disabling unused clock "rng_ick"
> Disabling unused clock "aes1_ick"
> Disabling unused clock "ssi_ick"
> Disabling unused clock "mailboxes_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt10_ick"
> Disabling unused clock "gpt11_ick"
> Disabling unused clock "i2c_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "hdq_ick"
> Disabling unused clock "mspro_ick"
> Disabling unused clock "des2_ick"
> Disabling unused clock "sha12_ick"
> Disabling unused clock "aes2_ick"
> Disabling unused clock "icr_ick"
> Disabling unused clock "pka_ick"
> Disabling unused clock "ssi_ssr_fck"
> Disabling unused clock "hdq_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "i2c_fck"
> Disabling unused clock "mspro_fck"
> Disabling unused clock "gpt11_fck"
> Disabling unused clock "gpt10_fck"
> Disabling unused clock "iva2_ck"
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m5x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 1
> OMAPFB: omapfb_init
> OMAPFB: omapfb_probe
> OMAPFB: create 3 framebuffers
> OMAPFB: fb_infos allocated
> param '4M'
> param '4M'
> OMAPFB: allocating 4194304 bytes for fb 0
> OMAPFB: allocated VRAM paddr 80750000, vaddr d1000000
> OMAPFB: allocating 4194304 bytes for fb 1
> OMAPFB: allocated VRAM paddr 80b50000, vaddr d1400000
> OMAPFB: region0 phys 80750000 virt d1000000 size=3D4194304
> OMAPFB: region1 phys 80b50000 virt d1400000 size=3D4194304
> OMAPFB: region2 phys 00000000 virt 00000000 size=3D0
> OMAPFB: fbmems allocated
> OMAPFB: check_fb_var 0
> OMAPFB: xres =3D 640, yres =3D 480, vxres =3D 640, vyres =3D 480
> OMAPFB: set_fb_fix
> OMAPFB: check_fb_var 1
> OMAPFB: xres =3D 640, yres =3D 480, vxres =3D 640, vyres =3D 480
> OMAPFB: set_fb_fix
> OMAPFB: check_fb_var 2
> OMAPFB: set_fb_fix
> OMAPFB: fb_infos initialized
> OMAPFB: set_par(0)
> OMAPFB: set_fb_fix
> OMAPFB: apply_changes, fb 0, ovl 0
> OMAPFB: setup_overlay 0
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_enable_plane 0, 0
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DSS: save context
> OMAPFB: pan_display(0)
> OMAPFB: setcmap
> OMAPFB: setcmap
> Console: switching to colour frame buffer device 80x30
> OMAPFB: pan_display(0)
> OMAPFB: setcmap
> OMAPFB: setcmap
> OMAPFB: framebuffers registered
> OMAPFB: apply_changes, fb 0, ovl 0
> OMAPFB: setup_overlay 0
> OMAPFB: apply_changes, fb 1, ovl 1
> OMAPFB: setup_overlay 1
> OMAPFB: apply_changes, fb 2, ovl 2
> OMAPFB: create_framebuffers done
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_setup_plane 0, 80750000, sw 640, 0,0, 640x480 -=
>
> 640x480, (ilace 0)
> omap-dss DISPC: dispc_enable_plane 0, 1
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DSS: save context
> omap-dss DISPLAY: omap_dss_mgr_apply(tv)
> omap-dss DSS: save context
> omap-dss DISPLAY: omap_dss_mgr_apply_l4(l4)
> OMAPFB: mgr->apply'ed
> omap-dss DSI: PLL init
> omap-dss DISPC: dpll4_m4 =3D 432000000
> omap-dss DISPC: fck =3D 96000000 (9)
> omap-dss DISPC: lck =3D 96000000 (1)
> omap-dss DISPC: pck =3D 48000000 (2)
> clock: new_div =3D 9, new_rate =3D 48000000
> omap-dss DSI: PLL init done
> omap-dss DISPC: fifo(0) size 1024, low/high old 960/1023, new 256/960
> omap-dss DISPC: fifo(1) size 1024, low/high old 960/1023, new 256/960
> omap-dss DISPC: fifo(2) size 1024, low/high old 960/1023, new 256/960
> omap-dss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 0 ivs 0 acbi 0 acb 0
> omap-dss DSI: dsi_pll_calc
> omap-dss DSI: dsi_pll_program
> omap-dss DSI: DSI Fint 1857142
> omap-dss DSI: clkin (dss2_fck) rate 13000000, highfreq 0
> omap-dss DSI: DSIPHY =3D 2 * 329 / 7 * 13000000 / 1 =3D 1222000000
> omap-dss DSI: Data rate on 1 DSI lane 611 Mbps
> omap-dss DSI: Clock lane freq 305500000 Hz
> omap-dss DSI: regm3 =3D 13, dsi1_pll_fclk =3D 94000000
> omap-dss DSI: regm4 =3D 16, dsi2_pll_fclk =3D 76375000
> omap-dss DSI: PLL config done
> omap-dss DISPC: xres 640 yres 480
> omap-dss DISPC: pck 23500
> omap-dss DISPC: hsw 32 hfp 48 hbp 80 vsw 4 vfp 3 vbp 7
> omap-dss DISPC: hsync 29375Hz, vsync 59Hz
> OMAPFB: display->updated
> DISPC IRQ: 0x4024: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4024
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4000
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4000
> DISPC IRQ: 0x4022: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4022
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4000
> DISPC IRQ: 0x4022: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4022
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4000
> DISPC IRQ: 0x4022: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4022
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4000
> DISPC IRQ: 0x4002: SYNC_LOST
> omap-dss DISPC error: dispc irq error status 4002
> DISPC IRQ: 0x4020: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> OMAPFB: sysfs created
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4022: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: Excessive DISPC errors
> Turning off lcd and digit
> DISPC IRQ: 0x4022: SYNC_LOST
> omap-dss DISPC error: Excessive DISPC errors
> Turning off lcd and digit
> DISPC IRQ: 0x4000: SYNC_LOST
> omap-dss DISPC error: Excessive DISPC errors
> Turning off lcd and digit
> DISPC IRQ: 0x4003: SYNC_LOST
> omap-dss DISPC error: Excessive DISPC errors
> Turning off lcd and digit
> usb 1-2: configuration #1 chosen from 1 choice
> twl4030_rtc twl4030_rtc: setting system clock to 2009-01-13 21:11:13
> UTC (1231881073)
> hub 1-2:1.0: USB hub found
> hub 1-2:1.0: 4 ports detected
> mmc0: new SDHC card at address 8fe4
> mmcblk0: mmc0:8fe4 SD08G 7.40 GiB
>  mmcblk0: p1 p2 p3
> EXT3-fs warning: maximal mount count reached, running e2fsck is
> recommended
> EXT3 FS on mmcblk0p2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem).
> Freeing init memory: 188K
>
> If you have read till down here: still no cpufreq while the board fil=
e
> has the rate tables and the initcall:
>
> --- /tmp/board-omap3beagle.c	2009-01-12 15:46:26.000000000 +0100
> +++ git/arch/arm/mach-omap2/board-omap3beagle.c	2009-01-12
> 15:46:28.000000000 +0100
> @@ -41,14 +41,73 @@
>  #include <mach/usb-ehci.h>
>  #include <mach/common.h>
>  #include <mach/gpmc.h>
> +#include <mach/omap-pm.h>
>  #include <mach/nand.h>
>  #include <mach/mux.h>
>  #include <mach/omapfb.h>
>  #include <mach/display.h>
> +#include <mach/clock.h>
> +
>
>  #include "twl4030-generic-scripts.h"
>  #include "mmc-twl4030.h"
> +#include "pm.h"
> +
> +/* MPU speeds */
> +#define S600M   600000000
> +#define S550M   550000000
> +#define S500M   500000000
> +#define S250M   250000000
> +#define S125M   125000000
> +
> +/* DSP speeds */
> +#define S430M   430000000
> +#define S400M   400000000
> +#define S360M   360000000
> +#define S180M   180000000
> +#define S90M    90000000
> +
> +/* L3 speeds */
> +#define S83M    83000000
> +#define S166M   166000000
> +
> +static struct omap_opp mpu_rate_table[] =3D {
> +	{0, 0, 0},
> +	/*OPP1*/
> +	{S125M, VDD1_OPP1, 0x18},
> +	/*OPP2*/
> +	{S250M, VDD1_OPP2, 0x20},
> +	/*OPP3*/
> +	{S500M, VDD1_OPP3, 0x30},
> +	/*OPP4*/
> +	{S550M, VDD1_OPP4, 0x36},
> +	/*OPP5*/
> +	{S600M, VDD1_OPP5, 0x3C},
> +};
>
> +static struct omap_opp l3_rate_table[] =3D {
> +	{0, 0, 0},
> +	/*OPP1*/
> +	{0, VDD2_OPP1, 0x18},
> +	/*OPP2*/
> +	{S83M, VDD2_OPP2, 0x20},
> +	/*OPP3*/
> +	{S166M, VDD2_OPP3, 0x2C},
> +};
> +
> +struct omap_opp dsp_rate_table[] =3D {
> +	{0, 0, 0},
> +	/*OPP1*/
> +	{S90M, VDD1_OPP1, 0x18},
> +	/*OPP2*/
> +	{S180M, VDD1_OPP2, 0x20},
> +	/*OPP3*/
> +	{S360M, VDD1_OPP3, 0x30},
> +	/*OPP4*/
> +	{S400M, VDD1_OPP4, 0x36},
> +	/*OPP5*/
> +	{S430M, VDD1_OPP5, 0x3C},
> +};
>
>  #define GPMC_CS0_BASE  0x60
>  #define GPMC_CS_SIZE   0x30
>
> @@ -227,7 +294,8 @@
>
>  static void __init omap3_beagle_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, mpu_rate_table,
> +						 dsp_rate_table, l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
>
>
> regards,
>
> Koen

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.g=
it;a=3Dcommit;h=3D818862e11bad091dc635baedace58265a126b5c8
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
