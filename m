From: James Selvam <james.iisc@gmail.com>
Subject: error while loading shared libraries ...
Date: Mon, 13 Feb 2006 12:19:53 +0530
Message-ID: <fd1e34b0602122249t7829239ahdef5755a57d6c11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello All,

I am
->using the following tools for building: Binutils-2.12.1; gcc-2.95.3;
glibc-2.2.3.
->working with the kernel 2.4.19 with patch-2.4.19-rmk7 and
patch-2.4.19-rmk7-omap1 patches and an EXT2 Disk Filesystem over RAM
Disk.
->using the RRload bootloader for the innovator (OMAP 1510).

Im getting an "error while loading shared libraries". I have attached
the console output inline for your reference. Could someone tell me
how to get around the problem?

Also what is the latest combination of build tools version that has been te=
sted?

Regards,
James.

Jumping to 0x10C08000
Uncompressing Linux............................................... done, bo=
oting
the kernel.
Linux version 2.4.19-rmk7-omap1 (root@edpc461) (gcc version 2.95.3 20010315=
 (rel
ease)) #4 Tue Feb 7 12:09:08 IST 2006
CPU: Arm925Tsid(wb) revision 2
Machine: TI-Innovator/OMAP1510
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: mem=3D32M console=3DttyS0,115200n8 initrd=3D0x10000000=
 root=3D/dev/
mtdblock3 ip=3Doff pra
Console: colour dummy device 80x30
Calibrating delay loop... 83.76 BogoMIPS
Memory: 32MB =3D 32MB total
Memory: 30768KB available (1208K code, 307K data, 76K init)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Innovator FPGA Rev 2.1 Board Rev 16
Power Management for the OMAP1510 is initialized pm_idle 0xc00264f4
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.13)
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfffb0000 (irq =3D 46) is a OMAP UART
ttyS01 at 0xfffb0800 (irq =3D 47) is a OMAP UART
ttyS02 at 0xfffb9800 (irq =3D 15) is a OMAP UART
smc9194.c:v0.15 12/15/00 by Erik Stahlman (erik@vt.edu)
eth0: SMC91C94/91C96 (rev 9) at 0xe8000300 IRQ:93 INTF:TP MEM:6144b ADDR: 0=
8:00:
28:32:00:00
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
innovator-ts: registered
OMAP flash 0: probing 16-bit flash bus
Using buffer write method
Using static partition definition
Creating 4 MTD partitions on "OMAP flash":
0x00000000-0x00020000 : "BootLoader"
0x00020000-0x00060000 : "Params"
0x00060000-0x00260000 : "Kernel"
0x00260000-0x01000000 : "Flash0 FileSys"
OMAP flash 1: probing 16-bit flash bus
Using buffer write method
Using static partition definition
Creating 1 MTD partitions on "OMAP flash":
0x00000000-0x01000000 : "Flash1 FileSys"
DSPLinux FB (c) 2001 RidgeRun, Inc.
Console: switching to colour frame buffer device 30x40
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 76K
init: error while loading shared libraries: cannot open shared object file:=
 cann
ot load shared object file: No such file or directory
Kernel panic: Attempted to kill init!
