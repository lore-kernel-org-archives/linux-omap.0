From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: Re: NFS Bootargs
Date: Wed, 09 Aug 2006 19:55:14 +0000
Message-ID: <BAY102-F40D97F1BD174E3E377EB12A9550@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_5055_62dc_237c"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.

------=_NextPart_000_5055_62dc_237c
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by calf.ext.ti.com id k79JtSa1026757

Daan,

   The raw console output as captured by hyperterminal is attached. I hav=
e=20
to head out now but I will do more tomorrow on this issue. Seriously, tha=
nks=20
so much for your help.

Thanks,
Andy



>From: "Daan Biere" <webwire@zonnet.nl>
>Reply-To: "Daan Biere" <webwire@zonnet.nl>
>To: "Abot Botbot" <dejanigma@hotmail.com>
>Subject: Re: NFS Bootargs
>Date: Wed, 9 Aug 2006 21:08:21 +0200
>
>Hey :)
>i made the script because i'll make alot of filesystems for development=20
>purposes, the script is just to use if you have an empty directory and w=
ant=20
>to build your own distribution, if you run the script in the /nfsroot/li=
b=20
>directory with parameter "/bin/bash" it will copy all needed libs to tha=
t=20
>directory, but if you already have the nfsroot it shouldn't be necessary.
>Did you already check in the /var/log/daemon.log if the nfs root is bein=
g=20
>accessed by the nfs client?, if not you should check your kernel build=20
>again, i'm not aware of your linux experience but iits better to explain=
=20
>then not.
>
>In the menuconfig of your kernel you have to check the following options=
:
>
>    File systems  --->      Network File Systems  --->
>  x x                         <*> NFS file system support x x
>  x x                         [*]   Provide NFSv3 client support x x
>  x x                         [*]     Provide client support for the NFS=
v3=20
>ACL protocol extension                             x x
>  x x                         [*]   Provide NFSv4 client support=20
>(EXPERIMENTAL)                                               x x
>  x x                         [*]   Allow direct I/O on NFS files=20
>(EXPERIMENTAL)                                              x x
>  x x                         <*> NFS server support x x
>  x x                         [*]   Provide NFSv3 server support x x
>  x x                         [*]     Provide server support for the NFS=
v3=20
>ACL protocol extension                             x x
>  x x                         [*]     Provide NFSv4 server support=20
>(EXPERIMENTAL)                                             x x
>  x x                         ---   Provide NFS server over TCP support =
x x
>  x x                         [*] Root file system on NFS x x
>
>
>Can you give me an output of the kernel messages so i can check what err=
ors=20
>could cause the problem?
>
>
>----- Original Message ----- From: "Abot Botbot" <dejanigma@hotmail.com>
>To: <linux-omap-open-source@linux.omap.com>
>Sent: Wednesday, August 09, 2006 8:18 PM
>Subject: Re: NFS Bootargs
>
>
>>Daan,
>>
>>
>>   Thanks so much for your quick reply. I checked my lib folder, it was=
=20
>>fully populated with everything I need and the perms are set correctly.=
=20
>>This was taken care of during the "make modules" and "make=20
>>INSTALL_MOD_PATH..." stuff. I haven't bashed your script yet just becau=
se=20
>>I'm not too clear what the regexp is doing, but I assume that its looki=
ng=20
>>for the correct version numbers and copying the appropraite files. Woul=
d I=20
>>run this from the /filesys/lib directory? Also, the "lddcopy /bin/bash"=
=20
>>line, should that be run from /filesys/lib to /filesys/bin/sh (not bash=
?)?=20
>>I haven't run accross a document that entailed that any of the librarie=
s=20
>>should end up in that place, though I am pretty new to this process.=20
>>Thanks again for your help, and don't feel obligated to waste more time=
 on=20
