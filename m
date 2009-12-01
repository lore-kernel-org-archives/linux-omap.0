From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [RFC][PATCH] DSPBRIDGE: Remove GT_Trace for curTrace mask
Date: Mon, 30 Nov 2009 23:44:10 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426FE26D7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbZLAFoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 00:44:10 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Removed GT_Trace for curTrace mask which was enabled using "DD"

Used %p modifier to print pointers.

Removed near AOE style errors:
 - braces for single if statements
 - simplify if conditions
 - Reduced indentation on DRV_ProcFreeNodeRes for a bit
   more legible debug statements

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c  |  163 ++++++----------
 drivers/dsp/bridge/rmgr/drv.c    |  380 ++++++++++++++++----------------------
 drivers/dsp/bridge/rmgr/dspdrv.c |   38 ++---
 3 files changed, 238 insertions(+), 343 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 47241b1..4b213c4 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -67,8 +67,6 @@ struct DCD_MANAGER {
 static u32 cRefs;
 static u32 cEnumRefs;

-extern struct GT_Mask curTrace;
-
 /* Helper function prototypes. */
 static s32 Atoi(char *pszBuf);
 static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
@@ -96,8 +94,7 @@ DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,

        DBC_Require(cRefs > 0);

-       GT_1trace(curTrace, GT_ENTER, "DCD_AutoRegister: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        if (IsValidHandle(hDcdMgr)) {
                status = DCD_GetObjects(hDcdMgr, pszCoffPath,
@@ -105,8 +102,7 @@ DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,
                                        (void *)pszCoffPath);
        } else {
                status = DSP_EHANDLE;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_AutoRegister: invalid DCD manager handle.\n");
+               pr_debug("%s: invalid DCD manager handle\n", __func__);
        }

        return status;
@@ -124,17 +120,14 @@ DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,

        DBC_Require(cRefs > 0);

-       GT_1trace(curTrace, GT_ENTER, "DCD_AutoUnregister: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        if (IsValidHandle(hDcdMgr)) {
                status = DCD_GetObjects(hDcdMgr, pszCoffPath,
                                (DCD_REGISTERFXN)DCD_RegisterObject, NULL);
        } else {
                status = DSP_EHANDLE;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_AutoUnregister: invalid DCD manager"
-                        " handle.\n");
+               pr_debug("%s: invalid DCD manager handle\n", __func__);
        }

        return status;
@@ -155,15 +148,13 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
        DBC_Require(cRefs >= 0);
        DBC_Require(phDcdMgr);

-       GT_1trace(curTrace, GT_ENTER, "DCD_CreateManager: phDcdMgr 0x%x\n",
-                phDcdMgr);
+       pr_debug("%s: phDcdMgr %p\n", __func__, phDcdMgr);

        status = COD_Create(&hCodMgr, pszZlDllName, NULL);

        if (DSP_FAILED(status)) {
                status = DSP_EFAIL;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_CreateManager: COD_Create failed\n");
+               pr_debug("%s: COD_Create failed\n", __func__);
                goto func_end;
        }

@@ -176,9 +167,8 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
                /* Return handle to this DCD interface. */
                *phDcdMgr = pDcdMgr;

-               GT_2trace(curTrace, GT_5CLASS,
-                        "DCD_CreateManager: pDcdMgr 0x%x, "
-                        " hCodMgr 0x%x", pDcdMgr, hCodMgr);
+               pr_debug("%s: pDcdMgr %p, hCodMgr %p", __func__, pDcdMgr,
+                                                               hCodMgr);
        } else {
                status = DSP_EMEMORY;

@@ -188,8 +178,7 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
                 */
                COD_Delete(hCodMgr);

-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_CreateManager: MEM_AllocObject failed\n");
+               pr_debug("%s: MEM_AllocObject failed\n", __func__);
        }

        DBC_Ensure((DSP_SUCCEEDED(status)) || ((hCodMgr == NULL) &&
@@ -212,8 +201,7 @@ DSP_STATUS DCD_DestroyManager(IN struct DCD_MANAGER *hDcdMgr)

        DBC_Require(cRefs >= 0);

-       GT_1trace(curTrace, GT_ENTER, "DCD_DestroyManager: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        if (IsValidHandle(hDcdMgr)) {
                /* Delete the COD manager. */
@@ -224,8 +212,7 @@ DSP_STATUS DCD_DestroyManager(IN struct DCD_MANAGER *hDcdMgr)

                status = DSP_SOK;
        } else {
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_DestroyManager: invalid DCD manager handle.\n");
+               pr_debug("%s: invalid DCD manager handle\n", __func__);
        }

        return status;
@@ -253,9 +240,8 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
        DBC_Require(cIndex >= 0);
        DBC_Require(pUuid != NULL);

-       GT_3trace(curTrace, GT_ENTER,
-                "DCD_EnumerateObject: cIndex %d, objType %d, "
-                " pUuid 0x%x\n", cIndex, objType, pUuid);
+       pr_debug("%s: cIndex %d, objType %d, pUuid %p\n", __func__, cIndex,
+                                                               objType, pUuid);

        if ((cIndex != 0) && (cEnumRefs == 0)) {
                /*
@@ -327,9 +313,8 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
                        status = DSP_SENUMCOMPLETE;
                } else {
                        status = DSP_EFAIL;
-                       GT_1trace(curTrace, GT_6CLASS,
-                                "DCD_EnumerateObject: REG_EnumValue"
-                                " failed, status = 0x%x\n", status);
+                       pr_debug("%s: REG_EnumValue failed, status = 0x%x\n",
+                                                       __func__, status);
                }
        }

@@ -347,7 +332,7 @@ void DCD_Exit(void)
 {
        DBC_Require(cRefs > 0);

-       GT_1trace(curTrace, GT_5CLASS, "DCD_Exit: cRefs 0x%x\n", cRefs);
+       pr_debug("%s: cRefs 0x%x\n", __func__, cRefs);

        cRefs--;
        if (cRefs == 0) {
@@ -375,8 +360,7 @@ DSP_STATUS DCD_GetDepLibs(IN struct DCD_MANAGER *hDcdMgr,
        DBC_Require(pDepLibUuids != NULL);
        DBC_Require(pPersistentDepLibs != NULL);

-       GT_1trace(curTrace, GT_ENTER, "DCD_GetDepLibs: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        status = GetDepLibInfo(hDcdMgr, pUuid, &numLibs, NULL, pDepLibUuids,
                              pPersistentDepLibs, phase);
@@ -399,8 +383,7 @@ DSP_STATUS DCD_GetNumDepLibs(IN struct DCD_MANAGER *hDcdMgr,
        DBC_Require(pNumPersLibs != NULL);
        DBC_Require(pUuid != NULL);

-       GT_1trace(curTrace, GT_ENTER, "DCD_GetNumDepLibs: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        status = GetDepLibInfo(hDcdMgr, pUuid, pNumLibs, pNumPersLibs,
                                NULL, NULL, phase);
@@ -437,18 +420,16 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
        DBC_Require(pObjDef != NULL);
        DBC_Require(pObjUuid != NULL);

-       GT_4trace(curTrace, GT_ENTER,
-                "DCD_GetObjectDef: hDcdMgr 0x%x, " "objUuid"
-                " 0x%x, objType 0x%x, pObjDef 0x%x\n", hDcdMgr, pObjUuid,
-                objType, pObjDef);
+       pr_debug("%s: hDcdMgr %p, objUuid %p, objType 0x%x, pObjDef %p\n",
+                               __func__, hDcdMgr, pObjUuid, objType, pObjDef);
+
        szUuid = (char *)MEM_Calloc(MAXUUIDLEN, MEM_PAGED);
        if (!szUuid)
                return status = DSP_EMEMORY;

        if (!IsValidHandle(hDcdMgr)) {
                status = DSP_EHANDLE;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: invalid "
-                        "DCD manager handle.\n");
+               pr_debug("%s: invalid DCD manager handle\n", __func__);
                goto func_end;
        }

@@ -494,8 +475,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,

        if (DSP_FAILED(status)) {
                status = DSP_EUUID;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-                        "REG_GetValue() failed\n");
+               pr_debug("%s: REG_GetValue() failed\n", __func__);
                goto func_end;
        }

@@ -503,8 +483,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
        status = COD_Open(pDcdMgr->hCodMgr, szRegData, COD_NOLOAD, &lib);
        if (DSP_FAILED(status)) {
                status = DSP_EDCDLOADBASE;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-                        "COD_OpenBase() failed\n");
+               pr_debug("%s: COD_OpenBase() failed\n", __func__);
                goto func_end;
        }

@@ -521,8 +500,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
        status = COD_GetSection(lib, szSectName, &ulAddr, &ulLen);
        if (DSP_FAILED(status)) {
                status = DSP_EDCDGETSECT;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef:"
-                        " COD_GetSection() failed\n");
+               pr_debug("%s: COD_GetSection failed\n", __func__);
                goto func_end;
        }

@@ -534,8 +512,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
                status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
        } else {
                status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
-               GT_0trace(curTrace, GT_4CLASS,
-                        "Skipped Byte swap for IVA !!\n");
+               pr_debug("%s: Skipped Byte swap for IVA !!\n", __func__);
        }
 #else
        status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
@@ -546,21 +523,19 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
                        CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
                } else {
                        CompressBuf(pszCoffBuf, ulLen, 1);
-                       GT_0trace(curTrace, GT_4CLASS, "Compressing IVA "
-                                "COFF buffer by 1 for IVA !!\n");
+                       pr_debug("%s: Compressing IVA COFF buffer by 1 "
+                                               "for IVA!!\n", __func__);
                }

                /* Parse the content of the COFF buffer. */
                status = GetAttrsFromBuf(pszCoffBuf, ulLen, objType, pObjDef);
                if (DSP_FAILED(status)) {
                        status = DSP_EDCDPARSESECT;
-                       GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-                                "GetAttrsFromBuf() failed\n");
+                       pr_debug("%s: GetAttrsFromBuf() failed\n", __func__);
                }
        } else {
                status = DSP_EDCDREADSECT;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-                        "COD_ReadSection() failed\n");
+               pr_debug("%s: COD_ReadSection() failed\n", __func__);
        }

        /* Free the previously allocated dynamic buffer. */
