From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] mtd: nand: omap2: fix error path
Date: Tue, 11 Sep 2012 11:58:54 +0530
Message-ID: <1347344934-28103-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39363 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2IKG3F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 02:29:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Let probe return error value if gpmc terminal
count interrupt could not be obtained

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
Hi,

My commit (now in l-o/devel-gpmc),

"bd4156f  mtd: nand: omap2: use gpmc provided irqs"

did not propogate error code properly due to
which this fix was required.

But this has not been mentioned in commit message
as it is not yet in mainline.

Regards
Afzal

 drivers/mtd/nand/omap2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 337cf0a..27293e3 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1404,6 +1404,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		info->gpmc_irq_count = platform_get_irq(pdev, 1);
 		if (info->gpmc_irq_count <= 0) {
 			dev_err(&pdev->dev, "error getting count irq\n");
+			err = -ENODEV;
 			goto out_release_mem_region;
 		}
 		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
-- 
1.7.0.4

