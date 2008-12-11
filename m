From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 13:54:41 -0800
Message-ID: <5e088bd90812111354w7633e2a3p1365ab35d43277b9@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
	 <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
	 <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
	 <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
	 <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:44430 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958AbYLKVyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:54:43 -0500
Received: by an-out-0708.google.com with SMTP id d40so565617and.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 13:54:42 -0800 (PST)
In-Reply-To: <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@booyaka.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Dec 11, 2008 at 12:41 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Thu, Dec 11, 2008 at 7:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
>> On Thu, Dec 11, 2008 at 8:49 AM, Paul Walmsley <paul@booyaka.com> wrote:
>>> Hi Grazvydas, Steve,
>>>
>>> On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:
>>>
>>>> > Can you please post whatever patches you need to apply to make it work
>>>> > occasionally so others can also look at the issue?
>>>>
>>>> For pandora, making infinite while loops finite doesn't help much,
>>>> kernel crashes later on. Steve had this too:
>>>> http://marc.info/?l=linux-omap&m=122378604027303&w=2
>>>>
>>>> I did bisect and found that commit
>>>> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
>>>> Reverting this makes EHCI work again on pandora.
>>>> http://marc.info/?l=linux-omap&m=122453174024860&w=2
>>>
>>> Would one of you be willing to run with this patch and send back any debug
>>> output relating to dpll5_ck ?  (Unfortunately, I don't have access to any
>>> boards with EHCI hardware, so cannot try it myself)
>>>
>>> This will help determine what fix should be applied
>>
>> Here you go.  Note that no infinite loop!
>
> Ah, so it no longer needs that revert, probably recent clock changes
> fixed that issue.
>
>> ...
>> Result: no hang at boot, but I still end up with the auto suspend,
>> though the behavior is slightly different (dmesg output this time
>> since it contains more debug info):
>
> If your host uses PHY mode, have you hacked EXT_PHY_RESET_GPIO* in
> drivers/usb/host/ehci-omap.c? BTW, if this stuff is really needed, it
> should go to platform_data..

I have hacked in the reset GPIO used on Overo.  I agree -- board
specific stuff has no place in ehci-omap, it really should be platform
data.

Sadly my ehci port still goes into auto suspend.  I've attached the
output of dmesg.  Can you take a look and see at what point my ehci
messages diverge from what you see?

Steve