@@ -594,12 +569,12 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
        s32 cObjectType;

        DBC_Require(cRefs > 0);
-       GT_1trace(curTrace, GT_ENTER,
-                "DCD_GetObjects: hDcdMgr 0x%x\n", hDcdMgr);
+
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);
+
        if (!IsValidHandle(hDcdMgr)) {
                status = DSP_EHANDLE;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_GetObjects: invalid DCD manager handle.\n");
+               pr_debug("%s: invalid DCD manager handle\n", __func__);
                goto func_end;
        }

@@ -607,8 +582,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
        status = COD_Open(pDcdMgr->hCodMgr, pszCoffPath, COD_NOLOAD, &lib);
        if (DSP_FAILED(status)) {
                status = DSP_EDCDLOADBASE;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_AutoRegister: COD_Open() failed\n");
+               pr_debug("%s: COD_Open() failed\n", __func__);
                goto func_cont;
        }

@@ -616,9 +590,8 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
        status = COD_GetSection(lib, DCD_REGISTER_SECTION, &ulAddr, &ulLen);
        if (DSP_FAILED(status) ||  !(ulLen > 0)) {
                status = DSP_EDCDNOAUTOREGISTER;
-               GT_0trace(curTrace, GT_6CLASS,
-                        "DCD_GetObjects: COD_GetSection() "
-                        "- no auto register section\n");
+               pr_debug("%s: COD_GetSection() - no auto register section\n",
+                                                               __func__);
                goto func_cont;
        }

@@ -630,7 +603,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
                status = COD_ReadSection(lib, DCD_REGISTER_SECTION,
                                        pszCoffBuf, ulLen);
        } else {
-               GT_0trace(curTrace, GT_4CLASS, "Skipped Byte swap for IVA!!\n");
+               pr_debug("%s: Skipped Byte swap for IVA!!\n", __func__);
                status = COD_ReadSection(lib, DCD_REGISTER_SECTION,
                                        pszCoffBuf, ulLen);
        }
@@ -639,14 +612,13 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 #endif
        if (DSP_SUCCEEDED(status)) {
                /* Compress DSP buffer to conform to PC format. */
-               GT_0trace(curTrace, GT_4CLASS,
-                        "Successfully read section !!\n");
+               pr_debug("%s: Successfully read section!!\n", __func__);
                if (strstr(pszCoffPath, "iva") == NULL) {
                        CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
                } else {
                        CompressBuf(pszCoffBuf, ulLen, 1);
-                       GT_0trace(curTrace, GT_4CLASS, "Compress COFF buffer "
-                                "with 1 word for IVA !!\n");
+                       pr_debug("%s: Compress COFF buffer with 1 word "
+                                               "for IVA!!\n", __func__);
                }

                /* Read from buffer and register object in buffer. */
@@ -669,25 +641,21 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
                         *  2) Unregister found DCD object (when handle == NULL)
                         *  3) Add overlay node.
                         */
-                       GT_1trace(curTrace, GT_4CLASS, "Registering objtype "
-                                "%d \n", cObjectType);
+                       pr_debug("%s: Registering objtype %d \n", __func__,
+                                                               cObjectType);
                        status = registerFxn(&dspUuid, cObjectType, handle);
                        if (DSP_SUCCEEDED(status)) {
-                               GT_1trace(curTrace, GT_5CLASS,
-                                        "DCD_GetObjects: status 0x%x\n",
-                                        status);
+                               pr_debug("%s: status 0x%x\n", __func__, status);
                        } else {
-                               GT_0trace(curTrace, GT_6CLASS,
-                                        "DCD_GetObjects: "
-                                        "registration() failed\n");
+                               pr_debug("%s: registration() failed\n",
+                                                               __func__);
                                /* if error occurs, break from while loop. */
                                break;
                        }
                }
        } else {
                status = DSP_EDCDREADSECT;
-               GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjects: "
-                        "COD_ReadSection() failed\n");
+               pr_debug("%s: COD_ReadSection() failed\n", __func__);
        }

        /* Free the previously allocated dynamic buffer. */