>>this issue than you feel necessary. Otehrwise, if you do have any other=
=20
>>suggestions I would be glad to hear them.
>>
>>Thanks,
>>Andy
>>
>>
>>>From: "Daan Biere" <webwire@zonnet.nl>
>>>Reply-To: "Daan Biere" <webwire@zonnet.nl>
>>>To: "Abot Botbot"=20
>>><dejanigma@hotmail.com>,<linux-omap-open-source@linux.omap.com>
>>>Subject: Re: NFS Bootargs
>>>Date: Wed, 9 Aug 2006 16:45:35 +0200
>>>
>>>Hi Abot,
>>>I've set up a nfsroot yesterday for testing a mips based system, i''m=20
>>>using the following bootargs:
>>>
>>>append ip=3Ddhcp nfsroot=3D"192.168.1.101:/home/usr/projects/filesys"=20
>>>init=3D/bin/sh root=3D/dev/nfs rw
>>>
>>>just be sure you've got all the required depencies in the /lib dir and=
=20
>>>you'll have the /dev/console, i made a little script to do this.
>>>
>>>
>>>ldd $1 | awk '{ print $3; }' | sed 's/\(\/.*\/\(.*\)\)/\1 \2/g' -\
>>>| xargs -l1 --no-run-if-empty cp
>>>
>>>go to the lib dir and type something like "lddcopy /bin/bash" it would=
=20
>>>copy all the required libs.
>>>
>>>Kind Regards,
>>>Daan Biere
>>>----- Original Message ----- From: "Abot Botbot" <dejanigma@hotmail.co=
m>
>>>To: <linux-omap-open-source@linux.omap.com>
>>>Sent: Wednesday, August 09, 2006 4:26 PM
>>>Subject: NFS Bootargs
>>>
>>>
>>>>Hello all,
>>>>
>>>>
>>>>    I'm trying to boot off an NFS share as laid out in the OSK Users=20
>>>>guide so I can begin my software development process. My buidling of =
the=20
>>>>system with the approrpiate makefiles has all gone seamlessly. I am=20
>>>>attempting to boot from the NFS share on my linux machine, which I've=
=20
>>>>demonstrated is possible from a neighboring machine. The error is as=20
>>>>follows:
>>>>
>>>>Kernel panic: No init found.  Try passing init=3D option to kernel.
>>>>
>>>>I have tried putting an "init=3D/bin/sh" argument into the bootargs=20
>>>>string, but that hasn't solved the problem. Does anyone else have a=20
>>>>bootargs string for an NFS share that they have used succesfully? Her=
e=20
>>>>is the string I am currently using for refference:
>>>>
>>>>console=3DttyS0,115200n8 noinitrd rw ip=3Ddhcp root=3D/dev/nfs=20
>>>>nfsroot=3D192.168.1.101:/home/usr/projects/filesys,nolock mem=3D30M=20
>>>>init=3D/bin/sh
>>>>
>>>>Thanks for your help,
>>>>Andy
>>>>
>>>>_________________________________________________________________
>>>>Don't just search. Find. Check out the new MSN Search!=20
>>>>http://search.msn.click-url.com/go/onm00200636ave/direct/01/
>>>>
>>>>_______________________________________________
>>>>Linux-omap-open-source mailing list
>>>>Linux-omap-open-source@linux.omap.com
>>>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>>
>>
>>_________________________________________________________________
>>Express yourself instantly with MSN Messenger! Download today - it's FR=
EE!=20
>>http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>>
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar =96 get it now!=20
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

------=_NextPart_000_5055_62dc_237c
Content-Type: text/plain; name="error.txt"; format=flowed
Content-Disposition: attachment; filename="error.txt"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by calf.ext.ti.com id k79JtSa1026757

**^XB1000000000045a
=8A^X^X^X^X^X^X^X^X^X^X^H^H^H^H^H^H^H^H^H^H
U-Boot 1.1.1 (Aug  4 2005 - 10:41:25)

