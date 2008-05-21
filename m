From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: MMC/SD cards hotplug scenario
Date: Wed, 21 May 2008 15:01:00 +0530
Message-ID: <005d01c8bb25$63345fe0$538918ac@ent.ti.com>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com> <20080521073017.GB23427@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005E_01C8BB53.7CEC9BE0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:48732 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569AbYEUJbc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2008 05:31:32 -0400
In-Reply-To: <20080521073017.GB23427@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: 'Pierre Ossman' <drzeus@drzeus.cx>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This is a multi-part message in MIME format.

------=_NextPart_000_005E_01C8BB53.7CEC9BE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Wednesday, May 21, 2008 1:00 PM
> To: Madhusudhan Chikkature Rajashekar
> Cc: 'Pierre Ossman'; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.arm.linux.org.uk
> Subject: Re: MMC/SD cards hotplug scenario
> 
> On Wed, May 21, 2008 at 11:42:04AM +0530, Madhusudhan 
> Chikkature Rajashekar wrote:
> > After the end of the I/O errors I can umount the partition that was
> > mounted and I reinsert the card.
> 
> That's rather expected - outstanding IO has to be errored when the
> medium is removed.
Yes. I got your point. But can this be made to through few I/O errors and stop instead of resulting in I/O errors for the rest of
the data?
In the case where data copied is huge, for eg 500MB, the I/O errors are quite lot.

> 
> > It seem not to work very well consistently.
> 
> Vague handwaving comment with no useful information.  What 
> precisely is
> the problem that you're seeing?
> 
What I meant here is that reinsertion of the card does not seem to result in reinitialization of the card consistently.

Details of few things I noticed is listed below stepwise and to start with card is detected and mounted on mount point /mnt/mmc dir.

1. Start copy of data.
2. Removed the card in the middle of transfer. At the controller driver level this generated card removed interrupt. The
mmc_detect_change fn called.
3. I/O Errors generated.
4. Reinsert the card. This generated card inserted interrupt. The mmc_detect_fn called. But the card does not seem to be
reinitialized correctly.
   cat /proc/partitions does not list mmc partitions.

The attached log shows that out of 3 trails, it seem to work fine correctly 2 times and failed the third time.

So my question is for the above scenario does the MMC/SD core need to take care of anything explicitely or should this be fixed at
the controller
driver level?

Regards,
Madhu

------=_NextPart_000_005E_01C8BB53.7CEC9BE0
Content-Type: text/plain;
	name="MMC-Hp-Log.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="MMC-Hp-Log.txt"

p -a =08 =08=08 =08=08 =08=08 =08=08 =08cp -a /etc/ /mnt/mmc/

 +++++++++++++++++++++++++++++ MMC CARD REMOVED =
+++++++++++++++++++++++++=20
mmc0: card 981b removed
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 3928
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 48
Buffer I/O error on device mmcblk0p1, logical block 4
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 16
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 24
Buffer I/O error on device mmcblk0p1, logical block 1
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
WARNING: at fs/buffer.c:1169 mark_buffer_dirty()
[<c0033400>] (dump_stack+0x0/0x14) from [<c00d21ac>] =
(mark_buffer_dirty+0x44/0xb8)
[<c00d2168>] (mark_buffer_dirty+0x0/0xb8) from [<c0108ae4>] =
(group_adjust_blocks+0x38/0x3c)
 r5:00000008 r4:00000000
[<c0108aac>] (group_adjust_blocks+0x0/0x3c) from [<c0109778>] =
(ext2_new_blocks+0x3fc/0x5cc)
[<c010937c>] (ext2_new_blocks+0x0/0x5cc) from [<c010d100>] =
(ext2_get_block+0x2bc/0x69c)
[<c010ce44>] (ext2_get_block+0x0/0x69c) from [<c00d2f70>] =
(__block_prepare_write+0x18c/0x414)
[<c00d2de4>] (__block_prepare_write+0x0/0x414) from [<c00d32e4>] =
(block_write_begin+0x90/0x108)
[<c00d3254>] (block_write_begin+0x0/0x108) from [<c010cdf4>] =
(__ext2_write_begin+0x3c/0x48)
[<c010cdb8>] (__ext2_write_begin+0x0/0x48) from [<c010ce3c>] =
(ext2_write_begin+0x3c/0x44)
[<c010ce00>] (ext2_write_begin+0x0/0x44) from [<c009185c>] =
(generic_file_buffered_write+0x10c/0x5f0)
[<c0091750>] (generic_file_buffered_write+0x0/0x5f0) from [<c0092168>] =
(__generic_file_aio_write_nolock+0x428/0x478)
[<c0091d40>] (__generic_file_aio_write_nolock+0x0/0x478) from =
[<c009222c>] (generic_file_aio_write+0x74/0xe8)
[<c00921b8>] (generic_file_aio_write+0x0/0xe8) from [<c00b08d0>] =
(do_sync_write+0xbc/0x10c)
[<c00b0814>] (do_sync_write+0x0/0x10c) from [<c00b11b8>] =
(vfs_write+0xb8/0x148)
[<c00b1100>] (vfs_write+0x0/0x148) from [<c00b1784>] =
(sys_write+0x44/0x70)
 r7:00001000 r6:c7c1ff20 r5:00000000 r4:00000000