@@ -722,10 +690,8 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
        DBC_Require(pdwSize != NULL);
        DBC_Require(IsValidHandle(hDcdMgr));

-       GT_4trace(curTrace, GT_ENTER,
-                "DCD_GetLibraryName: hDcdMgr 0x%x, pUuid 0x%x, "
-                " pstrLibName 0x%x, pdwSize 0x%x\n", hDcdMgr, pUuid,
-                pstrLibName, pdwSize);
+       pr_debug("%s: hDcdMgr %p, pUuid %p, pstrLibName %s, pdwSize %p\n",
+                               __func__, hDcdMgr, pUuid, pstrLibName, pdwSize);

        /*
         *  Pre-determine final key length. It's length of DCD_REGKEY +
@@ -830,8 +796,7 @@ bool DCD_Init(void)

        DBC_Require(cRefs >= 0);

-       GT_1trace(curTrace, GT_ENTER, "DCD_Init: (on enter) cRefs = 0x%x\n",
-                cRefs);
+       pr_debug("%s: (on enter) cRefs = 0x%x\n", __func__, cRefs);

        if (cRefs == 0) {
                /* Initialize required modules. */
@@ -841,7 +806,7 @@ bool DCD_Init(void)

                if (!fInitMEM || !fInitCOD || !fInitREG) {
                        fInit = false;
-                       GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
+                       pr_debug("%s: failed\n", __func__);
                        /* Exit initialized modules. */
                        if (fInitMEM)
                                MEM_Exit();
@@ -858,9 +823,7 @@ bool DCD_Init(void)
        if (fInit)
                cRefs++;

-
-       GT_1trace(curTrace, GT_5CLASS, "DCD_Init: (on exit) cRefs = 0x%x\n",
-                cRefs);
+       pr_debug("%s: (on exit) cRefs = 0x%x\n", __func__, cRefs);

        DBC_Ensure((fInit && (cRefs > 0)) || (!fInit && (cRefs == 0)));

@@ -893,8 +856,8 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
                        (objType == DSP_DCDEXECUTELIBTYPE) ||
                        (objType == DSP_DCDDELETELIBTYPE));

-       GT_3trace(curTrace, GT_ENTER, "DCD_RegisterObject: object UUID 0x%x, "
-                "objType %d, szPathName %s\n", pUuid, objType, pszPathName);
+       pr_debug("%s: object UUID %p, objType %d, szPathName %s\n", __func__,
+                                               pUuid, objType, pszPathName);

        /*
         * Pre-determine final key length. It's length of DCD_REGKEY +
@@ -942,21 +905,18 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
                /* Add new reg value (UUID+objType) with COFF path info. */
                dwPathSize = strlen(pszPathName) + 1;
                status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
-               GT_2trace(curTrace, GT_6CLASS, "REG_SetValue  "
-                         "(u8 *)pszPathName=%s, dwPathSize=%d\n",
-                         pszPathName, dwPathSize);
+               pr_debug("%s: to REG_SetValue pszPathName %s, dwPathSize %d\n",
+                                       __func__, pszPathName, dwPathSize);
                if (DSP_FAILED(status)) {
                        status = DSP_EFAIL;
-                       GT_0trace(curTrace, GT_6CLASS,
-                               "DCD_RegisterObject: REG_SetValue failed!\n");
+                       pr_debug("%s: REG_SetValue failed!\n", __func__);
                }
        } else {
                /* Deregister an existing object. */
                status = REG_DeleteValue(szRegKey);
                if (DSP_FAILED(status)) {
                        status = DSP_EFAIL;
-                       GT_0trace(curTrace, GT_6CLASS, "DCD_UnregisterObject: "
-                               "REG_DeleteValue failed!\n");
+                       pr_debug("%s: REG_DeleteValue failed!\n", __func__);
                }
        }

@@ -993,9 +953,7 @@ DSP_STATUS DCD_UnregisterObject(IN struct DSP_UUID *pUuid,
                   (objType == DSP_DCDEXECUTELIBTYPE) ||
                   (objType == DSP_DCDDELETELIBTYPE));

-       GT_2trace(curTrace, GT_ENTER,
-                "DCD_UnregisterObject: object UUID 0x%x, "
-                "objType %d\n", pUuid, objType);
+       pr_debug("%s: object UUID %p, objType %d\n", __func__, pUuid, objType);

        /*
         *  When DCD_RegisterObject is called with NULL as pathname,
@@ -1448,8 +1406,7 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
        DBC_Require(pNumLibs != NULL);
        DBC_Require(pUuid != NULL);

-       GT_1trace(curTrace, GT_ENTER, "DCD_GetNumDepLibs: hDcdMgr 0x%x\n",
-                hDcdMgr);
+       pr_debug("%s: hDcdMgr %p\n", __func__, hDcdMgr);

        /*  Initialize to 0 dependent libraries, if only counting number of
         *  dependent libraries */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index d455c5b..4561606 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -68,10 +68,6 @@ struct DRV_EXT {
 /*  ----------------------------------- Globals */
 static s32 cRefs;

-#if GT_TRACE
-extern struct GT_Mask curTrace;
-#endif
-
 /*  ----------------------------------- Function Prototypes */
 static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 fRequest);
 static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
@@ -88,13 +84,11 @@ DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
 {
        struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
        DSP_STATUS status1 = DSP_SOK;
-       if (pCtxt != NULL) {
+       if (pCtxt != NULL)
                pCtxt->resState = status;
-       } else {
-               GT_0trace(curTrace, GT_ENTER,
-                        "DRV_ProcUpdatestate: Failed to update "
-                        "process state");
-       }
+       else
+               pr_debug("%s: Failed to update process state\n", __func__);
+
        return status1;
 }

@@ -107,12 +101,16 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
        struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
        DSP_STATUS status = DSP_SOK;
        struct NODE_RES_OBJECT   *pTempNodeRes = NULL;
-       GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 1");
+
+       pr_debug("Entered %s, hNode %p, hPCtxt %p\n",
+                                                __func__, hNode, hPCtxt);
+
        *pNodeRes = (struct NODE_RES_OBJECT *)MEM_Calloc
                    (1 * sizeof(struct NODE_RES_OBJECT), MEM_PAGED);
        DBC_Assert(hPCtxt != NULL);
        if ((*pNodeRes == NULL) || (hPCtxt == NULL)) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 12");
