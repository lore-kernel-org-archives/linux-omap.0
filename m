From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 09/11] iommu: omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:08 +0530
Message-ID: <1340372890-10091-10-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42164 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762184Ab2FVNsh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:48:37 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the iommu clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e70ee2b..fa72372 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -923,6 +923,7 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
 	if (IS_ERR(obj->clk))
 		goto err_clk;
+	clk_prepare(obj->clk);
 
 	obj->nr_tlb_entries = pdata->nr_tlb_entries;
 	obj->name = pdata->name;
@@ -974,6 +975,7 @@ err_irq:
 err_ioremap:
 	release_mem_region(res->start, resource_size(res));
 err_mem:
+	clk_unprepare(obj->clk);
 	clk_put(obj->clk);
 err_clk:
 	kfree(obj);
-- 
1.7.1

