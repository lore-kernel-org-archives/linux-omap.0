From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 10/18] DSPBRIDGE: Trivial cleanup on DBDCD
Date: Wed, 16 Dec 2009 20:15:55 -0600
Message-ID: <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-9-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-10-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763926AbZLQCIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 21:08:49 -0500
In-Reply-To: <1261016163-11091-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Trivial spacing cleanup on DSP/BIOS Bridge Configuration
Database module.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |  343 ++++++++++++++++++++-------------------
 1 files changed, 179 insertions(+), 164 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index fb4a9a6..b1391e2 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -31,32 +31,32 @@
  *! ================
  *! 03-Dec-2003 map Changed DCD_OBJTYPE to DSP_DCDOBJTYPE
  *! 17-Dec-2002 map Modified DCD_GetDepLibs, DCD_GetNumDepLibs, GetDepLibInfo
- *!                 to include phase information
+ *!		 to include phase information
  *! 02-Dec-2002 map Modified DCD_GetLibraryName for phases in different
- *!                 libraries
+ *!		 libraries
  *! 26-Feb-2003 kc  Updated DCD_AutoUnregister and DCD_GetObjects to simplify
- *!                 DCD implementation.
+ *!		 DCD implementation.
  *! 17-Jul-2002 jeh Call COD_Open() instead of COD_OpenBase(), call COD_Close()
  *! 11-Jul-2002 jeh Added DCD_GetDepLibs(), DCD_GetNumDepLibs().
  *! 18-Feb-2003 vp  Code review updates
  *! 18-Oct-2002 vp  Ported to Linux platform
  *! 15-Mar-2002 jeh Read dynamic loading memory requirements into node object
- *!                 data. Added DCD_GetLibraryName().
+ *!		 data. Added DCD_GetLibraryName().
  *! 13-Feb-2002 jeh Get system stack size in GetAttrsFromBuf().
  *! 01-Aug-2001 ag: Added check for PROC "extended" attributes used for
- *!                    DSP-MMU setup. These are private attributes.
+ *!		    DSP-MMU setup. These are private attributes.
  *! 18-Apr-2001 jeh Use COD_OpenBase instead of COD_LoadBase.
  *! 03-Apr-2001 sg: Changed error names to DSP_EDCD* format.
  *! 11-Jan-2001 jeh Changes to DCD_GetObjectDef to match node.cdb, proc.cdb.
  *! 12-Dec-2000 kc: Added DCD_AutoUnregister. MSGNODE, DAISNODE added in
- *!                 GetAttrsFromBuf
+ *!		 GetAttrsFromBuf
  *! 22-Nov-2000 kc: Replaced sprintf() calls with strncat.
  *! 09-Nov-2000 kc: Optimized DCD module.
  *! 30-Oct-2000 kc: Added DCD_AutoRegister function; changed local var. names.
  *! 29-Sep-2000 kc: Added code review changes (src/reviews/dcd_reviews.txt).
  *! 06-Sep-2000 jeh Get message segid, message notification type. Added Atoi()
- *!                 to replace atoi(), until cdb generation can output in
- *!                 decimal format.
+ *!		 to replace atoi(), until cdb generation can output in
+ *!		 decimal format.
  *! 26-Jul-2000 kc: Created.
  *!
  */
@@ -88,12 +88,12 @@
 /*  ----------------------------------- Global defines. */
 #define SIGNATURE       0x5f444344	/* "DCD_" (in reverse). */
 
-#define IsValidHandle(h)    (((h) != NULL) && (h->dwSignature == SIGNATURE))
+#define IsValidHandle(h)	(((h) != NULL) && (h->dwSignature == SIGNATURE))
 
 #define MAX_INT2CHAR_LENGTH     16   /* Maximum int2char len of 32 bit int. */
 
 /* Name of section containing dependent libraries */
-#define DEPLIBSECT              ".dspbridge_deplibs"
+#define DEPLIBSECT		".dspbridge_deplibs"
 
 /* DCD specific structures. */
 struct DCD_MANAGER {
@@ -107,17 +107,13 @@ static u32 cEnumRefs;
 
 extern struct GT_Mask curTrace;
 
-/* helper function prototypes. */
+/* Helper function prototypes. */
 static s32 Atoi(char *pszBuf);
-
 static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 				  enum DSP_DCDOBJTYPE objType,
 				  struct DCD_GENERICOBJ *pGenObj);