+               pr_debug("%s: Invalid Arg *pNodeRes %p hPCtxt %p\n",
+                                               __func__, *pNodeRes, hPCtxt);
                status = DSP_EHANDLE;
        }
        if (DSP_SUCCEEDED(status)) {
@@ -123,15 +121,13 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
                                pTempNodeRes = pTempNodeRes->next;

                        pTempNodeRes->next = *pNodeRes;
-                       GT_0trace(curTrace, GT_ENTER,
-                                "DRV_InsertNodeResElement: 2");
                } else {
                        pCtxt->pNodeList = *pNodeRes;
-                       GT_0trace(curTrace, GT_ENTER,
-                                "DRV_InsertNodeResElement: 3");
                }
        }
-       GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 4");
+
+       pr_debug("Leaving %s, status 0x%x\n", __func__, status);
+
        return status;
 }

@@ -146,7 +142,9 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
        struct NODE_RES_OBJECT *pTempNode = pCtxt->pNodeList;

        DBC_Assert(hPCtxt != NULL);
-       GT_0trace(curTrace, GT_ENTER, "\nDRV_RemoveNodeResElement: 1\n");
+
+       pr_debug("%s, hPCtxt %p\n", __func__, hPCtxt);
+
        while ((pTempNode != NULL) && (pTempNode != pNodeRes)) {
                pTempNode2 = pTempNode;
                pTempNode = pTempNode->next;
@@ -175,35 +173,31 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
        DBC_Assert(hPCtxt != NULL);
        pNodeList = pCtxt->pNodeList;
        while (pNodeList != NULL) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_ProcFreeNodeRes: 1");
                pNodeRes = pNodeList;
                pNodeList = pNodeList->next;
-               if (pNodeRes->nodeAllocated) {
-                       nState = NODE_GetState(pNodeRes->hNode) ;
-                       GT_1trace(curTrace, GT_5CLASS,
-                               "DRV_ProcFreeNodeRes: Node state %x\n", nState);
-                       if (nState <= NODE_DELETING) {
-                               if ((nState == NODE_RUNNING) ||
-                                       (nState == NODE_PAUSED) ||
-                                       (nState == NODE_TERMINATING)) {
-                                       GT_1trace(curTrace, GT_5CLASS,
-                                       "Calling Node_Terminate for Node:"
-                                       " 0x%x\n", pNodeRes->hNode);
-                                       status = NODE_Terminate
-                                               (pNodeRes->hNode, &status);
-                                       GT_1trace(curTrace, GT_5CLASS,
-                                                "Calling Node_Delete for Node:"
-                                                " 0x%x\n", pNodeRes->hNode);
-                                       status = NODE_Delete(pNodeRes->hNode,
-                                                       pCtxt);
-                                       GT_1trace(curTrace, GT_5CLASS,
-                                       "the status after the NodeDelete %x\n",
-                                       status);
-                               } else if ((nState == NODE_ALLOCATED)
-                                       || (nState == NODE_CREATED))
-                                       status = NODE_Delete(pNodeRes->hNode,
-                                                       pCtxt);
-                       }
+               if (!pNodeRes->nodeAllocated)
+                       continue;
+
+               nState = NODE_GetState(pNodeRes->hNode);
+               pr_debug("%s: Node state %d\n", __func__, nState);
+               if (nState > NODE_DELETING)
+                       continue;
+
+               if ((nState == NODE_RUNNING) || (nState == NODE_PAUSED) ||
+                  (nState == NODE_TERMINATING)) {
+                       status = NODE_Terminate(pNodeRes->hNode, &status);
+                       pr_debug("%s: Called Node_Terminate for Node: %p, "
+                                               "status 0x%x\n", __func__,
+                                               pNodeRes->hNode, status);
+
+                       pr_debug("%s: Calling Node_Delete for Node: %p\n",
+                                               __func__, pNodeRes->hNode);
+                       status = NODE_Delete(pNodeRes->hNode, pCtxt);
+                       pr_debug("%s: status after the NodeDelete %x\n",
+                                                       __func__, status);
+               } else if ((nState == NODE_ALLOCATED)
+                                || (nState == NODE_CREATED)) {
+                       status = NODE_Delete(pNodeRes->hNode, pCtxt);
                }
        }
        return status;
@@ -221,15 +215,14 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
        *pDMMRes = (struct DMM_RES_OBJECT *)
                    MEM_Calloc(1 * sizeof(struct DMM_RES_OBJECT), MEM_PAGED);
        DBC_Assert(hPCtxt != NULL);
-       GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 1");
+
        if ((*pDMMRes == NULL) || (hPCtxt == NULL)) {
-               GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
+               pr_debug("%s: Invalid Arg *pDMMRes %p, hPCtxt %p\n",
+                                               __func__, *pDMMRes, hPCtxt);
                status = DSP_EHANDLE;
        }
        if (DSP_SUCCEEDED(status)) {
                if (pCtxt->pDMMList != NULL) {
-                       GT_0trace(curTrace, GT_5CLASS,
-                                "DRV_InsertDMMResElement: 3");
                        pTempDMMRes = pCtxt->pDMMList;
                        while (pTempDMMRes->next != NULL)
                                pTempDMMRes = pTempDMMRes->next;
@@ -237,11 +230,9 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
                        pTempDMMRes->next = *pDMMRes;
                } else {
                        pCtxt->pDMMList = *pDMMRes;
-                       GT_0trace(curTrace, GT_5CLASS,
-                                "DRV_InsertDMMResElement: 4");
                }
        }
-       GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 5");
+
        return status;
 }

@@ -258,13 +249,12 @@ DSP_STATUS        DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
        DBC_Assert(hPCtxt != NULL);
        pTempDMMRes2 = pCtxt->pDMMList;
        pTempDMMRes = pCtxt->pDMMList;
-       GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 1");
+
        while ((pTempDMMRes != NULL) && (pTempDMMRes != pDMMRes)) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 2");
                pTempDMMRes2 = pTempDMMRes;
                pTempDMMRes = pTempDMMRes->next;
        }
-       GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 3");
+
        if (pCtxt->pDMMList == pTempDMMRes)
                pCtxt->pDMMList = pTempDMMRes->next;

@@ -274,7 +264,7 @@ DSP_STATUS  DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
                pTempDMMRes2->next = pTempDMMRes2->next->next;

        MEM_Free(pDMMRes);
-       GT_0trace(curTrace, GT_ENTER, "DRV_RemoveDMMResElement: 4");
+
        return status;
 }

@@ -306,7 +296,7 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
        struct DMM_RES_OBJECT *pDMMRes = NULL;

        DBC_Assert(hPCtxt != NULL);