root@overo:~# dmesg
76..383
twl4030: gpio (irq 368) chaining IRQs 384..401
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, pio, host, debug=0
musb_hdrc: ConfigData=0x55 (UTMI-16, dyn FIFOs, bulk split (X), HB-ISO Rx (X))
musb_hdrc: MHDRC RTL version 1.400
musb_hdrc: setup fifo_mode 4
musb_hdrc: 29/31 max ep, 15424/16384 memory
musb_hdrc: hw_ep 0shared, max 64
musb_hdrc: hw_ep 1tx, max 512
musb_hdrc: hw_ep 1rx, max 512
musb_hdrc: hw_ep 2tx, max 512
musb_hdrc: hw_ep 2rx, max 512
musb_hdrc: hw_ep 3tx, max 512
musb_hdrc: hw_ep 3rx, max 512
musb_hdrc: hw_ep 4tx, max 512
musb_hdrc: hw_ep 4rx, max 512
musb_hdrc: hw_ep 5tx, max 512
musb_hdrc: hw_ep 5rx, max 512
musb_hdrc: hw_ep 6tx, max 512
musb_hdrc: hw_ep 6rx, max 512
musb_hdrc: hw_ep 7tx, max 512
musb_hdrc: hw_ep 7rx, max 512
musb_hdrc: hw_ep 8tx, max 512
musb_hdrc: hw_ep 8rx, max 512
musb_hdrc: hw_ep 9tx, max 512
musb_hdrc: hw_ep 9rx, max 512
musb_hdrc: hw_ep 10tx, max 512
musb_hdrc: hw_ep 10rx, max 512
musb_hdrc: hw_ep 11tx, max 512
musb_hdrc: hw_ep 11rx, max 512
musb_hdrc: hw_ep 12tx, max 512
musb_hdrc: hw_ep 12rx, max 512
musb_hdrc: hw_ep 13tx, max 512
musb_hdrc: hw_ep 13rx, max 512
musb_hdrc: hw_ep 14shared, max 1024
musb_hdrc: hw_ep 15shared, max 1024
musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 10ms
hub 1-0:1.0: 100mA bus power budget for each child
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.28-rc7-omap1 musb-hcd
usb usb1: SerialNumber: musb_hdrc
Bluetooth: Core ver 2.13
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
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
msgmni has been set to 497
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: using mode 1024x768@60
omapfb: configured for panel overo
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 128x48
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
omapfb: Framebuffer initialized. Total vram 6291456 planes 2
omapfb: Pixclock 54000 kHz hfreq 45.6081 kHz vfreq 57.7 Hz
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
i2c /dev entries driver
input: triton2-pwrbutton as /class/input/input0
triton2 power button driver initialized
Driver 'sd' needs updating - please use bus_type methods
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
1,8V 16-bit)
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
cmdlinepart partition parsing not available
Creating 5 MTD partitions on "omap2-nand":
0x00000000-0x00080000 : "xloader"
0x00080000-0x00240000 : "uboot"
0x00240000-0x00280000 : "uboot environment"
0x00280000-0x00680000 : "linux"
0x00680000-0x10000000 : "rootfs"
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd: block sizes: qh 128 qtd 96 itd 160 sitd 96
ehci-omap ehci-omap.0: ehci_hcd_omap_drv_probe()
ehci-omap ehci-omap.0: starting TI EHCI USB Controller
clock: dpll5_ck: clk->rate = 120000000, hdwr rate = 120000000, parent
rate = 13000000
ehci-omap ehci-omap.0: TLL RESET DONE
ehci-omap ehci-omap.0: Entered ULPI PHY MODE: success
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 2
ehci-omap ehci-omap.0: park 0
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: reset command 090b02 park=3 ithresh=9
period=1024 Reset HALT
ehci-omap ehci-omap.0: init command 010009 (park)=0 ithresh=1 period=256 RUN
usb 1-1: new high speed USB device using musb_hdrc and address 2
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb2: default language 0x0409
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: individual port power switching
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 20ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.28-rc7-omap1 ehci_hcd
usb usb2: SerialNumber: ehci-omap.0
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
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
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
usb 1-1: uevent
usb 1-1: usb_probe_device
usb 1-1: configuration #1 chosen from 1 choice
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: uevent
hub 1-1:1.0: usb_probe_interface
hub 1-1:1.0: usb_probe_interface - got id
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
hub 1-1:1.0: standalone hub
hub 1-1:1.0: individual port power switching
hub 1-1:1.0: individual port over-current protection
hub 1-1:1.0: Single TT
hub 1-1:1.0: TT requires at most 16 FS bit times (1332 ns)
hub 1-1:1.0: Port indicators are supported
hub 1-1:1.0: power on to power good time: 100ms
hub 1-1:1.0: local power source is good
hub 1-1:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '002'
usb 1-1: New USB device found, idVendor=0409, idProduct=005a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
hub 1-0:1.0: port 1 enable change, status 00000503
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
hub 1-1:1.0: port 4: status 0101 change 0001
usbcore: registered new interface driver snd-usb-audio
ASoC version 0.13.2
overo SoC init
TWL4030 Audio Codec init
asoc: twl4030 <-> omap-mcbsp-dai-(link_id) mapping ok
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
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
ThumbEE CPU extension supported.
Power Management for TI OMAP3.
hub 1-1:1.0: state 7 ports 4 chg 0010 evt 0000
hub 1-1:1.0: port 4, status 0101, change 0000, 12 Mb/s
SmartReflex driver initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
twl4030_rtc twl4030_rtc: setting system clock to 2008-12-11 21:41:45
UTC (1229031705)
Waiting for root device /dev/mmcblk0p2...
usb 1-1.4: new full speed USB device using musb_hdrc and address 3
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address ee21
mmcblk0: mmc0:ee21 SU02G 1.89 GiB
 mmcblk0: p1 p2