-
 static void CompressBuf(char *pszBuf, u32 ulBufSize, s32 cCharSize);
-
 static char DspChar2GppChar(char *pWord, s32 cDspCharSize);
-
 static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 				IN struct DSP_UUID *pUuid,
 				IN OUT u16 *pNumLibs,
@@ -131,9 +127,8 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
  *  Purpose:
  *      Parses the supplied image and resigsters with DCD.
  */
-
 DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,
-			    IN char *pszCoffPath)
+				IN char *pszCoffPath)
 {
 	DSP_STATUS status = DSP_SOK;
 
@@ -161,7 +156,7 @@ DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,
  *      Parses the supplied DSP image and unresiters from DCD.
  */
 DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,
-			     IN char *pszCoffPath)
+				IN char *pszCoffPath)
 {
 	DSP_STATUS status = DSP_SOK;
 
@@ -172,8 +167,7 @@ DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,
 
 	if (IsValidHandle(hDcdMgr)) {
 		status = DCD_GetObjects(hDcdMgr, pszCoffPath,
-				       (DCD_REGISTERFXN)DCD_RegisterObject,
-				       NULL);
+				(DCD_REGISTERFXN)DCD_RegisterObject, NULL);
 	} else {
 		status = DSP_EHANDLE;
 		GT_0trace(curTrace, GT_6CLASS,
@@ -190,9 +184,9 @@ DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,
  *      Creates DCD manager.
  */
 DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
-			    OUT struct DCD_MANAGER **phDcdMgr)
+				OUT struct DCD_MANAGER **phDcdMgr)
 {
-	struct COD_MANAGER *hCodMgr;	/* COD manager handle */
+	struct COD_MANAGER *hCodMgr;		/* COD manager handle */
 	struct DCD_MANAGER *pDcdMgr = NULL;	/* DCD Manager pointer */
 	DSP_STATUS status = DSP_SOK;
 
@@ -203,43 +197,44 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 		 phDcdMgr);
 
 	status = COD_Create(&hCodMgr, pszZlDllName, NULL);
-	if (DSP_SUCCEEDED(status)) {
 
-		/* Create a DCD object. */
-		MEM_AllocObject(pDcdMgr, struct DCD_MANAGER, SIGNATURE);
-		if (pDcdMgr != NULL) {
+	if (DSP_FAILED(status)) {
+		status = DSP_EFAIL;
+		GT_0trace(curTrace, GT_6CLASS,
+			 "DCD_CreateManager: COD_Create failed\n");
+		goto func_end;
+	}
 
-			/* Fill out the object. */
-			pDcdMgr->hCodMgr = hCodMgr;
+	/* Create a DCD object. */
+	MEM_AllocObject(pDcdMgr, struct DCD_MANAGER, SIGNATURE);
+	if (pDcdMgr != NULL) {
+		/* Fill out the object. */
+		pDcdMgr->hCodMgr = hCodMgr;
 
-			/* Return handle to this DCD interface. */
-			*phDcdMgr = pDcdMgr;
+		/* Return handle to this DCD interface. */
+		*phDcdMgr = pDcdMgr;
 
-			GT_2trace(curTrace, GT_5CLASS,
-				 "DCD_CreateManager: pDcdMgr 0x%x, "
-				 " hCodMgr 0x%x", pDcdMgr, hCodMgr);
-		} else {
-			status = DSP_EMEMORY;
+		GT_2trace(curTrace, GT_5CLASS,
+			 "DCD_CreateManager: pDcdMgr 0x%x, "
+			 " hCodMgr 0x%x", pDcdMgr, hCodMgr);
+	} else {
+		status = DSP_EMEMORY;
 
-			/*
-			 * If allocation of DcdManager object failed, delete the
-			 * COD manager.
-			 */
-			COD_Delete(hCodMgr);
+		/*
+		 * If allocation of DcdManager object failed, delete the
+		 * COD manager.
+		 */
+		COD_Delete(hCodMgr);
 
-			GT_0trace(curTrace, GT_6CLASS,
-				 "DCD_CreateManager: MEM_AllocObject failed\n");
-		}
-	} else {
-		status = DSP_EFAIL;
 		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_CreateManager: COD_Create failed\n");
+			 "DCD_CreateManager: MEM_AllocObject failed\n");
 	}
 
 	DBC_Ensure((DSP_SUCCEEDED(status)) || ((hCodMgr == NULL) &&
-		  (status == DSP_EFAIL)) || ((pDcdMgr == NULL) &&
-		  (status == DSP_EMEMORY)));
+			(status == DSP_EFAIL)) || ((pDcdMgr == NULL) &&
+			(status == DSP_EMEMORY)));
 
