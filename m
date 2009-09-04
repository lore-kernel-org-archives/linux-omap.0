From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/4] DSPBRIDGE: Get rid of services/list.c
Date: Fri,  4 Sep 2009 12:18:58 +0300
Message-ID: <1252055941-29745-2-git-send-email-andy.shevchenko@gmail.com>
References: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25504 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933317AbZIDJTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 05:19:21 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n849J7vr020053
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 12:19:09 +0300
In-Reply-To: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

* Remove LST_Init() and LST_Exit() calls because they are doing nothing except
  tracing, Thus, remove tracing as well.

* Remove DBC_* calls. It's internal kernel business whether to have those
  assertions.

* Switch to list_head structure instead of LST_ELEM. Remove redudant code that
  uses head->self pointer.

* Use native list methods where it's possible in the list.c.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   43 +------------
 drivers/dsp/bridge/services/list.c          |   89 ++-------------------------
 drivers/dsp/bridge/services/mem.c           |    2 -
 drivers/dsp/bridge/services/services.c      |    9 +--
 4 files changed, 10 insertions(+), 133 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index 2e3f995..f9bbd13 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -24,11 +24,9 @@
  *  Public Functions:
  *      LST_Create
  *      LST_Delete
- *      LST_Exit
  *      LST_First
  *      LST_GetHead
  *      LST_InitElem
- *      LST_Init
  *      LST_InsertBefore
  *      LST_IsEmpty
  *      LST_Next
@@ -51,14 +49,10 @@
 #define LIST_
 
 #include <dspbridge/host_os.h>
+#include <linux/list.h>
 
