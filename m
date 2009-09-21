From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/2] DSPBRIDGE: OSAL: Simplify REG API
Date: Mon, 21 Sep 2009 19:11:12 +0300
Message-ID: <1253549473-13109-2-git-send-email-andy.shevchenko@gmail.com>
References: <1253549473-13109-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28168 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbZIUQL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 12:11:28 -0400
In-Reply-To: <1253549473-13109-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Simplify REG API by removing useless input parameters.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/reg.h |  102 ++++------------------------
 drivers/dsp/bridge/rmgr/dbdcd.c            |   22 +++----
 drivers/dsp/bridge/rmgr/drv.c              |   22 ++----
 drivers/dsp/bridge/rmgr/drv_interface.c    |   33 ++++-----
 drivers/dsp/bridge/services/cfg.c          |   49 +++++---------
 drivers/dsp/bridge/services/reg.c          |   26 ++-----
 drivers/dsp/bridge/services/regsup.c       |    3 +-
 drivers/dsp/bridge/services/regsup.h       |    4 +-
 drivers/dsp/bridge/wmd/tiomap3430.c        |    4 +-
 9 files changed, 75 insertions(+), 190 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/reg.h b/arch/arm/plat-omap/include/dspbridge/reg.h
index 5b34952..64a8fe8 100644
--- a/arch/arm/plat-omap/include/dspbridge/reg.h
+++ b/arch/arm/plat-omap/include/dspbridge/reg.h
@@ -22,7 +22,6 @@
  *
  *  Public Functions:
  *      REG_DeleteValue
- *      REG_EnumKey
  *      REG_EnumValue
  *      REG_Exit
  *      REG_GetValue
@@ -53,23 +52,6 @@
 
 #include <linux/types.h>
 
-/*  ------------------------- Defines, Data Structures, Typedefs for Linux */
-#ifndef UNDER_CE
-
-#ifndef REG_SZ
-#define REG_SZ          1
-#endif
-
-#ifndef REG_BINARY
-#define REG_BINARY      3
-#endif
-
-#ifndef REG_DWORD
-#define REG_DWORD       4
-#endif
-
-#endif				/* UNDER_CE */
-
 #define REG_MAXREGPATHLENGTH    255
 
 /*
@@ -78,57 +60,18 @@
  *      Deletes a registry entry. NOTE: A registry entry is not the same as
  *      a registry key.
  *  Parameters:
- *      phKey:      Currently reserved; must be NULL.
- *      pstrSubkey: Path to key to open.
  *      pstrValue:  Name of entry to delete.
  *  Returns:
  *      DSP_SOK:    Success.
  *      DSP_EFAIL:  General failure.
  *  Requires:
  *      - REG initialized.
- *      - pstrSubkey & pstrValue are non-NULL values.
- *      - phKey is NULL.
- *      - length of pstrSubkey < REG_MAXREGPATHLENGTH.
+ *      - pstrValue is non-NULL value.
  *      - length of pstrValue < REG_MAXREGPATHLENGTH.
  *  Ensures:
  *  Details:
  */
