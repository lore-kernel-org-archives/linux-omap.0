From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 02/17] iommu/omap: Remove unused isr_priv field from omap_iommu
Date: Wed, 22 Oct 2014 17:22:20 -0500
Message-ID: <1414016555-28067-3-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49941 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933498AbaJVWWx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:53 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The isr_priv field is a left-over from before the IOMMU API
adaptation, this was used to store the callback data. This is
no longer relevant, so remove it.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 5c14000..18a0f3a 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -30,7 +30,6 @@ struct omap_iommu {
 	const char	*name;
 	void __iomem	*regbase;
 	struct device	*dev;
-	void		*isr_priv;
 	struct iommu_domain *domain;
 
 	spinlock_t	iommu_lock;	/* global for this whole object */
-- 
2.1.0

