From: Daniel Walker <dwalker@fifo99.com>
Subject: [PATCH] arm: omap: iovmm: add missing mutex_unlock
Date: Sat, 26 Sep 2009 14:37:19 -0700
Message-ID: <1254001039-27976-1-git-send-email-dwalker@fifo99.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fifo99.com ([67.223.236.141]:56645 "EHLO fifo99.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbZIZVhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Sep 2009 17:37:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Daniel Walker <dwalker@fifo99.com>, Julia Lawall <julia@diku.dk>, Kevin Hilman <khilman@deeprooted.net>, Tony Lindgren <tony@atomide.com>

I was using Coccinelle with the mutex_unlock semantic patch, and it
unconvered this problem. It appears to be a valid missing unlock issue.
This change should correct it by moving the unlock below the label.

This patch is against the mainline kernel.

Cc: Julia Lawall <julia@diku.dk>
Cc: Kevin Hilman <khilman@deeprooted.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 arch/arm/plat-omap/iovmm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 57f7122..9b6cb90 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -363,8 +363,9 @@ void *da_to_va(struct iommu *obj, u32 da)
 		goto out;
 	}
 	va = area->va;
-	mutex_unlock(&obj->mmap_lock);
 out:
+	mutex_unlock(&obj->mmap_lock);
+
 	return va;
 }
 EXPORT_SYMBOL_GPL(da_to_va);
-- 
1.6.0.4