-       GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
+
        while (pDMMList != NULL) {
                pDMMRes = pDMMList;
                pDMMList = pDMMList->next;
@@ -353,19 +343,18 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
        DBC_Assert(hPCtxt != NULL);
        pTempDMM = pCtxt->pDMMList;
        while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr)) {
-               GT_3trace(curTrace, GT_ENTER,
-                        "DRV_GetDMMResElement: 2 pTempDMM:%x "
-                        "pTempDMM->ulDSPAddr:%x pMapAddr:%x\n", pTempDMM,
-                        pTempDMM->ulDSPAddr, pMapAddr);
+               pr_debug("%s: pTempDMM: %p, pTempDMM->ulDSPAddr: 0x%x, "
+                                       "pMapAddr: 0x%x\n", __func__, pTempDMM,
+                                       pTempDMM->ulDSPAddr, pMapAddr);
                pTempDMM2 = pTempDMM;
                pTempDMM = pTempDMM->next;
        }
-       if (pTempDMM != NULL) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 3");
+
+       if (pTempDMM)
                *pDMMRes = pTempDMM;
-       } else {
+       else
                status = DSP_ENOTFOUND;
-       } GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 4");
+
        return status;
 }

@@ -418,7 +407,7 @@ DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)

        DBC_Assert(hPCtxt != NULL);
        pTempNode = pCtxt->pNodeList;
-       GT_0trace(curTrace, GT_ENTER, "DRV_GetNodeResElement: 1");
+
        while ((pTempNode != NULL) && (pTempNode->hNode != hNode)) {
                pTempNode2 = pTempNode;
                pTempNode = pTempNode->next;
@@ -445,15 +434,12 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,

        *pSTRMRes = (struct STRM_RES_OBJECT *)
                    MEM_Calloc(1 * sizeof(struct STRM_RES_OBJECT), MEM_PAGED);
-       if ((*pSTRMRes == NULL) || (hPCtxt == NULL)) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_InsertSTRMResElement: 2");
+       if (!*pSTRMRes || !hPCtxt)
                status = DSP_EHANDLE;
-       }
+
        if (DSP_SUCCEEDED(status)) {
                (*pSTRMRes)->hStream = hStreamHandle;
                if (pCtxt->pSTRMList != NULL) {
-                       GT_0trace(curTrace, GT_ENTER,
-                                "DRV_InsertiSTRMResElement: 3");
                        pTempSTRMRes = pCtxt->pSTRMList;
                        while (pTempSTRMRes->next != NULL)
                                pTempSTRMRes = pTempSTRMRes->next;
@@ -461,10 +447,9 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
                        pTempSTRMRes->next = *pSTRMRes;
                } else {
                        pCtxt->pSTRMList = *pSTRMRes;
-                       GT_0trace(curTrace, GT_ENTER,
-                                "DRV_InsertSTRMResElement: 4");
                }
        }
+
        return status;
 }

@@ -572,18 +557,14 @@ DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)

        DBC_Assert(hPCtxt != NULL);
        while ((pTempSTRM != NULL) && (pTempSTRM->hStream != hStrm)) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 2");
                pTempSTRM2 = pTempSTRM;
                pTempSTRM = pTempSTRM->next;
        }
-       if (pTempSTRM != NULL) {
-               GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 3");
+       if (pTempSTRM)
                *STRMRes = pTempSTRM;
-       } else {
-               GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 4");
+       else
                status = DSP_ENOTFOUND;
-       }
-       GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 5");
+
        return status;
 }

@@ -613,8 +594,9 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)

        DBC_Require(phDRVObject != NULL);
        DBC_Require(cRefs > 0);
-       GT_1trace(curTrace, GT_ENTER, "Entering DRV_Create"
-                       " phDRVObject 0x%x\n", phDRVObject);
+
+       pr_debug("Entering %s phDRVObject %p\n", __func__, phDRVObject);
+
        MEM_AllocObject(pDRVObject, struct DRV_OBJECT, SIGNATURE);
        if (pDRVObject) {
                /* Create and Initialize List of device objects */
@@ -624,43 +606,42 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
                        pDRVObject->devNodeString = LST_Create();
                        if (!(pDRVObject->devNodeString)) {
                                status = DSP_EFAIL;
-                               GT_0trace(curTrace, GT_7CLASS,
-                                        "Failed to Create DRV_EXT list ");
+                               pr_debug("%s: Failed to Create DRV_EXT list\n",
+                                                               __func__);
                                MEM_FreeObject(pDRVObject);
                        }
                } else {
                        status = DSP_EFAIL;
-                       GT_0trace(curTrace, GT_7CLASS,
-                                "Failed to Create Dev List ");
+                       pr_debug("%s: Failed to Create Dev List\n", __func__);
                        MEM_FreeObject(pDRVObject);
                }
        } else {
                status = DSP_EFAIL;
-               GT_0trace(curTrace, GT_7CLASS,
-                        "Failed to Allocate Memory for DRV Obj");
+               pr_debug("%s: Failed to Allocate Memory for DRV Obj\n",
+                                                               __func__);
        }
        if (DSP_SUCCEEDED(status)) {
                /* Store the DRV Object in the Registry */
                if (DSP_SUCCEEDED
                    (CFG_SetObject((u32) pDRVObject, REG_DRV_OBJECT))) {
-                       GT_1trace(curTrace, GT_1CLASS,
-                                "DRV Obj Created pDrvObject 0x%x\n ",
-                                pDRVObject);
+                       pr_debug("%s: DRV Obj Created pDrvObject %p\n",
+                                                       __func__, pDRVObject);
                        *phDRVObject = pDRVObject;
                } else {
                        /* Free the DRV Object */
                        status = DSP_EFAIL;
                        MEM_Free(pDRVObject);
-                       GT_0trace(curTrace, GT_7CLASS,
-                                "Failed to update the Registry with "
-                                "DRV Object ");
+                       pr_debug("%s: Failed to update the Registry with "
+                                               "DRV Object\n", __func__);
                }
        }
-       GT_2trace(curTrace, GT_ENTER,
-                "Exiting DRV_Create: phDRVObject: 0x%x\tstatus:"
-                "0x%x\n", phDRVObject, status);
+
+       pr_debug("Exiting %s: phDRVObject: %p, status: 0x%x\n", __func__,
+                                                       phDRVObject, status);
+
        DBC_Ensure(DSP_FAILED(status) ||
                  MEM_IsValidHandle(pDRVObject, SIGNATURE));
+
        return status;
 }

@@ -673,7 +654,7 @@ void DRV_Exit(void)
 {
        DBC_Require(cRefs > 0);

-       GT_0trace(curTrace, GT_5CLASS, "Entering DRV_Exit \n");
+       pr_debug("Entering %s\n", __func__);

        cRefs--;

@@ -693,8 +674,8 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(pDRVObject, SIGNATURE));

-       GT_1trace(curTrace, GT_ENTER, "Entering DRV_Destroy"
-                       " hDRVObject 0x%x\n", hDRVObject);
+       pr_debug("Entering %s, hDRVObject %p\n", __func__, hDRVObject);
+
        /*
         *  Delete the List if it exists.Should not come here
         *  as the DRV_RemoveDevObject and the Last DRV_RequestResources
@@ -711,10 +692,12 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
        MEM_FreeObject(pDRVObject);
        /* Update the DRV Object in Registry to be 0 */
        (void)CFG_SetObject(0, REG_DRV_OBJECT);
