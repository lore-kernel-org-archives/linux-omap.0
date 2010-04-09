From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 07/13] DSPBRIDGE: Replace MEM_FREE_OBJECT macro by kfree
 function
Date: Thu, 8 Apr 2010 19:06:00 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D152@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43954 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0DIAGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:06:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a0d8b79b9125351d39dc33f85a3f2d35de32395f Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Wed, 24 Mar 2010 14:57:43 -0600
Subject: [PATCH 07/13] DSPBRIDGE: Replace MEM_FREE_OBJECT macro by kfree function

As the dw_signature is not used in the patch "Replace MEM_ALLOC_OBJECT
macro by kzalloc function", then the MEM_FREE_OBJECT can be replaced
by the kfree function.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/pmgr/cmm.c    |    6 +++---
 drivers/dsp/bridge/pmgr/dbll.c   |    4 ++--
 drivers/dsp/bridge/pmgr/dev.c    |    5 ++---
 drivers/dsp/bridge/pmgr/dmm.c    |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c  |    2 +-
 drivers/dsp/bridge/rmgr/disp.c   |    2 +-
 drivers/dsp/bridge/rmgr/drv.c    |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c    |    6 +++---
 drivers/dsp/bridge/rmgr/nldr.c   |    4 ++--
 drivers/dsp/bridge/rmgr/node.c   |    4 ++--
 drivers/dsp/bridge/rmgr/proc.c   |   12 ++++++------
 drivers/dsp/bridge/rmgr/rmm.c    |    2 +-
 drivers/dsp/bridge/rmgr/strm.c   |    4 ++--
 drivers/dsp/bridge/wmd/chnl_sm.c |    6 +++---
 drivers/dsp/bridge/wmd/io_sm.c   |    2 +-
 drivers/dsp/bridge/wmd/msg_sm.c  |    4 ++--
 drivers/dsp/bridge/wmd/ue_deh.c  |    2 +-
 17 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 147ad5e..9b6d642 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -364,7 +364,7 @@ dsp_status cmm_destroy(struct cmm_object *hcmm_mgr, bool bForce)
 	if (DSP_SUCCEEDED(status)) {
 		/* delete CS & cmm mgr object */
 		mutex_destroy(&cmm_mgr_obj->cmm_lock);
-		MEM_FREE_OBJECT(cmm_mgr_obj);
+		kfree(cmm_mgr_obj);
 	}
 	return status;
 }
@@ -753,7 +753,7 @@ static void un_register_gppsm_seg(struct cmm_allocator *psma)
 		MEM_UNMAP_LINEAR_ADDRESS((void *)psma->dw_vm_base);
 
 	/* Free allocator itself */
-	MEM_FREE_OBJECT(psma);
+	kfree(psma);
 }
 
 /*
@@ -1008,7 +1008,7 @@ dsp_status cmm_xlator_delete(struct cmm_xlatorobject *xlator, bool bForce)
 	DBC_REQUIRE(refs > 0);
 
 	if (MEM_IS_VALID_HANDLE(xlator_obj, CMMXLATESIGNATURE)) {
-		MEM_FREE_OBJECT(xlator_obj);
+		kfree(xlator_obj);
 	} else {
 		status = DSP_EHANDLE;
 	}
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 2fb05a0..3b67a03 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -237,7 +237,7 @@ void dbll_close(struct dbll_library_obj *zl_lib)
 			gh_delete(zl_lib->sym_tab);
 
 		/* remove the library object itself */
-		MEM_FREE_OBJECT(zl_lib);
+		kfree(zl_lib);
 		zl_lib = NULL;
 	}
 }
@@ -286,7 +286,7 @@ void dbll_delete(struct dbll_tar_obj *target)
 	DBC_REQUIRE(MEM_IS_VALID_HANDLE(zl_target, DBLL_TARGSIGNATURE));
 
 	if (zl_target != NULL)
-		MEM_FREE_OBJECT(zl_target);
+		kfree(zl_target);
 
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 1e55f55..8a51ee7 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -267,8 +267,7 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
 		if (dev_obj && dev_obj->dmm_mgr)
 			dmm_destroy(dev_obj->dmm_mgr);
 
-		if (dev_obj)
-			MEM_FREE_OBJECT(dev_obj);
+		kfree(dev_obj);
 
 		*phDevObject = NULL;
 	}
@@ -401,7 +400,7 @@ dsp_status dev_destroy_device(struct dev_object *hdev_obj)
 			/* Free The library * LDR_FreeModule
 			 * (dev_obj->module_obj); */
 			/* Free this dev object: */
