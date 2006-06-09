From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [patch] Fix to allow H4 to boot and ethernet to work on
	2.6.17-rc5 git.
Date: Thu, 8 Jun 2006 19:01:33 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506198F9A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Here is an NFS boot log (Irda disabled in build & VFP turned on).

----------
U-Boot 1.1.3 (Feb 27 2006 - 12:26:39)

U-Boot code: 80E80000 -> 80E9C658  BSS: -> 80EA1424
OMAP2420-GP revision 5, PRCM III
TI H4 SDP Base Board + Menelaus Daughter Board + mDDR
RAM Configuration:
Bank #0: 80000000 32 MB
Bank #1: 82000000 32 MB
Flash: 64 MB
In:    serial
Out:   serial
Err:   serial
OMAP242x H4 # setenv bootargs $(ml)
OMAP242x H4 # dhcp 80300000 4x/uImage-git
Using MAC Address 00:50:C2:35:B3:1B
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
DHCP client bound to address 128.247.77.144
TFTP from server 128.247.77.43; our IP address is 128.247.77.144
Filename '4x/uImage-git'.
Load address: 0x80300000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
         ##########################################################
done
Bytes transferred =3D 1292455 (13b8a7 hex)
OMAP242x H4 # bootm
## Booting image at 80300000 ...
   Image Name:   2420 2.6.16
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1292391 Bytes =3D  1.2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

<5>Linux version 2.6.17-rc5-omap1-g46c0c428-dirty
(a0384864@dta0384864.sc.ti.com
) (gcc version 3.4.0 20040409 (CodeSourcery ARM Q1A 2004)) #9 Thu Jun 8
18:57:47
 CDT 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 8192