-       GT_2trace(curTrace, GT_ENTER,
-                "Exiting DRV_Destroy: hDRVObject: 0x%x\tstatus:"
-                "0x%x\n", hDRVObject, status);
+
+       pr_debug("Exiting %s, hDRVObject: %p, status: 0x%x\n", __func__,
+                                                       hDRVObject, status);
+
        DBC_Ensure(!MEM_IsValidHandle(pDRVObject, SIGNATURE));
+
        return status;
 }

@@ -737,10 +720,10 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
        DBC_Require(uIndex >= 0);
        DBC_Require(cRefs > 0);
        DBC_Assert(!(LST_IsEmpty(pDrvObject->devList)));
-       GT_3trace(curTrace, GT_ENTER,
-                "Entered DRV_GetDevObject, args:\n\tuIndex: "
-                "0x%x\n\thDrvObject:  0x%x\n\tphDevObject:  0x%x\n",
-                uIndex, hDrvObject, phDevObject);
+
+       pr_debug("Entered %s, uIndex: 0x%x, hDrvObject: %p, phDevObject: %p\n",
+                               __func__, uIndex, hDrvObject, phDevObject);
+
        pDevObject = (struct DEV_OBJECT *)DRV_GetFirstDevObject();
        for (i = 0; i < uIndex; i++) {
                pDevObject =
@@ -752,12 +735,12 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
        } else {
                *phDevObject = NULL;
                status = DSP_EFAIL;
-               GT_0trace(curTrace, GT_7CLASS,
-                        "DRV: Could not get the DevObject\n");
+               pr_debug("%s: Could not get the DevObject\n", __func__);
        }
-       GT_2trace(curTrace, GT_ENTER,
-                "Exiting Drv_GetDevObject\n\tstatus: 0x%x\n\t"
-                "hDevObject: 0x%x\n", status, *phDevObject);
+
+       pr_debug("Exiting %s, status: 0x%x, hDevObject: %p\n", __func__,
+                                                       status, *phDevObject);
+
        return status;
 }

@@ -874,8 +857,7 @@ DSP_STATUS DRV_Init(void)
        if (fRetval)
                cRefs++;

-       GT_1trace(curTrace, GT_5CLASS, "Entering DRV_Entry  crefs 0x%x \n",
-                cRefs);
+       pr_debug("%s crefs 0x%x\n", __func__, cRefs);

        DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));

@@ -898,14 +880,12 @@ DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
        DBC_Require(MEM_IsValidHandle(pDRVObject, SIGNATURE));
        DBC_Assert(pDRVObject->devList);

-       GT_2trace(curTrace, GT_ENTER,
-                "Entering DRV_InsertProcObject hDRVObject "
-                "0x%x\n, hDevObject 0x%x\n", hDRVObject, hDevObject);
+       pr_debug("Entering %s hDRVObject %p, hDevObject %p\n", __func__,
+                                                       hDRVObject, hDevObject);

        LST_PutTail(pDRVObject->devList, (struct LST_ELEM *)hDevObject);

-       GT_1trace(curTrace, GT_ENTER,
-                "Exiting InsertDevObject status 0x%x\n", status);
+       pr_debug("Exiting %s, status 0x%x\n", __func__, status);

        DBC_Ensure(DSP_SUCCEEDED(status) && !LST_IsEmpty(pDRVObject->devList));

@@ -932,9 +912,9 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
        DBC_Require(pDRVObject->devList != NULL);
        DBC_Require(!LST_IsEmpty(pDRVObject->devList));

-       GT_2trace(curTrace, GT_ENTER,
-                "Entering DRV_RemoveDevObject hDevObject "
-                "0x%x\n, hDRVObject 0x%x\n", hDevObject, hDRVObject);
+       pr_debug("Entering %s, hDevObject %p, hDRVObject %p\n", __func__,
+                                                       hDevObject, hDRVObject);
+
        /* Search list for pProcObject: */
        for (pCurElem = LST_First(pDRVObject->devList); pCurElem != NULL;
            pCurElem = LST_Next(pDRVObject->devList, pCurElem)) {
@@ -950,10 +930,11 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
                LST_Delete(pDRVObject->devList);
                pDRVObject->devList = NULL;
        }
+
        DBC_Ensure((pDRVObject->devList == NULL) ||
                  !LST_IsEmpty(pDRVObject->devList));
-       GT_1trace(curTrace, GT_ENTER,
-                "DRV_RemoveDevObject returning 0x%x\n", status);
+       pr_debug("Leaving %s: status 0x%x\n", __func__, status);
+
        return status;
 }

@@ -970,7 +951,9 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)

        DBC_Require(dwContext != 0);
        DBC_Require(pDevNodeString != NULL);