-#define LST_IsEmpty(l)      (((l)->head.next == &(l)->head))
-
-	struct LST_ELEM {
-		struct LST_ELEM *next;
-		struct LST_ELEM *prev;
-		struct LST_ELEM *self;
-	} ;
+#define LST_ELEM            list_head
+#define LST_IsEmpty(l)      list_empty(&(l)->head)
 
 	struct LST_LIST {
 		struct LST_ELEM head;
@@ -111,20 +105,6 @@
 	extern void LST_Delete(IN struct LST_LIST *pList);
 
 /*
- *  ======== LST_Exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      LST initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-	extern void LST_Exit(void);
-
-/*
  *  ======== LST_First ========
  *  Purpose:
  *      Returns a pointer to the first element of the list, or NULL if the list
@@ -160,7 +140,6 @@
  *      Pointer to element that was at the head of the list (success)
  *      NULL          No elements in list
  *  Requires:
- *      - head.self must be correctly set to &head.
  *      - LST initialized.
  *      - pList != NULL.
  *  Ensures:
@@ -172,19 +151,6 @@
 	extern struct LST_ELEM *LST_GetHead(IN struct LST_LIST *pList);
 
 /*
- *  ======== LST_Init ========
- *  Purpose:
- *      Initializes private state of LST module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE otherwise.
- *  Requires:
- *  Ensures:
- *      LST initialized.
- */
-	extern bool LST_Init(void);
-
-/*
  *  ======== LST_InitElem ========
  *  Purpose:
  *      Initializes a list element to default (cleared) values
@@ -262,15 +228,12 @@
  *      Void
  *  Requires:
  *      *pElem and *pList must both exist.
- *      pElem->self = pElem before pElem is passed to this function.
  *      LST initialized.
  *  Ensures:
  *  Notes:
  *      Because the tail is always "just before" the head of the list (the
  *      tail's "next" pointer points at the head of the list, and the head's
  *      "prev" pointer points at the tail of the list), the list is circular.
- *  Warning: if pElem->self is not set beforehand, LST_GetHead() will
- *      return an erroneous pointer when it is called for this element.
  */
 	extern void LST_PutTail(IN struct LST_LIST *pList,
 				IN struct LST_ELEM *pListElem);
diff --git a/drivers/dsp/bridge/services/list.c b/drivers/dsp/bridge/services/list.c
index 7ac7772..bc82613 100644
--- a/drivers/dsp/bridge/services/list.c
+++ b/drivers/dsp/bridge/services/list.c
@@ -23,10 +23,8 @@
  *  Public Functions:
  *      LST_Create
  *      LST_Delete
- *      LST_Exit
  *      LST_First
  *      LST_GetHead
- *      LST_Init
  *      LST_InitElem
  *      LST_InsertBefore
  *      LST_Next
@@ -51,21 +49,12 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/dbc.h>
-#include <dspbridge/gt.h>
-
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/list.h>
 
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask LST_debugMask = { NULL, NULL };	/* GT trace var. */
-#endif
-
 /*
  *  ======== LST_Create ========
  *  Purpose:
@@ -75,14 +64,10 @@ struct LST_LIST *LST_Create(void)
 {
 	struct LST_LIST *pList;
 
-	GT_0trace(LST_debugMask, GT_ENTER, "LST_Create: entered\n");
-
 	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
 		MEM_NONPAGED);
 	if (pList != NULL) {
-		pList->head.next = &pList->head;
-		pList->head.prev = &pList->head;
-		pList->head.self = NULL;
+		INIT_LIST_HEAD(&pList->head);
 	}
 
 	return pList;
@@ -95,23 +80,11 @@ struct LST_LIST *LST_Create(void)
  */
 void LST_Delete(struct LST_LIST *pList)
 {
-	GT_1trace(LST_debugMask, GT_ENTER, "LST_Delete: pList 0x%x\n", pList);
-
 	if (pList != NULL)
 		MEM_Free(pList);
 }
 
 /*
- *  ======== LST_Exit ========
- *  Purpose:
- *      Discontinue usage of the LST module.
- */
-void LST_Exit(void)
-{
-	GT_0trace(LST_debugMask, GT_5CLASS, "LST_Exit\n");
-}
-
-/*
  *  ======== LST_First ========
  *  Purpose:
  *      Returns a pointer to the first element of the list, or NULL if the
@@ -121,8 +94,6 @@ struct LST_ELEM *LST_First(struct LST_LIST *pList)
 {
 	struct LST_ELEM *pElem = NULL;
 
-	GT_1trace(LST_debugMask, GT_ENTER, "LST_First: pList 0x%x\n", pList);
-
 	if (pList && !LST_IsEmpty(pList))
 		pElem = pList->head.next;
 
@@ -138,8 +109,6 @@ struct LST_ELEM *LST_GetHead(struct LST_LIST *pList)
 {
 	struct LST_ELEM *pElem;
 
-	GT_1trace(LST_debugMask, GT_ENTER, "LST_GetHead: pList 0x%x\n", pList);
-
 	if (!pList || LST_IsEmpty(pList))
 		return NULL;
 
@@ -149,21 +118,7 @@ struct LST_ELEM *LST_GetHead(struct LST_LIST *pList)
 	pList->head.next = pElem->next;
 	pElem->next->prev = &pList->head;
 
-	return pElem->self;
-}
-
-/*
- *  ======== LST_Init ========
- *  Purpose:
- *      Initialize LST module private state.
- */
-bool LST_Init(void)
-{
-	GT_create(&LST_debugMask, "LS");	/* LS for LSt module */
-
-	GT_0trace(LST_debugMask, GT_5CLASS, "LST_Init\n");
-
-	return true;
+	return pElem;
 }
 
 /*
@@ -173,14 +128,9 @@ bool LST_Init(void)
  */
 void LST_InitElem(struct LST_ELEM *pElem)
 {
-	DBC_Require(pElem != NULL);
-
-	GT_1trace(LST_debugMask, GT_ENTER, "LST_InitElem: pElem 0x%x\n", pElem);
-
 	if (pElem) {
 		pElem->next = NULL;
 		pElem->prev = NULL;
-		pElem->self = pElem;
 	}
 }
 
@@ -192,17 +142,10 @@ void LST_InitElem(struct LST_ELEM *pElem)
 void LST_InsertBefore(struct LST_LIST *pList, struct LST_ELEM *pElem,
 		      struct LST_ELEM *pElemExisting)
 {
-	GT_3trace(LST_debugMask, GT_ENTER, "LST_InsertBefore: pList 0x%x, "
-		  "pElem 0x%x pElemExisting 0x%x\n", pList, pElem,
-		  pElemExisting);
-
 	if (!pList || !pElem || !pElemExisting)
 		return;
 
-	pElemExisting->prev->next = pElem;
-	pElem->prev = pElemExisting->prev;
-	pElem->next = pElemExisting;
-	pElemExisting->prev = pElem;
+	list_add_tail(pElem, pElemExisting);
 }
 
 /*
@@ -218,10 +161,6 @@ struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
 	if (!pList || !pCurElem)
 		return NULL;
 
-	GT_2trace(LST_debugMask, GT_ENTER,
-		  "LST_Next: pList 0x%x, pCurElem 0x%x\n",
-		  pList, pCurElem);
-
 	if (!LST_IsEmpty(pList)) {
 		if (pCurElem->next != &pList->head)
 			pNextElem = pCurElem->next;
@@ -237,19 +176,10 @@ struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
  */
 void LST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
 {
-	GT_2trace(LST_debugMask, GT_ENTER,
-		  "LST_PutTail: pList 0x%x, pElem 0x%x\n",
-		  pList, pElem);
-
 	if (!pList || !pElem)
 		return;
 
-	pElem->prev = pList->head.prev;
-	pElem->next = &pList->head;
-	pList->head.prev = pElem;
-	pElem->prev->next = pElem;
-
-	DBC_Ensure(!LST_IsEmpty(pList));
+	list_add_tail(pElem, &pList->head);
 }
 
 /*
@@ -263,17 +193,8 @@ void LST_RemoveElem(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
 	if (!pList || !pCurElem)
 		return;
 
-	GT_2trace(LST_debugMask, GT_ENTER,
-		  "LST_RemoveElem: pList 0x%x, pCurElem "
-		  "0x%x\n", pList, pCurElem);
-
 	if (!LST_IsEmpty(pList)) {
-		pCurElem->prev->next = pCurElem->next;
-		pCurElem->next->prev = pCurElem->prev;
-
-		/* set elem fields to NULL to prevent illegal references */
-		pCurElem->next = NULL;
-		pCurElem->prev = NULL;
+		list_del_init(pCurElem);
 	}
 }
 
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index af5adbf..ff507d6 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -125,7 +125,6 @@ static inline void MLST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
 	pElem->next = &pList->head;
 	pList->head.prev = pElem;
 	pElem->prev->next = pElem;