[<c00b1740>] (sys_write+0x0/0x70) from [<c002ee60>] =
(ret_fast_syscall+0x0/0x2c)
 r8:c002f66c r7:00000004 r6:00000004 r5:be8aa148 r4:00001000
end_request: I/O error, dev mmcblk0, sector 1048592
Buffer I/O error on device mmcblk0p1, logical block 131072
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1048600
Buffer I/O error on device mmcblk0p1, logical block 131073
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1048608
Buffer I/O error on device mmcblk0p1, logical block 131074
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1048616
Buffer I/O error on device mmcblk0p1, logical block 131075
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1048624
Buffer I/O error on device mmcblk0p1, logical block 131076
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1048632
Buffer I/O error on device mmcblk0p1, logical block 131077
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1064976
end_request: I/O error, dev mmcblk0, sector 1064984
end_request: I/O error, dev mmcblk0, sector 1064992
end_request: I/O error, dev mmcblk0, sector 1065000
end_request: I/O error, dev mmcblk0, sector 1065008
end_request: I/O error, dev mmcblk0, sector 1065016
end_request: I/O error, dev mmcblk0, sector 1065024
end_request: I/O error, dev mmcblk0, sector 1065032
end_request: I/O error, dev mmcblk0, sector 1065040
end_request: I/O error, dev mmcblk0, sector 1065048
end_request: I/O error, dev mmcblk0, sector 1065056
end_request: I/O error, dev mmcblk0, sector 1065064
end_request: I/O error, dev mmcblk0, sector 1065072
end_request: I/O error, dev mmcblk0, sector 1065080
end_request: I/O error, dev mmcblk0, sector 1065088
end_request: I/O error, dev mmcblk0, sector 1065096

cp: cannot create regular file `/mnt/mmc/etc/init.d/mvltd': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/init.d/ssh': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/init.d/ppp': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/init.d/wu-ftpd': =
Input/EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 output error
Cannot read inode bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create directory `/mnt/mmc/etc/rc.d': Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/prelink.conf': =
Input/ouEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 tput error
Cannot read inode bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: EXT2-fs error (device mmcblk0p1): read_inode_bitmap: cannot create =
regular file `/mntCannot read inode bitmap - bloc
k_group =3D 4, inode_bitmap =3D 131073/mmc/etc/locale.alias': Input/ou
tput error
cp: cannot create directory `/mnt/mmc/etc/hotplug.d': Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/shells': Input/output =
eEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 rror
Cannot read inode bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/shells.conf': Input/ou
tCannot read inode bitmap - block_group =3D 4, inode_bitmap =3D =
131073put error


