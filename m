From: "Mihail Georgiev" <georgiev@students.cc.tut.fi>
Subject: Re: omap 1510 touchscreen druver on linux 2.6.x
Date: Thu, 15 Dec 2005 16:23:36 +0200
Message-ID: <op.s1twxm1wtqqdru@tsunami.it.tut.fi>
References: <EA12F909C0431D458B9D18A176BEE4A5036C1618@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5036C1618@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "G Kondaiah, Manjunath" <xgkondai@ti.com>, Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thank YOu Kondaiah..
this is good suggest, but booting kernel now surprises me with
Warning:unable to open initial console
and hangs..
the samoe kernel without touchscreen driver is working perfectly....
and on the same place i have received message:
serial console detected. Disabling vortual terminals...

(I am using my omap through serial console and NFS)

On Thu, 15 Dec 2005 14:45:08 +0200, G Kondaiah, Manjunath =20
<xgkondai@ti.com> wrote:

> You should disable Touch screen interface in the make menuconfig(under =
=20
> Input Device Support) and make sure OMAP touchscreen input driver is =20
> enabled as shown below.
>
>
>                          < > Touchscreen =20
> interface                                                           =E2=
=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                               [*] =20
> Touchscreens                                                           =
         =20
> =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                               < >   Gunze AHL-51S=
 touchscreen =20
> (NEW)                                               =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                               <*>   OMAP touchscr=
een input =20
> driver                                                 =E2=94=82 =E2=94=
=82
> I guess this will solve will your problem.
>
> Regards,
> Manjunath
>
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =20
> Mihail Georgiev
> Sent: Thursday, December 15, 2005 4:57 AM
> To: Komal Shah; linux-omap-open-source@linux.omap.com
> Subject: Re: omap 1510 touchscreen druver on linux 2.6.x
>
> It just not continue to boot after the last line...
> without touchscreen input driver everything is ok when booting
>
>
>
>
>
>
>     Image Name:   Linux Kernel
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    3335072 Bytes =3D  3.2 MB
>     Load Address: 10008000
>     Entry Point:  10008000
>     Verifying Checksum ... OK
> OK
>
> Starting kernel ...
>
> Linux version 2.6.10-omap1 (georgiev@hopearilli.cs.tut.fi) (gcc version
> 3.3.2) 5
> CPU: ARM925Tid(wt) [54029252] revision 2 (ARMv4T)
> CPU: D VIVT write-back cache
> CPU: I cache: 16384 bytes, associativity 2, 16 byte lines, 512 sets
> CPU: D cache: 8192 bytes, associativity 2, 16 byte lines, 256 sets
> Machine: TI-Innovator
> Memory policy: ECC disabled, Data cache writethrough
> OMAP_DIE_ID_0: 0xf2850514
> OMAP_DIE_ID_1: 0xd158c8a8 DIE_REV: 12
> OMAP_PRODUCTION_ID_0: 0x00000000
> OMAP_PRODUCTION_ID_1: 0x00000000 JTAG_ID: 0x0000
> OMAP32_ID_0: 0x03310115
> OMAP32_ID_1: 0x3b47002f
> JTAG_ID: 0xb470 DIE_REV: 12
> OMAP1510 revision 12 handled as 15xx id: d158c8a8f2850514
> Innovator FPGA Rev 2.1 Board Rev 16
> MUX: initialized UART1_TX
> MUX: initialized UART1_RTS
> MUX: initialized UART2_TX
> MUX: initialized UART2_RTS
> MUX: initialized UART3_TX
> Built 1 zonelists
> Kernel command line: console=3DttyS0,115200n8 noinitrd root=3D/dev/nfs =
=20
> ip=3Dbootp
> Total of 64 interrupts in 2 interrupt banks
> OMAP1510 GPIO hardware
> PID hash table entries: 256 (order: 8, 4096 bytes)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 32MB =3D 32MB total
> Memory: 28944KB available (2779K code, 508K data, 124K init)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> NET: Registered protocol family 16
> DMA support for OMAP1510 initialized
> Initializing OMAP McBSP system
> MUX: initialized USB1_TXD
> MUX: initialized USB1_SE0
> MUX: initialized USB1_SPEED
> MUX: initialized USB2_TXD
> MUX: initialized USB2_TXEN
> MUX: initialized USB2_SE0
> MUX: initialized USB2_RCV
> MUX: initialized USB2_VM
> USB: hmc 4, usb0 2 wires, usb1 6 wires, usb2 6 wires
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> Power Management for TI OMAP.
> NetWinder Floating Point Emulator V0.97 (double precision)
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: devfs_debug: 0x0
> devfs: boot_options: 0x1
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> omapfb: configured for panel inn1510
> OMAP LCD controller initialized.
> Console: switching to colour frame buffer device 30x40
> OMAP framebuffer initialized vram=3D262144
> omap-rtc: RTC power up reset detected.
> omap-rtc: Enabling RTC.
> Real Time Clock Driver v1.0
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabl=
ed
> ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
> ttyS1 at MMIO 0xfffb0800 (irq =3D 47) is a ST16654
> ttyS2 at MMIO 0xfffb9800 (irq =3D 15) is a ST16654
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> PPP BSD Compression module registered
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> eth0: SMC91C94 (rev 9) at 0xc2800300 IRQ 381 [nowait]
> eth0: Ethernet addr: 00:0b:36:00:07:be
> Linux video capture interface: v1.00
> ovcamchip: v2.27 for Linux 2.6 : OV camera chip I2C driver
> st: Version 20041025, fixed bufsize 32768, s/g segs 256
> clock.c: Enable for usb_ck without enable code
> ohci ohci: at 0xfefba000, irq 38
> ohci ohci: new USB bus registered, assigned bus number 1
> usb usb1: Product: OMAP OHCI
> usb usb1: Manufacturer: Linux 2.6.10-omap1 ohci_hcd
> usb usb1: SerialNumber: ohci
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2
> (2004/08/27)
> usbcore: registered new driver rtl8150
> usbcore: registered new driver usbnet
> mice: PS/2 mouse device common for all mice
> ts: Compaq touchscreen protocol output
>
>
>
>
>
>
>
>
>
>
> On Thu, 15 Dec 2005 12:38:28 +0200, Komal Shah
> <komal_shah802003@yahoo.com> wrote:
>
>> --- Mihail Georgiev <georgiev@students.cc.tut.fi> wrote:
>>
>>> Hello,
>>> Is there somebody who knows how to install touchscreen driver on Omap
>>> Inno
>>> 1510..
>>> I have patched the kernel with patch from muru.com
>>> in menuconfig
>>> I checked touchscreen in -->input device
>>> support-->touchscreens-->Omap
>>> touchscreen input driver...
>>> but when I boot the system after installing
>>> my system hangs when booting the kernel..
>>> Is there some other options in kernel menuconfig
>>> to start linux flawlessly...
>>
>> At what point it hangs? Could you please post the kernel boot log?
>>
>>
>> ---Komal Shah
>> http://komalshah.blogspot.com/
>>
>> __________________________________________________
>> Do You Yahoo!?
>> Tired of spam?  Yahoo! Mail has the best spam protection around
>> http://mail.yahoo.com
>
>
>



--=20
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
