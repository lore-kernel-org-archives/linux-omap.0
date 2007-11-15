From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3430 and UART3 parent clocks
Date: Thu, 15 Nov 2007 14:02:48 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711151356390.32494@utopia.booyaka.com>
References: <1194982452.7433.55.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711140221470.3713@utopia.booyaka.com>
	<1195052848.15127.30.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-511648098-1195160568=:32494"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1195052848.15127.30.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: amit@verdurent.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-511648098-1195160568=:32494
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kevin,

On Wed, 14 Nov 2007, Kevin Hilman wrote:

> On Wed, 2007-11-14 at 02:24 -0700, Paul Walmsley wrote:
>
> > ... What bootloader are you using?
>=20
> u-boot from TI.  See the full console log attached for u-boot version
> and details, as well as the crash dump.

Thanks, that's very helpful.  Looks like we're running different=20
bootloaders.  I suspect that the bootloader here may be enabling UART3=20
itself, but need to investigate further.  I've included our bootlog=20
below for comparison.

> I also do not have ES2.0 silicon, in case that might matter.

Yep, ES1 here too.


- Paul


U-Boot 1.1.4 Flash: 64 MB
Muxed OneNAND 128MB 1.8V 16-bit (0x30)
Scanning device for bad blocks
num of blocks =3D 2048
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  3 =08=08=08 0=20
OMAP34XX SDP # version

U-Boot 1.1.4 (Sep 12 2007 - 16:10:57)
OMAP34XX SDP # boot

