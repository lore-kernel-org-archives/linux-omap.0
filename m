From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: omap alsa tsc2101 driver
Date: Tue, 07 Feb 2006 14:43:58 +0200
Message-ID: <43E8960E.6090005@cc.jyu.fi>
References: <43E66CF6.8040600@cc.jyu.fi>	
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>	
	<43E7AEC3.3020901@cc.jyu.fi>
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>Yes, I am sending it right now (I have just updated my tree). Please
>note that it is really work in progress code, with remaining debug
>printks and so on. I will clean up soon.
>Try to make it work w/ your device, you will have to change the board*
>file accordingly H2 or osk in this patch.
>  
>
Yes, I made the changes. I kind of liked from the idea to codec
aic/tsc2101 specific
functions in the board, but the side-effect is that I was not able to
build the driver anymore
as a module. (I got unresolved function errors in the end of build). But
when selecting to
build the driver in to image, it compiled just fine.

>Let me know if you can play sounds with this patch so that I will
>prepare it to receive your mixer then you can debug it
>  
>
But unfortunately your version seemed to work in a similar way for me
than my one,--> I was able to hear only the beginning of song. The only
code difference for our h6300 board compared to h2/osk is the mcbsp
settings and they could be wrong.
But could they be wrong when with the OSS driver "cat song.wav >
/dev/dsp" works just fine with the same mcbsp settings...

Following questions comes to my mind:
Are you able to play all kind of wav/mp3 songs with your driver by using
aplay?
Any changes you could also test the playback with my driver version, it
could help me to identify the problem
if I know/not know whether that version works with h2 or osk.

I have found at least one difference in my and your driver versions is
that in set_samplerate function
you do not change all mcbsp registers by calling omap_mcbsp_config().
Instead you will only update
srgr1 and srgr2 by calling

    OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR2, srgr2);
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR1, srgr1);

Below is the debug from my attempt with your driver...

Mika

