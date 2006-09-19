From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Fwd: Problems loading ffs image
Date: Tue, 19 Sep 2006 16:21:33 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507B53C33@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-2?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> it=B6 a nand type i suppose. Is a OSK 5912 starter kit where I'm =
trying
> to boot my new system.

I don't think this is correct. The boot log shows its using the MTD-CFI =
driver which is used for NOR type flashes.  I don't know a NAND which =
uses that command format.

> My full boot message log on console screen:
> OMAP5912 OSK # boot
> Unknown command '0x00100000' - try 'help'
> ## Booting image at 10000000 ...

This error comes from the bit I pointed out below about a bad boot =
command.


I would guess your issue might be with what ever your JFFS image =
creation command was.  It will need to know your erase block size so it =
can in-line the clean markers and it will need to be told to do so.  You =
should be able to google the correct command, and you need to look up =
the flash part's data sheet for its attributes to feed into the command.

Regards,
Richard W.


>    Image Name:   Linux-2.6.18-rc7-omap1-gf16bdc72
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1321716 Bytes =3D  1.3 MB
>    Load Address: 10008000
>    Entry Point:  10008000
>    Verifying Checksum ... OK
> OK
>=20
> Starting kernel ...
>=20
> Uncompressing
> =
Linux....................................................................=
.
> ..................
> done, booting the kernel.
> Linux version 2.6.18-rc7-omap1-gf16bdc72 (lvcargnini@enterprise) (gcc
> version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Tue Sep 19 18:09:46 BRT 2006
> CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=3D00053177
> Machine: TI-OSK
> Memory policy: ECC disabled, Data cache writeback
> OMAP162123 revision 2 handled as 16xx id: 8605907dc1530214
> SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
> CPU0: D VIVT write-back cache
> CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
> CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
> Built 1 zonelists.  Total pages: 8192
> Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd rw =
ip=3Doff
> root=3D/dev/mtdblock3 rootfstype=3Djffs2
> Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
> Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
> Total of 128 interrupts in 4 interrupt banks
> OMAP GPIO hardware version 1.0
> MUX: initialized M7_1610_GPIO62
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Memory: 32MB =3D 32MB total
> Memory: 29616KB available (2201K code, 477K data, 116K init)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> NET: Registered protocol family 16
> OMAP DMA hardware version 1
> DMA capabilities: 000c0000:00000000:01ff:003f:007f
> Initializing OMAP McBSP system
> omap_dsp_init() done
> USB: hmc 16, usb0 2 wires
> i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
> tps65010: version 2 May 2005
> No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)
> MUX: initialized N14_1610_UWIRE_CS0
> MUX: initialized P15_1610_UWIRE_CS3
> NET: Registered protocol family 2
> IP route cache hash table entries: 256 (order: -2, 1024 bytes)
> TCP established hash table entries: 1024 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 1024 bind 512)
> TCP reno registered
> Power Management for TI OMAP.
> MUX: initialized T20_1610_LOW_PWR
> NetWinder Floating Point Emulator V0.97 (double precision)
> OMAP OCPI interconnect driver loaded
> OMAP DSP driver initialization
> JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
> serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> PPP generic driver version 2.4.2
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
> eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
> eth0: Ethernet addr: 00:0e:99:02:0a:4d
> i2c /dev entries driver
> Clock enabled to MCBSP1 & 3
> TLV320AIC23 I2C version 1.8 (10-Feb-2006)
> omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
> omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x0031
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> Creating 4 MTD partitions on "omapflash.0":
> 0x00000000-0x00020000 : "bootloader"
> 0x00020000-0x00040000 : "params"
> 0x00040000-0x00240000 : "kernel"
> 0x00240000-0x02000000 : "filesystem"
> MUX: initialized W11_1610_CF_CD1
> MUX: initialized P11_1610_CF_CD2
> MUX: initialized R11_1610_CF_IOIS16
> MUX: initialized V10_1610_CF_IREQ
> MUX: initialized W10_1610_CF_RESET
> omap_cf: cs2 on irq 222
> mice: PS/2 mouse device common for all mice
> OMAP Keypad Driver
> Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
> 13:55:50 2006 UTC).
> audio support initialized
> ALSA device list:
>   #0: OSK AIC23
> TCP bic registered
> NET: Registered protocol family 1
> Disabling unused clock "usb_dc_ck"...  done
> FIXME: Clock "tc2_ck" seems unused
> Disabling unused clock "tc1_ck"...  done
> Skipping reset check for DSP domain clock "dsptim_ck"
> Skipping reset check for DSP domain clock "dspper_ck"
> OMAP GPIO switch handler initializing
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x9d8d instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
> 0x0b59 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008:
> 0x4f8f instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
> 0xd159 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000010:
> 0xe226 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000014:
> 0x9318 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018:
> 0x030a instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
> 0xb702 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
> 0x7044 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024:
> 0x6d97 instead
> Further such events for this erase block will not be printed
> VFS: Mounted root (jffs2 filesystem).
> Freeing init memory: 116K
> Warning: unable to open an initial console.
> I'm using the mkfs.jffs2 of mtd-utils 1.00 as i said before.
> the command to create image is:
> mkfs.jffs2 -p -l -e 0x20000 -n -v -r ilfs/ -o instramed.jffs2
>=20
> On 9/19/06, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > You boot command doesn't look right...
> >         bootcmd=3D0x00100000 0x10000000 142b34;bootm
> >
> > What type of device is your root file system on NAND or NOR?  NAND =
and
> NOR JFFS2 images are created differently.  It used to be the clean =
markers
> were in-lined in a NOR image (you must specify this in image build).  =
NAND
> ones are kept in the NAND's OOB area and are not part of the basic =
image.
> >
> > Can you even read reasonable data in your flash device when the =
kernel
> is on the way up?  It could be as simple as your memory timings are =
wrong
> given your boot speed and they simply are read up incorrectly.
> >
> > Regards,
> > Richard W.
> >
> >
> >
>=20
>=20
>=20
> --
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
