From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: booting new image
Date: Fri, 22 Sep 2006 01:08:45 -0300
Message-ID: <ae36f8040609212108t1af9f0d5qc82f6eb5d717f546@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi people,
After 2 days working with openembedded, thanks to Philip Balister and his
help in this 2 days, i have an image without warning or error on blocks of
erasure size etc.
But the system isn't bootin yet isn't opening the console.

this is my console loging:

OMAP5912 OSK # boot
## Booting image at 00040000 ...
   Image Name:   Linux-2.6.18-rc7-omap1-gf16bdc72
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1321708 Bytes =3D  1.3 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing
Linux......................................................................=
.................
done, booting the kernel.
Linux version 2.6.18-rc7-omap1-gf16bdc72-dirty (lvcargnini@enterprise) (gcc
version 4.0.0 (DENX ELDK 4.0 4.0.0)) #2 Fri Sep 22 00:02:25 BRT 2006
CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=3D00053177
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writeback
OMAP162123 revision 2 handled as 16xx id: e105940859901e19
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists.  Total pages: 8192
Kernel command line: console=3DttyS0,115200n8 noinitrd rw rootfstype=3Djffs=
2
root=3D/dev/mtdblock3 mem=3D32M
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.0
MUX: initialized M7_1610_GPIO62
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 29616KB available (2201K code, 477K data, 116K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
omap_dsp_init() done
USB: hmc 16, usb0 2 wires
i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
tps65010: version 2 May 2005
No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)
MUX: initialized N14_1610_UWIRE_CS0
MUX: initialized P15_1610_UWIRE_CS3
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
OMAP DSP driver initialization
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
eth0: Ethernet addr: 00:0e:99:02:0d:32
i2c /dev entries driver
Clock enabled to MCBSP1 & 3
TLV320AIC23 I2C version 1.8 (10-Feb-2006)
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
MUX: initialized W11_1610_CF_CD1
MUX: initialized P11_1610_CF_CD2
MUX: initialized R11_1610_CF_IOIS16
MUX: initialized V10_1610_CF_IREQ
MUX: initialized W10_1610_CF_RESET
omap_cf: cs2 on irq 222
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
audio support initialized
ALSA device list:
  #0: OSK AIC23
TCP bic registered
NET: Registered protocol family 1
Disabling unused clock "usb_dc_ck"...  done
FIXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"...  done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspper_ck"
OMAP GPIO switch handler initializing
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 116K

my u-boot env:

OMAP5912 OSK # printenv
baudrate=3D115200
etheraddr=3D00:0e:99:02:0d:32
ethaddr=3D00:0E:99:02:0D:32
bootdelay=3D4
bootfile=3DuImage
bootargs=3Dconsole=3DttyS0,115200n8 noinitrd rw rootfstype=3Djffs2
root=3D/dev/mtdblock3 mem=3D32M
filesize=3D142b2c
fileaddr=3D10000000
netmask=3D255.255.255.0
ipaddr=3D192.168.1.1
serverip=3D192.168.1.6
bootcmd=3Dbootm 0x00040000
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial


someone knows what is faulting to the system finally boots and open the
console ???
What i have missing ?
I'm asking here because I'm interrupting a lot Balister and he had to finis=
h
his papers, so any help is always welcome.


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