-	pElem->self = pElem;
 }
 
 static inline void MLST_RemoveElem(struct LST_LIST *pList,
@@ -617,7 +616,6 @@ bool MEM_Init(void)
 #ifdef MEM_CHECK
 		mMan.lst.head.next = &mMan.lst.head;
 		mMan.lst.head.prev = &mMan.lst.head;
-		mMan.lst.head.self = NULL;
 		spin_lock_init(&mMan.lock);
 #endif
 
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index f3f700e..b68c165 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -85,7 +85,6 @@ void SERVICES_Exit(void)
 		SYNC_Exit();
 		CLK_Exit();
 		REG_Exit();
-		LST_Exit();
 		KFILE_Exit();
 		DPC_Exit();
 		DBG_Exit();
@@ -107,7 +106,7 @@ void SERVICES_Exit(void)
 bool SERVICES_Init(void)
 {
 	bool fInit = true;
-	bool fCFG, fCSL, fDBG, fDPC, fKFILE, fLST, fMEM;
+	bool fCFG, fCSL, fDBG, fDPC, fKFILE, fMEM;
 	bool fREG, fSYNC, fCLK, fNTFY;
 
 	DBC_Require(cRefs >= 0);
@@ -128,13 +127,12 @@ bool SERVICES_Init(void)
 		fDBG = DBG_Init();
 		fDPC = DPC_Init();
 		fKFILE = KFILE_Init();
-		fLST = LST_Init();
 		fSYNC = SYNC_Init();
 		fCLK  = CLK_Init();
 		fNTFY = NTFY_Init();
 
 		fInit = fCFG && fCSL && fDBG && fDPC && fKFILE &&
-			fLST && fMEM && fREG && fSYNC && fCLK;
+			fMEM && fREG && fSYNC && fCLK;
 
 		if (!fInit) {
 			if (fNTFY)
@@ -149,9 +147,6 @@ bool SERVICES_Init(void)
 			if (fREG)
 				REG_Exit();
 
-			if (fLST)
-				LST_Exit();
-
 			if (fKFILE)
 				KFILE_Exit();
 
-- 
1.5.6.5