-       GT_0trace(curTrace, GT_ENTER, "Entering DRV_RequestResources\n");
+
+       pr_debug("Entering %s\n", __func__);
+
        /*
         *  Allocate memory to hold the string. This will live untill
         *  it is freed in the Release resources. Update the driver object
@@ -989,31 +972,29 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
                        LST_PutTail(pDRVObject->devNodeString,
                                (struct LST_ELEM *)pszdevNode);
                } else {
-                       GT_0trace(curTrace, GT_7CLASS,
-                               "Failed to Allocate Memory devNodeString ");
+                       pr_debug("%s: Failed to Allocate Memory "
+                                               "devNodeString\n", __func__);
                        status = DSP_EFAIL;
                        *pDevNodeString = 0;
                }
        } else {
                status = DSP_EFAIL;
-               GT_0trace(curTrace, GT_7CLASS,
-                        "Failed to get Driver Object from Registry");
+               pr_debug("%s: Failed to get Driver Object from Registry\n",
+                                                               __func__);
                *pDevNodeString = 0;
        }

        if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {
-               GT_0trace(curTrace, GT_1CLASS,
-                         " Allocating resources for UMA \n");
+               pr_debug("%s: Allocating resources for UMA\n", __func__);
                status = RequestBridgeResourcesDSP(dwContext, DRV_ASSIGN);
        } else {
                status = DSP_EFAIL;
-               GT_0trace(curTrace, GT_7CLASS, "Unknown Device ");
+               pr_debug("%s: Unknown Device\n", __func__);
        }

-       if (DSP_FAILED(status)) {
-               GT_0trace(curTrace, GT_7CLASS,
-                        "Failed to reserve bridge resources ");
-       }
+       if (DSP_FAILED(status))
+               pr_debug("%s: Failed to reserve bridge resources\n", __func__);
+
        DBC_Ensure((DSP_SUCCEEDED(status) && pDevNodeString != NULL &&
                  !LST_IsEmpty(pDRVObject->devNodeString)) ||
                  (DSP_FAILED(status) && *pDevNodeString == 0));
@@ -1032,21 +1013,18 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
        struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDrvObject;
        struct DRV_EXT *pszdevNode;

-       GT_0trace(curTrace, GT_ENTER, "Entering DRV_Release Resources\n");
+       pr_debug("Entering %s\n", __func__);

        if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
           "TIOMAP1510"))) {
-               GT_0trace(curTrace, GT_1CLASS,
-                        " Releasing DSP-Bridge resources \n");
+               pr_debug("%s: Releasing DSP-Bridge resources\n", __func__);
                status = RequestBridgeResources(dwContext, DRV_RELEASE);
        } else {
-               GT_0trace(curTrace, GT_1CLASS, " Unknown device\n");
+               pr_debug("%s: Unknown device\n", __func__);
        }

-       if (DSP_SUCCEEDED(status)) {
-               GT_0trace(curTrace, GT_1CLASS,
-                        "Failed to relese bridge resources\n");
-       }
+       if (DSP_FAILED(status))
+               pr_debug("%s: Failed to relese bridge resources\n", __func__);

        /*
         *  Irrespective of the status go ahead and clean it
@@ -1092,7 +1070,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)

        DBC_Require(dwContext != 0);

-       GT_0trace(curTrace, GT_ENTER, "->RequestBridgeResources \n");
+       pr_debug("Entered %s\n", __func__);

        if (!bRequest) {
                driverExt = (struct DRV_EXT *)dwContext;
@@ -1103,13 +1081,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                        if (DSP_FAILED(REG_GetValue(CURRENTCONFIG,
                                        (u8 *)pResources, &dwBuffSize))) {
                                status = CFG_E_RESOURCENOTAVAIL;
-                               GT_0trace(curTrace, GT_1CLASS,
-                                        "REG_GetValue Failed \n");
-                       } else {
-                               GT_0trace(curTrace, GT_1CLASS,
-                                        "REG_GetValue Succeeded \n");
+                               pr_debug("%s: REG_GetValue Failed\n", __func__);
                        }
-
                        dwBuffSize = sizeof(shm_size);
                        status = REG_GetValue(SHMSIZE, (u8 *)&shm_size,
                                              &dwBuffSize);
@@ -1121,11 +1094,11 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                        shm_size);
                                }
                        } else {
-                               GT_1trace(curTrace, GT_7CLASS,
-                                       "Error getting SHM size from registry: "
-                                       "%x. Not calling MEM_FreePhysMem\n",
-                                       status);
+                               pr_debug("%s: Error getting SHM size from "
+                                       "registry: %x. Not calling "
+                                       "MEM_FreePhysMem\n", __func__, status);
                        }
+
                        pResources->dwMemBase[1] = 0;
                        pResources->dwMemPhys[1] = 0;

@@ -1176,7 +1149,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                } else {
                        status = DSP_EMEMORY;
                }
-               GT_0trace(curTrace, GT_ENTER, " <- RequestBridgeResources \n");
+
+               pr_debug("Leaving %s, status 0x%x\n", __func__, status);
                return status;
        }
        dwBuffSize = sizeof(struct CFG_HOSTRES);
@@ -1194,20 +1168,13 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                                        OMAP_MBOX_SIZE);
                pResources->dwSysCtrlBase = ioremap(OMAP_SYSC_BASE,
                                                        OMAP_SYSC_SIZE);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
-                        pResources->dwMemBase[0]);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[3] 0x%x\n",
-                        pResources->dwMemBase[3]);
-               GT_1trace(curTrace, GT_2CLASS, "dwPrmBase 0x%x\n",
-                                                       pResources->dwPrmBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwCmBase 0x%x\n",
-                                                       pResources->dwCmBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
-                                               pResources->dwWdTimerDspBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-                                               pResources->dwMboxBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
-                                               pResources->dwDmmuBase);
+               pr_debug("MemBase[0] 0x%x\n", pResources->dwMemBase[0]);
+               pr_debug("MemBase[3] 0x%x\n", pResources->dwMemBase[3]);
+               pr_debug("PrmBase %p\n", pResources->dwPrmBase);
+               pr_debug("CmBase %p\n", pResources->dwCmBase);
+               pr_debug("WdTimerDspBase %p\n", pResources->dwWdTimerDspBase);
+               pr_debug("MboxBase %p\n", pResources->dwMboxBase);
+               pr_debug("DmmuBase %p\n", pResources->dwDmmuBase);

                /* for 24xx base port is not mapping the mamory for DSP
                 * internal memory TODO Do a ioremap here */
@@ -1224,19 +1191,13 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                        dwBuffSize = sizeof(struct CFG_HOSTRES);
                        status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
                                                sizeof(struct CFG_HOSTRES));
-                       if (DSP_SUCCEEDED(status)) {
-                               GT_0trace(curTrace, GT_1CLASS,
-                                        " Successfully set the registry "
-                                        "value for CURRENTCONFIG\n");
-                       } else {
-                               GT_0trace(curTrace, GT_7CLASS,
-                                        " Failed to set the registry "
-                                        "value for CURRENTCONFIG\n");
-                       }
+                       if (DSP_FAILED(status))
+                               pr_debug("%s: Failed to set the registry "
+                                       "value for CURRENTCONFIG\n", __func__);
                }
                MEM_Free(pResources);
        }
-       /* End Mem alloc */
+
        return status;
 }

@@ -1255,7 +1216,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)

        DBC_Require(dwContext != 0);

-       GT_0trace(curTrace, GT_ENTER, "->RequestBridgeResourcesDSP \n");
+       pr_debug("Entered %s\n", __func__);

        dwBuffSize = sizeof(struct CFG_HOSTRES);

@@ -1292,26 +1253,16 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                                                        OMAP_DMMU_SIZE);
                pResources->dwWdTimerDspBase = NULL;

