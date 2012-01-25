From: Orjan Friberg <of@flatfrog.com>
Subject: CONFIG_PREEMPT and JFFS2 oops
Date: Wed, 25 Jan 2012 21:12:03 +0100
Message-ID: <4F206213.9070704@flatfrog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------010702000403040806060201"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:51451
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751072Ab2AYURf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 15:17:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--------------010702000403040806060201
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With CONFIG_PREEMPT=y and hammering away on two different JFFS2 
partitions on a NAND flash I get an oops within ~10 seconds.  This is on 
a BeagleBoard xM (rev A2, with NAND).

I've boiled it down to whether CONFIG_PREEMPT (bug happens) or
CONFIG_PREEMPT_VOLUNTARY (bug doesn't happen) is selected.  Of course,
changing that affects a other things like inline spinlocking.  Turning 
on CONFIG_DEBUG_SPINLOCK reveals nothing.


By changing this option, I've made the bug go away in a 2.6.32 and
2.6.37 setup where it previously happened, and I've made it appear in a
2.6.39 setup where it previously didn't happen.


Pointers on what to look at next are appreciated.  (I've posted this on 
the mtd-utils mailing list too.)  More details below.


Thanks,
Orjan


The setup is simply two JFFS2-formatted partitions, and launching a

   while :; do dd if=/dev/zero of=file bs=800 count=1; done

on each of them.  Sometimes the oops trace originates from the garbage 
collector, sometimes the result is a JFFS2 decompress error.


-- 
Orjan Friberg
FlatFrog Laboratories AB

--------------010702000403040806060201
Content-Type: text/plain; name="jffs2_oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="jffs2_oops"

[   81.200805] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   81.217529] pgd = ce13c000
[   81.220855] [00000000] *pgd=8e172031, *pte=00000000, *ppte=00000000
[   81.236480] Internal error: Oops: 17 [#1] PREEMPT
[   81.241210] last sysfs file: /sys/kernel/uevent_seqnum
[   81.246368] Modules linked in: ftdi_sio usbserial
[   81.251129] CPU: 0    Not tainted  (2.6.32 #6)
[   81.255584] PC is at crc32_le+0x6c/0xf4
[   81.259460] LR is at jffs2_write_inode_range+0x2a0/0x420
[   81.264801] pc : [<c0211f28>]    lr : [<c01ae930>]    psr: 20000013
[   81.264801] sp : ce24bcd0  ip : 00000001  fp : ce11f840
[   81.276336] r10: 0000000c  r9 : ce5231d0  r8 : fffffffc
[   81.281585] r7 : 00000002  r6 : 00000000  r5 : c03fcf9c  r4 : 00000000
[   81.288146] r3 : 00000000  r2 : 00000008  r1 : 00000000  r0 : 00000000
[   81.294677] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   81.301849] Control: 10c5387d  Table: 8e13c019  DAC: 00000015
[   81.307617] Process dd (pid: 5270, stack limit = 0xce24a2f0)
[   81.313323] Stack: (0xce24bcd0 to 0xce24c000)
[   81.317687] bcc0:                                     00000000 00000002 00000003 00000000
[   81.325897] bce0: 00000000 c01ae930 ce24bd1c ce24bd18 00000000 00000008 00000000 00000000
[   81.334136] bd00: 00000000 00000002 cdca7000 ce1a8800 00000000 00000000 00000008 00000320
[   81.342346] bd20: 0001326c 00000000 00000320 00000000 ce11f840 ce523208 00000000 c07754e0
[   81.350555] bd40: 00000320 00000000 ce1a8800 c01a8ac4 00000000 00000320 ce24bd74 ffffffff
[   81.358764] bd60: 00000000 00000320 00000000 00000000 00000320 00000000 00000320 00000320
[   81.367004] bd80: 00000000 00000000 00000000 00000320 00000000 00000000 ce5232b0 c0097d1c
[   81.375213] bda0: 00000320 00000320 c07754e0 ce523208 ce24a000 cebf4140 ce5232b0 00001000
[   81.383422] bdc0: 00000000 c03efe38 ce24bf40 00000001 00000000 00000320 ce523208 c07754e0
[   81.391632] bde0: 00000320 00000320 00000000 00000320 ce523208 00000000 00000000 00000000
[   81.399871] be00: 00000000 c009846c 00000000 00000000 ce24bf00 00000320 00000000 00000000
[   81.408081] be20: 00000002 ce24bf00 ce24bf40 ce24beb0 cebf4140 ce5232b0 00000320 00000001
[   81.416290] be40: ce24a000 ce523278 000ad008 c03dd658 22222222 00000320 22222222 ce523278
[   81.424530] be60: ce24bf40 ce24beb0 00000001 00000000 cebf4140 00000000 000ad008 c009851c
[   81.432739] be80: ce24beb0 ce24bf40 00000000 00000000 ce24beb0 cebf4140 ce24bf80 ce24a000
[   81.440948] bea0: 000aad28 c00bf584 00000000 00000000 00020242 ce1ae000 00000000 00000001
[   81.449157] bec0: ffffffff cebf4140 00000000 00000000 00000000 00000000 ce12d6c0 00020241
[   81.457397] bee0: 00000000 00000000 00000200 ce12d6c0 c0077028 ce24bef4 ce24bef4 00000004
[   81.465606] bf00: 00000000 00000000 000aad28 00000300 00000000 00000000 00000320 00100073
[   81.473815] bf20: 000ad000 ce24a000 000ce000 00000000 00000002 ceb450e0 ce4b0618 00000001
[   81.482025] bf40: 000ad008 00000320 cebf4140 000ad008 ce24bf80 00000320 00000320 c00c01c8
[   81.490264] bf60: cebf4140 000ad008 00000000 00000000 cebf4140 00000320 000ad008 c00c036c
[   81.498474] bf80: 00000000 00000000 00000320 00000000 00000320 00000001 000ad008 00000004
[   81.506683] bfa0: c00390c4 c0038f40 00000320 00000001 00000001 000ad008 00000320 000acd34
[   81.514923] bfc0: 00000320 00000001 000ad008 00000004 00000320 000ad008 000aad28 000ad008
[   81.523132] bfe0: 4001e3e0 bece4b60 00010e34 40188abc 60000010 00000001 00000000 00000000
[   81.531372] [<c0211f28>] (crc32_le+0x6c/0xf4) from [<c01ae930>] (jffs2_write_inode_range+0x2a0/0x420)
[   81.540618] [<c01ae930>] (jffs2_write_inode_range+0x2a0/0x420) from [<c01a8ac4>] (jffs2_write_end+0x190/0x2d4)
[   81.550689] [<c01a8ac4>] (jffs2_write_end+0x190/0x2d4) from [<c0097d1c>] (generic_file_buffered_write+0x180/0x264)
[   81.561096] [<c0097d1c>] (generic_file_buffered_write+0x180/0x264) from [<c009846c>] (__generic_file_aio_write+0x468/0x4b0)
[   81.572265] [<c009846c>] (__generic_file_aio_write+0x468/0x4b0) from [<c009851c>] (generic_file_aio_write+0x68/0xc4)
[   81.582855] [<c009851c>] (generic_file_aio_write+0x68/0xc4) from [<c00bf584>] (do_sync_write+0xac/0xfc)
[   81.592285] [<c00bf584>] (do_sync_write+0xac/0xfc) from [<c00c01c8>] (vfs_write+0xac/0x1a4)
[   81.600677] [<c00c01c8>] (vfs_write+0xac/0x1a4) from [<c00c036c>] (sys_write+0x3c/0x68)
[   81.608734] [<c00c036c>] (sys_write+0x3c/0x68) from [<c0038f40>] (ret_fast_syscall+0x0/0x2c)
[   81.617218] Code: e2448004 e3a01000 e1a0c007 ea00000e (e7942001) 
[   82.040069] ---[ end trace 6a60d817de90299e ]---

--------------010702000403040806060201--