+func_end:
 	return status;
 }
 
@@ -259,7 +254,6 @@ DSP_STATUS DCD_DestroyManager(IN struct DCD_MANAGER *hDcdMgr)
 		 hDcdMgr);
 
 	if (IsValidHandle(hDcdMgr)) {
-
 		/* Delete the COD manager. */
 		COD_Delete(pDcdMgr->hCodMgr);
 
@@ -317,15 +311,15 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
 		 * Pre-determine final key length. It's length of DCD_REGKEY +
 		 *  "_\0" + length of szObjType string + terminating NULL.
 		 */
-               dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
+		dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
 		DBC_Assert(dwKeyLen < REG_MAXREGPATHLENGTH);
 
 		/* Create proper REG key; concatenate DCD_REGKEY with
 		 * objType. */
-               strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
-               if ((strlen(szRegKey) + strlen("_\0")) <
+		strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
+		if ((strlen(szRegKey) + strlen("_\0")) <
 		   REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, "_\0", 2);
+			strncat(szRegKey, "_\0", 2);
 		} else {
 			status = DSP_EFAIL;
 		}
@@ -339,10 +333,10 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
 			status = DSP_EFAIL;
 		} else {
 			status = DSP_SOK;
-                       if ((strlen(szRegKey) + strlen(szObjType)) <
+			if ((strlen(szRegKey) + strlen(szObjType)) <
 			   REG_MAXREGPATHLENGTH) {
-                               strncat(szRegKey, szObjType,
-                                          strlen(szObjType) + 1);
+				strncat(szRegKey, szObjType,
+					strlen(szObjType) + 1);
 			} else {
 				status = DSP_EFAIL;
 			}
@@ -447,7 +441,7 @@ DSP_STATUS DCD_GetNumDepLibs(IN struct DCD_MANAGER *hDcdMgr,
 		 hDcdMgr);
 
 	status = GetDepLibInfo(hDcdMgr, pUuid, pNumLibs, pNumPersLibs,
-			      NULL, NULL, phase);
+				NULL, NULL, phase);
 
 	return status;
 }
@@ -459,9 +453,9 @@ DSP_STATUS DCD_GetNumDepLibs(IN struct DCD_MANAGER *hDcdMgr,
  *      object type.
  */
 DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
-			   IN struct DSP_UUID *pObjUuid,
-			   IN enum DSP_DCDOBJTYPE objType,
-			   OUT struct DCD_GENERICOBJ *pObjDef)
+			IN struct DSP_UUID *pObjUuid,
+			IN enum DSP_DCDOBJTYPE objType,
+			OUT struct DCD_GENERICOBJ *pObjDef)
 {
 	struct DCD_MANAGER *pDcdMgr = hDcdMgr;	/* pointer to DCD manager */
 	struct COD_LIBRARYOBJ *lib = NULL;
@@ -495,15 +489,17 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 			 "DCD manager handle.\n");
 		goto func_end;
 	}
-	 /* Pre-determine final key length. It's length of DCD_REGKEY +
+
+	/* Pre-determine final key length. It's length of DCD_REGKEY +
 	 *  "_\0" + length of szObjType string + terminating NULL */
-       dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
+	dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
 	DBC_Assert(dwKeyLen < REG_MAXREGPATHLENGTH);
+
 	/* Create proper REG key; concatenate DCD_REGKEY with objType. */
-       strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
+	strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
 
-       if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
-               strncat(szRegKey, "_\0", 2);
+	if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
+		strncat(szRegKey, "_\0", 2);
 	else
 		status = DSP_EFAIL;
 
