From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 10/17] iommu/omap: Fix the permissions on nr_tlb_entries
Date: Tue, 30 Sep 2014 16:16:05 -0500
Message-ID: <1412111772-38006-11-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaI3VQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2014 17:16:27 -0400
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The permissions on the debugfs entry "nr_tlb_entries" should
have been octal, not decimal, so fix it.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 0fb92aa..a520438 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -256,7 +256,7 @@ static int iommu_debug_register(struct device *dev, void *data)
 		goto nomem;
 	parent = d;
 
-	d = debugfs_create_u8("nr_tlb_entries", 400, parent,
+	d = debugfs_create_u8("nr_tlb_entries", 0400, parent,
 			      (u8 *)&obj->nr_tlb_entries);
 	if (!d)
 		goto nomem;
-- 
2.1.0

