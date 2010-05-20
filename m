From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: Fix Memory leak
Date: Thu, 20 May 2010 19:59:52 +0530
Message-ID: <1274365792-24938-4-git-send-email-manjugk@ti.com>
References: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39944 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092Ab0ETOa1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 10:30:27 -0400
In-Reply-To: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Satish <x0124230@ti.com>, Tony Lindgren <tony@atomide.com>

From: Satish <x0124230@ti.com>

The memory allocated for sgt structure is not freed on error
when sg_alloc_table is called in sg_alloc_table().

Signed-off-by: Satish Kumar <x0124230@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index e43983b..8ce0de2 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -140,8 +140,10 @@ static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags)
 		return ERR_PTR(-ENOMEM);
 
 	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
-	if (err)
+	if (err) {
+		kfree(sgt);
 		return ERR_PTR(err);
+	}
 
 	pr_debug("%s: sgt:%p(%d entries)\n", __func__, sgt, nr_entries);
 
-- 
1.7.0.4

