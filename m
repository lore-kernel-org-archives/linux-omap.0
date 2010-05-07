From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 4/5] omap iommu: Insert a gap page between IOVMAs against override
Date: Fri,  7 May 2010 09:56:03 +0300
Message-ID: <1273215364-15098-4-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32300 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab0EGG4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:56:40 -0400
In-Reply-To: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Inserting a gap page between IOVMAs could detect an override on other
IOVMA with iommu fault. This was originally suggested by Sakari Ailus
and based on the work and comment by David Cohen.

CC: David Cohen <david.cohen@nokia.com>
CC: Sakari Ailus <Sakari.Ailus@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 111fbca..b280766 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -255,16 +255,16 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 	prev_end = 0;
 	list_for_each_entry(tmp, &obj->mmap, list) {
 
-		if ((prev_end <= start) && (start + bytes < tmp->da_start))
+		if ((prev_end < start) && (start + bytes < tmp->da_start))
 			goto found;
 
 		if (flags & IOVMF_DA_ANON)
-			start = roundup(tmp->da_end, alignement);
+			start = roundup(tmp->da_end + 1, alignement);
 
 		prev_end = tmp->da_end;
 	}
 
-	if ((start >= prev_end) && (ULONG_MAX - start >= bytes))
+	if ((start > prev_end) && (ULONG_MAX - start >= bytes))
 		goto found;
 
 	dev_dbg(obj->dev, "%s: no space to fit %08x(%x) flags: %08x\n",
-- 
1.7.1.rc1