-	extern DSP_STATUS REG_DeleteValue(OPTIONAL IN HANDLE *phKey,
-					  IN CONST char *pstrSubkey,
-					  IN CONST char *pstrValue);
-
-/*
- *  ======== REG_EnumKey ========
- *  Purpose:
- *      Enumerates subkeys of the specified path to the  registry key
- *      Retrieves the  name of the subkey(given the index) and
- *      appends with the orignal path to form the full path.
- *  Parameters:
- *      phKey:      Currently reserved; must be NULL.
- *      pstrKey     The name of the registry key to be enumerated.
- *      dwIndex     Specifies the index of the subkey to retrieve.
- *      pstrSubkey: Pointer to buffer that receives full path name of the
- *                  specified key + the sub-key
- *      pdwValueSize:   Specifies bytes of memory pstrSubkey points to on input,
- *                      on output, specifies actual memory bytes written into.
- *                      If there is no sub key,pdwValueSize returns NULL.
- *  Returns:
- *      DSP_SOK:    Success.
- *      DSP_EFAIL:  General failure.
- *  Requires:
- *      - REG initialized.
- *      - pstrKey is non-NULL value.
- *      - pdwValueSize is a valid pointer.
- *      - phKey is NULL.
- *      - length of pstrKey < REG_MAXREGPATHLENGTH.
- *  Ensures:
- *      - strlen(pstrSubkey) is > strlen(pstrKey) &&
- *      - strlen(pstrSubkey) is < REG_MAXREGPATHLENGTH
- */
-	extern DSP_STATUS REG_EnumKey(OPTIONAL IN HANDLE *phKey,
-				      IN u32 dwIndex, IN CONST char *pstrKey,
-				      IN OUT char *pstrSubkey,
-				      IN OUT u32 *pdwValueSize);
+extern DSP_STATUS REG_DeleteValue(IN CONST char *pstrValue);
 
 /*
  *  ======== REG_EnumValue ========
@@ -136,7 +79,6 @@
  *      Enumerates values of a specified key. Retrieves each value name and
  *      the data associated with the value.
  *  Parameters:
- *      phKey:          Currently reserved; must be NULL.
  *      dwIndex:        Specifies the index of the value to retrieve.
  *      pstrKey:        The name of the registry key to be enumerated.
  *      pstrValue:      Pointer to buffer that receives the name of the value.
@@ -152,19 +94,16 @@
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      REG initialized.
- *      phKey is NULL.
  *      pstrKey is a non-NULL value.
  *      pstrValue, pstrData, pdwValueSize and pdwDataSize are valid pointers.
  *      Length of pstrKey is less than REG_MAXREGPATHLENGTH.
  *  Ensures:
  */
-	extern DSP_STATUS REG_EnumValue(IN HANDLE *phKey,
-					IN u32 dwIndex,
-					IN CONST char *pstrKey,
-					IN OUT char *pstrValue,
-					IN OUT u32 *pdwValueSize,
-					IN OUT char *pstrData,
-					IN OUT u32 *pdwDataSize);
+extern DSP_STATUS REG_EnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
+				IN OUT char *pstrValue,
+				IN OUT u32 *pdwValueSize,
+				IN OUT char *pstrData,
+				IN OUT u32 *pdwDataSize);
 
 /*
  *  ======== REG_Exit ========
@@ -185,8 +124,6 @@
  *  Purpose:
  *      Retrieve a value from the registry.
  *  Parameters:
- *      phKey:          Currently reserved; must be NULL.
- *      pstrSubkey:     Path to key to open.
  *      pstrEntry:      Name of entry to retrieve.
  *      pbValue:        Upon return, points to retrieved value.
  *      pdwValueSize:   Specifies bytes of memory pbValue points to on input,
@@ -198,18 +135,13 @@
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      - REG initialized.
- *      - pstrSubkey & pstrEntry are non-NULL values.
+ *      - pstrEntry is non-NULL value.
  *      - pbValue is a valid pointer.
- *      - phKey is NULL.
- *      - length of pstrSubkey < REG_MAXREGPATHLENGTH.
  *      - length of pstrEntry < REG_MAXREGPATHLENGTH.
  *  Ensures:
  */
