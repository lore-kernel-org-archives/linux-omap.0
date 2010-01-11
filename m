From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/3] omap iommu: fix incorrect address for supersection 1st entry
Date: Mon, 11 Jan 2010 09:46:35 +0200
Message-ID: <1263195995-23244-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61246 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0AKHrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 02:47:07 -0500
In-Reply-To: <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hnagalla@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index ccf25b3..ce0072a 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -667,7 +667,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
+			iopgd = iopgd_offset(obj, (da & IOSUPER_MASK));
 		}
 		bytes *= nent;
 	}
-- 
1.6.0.4

