From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: 2430 minimal support patch (fix for ether nfs boot, ++)
Date: Mon, 12 Jun 2006 15:43:58 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506200D41@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C68E60.EE4A0216"
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68E60.EE4A0216
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I took your patch and took an hour and tweaked it a little bit so that
Ethernet and NFS work.  Here are a couple comments on making it work.

- the mux_config base address is so your OMAP24XX_CTRL_BASE is wrong. It
is at a different offset than 2420.
	- at any rate the pin muxing and balls don't match up so any mux
settings are wrong. There should be 242x and 243x defines.
	- mcbsp had an init call which needed to be defined off.

- Ether board chip select base was set wrongly, its CS5 not CS1.  You
were creating a conflicting map.

- Ether interrupt polarity was wrong, it needs to be LEVEL_LOW.

- The patch didn't apply right off as there was a simple mismatch with
the current clock code.  A couple bug fixes should be brought it.

- All and all the register access method patch is pretty simple.  Still
doesn't seem necessary, but it is not so intrusive.

- I just applied this against the tree I have here which I tried on 2420
a few days back, so there are a couple of other differences but I doubt
any of them are strictly required.

With the modified patch I could boot from OneNAND on my 2430 up to a
shell with NFS (OMAP=3D330/L3=3D165MHz).  Hopefully, with NFS going =
things
will get a bit easier.  I've attached a boot log below on the sdp2430.

Regards,
Richard W.

-------------------
Texas Instruments X-Loader 1.40
Detected Samsung MuxOneNAND1G Flash
Starting OS Bootloader...


U-Boot 1.1.3 (May 10 2006 - 10:53:52)

U-Boot code: 80E80000 -> 80EA22F0  BSS: -> 80EA8494
OMAP2430C-GP revision 1, PRCM #2
TI 2430SDP 0.1 Version + mDDR (Boot ONND)
RAM Configuration:
Bank #0: 80000000 128 MB
Bank #1: 88000000  0 kB
Flash: 192 MB
Muxed OneNAND 128MB 1.8V 16-bit (0x30)
Scanning device for bad blocks
num of blocks =3D 2048
Bad eraseblock 169 at 0x01520000
Bad eraseblock 876 at 0x06d80000
In:    serial
Out:   serial
Err:   serial
OMAP243X SDP # dhcp 80300000 8x/uImage-git

*** Warning: ethaddr is not set properly, ignoring!!
Using MAC Address 08:00:28:01:01:2D
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
DHCP client bound to address 128.247.77.90
TFTP from server 128.247.77.43; our IP address is 128.247.77.90
Filename '8x/uImage-git'.
Load address: 0x80300000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
         ###########################