-	extern DSP_STATUS REG_GetValue(OPTIONAL IN HANDLE *phKey,
-				       IN CONST char *pstrSubkey,
-				       IN CONST char *pstrEntry,
-				       OUT u8 *pbValue,
-				       IN OUT u32 *pdwValueSize);
+extern DSP_STATUS REG_GetValue(IN CONST char *pstrEntry, OUT u8 *pbValue,
+			       IN OUT u32 *pdwValueSize);
 
 /*
  *  ======== REG_Init ========
@@ -229,10 +161,7 @@
  *  Purpose:
  *      Set a value in the registry.
  *  Parameters:
- *      phKey:          Handle to open reg key, or NULL if pSubkey is full path.
- *      pstrSubkey:     Path to key to open, could be based on phKey.
  *      pstrEntry:      Name of entry to set.
- *      dwType:         Data type of new registry value.
  *      pbValue:        Points to buffer containing new data.
  *      dwValueSize:    Specifies bytes of memory bValue points to.
  *  Returns:
@@ -240,18 +169,13 @@
  *      DSP_EFAIL:      General failure.
  *  Requires:
  *      - REG initialized.
- *      - pstrSubkey & pstrEntry are non-NULL values.
+ *      - pstrEntry is non-NULL value.
  *      - pbValue is a valid pointer.
- *      - phKey is NULL.
  *      - dwValuSize > 0.
- *      - length of pstrSubkey < REG_MAXREGPATHLENGTH.
  *      - length of pstrEntry < REG_MAXREGPATHLENGTH.
  *  Ensures:
  */
-	extern DSP_STATUS REG_SetValue(OPTIONAL IN HANDLE *phKey,
-				       IN CONST char *pstrSubKey,
-				       IN CONST char *pstrEntry,
-				       IN CONST u32 dwType,
-				       IN u8 *pbValue, IN u32 dwValueSize);
+extern DSP_STATUS REG_SetValue(IN CONST char *pstrEntry, IN u8 *pbValue,
+			       IN u32 dwValueSize);
 
 #endif				/* _REG_H */
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 954e83d..cc3373a 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -344,7 +344,7 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
 		}
 
 		if (DSP_SUCCEEDED(status)) {
-			status = REG_EnumValue(NULL, cIndex, szRegKey, szValue,
+			status = REG_EnumValue(cIndex, szRegKey, szValue,
 					&dwValueSize, szData, &dwDataSize);
 		}
 
@@ -529,8 +529,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 		dwBufSize = REG_MAXREGPATHLENGTH;
 	}
 	if (DSP_SUCCEEDED(status)) {
-		status = REG_GetValue(NULL, szRegKey, szRegKey, (u8 *)szRegData,
-					&dwBufSize);
+		status = REG_GetValue(szRegKey, (u8 *)szRegData, &dwBufSize);
 	}
 	if (DSP_FAILED(status)) {
 		status = DSP_EUUID;
@@ -824,8 +823,7 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Retrieve path from the registry based on DSP_UUID */
-		status = REG_GetValue(NULL, szRegKey, szRegKey,
-					(u8 *)pstrLibName, pdwSize);
+		status = REG_GetValue(szRegKey, (u8 *)pstrLibName, pdwSize);
 	}
 
 	/* If can't find, phases might be registered as generic LIBRARYTYPE */
@@ -853,8 +851,7 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 		else
 			status = DSP_EFAIL;
 
-		status = REG_GetValue(NULL, szRegKey, szRegKey,
-					(u8 *)pstrLibName, pdwSize);
+		status = REG_GetValue(szRegKey, (u8 *)pstrLibName, pdwSize);
 	}
 
 	return status;
