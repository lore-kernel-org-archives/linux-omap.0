From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/7] DSPBRIDGE: Allow separate load/run addresses for Dynamic Loader
Date: Wed, 17 Jun 2009 12:36:07 -0500
Message-ID: <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58457 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650AbZFQRbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 13:31:35 -0400
In-Reply-To: <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Fernando Guzman Lugo <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

Allow separate load/run addresses for Dynamic Loader.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/dbll.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 82430a3..5e58e80 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1313,6 +1313,7 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 	s32 req = -1;
 	s32 count = 0;
 	u32 allocSize = 0;
+	u32 runAddrFlag = 0;
 
 	DBC_Require(this != NULL);
 	lib = pAlloc->lib;
@@ -1357,10 +1358,9 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
                        if (strcmp(szSecLastToken, "DYN_SARAM") == 0) {
 				segId = 1;
 			} else {
-                               if (strcmp(szSecLastToken,
-				   "DYN_EXTERNAL") == 0) {
+				if (strcmp(szSecLastToken,
+				   "DYN_EXTERNAL") == 0)
 					segId = 2;
-				}
 			}
 		}
 		if (segId != -1) {
@@ -1381,6 +1381,11 @@ func_cont:
 		allocSize = info->size + GEM_L1P_PREFETCH_SIZE;
 	else
 		allocSize = info->size;
+	GT_2trace(DBLL_debugMask, GT_5CLASS,
+			 "Beg info->run_addr = 0x%x, info->load_addr= 0x%x\n",
+			 info->run_addr, info->load_addr);
+	if (info->load_addr != info->run_addr)
+		runAddrFlag = 1;
 	/* TODO - ideally, we can pass the alignment requirement also
 	 * from here */
 	if (lib != NULL) {
@@ -1393,12 +1398,16 @@ func_cont:
 	} else {
 		/* RMM gives word address. Need to convert to byte address */
 		info->load_addr = rmmAddr.addr * DSPWORDSIZE;
-		info->run_addr = info->load_addr;
+		if (!runAddrFlag)
+			info->run_addr = info->load_addr;
 		info->context = (u32)rmmAddr.segid;
 		GT_3trace(DBLL_debugMask, GT_5CLASS,
 			 "Remote alloc: %s  base = 0x%lx len"
 			 "= 0x%lx\n", info->name, info->load_addr / DSPWORDSIZE,
 			 info->size / DSPWORDSIZE);
+		GT_2trace(DBLL_debugMask, GT_5CLASS,
+			 "info->run_addr = 0x%x, info->load_addr= 0x%x\n",
+			 info->run_addr, info->load_addr);
 	}
 	return retVal;
 }
-- 
1.6.2.4

