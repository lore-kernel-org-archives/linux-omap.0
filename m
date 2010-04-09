From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Avoid possible NULL pointer dereference in
 dspbridge
Date: Thu, 8 Apr 2010 19:17:10 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB048971@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933974Ab0DIARP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:17:15 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 1471823b7a143bbb9566aaa192880309668f1bf9 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 24 Mar 2010 16:37:38 -0600
Subject: [PATCH] DSPBRIDGE: Avoid possible NULL pointer dereference in dspbridge

Avoid possible NULL pointer dereference in dspbridge reported by KW.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/dev.c           |   14 +++-----
 drivers/dsp/bridge/rmgr/nldr.c          |   20 +++++++-----
 drivers/dsp/bridge/rmgr/node.c          |    8 ++++-
 drivers/dsp/bridge/rmgr/proc.c          |   51 +++++++++++++++++++++----------
 drivers/dsp/bridge/wmd/io_sm.c          |    8 ++++-
 drivers/dsp/bridge/wmd/tiomap3430.c     |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    4 ++-
 7 files changed, 67 insertions(+), 40 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5bc16e9..f424009 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -700,16 +700,12 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(pstrSym != NULL && pul_value != NULL);
 
-	if (IS_VALID_HANDLE(hdev_obj)) {
-		status = dev_get_cod_mgr(hdev_obj, &cod_mgr);
-		if (DSP_SUCCEEDED(status)) {
-			DBC_ASSERT(cod_mgr != NULL);
-			status = cod_get_sym_value(cod_mgr, (char *)pstrSym,
-						   pul_value);
-		}
-	} else {
+	status = dev_get_cod_mgr(hdev_obj, &cod_mgr);
+	if (cod_mgr)
+		status = cod_get_sym_value(cod_mgr, (char *)pstrSym,
+					   pul_value);
+	else
 		status = DSP_EHANDLE;
-	}
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 6a88ea8..f796d37 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -466,15 +466,17 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
 	if (nldr_obj) {
 		nldr_obj->hdev_obj = hdev_obj;
 		/* warning, lazy status checking alert! */
-		status = dev_get_cod_mgr(hdev_obj, &cod_mgr);
-		DBC_ASSERT(DSP_SUCCEEDED(status));
-		status = cod_get_loader(cod_mgr, &nldr_obj->dbll);
-		DBC_ASSERT(DSP_SUCCEEDED(status));
-		status = cod_get_base_lib(cod_mgr, &nldr_obj->base_lib);
-		DBC_ASSERT(DSP_SUCCEEDED(status));
-		status =
-		    cod_get_base_name(cod_mgr, sz_zl_file, COD_MAXPATHLENGTH);
-		DBC_ASSERT(DSP_SUCCEEDED(status));
+		dev_get_cod_mgr(hdev_obj, &cod_mgr);
+		if (cod_mgr) {
+			status = cod_get_loader(cod_mgr, &nldr_obj->dbll);
+			DBC_ASSERT(DSP_SUCCEEDED(status));
+			status = cod_get_base_lib(cod_mgr, &nldr_obj->base_lib);
+			DBC_ASSERT(DSP_SUCCEEDED(status));
+			status =
+			    cod_get_base_name(cod_mgr, sz_zl_file,
+							COD_MAXPATHLENGTH);
+			DBC_ASSERT(DSP_SUCCEEDED(status));
+		}
 		status = DSP_SOK;
 		/* end lazy status checking */
 		nldr_obj->us_dsp_mau_size = pattrs->us_dsp_mau_size;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 66e28c7..ea4c627 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -442,8 +442,10 @@ dsp_status node_allocate(struct proc_object *hprocessor,
 	}
 #ifdef DSP_DMM_DEBUG
 	status = dmm_get_handle(p_proc_object, &dmm_mgr);
-	if (DSP_FAILED(status))
+	if (!dmm_mgr) {
+		status = DSP_EHANDLE;
 		goto func_cont;
+	}
 
 	dmm_mem_map_dump(dmm_mgr);
 #endif
@@ -2599,8 +2601,10 @@ static void delete_node(struct node_object *hnode,
 							pr_ctxt);
 #ifdef DSP_DMM_DEBUG
 			status = dmm_get_handle(p_proc_object, &dmm_mgr);
-			if (DSP_SUCCEEDED(status))
+			if (dmm_mgr)
 				dmm_mem_map_dump(dmm_mgr);
+			else
+				status = DSP_EHANDLE;
 #endif
 		}
 	}
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f6c67cf..b6846e5 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -623,32 +623,37 @@ dsp_status proc_get_resource_info(void *hprocessor, u32 resource_type,
 	case DSP_RESOURCE_DYNSRAM:
 		status = dev_get_node_manager(p_proc_object->hdev_obj,
 					      &hnode_mgr);
-		if (DSP_FAILED(status))
+		if (!hnode_mgr) {
+			status = DSP_EHANDLE;
 			goto func_end;
+		}
 
 		status = node_get_nldr_obj(hnode_mgr, &nldr_obj);
 		if (DSP_SUCCEEDED(status)) {
 			status = nldr_get_rmm_manager(nldr_obj, &rmm);
-			if (DSP_SUCCEEDED(status)) {
-				DBC_ASSERT(rmm != NULL);
+			if (rmm) {
 				if (!rmm_stat(rmm,
 					      (enum dsp_memtype)resource_type,
 					      (struct dsp_memstat *)
 					      &(resource_info->result.
 						mem_stat)))
 					status = DSP_EVALUE;
+			} else {
+				status = DSP_EHANDLE;
 			}
 		}
 		break;
 	case DSP_RESOURCE_PROCLOAD:
 		status = dev_get_io_mgr(p_proc_object->hdev_obj, &hio_mgr);
-		if (DSP_SUCCEEDED(status))
+		if (hio_mgr)
 			status =
 			    p_proc_object->intf_fxns->
 			    pfn_io_get_proc_load(hio_mgr,
 						 (struct dsp_procloadstat *)
 						 &(resource_info->result.
 						   proc_load_stat));
+		else
+			status = DSP_EHANDLE;
 		break;
 	default:
 		status = DSP_EFAIL;
@@ -842,12 +847,12 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv1);
 #endif
-	/* Call the WMD_BRD_Load fxn */
 	if (!MEM_IS_VALID_HANDLE(p_proc_object, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
-	if (DSP_FAILED(dev_get_cod_mgr(p_proc_object->hdev_obj, &cod_mgr))) {
+	dev_get_cod_mgr(p_proc_object->hdev_obj, &cod_mgr);
+	if (!cod_mgr) {
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -957,9 +962,11 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Device object's message manager */
 		status = dev_get_io_mgr(p_proc_object->hdev_obj, &hio_mgr);
-		DBC_ASSERT(DSP_SUCCEEDED(status));
-		status =
-		    (*p_proc_object->intf_fxns->pfn_io_on_loaded) (hio_mgr);
+		if (hio_mgr)
+			status = (*p_proc_object->intf_fxns->pfn_io_on_loaded)
+								(hio_mgr);
+		else
+			status = DSP_EHANDLE;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Now, attempt to load an exec: */
@@ -1014,7 +1021,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 				status =
 				    dev_get_dmm_mgr(p_proc_object->hdev_obj,
 						    &dmm_mgr);
-				if (DSP_SUCCEEDED(status)) {
+				if (dmm_mgr) {
 					/* Set dw_ext_end to DMM START u8
 					 * address */
 					dw_ext_end =
@@ -1023,6 +1030,8 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 					status = dmm_create_tables(dmm_mgr,
 								   dw_ext_end,
 								   DMMPOOLSIZE);
+				} else {
+					status = DSP_EHANDLE;
 				}
 			}
 		}
@@ -1099,9 +1108,11 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	}
 	/* Critical section */
 	mutex_lock(&proc_lock);
-	status = dmm_get_handle(p_proc_object, &dmm_mgr);
-	if (DSP_SUCCEEDED(status))
+	dmm_get_handle(p_proc_object, &dmm_mgr);
+	if (dmm_mgr)
 		status = dmm_map_memory(dmm_mgr, va_align, size_align);
+	else
+		status = DSP_EHANDLE;
 
 	/* Add mapping to the page tables. */
 	if (DSP_SUCCEEDED(status)) {
@@ -1242,8 +1253,10 @@ dsp_status proc_reserve_memory(void *hprocessor, u32 ul_size,
 	}
 
 	status = dmm_get_handle(p_proc_object, &dmm_mgr);
-	if (DSP_FAILED(status))
+	if (!dmm_mgr) {
+		status = DSP_EHANDLE;
 		goto func_end;
+	}
 
 	status = dmm_reserve_memory(dmm_mgr, ul_size, (u32 *) pp_rsv_addr);
 	if (status != DSP_SOK)
@@ -1293,8 +1306,10 @@ dsp_status proc_start(void *hprocessor)
 		goto func_end;
 	}
 	status = dev_get_cod_mgr(p_proc_object->hdev_obj, &cod_mgr);
-	if (DSP_FAILED(status))
+	if (!cod_mgr) {
+		status = DSP_EHANDLE;
 		goto func_cont;
+	}
 
 	status = cod_get_entry(cod_mgr, &dw_dsp_addr);
 	if (DSP_FAILED(status))
@@ -1432,8 +1447,10 @@ dsp_status proc_un_map(void *hprocessor, void *map_addr,
 	}
 
 	status = dmm_get_handle(hprocessor, &dmm_mgr);
-	if (DSP_FAILED(status))
+	if (!dmm_mgr) {
+		status = DSP_EHANDLE;
 		goto func_end;
+	}
 
 	/* Critical section */
 	mutex_lock(&proc_lock);
@@ -1491,8 +1508,10 @@ dsp_status proc_un_reserve_memory(void *hprocessor, void *prsv_addr,
 	}
 
 	status = dmm_get_handle(p_proc_object, &dmm_mgr);
-	if (DSP_FAILED(status))
+	if (!dmm_mgr) {
+		status = DSP_EHANDLE;
 		goto func_end;
+	}
 
 	status = dmm_un_reserve_memory(dmm_mgr, (u32) prsv_addr);
 	if (status != DSP_SOK)
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 480968d..5d84bdf 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -346,8 +346,10 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	};
 
 	status = dev_get_cod_mgr(hio_mgr->hdev_obj, &cod_man);
-	if (DSP_FAILED(status))
+	if (!cod_man) {
+		status = DSP_EHANDLE;
 		goto func_end;
+	}
 	hchnl_mgr = hio_mgr->hchnl_mgr;
 	/* The message manager is destroyed when the board is stopped. */
 	dev_get_msg_mgr(hio_mgr->hdev_obj, &hio_mgr->hmsg_mgr);
@@ -1911,10 +1913,12 @@ dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
 
 	status = dev_get_cod_mgr(dev_obj, &cod_mgr);
 
-	if (DSP_SUCCEEDED(status))
+	if (cod_mgr)
 		/* Look for SYS_PUTCBEG/SYS_PUTCEND */
 		status =
 		    cod_get_sym_value(cod_mgr, COD_TRACEBEG, &ul_trace_begin);
+	else
+		status = DSP_EHANDLE;
 
 	if (DSP_SUCCEEDED(status))
 		status =
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 356e16e..b4af504 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -682,7 +682,7 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 		dsp_wdt_enable(true);
 
 		status = dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
-		if (DSP_SUCCEEDED(status)) {
+		if (hio_mgr) {
 			io_sh_msetting(hio_mgr, SHM_OPPINFO, NULL);
 			/* Write the synchronization bit to indicate the
 			 * completion of OPP table update to DSP
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index c15f0c9..6eca930 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -126,8 +126,10 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
 #ifdef CONFIG_BRIDGE_DVFS
 			status =
 			    dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
-			if (DSP_FAILED(status))
+			if (!hio_mgr) {
+				status = DSP_EHANDLE;
 				return status;
+			}
 			io_sh_msetting(hio_mgr, SHM_GETOPP, &opplevel);
 
 			/*
-- 
1.6.0.4

