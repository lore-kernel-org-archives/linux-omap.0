From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB
Date: Thu,  7 Jan 2010 19:00:35 -0600
Message-ID: <1262912435-30024-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41959 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab0AHAv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Leed Aguilar <leed.aguilar@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

This patch increases the DMM from 64MB to 256MB.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dmm.h |    2 +-
 drivers/dsp/bridge/pmgr/dmm.c              |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index 335edf8..af0c35a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
@@ -41,7 +41,7 @@
 		u32 reserved;
 	} ;
 
-#define DMMPOOLSIZE      0x4000000
+#define DMMPOOLSIZE      0x10000000
 
 /*
  *  ======== DMM_GetHandle ========
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 46c05c6..f878855 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -103,10 +103,10 @@ static struct GT_Mask DMM_debugMask = { NULL, NULL };	/* GT trace variable */
 
 static u32 cRefs;		/* module reference count */
 struct MapPage {
-	u32   RegionSize:15;
-	u32   MappedSize:15;
-	u32   bReserved:1;
-	u32   bMapped:1;
+	u64   RegionSize:31;
+	u64   MappedSize:31;
+	u64   bReserved:1;
+	u64   bMapped:1;
 };
 
 /*  Create the free list */
-- 
1.6.2.4