done
Bytes transferred =3D 1133901 (114d4d hex)
OMAP243X SDP # bootm
## Booting image at 80300000 ...
   Image Name:   2430 2.6.17
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1133837 Bytes =3D  1.1 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.17-rc5-omap1 (a0384864@dta0384864.sc.ti.com) (gcc
version 3.4.
0 20040409 (CodeSourcery ARM Q1A 2004)) #1 Mon Jun 12 14:49:08 CDT 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2430 sdp2430 board
Memory policy: ECC disabled, Data cache writeback
OMAP2430
SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
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
OMAP PRCM hardware version 1.0
Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
clock.c: Enable for dpll_ck without enable code
IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP24xx GPIO hardware version 2.2
PID hash table entries: 256 (order: 8, 1024 bytes)
OMAP2 GP timer (HW version 1.6)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 29992KB available (1880K code, 454K data, 92K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
OMAP DMA hardware revision 3.0
Initializing OMAP McBSP system
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
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
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2800300 IRQ 309 [nowait]
eth0: Ethernet addr: 08:00:28:01:01:2d
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00040000 : "bootloader"
0x00040000-0x00060000 : "params"
0x00060000-0x00260000 : "kernel"
0x00260000-0x04000000 : "filesystem"
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 255.255.255.255, my address is
128.247.77.90
IP-Config: Complete:
      device=3Deth0, addr=3D128.247.77.90, mask=3D255.255.254.0,
gw=3D128.247.76.1,
     host=3D128.247.77.90, domain=3Dsc.ti.com, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D128.247.77.43, =
rootpath=3D
Looking up port of RPC 100003/2 on 128.247.77.43
Looking up port of RPC 100005/1 on 128.247.77.43
VFS: Mounted root (nfs filesystem).
Freeing init memory: 92K
INIT: version 2.85 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Activating swap...done.
Remounting root filesystem...done.
Calculating module dependencies
WARNING: Couldn't open directory /lib/modules/2.6.17-rc5-omap1: No such
file or
directory
FATAL: Could not open /lib/modules/2.6.17-rc5-omap1/modules.dep.temp for
writing
: No such file or directory
Loading modules:
Checking all file systems: fsck
fsck 1.35 (28-Feb-2004)
/etc/init.d/rcS: line 57:   291 Segmentation fault      ( trap - INT
QUIT TSTP;
set start; . $i )
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
/etc/init.d/rcS: line 57:   370 Segmentation fault      ( trap - INT
QUIT TSTP;
set start; . $i )
INIT: Entering runlevel: 3  3
Starting NFS common utilities: statd lockdlockdsvc: Function not
implemented
 failed (1: ).
Starting internet superserver: inetd.
Starting MontaVista target tools daemon: mvltdmvltd version 2.1
MontaVista Softw
are,Inc.
mvltd[398]: started on port 34577
.
Mobilinux(TM) 4.0

128.247.77.90 login: root
Last login: Thu Jan  1 00:00:31 1970 on console
Linux 128.247.77.90 2.6.10_mobilinux410 #2 Fri Jun 9 19:07:17 CDT 2006
armv6l GN
U/Linux

Mobilinux(TM) 4.0

root@128.247.77.90:~# uname -a
Linux 128.247.77.90 2.6.17-rc5-omap1 #1 Mon Jun 12 14:49:08 CDT 2006
armv6l GNU/
Linux
root@128.247.77.90:~# cat /proc/interrupts
           CPU0
 12:          0   DMA
 38:       3772   gp timer
 72:        218   serial
309:      13406   eth0
Err:          0
root@128.247.77.90:~# cat /proc/cpuinfo
Processor       : Some Random V6 Processor rev 2 (v6l)
BogoMIPS        : 329.31
Features        : swp half thumb fastmult vfp edsp java
CPU implementer : 0x41
CPU architecture: 6TEJ
CPU variant     : 0x0
CPU part        : 0xb36
CPU revision    : 2
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format C
Cache format    : Harvard
I size          : 32768
I assoc         : 4
I line length   : 32
I sets          : 256
D size          : 32768
D assoc         : 4
D line length   : 32
D sets          : 256

Hardware        : OMAP2430 sdp2430 board
Revision        : 24300024
Serial          : 0000000000000000
root@128.247.77.90:~#

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Komal Shah
> Sent: Monday, June 12, 2006 11:25 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH] ARM: OMAP: Add minimal OMAP2430 support V2
>=20
> Tony/Juha/Richard,
>=20
> Attached patch is re-worked with PRCM and SDRC changes
> to prcm/sdrc_read/write_reg fashion. I have tested it on OMAP2420
> H4 EVM. I still need to test it on SDP2430.
>=20
> - Moved prcm.c to clock.c.
>=20
> Please review.
>=20
> ---
> [PATCH] ARM: OMAP: Add Minimal OMAP2430 support and
> added read/write_reg functions for PRCM and SDRC.
>=20
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
>=20
> --
> http://www.fastmail.fm - Email service worth paying for. Try it for
free


------_=_NextPart_001_01C68E60.EE4A0216
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C68E60.EE4A0216--
