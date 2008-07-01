From: "Kamat, Nishant" <nskamat@ti.com>
Subject: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Tue, 1 Jul 2008 09:32:25 -0500
Message-ID: <DFEF307E035C8647B119E6A60DB62D4AE47475F8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:38871 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbYGAOcg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 10:32:36 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EWV0V013048
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:32:36 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m61EWPuK019795
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:32:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Nishant Kamat <nskamat@ti.com>

MTD: OMAP2-NAND: Fix partition reading from board info

The parse_mtd_partitions() function no longer returns
a negative error in case cmdline is not passed.
See commit: b0d06afb607

Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-ti.ldp/drivers/mtd/nand/omap2.c
===================================================================
--- linux-omap-ti.ldp.orig/drivers/mtd/nand/omap2.c     2008-06-30 22:01:50.000000000 +0530
+++ linux-omap-ti.ldp/drivers/mtd/nand/omap2.c  2008-06-30 22:03:34.446471469 +0530
@@ -699,7 +699,7 @@
        err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
        if (err > 0)
                add_mtd_partitions(&info->mtd, info->parts, err);
-       else if (err < 0 && pdata->parts)
+       else if (pdata->parts)
                add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
        else
 #endif
