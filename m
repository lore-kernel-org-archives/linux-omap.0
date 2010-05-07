From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/5] omap iommu: Exit iteration if no possibility of available area
Date: Fri,  7 May 2010 09:56:04 +0300
Message-ID: <1273215364-15098-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60127 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab0EGG4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:56:39 -0400
In-Reply-To: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Searching avaialable spaces should be stopped as soon as it turns out
that there's no possibility with the rest of it.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index b280766..feeb3f4 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -255,7 +255,10 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 	prev_end = 0;
 	list_for_each_entry(tmp, &obj->mmap, list) {
 
-		if ((prev_end < start) && (start + bytes < tmp->da_start))
+		if (prev_end >= start)
+			break;
+
+		if (start + bytes < tmp->da_start)
 			goto found;
 
 		if (flags & IOVMF_DA_ANON)
-- 
1.7.1.rc1

