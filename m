From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 3/4] dspbridge: use linux memory allocator directly
Date: Fri,  4 Sep 2009 12:19:00 +0300
Message-ID: <1252055941-29745-4-git-send-email-andy.shevchenko@gmail.com>
References: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com>
 <1252055941-29745-2-git-send-email-andy.shevchenko@gmail.com>
 <1252055941-29745-3-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23051 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933269AbZIDJTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 05:19:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n849IYuc010073
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 12:18:59 +0300
In-Reply-To: <1252055941-29745-3-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Instead of MEM_Calloc()/MEM_Free() use kzalloc()/kfree() calls. Thus we get rid
of mem.h dependency.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index 414579f..867f5ac 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -49,8 +49,8 @@
 #define LIST_
 
 #include <dspbridge/host_os.h>
-/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
-#include <dspbridge/mem.h>
+#include <linux/types.h>
+#include <linux/slab.h>
 #include <linux/list.h>
 
 #define LST_ELEM            list_head
@@ -85,9 +85,9 @@ struct LST_LIST {
 static inline struct LST_LIST *LST_Create(void)
 {
 	struct LST_LIST *pList;
+	gfp_t flags = (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
 
-	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
-		MEM_NONPAGED);
+	pList = kzalloc(sizeof(*pList), flags);
 	if (pList != NULL)
 		INIT_LIST_HEAD(&pList->head);
 
@@ -116,8 +116,7 @@ static inline struct LST_LIST *LST_Create(void)
  */
 static inline void LST_Delete(struct LST_LIST *pList)
 {
-	if (pList != NULL)
-		MEM_Free(pList);
+	kfree(pList);
 }
 
 /*
-- 
1.5.6.5

