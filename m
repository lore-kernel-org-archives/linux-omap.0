From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv3 1/3] DSPBRIDGE: Get rid of services/list.c
Date: Mon, 14 Sep 2009 18:58:57 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A6121F1D@dlee06.ent.ti.com>
References: <1252411936-25722-1-git-send-email-andy.shevchenko@gmail.com>
 <1252411936-25722-2-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42505 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbZINX66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 19:58:58 -0400
In-Reply-To: <1252411936-25722-2-git-send-email-andy.shevchenko@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


Hi,

        Please see my comments bellow.

Regards,
Fernando.

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andy Shevchenko
>Sent: Tuesday, September 08, 2009 7:12 AM
>To: linux-omap@vger.kernel.org
>Cc: hiroshi.doyu@nokia.com; Andy Shevchenko
>Subject: [PATCHv3 1/3] DSPBRIDGE: Get rid of services/list.c
>
>From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
>* Remove LST_Init() and LST_Exit() calls because they are doing nothing
>except
>  tracing, Thus, remove tracing as well.
>
>* Remove DBC_* calls. It's internal kernel business whether to have those
>  assertions.
>
>* Move methods from list.c as inline functions to the list.h.
>
>* Switch to list_head structure instead of LST_ELEM:
>  - define LST_ELEM as list_head via macro
>  - substitute LST_ELEM by list_head
>  - remove redudant code that uses head->self pointer
>
>* Remove extra local variables.
>
>* Use native list methods where it's possible inside the list.h.
>
>Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>---
> arch/arm/plat-omap/include/dspbridge/list.h |  131 +++++++------
> drivers/dsp/bridge/Kbuild                   |    2 +-
> drivers/dsp/bridge/services/list.c          |  279 -----------------------
>----
> drivers/dsp/bridge/services/mem.c           |    2 -
> drivers/dsp/bridge/services/services.c      |    9 +-
> 5 files changed, 78 insertions(+), 345 deletions(-)
> delete mode 100644 drivers/dsp/bridge/services/list.c
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/list.h b/arch/arm/plat-
>omap/include/dspbridge/list.h
>index 2e3f995..414579f 100644
>--- a/arch/arm/plat-omap/include/dspbridge/list.h
>+++ b/arch/arm/plat-omap/include/dspbridge/list.h
>@@ -24,11 +24,9 @@
>  *  Public Functions:
>  *      LST_Create
>  *      LST_Delete
>- *      LST_Exit
>  *      LST_First
>  *      LST_GetHead
>  *      LST_InitElem
>- *      LST_Init
>  *      LST_InsertBefore
>  *      LST_IsEmpty
>  *      LST_Next
>@@ -51,18 +49,16 @@
> #define LIST_
>
> #include <dspbridge/host_os.h>
>+/* MEM_Calloc(), MEM_NONPAGED, MEM_Free() */
>+#include <dspbridge/mem.h>
>+#include <linux/list.h>
>
>-#define LST_IsEmpty(l)      (((l)->head.next == &(l)->head))
>+#define LST_ELEM            list_head
>+#define LST_IsEmpty(l)      list_empty(&(l)->head)
>
>-      struct LST_ELEM {
>-              struct LST_ELEM *next;
>-              struct LST_ELEM *prev;
>-              struct LST_ELEM *self;
>-      } ;
>-
>-      struct LST_LIST {
>-              struct LST_ELEM head;
>-      } ;
>+struct LST_LIST {
>+      struct list_head head;
>+};
>
> /*
>  *  ======== LST_Create ========
>@@ -86,7 +82,17 @@
>  *      "empty" element, because its "next" and "prev" pointers point at
>  *      the same location (the element itself).
>  */
>-      extern struct LST_LIST *LST_Create(void);
>+static inline struct LST_LIST *LST_Create(void)
>+{
>+      struct LST_LIST *pList;
>+
>+      pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
>+              MEM_NONPAGED);
>+      if (pList != NULL)
>+              INIT_LIST_HEAD(&pList->head);
>+
>+      return pList;
>+}
>
> /*
>  *  ======== LST_Delete ========
>@@ -108,21 +114,11 @@
>  *      chain of list elements.  Calling this function on a non-empty list
>  *      will cause a memory leak.
>  */
>-      extern void LST_Delete(IN struct LST_LIST *pList);
>-
>-/*
>- *  ======== LST_Exit ========
>- *  Purpose:
>- *      Discontinue usage of module; free resources when reference count
>- *      reaches 0.
>- *  Parameters:
>- *  Returns:
>- *  Requires:
>- *      LST initialized.
>- *  Ensures:
>- *      Resources used by module are freed when cRef reaches zero.
>- */
>-      extern void LST_Exit(void);
>+static inline void LST_Delete(struct LST_LIST *pList)
>+{
>+      if (pList != NULL)
>+              MEM_Free(pList);
>+}
>
> /*
>  *  ======== LST_First ========
>@@ -138,7 +134,12 @@
>  *      - pList != NULL.
>  *  Ensures:
>  */
>-      extern struct LST_ELEM *LST_First(IN struct LST_LIST *pList);
>+static inline struct list_head *LST_First(struct LST_LIST *pList)
>+{
>+      if (pList && !list_empty(&pList->head))
>+              return pList->head.next;
>+      return NULL;
>+}
>
> /*
>  *  ======== LST_GetHead ========
>@@ -160,7 +161,6 @@
>  *      Pointer to element that was at the head of the list (success)
>  *      NULL          No elements in list
>  *  Requires:
>- *      - head.self must be correctly set to &head.
>  *      - LST initialized.
>  *      - pList != NULL.
>  *  Ensures:
>@@ -169,20 +169,19 @@
>  *      the head of the list, and the head of the list points backward
>(its
>  *      "prev" pointer) to the tail of the list, this list is circular.
>  */
>-      extern struct LST_ELEM *LST_GetHead(IN struct LST_LIST *pList);
>+static inline struct list_head *LST_GetHead(struct LST_LIST *pList)
>+{
>+      struct list_head *pElem;
>
>-/*
>- *  ======== LST_Init ========
>- *  Purpose:
>- *      Initializes private state of LST module.
>- *  Parameters:
>- *  Returns:
>- *      TRUE if initialized; FALSE otherwise.
>- *  Requires:
>- *  Ensures:
>- *      LST initialized.
>- */
>-      extern bool LST_Init(void);
>+      if (!pList && list_empty(&pList->head))
>+              return NULL;

"if" statement should be use OR conditional instead of AND.
        if (!pList || list_empty(&pList->head))



>+
>+      pElem = pList->head.next;
>+      pList->head.next = pElem->next;
>+      pElem->next->prev = &pList->head;
>+
>+      return pElem;
>+}
>
> /*
>  *  ======== LST_InitElem ========
>@@ -200,7 +199,13 @@
>  *      of a list chain -- that would break the chain.
>  *
>  */
>-      extern void LST_InitElem(IN struct LST_ELEM *pListElem);
>+static inline void LST_InitElem(struct list_head *pElem)
>+{
>+      if (pElem) {
>+              pElem->next = NULL;
>+              pElem->prev = NULL;
>+      }
>+}
>
> /*
>  *  ======== LST_InsertBefore ========
>@@ -218,9 +223,13 @@
>  *      - pElemExisting != NULL.
>  *  Ensures:
>  */
>-      extern void LST_InsertBefore(IN struct LST_LIST *pList,
>-                                   IN struct LST_ELEM *pElem,
>-                                   IN struct LST_ELEM *pElemExisting);
>+static inline void LST_InsertBefore(struct LST_LIST *pList,
>+                                  struct list_head *pElem,
>+                                  struct list_head *pElemExisting)
>+{
>+      if (pList && pElem && pElemExisting)
>+              list_add_tail(pElem, pElemExisting);
>+}
>
> /*
>  *  ======== LST_Next ========
>@@ -238,8 +247,14 @@
>  *      - pCurElem != NULL.
>  *  Ensures:
>  */
>-      extern struct LST_ELEM *LST_Next(IN struct LST_LIST *pList,
>-                                       IN struct LST_ELEM *pCurElem);
>+static inline struct list_head *LST_Next(struct LST_LIST *pList,
>+                                       struct list_head *pCurElem)
>+{
>+      if (pList && !list_empty(&pList->head) && pCurElem &&
>+         (pCurElem->next != &pList->head))
>+              return pCurElem->next;
>+      return NULL;
>+}
>
> /*
>  *  ======== LST_PutTail ========
>@@ -262,18 +277,18 @@
>  *      Void
>  *  Requires:
>  *      *pElem and *pList must both exist.
>- *      pElem->self = pElem before pElem is passed to this function.
>  *      LST initialized.
>  *  Ensures:
>  *  Notes:
>  *      Because the tail is always "just before" the head of the list (the
>  *      tail's "next" pointer points at the head of the list, and the
>head's
>  *      "prev" pointer points at the tail of the list), the list is
>circular.
>- *  Warning: if pElem->self is not set beforehand, LST_GetHead() will
>- *      return an erroneous pointer when it is called for this element.
>  */
>-      extern void LST_PutTail(IN struct LST_LIST *pList,
>-                              IN struct LST_ELEM *pListElem);
>+static inline void LST_PutTail(struct LST_LIST *pList, struct list_head
>*pElem)
>+{
>+      if (pList && pElem)
>+              list_add_tail(pElem, &pList->head);
>+}
>
> /*
>  *  ======== LST_RemoveElem ========
>@@ -290,7 +305,11 @@
>  *      - pCurElem != NULL.
>  *  Ensures:
>  */
>-extern void LST_RemoveElem(IN struct LST_LIST *pList,
>-                         IN struct LST_ELEM *pCurElem);
>+static inline void LST_RemoveElem(struct LST_LIST *pList,
>+                                struct list_head *pCurElem)
>+{
>+      if (pList && !list_empty(&pList->head) && pCurElem)
>+              list_del_init(pCurElem);
>+}
>
> #endif                                /* LIST_ */
>diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
>index 8d6c5c7..e04a6e4 100644
>--- a/drivers/dsp/bridge/Kbuild
>+++ b/drivers/dsp/bridge/Kbuild
>@@ -1,7 +1,7 @@
> obj-$(CONFIG_MPU_BRIDGE)      += bridgedriver.o
>
> libgen = gen/gb.o gen/gt.o gen/gs.o gen/gh.o gen/_gt_para.o gen/uuidutil.o
>-libservices = services/csl.o services/mem.o services/list.o services/dpc.o
>\
>+libservices = services/csl.o services/mem.o services/dpc.o \
>                services/kfile.o services/sync.o \
>               services/clk.o services/cfg.o services/reg.o \
>                services/regsup.o services/ntfy.o \
>diff --git a/drivers/dsp/bridge/services/list.c
>b/drivers/dsp/bridge/services/list.c
>deleted file mode 100644
>index 7ac7772..0000000
>--- a/drivers/dsp/bridge/services/list.c
>+++ /dev/null
>@@ -1,279 +0,0 @@
>-/*
>- * list.c
>- *
>- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
>- *
>- * Copyright (C) 2005-2006 Texas Instruments, Inc.
>- *
>- * This package is free software; you can redistribute it and/or modify
>- * it under the terms of the GNU General Public License version 2 as
>- * published by the Free Software Foundation.
>- *
>- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
>- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
>- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
>- */
>-
>-
>-/*
>- *  ======== listce.c ========
>- *  Purpose
>- *      Provides standard circular list handling functions.
>- *
>- *  Public Functions:
>- *      LST_Create
>- *      LST_Delete
>- *      LST_Exit
>- *      LST_First
>- *      LST_GetHead
>- *      LST_Init
>- *      LST_InitElem
>- *      LST_InsertBefore
>- *      LST_Next
>- *      LST_PutTail
>- *      LST_RemoveElem
>- *
>- *! Revision History
>- *! ================
>- *! 06-Mar-2002 jeh Don't set element self to NULL in LST_RemoveElem().
>- *! 10-Aug-2000 ag: Added LST_InsertBefore().
>- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
>- *!            GT Changes.
>- *! 22-Nov-1999 kc: Added changes from code review.
>- *! 10-Aug-1999 kc: Based on wsx-c18.
>- *! 16-Jun-1997 gp: Removed unnecessary enabling/disabling of interrupts
>around
>- *!                 list manipulation code.
>- *! 22-Oct-1996 gp: Added LST_RemoveElem, and LST_First/LST_Next
>iterators.
>- *! 10-Aug-1996 gp: Acquired from SMM for WinSPOX v. 1.1; renamed
>identifiers.
>- */
>-
>-/*  ----------------------------------- DSP/BIOS Bridge */
>-#include <dspbridge/std.h>
>-#include <dspbridge/dbdefs.h>
>-
>-/*  ----------------------------------- Trace & Debug */
>-#include <dspbridge/dbc.h>
>-#include <dspbridge/gt.h>
>-
>-/*  ----------------------------------- OS Adaptation Layer */
>-#include <dspbridge/mem.h>
>-
>-/*  ----------------------------------- This */
>-#include <dspbridge/list.h>
>-
>-/*  ----------------------------------- Globals */
>-#if GT_TRACE
>-static struct GT_Mask LST_debugMask = { NULL, NULL }; /* GT trace
>var. */
>-#endif
>-
>-/*
>- *  ======== LST_Create ========
>- *  Purpose:
>- *      Allocates and initializes a circular list.
>- */
>-struct LST_LIST *LST_Create(void)
>-{
>-      struct LST_LIST *pList;
>-
>-      GT_0trace(LST_debugMask, GT_ENTER, "LST_Create: entered\n");
>-
>-      pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
>-              MEM_NONPAGED);
>-      if (pList != NULL) {
>-              pList->head.next = &pList->head;
>-              pList->head.prev = &pList->head;
>-              pList->head.self = NULL;
>-      }
>-
>-      return pList;
>-}
>-
>-/*
>- *  ======== LST_Delete ========
>- *  Purpose:
>- *      Removes a list by freeing its control structure's memory space.
>- */
>-void LST_Delete(struct LST_LIST *pList)
>-{
>-      GT_1trace(LST_debugMask, GT_ENTER, "LST_Delete: pList 0x%x\n",
>pList);
>-
>-      if (pList != NULL)
>-              MEM_Free(pList);
>-}
>-
>-/*
>- *  ======== LST_Exit ========
>- *  Purpose:
>- *      Discontinue usage of the LST module.
>- */
>-void LST_Exit(void)
>-{
>-      GT_0trace(LST_debugMask, GT_5CLASS, "LST_Exit\n");
>-}
>-
>-/*
>- *  ======== LST_First ========
>- *  Purpose:
>- *      Returns a pointer to the first element of the list, or NULL if the
>- *      list is empty.
>- */
>-struct LST_ELEM *LST_First(struct LST_LIST *pList)
>-{
>-      struct LST_ELEM *pElem = NULL;
>-
>-      GT_1trace(LST_debugMask, GT_ENTER, "LST_First: pList 0x%x\n", pList);
>-
>-      if (pList && !LST_IsEmpty(pList))
>-              pElem = pList->head.next;
>-
>-      return pElem;
>-}
>-
>-/*
>- *  ======== LST_GetHead ========
>- *  Purpose:
>- *      "Pops" the head off the list and returns a pointer to it.
>- */
>-struct LST_ELEM *LST_GetHead(struct LST_LIST *pList)
>-{
>-      struct LST_ELEM *pElem;
>-
>-      GT_1trace(LST_debugMask, GT_ENTER, "LST_GetHead: pList 0x%x\n",
>pList);
>-
>-      if (!pList || LST_IsEmpty(pList))
>-              return NULL;
>-
>-      /* pElem is always valid because the list cannot be empty
>-       * at this point */
>-      pElem = pList->head.next;
>-      pList->head.next = pElem->next;
>-      pElem->next->prev = &pList->head;
>-
>-      return pElem->self;
>-}
>-
>-/*
>- *  ======== LST_Init ========
>- *  Purpose:
>- *      Initialize LST module private state.
>- */
>-bool LST_Init(void)
>-{
>-      GT_create(&LST_debugMask, "LS");        /* LS for LSt module */
>-
>-      GT_0trace(LST_debugMask, GT_5CLASS, "LST_Init\n");
>-
>-      return true;
>-}
>-
>-/*
>- *  ======== LST_InitElem ========
>- *  Purpose:
>- *      Initializes a list element to default (cleared) values
>- */
>-void LST_InitElem(struct LST_ELEM *pElem)
>-{
>-      DBC_Require(pElem != NULL);
>-
>-      GT_1trace(LST_debugMask, GT_ENTER, "LST_InitElem: pElem 0x%x\n",
>pElem);
>-
>-      if (pElem) {
>-              pElem->next = NULL;
>-              pElem->prev = NULL;
>-              pElem->self = pElem;
>-      }
>-}
>-
>-/*
>- *  ======== LST_InsertBefore ========
>- *  Purpose:
>- *      Insert the element before the existing element.
>- */
>-void LST_InsertBefore(struct LST_LIST *pList, struct LST_ELEM *pElem,
>-                    struct LST_ELEM *pElemExisting)
>-{
>-      GT_3trace(LST_debugMask, GT_ENTER, "LST_InsertBefore: pList 0x%x, "
>-                "pElem 0x%x pElemExisting 0x%x\n", pList, pElem,
>-                pElemExisting);
>-
>-      if (!pList || !pElem || !pElemExisting)
>-              return;
>-
>-      pElemExisting->prev->next = pElem;
>-      pElem->prev = pElemExisting->prev;
>-      pElem->next = pElemExisting;
>-      pElemExisting->prev = pElem;
>-}
>-
>-/*
>- *  ======== LST_Next ========
>- *  Purpose:
>- *      Returns a pointer to the next element of the list, or NULL if the
>- *      next element is the head of the list or the list is empty.
>- */
>-struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM
>*pCurElem)
>-{
>-      struct LST_ELEM *pNextElem = NULL;
>-
>-      if (!pList || !pCurElem)
>-              return NULL;
>-
>-      GT_2trace(LST_debugMask, GT_ENTER,
>-                "LST_Next: pList 0x%x, pCurElem 0x%x\n",
>-                pList, pCurElem);
>-
>-      if (!LST_IsEmpty(pList)) {
>-              if (pCurElem->next != &pList->head)
>-                      pNextElem = pCurElem->next;
>-      }
>-
>-      return pNextElem;
>-}
>-
>-/*
>- *  ======== LST_PutTail ========
>- *  Purpose:
>- *      Adds the specified element to the tail of the list
>- */
>-void LST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
>-{
>-      GT_2trace(LST_debugMask, GT_ENTER,
>-                "LST_PutTail: pList 0x%x, pElem 0x%x\n",
>-                pList, pElem);
>-
>-      if (!pList || !pElem)
>-              return;
>-
>-      pElem->prev = pList->head.prev;
>-      pElem->next = &pList->head;
>-      pList->head.prev = pElem;
>-      pElem->prev->next = pElem;
>-
>-      DBC_Ensure(!LST_IsEmpty(pList));
>-}
>-
>-/*
>- *  ======== LST_RemoveElem ========
>- *  Purpose:
>- *      Removes (unlinks) the given element from the list, if the list is
>not
>- *      empty.  Does not free the list element.
>- */
>-void LST_RemoveElem(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
>-{
>-      if (!pList || !pCurElem)
>-              return;
>-
>-      GT_2trace(LST_debugMask, GT_ENTER,
>-                "LST_RemoveElem: pList 0x%x, pCurElem "
>-                "0x%x\n", pList, pCurElem);
>-
>-      if (!LST_IsEmpty(pList)) {
>-              pCurElem->prev->next = pCurElem->next;
>-              pCurElem->next->prev = pCurElem->prev;
>-
>-              /* set elem fields to NULL to prevent illegal references */
>-              pCurElem->next = NULL;
>-              pCurElem->prev = NULL;
>-      }
>-}
>-
>diff --git a/drivers/dsp/bridge/services/mem.c
>b/drivers/dsp/bridge/services/mem.c
>index af5adbf..ff507d6 100644
>--- a/drivers/dsp/bridge/services/mem.c
>+++ b/drivers/dsp/bridge/services/mem.c
>@@ -125,7 +125,6 @@ static inline void MLST_PutTail(struct LST_LIST *pList,
>struct LST_ELEM *pElem)
>       pElem->next = &pList->head;
>       pList->head.prev = pElem;
>       pElem->prev->next = pElem;
>-      pElem->self = pElem;
> }
>
> static inline void MLST_RemoveElem(struct LST_LIST *pList,
>@@ -617,7 +616,6 @@ bool MEM_Init(void)
> #ifdef MEM_CHECK
>               mMan.lst.head.next = &mMan.lst.head;
>               mMan.lst.head.prev = &mMan.lst.head;
>-              mMan.lst.head.self = NULL;
>               spin_lock_init(&mMan.lock);
> #endif
>
>diff --git a/drivers/dsp/bridge/services/services.c
>b/drivers/dsp/bridge/services/services.c
>index f3f700e..b68c165 100644
>--- a/drivers/dsp/bridge/services/services.c
>+++ b/drivers/dsp/bridge/services/services.c
>@@ -85,7 +85,6 @@ void SERVICES_Exit(void)
>               SYNC_Exit();
>               CLK_Exit();
>               REG_Exit();
>-              LST_Exit();
>               KFILE_Exit();
>               DPC_Exit();
>               DBG_Exit();
>@@ -107,7 +106,7 @@ void SERVICES_Exit(void)
> bool SERVICES_Init(void)
> {
>       bool fInit = true;
>-      bool fCFG, fCSL, fDBG, fDPC, fKFILE, fLST, fMEM;
>+      bool fCFG, fCSL, fDBG, fDPC, fKFILE, fMEM;
>       bool fREG, fSYNC, fCLK, fNTFY;
>
>       DBC_Require(cRefs >= 0);
>@@ -128,13 +127,12 @@ bool SERVICES_Init(void)
>               fDBG = DBG_Init();
>               fDPC = DPC_Init();
>               fKFILE = KFILE_Init();
>-              fLST = LST_Init();
>               fSYNC = SYNC_Init();
>               fCLK  = CLK_Init();
>               fNTFY = NTFY_Init();
>
>               fInit = fCFG && fCSL && fDBG && fDPC && fKFILE &&
>-                      fLST && fMEM && fREG && fSYNC && fCLK;
>+                      fMEM && fREG && fSYNC && fCLK;
>
>               if (!fInit) {
>                       if (fNTFY)
>@@ -149,9 +147,6 @@ bool SERVICES_Init(void)
>                       if (fREG)
>                               REG_Exit();
>
>-                      if (fLST)
>-                              LST_Exit();
>-
>                       if (fKFILE)
>                               KFILE_Exit();
>
>--
>1.5.6.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

