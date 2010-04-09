From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 11/13] DSPBRIDGE: Remove IS_VALID_HANDLE function and macro
Date: Thu, 8 Apr 2010 19:11:49 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D156@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44129 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0DIAMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:12:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 6d9b054e76f52b4ae0adff17b4e875793b54a6b1 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Mon, 29 Mar 2010 18:16:42 -0600
Subject: [PATCH 11/13] DSPBRIDGE: Remove IS_VALID_HANDLE function and macro

The patch "DSPBRIDGE: Replace MEM_ALLOC_OBJECT macro by kzalloc function"
do not set the dw_signature, then all the signature checking will be
removed.

IS_VALID_HANDLE can be replaced by a simple pointer check.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/wmd.h |    2 +-
 drivers/dsp/bridge/pmgr/dev.c              |   72 ++++++++++------------------
 drivers/dsp/bridge/rmgr/dbdcd.c            |   20 ++++----
 3 files changed, 35 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index f9883db..6a41975 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -318,7 +318,7 @@ typedef dsp_status(*fxn_brd_write) (struct wmd_dev_context *hDevContext,
  *          0 < max_channels <= CHNL_MAXCHANNELS.
  *          birq <= 15.
  *          word_size > 0.
- *      IS_VALID_HANDLE(hdev_obj)
+ *      hdev_obj != NULL
  *      No channel manager exists for this board.
  *  Ensures:
  */
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index aafdbaa..09884ca 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -90,7 +90,6 @@ static u32 refs;		/* Module reference count */
 /*  ----------------------------------- Function Prototypes */
 static dsp_status fxn_not_implemented(int arg, ...);
 static dsp_status init_cod_mgr(struct dev_object *dev_obj);
-static bool IS_VALID_HANDLE(struct dev_object *hObj);
 static void store_interface_fxns(struct bridge_drv_interface *drv_fxns,
 				 OUT struct bridge_drv_interface *intf_fxns);
 /*
@@ -109,7 +108,7 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(pHostBuf != NULL);	/* Required of BrdWrite(). */
-	if (IS_VALID_HANDLE(dev_obj)) {
+	if (dev_obj) {
 		/* Require of BrdWrite() */
 		DBC_ASSERT(dev_obj->hwmd_context != NULL);
 		status =
@@ -271,7 +270,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		*phDevObject = NULL;
 	}
 
-	DBC_ENSURE((DSP_SUCCEEDED(status) && IS_VALID_HANDLE(*phDevObject)) ||
+	DBC_ENSURE((DSP_SUCCEEDED(status) && *phDevObject) ||
 		   (DSP_FAILED(status) && !*phDevObject));
 	return status;
 }
@@ -289,7 +288,7 @@ dsp_status dev_create2(struct dev_object *hdev_obj)
 	struct dev_object *dev_obj = hdev_obj;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdev_obj));
+	DBC_REQUIRE(hdev_obj);
 
 	/* There can be only one Node Manager per DEV object */
 	DBC_ASSERT(!dev_obj->hnode_mgr);
@@ -313,7 +312,7 @@ dsp_status dev_destroy2(struct dev_object *hdev_obj)
 	struct dev_object *dev_obj = hdev_obj;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdev_obj));