@@ -513,32 +509,34 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	} else {
 		status = DSP_SOK;
 
-               if ((strlen(szRegKey) + strlen(szObjType)) <
+		if ((strlen(szRegKey) + strlen(szObjType)) <
 		   REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, szObjType, strlen(szObjType) + 1);
+			strncat(szRegKey, szObjType, strlen(szObjType) + 1);
 		} else {
 			status = DSP_EFAIL;
 		}
+
 		/* Create UUID value to set in registry. */
 		UUID_UuidToString(pObjUuid, szUuid, MAXUUIDLEN);
 
-               if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
-                       strncat(szRegKey, szUuid, MAXUUIDLEN);
-               else
+		if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
+			strncat(szRegKey, szUuid, MAXUUIDLEN);
+		else
 			status = DSP_EFAIL;
 
 		/* Retrieve paths from the registry based on struct DSP_UUID */
 		dwBufSize = REG_MAXREGPATHLENGTH;
 	}
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status))
 		status = REG_GetValue(szRegKey, (u8 *)szRegData, &dwBufSize);
-	}
+
 	if (DSP_FAILED(status)) {
 		status = DSP_EUUID;
 		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
 			 "REG_GetValue() failed\n");
 		goto func_end;
 	}
+
 	/* Open COFF file. */
 	status = COD_Open(pDcdMgr->hCodMgr, szRegData, COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
@@ -547,13 +545,16 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 			 "COD_OpenBase() failed\n");
 		goto func_end;
 	}
+
 	/* Ensure szUuid + 1 is not greater than sizeof szSectName. */
-       DBC_Assert((strlen(szUuid) + 1) < sizeof(szSectName));
+	DBC_Assert((strlen(szUuid) + 1) < sizeof(szSectName));
+
 	/* Create section name based on node UUID. A period is
 	 * pre-pended to the UUID string to form the section name.
 	 * I.e. ".24BC8D90_BB45_11d4_B756_006008BDB66F" */
-       strncpy(szSectName, ".", 2);
-       strncat(szSectName, szUuid, strlen(szUuid));
+	strncpy(szSectName, ".", 2);
+	strncat(szSectName, szUuid, strlen(szUuid));
+
 	/* Get section information. */
 	status = COD_GetSection(lib, szSectName, &ulAddr, &ulLen);
 	if (DSP_FAILED(status)) {
@@ -562,10 +563,11 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 			 " COD_GetSection() failed\n");
 		goto func_end;
 	}
+
 	/* Allocate zeroed buffer. */
 	pszCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 #ifdef _DB_TIOMAP
-       if (strstr(szRegData, "iva") == NULL) {
+	if (strstr(szRegData, "iva") == NULL) {
 		/* Locate section by objectID and read its content. */
 		status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
 	} else {
@@ -578,13 +580,14 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 #endif
 	if (DSP_SUCCEEDED(status)) {
 		/* Compres DSP buffer to conform to PC format. */
-               if (strstr(szRegData, "iva") == NULL) {
+		if (strstr(szRegData, "iva") == NULL) {
 			CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
 		} else {
 			CompressBuf(pszCoffBuf, ulLen, 1);
 			GT_0trace(curTrace, GT_4CLASS, "Compressing IVA "
 				 "COFF buffer by 1 for IVA !!\n");
 		}
+
 		/* Parse the content of the COFF buffer. */
 		status = GetAttrsFromBuf(pszCoffBuf, ulLen, objType, pObjDef);
 		if (DSP_FAILED(status)) {
@@ -597,6 +600,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
 			 "COD_ReadSection() failed\n");
 	}
+
 	/* Free the previously allocated dynamic buffer. */
 	MEM_Free(pszCoffBuf);
 func_end:
@@ -605,6 +609,7 @@ func_end:
 
 	if (szUuid)
 		MEM_Free(szUuid);
+
 	return status;
 }
 
@@ -635,6 +640,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			 "DCD_GetObjects: invalid DCD manager handle.\n");
 		goto func_end;
 	}
+
 	/* Open DSP coff file, don't load symbols. */
 	status = COD_Open(pDcdMgr->hCodMgr, pszCoffPath, COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
@@ -643,6 +649,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			 "DCD_AutoRegister: COD_Open() failed\n");
 		goto func_cont;
 	}
