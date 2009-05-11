From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] DSPBRIDGE: fix L2 pagetable alignment for DSP MMU
Date: Mon, 11 May 2009 07:55:12 +0300
Message-ID: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32347 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZEKEzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 00:55:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


The L2 pagetable should align on 1KB since the lower 10 bits of L2
pagetable address are not used by DSP H/W.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 2ab585d..5a858bd 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1080,8 +1080,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 		pPtAttrs->L2NumPages = ((DMMPOOLSIZE >> 20) + 6);
 		pPtAttrs->L2size = HW_MMU_COARSE_PAGE_SIZE *
 				   pPtAttrs->L2NumPages;
-		align_size = 4; /* Make it u32 aligned  */
-		/* we like to get aligned on L1 table size */
+		align_size = 1 << 10; /* L2 pagetable alignement */
 		pg_tbl_va = (u32)MEM_AllocPhysMem(pPtAttrs->L2size,
 			    align_size, &pg_tbl_pa);
 	pPtAttrs->L2TblAllocPa = pg_tbl_pa;
-- 
1.6.0.4