U-Boot code: 11080000 -> 11095DD4  BSS: -> 1109A5A4
RAM Configuration:
Bank #0: 10000000 32 MB
Micron StrataFlash MT28F128J3 device initialized
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot: 10 =08=08=08 9 =08=08=08 8 =08=08=08 7 =08=08=
=08 6 =08=08=08 5 =08=08=08 4 =08=08=08 3=20
=08=08=08 2 =08=08=08 1 =08=08=08 0
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20_mvl31-omap5912_osk
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    741532 Bytes =3D 724.2 kB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ...
U-Boot 1.1.1 (Aug  4 2005 - 10:41:25)

U-Boot code: 11080000 -> 11095DD4  BSS: -> 1109A5A4
RAM Configuration:
Bank #0: 10000000 32 MB
Micron StrataFlash MT28F128J3 device initialized
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot: 10 =08=08=08 9 =08=08=08 8 =08=08=08 7 =08=08=
=08 6 =08=08=08 5 =08=08=08 4 =08=08=08 3=20
=08=08=08 2 =08=08=08 1 =08=08=08 0
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20_mvl31-omap5912_osk
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    741532 Bytes =3D 724.2 kB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux................................................... do=
ne,=20
booting the kernel.

CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv?(8))

CPU: D undefined 14 cache

CPU: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets

CPU: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets

Machine: OMAP5912 OSK/OMAP1610

On node 0 totalpages: 8192

zone(0): 8192 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200n8 ip=3Ddhcp=20
nfsroot=3D130.215.17.144:/home/dejanigma/projects/filesys init=3D/bin/sh=20
root=3D/dev/nfs rw

Calibrating delay loop... 95.84 BogoMIPS

Memory: 32MB =3D 32MB total

Memory: 22484KB available (1352K code, 282K data, 64K init)

Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)

Inode cache hash table entries: 2048 (order: 2, 16384 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)

Page-cache hash table entries: 8192 (order: 3, 32768 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

LSP Revision 33

ikconfig 0.5 with /proc/ikconfig

Starting kswapd

Disabling the Out Of Memory Killer

devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis=20
Communications AB.

i2c-core.o: i2c core module version 2.6.2 (20011118)

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with no serial options enabled

ttyS00 at 0xfffb0000 (irq =3D 46) is a OMAP UART

rtc: RTC power up reset detected.

rtc: Enabling RTC.

Real Time Clock Driver v1.0

watchdog: TI OMAP Watchdog Timer: timer margin 19 sec

smc9194.c:v0.15 12/15/00 by Erik Stahlman (erik@vt.edu)

eth0: SMC91C94/91C96 (rev 9) at 0xe8000000 IRQ:160 INTF:TP MEM:6144b ADDR=
:=20
00:0e:99:02:0d:46

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

OMAP1610 I2C INFO: Driver ver. 1.1

TPS65010 driver successfully loaded

OMAP1610 audio support initialized

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

OMAP flash: CFI device at 0x00000000, 16MiB, 16-bit

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

OMAP flash: CFI device at 0x01000000, 16MiB, 16-bit

Concatenating MTD devices:

(0): "<NULL>"

(1): "<NULL>"

into device "omap-flash"

No RedBoot partition table detected in omap-flash

OMAP flash: using static partition definition

Creating 5 MTD partitions on "omap-flash":

0x00000000-0x00020000 : "BootLoader"

0x00020000-0x00040000 : "Params"

0x00040000-0x00240000 : "Kernel"

0x00240000-0x01000000 : "Flash0 FileSys"

0x01000000-0x02000000 : "Flash1 FileSys"

Linux Kernel Card Services 3.1.22

  options:  none

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 2048 bind 4096)

Sending DHCP requests ., OK

IP-Config: Got DHCP answer from 0.0.0.0, my addr

U-Boot 1.1.1 (Aug  4 2005 - 10:41:25)

U-Boot code: 11080000 -> 11095DD4  BSS: -> 1109A5A4
RAM Configuration:
Bank #0: 10000000 32 MB
Micron StrataFlash MT28F128J3 device initialized
Flash: 32 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot: 10 =08=08=08 9 =08=08=08 8 =08=08=08 7 =08=08=
=08 6 =08=08=08 5 =08=08=08 4 =08=08=08 3=20
=08=08=08 2 =08=08=08 1 =08=08=08 0
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20_mvl31-omap5912_osk
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    741532 Bytes =3D 724.2 kB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux................................................... do=
ne,=20
booting the kernel.

CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv?(8))

CPU: D undefined 14 cache

CPU: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets

CPU: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets

Machine: OMAP5912 OSK/OMAP1610

On node 0 totalpages: 8192

zone(0): 8192 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=3DttyS0,115200n8 ip=3Ddhcp=20
nfsroot=3D130.215.17.144:/home/dejanigma/projects/filesys init=3D/bin/sh=20
root=3D/dev/nfs rw

Calibrating delay loop... 95.84 BogoMIPS

Memory: 32MB =3D 32MB total

Memory: 22484KB available (1352K code, 282K data, 64K init)

Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)

Inode cache hash table entries: 2048 (order: 2, 16384 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)

Page-cache hash table entries: 8192 (order: 3, 32768 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

LSP Revision 33

ikconfig 0.5 with /proc/ikconfig

Starting kswapd

Disabling the Out Of Memory Killer

devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis=20
Communications AB.

i2c-core.o: i2c core module version 2.6.2 (20011118)

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with no serial options enabled

ttyS00 at 0xfffb0000 (irq =3D 46) is a OMAP UART

rtc: RTC power up reset detected.

rtc: Enabling RTC.

Real Time Clock Driver v1.0

watchdog: TI OMAP Watchdog Timer: timer margin 19 sec

smc9194.c:v0.15 12/15/00 by Erik Stahlman (erik@vt.edu)

eth0: SMC91C94/91C96 (rev 9) at 0xe8000000 IRQ:160 INTF:TP MEM:6144b ADDR=
:=20
00:0e:99:02:0d:46

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

OMAP1610 I2C INFO: Driver ver. 1.1

TPS65010 driver successfully loaded

OMAP1610 audio support initialized

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

OMAP flash: CFI device at 0x00000000, 16MiB, 16-bit

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

OMAP flash: CFI device at 0x01000000, 16MiB, 16-bit

Concatenating MTD devices:

(0): "<NULL>"

(1): "<NULL>"

into device "omap-flash"

No RedBoot partition table detected in omap-flash

OMAP flash: using static partition definition

Creating 5 MTD partitions on "omap-flash":

0x00000000-0x00020000 : "BootLoader"

0x00020000-0x00040000 : "Params"

0x00040000-0x00240000 : "Kernel"

0x00240000-0x01000000 : "Flash0 FileSys"

0x01000000-0x02000000 : "Flash1 FileSys"

Linux Kernel Card Services 3.1.22

  options:  none

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 2048 bind 4096)

Sending DHCP requests ., OK

IP-Config: Got DHCP answer from 0.0.0.0, my address is 130.215.18.10

IP-Config: Complete:

      device=3Deth0, addr=3D130.215.18.10, mask=3D255.255.248.0, gw=3D130=
.215.16.1,

     host=3Dandyd_evm.ece.wpi.edu, domain=3Dece.wpi.edu, nis-domain=3D(no=
ne),

     bootserver=3D0.0.0.0, rootserver=3D130.215.17.144, rootpath=3D

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

802.1Q VLAN Support v1.7 Ben Greear <greearb@candelatech.com>

All bugs added by David S. Miller <davem@redhat.com>

NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com

RAMDISK: Couldn't find valid RAM disk image starting at 0.

Freeing initrd memory: 8192K

Looking up port of RPC 100003/2 on 130.215.17.144

Looking up port of RPC 100005/1 on 130.215.17.144

VFS: Mounted root (nfs filesystem).

Mounted devfs on /dev

Freeing init memory: 64K

Kernel panic: No init found.  Try passing init=3D option to kernel.


------=_NextPart_000_5055_62dc_237c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


------=_NextPart_000_5055_62dc_237c--
