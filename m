From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/2] DSPBRIDGE: Get rid of services/list.c (step 2)
Date: Tue,  1 Sep 2009 14:39:33 +0300
Message-ID: <1251805173-15214-3-git-send-email-andy.shevchenko@gmail.com>
References: <1251805173-15214-1-git-send-email-andy.shevchenko@gmail.com>
 <1251805173-15214-2-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60389 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbZIALjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 07:39:48 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n81BdPgc024598
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 14:39:35 +0300
In-Reply-To: <1251805173-15214-2-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

* Use native list_empty() method instead of LST_IsEmpty() inside list.c. Remove
  extra local variables.
* Move methods from list.c as inline functions in the list.h. Get rid of list.c
  at all.
* Use list_head natively instead of LST_ELEM in the list.h.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/list.h |   86 ++++++++++---
 drivers/dsp/bridge/Kbuild                   |    2 +-
 drivers/dsp/bridge/services/list.c          |  187 ---------------------------
 3 files changed, 70 insertions(+), 205 deletions(-)
 delete mode 100644 drivers/dsp/bridge/services/list.c

diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-omap/include/dspbridge/list.h
index f9bbd13..c9d9e49 100644
--- a/arch/arm/plat-omap/include/dspbridge/list.h
+++ b/arch/arm/plat-omap/include/dspbridge/list.h
@@ -49,14 +49,16 @@
 #define LIST_
 
 #include <dspbridge/host_os.h>
+/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
+#include <dspbridge/mem.h>
 #include <linux/list.h>
 
 #define LST_ELEM            list_head
 #define LST_IsEmpty(l)      list_empty(&(l)->head)
 
-	struct LST_LIST {
-		struct LST_ELEM head;
-	} ;
+struct LST_LIST {
+	struct list_head head;
+};
 
 /*
  *  ======== LST_Create ========
@@ -80,7 +82,17 @@
  *      "empty" element, because its "next" and "prev" pointers point at
  *      the same location (the element itself).
  */
-	extern struct LST_LIST *LST_Create(void);
+static inline struct LST_LIST *LST_Create(void)
+{
+	struct LST_LIST *pList;
+
+	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
+		MEM_NONPAGED);
+	if (pList != NULL)
+		INIT_LIST_HEAD(&pList->head);
+
+	return pList;
+}
 
 /*
  *  ======== LST_Delete ========
@@ -102,7 +114,10 @@
  *      chain of list elements.  Calling this function on a non-empty list
  *      will cause a memory leak.
  */
-	extern void LST_Delete(IN struct LST_LIST *pList);
+static inline void LST_Delete(struct LST_LIST *pList)
+{
+	MEM_Free(pList);
+}
 
 /*
  *  ======== LST_First ========
@@ -118,7 +133,12 @@
  *      - pList != NULL.
  *  Ensures:
  */
-	extern struct LST_ELEM *LST_First(IN struct LST_LIST *pList);
+static inline struct list_head *LST_First(struct LST_LIST *pList)
+{
+	if (!list_empty(&pList->head))
+		return pList->head.next;
+	return NULL;
+}
 
 /*
  *  ======== LST_GetHead ========
@@ -148,7 +168,19 @@
  *      the head of the list, and the head of the list points backward (its
  *      "prev" pointer) to the tail of the list, this list is circular.
  */
-	extern struct LST_ELEM *LST_GetHead(IN struct LST_LIST *pList);
+static inline struct list_head *LST_GetHead(struct LST_LIST *pList)
+{
+	struct list_head *pElem;
+
+	if (list_empty(&pList->head))
+		return NULL;
+
+	pElem = pList->head.next;
+	pList->head.next = pElem->next;
+	pElem->next->prev = &pList->head;
+
+	return pElem;
+}
 
 /*
  *  ======== LST_InitElem ========
@@ -166,7 +198,13 @@
  *      of a list chain -- that would break the chain.
  *
  */