cp: cannot create regular file `/mnt/mmc/etc/ftpusers': =
Input/outputEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
  error
Cannot read inode bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/hosts.equiv': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create regular file `/mnt/mmc/etc/pam.conf': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 4, inode_bitmap =3D 131073
cp: cannot create directory `/mnt/mmc/etc/wu-ftpd': Input/output error
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
root@omap:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                94371840  73954940  20416900  79% /
/dev/root             94371840  73954940  20416900  79% /
tmpfs                    62816         0     62816   0% /tmp
/dev/root             94371840  73954940  20416900  79% /dev/.static/dev
none                     10240       792      9448   8% /dev
tmpfs                    62816         0     62816   0% /dev/shm
/dev/mmcblk0p1          976368       536    926236   1% /mnt/mmc
root@omap:~# umount /mnt/mmc
printk: 138 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D62192, block=3D131077
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D62113, block=3D131075
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D62081, block=3D131074
root@omap:~#=20
root@omap:~#=20
root@omap:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                94371840  73954940  20416900  79% /
/dev/root             94371840  73954940  20416900  79% /
tmpfs                    62816         0     62816   0% /tmp
/dev/root             94371840  73954940  20416900  79% /dev/.static/dev
none                     10240       792      9448   8% /dev
tmpfs                    62816         0     62816   0% /dev/shm
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
 +++++++++++++++++++++++++++++ MMC CARD INSERTED =
+++++++++++++++++++++++++=20
mmc0: host does not support reading read-only switch. assuming =
write-enable.
mmc0: new SD card at address 981b
mmcblk0: mmc0:981b SU01G 992000KiB=20
 mmcblk0: p1

root@omap:~#=20
root@omap:~#=20
root@omap:~# f



-bash: f: command not found
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
root@omap:~# mount /dev/mmcblk0p1 /mnt/mmc
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
root@omap:~#=20
root@omap:~#=20
root@omap:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                94371840  73954940  20416900  79% /
/dev/root             94371840  73954940  20416900  79% /
tmpfs                    62816         0     62816   0% /tmp
/dev/root             94371840  73954940  20416900  79% /dev/.static/dev
none                     10240       800      9440   8% /dev
tmpfs                    62816         0     62816   0% /dev/shm
/dev/mmcblk0p1          976368        20    926752   1% /mnt/mmc
root@omap:~#=20
root@omap:~#=20
root@omap:~# cp -a /etc/ /mnt/mmc/

 +++++++++++++++++++++++++++++ MMC CARD REMOVED =
+++++++++++++++++++++++++=20
mmc0: card 981b removed
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 3928
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 48
printk: 1 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 4
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 16
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 24
Buffer I/O error on device mmcblk0p1, logical block 1
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1572880
Buffer I/O error on device mmcblk0p1, logical block 196608
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572888
Buffer I/O error on device mmcblk0p1, logical block 196609
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572896
Buffer I/O error on device mmcblk0p1, logical block 196610
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572904
Buffer I/O error on device mmcblk0p1, logical block 196611
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572912
Buffer I/O error on device mmcblk0p1, logical block 196612
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572920
Buffer I/O error on device mmcblk0p1, logical block 196613
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572928
Buffer I/O error on device mmcblk0p1, logical block 196614
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572936
end_request: I/O error, dev mmcblk0, sector 1572944
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1622032
end_request: I/O error, dev mmcblk0, sector 1622040
end_request: I/O error, dev mmcblk0, sector 1622048
end_request: I/O error, dev mmcblk0, sector 1622056
end_request: I/O error, dev mmcblk0, sector 1622064
end_request: I/O error, dev mmcblk0, sector 1622072
end_request: I/O error, dev mmcblk0, sector 1622080
end_request: I/O error, dev mmcblk0, sector 1622088
end_request: I/O error, dev mmcblk0, sector 1622096
end_request: I/O error, dev mmcblk0, sector 1622104
end_request: I/O error, dev mmcblk0, sector 1622112
end_request: I/O error, dev mmcblk0, sector 1622120
end_request: I/O error, dev mmcblk0, sector 1622128
end_request: I/O error, dev mmcblk0, sector 1622136
end_request: I/O error, dev mmcblk0, sector 1622144
end_request: I/O error, dev mmcblk0, sector 1622152
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1572888
mmcblk0: error -110 sending read/write command

cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/squid.conf': Input/out
pCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609ut =
error

cp: cannot create regular file `/mnt/mmc/etc/watchdog.conf': =
Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/syslog.conf': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/inittab': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/ypserv.conf': Input/ou
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put error

cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/wgetrc': Input/output=20
eCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609rror

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/cron.d': Input/output err
oCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609r

cp: cannot create directory `/mnt/mmc/etc/cron.hourly': =
Input/outputEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
  error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ypserv.securenets': =
InpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut/output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/nsswitch.conf.nis': =
InpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut/output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/yp.conf': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/checksecurity.conf': I
nCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put/output error

cp: cannot create directory `/mnt/mmc/etc/cron.monthly': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create directory `/mnt/mmc/etc/security': Input/output =
erEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ror
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/crontab': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/login.access': Input/o
uCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609tput error

cp: cannot create regular file `/mnt/mmc/etc/environment': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/limits': Input/output =
eEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 rror
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/email-addresses': Inpu
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609/output error

cp: cannot create regular file `/mnt/mmc/etc/login.defs': =
Input/outpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/securetty': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/anacrontab': =
Input/outpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/aliases': Input/output
 Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609error