+	DBC_REQUIRE(hdev_obj);
 
 	if (dev_obj->hnode_mgr) {
 		if (DSP_FAILED(node_delete_mgr(dev_obj->hnode_mgr)))
@@ -341,7 +340,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 
 	DBC_REQUIRE(refs > 0);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		if (dev_obj->cod_mgr) {
 			cod_delete(dev_obj->cod_mgr);
 			dev_obj->cod_mgr = NULL;
@@ -424,7 +423,7 @@ dsp_status dev_get_chnl_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phMgr != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phMgr = dev_obj->hchnl_mgr;
 	} else {
 		*phMgr = NULL;
@@ -451,7 +450,7 @@ dsp_status dev_get_cmm_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phMgr != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phMgr = dev_obj->hcmm_mgr;
 	} else {
 		*phMgr = NULL;
@@ -478,7 +477,7 @@ dsp_status dev_get_dmm_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phMgr != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phMgr = dev_obj->dmm_mgr;
 	} else {
 		*phMgr = NULL;
@@ -504,7 +503,7 @@ dsp_status dev_get_cod_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phCodMgr != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phCodMgr = dev_obj->cod_mgr;
 	} else {
 		*phCodMgr = NULL;
@@ -527,7 +526,7 @@ dsp_status dev_get_deh_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phDehMgr != NULL);
 	DBC_REQUIRE(hdev_obj);
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phDehMgr = hdev_obj->hdeh_mgr;
 	} else {
 		*phDehMgr = NULL;
@@ -550,7 +549,7 @@ dsp_status dev_get_dev_node(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phDevNode != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phDevNode = dev_obj->dev_node_obj;
 	} else {
 		*phDevNode = NULL;
@@ -574,7 +573,7 @@ struct dev_object *dev_get_first(void)
 
 	dev_obj = (struct dev_object *)drv_get_first_dev_object();
 
-	DBC_ENSURE((dev_obj == NULL) || IS_VALID_HANDLE(dev_obj));
+	DBC_ENSURE((dev_obj == NULL) || dev_obj);
 
 	return dev_obj;
 }
@@ -594,7 +593,7 @@ dsp_status dev_get_intf_fxns(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(ppIntfFxns != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*ppIntfFxns = &dev_obj->wmd_interface;
 	} else {
 		*ppIntfFxns = NULL;
@@ -618,7 +617,7 @@ dsp_status dev_get_io_mgr(struct dev_object *hdev_obj,
 	DBC_REQUIRE(phIOMgr != NULL);
 	DBC_REQUIRE(hdev_obj);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phIOMgr = hdev_obj->hio_mgr;
 	} else {
 		*phIOMgr = NULL;
@@ -639,12 +638,12 @@ struct dev_object *dev_get_next(struct dev_object *hdev_obj)
 {
 	struct dev_object *next_dev_object = NULL;
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		next_dev_object = (struct dev_object *)
 		    drv_get_next_dev_object((u32) hdev_obj);
 	}
-	DBC_ENSURE((next_dev_object == NULL)
-		   || IS_VALID_HANDLE(next_dev_object));
+	DBC_ENSURE((next_dev_object == NULL) || next_dev_object);
+
 	return next_dev_object;
 }
 
@@ -674,7 +673,7 @@ dsp_status dev_get_node_manager(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phNodeMgr != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phNodeMgr = dev_obj->hnode_mgr;
 	} else {
 		*phNodeMgr = NULL;
@@ -698,7 +697,7 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(pstrSym != NULL && pul_value != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		status = dev_get_cod_mgr(hdev_obj, &cod_mgr);
 		if (DSP_SUCCEEDED(status)) {
 			DBC_ASSERT(cod_mgr != NULL);
@@ -726,7 +725,7 @@ dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(phWmdContext != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
+	if (hdev_obj) {
 		*phWmdContext = dev_obj->hwmd_context;
 	} else {
 		*phWmdContext = NULL;
@@ -849,7 +848,7 @@ dsp_status dev_set_chnl_mgr(struct dev_object *hdev_obj,
 
 	DBC_REQUIRE(refs > 0);
 
-	if (IS_VALID_HANDLE(hdev_obj))
+	if (hdev_obj)
 		dev_obj->hchnl_mgr = hmgr;
 	else
 		status = DSP_EHANDLE;
@@ -866,7 +865,7 @@ dsp_status dev_set_chnl_mgr(struct dev_object *hdev_obj,
 void dev_set_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr *hmgr)
 {
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdev_obj));
+	DBC_REQUIRE(hdev_obj);
 
 	hdev_obj->hmsg_mgr = hmgr;
 }
@@ -939,27 +938,6 @@ static dsp_status fxn_not_implemented(int arg, ...)
 }
 
 /*
- *  ======== IS_VALID_HANDLE ========
- *  Purpose:
- *      Validate the device object handle.
- *  Parameters:
- *      hdev_obj:     Handle to device object created with
- *                      dev_create_device().
- *  Returns:
- *      true if handle is valid; false otherwise.
- *  Requires:
- *  Ensures:
- */
-static bool IS_VALID_HANDLE(struct dev_object *hObj)
-{
-	bool ret;
-
-	ret = (hObj != NULL) && (hObj->dw_signature == SIGNATURE);
-
-	return ret;
-}
-
-/*
  *  ======== init_cod_mgr ========
  *  Purpose:
  *      Create a COD manager for this device.
@@ -979,7 +957,7 @@ static dsp_status init_cod_mgr(struct dev_object *dev_obj)
 	char *sz_dummy_file = "dummy";
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(!IS_VALID_HANDLE(dev_obj) || (dev_obj->cod_mgr == NULL));
+	DBC_REQUIRE(!dev_obj || (dev_obj->cod_mgr == NULL));
 
 	status = cod_create(&dev_obj->cod_mgr, sz_dummy_file, NULL);
 
@@ -1012,7 +990,7 @@ dsp_status dev_insert_proc_object(struct dev_object *hdev_obj,
 	struct dev_object *dev_obj = (struct dev_object *)hdev_obj;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(dev_obj));
+	DBC_REQUIRE(dev_obj);
 	DBC_REQUIRE(proc_obj != 0);
 	DBC_REQUIRE(dev_obj->proc_list != NULL);
 	DBC_REQUIRE(pbAlreadyAttached != NULL);
@@ -1051,7 +1029,7 @@ dsp_status dev_remove_proc_object(struct dev_object *hdev_obj, u32 proc_obj)
 	struct list_head *cur_elem;
 	struct dev_object *dev_obj = (struct dev_object *)hdev_obj;
 
-	DBC_REQUIRE(IS_VALID_HANDLE(dev_obj));
+	DBC_REQUIRE(dev_obj);
 	DBC_REQUIRE(proc_obj != 0);
 	DBC_REQUIRE(dev_obj->proc_list != NULL);
 	DBC_REQUIRE(!LST_IS_EMPTY(dev_obj->proc_list));
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 8895b93..5c7fed0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -48,8 +48,6 @@
 /*  ----------------------------------- Global defines. */
 #define SIGNATURE       0x5f444344	/* "DCD_" (in reverse). */
 
-#define IS_VALID_HANDLE(h) (((h) != NULL) && (h->dw_signature == SIGNATURE))
-
 #define MAX_INT2CHAR_LENGTH     16	/* Max int2char len of 32 bit int */
 
 /* Name of section containing dependent libraries */
@@ -92,7 +90,7 @@ dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
 
 	DBC_REQUIRE(refs > 0);
 
-	if (IS_VALID_HANDLE(hdcd_mgr))
+	if (hdcd_mgr)
 		status = dcd_get_objects(hdcd_mgr, pszCoffPath,
 					 (dcd_registerfxn) dcd_register_object,
 					 (void *)pszCoffPath);
@@ -114,7 +112,7 @@ dsp_status dcd_auto_unregister(IN struct dcd_manager *hdcd_mgr,
 
 	DBC_REQUIRE(refs > 0);
 
-	if (IS_VALID_HANDLE(hdcd_mgr))
+	if (hdcd_mgr)
 		status = dcd_get_objects(hdcd_mgr, pszCoffPath,
 					 (dcd_registerfxn) dcd_register_object,
 					 NULL);
@@ -181,7 +179,7 @@ dsp_status dcd_destroy_manager(IN struct dcd_manager *hdcd_mgr)
 
 	DBC_REQUIRE(refs >= 0);
 
-	if (IS_VALID_HANDLE(hdcd_mgr)) {
+	if (hdcd_mgr) {
 		/* Delete the COD manager. */
 		cod_delete(dcd_mgr_obj->cod_mgr);
 
@@ -323,7 +321,7 @@ dsp_status dcd_get_dep_libs(IN struct dcd_manager *hdcd_mgr,
 	dsp_status status = DSP_SOK;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdcd_mgr));
+	DBC_REQUIRE(hdcd_mgr);
 	DBC_REQUIRE(uuid_obj != NULL);
 	DBC_REQUIRE(pDepLibUuids != NULL);
 	DBC_REQUIRE(pPersistentDepLibs != NULL);
@@ -346,7 +344,7 @@ dsp_status dcd_get_num_dep_libs(IN struct dcd_manager *hdcd_mgr,
 	dsp_status status = DSP_SOK;
 
 	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdcd_mgr));
+	DBC_REQUIRE(hdcd_mgr);
 	DBC_REQUIRE(pNumLibs != NULL);
 	DBC_REQUIRE(pNumPersLibs != NULL);
 	DBC_REQUIRE(uuid_obj != NULL);
@@ -392,7 +390,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 		goto func_end;
 	}
 
-	if (!IS_VALID_HANDLE(hdcd_mgr)) {
+	if (!hdcd_mgr) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -532,7 +530,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,
 	s32 object_type;
 
 	DBC_REQUIRE(refs > 0);
-	if (!IS_VALID_HANDLE(hdcd_mgr)) {
+	if (!hdcd_mgr) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
@@ -638,7 +636,7 @@ dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
 	DBC_REQUIRE(uuid_obj != NULL);
 	DBC_REQUIRE(pstrLibName != NULL);
 	DBC_REQUIRE(pdwSize != NULL);
-	DBC_REQUIRE(IS_VALID_HANDLE(hdcd_mgr));
+	DBC_REQUIRE(hdcd_mgr);
 
 	dev_dbg(bridge, "%s: hdcd_mgr %p, uuid_obj %p, pstrLibName %p, pdwSize "
 		"%p\n", __func__, hdcd_mgr, uuid_obj, pstrLibName, pdwSize);
@@ -1307,7 +1305,7 @@ static dsp_status get_dep_lib_info(IN struct dcd_manager *hdcd_mgr,
 
 	DBC_REQUIRE(refs > 0);
 
-	DBC_REQUIRE(IS_VALID_HANDLE(hdcd_mgr));
+	DBC_REQUIRE(hdcd_mgr);
 	DBC_REQUIRE(pNumLibs != NULL);
 	DBC_REQUIRE(uuid_obj != NULL);
 
-- 
1.7.0.3
