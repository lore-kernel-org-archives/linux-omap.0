From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v4-rebased 7/7] iommu/core: remove the temporary pgsize settings
Date: Thu, 10 Nov 2011 11:32:31 +0200
Message-ID: <1320917551-11328-8-git-send-email-ohad@wizery.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62384 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934094Ab1KJJde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 04:33:34 -0500
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>

Now that all IOMMU drivers are exporting their supported pgsizes,
we can remove the default pgsize settings in register_iommu().

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b278458..84cdd8a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -49,16 +49,6 @@ int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops)
 	if (bus->iommu_ops != NULL)
 		return -EBUSY;
 
-	/*
-	 * Set the default pgsize values, which retain the existing
-	 * IOMMU API behavior: drivers will be called to map
-	 * regions that are sized/aligned to order of 4KiB pages.
-	 *
-	 * This will be removed once all drivers are migrated.
-	 */
-	if (!ops->pgsize_bitmap)
-		ops->pgsize_bitmap = ~0xFFFUL;
-
 	bus->iommu_ops = ops;
 
 	/* Do IOMMU specific setup for this bus-type */
-- 
1.7.5.4