+
 	/* Get DCD_RESIGER_SECTION section information. */
 	status = COD_GetSection(lib, DCD_REGISTER_SECTION, &ulAddr, &ulLen);
 	if (DSP_FAILED(status) ||  !(ulLen > 0)) {
@@ -652,6 +659,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			 "- no auto register section\n");
 		goto func_cont;
 	}
+
 	/* Allocate zeroed buffer. */
 	pszCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 #ifdef _DB_TIOMAP
@@ -678,15 +686,19 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			GT_0trace(curTrace, GT_4CLASS, "Compress COFF buffer "
 				 "with 1 word for IVA !!\n");
 		}
+
 		/* Read from buffer and register object in buffer. */
 		pszCur = pszCoffBuf;
 		while ((pToken = strsep(&pszCur, seps)) && *pToken != '\0') {
 			/*  Retrieve UUID string. */
 			UUID_UuidFromString(pToken, &dspUuid);
+
 			/*  Retrieve object type */
 			pToken = strsep(&pszCur, seps);
+
 			/*  Retrieve object type */
 			cObjectType = Atoi(pToken);
+
 			/*
 			 *  Apply registerFxn to the found DCD object.
 			 *  Possible actions include:
@@ -715,6 +727,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjects: "
 			 "COD_ReadSection() failed\n");
 	}
+
 	/* Free the previously allocated dynamic buffer. */
 	MEM_Free(pszCoffBuf);
 func_cont:
@@ -732,9 +745,9 @@ func_end:
  *
  */
 DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
-			     IN struct DSP_UUID *pUuid,
-			     IN OUT char *pstrLibName, IN OUT u32 *pdwSize,
-			     enum NLDR_PHASE phase, OUT bool *fPhaseSplit)
+			IN struct DSP_UUID *pUuid,
+			IN OUT char *pstrLibName, IN OUT u32 *pdwSize,
+			enum NLDR_PHASE phase, OUT bool *fPhaseSplit)
 {
 	char szRegKey[REG_MAXREGPATHLENGTH];
 	char szUuid[MAXUUIDLEN];
@@ -751,16 +764,18 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 		 "DCD_GetLibraryName: hDcdMgr 0x%x, pUuid 0x%x, "
 		 " pstrLibName 0x%x, pdwSize 0x%x\n", hDcdMgr, pUuid,
 		 pstrLibName, pdwSize);
+
 	/*
 	 *  Pre-determine final key length. It's length of DCD_REGKEY +
 	 *  "_\0" + length of szObjType string + terminating NULL.
 	 */
-       dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
+	dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
 	DBC_Assert(dwKeyLen < REG_MAXREGPATHLENGTH);
+
 	/* Create proper REG key; concatenate DCD_REGKEY with objType. */
-       strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
-       if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
-               strncat(szRegKey, "_\0", 2);
+	strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
+	if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
+		strncat(szRegKey, "_\0", 2);
 	else
 		status = DSP_EFAIL;
 
@@ -789,17 +804,17 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 		status = DSP_EFAIL;
 	} else {
 		status = DSP_SOK;
-               if ((strlen(szRegKey) + strlen(szObjType))
-		   < REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, szObjType, strlen(szObjType) + 1);
+		if ((strlen(szRegKey) + strlen(szObjType)) <
+		   REG_MAXREGPATHLENGTH) {
+			strncat(szRegKey, szObjType, strlen(szObjType) + 1);
 		} else {
 			status = DSP_EFAIL;
 		}
 		/* Create UUID value to find match in registry. */
 		UUID_UuidToString(pUuid, szUuid, MAXUUIDLEN);
-               if ((strlen(szRegKey) + MAXUUIDLEN) <
+		if ((strlen(szRegKey) + MAXUUIDLEN) <
 		   REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, szUuid, MAXUUIDLEN);
+			strncat(szRegKey, szUuid, MAXUUIDLEN);
 		} else {
 			status = DSP_EFAIL;
 		}
@@ -808,29 +823,30 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 		/* Retrieve path from the registry based on DSP_UUID */
 		status = REG_GetValue(szRegKey,	(u8 *)pstrLibName, pdwSize);
 	}
