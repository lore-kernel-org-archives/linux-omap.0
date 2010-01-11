From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/3] omap iommu: fix incorrect address for large page 1st entry
Date: Mon, 11 Jan 2010 09:46:34 +0200
Message-ID: <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61380 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0AKHrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 02:47:22 -0500
In-Reply-To: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hnagalla@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Reported-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm/plat-omap/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index c0ff1e3..ccf25b3 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: tlb and pagetable primitives
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
@@ -646,7 +646,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if (*iopte & IOPTE_LARGE) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopte = (u32 *)((u32)iopte & IOLARGE_MASK);
+			iopte = iopte_offset(iopgd, (da & IOLARGE_MASK));
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
-- 
1.6.0.4

