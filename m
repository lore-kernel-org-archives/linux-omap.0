From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [BUG]: v2.6.31: always output black in beagle DVI LCD
Date: Sat, 19 Sep 2009 22:01:57 +0800
Message-ID: <d82e647a0909190701k11c96bb9ubd70b93d5484c9eb@mail.gmail.com>
References: <d82e647a0909180852u13dc1751pc1ae88413707706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:62797 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbZISOBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 10:01:54 -0400
In-Reply-To: <d82e647a0909180852u13dc1751pc1ae88413707706@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-embedded@vger.kernel.org

2009/9/18 Ming Lei <tom.leiming@gmail.com>:
> Board: beagle B5
> LCD: can show beagle logo in uboot
>
> Once I upgrade to v2.6.31 from
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 git://git.kernel.org/pub/scm/linux/kernel=
/git/tmlind/linux-omap-2.6.git
>
> and apply the patch:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omapfb: Reorder Register_framebuffe=
r call
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://marc.info/?l=3Dlinux-omap&m=3D=
125277326104621&w=3D2
>
> the dvi lcd can't show anything but black colour. And from view of th=
e monitor,
> there is video signal outputed from beagle, which can be indicated th=
e
> green-led of
> monitor.
>
> Also the fb device(/dev/fb0) can be accessed well by my test code.
>
> I can provide more information if anyone needs.

dmesg:

Linux version 2.6.31-omap1-05924-g3a3575e-dirty (lm@linux-lm) (gcc
version 4.2.1 (CodeSourcery S
ourcery G++ Lite 2007q3-51)) #80 Fri Sep 18 23:35:02 CST 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c03862c0, node_mem_map c03a2000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
OMAP3430 ES2.1
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32=
512
Kernel command line: console=3DttyS2,115200n8 root=3D/dev/mmcblk0p2 rw
rootdelay=3D5 omapfb.mode=3Ddvi:1
440x900MR-16@60
Unknown boot option `omapfb.mode=3Ddvi:1440x900MR-16@60': ignoring
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB =3D 128MB total
Memory: 126080KB available (3144K code, 296K data, 132K init, 0K highme=
m)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 316.17 BogoMIPS (lpj=3D1236992)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
=46ound NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
musb_hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk
split (X), HB-ISO Rx, HB-I
SO Tx, SoftConn)
musb_hdrc: MHDRC RTL version 1.400
musb_hdrc: setup fifo_mode 4
musb_hdrc: 28/31 max ep, 16384/16384 memory
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
musb_hdrc: hw_ep 10tx, max 256
musb_hdrc: hw_ep 10rx, max 64
musb_hdrc: hw_ep 11tx, max 256
musb_hdrc: hw_ep 11rx, max 64
musb_hdrc: hw_ep 12tx, max 256
musb_hdrc: hw_ep 12rx, max 64
musb_hdrc: hw_ep 13shared, max 4096
musb_hdrc: hw_ep 14shared, max 1024
musb_hdrc: hw_ep 15shared, max 1024
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
Switched to high resolution mode on CPU 0
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =E4=BE=A3=EF=BF=BD 2001-2006 Red Hat, Inc.
msgmni has been set to 246
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel omap3beagle
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 128x48
omapfb: Framebuffer initialized. Total vram 1572864 planes 1
omapfb: Pixclock 48000 kHz hfreq 44.7 kHz vfreq 57.7 Hz
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 36:4b:c8:25:70:04
usb0: HOST MAC e2:1d:b8:ec:4e:2a
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting 5sec before mounting root device...
mmc0: new SD card at address 0001
mmcblk0: mmc0:0001 064MB 118 MiB
 mmcblk0: p1 p2
g_ether gadget: high speed config #1: CDC Ethernet (ECM)
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recomme=
nded
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) on device 179:2.
=46reeing init memory: 132K



--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
