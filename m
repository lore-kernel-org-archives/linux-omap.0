From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 15/17] iommu/omap: Reset the domain field upon detaching
Date: Wed, 22 Oct 2014 17:22:33 -0500
Message-ID: <1414016555-28067-16-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49939 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933477AbaJVWWt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:49 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The .domain field in omap_iommu struct is set properly when the
OMAP IOMMU device is attached to, but is never reset properly
on detach. Reset this properly so that the OMAP IOMMU debugfs
logic can depend on this field before allowing the debugfs
operations.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3dcaef0..2ba3219 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1206,6 +1206,7 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 
 	omap_domain->iommu_dev = arch_data->iommu_dev = NULL;
 	omap_domain->dev = NULL;
+	oiommu->domain = NULL;
 }
 
 static void omap_iommu_detach_dev(struct iommu_domain *domain,
-- 
2.1.0

