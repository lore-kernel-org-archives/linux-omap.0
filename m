From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 06/13] DSPBRIDGE: Replace MEM_ALLOC_OBJECT macro by kzalloc
 function
Date: Thu, 8 Apr 2010 19:04:43 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D151@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43911 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852Ab0DIAEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:04:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 9db05854944ef38aa411bc277b05a4c3aebd1bea Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Wed, 24 Mar 2010 14:39:31 -0600
Subject: [PATCH 06/13] DSPBRIDGE: Replace MEM_ALLOC_OBJECT macro by kzalloc function

The dw_signature member of these structures are not necessary. For
example, MEM_ALLOC_OBJECT will try to allocate memory for the object
and set its signature, but when it fails to allocate memory the
pointer is set to NULL. If MEM_IS_VALID_HANDLE is used to check for
the signature, a NULL pointer dereference error can be obtained.
So the MEM_ALLOC_OBJECT can be replaced by a kzalloc function.

This patch is highly dependent on the following patches:

DSPBRIDGE: Replace MEM_FREE_OBJECT macro by kfree function
DSPBRIDGE: Check pointer instead of using MEM_IS_VALID_HANDLE macro
DSPBRIDGE: Remove CHNL_IS_VALID_MGR and CHNL_IS_VALID_CHNL
DSPBRIDGE: Remove IS_VALID_HANDLE function and macro
DSPBRIDGE: Remove dw_signature field from structures
DSPBRIDGE: Remove signature definitions used for object validation

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/pmgr/cmm.c    |    6 +++---
 drivers/dsp/bridge/pmgr/dbll.c   |    5 ++---
 drivers/dsp/bridge/pmgr/dev.c    |    2 +-
 drivers/dsp/bridge/pmgr/dmm.c    |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c  |    2 +-
 drivers/dsp/bridge/rmgr/disp.c   |    2 +-
 drivers/dsp/bridge/rmgr/drv.c    |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c    |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c   |    5 ++---
 drivers/dsp/bridge/rmgr/node.c   |    4 ++--
 drivers/dsp/bridge/rmgr/proc.c   |    4 ++--
 drivers/dsp/bridge/rmgr/rmm.c    |    2 +-
 drivers/dsp/bridge/rmgr/strm.c   |    4 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c |    4 ++--
 drivers/dsp/bridge/wmd/io_sm.c   |    2 +-
 drivers/dsp/bridge/wmd/msg_sm.c  |    4 ++--
 drivers/dsp/bridge/wmd/ue_deh.c  |    2 +-
 17 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 5c093c9..147ad5e 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -263,7 +263,7 @@ dsp_status cmm_create(OUT struct cmm_object **ph_cmm_mgr,
 
 	*ph_cmm_mgr = NULL;
 	/* create, zero, and tag a cmm mgr object */
-	MEM_ALLOC_OBJECT(cmm_obj, struct cmm_object, CMMSIGNATURE);
+	cmm_obj = kzalloc(sizeof(struct cmm_object), GFP_KERNEL);
 	if (cmm_obj != NULL) {
 		if (pMgrAttrs == NULL)
 			pMgrAttrs = &cmm_dfltmgrattrs;	/* set defaults */
@@ -590,7 +590,7 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* create, zero, and tag an SM allocator object */
-		MEM_ALLOC_OBJECT(psma, struct cmm_allocator, SMEMSIGNATURE);
+		psma = kzalloc(sizeof(struct cmm_allocator), GFP_KERNEL);
 	}
 	if (psma != NULL) {
 		psma->hcmm_mgr = hcmm_mgr;	/* ref to parent */
@@ -980,7 +980,7 @@ dsp_status cmm_xlator_create(OUT struct cmm_xlatorobject **phXlator,
 	if (pXlatorAttrs == NULL)
 		pXlatorAttrs = &cmm_dfltxlatorattrs;	/* set defaults */
 
-	MEM_ALLOC_OBJECT(xlator_object, struct cmm_xlator, CMMXLATESIGNATURE);
+	xlator_object = kzalloc(sizeof(struct cmm_xlator), GFP_KERNEL);
 	if (xlator_object != NULL) {
 		xlator_object->hcmm_mgr = hcmm_mgr;	/* ref back to CMM */
 		/* SM seg_id */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 0bf96c7..2fb05a0 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -256,7 +256,7 @@ dsp_status dbll_create(struct dbll_tar_obj **target_obj,
 	DBC_REQUIRE(target_obj != NULL);
 
 	/* Allocate DBL target object */
-	MEM_ALLOC_OBJECT(pzl_target, struct dbll_tar_obj, DBLL_TARGSIGNATURE);
+	pzl_target = kzalloc(sizeof(struct dbll_tar_obj), GFP_KERNEL);
 	if (target_obj != NULL) {
 		if (pzl_target == NULL) {
 			*target_obj = NULL;
@@ -620,8 +620,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
 	}
 	if (zl_lib == NULL) {
 		/* Allocate DBL library object */
-		MEM_ALLOC_OBJECT(zl_lib, struct dbll_library_obj,
-				 DBLL_LIBSIGNATURE);
+		zl_lib = kzalloc(sizeof(struct dbll_library_obj), GFP_KERNEL);
 		if (zl_lib == NULL) {
 			status = DSP_EMEMORY;
 		} else {
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 196d108..1e55f55 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -163,7 +163,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 	 * storage. */
 	if (DSP_SUCCEEDED(status)) {
 		DBC_ASSERT(drv_fxns);
-		MEM_ALLOC_OBJECT(dev_obj, struct dev_object, SIGNATURE);
+		dev_obj = kzalloc(sizeof(struct dev_object), GFP_KERNEL);
 		if (dev_obj) {
 			/* Fill out the rest of the Dev Object structure: */
 			dev_obj->dev_node_obj = dev_node_obj;
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index dd40e44..d25cca7 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -137,7 +137,7 @@ dsp_status dmm_create(OUT struct dmm_object **phDmmMgr,
 
 	*phDmmMgr = NULL;
 	/* create, zero, and tag a cmm mgr object */
-	MEM_ALLOC_OBJECT(dmm_obj, struct dmm_object, DMMSIGNATURE);
+	dmm_obj = kzalloc(sizeof(struct dmm_object), GFP_KERNEL);
 	if (dmm_obj != NULL) {
 		spin_lock_init(&dmm_obj->dmm_lock);
 		*phDmmMgr = dmm_obj;
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 923f9dc..1bc6856 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -145,7 +145,7 @@ dsp_status dcd_create_manager(IN char *pszZlDllName,
 		goto func_end;
 
 	/* Create a DCD object. */
-	MEM_ALLOC_OBJECT(dcd_mgr_obj, struct dcd_manager, SIGNATURE);
+	dcd_mgr_obj = kzalloc(sizeof(struct dcd_manager), GFP_KERNEL);
 	if (dcd_mgr_obj != NULL) {
 		/* Fill out the object. */
 		dcd_mgr_obj->cod_mgr = cod_mgr;
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index fa0ed46..4a0a654 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -110,7 +110,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
 	*phDispObject = NULL;
 
 	/* Allocate Node Dispatcher object */
-	MEM_ALLOC_OBJECT(disp_obj, struct disp_object, DISP_SIGNATURE);
+	disp_obj = kzalloc(sizeof(struct disp_object), GFP_KERNEL);
 	if (disp_obj == NULL)
 		status = DSP_EMEMORY;
 	else
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 04c7133..0fb6c09 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -442,7 +442,7 @@ dsp_status drv_create(OUT struct drv_object **phDRVObject)
 	DBC_REQUIRE(phDRVObject != NULL);
 	DBC_REQUIRE(refs > 0);
 
-	MEM_ALLOC_OBJECT(pdrv_object, struct drv_object, SIGNATURE);
+	pdrv_object = kzalloc(sizeof(struct drv_object), GFP_KERNEL);
 	if (pdrv_object) {
 		/* Create and Initialize List of device objects */
 		pdrv_object->dev_list = kzalloc(sizeof(struct lst_list),
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index cece9da..2fbbe29 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -65,7 +65,7 @@ dsp_status mgr_create(OUT struct mgr_object **phMgrObject,
 	DBC_REQUIRE(phMgrObject != NULL);
 	DBC_REQUIRE(refs > 0);
 
-	MEM_ALLOC_OBJECT(pmgr_obj, struct mgr_object, SIGNATURE);
+	pmgr_obj = kzalloc(sizeof(struct mgr_object), GFP_KERNEL);
 	if (pmgr_obj) {
 		status = dcd_create_manager(ZLDLLNAME, &pmgr_obj->hdcd_mgr);
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 924ac84..b9ba7e6 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -347,8 +347,7 @@ dsp_status nldr_allocate(struct nldr_object *nldr_obj, void *priv_ref,
 	/* Initialize handle in case of failure */
 	*phNldrNode = NULL;
 	/* Allocate node object */
-	MEM_ALLOC_OBJECT(nldr_node_obj, struct nldr_nodeobject,
-			 NLDR_NODESIGNATURE);
+	nldr_node_obj = kzalloc(sizeof(struct nldr_nodeobject), GFP_KERNEL);
 
 	if (nldr_node_obj == NULL) {
 		status = DSP_EMEMORY;
@@ -462,7 +461,7 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
 	DBC_REQUIRE(pattrs->pfn_write != NULL);
 
 	/* Allocate dynamic loader object */
-	MEM_ALLOC_OBJECT(nldr_obj, struct nldr_object, NLDR_SIGNATURE);
+	nldr_obj = kzalloc(sizeof(struct nldr_object), GFP_KERNEL);
 	if (nldr_obj) {
 		nldr_obj->hdev_obj = hdev_obj;
 		/* warning, lazy status checking alert! */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index fd2a284..231ca79 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -381,7 +381,7 @@ dsp_status node_allocate(struct proc_object *hprocessor,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	MEM_ALLOC_OBJECT(pnode, struct node_object, NODE_SIGNATURE);
+	pnode = kzalloc(sizeof(struct node_object), GFP_KERNEL);
 	if (pnode == NULL) {
 		status = DSP_EMEMORY;
 		goto func_end;
@@ -1317,7 +1317,7 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
 
 	*phNodeMgr = NULL;
 	/* Allocate Node manager object */
-	MEM_ALLOC_OBJECT(node_mgr_obj, struct node_mgr, NODEMGR_SIGNATURE);
+	node_mgr_obj = kzalloc(sizeof(struct node_mgr), GFP_KERNEL);
 	if (node_mgr_obj) {
 		node_mgr_obj->hdev_obj = hdev_obj;
 		node_mgr_obj->node_list = kzalloc(sizeof(struct lst_list),
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 975cd6e..c4f31a8 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -156,7 +156,7 @@ proc_attach(u32 processor_id,
 		goto func_end;
 
 	/* If we made it this far, create the Proceesor object: */
-	MEM_ALLOC_OBJECT(p_proc_object, struct proc_object, PROC_SIGNATURE);
+	p_proc_object = kzalloc(sizeof(struct proc_object), GFP_KERNEL);
 	/* Fill out the Processor Object: */
 	if (p_proc_object == NULL) {
 		status = DSP_EMEMORY;
@@ -292,7 +292,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	MEM_ALLOC_OBJECT(p_proc_object, struct proc_object, PROC_SIGNATURE);
+	p_proc_object = kzalloc(sizeof(struct proc_object), GFP_KERNEL);
 	if (p_proc_object == NULL) {
 		status = DSP_EMEMORY;
 		goto func_end;
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 861ab15..b63b069 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -185,7 +185,7 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
 	DBC_REQUIRE(num_segs == 0 || seg_tab != NULL);
 
 	/* Allocate DBL target object */
-	MEM_ALLOC_OBJECT(target, struct rmm_target_obj, RMM_TARGSIGNATURE);
+	target = kzalloc(sizeof(struct rmm_target_obj), GFP_KERNEL);
 
 	if (target == NULL)
 		status = DSP_EMEMORY;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 1c59db1..b1aec88 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -217,7 +217,7 @@ dsp_status strm_create(OUT struct strm_mgr **phStrmMgr,
 
 	*phStrmMgr = NULL;
 	/* Allocate STRM manager object */
-	MEM_ALLOC_OBJECT(strm_mgr_obj, struct strm_mgr, STRMMGR_SIGNATURE);
+	strm_mgr_obj = kzalloc(sizeof(struct strm_mgr), GFP_KERNEL);
 	if (strm_mgr_obj == NULL)
 		status = DSP_EMEMORY;
 	else
@@ -501,7 +501,7 @@ dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
 		status = node_get_strm_mgr(hnode, &strm_mgr_obj);
 
 	if (DSP_SUCCEEDED(status)) {
-		MEM_ALLOC_OBJECT(strm_obj, struct strm_object, STRM_SIGNATURE);
+		strm_obj = kzalloc(sizeof(struct strm_object), GFP_KERNEL);
 		if (strm_obj == NULL) {
 			status = DSP_EMEMORY;
 		} else {
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 7b24022..74e105d 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -402,7 +402,7 @@ dsp_status bridge_chnl_create(OUT struct chnl_mgr **phChnlMgr,
 	DBC_REQUIRE(pMgrAttrs->word_size != 0);
 
 	/* Allocate channel manager object */
-	MEM_ALLOC_OBJECT(chnl_mgr_obj, struct chnl_mgr, CHNL_MGRSIGNATURE);
+	chnl_mgr_obj = kzalloc(sizeof(struct chnl_mgr), GFP_KERNEL);
 	if (chnl_mgr_obj) {
 		/*
 		 * The max_channels attr must equal the # of supported chnls for
@@ -820,7 +820,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 
 	DBC_ASSERT(uChnlId < chnl_mgr_obj->max_channels);
 	/* Create channel object: */
-	MEM_ALLOC_OBJECT(pchnl, struct chnl_object, 0x0000);
+	pchnl = kzalloc(sizeof(struct chnl_object), GFP_KERNEL);
 	if (!pchnl) {
 		status = DSP_EMEMORY;
 		goto func_end;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 2bdfc2a..fdc9281 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -210,7 +210,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	shared_mem = (struct shm *)-1;
 
 	/* Allocate IO manager object */
-	MEM_ALLOC_OBJECT(pio_mgr, struct io_mgr, IO_MGRSIGNATURE);
+	pio_mgr = kzalloc(sizeof(struct io_mgr), GFP_KERNEL);
 	if (pio_mgr == NULL) {
 		status = DSP_EMEMORY;
 		goto func_end;
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index b055e98..8bb4e70 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -72,7 +72,7 @@ dsp_status bridge_msg_create(OUT struct msg_mgr **phMsgMgr,
 	}
 	*phMsgMgr = NULL;
 	/* Allocate msg_ctrl manager object */
-	MEM_ALLOC_OBJECT(msg_mgr_obj, struct msg_mgr, MSGMGR_SIGNATURE);
+	msg_mgr_obj = kzalloc(sizeof(struct msg_mgr), GFP_KERNEL);
 
 	if (msg_mgr_obj) {
 		msg_mgr_obj->on_exit = msgCallback;
@@ -141,7 +141,7 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
 
 	*phMsgQueue = NULL;
 	/* Allocate msg_queue object */
-	MEM_ALLOC_OBJECT(msg_q, struct msg_queue, MSGQ_SIGNATURE);
+	msg_q = kzalloc(sizeof(struct msg_queue), GFP_KERNEL);
 	if (!msg_q) {
 		status = DSP_EMEMORY;
 		goto func_end;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 6c1b318..e94afc8 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -82,7 +82,7 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	DBC_ASSERT(hwmd_context);
 	dummy_va_addr = 0;
 	/* Allocate IO manager object: */
-	MEM_ALLOC_OBJECT(deh_mgr_obj, struct deh_mgr, SIGNATURE);
+	deh_mgr_obj = kzalloc(sizeof(struct deh_mgr), GFP_KERNEL);
 	if (deh_mgr_obj == NULL) {
 		status = DSP_EMEMORY;
 	} else {
-- 
1.7.0.3
