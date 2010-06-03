From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 26/40] DSPBRIDGE: err code replace DSP_ENOTFOUND with ENOENT
Date: Thu,  3 Jun 2010 00:47:39 -0500
Message-ID: <1275544073-20418-27-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab0FCF4V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:21 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_ENOTFOUND with ENOENT

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/proc.h |    6 +++---
 drivers/dsp/bridge/pmgr/dmm.c               |    6 +++---
 drivers/dsp/bridge/rmgr/drv.c               |    8 ++++----
 drivers/dsp/bridge/rmgr/nldr.c              |    2 +-
 drivers/dsp/bridge/rmgr/node.c              |    4 ++--
 drivers/dsp/bridge/rmgr/strm.c              |    6 +++---
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 11595d6..9311f72 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -515,7 +515,7 @@ extern dsp_status proc_invalidate_memory(void *hprocessor,
  *      -EFAULT     :   Invalid processor handle.
  *      -EPERM       :   General failure.
  *      -ENOMEM     :   MPU side memory allocation error.
- *      DSP_ENOTFOUND   :   Cannot find a reserved region starting with this
+ *      -ENOENT   :   Cannot find a reserved region starting with this
  *		      :   address.
  *  Requires:
  *      pmpu_addr is not NULL
@@ -566,7 +566,7 @@ extern dsp_status proc_reserve_memory(void *hprocessor,
  *      0	 :   Success.
  *      -EFAULT     :   Invalid processor handle.
  *      -EPERM       :   General failure.
- *      DSP_ENOTFOUND   :   Cannot find a mapped region starting with this
+ *      -ENOENT   :   Cannot find a mapped region starting with this
  *		      :   address.
  *  Requires:
  *      map_addr is not NULL
@@ -588,7 +588,7 @@ extern dsp_status proc_un_map(void *hprocessor, void *map_addr,
  *      0	 :   Success.
  *      -EFAULT     :   Invalid processor handle.
  *      -EPERM       :   General failure.
- *      DSP_ENOTFOUND   :   Cannot find a reserved region starting with this
+ *      -ENOENT   :   Cannot find a reserved region starting with this
  *		      :   address.
  *  Requires:
  *      prsv_addr is not NULL
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 5e8b770..bf2c0e1 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -261,7 +261,7 @@ dsp_status dmm_map_memory(struct dmm_object *dmm_mgr, u32 addr, u32 size)
 		chunk->mapped = true;
 		chunk->mapped_size = (size / PG_SIZE4K);
 	} else
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 	spin_unlock(&dmm_obj->dmm_lock);
 
 	dev_dbg(bridge, "%s dmm_mgr %p, addr %x, size %x\n\tstatus %x, "
@@ -336,7 +336,7 @@ dsp_status dmm_un_map_memory(struct dmm_object *dmm_mgr, u32 addr, u32 *psize)
 	spin_lock(&dmm_obj->dmm_lock);
 	chunk = get_mapped_region(addr);
 	if (chunk == NULL)
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Unmap the region */
@@ -370,7 +370,7 @@ dsp_status dmm_un_reserve_memory(struct dmm_object *dmm_mgr, u32 rsv_addr)
 	/* Find the chunk containing the reserved address */
 	chunk = get_mapped_region(rsv_addr);
 	if (chunk == NULL)
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Free all the mapped pages for this reserved region */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 4869e2c..a92b0d7 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -131,7 +131,7 @@ dsp_status drv_remove_node_res_element(void *hNodeRes, void *hPCtxt)
 		while (temp_node && temp_node->next != node_res_obj)
 			temp_node = temp_node->next;
 		if (!temp_node)
-			status = DSP_ENOTFOUND;
+			status = -ENOENT;
 		else
 			temp_node->next = node_res_obj->next;
 	}
@@ -267,7 +267,7 @@ dsp_status drv_get_node_res_element(void *hnode, void *hNodeRes,
 	if (temp_node != NULL)
 		*node_res = temp_node;
 	else
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 
 	return status;
 }
@@ -328,7 +328,7 @@ dsp_status drv_proc_remove_strm_res_element(void *hstrm_res, void *hPCtxt)
 		while (temp_strm_res && temp_strm_res->next != pstrm_res)
 			temp_strm_res = temp_strm_res->next;
 		if (temp_strm_res == NULL)
-			status = DSP_ENOTFOUND;
+			status = -ENOENT;
 		else
 			temp_strm_res->next = pstrm_res->next;
 	}
@@ -405,7 +405,7 @@ dsp_status drv_get_strm_res_element(void *hStrm, void *hstrm_res,
 	if (temp_strm != NULL)
 		*strm_res = temp_strm;
 	else
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index b6044e0..d2cd465 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1492,7 +1492,7 @@ static dsp_status load_ovly(struct nldr_nodeobject *nldr_node_obj,
 	DBC_ASSERT(i < nldr_obj->ovly_nodes);
 
 	if (!po_node) {
-		status = DSP_ENOTFOUND;
+		status = -ENOENT;
 		goto func_end;
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 20bfe18..bb021dd 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1573,7 +1573,7 @@ func_cont1:
 	/*  Free host-side resources allocated by node_create()
 	 *  delete_node() fails if SM buffers not freed by client! */
 	if (drv_get_node_res_element(hnode, &node_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
+	    -ENOENT)
 		drv_proc_node_update_status(node_res, false);
 	delete_node(hnode, pr_ctxt);
 
@@ -3200,7 +3200,7 @@ dsp_status node_find_addr(struct node_mgr *node_mgr, u32 sym_addr,
 		u32 offset_range, void *sym_addr_output, char *sym_name)
 {
 	struct node_object *node_obj;
-	dsp_status status = DSP_ENOTFOUND;
+	dsp_status status = -ENOENT;
 	u32 n;
 
 	pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__,
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 094b134..061175e 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -139,7 +139,7 @@ dsp_status strm_allocate_buffer(struct strm_object *hStrm, u32 usize,
 		goto func_end;
 
 	if (drv_get_strm_res_element(hStrm, &hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
+	    -ENOENT)
 		drv_proc_update_strm_res(num_bufs, hstrm_res);
 
 func_end:
@@ -183,7 +183,7 @@ dsp_status strm_close(struct strm_object *hStrm,
 		goto func_end;
 
 	if (drv_get_strm_res_element(hStrm, &hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
+	    -ENOENT)
 		drv_proc_remove_strm_res_element(hstrm_res, pr_ctxt);
 func_end:
 	DBC_ENSURE(status == 0 || status == -EFAULT ||
@@ -297,7 +297,7 @@ dsp_status strm_free_buffer(struct strm_object *hStrm, u8 ** ap_buffer,
 		}
 	}
 	if (drv_get_strm_res_element(hStrm, hstrm_res, pr_ctxt) !=
-	    DSP_ENOTFOUND)
+	    -ENOENT)
 		drv_proc_update_strm_res(num_bufs - i, hstrm_res);
 
 	return status;
-- 
1.7.1

