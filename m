From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM] [PATCH 1/6] BRIDGE: Remove -Wno-strict-prototypes
Date: Thu, 29 Jan 2009 17:56:23 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52AE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35502 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZA2X4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 18:56:30 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0TNuOTt030502
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 17:56:29 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0TNuOh6006741
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 17:56:24 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Sat, 22 Nov 2008 00:02:05 +0200
Subject: [PATCH] BRIDGE: Remove -Wno-strict-prototypes

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h  |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dev.h  |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dpc.h  |    8 ++++----
 arch/arm/plat-omap/include/dspbridge/mgr.h  |    4 ++--
 arch/arm/plat-omap/include/dspbridge/proc.h |    4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index e13d7cf..d9db3e8 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -176,9 +176,9 @@
  *  Requires:
  *      COD initialized.
  *  Ensures:
- *      Resources acquired in COD_Init() are freed.
+ *      Resources acquired in COD_Init(void) are freed.
  */
-	extern void COD_Exit();
+	extern void COD_Exit(void);
 
 /*
  *  ======== COD_GetBaseLib ========
@@ -322,7 +322,7 @@
  *  Ensures:
  *      A requirement for each of the other public COD functions.
  */
-	extern bool COD_Init();
+	extern bool COD_Init(void);
 
 /*
  *  ======== COD_LoadBase ========
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 05dc3d6..72212ab 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -437,7 +437,7 @@
  *      A subsequent call to DEV_GetNext will return the next device object in
  *      the list.
  */
-	extern struct DEV_OBJECT *DEV_GetFirst();
+	extern struct DEV_OBJECT *DEV_GetFirst(void);
 
 /*
  *  ======== DEV_GetIntfFxns ========
@@ -603,7 +603,7 @@
  *  Ensures:
  *      When reference count == 0, DEV's private resources are freed.
  */
-	extern void DEV_Exit();
+	extern void DEV_Exit(void);
 
 /*
  *  ======== DEV_Init ========
@@ -616,7 +616,7 @@
  *  Ensures:
  *      TRUE: A requirement for the other public DEV functions.
  */
-	extern bool DEV_Init();
+	extern bool DEV_Init(void);
 
 /*
  *  ======== DEV_IsLocked ========
diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
index 620d79c..41838f8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dpc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
@@ -128,11 +128,11 @@
  *  Parameters:
  *  Returns:
  *  Requires:
- *      DPC_Init() was previously called.
+ *      DPC_Init(void) was previously called.
  *  Ensures:
- *      Resources acquired in DPC_Init() are freed.
+ *      Resources acquired in DPC_Init(void) are freed.
  */
-	extern void DPC_Exit();
+	extern void DPC_Exit(void);
 
 /*
  *  ======== DPC_Init ========
@@ -145,7 +145,7 @@
  *  Ensures:
  *      A requirement for each of the other public DPC functions.
  */
-	extern bool DPC_Init();
+	extern bool DPC_Init(void);
 
 /*
  *  ======== DPC_Schedule ========
diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index 6d4ebd3..5d27344 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -194,7 +194,7 @@
  *  Ensures:
  *      When reference count == 0, MGR's private resources are freed.
  */
-	extern void MGR_Exit();
+	extern void MGR_Exit(void);
 
 /*
  *  ======== MGR_GetDCDHandle ========
@@ -229,6 +229,6 @@
  *  Ensures:
  *      TRUE: A requirement for the other public MGR functions.
  */
-	extern bool MGR_Init();
+	extern bool MGR_Init(void);
 
 #endif				/* MGR_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index ecb83b8..12af76b 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -246,7 +246,7 @@
  *  Ensures:
  *      When reference count == 0, PROC's private resources are freed.
  */
-	extern void PROC_Exit();
+	extern void PROC_Exit(void);
 
 /*
  * ======== PROC_GetDevObject =========
@@ -280,7 +280,7 @@
  *  Ensures:
  *      TRUE: A requirement for the other public PROC functions.
  */
-	extern bool PROC_Init();
+	extern bool PROC_Init(void);
 
 /*
  *  ======== PROC_GetState ========
-- 
1.5.4.3