cp: cannot create directory `/mnt/mmc/etc/exim': Input/output =
errorEXT2-fs error (device mmcblk0p1): read_inode_bitmap:=20
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ftpchroot': =
Input/outpuEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 t error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ftpusers': =
Input/outputEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
  error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/hosts.equiv': Input/ou
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put error

cp: cannot create regular file `/mnt/mmc/etc/pam.conf': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create directory `/mnt/mmc/etc/wu-ftpd': Input/output error
root@omap:~#=20
root@omap:~#=20
root@omap:~# umount /mnt/mmc
printk: 119 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D93121, block=3D196610
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
 +++++++++++++++++++++++++++++ MMC CARD INSERTED =
+++++++++++++++++++++++++=20
mmc0: host does not support reading read-only switch. assuming =
write-enable.
mmc0: new SD card at address 981b
mmcblk0: mmc0:981b SU01G 992000KiB=20
 mmcblk0: p1

root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
root@omap:~# mount /dev/mmcblk0 =08 =08p1 /mnt/mmc
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
root@omap:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                94371840  73954976  20416864  79% /
/dev/root             94371840  73954976  20416864  79% /
tmpfs                    62816         0     62816   0% /tmp
/dev/root             94371840  73954976  20416864  79% /dev/.static/dev
none                     10240       800      9440   8% /dev
tmpfs                    62816         0     62816   0% /dev/shm
/dev/mmcblk0p1          976368        20    926752   1% /mnt/mmc
root@omap:~# cp -a /etc/ /mnt/mmc/

 +++++++++++++++++++++++++++++ MMC CARD REMOVED =
+++++++++++++++++++++++++=20
mmc0: card 981b removed
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 3928
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 48
Buffer I/O error on device mmcblk0p1, logical block 4
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 16
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 24
Buffer I/O error on device mmcblk0p1, logical block 1
lost page write due to I/O error on mmcblk0p1
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1572880
Buffer I/O error on device mmcblk0p1, logical block 196608
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572888
Buffer I/O error on device mmcblk0p1, logical block 196609
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572896
Buffer I/O error on device mmcblk0p1, logical block 196610
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572904
Buffer I/O error on device mmcblk0p1, logical block 196611
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572912
Buffer I/O error on device mmcblk0p1, logical block 196612
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572920
Buffer I/O error on device mmcblk0p1, logical block 196613
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572928
Buffer I/O error on device mmcblk0p1, logical block 196614
lost page write due to I/O error on mmcblk0p1
end_request: I/O error, dev mmcblk0, sector 1572936
end_request: I/O error, dev mmcblk0, sector 1572944
end_request: I/O error, dev mmcblk0, sector 1572952
mmcblk0: error -110 sending read/write command
end_request: I/O error, dev mmcblk0, sector 1622032
end_request: I/O error, dev mmcblk0, sector 1622040
end_request: I/O error, dev mmcblk0, sector 1622048
end_request: I/O error, dev mmcblk0, sector 1622056
end_request: I/O error, dev mmcblk0, sector 1622064
end_request: I/O error, dev mmcblk0, sector 1622072
end_request: I/O error, dev mmcblk0, sector 1622080
end_request: I/O error, dev mmcblk0, sector 1622088
end_request: I/O error, dev mmcblk0, sector 1622096
end_request: I/O error, dev mmcblk0, sector 1622104
end_request: I/O error, dev mmcblk0, sector 1622112
end_request: I/O error, dev mmcblk0, sector 1622120
end_request: I/O error, dev mmcblk0, sector 1622128
end_request: I/O error, dev mmcblk0, sector 1622136
end_request: I/O error, dev mmcblk0, sector 1622144
end_request: I/O error, dev mmcblk0, sector 1622152
mmcblk0: error -110 sending read/write command

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/udhcpc': Input/output err
oCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609r

cp: cannot create directory `/mnt/mmc/etc/dnrd': Input/output =
errorEXT2-fs error (device mmcblk0p1): read_inode_bitmap:=20
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/sysctl.conf': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/auto.master': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/auto.misc': Input/outp
uCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609t =
error

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/devfs': Input/output erro
rCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/pcmcia': Input/output err
oCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609r

cp: cannot create directory `/mnt/mmc/etc/cups': Input/output =
errorEXT2-fs error (device mmcblk0p1): read_inode_bitmap:=20
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/dhcpd.conf': Input/out
pCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609ut =
error

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/discover.d': Input/output
 Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609error

