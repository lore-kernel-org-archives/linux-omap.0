From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Problems with jffs2 rootfs using 2.6.28-rc3
Date: Fri, 7 Nov 2008 12:09:33 -0800
Message-ID: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:64349 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYKGUJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 15:09:35 -0500
Received: by ey-out-2122.google.com with SMTP id 6so619618eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 12:09:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Is anyone successfully using a rootfs on nand using jffs2 on OMAP3 systems?

I'm having little success.  It used to work back in 2.6.26 timeframe
but seems to have broken sometime during 2.6.27.

Attempts to untar a rootfs result in ECC errors and then an oops.
Details below.

Is anyone else seeing this?

Steve

root@overo:~# flash_eraseall -jq /dev/mtd4

root@overo:~# mount -t jffs2 /dev/mtdblock4 /media/mtdblock4/
JFFS2 notice: (1766) jffs2_build_xattr_subsystem: complete building
xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0
dead, 0 orphan) found.

root@overo:~# df
Filesystem           1k-blocks      Used Available Use% Mounted on
rootfs                 1792984    899200    803420  53% /
/dev/root              1792984    899200    803420  53% /
tmpfs                       40         0        40   0% /mnt/.psplash
none                     62756        80     62676   0% /dev
/dev/mmcblk0p1           39497      2588     36909   7% /media/mmcblk0p1
/dev/mmcblk0p2         1792984    899200    803420  53% /media/mmcblk0p2
tmpfs                    62756       108     62648   0% /var/volatile
tmpfs                    62756         0     62756   0% /dev/shm
tmpfs                    62756         0     62756   0% /media/ram
/dev/mtdblock4          255488      5764    249724   2% /media/mtdblock4

root@overo:~# cd /media/mtdblock4/
root@overo:/media/mtdblock4# tar xvf /home/root/Desktop/omap3-desktop-image-over
o.tar
./
./usr/
./usr/games/
./usr/share/
./usr/share/gpe-todo/
./usr/share/gpe-todo/bar-box.png
./usr/share/gpe-todo/tick-box.png
./usr/share/gpe-todo/dot-box.png
./usr/share/gpe-todo/flag-16.png
./usr/share/gpe-todo/notick-box.png
./usr/share/udhcpc/
./usr/share/udhcpc/default.script
./usr/share/enchant/
./usr/share/enchant/enchant.ordering
./usr/share/glchess/
./usr/share/glchess/save_game.glade
./usr/share/glchess/network_game.glade
./usr/share/glchess/glchess.glade
./usr/share/glchess/log.glade
./usr/share/glchess/preferences.glade
./usr/share/glchess/new_game.glade
./usr/share/glchess/chess_view.glade
./usr/share/glchess/ai.xml
./usr/share/glchess/load_game.glade
./usr/share/gpe-lights/
./usr/share/gpe-lights/oses.png
uncorrectable error : <3>uncorrectable error : <3>uncorrectable error
: <3>uncorrectable error : <3>uncorrectable error : <3>uncorrectable
error : <3>uncorrectable error : <3>uncorrectable error :
<4>mtd->read(0x1000 bytes from 0xf950ecc) returned ECC error
./usr/share/gpe-lights/face.png
uncorrectable error : <3>uncorrectable error : <3>uncorrectable error
: <3>uncorrectable error : <3>uncorrectable error : <3>uncorrectable
error : <3>uncorrectable error : <3>uncorrectable error :
<4>mtd->read(0x1000 bytes from 0xf9523cc) returned ECC error
uncorrectable error : <3>uncorrectable error : <3>uncorrectable error
: <3>uncorrectable error : <3>uncorrectable error : <3>uncorrectable
error : <3>uncorrectable error : <3>uncorrectable error :
<4>mtd->read(0x1000 bytes from 0xf953e54) returned ECC error
./usr/share/gpe-lights/colors.png
./usr/share/gpe-lights/bulb.png
./usr/share/dbus-1/
./usr/share/dbus-1/system-services/
./usr/share/dbus-1/services/
./usr/share/dbus-1/services/gconf.service
./usr/share/dbus-1/services/gnome-vfs-daemon.service
./usr/share/dbus-1/services/org.gnome.keyring.service
./usr/share/gnome-2.0/
./usr/share/gnome-2.0/ui/
./usr/share/gnome-2.0/ui/Bonobo_Sample_Container-ui.xml
uncorrectable error : ./usr/share/gnome-2.0/ui/bonobo-<3>uncorrectable
error : browser.xml
./usr/share/gnome-2<3>uncorrectable error : .0/ui/Bonobo_Sample_Hello.xml
.<3>uncorrectable error : /usr/share/pixmaps/
./usr/share<3>uncorrectable error : /pixmaps/edit-vcard.png
./usr/s<4>mtd->read(0x1000 bytes from 0xf95af1c) returned ECC error
hare/pixmaps/gnome-application-xData CRC 10a52e7d != calculated CRC
19b1f1cc for node at 0f95aed8
-gnumeric.png
./usr/share/pixmaUnable to handle kernel NULL pointer dereference at
virtual address 00000000
ps/gpe-config-screen.png
./usr/pgd = c5bfc000
share/pixmaps/gpe-lights.png
./[00000000] *pgd=85b32031usr/share/pixmaps/hourglass-4.pn, *pte=00000000g
, *ppte=00000000aps/glchess/
                ./usr/share/pixmaps/glchess/pie