Warning: MAC addresses don't match:
=09HW MAC address:  08:00:28:01:06:9F
=09"ethaddr" value: 10:10:10:10:34:30
Using MAC Address 10:10:10:10:34:30
TFTP from server 192.168.111.1; our IP address is 192.168.111.156
Filename 'uImage-omap3430sdp'.
Load address: 0x80000000
Loading: *=08##############################################################=
###
=09 #################################################################
=09 #################################################################
=09 #################################################################
=09 ######################
done
Bytes transferred =3D 1443316 (1605f4 hex)
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.23-omap1-g39898515-dir
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1443252 Bytes =3D  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux........................................................=
=2E...................................... done, booting the kernel.
<5>Linux version 2.6.23-omap1-g39898515-dirty (paul@daigoro) (gcc version 4=
=2E2.0 20070413 (prerelease) (CodeSourcery Sourcery G++ Lite 2007q1-10)) #5=
98 Wed Nov 14 02:19:42 MST 2007
CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D00c5387f
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 256 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 32512 pages, LIFO batch:7
<7>  Normal zone: 0 pages used for memmap
<7>  Movable zone: 0 pages used for memmap
<3>Unknown OMAP CPU id
<6>SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs nfsroot=3D19=
2.168.111.1:/home/armroot,rsize=3D8192,wsize=3D8192,nolock ip=3D192.168.111=
=2E156:192.168.111.1:192.168.111.1 ro
<6>Clocking rate (Crystal/DPLL/MPU): 19.2/166/166 MHz
<6>GPMC revision 4.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.4
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB 0MB =3D 128MB total
<5>Memory: 126848KB available (2680K code, 231K data, 104K init)
<7>Calibrating delay loop... 380.10 BogoMIPS (lpj=3D1900544)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>net_namespace: 64 bytes
<6>NET: Registered protocol family 16
<6>OMAP DMA hardware revision 4.0
<3>USB: No board-specific platform config found
<6>NET: Registered protocol family 2
<6>Time: gp timer clocksource has been installed.
<6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>TCP established hash table entries: 4096 (order: 3, 32768 bytes)
<6>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
<6>TCP: Hash tables configured (established 4096 bind 4096)
<6>TCP reno registered
<4>NetWinder Floating Point Emulator V0.97 (double precision)
<5>VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
<6>console [ttyS0] enabled
Linux version 2.6.23-omap1-g39898515-dirty (paul@daigoro) (gcc version 4.2.=
0 20070413 (prerelease) (CodeSourcery Sourcery G++ Lite 2007q1-10)) #598 We=
d Nov 14 02:19:42 MST 2007
CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D00c5387f
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
Unknown OMAP CPU id
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs nfsroot=3D192.1=
68.111.1:/home/armroot,rsize=3D8192,wsize=3D8192,nolock ip=3D192.168.111.15=
6:192.168.111.1:192.168.111.1 ro
Clocking rate (Crystal/DPLL/MPU): 19.2/166/166 MHz
GPMC revision 4.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.4
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB 0MB =3D 128MB total
Memory: 126848KB available (2680K code, 231K data, 104K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 64 bytes
NET: Registered protocol family 16
OMAP DMA hardware revision 4.0
USB: No board-specific platform config found
NET: Registered protocol family 2
Time: gp timer clocksource has been installed.
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
console [ttyS0] enabled
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
<6>serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
<6>loop: module loaded
loop: module loaded
smc91x: IOADDR c8850000 doesn't match configuration (300).
smc91x: IOADDR c8850000 doesn't match configuration (300).
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c8850000 IRQ 189eth0: SMC91C94 (rev 9) at c885000=
0 IRQ 189 [nowait]
 [nowait]
eth0: Ethernet addr: 10:10:10:10:34:30
eth0: Ethernet addr: 10:10:10:10:34:30
<7>eth0: No PHY found
<6>omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
<6>omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
<6>Using buffer write method
Using buffer write method
<5>cfi_cmdset_0001: Erase suspend on write enabled
cfi_cmdset_0001: Erase suspend on write enabled
<7>erase region 0: offset=3D0x0,size=3D0x20000,blocks=3D255
<7>erase region 1: offset=3D0x1fe0000,size=3D0x8000,blocks=3D4
<7>erase region 2: offset=3D0x2000000,size=3D0x20000,blocks=3D255
<7>erase region 3: offset=3D0x3fe0000,size=3D0x8000,blocks=3D4
<7>omapflash.0: 2 set(s) of 1 interleaved chips --> 32 partitions of 2048 K=
iB
<5>Creating 4 MTD partitions on "omapflash.0":
Creating 4 MTD partitions on "omapflash.0":
<5>0x00000000-0x00040000 : "bootloader"
0x00000000-0x00040000 : "bootloader"
<5>0x00040000-0x00060000 : "params"
0x00040000-0x00060000 : "params"
<5>0x00060000-0x00260000 : "kernel"
0x00060000-0x00260000 : "kernel"
<5>0x00260000-0x04000000 : "filesystem"
0x00260000-0x04000000 : "filesystem"
<6>TCP cubic registered
TCP cubic registered
<6>NET: Registered protocol family 1
NET: Registered protocol family 1
<6>NET: Registered protocol family 17
NET: Registered protocol family 17
<6>NET: Registered protocol family 15
NET: Registered protocol family 15
<6>RPC: Registered udp transport module.
RPC: Registered udp transport module.
<6>RPC: Registered tcp transport module.
RPC: Registered tcp transport module.
<6>VFP support v0.3: VFP support v0.3: implementor 41 architecture 3 part 3=
0 variant c rev 0
implementor 41 architecture 3 part 30 variant c rev 0
<6>eth0: link up
eth0: link up
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:IP-Config: Complete:
      device=3Deth0
      device=3Deth0, addr=3D192.168.111.156, addr=3D192.168.111.156, mask=
=3D255.255.255.0, mask=3D255.255.255.0, gw=3D192.168.111.1, gw=3D192.168.11=
1.1,
     host=3D192.168.111.156, domain=3D, nis-domain=3D(none),
     host=3D192.168.111.156, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.111.1,
     bootserver=3D192.168.111.1, rootserver=3D192.168.111.1, rootserver=3D1=
92.168.111.1, rootpath=3D, rootpath=3D

<5>Looking up port of RPC 100003/2 on 192.168.111.1
Looking up port of RPC 100003/2 on 192.168.111.1
<5>Looking up port of RPC 100005/1 on 192.168.111.1
Looking up port of RPC 100005/1 on 192.168.111.1
VFS: Mounted root (nfs filesystem) readonly.
VFS: Mounted root (nfs filesystem) readonly.
<6>Freeing init memory: 104K
Freeing init memory: 104K
INIT: version 2.86 booting
INIT: Entering runlevel: 2
Mounting /var and /tmp as tmpfs
Starting PCMCIA services: FATAL: Could not load /lib/modules/2.6.23-omap1-g=
39898515-dirty/modules.dep: No such file or directory
Error: Failed to load pcmcia_core
Starting OpenBSD Secure Shell server: sshd.
modprobe: FATAL: Could not load /lib/modules/2.6.23-omap1-g39898515-dirty/m=
odules.dep: No such file or directory

Starting web server: /usr/sbin/thttpd already running.

Debian GNU/Linux 3.1 192.168.111.156 ttyS0

192.168.111.156 login:=20
--155748971-511648098-1195160568=:32494
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-511648098-1195160568=:32494--
