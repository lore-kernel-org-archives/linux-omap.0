From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 17/18] DSPBRIDGE: change critical error statements to pr_err in pmgr
Date: Tue, 16 Feb 2010 02:42:27 -0600
Message-ID: <1266309748-11714-18-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-16-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-17-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab0BPIaJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:09 -0500
In-Reply-To: <1266309748-11714-17-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console:
    - DMM table creation fails.
    - Failure while finding dsp code.
    - Failure on device create

This will help to quick diagnose most common bridge errors.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/cod.c |   14 ++++++--------
 drivers/dsp/bridge/pmgr/dev.c |    5 ++---
 drivers/dsp/bridge/pmgr/dmm.c |    8 ++++----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index eb74fb8..541503c 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -574,10 +574,6 @@ DSP_STATUS COD_Open(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	DBC_Require(flags == COD_NOLOAD || flags == COD_SYMB);
 	DBC_Require(pLib != NULL);
 
-	GT_4trace(COD_debugMask, GT_ENTER, "Entered COD_Open, hMgr: 0x%x\n\t "
-		  "pszCoffPath:  0x%x\tflags: 0x%x\tlib: 0x%x\n", hMgr,
-		  pszCoffPath, flags, pLib);
-
 	*pLib = NULL;
 
 	lib = MEM_Calloc(sizeof(struct COD_LIBRARYOBJ), MEM_NONPAGED);
@@ -592,6 +588,9 @@ DSP_STATUS COD_Open(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 			*pLib = lib;
 	}
 
+	if (DSP_FAILED(status))
+		pr_err("%s: error status 0x%x, pszCoffPath: %s flags: 0x%x\n",
+					__func__, status, pszCoffPath, flags);
 	return status;
 }
 
@@ -610,10 +609,6 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	DBC_Require(IsValid(hMgr));
 	DBC_Require(pszCoffPath != NULL);
 
-	GT_2trace(COD_debugMask, GT_ENTER,
-		  "Entered COD_OpenBase, hMgr:  0x%x\n\t"
-		  "pszCoffPath:  0x%x\n", hMgr, pszCoffPath);
-
 	/* if we previously opened a base image, close it now */
 	if (hMgr->baseLib) {
 		if (hMgr->fLoaded) {
@@ -631,6 +626,9 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 		hMgr->szZLFile[COD_MAXPATHLENGTH - 1] = '\0';
 	}
 
+	if (DSP_FAILED(status))
+		pr_err("%s: error status 0x%x pszCoffPath: %s\n", __func__,
+							status, pszCoffPath);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 8ee6d69..e4450bc 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -215,9 +215,8 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 		} else {
 			ioMgrAttrs.dwSMBase = 0;
 			ioMgrAttrs.uSMLength = 0;
-			GT_0trace(debugMask, GT_7CLASS,
-				  "**There is no memory reserved for "
-				  "shared structures**\n");
+			pr_err("%s: No memory reserved for shared structures\n",
+								__func__);
 		}
 		status = CHNL_Create(&pDevObject->hChnlMgr, pDevObject,
 				    &mgrAttrs);
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index ebecc8b..2840674 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -120,10 +120,10 @@ DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 			pVirtualMappingTable[0].RegionSize = TableSize;
 		}
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
-	} else
-		GT_0trace(DMM_debugMask, GT_7CLASS,
-			 "DMM_CreateTables: DMM_DeleteTables"
-			 "Failure\n");
+	}
+
+	if (DSP_FAILED(status))
+		pr_err("%s: failure, status 0x%x\n", __func__, status);
 
 	return status;
 }
-- 
1.6.2.4

