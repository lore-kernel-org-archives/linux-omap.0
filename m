From: "Premi, Sanjeev" <premi@ti.com>
Subject: Oops in MMC
Date: Tue, 2 Dec 2008 17:17:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYLBLr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 06:47:59 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB2Blqwa029227
	for <linux-omap@vger.kernel.org>; Tue, 2 Dec 2008 05:47:58 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mB2BlodG028212
	for <linux-omap@vger.kernel.org>; Tue, 2 Dec 2008 17:17:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was trying to mount the filesystem from MMC card on OMAP3EVM.
Came across this oops.

However, when I boot via ramdisk/NFS and mount /dev/mmcblk0p2; there is no oops.

Anything missing in the configuration?

Here is my snapshot menuconfig:
   --- MMC/SD/SDIO card support
   *** MMC/SD/SDIO Card Drivers ***
    <*>   MMC block device driver
    [*]     Use bounce buffer for simple hosts
    <*>   TI OMAP High Speed Multimedia Card Interface support

Also:
# git-show --pretty=oneline
5019ed843f3208482c64043e4052e89b3d5462a0 sync isp1301_omap with mainlne

Best regards,
Sanjeev

Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting system logger: <1>Unhandled fault: external abort on non-linefetch (0x1808) at 0xd809c104
Unhandled fault: external abort on non-linefetch (0x1808) at 0xd809c104
Internal error: : 1808 [#1]
Internal error: : 1808 [#1]
Modules linked in:Modules linked in:

CPU: 0    Not tainted  (2.6.27-omap1-00099-g13446fc-dirty #111)
CPU: 0    Not tainted  (2.6.27-omap1-00099-g13446fc-dirty #111)
PC is at omap_mmc_request+0x64/0x264
PC is at omap_mmc_request+0x64/0x264
LR is at mmc_wait_for_req+0xf0/0x108
LR is at mmc_wait_for_req+0xf0/0x108
pc : [<c01fc2b0>]    lr : [<c01f5a2c>]    psr: a0000013
sp : c7a97dc8  ip : c7a97e18  fp : c7a97e14
pc : [<c01fc2b0>]    lr : [<c01f5a2c>]    psr: a0000013
sp : c7a97dc8  ip : c7a97e18  fp : c7a97e14
r10: 00000000  r9 : 00000000  r8 : c7ac3d30
r10: 00000000  r9 : 00000000  r8 : c7ac3d30
r7 : c7a97e58  r6 : c7ac2400  r5 : c7ac2400  r4 : c7ac25c0
r7 : c7a97e58  r6 : c7ac2400  r5 : c7ac2400  r4 : c7ac25c0
r3 : 00080200  r2 : 00000008  r1 : d809c000  r0 : c7ac2400
r3 : 00080200  r2 : 00000008  r1 : d809c000  r0 : c7ac2400
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 87b20018  DAC: 00000017
Control: 00c5387f  Table: 87b20018  DAC: 00000017
Process mmcqd (pid: 289, stack limit = 0xc7a962e0)
Process mmcqd (pid: 289, stack limit = 0xc7a962e0)
Stack: (0xc7a97dc8 to 0xc7a98000)
Stack: (0xc7a97dc8 to 0xc7a98000)
7dc0: 7dc0:                                     c7ac3d30 c7ac3d30 00000400 00000400 c7a97e04 c7a97e04 c7a97de0 c7a97de0 c0158798 c0158798 c01586c8 c01586c8

7de0: 7de0: 00000000 00000000 c78b5800 c78b5800 00000000 00000000 c7a97e58 c7a97e58 00000000 00000000 c7ac2400 c7ac2400 c7aa3200 c7aa3200 c7ac3d30 c7ac3d30

7e00: 7e00: 00000000 00000000 00000000 00000000 c7a97e44 c7a97e44 c7a97e18 c7a97e18 c01f5a2c c01f5a2c c01fc258 c01fc258 c7a97e44 c7a97e44 00000000 00000000

7e20: 7e20: c7a97e20 c7a97e20 c7a97e20 c7a97e20 c7a97ec4 c7a97ec4 c7a97ec4 c7a97ec4 c7ac3d30 c7ac3d30 c7a9a424 c7a9a424 c7a97fb4 c7a97fb4 c7a97e48 c7a97e48

7e40: 7e40: c01fab74 c01fab74 c01f5948 c01f5948 165c5fcb 165c5fcb c7a9a420 c7a9a420 00000001 00000001 00000011 00000011 c7a97e6c c7a97e6c c7a97ec4 c7a97ec4

7e60: 7e60: c7a97e98 c7a97e98 c7a97e1c c7a97e1c c01f5ac0 c01f5ac0 00000012 00000012 00692b0b 00692b0b 00000000 00000000 00000000 00000000 00000000 00000000

7e80: 7e80: 00000000 00000000 000000b5 000000b5 00000000 00000000 00000000 00000000 c7a97ec4 c7a97ec4 c7a97e58 c7a97e58 0000000c 0000000c 00000000 00000000

7ea0: 7ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000049d 0000049d 00000000 00000000 00000000 00000000 00000000 00000000

7ec0: 7ec0: c7a97e58 c7a97e58 05f5e100 05f5e100 00000000 00000000 00000200 00000200 00000008 00000008 00000000 00000000 00000200 00000200 00000000 00000000

7ee0: 7ee0: c7a97e98 c7a97e98 c7a97e58 c7a97e58 00000001 00000001 c7aa1a20 c7aa1a20 c7ac3d30 c7ac3d30 c7ac3d74 c7ac3d74 c78713a0 c78713a0 00000000 00000000

7f00: 7f00: c7a97f24 c7a97f24 c7a97f10 c7a97f10 c0157728 c0157728 c016a414 c016a414 c7ac3d30 c7ac3d30 c78713bc c78713bc c7a97f44 c7a97f44 c7a97f28 c7a97f28

7f20: 7f20: c7a97f44 c7a97f44 c7a97f30 c7a97f30 c01577dc c01577dc c0156380 c0156380 c78713a0 c78713a0 c7ac3d30 c7ac3d30 c7a97f6c c7a97f6c c7a97f48 c7a97f48

7f40: 7f40: c015ff48 c015ff48 c01577c0 c01577c0 c7a96000 c7a96000 c7ac5398 c7ac5398 c78713a0 c78713a0 00000000 00000000 c7ac3d30 c7ac3d30 00000001 00000001

7f60: 7f60: c7a97f94 c7a97f94 c7a97f70 c7a97f70 c0160740 c0160740 c015fe60 c015fe60 c7a9a424 c7a9a424 c78ba918 c78ba918 c7a96000 c7a96000 c7a9a42c c7a9a42c

7f80: 7f80: c7ac3d30 c7ac3d30 c78ba918 c78ba918 c7a97fb4 c7a97fb4 c7a9a424 c7a9a424 c7ac3d30 c7ac3d30 c7a96000 c7a96000 c7a9a42c c7a9a42c c78ba918 c78ba918

7fa0: 7fa0: 00000000 00000000 00000000 00000000 c7a97fdc c7a97fdc c7a97fb8 c7a97fb8 c01fb5c4 c01fb5c4 c01fa9ac c01fa9ac c7a9a424 c7a9a424 c01fb510 c01fb510

7fc0: 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c7a97ff4 c7a97ff4 c7a97fe0 c7a97fe0 c00649a8 c00649a8 c01fb51c c01fb51c

7fe0: 7fe0: 00000000 00000000 00000000 00000000 00000000 00000000 c7a97ff8 c7a97ff8 c0054770 c0054770 c0064960 c0064960 0cfbce10 0cfbce10 0077eea1 0077eea1

Backtrace: Backtrace:

[<c01fc24c>] [<c01fc24c>] (omap_mmc_request+0x0/0x264) (omap_mmc_request+0x0/0x264) from [<c01f5a2c>] from [<c01f5a2c>] (mmc_wait_for_req+0xf0/0x108)
(mmc_wait_for_req+0xf0/0x108)
[<c01f593c>] [<c01f593c>] (mmc_wait_for_req+0x0/0x108) (mmc_wait_for_req+0x0/0x108) from [<c01fab74>] from [<c01fab74>] (mmc_blk_issue_rq+0x1d4/0x560)
(mmc_blk_issue_rq+0x1d4/0x560)
 r6:c7a9a424 r6:c7a9a424 r5:c7ac3d30 r5:c7ac3d30 r4:c7a97ec4 r4:c7a97ec4

[<c01fa9a0>] [<c01fa9a0>] (mmc_blk_issue_rq+0x0/0x560) (mmc_blk_issue_rq+0x0/0x560) from [<c01fb5c4>] from [<c01fb5c4>] (mmc_queue_thread+0xb4/0xdc)
(mmc_queue_thread+0xb4/0xdc)
[<c01fb510>] [<c01fb510>] (mmc_queue_thread+0x0/0xdc) (mmc_queue_thread+0x0/0xdc) from [<c00649a8>] from [<c00649a8>] (kthread+0x54/0x80)
(kthread+0x54/0x80)
 r9:00000000 r9:00000000 r8:00000000 r8:00000000 r7:00000000 r7:00000000 r6:00000000 r6:00000000 r5:c01fb510 r5:c01fb510
r4:c7a9a424
r4:c7a9a424

[<c0064954>] [<c0064954>] (kthread+0x0/0x80) (kthread+0x0/0x80) from [<c0054770>] from [<c0054770>] (do_exit+0x0/0x6b8)
(do_exit+0x0/0x6b8)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000

Code: Code: 0a000076 0a000076 e593200c e593200c e5933008 e5933008 e1833802 e1833802 (e5813104) (e5813104)

<4>---[ end trace b5f4aa4005b441fc ]---
---[ end trace b5f4aa4005b441fc ]---
