From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC 0/2] mtd updates
Date: Mon, 23 Jan 2012 13:42:39 +0530
Message-ID: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57440 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab2AWIMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 03:12:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

This patch series does the following
Patch 1:
 
- Prevents the null pointer access
Also fixes the following crash
echo mem > /sys/power/state
[  263.507019] PM: Syncing filesystems ... done.
[  263.516876] PM: Preparing system for mem sleep
[  263.548065] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  263.578308] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[  263.609374] PM: Entering mem sleep
[  263.620361] Unable to handle kernel NULL pointer dereference at
virtual address 000000a0
[  263.628997] pgd = c7034000
[  263.631866] [000000a0] *pgd=87b9e831, *pte=00000000, *ppte=00000000
[  263.638580] Internal error: Oops: 17 [#1] SMP
[  263.643157] Modules linked in:
[  263.646392] CPU: 0    Tainted: G        W     (3.3.0-rc1-gda9a8ca #12)
[  263.653289] PC is at mtd_cls_suspend+0x8/0x20
[  263.657897] LR is at mtd_cls_suspend+0x8/0x20
[  263.662475] pc : [<c02e7804>]    lr : [<c02e7804>]    psr: a0000113
[  263.662506] sp : c7011e60  ip : 22222222  fp : c06e52a0
[  263.674591] r10: c06e5250  r9 : 00000000  r8 : c02e77fc
[  263.680084] r7 : 00000000  r6 : 00000000  r5 : 00000002  r4 : c7afec00
[  263.686950] r3 : c7afbac0  r2 : 00000000  r1 : 00000002  r0 : 00000000
[  263.693847] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  263.701354] Control: 10c5387d  Table: 87034019  DAC: 00000015
[  263.707397] Process sh (pid: 654, stack limit = 0xc70102f8)
[  263.713287] Stack: (0xc7011e60 to 0xc7012000)
[  263.717864] 1e60: 00000000 c02c2dc0 00000000 c7afec00 00000000
00000000 c7afec00 c0c47ed8
[  263.726501] 1e80: c7afec34 00000002 c06d0fc0 c02c32b8 c02c3464
0047325c c7afec00 c7afec00
[  263.735107] 1ea0: c0c47ed8 00000004 c06e5250 c02c33e0 c7001c00
00000002 60a157bf 0000003d
[  263.743743] 1ec0: 60a157bf 0000003d 00000002 c0710698 00000000
00000003 c06fb910 00000000
[  263.752349] 1ee0: c049bf78 c78019a0 00000002 c007fec8 00000003
c0587e94 00000000 00000004
[  263.760986] 1f00: 00000000 c049bf78 c78019a0 c0080264 c7bd3000
00000003 c0587e94 c007f008
[  263.769592] 1f20: c7b90aa0 c7b90ab8 c7011f80 c783e7a0 c02528b0
c02528c8 00000004 c0166cd4
[  263.778198] 1f40: c7bfb6e0 00000004 b6f88000 c7011f80 00000000
00000000 00000000 c01071b4
[  263.786834] 1f60: c0014280 c7b34240 c7bfb6e0 b6f88000 00000004
00000004 00000000 c0107308
[  263.795440] 1f80: 00000000 00000000 00000004 00000000 00000004
001f6e80 00000004 c0014328
[  263.804077] 1fa0: c7010000 c0014160 00000004 001f6e80 00000001
b6f88000 00000004 00000000
[  263.812683] 1fc0: 00000004 001f6e80 00000004 00000004 b6f88000
001fcfc8 b6f88000 00000002
[  263.821289] 1fe0: 00000000 be8895e0 000fded8 0000921c 60000010
00000001 00000000 00000000
[  263.829956] [<c02e7804>] (mtd_cls_suspend+0x8/0x20) from
[<c02c2dc0>] (legacy_suspend+0x30
/0x78)
[  263.839202] [<c02c2dc0>] (legacy_suspend+0x30/0x78) from
[<c02c32b8>] (__device_suspend+0x
2c8/0x30c)
[  263.848846] [<c02c32b8>] (__device_suspend+0x2c8/0x30c) from
[<c02c33e0>] (dpm_suspend+0x5
8/0x214)
[  263.858306] [<c02c33e0>] (dpm_suspend+0x58/0x214) from [<c007fec8>]
(suspend_devices_and_e
nter+0x78/0x2d8)
[  263.868499] [<c007fec8>] (suspend_devices_and_enter+0x78/0x2d8)
from [<c0080264>] (enter_s
tate+0x13c/0x17c)
[  263.878753] [<c0080264>] (enter_state+0x13c/0x17c) from
[<c007f008>] (state_store+0xd0/0x1
70)
[  263.887756] [<c007f008>] (state_store+0xd0/0x170) from [<c02528c8>]
(kobj_attr_store+0x18/
0x1c)
[  263.896942] [<c02528c8>] (kobj_attr_store+0x18/0x1c) from
[<c0166cd4>] (sysfs_write_file+0
xfc/0x180)
[  263.906585] [<c0166cd4>] (sysfs_write_file+0xfc/0x180) from
[<c01071b4>] (vfs_write+0xb0/0
x134)
[  263.915771] [<c01071b4>] (vfs_write+0xb0/0x134) from [<c0107308>]
(sys_write+0x40/0x70)
[  263.924224] [<c0107308>] (sys_write+0x40/0x70) from [<c0014160>]
(ret_fast_syscall+0x0/0x3
c)
[  263.933105] Code: e3a00000 e8bd8008 e92d4008 ebff57f9 (e59030a0)
[  263.939849] ---[ end trace 1b75b31a2719ed20 ]---

Patch 2:

- Currently mtd_suspend returns an error value -EOPNOTSUPP
if the suspend function is not implemented which prevents the
suspend. This patch prevents the nack of suspend if suspend
is not implemented


Shubhrajyoti D (2):
  mtd : Prevent the NULL pointer access
  mtd : Make the mtd_suspend return 0 if the suspend is not implemented

 drivers/mtd/mtdcore.c   |    5 +++--
 include/linux/mtd/mtd.h |    6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