+
 	/* If can't find, phases might be registered as generic LIBRARYTYPE */
 	if (DSP_FAILED(status) && phase != NLDR_NOPHASE) {
 		if (fPhaseSplit)
 			*fPhaseSplit = false;
 
-               strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
-               if ((strlen(szRegKey) + strlen("_\0")) <
+		strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
+		if ((strlen(szRegKey) + strlen("_\0")) <
 		   REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, "_\0", 2);
+			strncat(szRegKey, "_\0", 2);
 		} else {
 			status = DSP_EFAIL;
 		}
 		sprintf(szObjType, "%d", DSP_DCDLIBRARYTYPE);
-               if ((strlen(szRegKey) + strlen(szObjType))
+		if ((strlen(szRegKey) + strlen(szObjType))
 		   < REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, szObjType, strlen(szObjType) + 1);
+			strncat(szRegKey, szObjType, strlen(szObjType) + 1);
 		} else {
 			status = DSP_EFAIL;
 		}
 		UUID_UuidToString(pUuid, szUuid, MAXUUIDLEN);
-               if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
-                       strncat(szRegKey, szUuid, MAXUUIDLEN);
-               else
+		if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
+			strncat(szRegKey, szUuid, MAXUUIDLEN);
+		else
 			status = DSP_EFAIL;
 
 		status = REG_GetValue(szRegKey, (u8 *)pstrLibName, pdwSize);
@@ -857,11 +873,11 @@ bool DCD_Init(void)
 		 cRefs);
 
 	if (cRefs == 0) {
-
 		/* Initialize required modules. */
 		fInitMEM = MEM_Init();
 		fInitCOD = COD_Init();
 		fInitREG = REG_Init();
+
 		if (!fInitMEM || !fInitCOD || !fInitREG) {
 			fInit = false;
 			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
@@ -897,91 +913,94 @@ bool DCD_Init(void)
  *      If pszPathName == NULL, unregister the specified DCD object.
  */
 DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
-			     IN enum DSP_DCDOBJTYPE objType,
-			     IN char *pszPathName)
+			IN enum DSP_DCDOBJTYPE objType,
+			IN char *pszPathName)
 {
 	DSP_STATUS status = DSP_SOK;
 	char szRegKey[REG_MAXREGPATHLENGTH];
 	char szUuid[MAXUUIDLEN + 1];
 	u32 dwPathSize = 0;
-	u32 dwKeyLen;		/* Len of REG key. */
+	u32 dwKeyLen;				/* Len of REG key. */
 	char szObjType[MAX_INT2CHAR_LENGTH];	/* str. rep. of objType. */
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pUuid != NULL);
 	DBC_Require((objType == DSP_DCDNODETYPE) ||
-		   (objType == DSP_DCDPROCESSORTYPE) ||
-		   (objType == DSP_DCDLIBRARYTYPE) ||
-		   (objType == DSP_DCDCREATELIBTYPE) ||
-		   (objType == DSP_DCDEXECUTELIBTYPE) ||
-		   (objType == DSP_DCDDELETELIBTYPE));
+			(objType == DSP_DCDPROCESSORTYPE) ||
+			(objType == DSP_DCDLIBRARYTYPE) ||
+			(objType == DSP_DCDCREATELIBTYPE) ||
+			(objType == DSP_DCDEXECUTELIBTYPE) ||
+			(objType == DSP_DCDDELETELIBTYPE));
 
 	GT_3trace(curTrace, GT_ENTER, "DCD_RegisterObject: object UUID 0x%x, "
 		 "objType %d, szPathName %s\n", pUuid, objType, pszPathName);
+
 	/*
 	 * Pre-determine final key length. It's length of DCD_REGKEY +
 	 *  "_\0" + length of szObjType string + terminating NULL.
 	 */
-       dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
+	dwKeyLen = strlen(DCD_REGKEY) + 1 + sizeof(szObjType) + 1;
 	DBC_Assert(dwKeyLen < REG_MAXREGPATHLENGTH);
+
 	/* Create proper REG key; concatenate DCD_REGKEY with objType. */
