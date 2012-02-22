From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/2] iommu/omap: fix NULL pointer dereference
Date: Wed, 22 Feb 2012 10:52:52 +0200
Message-ID: <1329900772-9306-2-git-send-email-ohad@wizery.com>
References: <1329900772-9306-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53774 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab2BVIxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 03:53:20 -0500
Received: by wics10 with SMTP id s10so4039781wic.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 00:53:19 -0800 (PST)
In-Reply-To: <1329900772-9306-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi Doyu <hdoyu@nvidia.com>

Fix this:

root@omap4430-panda:~# cat /debug/iommu/ducati/mem
[   62.725708] Unable to handle kernel NULL pointer dereference at virtual addre
ss 0000001c
[   62.725708] pgd = e6240000
[   62.737091] [0000001c] *pgd=a7168831, *pte=00000000, *ppte=00000000
[   62.743682] Internal error: Oops: 17 [#1] SMP
[   62.743682] Modules linked in: omap_iommu_debug omap_iovmm virtio_rpmsg_bus o
map_remoteproc remoteproc virtio_ring virtio mailbox_mach mailbox
[   62.743682] CPU: 0    Not tainted  (3.3.0-rc1-00265-g382f84e-dirty #682)
[   62.743682] PC is at debug_read_mem+0x5c/0xac [omap_iommu_debug]
[   62.743682] LR is at 0x1004
[   62.777832] pc : [<bf033178>]    lr : [<00001004>]    psr: 60000013
[   62.777832] sp : e72c7f40  ip : c0763c00  fp : 00000001
[   62.777832] r10: 00000000  r9 : 00000000  r8 : e72c7f80
[   62.777832] r7 : e6ffdc08  r6 : bed1ac78  r5 : 00001000  r4 : e7276000
[   62.777832] r3 : e60f3460  r2 : 00000000  r1 : e60f38c0  r0 : 00000000
[   62.777832] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   62.816375] Control: 10c53c7d  Table: a624004a  DAC: 00000015
[   62.816375] Process cat (pid: 1176, stack limit = 0xe72c62f8)
[   62.828369] Stack: (0xe72c7f40 to 0xe72c8000)
...
[   62.884185] [<bf033178>] (debug_read_mem+0x5c/0xac [omap_iommu_debug]) from [
<c010e354>] (vfs_read+0xac/0x130)
[   62.884185] [<c010e354>] (vfs_read+0xac/0x130) from [<c010e4a8>] (sys_read+0x
40/0x70)
[   62.884185] [<c010e4a8>] (sys_read+0x40/0x70) from [<c0014a00>] (ret_fast_sys
call+0x0/0x3c)

Fix also its 'echo bla > /debug/iommu/ducati/mem' Oops sibling, too.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
---
 drivers/iommu/omap-iommu-debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index bad9f9d..a2ab29e 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -274,7 +274,7 @@ static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
 	mutex_lock(&iommu_debug_lock);
 
 	area = omap_find_iovm_area(dev, (u32)ppos);
-	if (IS_ERR(area)) {
+	if (IS_ERR_OR_NULL(area)) {
 		bytes = -EINVAL;
 		goto err_out;
 	}
@@ -311,7 +311,7 @@ static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
 	}
 
 	area = omap_find_iovm_area(dev, (u32)ppos);
-	if (IS_ERR(area)) {
+	if (IS_ERR_OR_NULL(area)) {
 		count = -EINVAL;
 		goto err_out;
 	}
-- 
1.7.5.4