@@ -989,11 +986,10 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 	if (pszPathName) {
 		/* Add new reg value (UUID+objType) with COFF path info. */
 		dwPathSize = strlen(pszPathName) + 1;
-		status = REG_SetValue(NULL, szRegKey, szRegKey, REG_SZ,
-				(u8 *)pszPathName, dwPathSize);
-		GT_3trace(curTrace, GT_6CLASS, "REG_SetValue  REG_SZ=%d, "
-			"(u8 *)pszPathName=%s, dwPathSize=%d\n",
-			REG_SZ, pszPathName, dwPathSize);
+		status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
+		GT_3trace(curTrace, GT_6CLASS, "REG_SetValue  "
+			  "(u8 *)pszPathName=%s, dwPathSize=%d\n",
+			  pszPathName, dwPathSize);
 		if (DSP_FAILED(status)) {
 			status = DSP_EFAIL;
 			GT_0trace(curTrace, GT_6CLASS,
@@ -1018,7 +1014,7 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 #endif /* RES_CLEANUP_DISABLE */
 	} else {
 		/* Deregister an existing object. */
-		status = REG_DeleteValue(NULL, szRegKey, szRegKey);
+		status = REG_DeleteValue(szRegKey);
 		if (DSP_FAILED(status)) {
 			status = DSP_EFAIL;
 			GT_0trace(curTrace, GT_6CLASS, "DCD_UnregisterObject: "
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 8c83c22..838fb45 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1193,8 +1193,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		/* Releasing resources by deleting the registry key  */
 		dwBuffSize = sizeof(struct CFG_HOSTRES);
 		pResources = MEM_Calloc(dwBuffSize, MEM_NONPAGED);
-		if (DSP_FAILED(REG_GetValue(NULL, (char *)driverExt->szString,
-		   CURRENTCONFIG, (u8 *)pResources, &dwBuffSize))) {
+		if (DSP_FAILED(REG_GetValue(CURRENTCONFIG, (u8 *)pResources,
+					    &dwBuffSize))) {
 			status = CFG_E_RESOURCENOTAVAIL;
 			GT_0trace(curTrace, GT_1CLASS,
 				 "REG_GetValue Failed \n");
@@ -1205,8 +1205,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 
 		if (pResources != NULL) {
 			dwBuffSize = sizeof(shm_size);
-			status = REG_GetValue(NULL, CURRENTCONFIG, SHMSIZE,
-				(u8 *)&shm_size, &dwBuffSize);
+			status = REG_GetValue(SHMSIZE, (u8 *)&shm_size,
+					      &dwBuffSize);
 			if (DSP_SUCCEEDED(status)) {
 				if ((pResources->dwMemBase[1]) &&
 				   (pResources->dwMemPhys[1])) {
@@ -1263,8 +1263,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			pResources->dwDmmuBase = NULL;
 
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
-			status = REG_SetValue(NULL, (char *)driverExt->szString,
-				 CURRENTCONFIG, REG_BINARY, (u8 *)pResources,
+			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 				 (u32)dwBuffSize);
 			/*  Set all the other entries to NULL */
 			MEM_Free(pResources);
@@ -1315,9 +1314,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			pResources->dwNumChnls = CHNL_MAXCHANNELS;
 			pResources->dwChnlBufSize = 0x400;
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
-			status = REG_SetValue(NULL, (char *) dwContext,
-					     CURRENTCONFIG, REG_BINARY,
-					     (u8 *)pResources,
+			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 					     sizeof(struct CFG_HOSTRES));
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(curTrace, GT_1CLASS,
@@ -1408,8 +1405,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 		GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
 						pResources->dwDmmuBase);
 		dwBuffSize = sizeof(shm_size);
-		status = REG_GetValue(NULL, CURRENTCONFIG, SHMSIZE,
-				     (u8 *)&shm_size, &dwBuffSize);
+		status = REG_GetValue(SHMSIZE, (u8 *)&shm_size, &dwBuffSize);
 		if (DSP_SUCCEEDED(status)) {
 			/* Allocate Physically contiguous,
 			 * non-cacheable  memory */
@@ -1441,9 +1437,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 			pResources->dwNumChnls = CHNL_MAXCHANNELS;
 			pResources->dwChnlBufSize = 0x400;
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
-			status = REG_SetValue(NULL, (char *)dwContext,
-					     CURRENTCONFIG, REG_BINARY,
-					     (u8 *)pResources,
+			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 					     sizeof(struct CFG_HOSTRES));
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(curTrace, GT_1CLASS,
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 06db1bd..6a540a9 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -349,22 +349,18 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	if (base_img) {
 		temp = true;
-		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, (u8 *)&temp,
-			    sizeof(temp));
-		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 *)base_img,
-						strlen(base_img) + 1);
+		REG_SetValue(AUTOSTART, (u8 *)&temp, sizeof(temp));
+		REG_SetValue(DEFEXEC, (u8 *)base_img, strlen(base_img) + 1);
 	} else {
 		temp = false;
-		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, (u8 *)&temp,
-			    sizeof(temp));
-		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 *) "\0", (u32)2);
+		REG_SetValue(AUTOSTART, (u8 *)&temp, sizeof(temp));
+		REG_SetValue(DEFEXEC, (u8 *) "\0", (u32)2);
 	}
-	REG_SetValue(NULL, NULL, NUMPROCS, REG_SZ, (u8 *) num_procs,
-						strlen(num_procs) + 1);
+	REG_SetValue(NUMPROCS, (u8 *) num_procs, strlen(num_procs) + 1);
 
 	if (shm_size >= 0x10000) {	/* 64 KB */
-		initStatus = REG_SetValue(NULL, NULL, SHMSIZE, REG_DWORD,
-					  (u8 *)&shm_size, sizeof(shm_size));
+		initStatus = REG_SetValue(SHMSIZE, (u8 *)&shm_size,
+					  sizeof(shm_size));
 	} else {
 		initStatus = DSP_EINVALIDARG;
 		status = -1;
@@ -380,16 +376,16 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	}
 
 	if (phys_mempool_base > 0x0) {
-		initStatus = REG_SetValue(NULL, NULL, PHYSMEMPOOLBASE,
-					 REG_DWORD, (u8 *)&phys_mempool_base,
+		initStatus = REG_SetValue(PHYSMEMPOOLBASE,
+					 (u8 *)&phys_mempool_base,
 					 sizeof(phys_mempool_base));
 	}
 	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_base = 0x%x \n",
 		 phys_mempool_base);
 
 	if (phys_mempool_size > 0x0) {
-		initStatus = REG_SetValue(NULL, NULL, PHYSMEMPOOLSIZE,
-					 REG_DWORD, (u8 *)&phys_mempool_size,
+		initStatus = REG_SetValue(PHYSMEMPOOLSIZE,
+					 (u8 *)&phys_mempool_size,
 					 sizeof(phys_mempool_size));
 	}
 	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_size = 0x%x\n",
@@ -398,12 +394,11 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		MEM_ExtPhysPoolInit(phys_mempool_base, phys_mempool_size);
 	if (tc_wordswapon) {
 		GT_0trace(driverTrace, GT_7CLASS, "TC Word Swap is enabled\n");
-		REG_SetValue(NULL, NULL, TCWORDSWAP, REG_DWORD,
-			    (u8 *)&tc_wordswapon, sizeof(tc_wordswapon));
+		REG_SetValue(TCWORDSWAP, (u8 *)&tc_wordswapon,
+			    sizeof(tc_wordswapon));
 	} else {
 		GT_0trace(driverTrace, GT_7CLASS, "TC Word Swap is disabled\n");
-		REG_SetValue(NULL, NULL, TCWORDSWAP,
-			    REG_DWORD, (u8 *)&tc_wordswapon,
+		REG_SetValue(TCWORDSWAP, (u8 *)&tc_wordswapon,
 			    sizeof(tc_wordswapon));
 	}
 	if (DSP_SUCCEEDED(initStatus)) {
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 18ab65d..cb4ffea 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -130,8 +130,8 @@ DSP_STATUS CFG_GetAutoStart(struct CFG_DEVNODE *hDevNode,
 	if (!pdwAutoStart)
 		status = CFG_E_INVALIDPOINTER;
 	if (DSP_SUCCEEDED(status)) {
-		status = REG_GetValue(NULL, (char *)hDevNode, AUTOSTART,
-				     (u8 *)pdwAutoStart, &dwBufSize);
+		status = REG_GetValue(AUTOSTART, (u8 *)pdwAutoStart,
+				      &dwBufSize);
 		if (DSP_FAILED(status))
 			status = CFG_E_RESOURCENOTAVAIL;
 	}
@@ -177,9 +177,8 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 			GT_0trace(CFG_debugMask, GT_1CLASS,
 				  "Fetching DSP Device from "
 				  "Registry \n");
-			status = REG_GetValue(NULL, (char *)hDevNode,
-					      "DEVICE_DSP",
-					      (u8 *)pdwValue, &dwBufSize);
+			status = REG_GetValue("DEVICE_DSP", (u8 *)pdwValue,
+					      &dwBufSize);
 		} else {
 			GT_0trace(CFG_debugMask, GT_6CLASS,
 				  "Failed to Identify the Device to Fetch \n");
@@ -217,8 +216,7 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 	} else if (!pDSPResTable) {
 		status = CFG_E_INVALIDPOINTER;
 	} else {
-		status = REG_GetValue(NULL, CONFIG, DSPRESOURCES,
-				     (u8 *)pDSPResTable,
+		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,
 				     &dwResSize);
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -261,8 +259,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 		status = CFG_E_INVALIDPOINTER;
 
 	if (DSP_SUCCEEDED(status)) {
-		status = REG_GetValue(NULL, (char *)hDevNode, DEFEXEC,
-				     (u8 *)pstrExecFile, &cExecSize);
+		status = REG_GetValue(DEFEXEC, (u8 *)pstrExecFile, &cExecSize);
 		if (DSP_FAILED(status))
 			status = CFG_E_RESOURCENOTAVAIL;
 		else if (cExecSize > ulBufSize)
@@ -306,9 +303,8 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 
 	if (DSP_SUCCEEDED(status)) {
 		dwBufSize = sizeof(struct CFG_HOSTRES);
-		if (DSP_FAILED(REG_GetValue(NULL, (char *)hDevNode,
-			       CURRENTCONFIG,
-			      (u8 *)pHostResTable, &dwBufSize))) {
+		if (DSP_FAILED(REG_GetValue(CURRENTCONFIG, (u8 *)pHostResTable,
+					    &dwBufSize))) {
 			status = CFG_E_RESOURCENOTAVAIL;
 		}
 	}
@@ -340,14 +336,10 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 	dwBufSize = sizeof(pdwValue);
 	switch (dwType) {
 	case (REG_DRV_OBJECT):
-		status = REG_GetValue(NULL, CONFIG, DRVOBJECT,
-				     (u8 *)pdwValue,
-				     &dwBufSize);
+		status = REG_GetValue(DRVOBJECT, (u8 *)pdwValue, &dwBufSize);
 		break;
 	case (REG_MGR_OBJECT):
-		status = REG_GetValue(NULL, CONFIG, MGROBJECT,
-				     (u8 *)pdwValue,
-				     &dwBufSize);
+		status = REG_GetValue(MGROBJECT, (u8 *)pdwValue, &dwBufSize);
 		break;
 	default:
 		break;
@@ -385,8 +377,8 @@ bool CFG_Init(void)
 	dspResources.aMemDesc[0].uMemType = 0;
 	dspResources.aMemDesc[0].ulMin = 0;
 	dspResources.aMemDesc[0].ulMax = 0;
-	if (DSP_SUCCEEDED(REG_SetValue(NULL, CONFIG, DSPRESOURCES, REG_BINARY,
-			 (u8 *)&dspResources, sizeof(struct CFG_DSPRES)))) {
+	if (DSP_SUCCEEDED(REG_SetValue(DSPRESOURCES, (u8 *)&dspResources,
+				       sizeof(struct CFG_DSPRES)))) {
 		GT_0trace(CFG_debugMask, GT_5CLASS,
 			  "Initialized DSP resources in "
 			  "Registry \n");
@@ -419,15 +411,12 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
                if (!(strcmp((char *)hDevNode, "TIOMAP1510"))) {
 			GT_0trace(CFG_debugMask, GT_1CLASS,
 				  "Registering the DSP Device \n");
-			status = REG_SetValue(NULL, (char *)hDevNode,
-				  "DEVICE_DSP", REG_DWORD,\
-				  (u8 *)&dwValue, dwBuffSize);
+			status = REG_SetValue("DEVICE_DSP", (u8 *)&dwValue,
+					      dwBuffSize);
 			if (DSP_SUCCEEDED(status)) {
 				dwBuffSize = sizeof(hDevNode);
-				status = REG_SetValue(NULL,
-					  (char *)hDevNode, "DEVNODESTRING_DSP",
-					  REG_DWORD, (u8 *)&hDevNode,
-					  dwBuffSize);
+				status = REG_SetValue("DEVNODESTRING_DSP",
+						(u8 *)&hDevNode, dwBuffSize);
 			}
 		} else {
 			GT_0trace(CFG_debugMask, GT_6CLASS,
@@ -461,12 +450,10 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 	dwBuffSize = sizeof(dwValue);
 	switch (dwType) {
 	case (REG_DRV_OBJECT):
-		status = REG_SetValue(NULL, CONFIG, DRVOBJECT, REG_DWORD,
-			 (u8 *)&dwValue, dwBuffSize);
+		status = REG_SetValue(DRVOBJECT, (u8 *)&dwValue, dwBuffSize);
 		break;
 	case (REG_MGR_OBJECT):
-		status = REG_SetValue(NULL, CONFIG, MGROBJECT, REG_DWORD,
-			 (u8 *) &dwValue, dwBuffSize);
+		status = REG_SetValue(MGROBJECT, (u8 *) &dwValue, dwBuffSize);
 		break;
 	default:
 		break;
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index a1f287d..9fa1979 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -64,19 +64,15 @@ struct GT_Mask REG_debugMask = { NULL, NULL };	/* GT trace var. */
  *  Deletes a registry entry value.  NOTE:  A registry entry value is not the
  *  same as *  a registry key.
  */
-DSP_STATUS REG_DeleteValue(OPTIONAL IN HANDLE *phKey, IN CONST char *pstrSubkey,
-			   IN CONST char *pstrValue)
+DSP_STATUS REG_DeleteValue(IN CONST char *pstrValue)
 {
 	DSP_STATUS status;
-	DBC_Require(pstrSubkey && pstrValue);
-	DBC_Require(phKey == NULL);
-       DBC_Require(strlen(pstrSubkey) < REG_MAXREGPATHLENGTH);
+	DBC_Require(pstrValue);
        DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
 	GT_0trace(REG_debugMask, GT_ENTER, "REG_DeleteValue: entered\n");
 
-	/*  Note that we don't use phKey */
-	if (regsupDeleteValue(pstrSubkey, pstrValue) == DSP_SOK)
+	if (regsupDeleteValue(pstrValue) == DSP_SOK)
 		status = DSP_SOK;
 	else
 		status = DSP_EFAIL;
@@ -90,7 +86,7 @@ DSP_STATUS REG_DeleteValue(OPTIONAL IN HANDLE *phKey, IN CONST char *pstrSubkey,
  *  We will assume the input pdwValueSize is smaller than
  *  REG_MAXREGPATHLENGTH for implementation purposes.
  */
-DSP_STATUS REG_EnumValue(IN HANDLE *phKey, IN u32 dwIndex,
+DSP_STATUS REG_EnumValue(IN u32 dwIndex,
 			 IN CONST char *pstrKey, IN OUT char *pstrValue,
 			 IN OUT u32 *pdwValueSize, IN OUT char *pstrData,
 			 IN OUT u32 *pdwDataSize)
@@ -100,7 +96,6 @@ DSP_STATUS REG_EnumValue(IN HANDLE *phKey, IN u32 dwIndex,
 	DBC_Require(pstrKey && pstrValue && pdwValueSize && pstrData &&
 		    pdwDataSize);
 	DBC_Require(*pdwValueSize <= REG_MAXREGPATHLENGTH);
-	DBC_Require(phKey == NULL);
        DBC_Require(strlen(pstrKey) < REG_MAXREGPATHLENGTH);
 
 	GT_0trace(REG_debugMask, GT_ENTER, "REG_EnumValue: entered\n");
@@ -126,15 +121,12 @@ void REG_Exit(void)
  *  ======== REG_GetValue ========
  *  Retrieve a value from the registry.
  */
-DSP_STATUS REG_GetValue(OPTIONAL IN HANDLE *phKey, IN CONST char *pstrSubkey,
-			IN CONST char *pstrValue, OUT u8 *pbData,
+DSP_STATUS REG_GetValue(IN CONST char *pstrValue, OUT u8 *pbData,
 			IN OUT u32 *pdwDataSize)
 {
 	DSP_STATUS status;
 
-	DBC_Require(pstrSubkey && pstrValue && pbData);
-	DBC_Require(phKey == NULL);
-       DBC_Require(strlen(pstrSubkey) < REG_MAXREGPATHLENGTH);
+	DBC_Require(pstrValue && pbData);
        DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
 	GT_0trace(REG_debugMask, GT_ENTER, "REG_GetValue: entered\n");
@@ -171,14 +163,12 @@ bool REG_Init(void)
  *  ======== REG_SetValue ========
  *  Set a value in the registry.
  */
-DSP_STATUS REG_SetValue(OPTIONAL IN HANDLE *phKey, IN CONST char *pstrSubkey,
-			IN CONST char *pstrValue, IN CONST u32 dwType,
-			IN u8 *pbData, IN u32 dwDataSize)
+DSP_STATUS REG_SetValue(IN CONST char *pstrValue, IN u8 *pbData,
+			IN u32 dwDataSize)
 {
 	DSP_STATUS status;
 
 	DBC_Require(pstrValue && pbData);
-	DBC_Require(phKey == NULL);
 	DBC_Require(dwDataSize > 0);
        DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 8e19ad1..0527f41 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -318,8 +318,7 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 /*
  *  ======== regsupDeleteValue ========
  */
-DSP_STATUS regsupDeleteValue(IN CONST char *pstrSubkey,
-			    IN CONST char *pstrValue)
+DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 {
 	DSP_STATUS retVal = DSP_EFAIL;
 	u32 i;
diff --git a/drivers/dsp/bridge/services/regsup.h b/drivers/dsp/bridge/services/regsup.h
index 011be52..c4d9c2d 100644
--- a/drivers/dsp/bridge/services/regsup.h
+++ b/drivers/dsp/bridge/services/regsup.h
@@ -38,8 +38,8 @@ extern void regsupExit(void);
 /*
  *  ======== regsupDeleteValue ========
  */
-extern DSP_STATUS regsupDeleteValue(IN CONST char *pstrSubkey,
-				    IN CONST char *pstrValue);
+extern DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue);
+
 /*  Get the value of the entry having the given name.  Returns DSP_SOK  */
 /*  if an entry was found and the value retrieved.  Returns DSP_EFAIL
  *  otherwise.*/
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index fe18cf2..032bdb4 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1140,8 +1140,8 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Endianism Register */ /* Need to set this */
 		/* Retrieve the TC u16 SWAP Option */
-		status = REG_GetValue(NULL, CURRENTCONFIG, TCWORDSWAP,
-				     (u8 *)&tcWordSwap, &tcWordSwapSize);
+		status = REG_GetValue(TCWORDSWAP, (u8 *)&tcWordSwap,
+				      &tcWordSwapSize);
 		/* Save the value */
 		pDevContext->tcWordSwapOn = tcWordSwap;
 	}
-- 
1.5.6.5