-			MEM_FREE_OBJECT(dev_obj);
+			kfree(dev_obj);
 			dev_obj = NULL;
 		}
 	} else {
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index d25cca7..322e0f5 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -162,7 +162,7 @@ dsp_status dmm_destroy(struct dmm_object *dmm_mgr)
 	if (MEM_IS_VALID_HANDLE(dmm_mgr, DMMSIGNATURE)) {
 		status = dmm_delete_tables(dmm_obj);
 		if (DSP_SUCCEEDED(status))
-			MEM_FREE_OBJECT(dmm_obj);
+			kfree(dmm_obj);
 	} else
 		status = DSP_EHANDLE;
 
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 1bc6856..70806af 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -187,7 +187,7 @@ dsp_status dcd_destroy_manager(IN struct dcd_manager *hdcd_mgr)
 		cod_delete(dcd_mgr_obj->cod_mgr);
 
 		/* Deallocate a DCD manager object. */
-		MEM_FREE_OBJECT(dcd_mgr_obj);
+		kfree(dcd_mgr_obj);
 
 		status = DSP_SOK;
 	}
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 4a0a654..344beaa 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -628,7 +628,7 @@ static void delete_disp(struct disp_object *disp_obj)
 		}
 		kfree(disp_obj->pbuf);
 
-		MEM_FREE_OBJECT(disp_obj);
+		kfree(disp_obj);
 	}
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 0fb6c09..4054a4c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -515,7 +515,7 @@ dsp_status drv_destroy(struct drv_object *hDRVObject)
 	 */
 	kfree(pdrv_object->dev_list);
 	kfree(pdrv_object->dev_node_string);
-	MEM_FREE_OBJECT(pdrv_object);
+	kfree(pdrv_object);
 	/* Update the DRV Object in Registry to be 0 */
 	(void)cfg_set_object(0, REG_DRV_OBJECT);
 	DBC_ENSURE(!MEM_IS_VALID_HANDLE(pdrv_object, SIGNATURE));
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 2fbbe29..3eda5ec 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -75,11 +75,11 @@ dsp_status mgr_create(OUT struct mgr_object **phMgrObject,
 				*phMgrObject = pmgr_obj;
 			} else {
 				dcd_destroy_manager(pmgr_obj->hdcd_mgr);
-				MEM_FREE_OBJECT(pmgr_obj);
+				kfree(pmgr_obj);
 			}
 		} else {
 			/* failed to Create DCD Manager */
-			MEM_FREE_OBJECT(pmgr_obj);
+			kfree(pmgr_obj);
 		}
 	} else {
 		status = DSP_EMEMORY;
@@ -106,7 +106,7 @@ dsp_status mgr_destroy(struct mgr_object *hmgr_obj)
 	if (hmgr_obj->hdcd_mgr)
 		dcd_destroy_manager(hmgr_obj->hdcd_mgr);
 
-	MEM_FREE_OBJECT(pmgr_obj);
+	kfree(pmgr_obj);
 	/* Update the Registry with NULL for MGR Object */
 	(void)cfg_set_object(0, REG_MGR_OBJECT);
 
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index b9ba7e6..73bac50 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -422,7 +422,7 @@ dsp_status nldr_allocate(struct nldr_object *nldr_obj, void *priv_ref,
 	}
 	/* Cleanup on failure */
 	if (DSP_FAILED(status) && nldr_node_obj)
-		MEM_FREE_OBJECT(nldr_node_obj);
+		kfree(nldr_node_obj);
 
 	DBC_ENSURE((DSP_SUCCEEDED(status) &&
 		    MEM_IS_VALID_HANDLE(((struct nldr_nodeobject
@@ -669,7 +669,7 @@ void nldr_delete(struct nldr_object *nldr_obj)
 		}
 		kfree(nldr_obj->ovly_table);
 	}
-	MEM_FREE_OBJECT(nldr_obj);
+	kfree(nldr_obj);
 	DBC_ENSURE(!MEM_IS_VALID_HANDLE(nldr_obj, NLDR_SIGNATURE));
 }
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 231ca79..9531921 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2636,7 +2636,7 @@ static void delete_node(struct node_object *hnode,
 	kfree(hnode->nldr_node_obj);
 	hnode->nldr_node_obj = NULL;
 	hnode->hnode_mgr = NULL;
-	MEM_FREE_OBJECT(hnode);
+	kfree(hnode);
 	hnode = NULL;
 func_end:
 	return;
@@ -2699,7 +2699,7 @@ static void delete_node_mgr(struct node_mgr *hnode_mgr)
 		if (hnode_mgr->loader_init)
 			hnode_mgr->nldr_fxns.pfn_exit();
 
-		MEM_FREE_OBJECT(hnode_mgr);
+		kfree(hnode_mgr);
 	}
 }
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c4f31a8..236e05a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -180,9 +180,9 @@ proc_attach(u32 processor_id,
 		status = dev_get_wmd_context(hdev_obj,
 					     &p_proc_object->hwmd_context);
 		if (DSP_FAILED(status))
-			MEM_FREE_OBJECT(p_proc_object);
+			kfree(p_proc_object);
 	} else
-		MEM_FREE_OBJECT(p_proc_object);
+		kfree(p_proc_object);
 
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -217,7 +217,7 @@ proc_attach(u32 processor_id,
 				kfree(p_proc_object->ntfy_obj);
 			}
 
-			MEM_FREE_OBJECT(p_proc_object);
+			kfree(p_proc_object);
 		}
 		if (DSP_SUCCEEDED(status)) {
 			*ph_processor = (void *)p_proc_object;
@@ -227,7 +227,7 @@ proc_attach(u32 processor_id,
 		}
 	} else {
 		/* Don't leak memory if DSP_FAILED */
-		MEM_FREE_OBJECT(p_proc_object);
+		kfree(p_proc_object);
 	}
 func_end:
 	DBC_ENSURE((status == DSP_EFAIL && *ph_processor == NULL) ||
@@ -328,7 +328,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
 	kfree(p_proc_object->psz_last_coff);
 	p_proc_object->psz_last_coff = NULL;
 func_cont:
-	MEM_FREE_OBJECT(p_proc_object);
+	kfree(p_proc_object);
 func_end:
 	return status;
 }
@@ -418,7 +418,7 @@ dsp_status proc_detach(struct process_context *pr_ctxt)
 		(void)dev_remove_proc_object(p_proc_object->hdev_obj,
 					     (u32) p_proc_object);
 		/* Free the Processor Object */
-		MEM_FREE_OBJECT(p_proc_object);
+		kfree(p_proc_object);
 		pr_ctxt->hprocessor = NULL;
 	} else {
 		status = DSP_EHANDLE;
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index b63b069..ed29272 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -295,7 +295,7 @@ void rmm_delete(struct rmm_target_obj *target)
 		kfree(target->free_list);
 	}
 
