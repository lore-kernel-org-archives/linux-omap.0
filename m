From: "naga rajan" <nagubk82@gmail.com>
Subject: Problem while fusing the filesystem
Date: Thu, 23 Mar 2006 18:36:37 +0530
Message-ID: <7e6cc7550603230506k35f8817eh6b8f70bc1e586c58@mail.gmail.com>
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

 Hi all,

  I ported the linux kernel 2.6.12 and mounted the filesystem using NFS
method successfully. While fusing the filesystem using TFTP method, I am
getting the following error. I set the MTD configuration as mentioned in th=
e
"newbie guide".

 Initially I tried with mtdblock 4,

U-Boot 1.1.1 (Jul 19 2004 - 09:17:40)

U-Boot code: 11080000 -> 11095D6C  BSS: -> 1109A53C
RAM Configuration:
Bank #0: 10000000 32 MB
Micron StrataFlash MT28F128J3 device initialized
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
## Booting image at 00100000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1106230 Bytes =3D  1.1 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Uncompressing
Linux.............................................................
............. done, booting the kernel.
Linux version 2.6.12-omap1 (root@omap) (gcc version 3.3.2) #7 Thu Mar 23
16:21:0
4 IST 2006
CPU: ARM926EJ-Sid(wt) [41069263] revision 3 (ARMv5TEJ)
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writethrough
OMAP162123 revision 2 handled as 16xx id: 90059089bfcb0c0c
SRAM size: 0x4000
Clocks: ARM_SYSST: 0x0000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
Clocking rate (xtal/DPLL1/MPU): 12.0/192000000/192000000 MHz
Built 1 zonelists
Kernel command line: console=3DttyS0,115200n8 noinitrd rw ip=3Doff
root=3D/dev/mtdbloc
k4 mem=3D30M
.
.
.
.
.
.
.
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
MUX: initialized P20_1610_GPIO4
OMAP touchscreen driver initialized
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
NET: Registered protocol family 1
VFS: No root yet, retrying to mount root on mtdblock4 (unknown-block(0,0))
VFS: No root yet, retrying to mount root on mtdblock4 (unknown-block(0,0))

 I also tried with mtdblock3,



U-Boot 1.1.1 (Jul 19 2004 - 09:17:40)

U-Boot code: 11080000 -> 11095D6C  BSS: -> 1109A53C
RAM Configuration:
Bank #0: 10000000 32 MB
Micron StrataFlash MT28F128J3 device initialized
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
## Booting image at 00100000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1106230 Bytes =3D  1.1 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Uncompressing
Linux.............................................................
............. done, booting the kernel.
Linux version 2.6.12-omap1 (root@omap) (gcc version 3.3.2) #7 Thu Mar 23
16:21:0
4 IST 2006
CPU: ARM926EJ-Sid(wt) [41069263] revision 3 (ARMv5TEJ)
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writethrough
OMAP162123 revision 2 handled as 16xx id: 90059089bfcb0c0c
SRAM size: 0x4000
Clocks: ARM_SYSST: 0x0000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
Clocking rate (xtal/DPLL1/MPU): 12.0/192000000/192000000 MHz
Built 1 zonelists
Kernel command line: console=3DttyS0,115200n8 noinitrd rw ip=3Doff
root=3D/dev/mtdbloc
k3 mem=3D30M
.
.
.
.
.
.
.
.
.
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
MUX: initialized P20_1610_GPIO4
OMAP touchscreen driver initialized
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
NET: Registered protocol family 1
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(31,3)

 Have you overcome this problem?Please help me in this regard.


Thanks in advance,
B.Nagarajan,
SANDS.