<7>  DMA zone: 8192 pages, LIFO batch:1
<6>OMAP24205
<6>SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0xa0000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
<5>Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/nfs rw
=20
nfsroot=3D128.247.77.43:/home/a0384864/wtbu/rootfs/mobilinux,rsize=3D1024=
,ws
ize=3D102
4,nolock ip=3Ddhcp
<6>Clocking rate (Crystal/DPLL/MPU): 12.0/532/266 MHz
<3>clock.c: Enable for dpll_ck without enable code
<6>IRQ: Found an INTC at 0x480fe000 (revision 2.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP24xx GPIO hardware version 1.8
Muxing M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
PID hash table entries: 256 (order: 8, 1024 bytes)
<6>OMAP2 GP timer (HW version 1.3)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>Memory: 32MB =3D 32MB total
<5>Memory: 29672KB available (2132K code, 502K data, 108K init)
<7>Calibrating delay loop... 265.42 BogoMIPS (lpj=3D1327104)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>NET: Registered protocol family 16
Muxing K15_24XX_UART3_TX (0x48000118): 0x00 -> 0x00
Muxing K14_24XX_UART3_RX (0x48000119): 0x00 -> 0x00
Muxing M19_24XX_I2C1_SCL (0x48000111): 0x00 -> 0x00
Muxing L15_24XX_I2C1_SDA (0x48000112): 0x00 -> 0x00
Muxing T19_24XX_KBR0 (0x48000106): 0x0f -> 0x1b
Muxing R19_24XX_KBR1 (0x48000107): 0x0f -> 0x1b
Muxing V18_24XX_KBR2 (0x48000139): 0x07 -> 0x1b
Muxing M21_24XX_KBR3 (0x480000c9): 0x0f -> 0x1b
Muxing E5__24XX_KBR4 (0x48000138): 0x0f -> 0x1b
Muxing B3__24XX_KBR5 (0x48000030): 0x03 -> 0x1b
Muxing AA4_24XX_KBC2 (0x480000e7): 0x03 -> 0x03
Muxing B13_24XX_KBC6 (0x48000110): 0x03 -> 0x03
Muxing R20_24XX_KBC0 (0x48000108): 0x0f -> 0x03
Muxing M14_24XX_KBC1 (0x48000109): 0x1f -> 0x03
Muxing V17_24XX_KBC3 (0x48000135): 0x07 -> 0x03
Muxing P21_24XX_KBC4 (0x480000ca): 0x0f -> 0x03
Muxing L14_24XX_KBC5 (0x4800010f): 0x0f -> 0x03
<6>OMAP DMA hardware revision 2.0
Initializing OMAP McBSP system
Muxing Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
Muxing R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
Muxing W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
Muxing V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
Muxing V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
Muxing W14_24XX_SYS_CLKOUT (0x48000137): 0x0f -> 0x18
<3>omapdsp: unsupported omap architecture.
<3>USB: No board-specific platform config found
<6>i2c_omap i2c_omap.1: bus 0 rev3.4 at 100 kHz
<6>NET: Registered protocol family 23
<6>NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
<6>TCP: Hash tables configured (established 1024 bind 512)
<6>TCP reno registered
<4>NetWinder Floating Point Emulator V0.97 (double precision)
<5>VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>omapfb: configured for panel h4
<6>omapfb-dispc: version 2.0
Console: switching to colour frame buffer device 30x40
<6>omapfb: initialized vram=3D159744 pixclock 5541 kHz hfreq 16.9 kHz
vfreq 51.9 H
z
<6>OMAP Watchdog Timer: initial timeout 60 sec
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
Linux version 2.6.17-rc5-omap1-g46c0c428-dirty
(a0384864@dta0384864.sc.ti.com) (
gcc version 3.4.0 20040409 (CodeSourcery ARM Q1A 2004)) #9 Thu Jun 8
18:57:47 CD
T 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
OMAP24205
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0xa0000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/nfs rw nf
sroot=3D128.247.77.43:/home/a0384864/wtbu/rootfs/mobilinux,rsize=3D1024,w=
siz
e=3D1024,n
olock ip=3Ddhcp
Clocking rate (Crystal/DPLL/MPU): 12.0/532/266 MHz
clock.c: Enable for dpll_ck without enable code
IRQ: Found an INTC at 0x480fe000 (revision 2.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP24xx GPIO hardware version 1.8
Muxing M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
PID hash table entries: 256 (order: 8, 1024 bytes)
OMAP2 GP timer (HW version 1.3)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 29672KB available (2132K code, 502K data, 108K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Muxing K15_24XX_UART3_TX (0x48000118): 0x00 -> 0x00
Muxing K14_24XX_UART3_RX (0x48000119): 0x00 -> 0x00
Muxing M19_24XX_I2C1_SCL (0x48000111): 0x00 -> 0x00
Muxing L15_24XX_I2C1_SDA (0x48000112): 0x00 -> 0x00
Muxing T19_24XX_KBR0 (0x48000106): 0x0f -> 0x1b
Muxing R19_24XX_KBR1 (0x48000107): 0x0f -> 0x1b
Muxing V18_24XX_KBR2 (0x48000139): 0x07 -> 0x1b
Muxing M21_24XX_KBR3 (0x480000c9): 0x0f -> 0x1b
Muxing E5__24XX_KBR4 (0x48000138): 0x0f -> 0x1b
Muxing B3__24XX_KBR5 (0x48000030): 0x03 -> 0x1b
Muxing AA4_24XX_KBC2 (0x480000e7): 0x03 -> 0x03
Muxing B13_24XX_KBC6 (0x48000110): 0x03 -> 0x03
Muxing R20_24XX_KBC0 (0x48000108): 0x0f -> 0x03
Muxing M14_24XX_KBC1 (0x48000109): 0x1f -> 0x03
Muxing V17_24XX_KBC3 (0x48000135): 0x07 -> 0x03
Muxing P21_24XX_KBC4 (0x480000ca): 0x0f -> 0x03
Muxing L14_24XX_KBC5 (0x4800010f): 0x0f -> 0x03
OMAP DMA hardware revision 2.0
Initializing OMAP McBSP system
Muxing Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
Muxing R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
Muxing W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
Muxing V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
Muxing V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
Muxing W14_24XX_SYS_CLKOUT (0x48000137): 0x0f -> 0x18
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
i2c_omap i2c_omap.1: bus 0 rev3.4 at 100 kHz
NET: Registered protocol family 23
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel h4
omapfb-dispc: version 2.0
Console: switching to colour frame buffer device 30x40
omapfb: initialized vram=3D159744 pixclock 5541 kHz hfreq 16.9 kHz vfreq
51.9 Hz
OMAP Watchdog Timer: initial timeout 60 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
<6>serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
<6>loop: loaded (max 8 devices)
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2800300 IRQ 252eth0: SMC91C94 (rev 9) at
c2800300 IRQ
 252 [nowait]
 [nowait]
eth0: Ethernet addr: eth0: Ethernet addr:
00:00:50:50:c2:c2:35:35:b3:b3:1b
1b
<7>eth0: No PHY found
<6>OMAP IrDA driver initializing
OMAP IrDA driver initializing
Muxing W19_24XX_SYS_NIRQ (0x4800012c): 0x00 -> 0x18
Muxing W19_24XX_SYS_NIRQ (0x4800012c): 0x00 -> 0x18
<6>Menelaus rev 2.0
Menelaus rev 2.0
<6>OMAP Keypad Driver
OMAP Keypad Driver
<6>input: omap-keypad as /class/input/input0
input: omap-keypad as /class/input/input0
<6>TCP bic registered
TCP bic registered
<6>NET: Registered protocol family 1
NET: Registered protocol family 1
<6>NET: Registered protocol family 17
NET: Registered protocol family 17
<6>NET: Registered protocol family 15
NET: Registered protocol family 15
<6>IrCOMM protocol (Dag Brattli)
IrCOMM protocol (Dag Brattli)
<6>VFP support v0.3: VFP support v0.3: implementor 41 architecture 1
part 20 var
iant b rev 2
implementor 41 architecture 1 part 20 variant b rev 2
<6>eth0: link up
eth0: link up
<5>Sending DHCP requests .Sending DHCP requests .,, OK
 OK
IP-Config: Got DHCP answer from 255.255.255.255, IP-Config: Got DHCP
answer from
 255.255.255.255, my address is 128.247.77.144
my address is 128.247.77.144
IP-Config: Complete:IP-Config: Complete:
      device=3Deth0
      device=3Deth0, addr=3D128.247.77.144, addr=3D128.247.77.144,
mask=3D255.255.254.0,
 mask=3D255.255.254.0, gw=3D128.247.76.1, gw=3D128.247.76.1,
     host=3D128.247.77.144, domain=3Dsc.ti.com, nis-domain=3D(none),
     host=3D128.247.77.144, domain=3Dsc.ti.com, nis-domain=3D(none),
     bootserver=3D255.255.255.255,
     bootserver=3D255.255.255.255, rootserver=3D128.247.77.43,
rootserver=3D128.247.77
.43, rootpath=3D, rootpath=3D

<5>Looking up port of RPC 100003/2 on 128.247.77.43
Looking up port of RPC 100003/2 on 128.247.77.43
<5>Looking up port of RPC 100005/1 on 128.247.77.43
Looking up port of RPC 100005/1 on 128.247.77.43
VFS: Mounted root (nfs filesystem).
VFS: Mounted root (nfs filesystem).
<6>Freeing init memory: 108K
Freeing init memory: 108K
INIT: version 2.85 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Activating swap...done.
Remounting root filesystem...done.
Calculating module dependencies
WARNING: Couldn't open directory
/lib/modules/2.6.17-rc5-omap1-g46c0c428-dirty:
No such file or directory
FATAL: Could not open
/lib/modules/2.6.17-rc5-omap1-g46c0c428-dirty/modules.dep.
temp for writing: No such file or directory
Loading modules:
Checking all file systems: fsck
fsck 1.35 (28-Feb-2004)
Mounting local filesystems: mount nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Starting network interfaces: done.
Starting hotplug subsystem:
   pci
   pci      [success]
   usb
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
   input    [success]
   scsi
   scsi     [success]
done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run done.
Updating /etc/motd...done.
INIT: Entering runlevel: 3
Starting NFS common utilities: statd lockdlockdsvc: Function not
implemented
 failed (1: ).
Starting internet superserver: inetd.

128.247.77.144 login: root
Last login: Thu Jan  1 00:01:23 1970 on console
Linux 128.247.77.144 2.6.17-rc5-omap1-g46c0c428-dirty #9 Thu Jun 8
18:57:47 CDT
2006 armv6l GNU/Linux

root@128.247.77.144:~# uname -a
Linux 128.247.77.144 2.6.17-rc5-omap1-g46c0c428-dirty #9 Thu Jun 8
18:57:47 CDT
2006 armv6l GNU/Linux
root@128.247.77.144:~#

> -----Original Message-----
> From: Woodruff, Richard
> Sent: Thursday, June 08, 2006 6:36 PM
> To: linux-omap-open-source@linux.omap.com
> Cc: 'Tony Lindgren'
> Subject: [patch] Fix to allow H4 to boot and ethernet to work on
2.6.17-
> rc5 git.
>=20
> Hi,
>=20
> In case anyone is trying to actually use the H4-2420 this patch allows
it
> to boot on a pull from today.  I needed to test a few things and I see
> it's likely not worked for a bit.
>=20
> - The GPMC settings in the board file were wrong, especially the MUX
> settings, there is no way Ethernet would have worked with those.  The
> change to the board file is likely worth keeping.
>=20
> - I put ugly hacks into MMC and Irda which likely are not worth
keeping
> but they do allow a boot.
>=20
> - I noticed the 2422 and 2423 is_cpu_xyz macros are broke but did not
fix
> them.  You need to read both Hawkeye and production_id to distinguish
> current parts.
>=20
> Now on to some testing of other things ...
>=20
> Regards,
> Richard W.
