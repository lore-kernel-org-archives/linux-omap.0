From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: use linux memory allocator directly
Date: Thu,  3 Sep 2009 09:48:58 +0300
Message-ID: <1251960538-24736-1-git-send-email-andy.shevchenko@gmail.com>
References: <20090902174941.GA25799@localhost>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20097 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbZICGti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 02:49:38 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n836l3gK023884
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 01:49:04 -0500
In-Reply-To: <20090902174941.GA25799@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Instead of MEM_Calloc()/MEM_Free() use kzalloc()/kfree() calls. Thus we get rid
of mem.h dependency.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index c9d9e49..cda1d21 100644
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
+	pList = (struct LST_LIST *) kzalloc(sizeof(struct LST_LIST), flags);
 	if (pList != NULL)
 		INIT_LIST_HEAD(&pList->head);
 
@@ -116,7 +116,7 @@ static inline struct LST_LIST *LST_Create(void)
  */
 static inline void LST_Delete(struct LST_LIST *pList)
 {
-	MEM_Free(pList);
+	kfree(pList);
 }
 
 /*
-- 
1.5.6.5

