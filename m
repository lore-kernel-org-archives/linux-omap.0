From: Bob Liu <lliubbo@gmail.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update to kernel-2.6.37
Date: Thu, 20 Jan 2011 13:32:24 +0800
Message-ID: <AANLkTimByz+gc8X9uaVfUUGU+V9V-Og2U9xZQhca7P5b@mail.gmail.com>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
	<20110119110607.GA30211@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61790 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab1ATFcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 00:32:25 -0500
Received: by qwa26 with SMTP id 26so227660qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 21:32:24 -0800 (PST)
In-Reply-To: <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

On Wed, Jan 19, 2011 at 7:06 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
>> Any ideas?
>
> s/console=ttyS2,115200n8/console=ttyO2,115200n8/
>
> on your CMDLINE.
>

Yeah, that work! Thanks!

But my system still can't enter shell, I have changed /etc/inittab
from "tty0::respawn:/sbin/getty -L ttyS2 115200 vt102" to
"tty0::respawn:/sbin/getty -L ttyO2 115200 vt102", and also have added
ttyO2 to /etc/securetty.

Thanks.

The detail log is below:
===============
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3630 ES1.1 (l2cache iva sgx neon isp 192mhz_clk )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyO2,115200n8 mpurate=800 vram=12M
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 489120k/489120k available, 35168k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc1a61000   (26980 kB)
      .text : 0xc1a61000 - 0xc1d9e260   (3317 kB)
      .data : 0xc1da0000 - 0xc1dd4660   ( 210 kB)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 484.21 BogoMIPS (lpj=1892352)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
regulator: dummy:
NET: Registered protocol family 16
OMAP3 Beagle Rev: xM
Found NAND on CS0
Registering NAND on CS0
Unable to get DVI reset GPIO
Switched to new clocking rate (Crystal/Core/MPU): 26.0/800/332 MHz
OMAP DMA hardware revision 5.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev4.0 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VDVI: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev4.0 at 100 kHz
Switching to clocksource 32k_counter
musb_hdrc: version 6.0, musb-dma, host, debug=0
musb_hdrc musb_hdrc: incompatible Kconfig role setting
musb_hdrc: probe of musb_hdrc failed with error -22
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 955
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
omap-hsuart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
console [ttyO2] enabled
omap-hsuart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
brd: module loaded
loop: module loaded
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.37-ADI-2011R1-pre-g02d75de-dirty ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usbcore: registered new interface driver cdc_acm
cdc_acm: v0.26:USB Abstract Control Model driver for USB modems and
ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Registering the dns_resolver key type
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
mmc0: mmc_rescan: trying to init card at 400000 Hz
Power Management for TI OMAP3.
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
Freeing init memory: 26980K
Initializing random number generator... done.
Starting network...
hub 1-0:1.0: unable to enumerate USB device on port 2
hub 1-0:1.0: unable to enumerate USB device on port 2
hub 1-0:1.0: unable to enumerate USB device on port 2
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 1234
mmcblk0: mmc0:1234 SA02G 1.83 GiB
 mmcblk0: p1
=========================
Can't enter shell...

-- 
Regards,
--Bob
