From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/7] DSPBRIDGE: Increased DMM size to 256MB
Date: Wed, 17 Jun 2009 12:36:10 -0500
Message-ID: <1245260172-23008-6-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119AbZFQRbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 13:31:35 -0400
In-Reply-To: <1245260172-23008-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

This patch increases the DMM from 64MB to 256MB.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dmm.h |    2 +-
 drivers/dsp/bridge/pmgr/dmm.c              |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index ef37668..37f272f 100644
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
index 803de93..19b8f29 100644
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

