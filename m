From: Guillaume Aubertin <g-aubertin@ti.com>
Subject: [PATCH] omap: iommu: fixing NULL pointer return value
Date: Fri, 21 Dec 2012 14:36:19 +0100
Message-ID: <1356096979-27698-1-git-send-email-g-aubertin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2LUNfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Dec 2012 08:35:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: lo <linux-omap@vger.kernel.org>, Guillaume Aubertin <g-aubertin@ti.com>

the returned NULL pointer is not detected by IS_ERR(), and then
de-referenced in the calling function, omap_iommu_attach_dev().

Signed-off-by: Guillaume Aubertin <g-aubertin@ti.com>
---
 drivers/iommu/omap-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index badc17c..a0fcad2 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -861,7 +861,7 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
 				(void *)name,
 				device_match_by_alias);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	obj = to_iommu(dev);
 
-- 
1.7.0.4

