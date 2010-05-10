From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: missing check for TLB valid entry
Date: Mon, 10 May 2010 12:16:06 +0300
Message-ID: <1273482972-5586-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28016 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0EJJQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:16:59 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

Added the missing TLB valid entry setting for cam register

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 4f63dc6..d29ebff 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -184,7 +184,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
 	if (!cr)
 		return ERR_PTR(-ENOMEM);
 
-	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
 	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
 
 	return cr;
-- 
1.7.1.rc1