root@h6300:~# aplay 01_the_grudge.mp3
Playing raw data '01_the_grudge.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
root@h6300:~# dmesg
=417792)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
Freeing initrd memory: 2048K
NET: Registered protocol family 16
MUX: initialized UART3_TX
MUX: initialized UART3_RX
MUX: initialized F18_1610_KBC0
MUX: initialized D20_1610_KBC1
MUX: initialized D19_1610_KBC2
MUX: initialized E18_1610_KBC3
MUX: initialized C21_1610_KBC4
MUX: initialized G18_1610_KBR0
MUX: initialized F19_1610_KBR1
MUX: initialized H14_1610_KBR2
MUX: initialized E20_1610_KBR3
MUX: initialized E19_1610_KBR4
MUX: initialized N19_1610_KBR5
DMA support for OMAP15xx initialized
Initializing OMAP McBSP system
USB: hmc 0
MUX: initialized N14_1510_UWIRE_CS0
MUX: initialized P15_1510_UWIRE_CS3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Power Management for TI OMAP.
NetWinder Floating Point Emulator V0.97 (extended precision)
OMAP DSP driver initialization
omapdsp: mapping in ARM MMU, v=0xe0fff000, p=0x10ab4000, sz=0x1000
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Allocated 270656 bytes for deflate workspace
Allocated 46912 bytes for inflate workspace
Registering JFFS2 compressor "zlib"
Compressor "zlib", prio 60
Registering JFFS2 compressor "rtime"
Compressor "zlib", prio 60
Compressor "rtime", prio 50
Registering JFFS2 compressor "rubinmips"
Compressor "zlib", prio 60
Compressor "rtime", prio 50
Compressor "rubinmips", prio 10
Registering JFFS2 compressor "dynrubin"
Compressor "zlib", prio 60
Compressor "rtime", prio 50
Compressor "dynrubin", prio 20
Compressor "rubinmips", prio 10
JFFS2: default compression mode: priority
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel h6300
lcd_h6300.c: h6300_panel_init() done
omapfb-lcdc: init
lcd_h6300.c: h6300_panel_enable() done
Console: switching to colour frame buffer device 60x53
omapfb: initialized vram=153600 pixclock 21000 kHz hfreq 77.8 kHz vfreq
229.7 HzOMAP RTC Driver
omap_rtc: RTC already running.
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 47) is a ST16654
serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 15) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
STRIP: Version 1.3A-STUART.CHESHIRE (unlimited channels)
usbmon: debugfs is not available
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (OMAP)
ohci_hcd: block sizes: ed 64 td 64
usbcore: registered new driver cdc_acm
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/class/cdc-acm.c:
v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new driver asix
usbcore: registered new driver cdc_ether
usbcore: registered new driver net1080
usbcore: registered new driver zaurus
usbcore: registered new driver usbserial
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial Driver core
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial support registered for PocketPC PDA
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/ipaq.c:
USB PocketPC PDA driver v0.5
usbcore: registered new driver ipaq
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial support registered for Handspring Visor / Palm OS
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial support registered for Sony Clie 3.5
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/usb-serial.c:
USB Serial support registered for Sony Clie 5.0
usbcore: registered new driver visor
/home/lamikr/own/h6300/eclipsewk/h6300_dev/drivers/usb/serial/visor.c:
USB HandSpring Visor / Palm OS driver
udc: OMAP UDC driver, version: 4 October 2004 (iso)
udc: OMAP UDC rev 2.7
udc: hmc mode 0, (unknown) transceiver
udc: fifo mode 3, 648 bytes not used
usb0: Ethernet Gadget, version: May Day 2005
usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
usb0: MAC b2:e5:68:a6:39:c9
usb0: HOST MAC b2:58:90:b3:b8:66
ts: Compaq touchscreen protocol output
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
WR: ad:0x5 data:0x0
WR: ad:0x3 data:0xc010
udc: USB reset done, gadget ether
WR: ad:0x3 data:0xc010
WR: ad:0x1d data:0x0
WR: ad:0x2 data:0x0
WR: ad:0x20 data:0x75d1
usb0: full speed config #1: 100 mA, Ethernet Gadget, using CDC Ethernet
WR: ad:0x21 data:0xf0
WR: ad:0x22 data:0x0
WR: ad:0x1 data:0x1900
WR: ad:0x1e data:0x1900
WR: ad:0x2 data:0x3e3e
WR: ad:0x0 data:0x4100
WR: ad:0x6 data:0x2904
WR: ad:0x1b data:0x811c
WR: ad:0x1c data:0x5240


 TESTE 2

OSK audio support initialized
ALSA device list:
  #0: OMAP OSK with AIC23
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
mmcblk0: mmc0:0001 SDR256 250816KiB
 mmcblk0: p1 p2
Bridge firewalling registered
IP-Config: Complete:
      device=usb0, addr=192.168.2.2, mask=255.0.0.0, gw=192.168.2.1,
     host=h6300, domain=, nis-domain=(none),
     bootserver=192.168.2.1, rootserver=192.168.2.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.2.1
Looking up port of RPC 100005/1 on 192.168.2.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 120K
usb0: no IPv6 routers present
MUX: initialized M14_1510_GPIO2
input: omap_ts as /class/input/input0
OMAP touchscreen driver initialized
i2c_omap i2c_omap.1: bus 0 rev1.0 at 100 kHz
pca9535_attach() started
pca9535_attach() ok
OMAP Keypad Driver
omap-keypad: Spurious key event 0-5
omap-keypad: Spurious key event 1-5
omap-keypad: Spurious key event 2-5
omap-keypad: Spurious key event 3-5
omap-keypad: Spurious key event 4-5
omap-keypad: Spurious key event 5-5
omap-keypad: Spurious key event 6-5
omap-keypad: Spurious key event 7-5
input: omap-keypad as /class/input/input1
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
h6300 Bluetooth Driver init()
h6300_bt_led.c h6300_clear_led() done
h6300_bt_brf6100.c h6300_bt_probe() done
NET: Registered protocol family 23
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
WR: ad:0x0 data:0x413f
WR: ad:0x6 data:0x804
WR: ad:0x1b data:0x8120
WR: ad:0x1c data:0x1e00
