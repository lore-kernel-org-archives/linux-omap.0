From: Nachiappan <tonachi@gmail.com>
Subject: omap 1510 unable to open camera 0V6x30 device, but got it detected
Date: Tue, 25 Apr 2006 17:51:42 +0530
Message-ID: <b4638ae70604250521r1de7b133q5110c81585271017@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have ported linux kernel 2. 4.19 onto OMAP 1510 innovator board.

b4 porting kernel to omap, led on the camera glows.

After porting kernel,
camera module is getting detected.
and
led on camera turns off[while porting kernel to omap 1510]

As follows:

*innovator-ts: registered*

*camif: Initializing, DMA to SDRAM*

*camif: camera module detected, facing forward*

*sccb: registered SCCB*

*camif: OV6X30 camera detected*

*V4L2: Registered "OMAP1510 V4L2 Capture Driver" as char device 81, 0*

*kmod: failed to exec /sbin/modprobe -s -k v4l_compat, errno =3D 2*

**

*I have problem in open system call for this device.*

*my program abruptly hangs at that point where it should either return file
descriptor -1 if it is not able to find/open that char device file.*

*vid=3Dopen("/dev/video0" , O_RDONLY);*

*iam comparing vid<0 , it doesnt come out of that open statement itself.*

**

*what are the possibilities for hanging in open system call?*

*when i replace /dev/video0 with /dev/fb0 frame buffer lcd device, it is
opening, or with ttys0 it opens.*

*even with ts[touch screen] it opens.*

*Iam able to find that video0 file as well in /dev.*



Checking out the permissions of all file[char devices everything are the
same].



What else could be the reason for not opening the camera device.

is it that even after porting linux kernel led on the camera module should
be glowing?

Awaiting ur help eagerly,

Nachiappan

**

**

**

**

vid=3Dopen(device,O_RDONLY)


MY PROGRAM HANGS HERE,  i dont get even a unable to open statement which i
have given if i vid <0

same device if i replave with ts[touchscreen) or fb0(framebuffer) i dont
find this problem........


can u suggest me what could be the problems in opening that device.



*when iam booting the kernel i got it as :*



 +-------------------------------------+

| Welcome to the |

| DSPLinux Bootloader |

| |

| rrload v4.8 by RidgeRun, Inc |

| platform: OMAP1510_INNOVATOR |

+-------------------------------------+

MAIN MENU

---------

1. Load [comp] from I/O port...

2. Store RAM [comp] to Flash...

3. View/Edit Params...

4. Boot Kernel/filesystem (boot_auto)

5. CmdLine Mode

6. Dump memory

r. Run Default Boot Cmd

E. Erase [comp] from Flash...

Which? 4

Jumping to 0x10C08000

Uncompressing Linux............................................... done,
bootin.Linux version 2.4.19-rmk7-omap1 (root@localhost) (gcc version
2.95.320010315 (6CPU: Arm925Tsid(wb) revision 2

Machine: TI-Innovator/OMAP1510

On node 0 totalpages: 8192

zone(0): 8192 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: mem=3D32M console=3DttyS0,115200n8 initrd rw ip=3Dboot=
p
root=3D/de6Console: colour dummy device 80x30

Calibrating delay loop... 83.76 BogoMIPS

Memory: 32MB =3D 32MB total

Memory: 30748KB available (1220K code, 319K data, 76K init)

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

Power Management for the OMAP1510 is initialized pm_idle 0xc0026488

apm: BIOS version 1.2 Flags 0x02 (Driver version 1.13)

Starting kswapd

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with no serial options enabled

ttyS00 at 0xfffb0000 (irq =3D 46) is a OMAP UART

ttyS01 at 0xfffb0800 (irq =3D 47) is a OMAP UART

ttyS02 at 0xfffb9800 (irq =3D 15) is a OMAP UART

smc9194.c:v0.15 12/15/00 by Erik Stahlman (erik@vt.edu)

eth0: SMC91C94/91C96 (rev 9) at 0xe8000300 IRQ:93 INTF:TP MEM:6144b ADDR:
00:501RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

innovator-ts: registered

camif: Initializing, DMA to SDRAM

camif: camera module detected, facing forward

sccb: registered SCCB

camif: OV6X30 camera detected

V4L2: Registered "OMAP1510 V4L2 Capture Driver" as char device 81, 0

kmod: failed to exec /sbin/modprobe -s -k v4l_compat, errno =3D 2

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

Sending BOOTP requests . OK

IP-Config: Got BOOTP answer from 192.168.100.45, my address is
192.168.100.46

IP-Config: Complete:

device=3Deth0, addr=3D192.168.100.46, mask=3D255.255.255.0, gw=3D255.255.25=
5.255 ,

host=3D192.168.100.46, domain=3Dmygroup, nis-domain=3D(none),

bootserver=3D192.168.100.45, rootserver=3D192.168.100.45,
rootpath=3D/home/sami//NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

NetWinder Floating Point Emulator V0.95 (c) 1998-1999
Rebel.com<http://rebel.com/>

Looking up port of RPC 100003/2 on 192.168.100.45

Looking up port of RPC 100005/1 on 192.168.100.45

VFS: Mounted root (nfs filesystem).

Freeing init memory: 76K

init started: BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call binary

******************************************

Starting System Init for OMAP5912OSK

******************************************

Please press Enter to activate this console.

 BusyBox v1.00-pre8 (2004.03.05-22:18+0000) Built-in shell (ash)

Enter 'help' for a list of built-in commands.

-sh: can't access tty; job control turned off

#




with regards,
 Nachiappan
