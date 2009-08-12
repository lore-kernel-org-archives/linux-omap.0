From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] OMAP: iommu: fix wrong argument in flush_cache_vmap()
Date: Wed, 12 Aug 2009 15:12:00 +0300
Message-ID: <20090812121200.17601.61014.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61043 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbZHLMMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:12:08 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The second argument should be the end address, not the
length. Actually there will not be any effect on the behavior of this
driver since flush_cache_vmap() calls flush_cache_all() in the end.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 2fce2c1..6fc52fc 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -199,7 +199,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 		va += bytes;
 	}
 
-	flush_cache_vmap(new->addr, total);
+	flush_cache_vmap(new->addr, new->addr + total);
 	return new->addr;
 
 err_out:

