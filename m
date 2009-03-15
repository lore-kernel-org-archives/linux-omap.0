From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 20:56:12 -0700
Message-ID: <5e088bd90903142056j5a4acedbw13810efe94c3560a@mail.gmail.com>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com>
	 <200903141208.30413.david-b@pacbell.net>
	 <5e088bd90903141647s2faee448s6472f6b7bb9e0ba4@mail.gmail.com>
	 <200903141900.08727.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:20780 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153AbZCOD4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 23:56:15 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1247751wfa.4
        for <linux-omap@vger.kernel.org>; Sat, 14 Mar 2009 20:56:13 -0700 (PDT)
In-Reply-To: <200903141900.08727.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, linux-omap <linux-omap@vger.kernel.org>

On Sat, Mar 14, 2009 at 7:00 PM, David Brownell <david-b@pacbell.net> w=
rote:

>> I don't get the warning now, but mmc0 is still broken (boot log belo=
w)
>
> Works for me, and I think you've got all the patches that
> should matter. =A0 This is against today's GIT, yes?
> Does taking #3 away help?

Yes, this is against today's top of tree
(a504a838e680d623745d3ad9cee1405ddbc4cbf9).

I've rebuilt without patch 3 -- same result (boot log attached below).
 Is there any chance I might be missing some new kconfig option?  I
didn't notice any patches changing defconfig.

>> OMAP3430 ES2.1
>
> I hear ES3.1 will have better-working EHCI. =A0;)

I get the crufty old protos to work with :-)

>> sdhci: Secure Digital Host Controller Interface driver
>> sdhci: Copyright(c) Pierre Ossman
>
> Why do you have SDHCI configured??

Damn good question!  I have no idea when that snuck in there!  It is
removed in the new build.

> Which slot reports that mmc_rescan() thing though? =A0I take
> it that's your diagnostic. =A0More important ... why are you
> only getting one such message? =A0I hope you really *do* have
> an uSD card in that slot. =A0;)

Yes, there is a uSD card in the slot :-)  U-boot and uImage are
loading from the card so I know it is there!

That is my diagnostic left over from trying to track down the SDIO
issue.  Why we only see one message is a good question.  I would also
expect to see two.

> Try sticking diagnostics where it's checking whether there
> is a card in the slot. =A0And then where it turns on the
> regulator for mmc0 ... I'm thinking the latter doesn't seem
> to be happening,

OK, will get another build going with those diagnostics.

>> Waiting for root device /dev/mmcblk0p2...
>> mmc1: new SDIO card at address 0001
>>
> At that point I get:
>
> Waiting for root device /dev/mmcblk0p2...
> mmc0: host does not support reading read-only switch. assuming write-=
enable.
> mmc0: new high speed SD card at address 3395
> mmcblk0: mmc0:3395 SD02G 1.83 GiB
> =A0mmcblk0: p1 p2
> mmc1: voltage mask 100000 (orig ff8000, use 100000)
> usb 2-1: new high speed USB device using musb_hdrc and address 2
> mmc1: new SDIO card at address 0001
> libertas_sdio mmc1:0001:1: firmware: using built-in firmware sd8686_h=
elper.bin
> libertas_sdio mmc1:0001:1: firmware: using built-in firmware sd8686.b=
in

That is what I used to see too.

Thanks for helping me track this down!

Steve


Linux version 2.6.29-rc8-omap1 (sakoman@tera) (gcc version 4.3.1 (GCC)
) #1 Sat Mar 14 20:36:14 PDT 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Gumstix Overo
omapfb_early_vram, 12582912, 0x0
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES2.1
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Reserving 12582912 bytes SDRAM for VRAM
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65=
024
Kernel command line: console=3DttyS2,115200n8 vram=3D12M
omapfb.mode=3Ddvi:1024x768MR-16@60 omapfb.debug=3Dy omapdss.def_disp=3D=
dvi
root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait
Clocking rate (Crystal/DPLL/ARM core): 26.0/331/500 MHz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 1024 (order: 10, 4096 bytes)
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB =3D 256MB total
Memory: 241408KB available (4460K code, 531K data, 936K init)
Calibrating delay loop... 499.92 BogoMIPS (lpj=3D1949696)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 764 bytes
regulator: core version 0.5
NET: Registered protocol family 16
=46ound NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
OMAP DSS rev 2.0
OMAP DISPC rev 3.0
OMAP VENC rev 2
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
set_machine_constraints: disable 'VMMC1' --> 0
regulator: VMMC1: 1850 <--> 3150 mV normal standby
set_machine_constraints: disable 'VUSB1V5' --> 0
regulator: VUSB1V5: 1500 <--> 0 mV normal standby
set_machine_constraints: disable 'VUSB1V8' --> 0
regulator: VUSB1V8: 1800 <--> 0 mV normal standby
set_machine_constraints: disable 'VUSB3V1' --> 0
regulator: VUSB3V1: 3100 <--> 0 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Bluetooth: Core ver 2.14
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: US
	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
cfg80211: Calling CRDA for country: US
musb_hdrc: version 6.0, musb-dma, host, debug=3D0
musb_hdrc: USB Host mode controller at d80ab000 using DMA, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.29-rc8-omap1 musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 471
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
i2c /dev entries driver
Driver 'sd' needs updating - please use bus_type methods
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
1,8V 16-bit)
cmdlinepart partition parsing not available
Creating 5 MTD partitions on "omap2-nand":
0x000000000000-0x000000080000 : "xloader"
0x000000080000-0x000000240000 : "uboot"
0x000000240000-0x000000280000 : "uboot environment"
0x000000280000-0x000000680000 : "linux"
0x000000680000-0x000010000000 : "rootfs"
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 2
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.29-rc8-omap1 ehci_hcd
usb usb2: SerialNumber: ehci-omap.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
mice: PS/2 mouse device common for all mice
twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: Broadcom Blutonium firmware driver ver 1.2
usbcore: registered new interface driver bcm203x
Bluetooth: Digianswer Bluetooth USB driver ver 0.10
usbcore: registered new interface driver bpa10x
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc_aux
mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc
mmc_rescan: card ocr from io_op=3D0x90ff8000, err =3D 0
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.18a.
usbcore: registered new interface driver snd-usb-audio
No device for DAI twl4030
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
overo SoC init
TWL4030 Audio Codec init
asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
ALSA device list:
  #0: overo (twl4030)
oprofile: using arm/armv7
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Bluetooth: L2CAP ver 2.11
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.10
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ThumbEE CPU extension supported.
Power Management for TI OMAP3.
SmartReflex driver initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
fbcvt: 1024x768@60: CVT Name - .786M3-R
Console: switching to colour frame buffer device 128x48
clock: clksel_round_rate_div: dpll4_m4_ck target_rate 86400000
clock: new_div =3D 5, new_rate =3D 86400000
twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:12:36
UTC (946685556)
Waiting for root device /dev/mmcblk0p2...
mmc1: new SDIO card at address 0001
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