ce.png
Internal error: Oops: 817 [#1]
Modules linked in: ipv6 libertas_sdio libertas
CPU: 0    Not tainted  (2.6.28-rc3-omap1 #1)
PC is at jffs2_write_end+0x64/0x2e4
LR is at generic_file_buffered_write+0x17c/0x2b8
pc : [<c01fecf0>]    lr : [<c013a060>]    psr: 60000013
sp : c5b45ce8  ip : c5b45d48  fp : c5b45d44
r10: c05fbd00  r9 : 00000000  r8 : c7732210
r7 : c6eea000  r6 : 00001000  r5 : 00000600  r4 : 00000600
r3 : 00000000  r2 : c6604a00  r1 : 00000000  r0 : c6f88460
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387f  Table: 85bfc018  DAC: 00000015
Process tar (pid: 1779, stack limit = 0xc5b442e8)
Stack: (0xc5b45ce8 to 0xc5b46000)
5ce0:                   00001000 00000000 c5b45d14 c5b45d00 00000000 00000000
5d00: 00001000 00000000 c05fbd00 00000000 c5b44000 00000000 00000600 00000600
5d20: 00000600 00001000 00000000 c5b44000 00000000 00001000 c5b45dc4 c5b45d48
5d40: c013a060 c01fec98 00000600 00000600 c05fbd00 c016eb88 c6604a00 c5b45e90
5d60: c6f88460 c77322bc c03f3bf4 c7732210 c77322bc 00001000 00000000 c03f3bf4
5d80: c5b45f20 00000001 00001000 00000600 c016eb88 c05fbd00 4913d486 c7732284
5da0: c7732210 00000000 00000000 00001600 c5b45f20 c7732210 c5b45e44 c5b45dc8
5dc0: c013a808 c0139ef0 00000000 00000000 c5b45ee0 00001600 00000000 c012c128
5de0: c5b033e8 c5b45ee0 c5b45e90 c6f88460 c77322bc 00000000 c03e4e6c 00000001
5e00: c5b45e4c 22222222 22222222 22222222 22222222 00001600 c7732284 c7732284
5e20: c7732210 c5b45e90 c5b45f20 00000000 00000000 00000001 c5b45e84 c5b45e48
5e40: c013a8d4 c013a3ec c01725b8 c01703bc c6f88460 c77322bc c5b45e8c c5b45e90
5e60: c6f88460 c5b45f70 00001600 0005e200 c5b44000 00000004 c5b45f44 c5b45e88
5e80: c015cf54 c013a868 00000000 00000000 00000000 c5b45ed8 00000000 00000001
5ea0: ffffffff c6f88460 00000000 00000000 00000000 00000000 c793fae0 00000180
5ec0: 00000000 00000000 00000022 c793fae0 c0121e20 c5b45ed4 c5b45ed4 c761a238
5ee0: 00000000 00000000 c6cc801c 00000700 00000000 00000000 00001600 c02664ac
5f00: c78779c0 c0263638 c78a9414 00000000 00000000 c79ef8d8 c7926460 000200c2
5f20: 0005e200 00001600 00000000 c6f88460 0005e200 c5b45f70 c5b45f6c c5b45f48
5f40: c015d834 c015ceac 00000020 c7732210 00000000 00000000 c6f88460 00001600
5f60: c5b45fa4 c5b45f70 c015dcf4 c015d784 00000000 00000000 000000c1 00000000
5f80: 00000005 00001600 00001600 0005e200 00000004 c00eefc4 00000000 c5b45fa8
5fa0: c00eee40 c015dcbc 00001600 00001600 00000004 0005e200 00001600 00000010
5fc0: 00001600 00001600 0005e200 00000004 7fffe000 00062080 00000004 00000000
5fe0: 00000004 03fe6b38 0004518c 400f199c 60000010 00000004 00000000 00000000
Backtrace:
[<c01fec8c>] (jffs2_write_end+0x0/0x2e4) from [<c013a060>]
(generic_file_buffered_write+0x17c/0x2b8)
[<c0139ee4>] (generic_file_buffered_write+0x0/0x2b8) from [<c013a808>]
(__generic_file_aio_write_nolock+0x428/0x47c)
[<c013a3e0>] (__generic_file_aio_write_nolock+0x0/0x47c) from
[<c013a8d4>] (generic_file_aio_write+0x78/0xec)
[<c013a85c>] (generic_file_aio_write+0x0/0xec) from [<c015cf54>]
(do_sync_write+0xb4/0x104)
[<c015cea0>] (do_sync_write+0x0/0x104) from [<c015d834>] (vfs_write+0xbc/0x14c)
 r6:c5b45f70 r5:0005e200 r4:c6f88460
[<c015d778>] (vfs_write+0x0/0x14c) from [<c015dcf4>] (sys_write+0x44/0x70)
 r7:00001600 r6:c6f88460 r5:00000000 r4:00000000
[<c015dcb0>] (sys_write+0x0/0x70) from [<c00eee40>] (ret_fast_syscall+0x0/0x2c)
 r8:c00eefc4 r7:00000004 r6:0005e200 r5:00001600 r4:00001600
Code: 01a06001 0a000004 ea000002 e3a03000 (e5833000)
---[ end trace 51936947f0902144 ]---
Segmentation fault
root@overo:/media/mtdblock4#