-	extern void LST_InitElem(IN struct LST_ELEM *pListElem);
+static inline void LST_InitElem(struct list_head *pElem)
+{
+	if (pElem) {
+		pElem->next = NULL;
+		pElem->prev = NULL;
+	}
+}
 
 /*
  *  ======== LST_InsertBefore ========
@@ -184,9 +222,12 @@
  *      - pElemExisting != NULL.
  *  Ensures:
  */
-	extern void LST_InsertBefore(IN struct LST_LIST *pList,
-				     IN struct LST_ELEM *pElem,
-				     IN struct LST_ELEM *pElemExisting);
+static inline void LST_InsertBefore(struct LST_LIST *pList,
+				    struct list_head *pElem,
+				    struct list_head *pElemExisting)
+{
+	list_add_tail(pElem, pElemExisting);
+}
 
 /*
  *  ======== LST_Next ========
@@ -204,8 +245,13 @@
  *      - pCurElem != NULL.
  *  Ensures:
  */
-	extern struct LST_ELEM *LST_Next(IN struct LST_LIST *pList,
-					 IN struct LST_ELEM *pCurElem);
+static inline struct list_head *LST_Next(struct LST_LIST *pList,
+					 struct list_head *pCurElem)
+{
+	if (!list_empty(&pList->head) && (pCurElem->next != &pList->head))
+		return pCurElem->next;
+	return NULL;
+}
 
 /*
  *  ======== LST_PutTail ========
@@ -235,8 +281,10 @@
  *      tail's "next" pointer points at the head of the list, and the head's
  *      "prev" pointer points at the tail of the list), the list is circular.
  */
-	extern void LST_PutTail(IN struct LST_LIST *pList,
-				IN struct LST_ELEM *pListElem);
+static inline void LST_PutTail(struct LST_LIST *pList, struct list_head *pElem)
+{
+	list_add_tail(pElem, &pList->head);
+}
 
 /*
  *  ======== LST_RemoveElem ========
@@ -253,7 +301,11 @@
  *      - pCurElem != NULL.
  *  Ensures:
  */
-extern void LST_RemoveElem(IN struct LST_LIST *pList,
-			   IN struct LST_ELEM *pCurElem);
+static inline void LST_RemoveElem(struct LST_LIST *pList,
+				  struct list_head *pCurElem)
+{
+	if (!list_empty(&pList->head))
+		list_del_init(pCurElem);
+}
 
 #endif				/* LIST_ */
diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
index 3432ff2..30bf633 100644
--- a/drivers/dsp/bridge/Kbuild
+++ b/drivers/dsp/bridge/Kbuild
@@ -1,7 +1,7 @@
 obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
 
 libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
-libservices = services/csl.o services/mem.o services/list.o services/dpc.o \
+libservices = services/csl.o services/mem.o services/dpc.o \
                services/kfile.o services/sync.o \
 		services/clk.o services/cfg.o services/reg.o \
                services/regsup.o services/ntfy.o \
