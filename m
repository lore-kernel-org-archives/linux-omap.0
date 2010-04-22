From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 3/4][v4] OMAP:iommu - missing check for TLB valid entry
Date: Thu, 22 Apr 2010 18:26:10 -0500
Message-ID: <1271978771-26889-4-git-send-email-h-kanigeri2@ti.com>
References: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48695 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab0DVXIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 19:08:21 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MN8KsI004068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 18:08:20 -0500
In-Reply-To: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap <linux-omap@vger.kernel.org> Tony Lindgren
	<tony@atomide.com> Hiroshi Doyu" <Hiroshi.DOYU@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

Added the missing TLB valid entry setting for cam register

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 6f4b7cc..f01f985 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -183,7 +183,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
 	if (!cr)
 		return ERR_PTR(-ENOMEM);
 
-	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
 	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
 
 	return cr;
-- 
1.7.0