-       strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
-       if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
-               strncat(szRegKey, "_\0", 2);
-	else
+	strncpy(szRegKey, DCD_REGKEY, strlen(DCD_REGKEY) + 1);
+	if ((strlen(szRegKey) + strlen("_\0")) < REG_MAXREGPATHLENGTH)
+		strncat(szRegKey, "_\0", 2);
+	else {
 		status = DSP_EFAIL;
+		goto func_end;
+	}
 
 	status = snprintf(szObjType, MAX_INT2CHAR_LENGTH, "%d", objType);
 	if (status == -1) {
 		status = DSP_EFAIL;
 	} else {
 		status = DSP_SOK;
-               if ((strlen(szRegKey) + strlen(szObjType)) <
+		if ((strlen(szRegKey) + strlen(szObjType)) <
 		   REG_MAXREGPATHLENGTH) {
-                       strncat(szRegKey, szObjType, strlen(szObjType) + 1);
-		} else {
+			strncat(szRegKey, szObjType, strlen(szObjType) + 1);
+		} else
 			status = DSP_EFAIL;
-		}
+
 		/* Create UUID value to set in registry. */
 		UUID_UuidToString(pUuid, szUuid, MAXUUIDLEN);
-               if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
-                       strncat(szRegKey, szUuid, MAXUUIDLEN);
-               else
+		if ((strlen(szRegKey) + MAXUUIDLEN) < REG_MAXREGPATHLENGTH)
+			strncat(szRegKey, szUuid, MAXUUIDLEN);
+		else
 			status = DSP_EFAIL;
-
 	}
 
-	if (DSP_SUCCEEDED(status)) {
-		/*
-		 * If pszPathName != NULL, perform registration, otherwise,
-		 * perform unregistration.
-		 */
-		if (pszPathName) {
-			/* Add new reg value (UUID+objType) with COFF path
-			 * info. */
-                       dwPathSize = strlen(pszPathName) + 1;
-			status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
-			GT_2trace(curTrace, GT_6CLASS, "REG_SetValue  "
-				  "(u8 *)pszPathName=%s, dwPathSize=%d\n",
-				  pszPathName, dwPathSize);
-
-			if (DSP_FAILED(status)) {
-				status = DSP_EFAIL;
-				GT_0trace(curTrace, GT_6CLASS,
+	if (DSP_FAILED(status))
+		goto func_end;
+
+	/*
+	 * If pszPathName != NULL, perform registration, otherwise,
+	 * perform unregistration.
+	 */
+	if (pszPathName) {
+		/* Add new reg value (UUID+objType) with COFF path info */
+		dwPathSize = strlen(pszPathName) + 1;
+		status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
+		GT_2trace(curTrace, GT_6CLASS, "REG_SetValue "
+			"(u8 *)pszPathName=%s, dwPathSize=%d\n",
+			pszPathName, dwPathSize);
+
+		if (DSP_FAILED(status)) {
+			status = DSP_EFAIL;
+			GT_0trace(curTrace, GT_6CLASS,
 				  "DCD_RegisterObject: REG_SetValue failed!\n");
-			}
-		} else {
-			/* Deregister an existing object. */
-			status = REG_DeleteValue(szRegKey);
-			if (DSP_FAILED(status)) {
-				status = DSP_EFAIL;
-				GT_0trace(curTrace, GT_6CLASS,
-					"DCD_UnregisterObject: "
-					"REG_DeleteValue failed!\n");
-			}
+		}
+	} else {
+		/* Deregister an existing object */
+		status = REG_DeleteValue(szRegKey);
+		if (DSP_FAILED(status)) {
+			status = DSP_EFAIL;
+			GT_0trace(curTrace, GT_6CLASS, "DCD_UnregisterObject: "
+				"REG_DeleteValue failed!\n");
 		}
 	}
 
+
 	if (DSP_SUCCEEDED(status)) {
 		/*
 		 *  Because the node database has been updated through a
@@ -990,10 +1009,9 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 		 *  current enumerations to reflect this update in the node
 		 *  database.
 		 */
-
 		cEnumRefs = 0;
 	}
-
+func_end:
 	return status;
 }
 
@@ -1080,7 +1098,6 @@ static s32 Atoi(char *pszBuf)
 				c = c - 'a' + 10;
 			else
 				c -= '0';
-
 		}
 		result += c;
 		++pch;
@@ -1116,7 +1133,6 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		    || (objType == DSP_DCDPROCESSORTYPE));
 	DBC_Require(pGenObj != NULL);
 