-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
-                                               pResources->dwMemBase[0]);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[1] 0x%x\n",
-                                               pResources->dwMemBase[1]);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[2] 0x%x\n",
-                                               pResources->dwMemBase[2]);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[3] 0x%x\n",
-                                               pResources->dwMemBase[3]);
-               GT_1trace(curTrace, GT_2CLASS, "dwMemBase[4] 0x%x\n",
-                                               pResources->dwMemBase[4]);
-               GT_1trace(curTrace, GT_2CLASS, "dwPrmBase 0x%x\n",
-                                               pResources->dwPrmBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwCmBase 0x%x\n",
-                                               pResources->dwCmBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
-                                               pResources->dwWdTimerDspBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-                                               pResources->dwMboxBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
-                                               pResources->dwDmmuBase);
+               pr_debug("MemBase[0] 0x%x\n", pResources->dwMemBase[0]);
+               pr_debug("MemBase[1] 0x%x\n", pResources->dwMemBase[1]);
+               pr_debug("MemBase[2] 0x%x\n", pResources->dwMemBase[2]);
+               pr_debug("MemBase[3] 0x%x\n", pResources->dwMemBase[3]);
+               pr_debug("MemBase[4] 0x%x\n", pResources->dwMemBase[4]);
+               pr_debug("PrmBase %p\n", pResources->dwPrmBase);
+               pr_debug("CmBase %p\n", pResources->dwCmBase);
+               pr_debug("WDTimerDspBase %p\n", pResources->dwWdTimerDspBase);
+               pr_debug("MboxBase %p\n", pResources->dwMboxBase);
+               pr_debug("DmmuBase %p\n", pResources->dwDmmuBase);
                dwBuffSize = sizeof(shm_size);
                status = REG_GetValue(SHMSIZE, (u8 *)&shm_size, &dwBuffSize);
                if (DSP_SUCCEEDED(status)) {
@@ -1322,17 +1273,16 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                                                        &dmaAddr);
                        if (pResources->dwMemBase[1] == 0) {
                                status = DSP_EMEMORY;
-                               GT_0trace(curTrace, GT_7CLASS,
-                                        "SHM reservation Failed\n");
+                               pr_debug("%s: SHM reservation Failed\n",
+                                                               __func__);
                        } else {
                                pResources->dwMemLength[1] = shm_size;
                                pResources->dwMemPhys[1] = dmaAddr;

-                               GT_3trace(curTrace, GT_1CLASS,
-                                        "Bridge SHM address 0x%x dmaAddr"
-                                        " %x size %x\n",
-                                        pResources->dwMemBase[1],
-                                        dmaAddr, shm_size);
+                               pr_debug("%s: Bridge SHM address 0x%x, "
+                                       "dmaAddr %x, size %x\n", __func__,
+                                       pResources->dwMemBase[1], dmaAddr,
+                                       shm_size);
                        }
                }
                if (DSP_SUCCEEDED(status)) {
@@ -1347,18 +1297,12 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                        dwBuffSize = sizeof(struct CFG_HOSTRES);
                        status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
                                             sizeof(struct CFG_HOSTRES));
-                       if (DSP_SUCCEEDED(status)) {
-                               GT_0trace(curTrace, GT_1CLASS,
-                                        " Successfully set the registry"
-                                        " value for CURRENTCONFIG\n");
-                       } else {
-                               GT_0trace(curTrace, GT_7CLASS,
-                                        " Failed to set the registry value"
-                                        " for CURRENTCONFIG\n");
-                       }
+                       if (DSP_FAILED(status))
+                               pr_debug("%s: Failed to set the registry value"
+                                        " for CURRENTCONFIG\n", __func__);
                }
                MEM_Free(pResources);
        }
-       /* End Mem alloc */
+
        return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 183aba6..728a5dd 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -44,9 +44,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/dspdrv.h>

-/*  ----------------------------------- Globals */
-struct GT_Mask curTrace;
-
 /*
  *  ======== DSP_Init ========
  *     Allocates bridge resources. Loads a base image onto DSP, if specified.
@@ -60,20 +57,17 @@ u32 DSP_Init(OUT u32 *initStatus)
        u32 deviceNode;
        u32 deviceNodeString;

-       GT_create(&curTrace, "DD");
-
-       GT_0trace(curTrace, GT_ENTER, "Entering DSP_Init \r\n");
+       pr_debug("Entering %s\n", __func__);

        if (DSP_FAILED(WCD_Init())) {
-               GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed \n");
+               pr_debug("%s: Failed\n", __func__);
                goto func_cont;
        }                       /* End WCD_Exit */
        if (DSP_FAILED(DRV_Create(&drvObject))) {
-               GT_0trace(curTrace, GT_7CLASS, "DSP_Init:DRV_Create Failed \n");
+               pr_debug("%s: DRV_Create Failed\n", __func__);
                WCD_Exit();
                goto func_cont;
        }               /* End DRV_Create */
-       GT_0trace(curTrace, GT_5CLASS, "DSP_Init:DRV Created \r\n");

        /* Request Resources */
        if (DSP_SUCCEEDED(DRV_RequestResources((u32)&devNode,
@@ -82,20 +76,17 @@ u32 DSP_Init(OUT u32 *initStatus)
                if (DSP_SUCCEEDED(DEV_StartDevice(
                   (struct CFG_DEVNODE *)deviceNodeString))) {
                        /* Retreive the DevObject from the Registry */
-                       GT_2trace(curTrace, GT_1CLASS,
-                                "DSP_Init Succeeded for Device1:"
-                                "%d: value: %x\n", index, deviceNodeString);
+                       pr_debug("%s: Succeeded for Device: %d: value: %x\n",
+                                       __func__, index, deviceNodeString);
                        status = DSP_SOK;
                } else {
-                       GT_0trace(curTrace, GT_7CLASS,
-                                "DSP_Init:DEV_StartDevice Failed\n");
+                       pr_debug("%s: DEV_StartDevice Failed\n", __func__);
                        (void)DRV_ReleaseResources
                                ((u32) deviceNodeString, drvObject);
                        status = DSP_EFAIL;
                }
        } else {
-               GT_0trace(curTrace, GT_7CLASS,
-                        "DSP_Init:DRV_RequestResources Failed \r\n");
+               pr_debug("%s: DRV_RequestResources Failed\n", __func__);
                status = DSP_EFAIL;
        }       /* DRV_RequestResources */
        index++;
@@ -118,8 +109,7 @@ u32 DSP_Init(OUT u32 *initStatus)
                (void)DRV_Destroy(drvObject);
                drvObject = NULL;
                WCD_Exit();
-               GT_0trace(curTrace, GT_7CLASS,
-                        "DSP_Init:Logical device Failed to Load\n");
+               pr_debug("%s: Logical device Failed to Load\n", __func__);
        }       /* Unwinding the loaded drivers */
 func_cont:
        /* Attempt to Start the Board */
@@ -128,13 +118,15 @@ func_cont:
                 * correct one. We should not propagate that error
                 * into the device loader. */
                (void)WCD_InitComplete2();
-               GT_0trace(curTrace, GT_1CLASS, "DSP_Init Succeeded\n");
+               pr_debug("%s Succeeded\n", __func__);
        } else {
-               GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed\n");
-       }                       /* End WCD_InitComplete2 */
+               pr_debug("%s Failed\n", __func__);
+       }
+
        DBC_Ensure((DSP_SUCCEEDED(status) && drvObject != NULL) ||
                  (DSP_FAILED(status) && drvObject == NULL));
        *initStatus = status;
+
        /* Return the Driver Object */
        return (u32)drvObject;
 }
@@ -149,7 +141,7 @@ bool DSP_Deinit(u32 deviceContext)
        u32 deviceNode;
        struct MGR_OBJECT *mgrObject = NULL;

-       GT_0trace(curTrace, GT_ENTER, "Entering DSP_Deinit \r\n");
+       pr_debug("Entering %s\n", __func__);

        while ((deviceNode = DRV_GetFirstDevExtension()) != 0) {
                (void)DEV_RemoveDevice((struct CFG_DEVNODE *)deviceNode);
@@ -167,5 +159,7 @@ bool DSP_Deinit(u32 deviceContext)

        WCD_Exit();

+       pr_debug("Leaving %s\n", __func__);
+
        return retVal;
 }
--
1.6.2.4

