From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 11/18] DSPBRIDGE: Do not panic on bad page count
Date: Wed, 16 Dec 2009 20:15:56 -0600
Message-ID: <1261016163-11091-12-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-10-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763924AbZLQCIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 21:08:49 -0500
In-Reply-To: <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If a page doesn't have a sane count, do not panic or release it.
Loudly complain with dump_stack but do not halt with BUG.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 65a21b2..f41763c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -301,7 +301,7 @@ static void bad_page_dump(u32 pa, struct page *pg)
 		current->comm, pg, (int)(2*sizeof(unsigned long)),
 		(unsigned long)pg->flags, pg->mapping,
 		page_mapcount(pg), page_count(pg));
-	BUG();
+	dump_stack();
 }
 
 /*
@@ -1707,9 +1707,10 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 						"COUNT 0 FOR PA 0x%x, size = "
 						"0x%x\n", pAddr, ulNumBytes);
 					bad_page_dump(pAddr, pg);
+				} else {
+					SetPageDirty(pg);
+					page_cache_release(pg);
 				}
-				SetPageDirty(pg);
-				page_cache_release(pg);
 				pAddr += HW_PAGE_SIZE_4KB;
 			}
 			if (HW_MMU_PteClear(pteAddrL2, vaCurr, pteSize)
@@ -1772,9 +1773,10 @@ skip_coarse_page:
 						"COUNT 0 FOR PA 0x%x, size = "
 						"0x%x\n", pAddr, ulNumBytes);
 					bad_page_dump(pAddr, pg);
+				} else {
+					SetPageDirty(pg);
+					page_cache_release(pg);
 				}
-				SetPageDirty(pg);
-				page_cache_release(pg);
 			}
 			pAddr += HW_PAGE_SIZE_4KB;
 		}
-- 
1.6.2.4