-
 	switch (objType) {
 	case DSP_DCDNODETYPE:
 		/*
@@ -1137,12 +1153,12 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		token = strsep(&pszCur, seps);
 
 		/* acName */
-               DBC_Require(token);
+		DBC_Require(token);
 		cLen = strlen(token);
 		if (cLen > DSP_MAXNAMELEN - 1)
 			cLen = DSP_MAXNAMELEN - 1;
 
-               strncpy(pGenObj->objData.nodeObj.ndbProps.acName,
+		strncpy(pGenObj->objData.nodeObj.ndbProps.acName,
 			   token, cLen);
 		pGenObj->objData.nodeObj.ndbProps.acName[cLen] = '\0';
 		token = strsep(&pszCur, seps);
@@ -1220,8 +1236,8 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 			Atoi(token);
 		token = strsep(&pszCur, seps);
 
-		/* char * pstrCreatePhaseFxn */
-               DBC_Require(token);
+		/* char *pstrCreatePhaseFxn */
+		DBC_Require(token);
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrCreatePhaseFxn =
 			MEM_Calloc(cLen + 1, MEM_PAGED);
@@ -1230,8 +1246,8 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		pGenObj->objData.nodeObj.pstrCreatePhaseFxn[cLen] = '\0';
 		token = strsep(&pszCur, seps);
 
-		/* char * pstrExecutePhaseFxn */
-               DBC_Require(token);
+		/* char *pstrExecutePhaseFxn */
+		DBC_Require(token);
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrExecutePhaseFxn =
 			 MEM_Calloc(cLen + 1, MEM_PAGED);
@@ -1240,8 +1256,8 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		pGenObj->objData.nodeObj.pstrExecutePhaseFxn[cLen] = '\0';
 		token = strsep(&pszCur, seps);
 
-		/* char * pstrDeletePhaseFxn */
-               DBC_Require(token);
+		/* char *pstrDeletePhaseFxn */
+		DBC_Require(token);
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrDeletePhaseFxn =
 			MEM_Calloc(cLen + 1, MEM_PAGED);
@@ -1258,7 +1274,7 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		pGenObj->objData.nodeObj.uMsgNotifyType = Atoi(token);
 		token = strsep(&pszCur, seps);
 
-		/* char * pstrIAlgName */
+		/* char *pstrIAlgName */
 		if (token) {
 			cLen = strlen(token);
 			pGenObj->objData.nodeObj.pstrIAlgName =
@@ -1388,7 +1404,6 @@ static void CompressBuf(char *pszBuf, u32 ulBufSize, s32 cCharSize)
 		return;
 
 	for (q = pszBuf; q < (pszBuf + ulBufSize);) {
-
 		ch = DspChar2GppChar(q, cCharSize);
 		if (ch == '\\') {
 			q += cCharSize;
@@ -1424,7 +1439,6 @@ static void CompressBuf(char *pszBuf, u32 ulBufSize, s32 cCharSize)
 	/* NULL out remainder of buffer. */
 	while (p < q)
 		*p++ = '\0';
-
 }
 
 /*
@@ -1460,8 +1474,8 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 	char *pszCur;
 	char *pszFileName = NULL;
 	struct COD_LIBRARYOBJ *lib = NULL;
-	u32 ulAddr = 0;	/* Used by COD_GetSection */
-	u32 ulLen = 0;	/* Used by COD_GetSection */
+	u32 ulAddr = 0;				/* Used by COD_GetSection */
+	u32 ulLen = 0;				/* Used by COD_GetSection */
 	u32 dwDataSize = COD_MAXPATHLENGTH;
 	char seps[] = ", ";
 	char *pToken = NULL;
@@ -1494,6 +1508,7 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 		status = DCD_GetLibraryName(hDcdMgr, pUuid, pszFileName,
 			 &dwDataSize, phase, NULL);
 	}
+
 	/* Open the library */
 	if (DSP_SUCCEEDED(status)) {
 		status = COD_Open(pDcdMgr->hCodMgr, pszFileName,
@@ -1525,6 +1540,7 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 
 	/* Compress and format DSP buffer to conform to PC format. */
 	CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
+
 	/* Read from buffer */
 	pszCur = pszCoffBuf;
 	while ((pToken = strsep(&pszCur, seps)) && *pToken != '\0') {
@@ -1564,4 +1580,3 @@ func_cont:
 
 	return status;
 }
-
-- 
1.6.2.4