cp: cannot create regular file `/mnt/mmc/etc/nscd.conf': =
Input/outpuEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 t error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/mime.conf.default': =
InpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut/output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/hostapd.accept': =
Input/EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/hostapd.conf': =
Input/ouEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 tput error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/hostapd.deny': =
Input/ouEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 tput error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/memstat.conf': =
Input/ouEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 tput error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/modprobe.conf': =
Input/oEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 utput error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/modprobe.devfs': =
Input/EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/modules': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/inetd.conf': Input/out
pCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609ut =
error

cp: cannot create regular file `/mnt/mmc/etc/identd.conf': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/radvd.conf': =
Input/outpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/mime.conf': =
Input/outpuEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 t error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/squid.conf.default': I
nCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put/output error

cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/squid.conf': Input/out
pCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609ut =
error

cp: cannot create regular file `/mnt/mmc/etc/watchdog.conf': =
Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/syslog.conf': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/inittab': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/ypserv.conf': Input/ou
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put error

cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/wgetrc': Input/output=20
eCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609rror

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/cron.d': Input/output err
oCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609r

cp: cannot create directory `/mnt/mmc/etc/cron.hourly': =
Input/outputEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
  error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ypserv.securenets': =
InpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut/output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/nsswitch.conf.nis': =
InpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut/output error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/yp.conf': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/checksecurity.conf': I
nCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609put/output error

cp: cannot create directory `/mnt/mmEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: c/etc/cron.monthly': Input/outp
uCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609t =
error

cp: cannot create directory `/mnt/mmc/etc/security': Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/crontab': Input/output =
EXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/login.access': =
Input/ouEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 tput error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/environment': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/limits': Input/output =
eEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 rror
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/email-addresses': Inpu
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609/output error

cp: cannot create regular file `/mnt/mmc/etc/login.defs': =
Input/outpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/securetty': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/anacrontab': =
Input/outpEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 ut error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/aliases': Input/output
 Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D =
196609error

cp: cannot create directory `/mnt/mmc/etc/exim': Input/output error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ftpchroot': Input/output =
error
EXT2-fs error (device mmcblk0p1): read_inode_bitmap: Cannot read inode =
bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/ftpusers': =
Input/outputEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
  error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mnt/mmc/etc/hosts.equiv': =
Input/outEXT2-fs error (device mmcblk0p1): read_inode_bitmap:
 put error
Cannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609
cp: cannot create regular file `/mntEXT2-fs error (device mmcblk0p1): =
read_inode_bitmap: /mmc/etc/pam.conf': Input/outpu
tCannot read inode bitmap - block_group =3D 6, inode_bitmap =3D 196609 =
error

cp: cannot create directory `/mnt/mmc/etc/wu-ftpd': Input/output error
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
root@omap:~#=20
root@omap:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                94371840  73954976  20416864  79% /
/dev/root             94371840  73954976  20416864  79% /
tmpfs                    62816         0     62816   0% /tmp
/dev/root             94371840  73954976  20416864  79% /dev/.static/dev
none                     10240       792      9448   8% /dev
tmpfs                    62816         0     62816   0% /dev/shm
/dev/mmcblk0p1          976368       872    925900   1% /mnt/mmc
root@omap:~# umount /mnt/mmc
printk: 124 messages suppressed.
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D93369, block=3D196617
Buffer I/O error on device mmcblk0p1, logical block 0
lost page write due to I/O error on mmcblk0p1
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D93367, block=3D196617
EXT2-fs error (device mmcblk0p1): ext2_get_inode: unable to read inode =
block - inode=3D93121, block=3D196610
root@omap:~#=20
 +++++++++++++++++++++++++++++ MMC CARD INSERTED =
+++++++++++++++++++++++++=20

root@omap:~#=20
root@omap:~# cat /proc/partitions=20
major minor  #blocks  name

  31     0        256 mtdblock0
  31     1        256 mtdblock1
  31     2       2048 mtdblock2
  31     3     128512 mtdblock3
  31     4        512 mtdblock4
  31     5        512 mtdblock5
  31     6        256 mtdblock6
  31     7       4096 mtdblock7
  31     8     125696 mtdblock8
  31     9        512 mtdblock9
  31    10        256 mtdblock10
  31    11        128 mtdblock11
  31    12       2048 mtdblock12
  31    13     259200 mtdblock13
root@omap:~# 
------=_NextPart_000_005E_01C8BB53.7CEC9BE0--