usb 1-1.4: ep0 maxpacket = 8
usb 1-1.4: uevent
usb 1-1.4: usb_probe_device
usb 1-1.4: configuration #1 chosen from 1 choice
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: uevent
hub 1-1.4:1.0: usb_probe_interface
hub 1-1.4:1.0: usb_probe_interface - got id
hub 1-1.4:1.0: USB hub found
hub 1-1.4:1.0: 4 ports detected
hub 1-1.4:1.0: standalone hub
hub 1-1.4:1.0: individual port power switching
hub 1-1.4:1.0: individual port over-current protection
hub 1-1.4:1.0: power on to power good time: 100ms
hub 1-1.4:1.0: local power source is good
hub 1-1.4:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '003'
usb 1-1.4: New USB device found, idVendor=0557, idProduct=7000
usb 1-1.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
mmc1: new SDIO card at address 0001
hub 1-1.4:1.0: port 1: status 0301 change 0001
hub 1-1.4:1.0: state 7 ports 4 chg 0002 evt 0000
hub 1-1.4:1.0: port 1, status 0301, change 0000, 1.5 Mb/s
usb 1-1.4.1: new low speed USB device using musb_hdrc and address 4
usb 1-1.4.1: skipped 1 descriptor after interface
usb 1-1.4.1: skipped 1 descriptor after interface
usb 1-1.4.1: skipped 1 descriptor after interface
usb 1-1.4.1: default language 0x0409
usb 1-1.4.1: uevent
usb 1-1.4.1: usb_probe_device
usb 1-1.4.1: configuration #1 chosen from 1 choice
usb 1-1.4.1: adding 1-1.4.1:1.0 (config #1, interface 0)
usb 1-1.4.1:1.0: uevent
usbhid 1-1.4.1:1.0: usb_probe_interface
usbhid 1-1.4.1:1.0: usb_probe_interface - got id
input: BTC USB Multimedia Cordless Kit as /class/input/input1
generic-usb 0003:046E:5520.0001: input: USB HID v1.10 Keyboard [BTC
USB Multimedia Cordless Kit] on usb-musb_hdrc-1.4.1/input0
usb 1-1.4.1: adding 1-1.4.1:1.1 (config #1, interface 1)
usb 1-1.4.1:1.1: uevent
usbhid 1-1.4.1:1.1: usb_probe_interface
usbhid 1-1.4.1:1.1: usb_probe_interface - got id
generic-usb 0003:046E:5520.0002: claimed by neither input, hiddev nor hidraw
usb 1-1.4.1: adding 1-1.4.1:1.2 (config #1, interface 2)
usb 1-1.4.1:1.2: uevent
usbhid 1-1.4.1:1.2: usb_probe_interface
usbhid 1-1.4.1:1.2: usb_probe_interface - got id
generic-usb 0003:046E:5520.0003: claimed by neither input, hiddev nor hidraw
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: recovery complete.
drivers/usb/core/inode.c: creating file '004'
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing init memory: 920K
usb 1-1.4.1: New USB device found, idVendor=046e, idProduct=5520
usb 1-1.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.4.1: Product: USB Multimedia Cordless Kit
usb 1-1.4.1: Manufacturer: BTC
udevd version 124 started
usb usb2: uevent
usb 2-0:1.0: uevent
usb usb1: uevent
usb 1-0:1.0: uevent
usb 1-1: uevent
usb 1-1.4: uevent
usb 1-1.4.1: uevent
usb 1-1.4.1:1.0: uevent
usb 1-1.4.1:1.1: uevent
usb 1-1.4.1:1.2: uevent
usb 1-1.4:1.0: uevent
usb 1-1:1.0: uevent
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub
end_request: I/O error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 8
Buffer I/O error on device mtdblock0, logical block 1
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 16
Buffer I/O error on device mtdblock0, logical block 2
end_request: I/O error, dev mtdblock0, sector 24
Buffer I/O error on device mtdblock0, logical block 3
end_request: I/O error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
NET: Registered protocol family 10
libertas: 00:19:88:05:96:ca, fw 9.70.3p24, cap 0x00000303
ADDRCONF(NETDEV_UP): eth0: link is not ready
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: eth0: Marvell WLAN 802.11 adapter
usb usb2: usb auto-resume
ehci-omap ehci-omap.0: resume root hub
hub 2-0:1.0: hub_resume
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub
