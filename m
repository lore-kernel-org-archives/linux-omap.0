From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 07/18] DSPBRIDGE: Remove debug statements for success in pmgr
Date: Tue, 16 Feb 2010 02:42:17 -0600
Message-ID: <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57623 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab0BPIaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes debug statements used to print a successful
status or printed during normal execution, as they just polute
the logs if trying to look for a failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c |    3 ---
 drivers/dsp/bridge/pmgr/cmm.c  |   15 +--------------
 drivers/dsp/bridge/pmgr/cod.c  |    6 ------
 drivers/dsp/bridge/pmgr/dbll.c |   16 +---------------
 drivers/dsp/bridge/pmgr/dev.c  |    8 --------
 drivers/dsp/bridge/pmgr/io.c   |    3 ---
 drivers/dsp/bridge/pmgr/msg.c  |    2 --
 7 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 66464c7..802f71c 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -111,9 +111,6 @@ DSP_STATUS CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
 			pChnlMgr->pIntfFxns = pIntfFxns;
 			/* Finally, return the new channel manager handle: */
 			*phChnlMgr = hChnlMgr;
-			GT_1trace(CHNL_DebugMask, GT_1CLASS,
-				  "CHNL_Create: Success pChnlMgr:"
-				  "0x%x\n", pChnlMgr);
 		}
 	}
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 53855a9..e422dc5 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -237,9 +237,6 @@ void *CMM_CallocBuf(struct CMM_OBJECT *hCmmMgr, u32 uSize,
 				*ppBufVA = (void *)pNode->dwVA;
 			}
 		}
-		GT_3trace(CMM_debugMask, GT_3CLASS,
-			  "CMM_CallocBuf dwPA %x, dwVA %x uSize"
-			  "%x\n", pNode->dwPA, pNode->dwVA, uSize);
 		SYNC_LeaveCS(pCmmMgr->hCmmLock);
 	}
 	return pBufPA;
@@ -277,9 +274,6 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 		sysInfo.dwAllocationGranularity = PAGE_SIZE;
 		sysInfo.dwNumberOfProcessors = 1;
 		if (DSP_SUCCEEDED(status)) {
-			GT_1trace(CMM_debugMask, GT_5CLASS,
-				  "CMM_Create: Got system page size"
-				  "= 0x%x\t\n", sysInfo.dwPageSize);
 			pCmmObject->dwPageSize = sysInfo.dwPageSize;
 		} else {
 			GT_0trace(CMM_debugMask, GT_7CLASS,
@@ -1135,10 +1129,6 @@ DSP_STATUS CMM_XlatorInfo(struct CMM_XLATOROBJECT *hXlator, IN OUT u8 **pAddr,
 			/* set translators virtual address range */
 			pXlator->dwVirtBase = (u32)*pAddr;
 			pXlator->ulVirtSize = ulSize;
-			GT_2trace(CMM_debugMask, GT_3CLASS,
-				  "pXlator->dwVirtBase %x, "
-				  "ulVirtSize %x\n", pXlator->dwVirtBase,
-				  pXlator->ulVirtSize);
 		} else {	/* return virt base address */
 			*pAddr = (u8 *)pXlator->dwVirtBase;
 		}
@@ -1218,10 +1208,7 @@ loop_cont:
 		GT_2trace(CMM_debugMask, GT_7CLASS,
 			  "CMM_XlatorTranslate: Can't translate"
 			  " address: 0x%x xType %x\n", pAddr, xType);
-	} else {
-		GT_3trace(CMM_debugMask, GT_3CLASS,
-			  "CMM_XlatorTranslate: pAddr %x, xType"
-			  " %x, dwAddrXlate %x\n", pAddr, xType, dwAddrXlate);
 	}
+
 	return (void *)dwAddrXlate;
 }
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 6f659e5..25921fb 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -645,17 +645,11 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	/* if we previously opened a base image, close it now */
 	if (hMgr->baseLib) {
 		if (hMgr->fLoaded) {
-			GT_0trace(COD_debugMask, GT_7CLASS,
-				 "Base Image is already loaded. "
-				 "Unloading it...\n");
 			hMgr->fxns.unloadFxn(hMgr->baseLib, &hMgr->attrs);
 			hMgr->fLoaded = false;
 		}
 		hMgr->fxns.closeFxn(hMgr->baseLib);
 		hMgr->baseLib = NULL;
-	} else {
-		GT_0trace(COD_debugMask, GT_1CLASS,
-			 "COD_OpenBase: Opening the base image ...\n");
 	}
 	status = hMgr->fxns.openFxn(hMgr->target, pszCoffPath, flags, &lib);
 	if (DSP_FAILED(status)) {
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 22e08bd..367597d 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1313,12 +1313,6 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 					segId = 2;
 			}
 		}
-		if (segId != -1) {
-			GT_2trace(DBLL_debugMask, GT_5CLASS,
-				 "Extracted values for memory"
-				 " granularity req [%d] segId [%d]\n",
-				 req, segId);
-		}
 	}
 func_cont:
 	kfree(szSectName);
@@ -1332,9 +1326,7 @@ func_cont:
 		allocSize = info->size + GEM_L1P_PREFETCH_SIZE;
 	else
 		allocSize = info->size;
-	GT_2trace(DBLL_debugMask, GT_5CLASS,
-			 "Beg info->run_addr = 0x%x, info->load_addr= 0x%x\n",
-			 info->run_addr, info->load_addr);
+
 	if (info->load_addr != info->run_addr)
 		runAddrFlag = 1;
 	/* TODO - ideally, we can pass the alignment requirement also
@@ -1393,12 +1385,6 @@ static void rmmDealloc(struct Dynamic_Loader_Allocate *this,
 			 attrs.symHandle, segid, info->load_addr / DSPWORDSIZE,
 			 freeSize, false);
 	}
-	if (DSP_SUCCEEDED(status)) {
-		GT_2trace(DBLL_debugMask, GT_5CLASS,
-			 "Remote dealloc: base = 0x%lx len ="
-			 "0x%lx\n", info->load_addr / DSPWORDSIZE,
-			 freeSize / DSPWORDSIZE);
-	}
 }
 
 /* Dynamic_Loader_Initialize */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5719519..c6561a4 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -279,9 +279,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	 *  else, cleanup and return NULL in the OUT parameter.  */
 	if (DSP_SUCCEEDED(status)) {
 		*phDevObject = pDevObject;
-		GT_1trace(debugMask, GT_1CLASS,
-			 "DEV_CreateDevice Succeeded \nDevObject "
-			 "0x%x\n", pDevObject);
 	} else {
 		kfree(pDevObject->procList);
 
@@ -892,11 +889,6 @@ DSP_STATUS DEV_RemoveDevice(struct CFG_DEVNODE *hDevNode)
 		pDevObject = (struct DEV_OBJECT *)hDevObject;
 		/* Destroy the device object. */
 		status = DEV_DestroyDevice(hDevObject);
-		if (DSP_SUCCEEDED(status)) {
-			/* Null out the handle stored with the DevNode. */
-			GT_0trace(debugMask, GT_1CLASS,
-				 "DEV_RemoveDevice, success");
-		}
 	}
 
 	return status;
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 3b1156a..e83178b 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -94,9 +94,6 @@ DSP_STATUS IO_Create(OUT struct IO_MGR **phIOMgr, struct DEV_OBJECT *hDevObject,
 
 			/* Return the new channel manager handle: */
 			*phIOMgr = hIOMgr;
-			GT_1trace(IO_DebugMask, GT_1CLASS,
-				 "IO_Create: Success hIOMgr: 0x%x\n",
-				 hIOMgr);
 		}
 	}
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 1ba1c88..69f39a8 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -81,8 +81,6 @@ DSP_STATUS MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 
 		/* Finally, return the new message manager handle: */
 		*phMsgMgr = hMsgMgr;
-		GT_1trace(MSG_debugMask, GT_1CLASS,
-			 "MSG_Create: Success pMsgMgr: 0x%x\n",	pMsgMgr);
 	} else {
 		status = DSP_EFAIL;
 	}
-- 
1.6.2.4