diff --git a/drivers/dsp/bridge/services/list.c b/drivers/dsp/bridge/services/list.c
deleted file mode 100644
index b215b68..0000000
--- a/drivers/dsp/bridge/services/list.c
+++ /dev/null
@@ -1,187 +0,0 @@
-/*
- * list.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-
-/*
- *  ======== listce.c ========
- *  Purpose
- *      Provides standard circular list handling functions.
- *
- *  Public Functions:
- *      LST_Create
- *      LST_Delete
- *      LST_First
- *      LST_GetHead
- *      LST_InitElem
- *      LST_InsertBefore
- *      LST_Next
- *      LST_PutTail
- *      LST_RemoveElem
- *
- *! Revision History
- *! ================
- *! 06-Mar-2002 jeh Don't set element self to NULL in LST_RemoveElem().
- *! 10-Aug-2000 ag: Added LST_InsertBefore().
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!		 GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 10-Aug-1999 kc: Based on wsx-c18.
- *! 16-Jun-1997 gp: Removed unnecessary enabling/disabling of interrupts around
- *!                 list manipulation code.
- *! 22-Oct-1996 gp: Added LST_RemoveElem, and LST_First/LST_Next iterators.
- *! 10-Aug-1996 gp: Acquired from SMM for WinSPOX v. 1.1; renamed identifiers.
- */
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/mem.h>
-
-/*  ----------------------------------- This */
-#include <dspbridge/list.h>
-
-/*
- *  ======== LST_Create ========
- *  Purpose:
- *      Allocates and initializes a circular list.
- */
-struct LST_LIST *LST_Create(void)
-{
-	struct LST_LIST *pList;
-
-	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
-		MEM_NONPAGED);
-	if (pList != NULL) {
-		INIT_LIST_HEAD(&pList->head);
-	}
-
-	return pList;
-}
-
-/*
- *  ======== LST_Delete ========
- *  Purpose:
- *      Removes a list by freeing its control structure's memory space.
- */
-void LST_Delete(struct LST_LIST *pList)
-{
-	MEM_Free(pList);
-}
-
-/*
- *  ======== LST_First ========
- *  Purpose:
- *      Returns a pointer to the first element of the list, or NULL if the
- *      list is empty.
- */
-struct LST_ELEM *LST_First(struct LST_LIST *pList)
-{
-	struct LST_ELEM *pElem = NULL;
-
-	if (!LST_IsEmpty(pList))
-		pElem = pList->head.next;
-
-	return pElem;
-}
-
-/*
- *  ======== LST_GetHead ========
- *  Purpose:
- *      "Pops" the head off the list and returns a pointer to it.
- */
-struct LST_ELEM *LST_GetHead(struct LST_LIST *pList)
-{
-	struct LST_ELEM *pElem;
-
-	if (LST_IsEmpty(pList))
-		return NULL;
-
-	/* pElem is always valid because the list cannot be empty
-	 * at this point */
-	pElem = pList->head.next;
-	pList->head.next = pElem->next;
-	pElem->next->prev = &pList->head;
-
-	return pElem;
-}
-
-/*
- *  ======== LST_InitElem ========
- *  Purpose:
- *      Initializes a list element to default (cleared) values
- */
-void LST_InitElem(struct LST_ELEM *pElem)
-{
-	if (pElem) {
-		pElem->next = NULL;
-		pElem->prev = NULL;
-	}
-}
-
-/*
- *  ======== LST_InsertBefore ========
- *  Purpose:
- *      Insert the element before the existing element.
- */
-void LST_InsertBefore(struct LST_LIST *pList, struct LST_ELEM *pElem,
-		      struct LST_ELEM *pElemExisting)
-{
-	list_add_tail(pElem, pElemExisting);
-}
-
-/*
- *  ======== LST_Next ========
- *  Purpose:
- *      Returns a pointer to the next element of the list, or NULL if the
- *      next element is the head of the list or the list is empty.
- */
-struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
-{
-	struct LST_ELEM *pNextElem = NULL;
-
-	if (!LST_IsEmpty(pList)) {
-		if (pCurElem->next != &pList->head)
-			pNextElem = pCurElem->next;
-	}
-
-	return pNextElem;
-}
-
-/*
- *  ======== LST_PutTail ========
- *  Purpose:
- *      Adds the specified element to the tail of the list
- */
-void LST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
-{
-	list_add_tail(pElem, &pList->head);
-}
-
-/*
- *  ======== LST_RemoveElem ========
- *  Purpose:
- *      Removes (unlinks) the given element from the list, if the list is not
- *      empty.  Does not free the list element.
- */
-void LST_RemoveElem(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
-{
-	if (!LST_IsEmpty(pList)) {
-		list_del_init(pCurElem);
-	}
-}
-
-- 
1.5.6.5

