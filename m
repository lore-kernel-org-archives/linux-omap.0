From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: Insert a gap page between IOVMAs against override
Date: Mon, 10 May 2010 12:16:10 +0300
Message-ID: <1273482972-5586-7-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28054 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab0EJJRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:17:07 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Cohen <david.cohen@nokia.com>, Sakari Ailus <Sakari.Ailus@nokia.com>

Inserting a gap page between IOVMAs could detect an override on other
IOVMA with iommu fault. This was originally suggested by Sakari Ailus
and based on the work and comment by David Cohen.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: David Cohen <david.cohen@nokia.com>
Cc: Sakari Ailus <Sakari.Ailus@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 65c6d1f..5afe013 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -287,16 +287,16 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
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