-	MEM_FREE_OBJECT(target);
+	kfree(target);
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b1aec88..e50fcd4 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -853,7 +853,7 @@ static dsp_status delete_strm(struct strm_object *hStrm)
 				}
 			}
 		}
-		MEM_FREE_OBJECT(hStrm);
+		kfree(hStrm);
 	} else {
 		status = DSP_EHANDLE;
 	}
@@ -868,5 +868,5 @@ static dsp_status delete_strm(struct strm_object *hStrm)
 static void delete_strm_mgr(struct strm_mgr *strm_mgr_obj)
 {
 	if (MEM_IS_VALID_HANDLE(strm_mgr_obj, STRMMGR_SIGNATURE))
-		MEM_FREE_OBJECT(strm_mgr_obj);
+		kfree(strm_mgr_obj);
 }
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 74e105d..1273a46 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -373,7 +373,7 @@ func_cont:
 			pchnl->free_packets_list = NULL;
 		}
 		/* Release channel object. */
-		MEM_FREE_OBJECT(pchnl);
+		kfree(pchnl);
 		pchnl = NULL;
 	}
 	DBC_ENSURE(DSP_FAILED(status) ||
@@ -473,7 +473,7 @@ dsp_status bridge_chnl_destroy(struct chnl_mgr *hchnl_mgr)
 		/* Set hchnl_mgr to NULL in device object. */
 		dev_set_chnl_mgr(chnl_mgr_obj->hdev_obj, NULL);
 		/* Free this Chnl Mgr object: */
-		MEM_FREE_OBJECT(hchnl_mgr);
+		kfree(hchnl_mgr);
 	} else {
 		status = DSP_EHANDLE;
 	}
@@ -892,7 +892,7 @@ dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
 			kfree(pchnl->ntfy_obj);
 			pchnl->ntfy_obj = NULL;
 		}
-		MEM_FREE_OBJECT(pchnl);
+		kfree(pchnl);
 	} else {
 		/* Insert channel object in channel manager: */
 		chnl_mgr_obj->ap_channel[pchnl->chnl_id] = pchnl;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index fdc9281..b1c2ef5 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -284,7 +284,7 @@ dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 #endif
 		dsp_wdt_exit();
 		/* Free this IO manager object */
-		MEM_FREE_OBJECT(hio_mgr);
+		kfree(hio_mgr);
 	} else {
 		status = DSP_EHANDLE;
 	}
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 8bb4e70..8ba41c2 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -604,7 +604,7 @@ static void delete_msg_mgr(struct msg_mgr *hmsg_mgr)
 
 	kfree(hmsg_mgr->sync_event);
 
-	MEM_FREE_OBJECT(hmsg_mgr);
+	kfree(hmsg_mgr);
 func_end:
 	return;
 }
@@ -656,7 +656,7 @@ static void delete_msg_queue(struct msg_queue *msg_queue_obj, u32 uNumToDSP)
 	kfree(msg_queue_obj->sync_done);
 	kfree(msg_queue_obj->sync_done_ack);
 
-	MEM_FREE_OBJECT(msg_queue_obj);
+	kfree(msg_queue_obj);
 func_end:
 	return;
 
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index e94afc8..fee5c7e 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -156,7 +156,7 @@ dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 		tasklet_kill(&deh_mgr_obj->dpc_tasklet);
 
 		/* Deallocate the DEH manager object */
-		MEM_FREE_OBJECT(deh_mgr_obj);
+		kfree(deh_mgr_obj);
 	}
 
 	return status;
-- 
1.7.0.3
