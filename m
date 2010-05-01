From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 2/6] DSPBRIDGE: remember mapping and page info in proc_map
Date: Sat,  1 May 2010 23:44:27 +0300
Message-ID: <1272746671-13423-3-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:19785 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0EAUrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:47:51 -0400
Received: by fg-out-1718.google.com with SMTP id d23so560455fga.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:47:50 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Every time the MM application calls proc_map to map
a memory area, remember the details of that mapping,
together with the related page structures.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 arch/arm/plat-omap/include/dspbridge/wmd.h |    3 +-
 drivers/dsp/bridge/rmgr/proc.c             |   55 ++++++++++++++++++++++++++--
 drivers/dsp/bridge/wmd/io_sm.c             |   10 +++--
 drivers/dsp/bridge/wmd/tiomap3430.c        |   11 +++++-
 4 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index f9883db..37ee0f3 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -182,7 +182,8 @@ typedef dsp_status(*fxn_brd_memwrite) (struct wmd_dev_context
 typedef dsp_status(*fxn_brd_memmap) (struct wmd_dev_context
 				     * hDevContext, u32 ul_mpu_addr,
 				     u32 ulVirtAddr, u32 ul_num_bytes,
-				     u32 ulMapAttrs);
+				     u32 ulMapAttrs,
+				     struct page **mapped_pages);
 
 /*
  *  ======== bridge_brd_mem_un_map ========
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 95a194a..b03232f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -130,6 +130,45 @@ static s32 get_envp_count(char **envp);
 static char **prepend_envp(char **new_envp, char **envp, s32 envp_elems,
 			   s32 cnew_envp, char *szVar);
 
+/* remember mapping information */
+static struct memory_map_info *add_mapping_info(struct proc_object *pr_obj,
+				u32 mpu_addr, u32 dsp_addr, u32 size)
+{
+	struct memory_map_info *map_info;
+
+	u32 num_usr_pgs = size / PG_SIZE4K;
+
+	pr_debug("%s: adding map info: mpu_addr 0x%x virt 0x%x size 0x%x\n",
+						__func__, mpu_addr,
+						dsp_addr, size);
+
+	map_info = kzalloc(sizeof(struct memory_map_info), GFP_KERNEL);
+	if (!map_info) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&map_info->node);
+
+	map_info->pages = kcalloc(num_usr_pgs, sizeof(struct page *),
+							GFP_KERNEL);
+	if (!map_info->pages) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		kfree(map_info);
+		return NULL;
+	}
+
+	map_info->mpu_addr = mpu_addr;
+	map_info->dsp_addr = dsp_addr;
+	map_info->size = size;
+	map_info->num_usr_pgs = num_usr_pgs;
+
+	spin_lock(&pr_obj->maps_lock);
+	list_add(&map_info->node, &pr_obj->maps);
+	spin_unlock(&pr_obj->maps_lock);
+
+	return map_info;
+}
+
 /*
  *  ======== proc_attach ========
  *  Purpose:
@@ -185,6 +224,8 @@ proc_attach(u32 processor_id,
 	p_proc_object->process = current->tgid;
 
 	INIT_LIST_HEAD(&p_proc_object->proc_list);
+	INIT_LIST_HEAD(&p_proc_object->maps);
+	spin_lock_init(&p_proc_object->maps_lock);
 
 	if (attr_in)
 		p_proc_object->utimeout = attr_in->utimeout;
@@ -1091,6 +1132,7 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	dsp_status status = DSP_SOK;
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
 	struct dmm_map_object *map_obj;
+	struct memory_map_info *map_info;
 
 #ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
 	if ((ul_map_attr & BUFMODE_MASK) != RBUF) {
@@ -1121,10 +1163,15 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 
 	/* Add mapping to the page tables. */
 	if (DSP_SUCCEEDED(status)) {
-
-		status = (*p_proc_object->intf_fxns->pfn_brd_mem_map)
-		    (p_proc_object->hwmd_context, pa_align, va_align,
-		     size_align, ul_map_attr);
+		/* cache mapping information */
+		map_info = add_mapping_info(p_proc_object, pa_align, va_align,
+						size_align);
+		if (!map_info)
+			status = DSP_EMEMORY;
+		else
+			status = (*p_proc_object->intf_fxns->pfn_brd_mem_map)
+			    (p_proc_object->hwmd_context, pa_align, va_align,
+			     size_align, ul_map_attr, map_info->pages);
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Mapped address = MSB of VA | LSB of PA */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 1b5d977..d8cd9e3 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -505,7 +505,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 				    hio_mgr->intf_fxns->
 				    pfn_brd_mem_map(hio_mgr->hwmd_context,
 						    pa_curr, va_curr,
-						    page_size[i], map_attrs);
+						    page_size[i], map_attrs,
+						    NULL);
 				if (DSP_FAILED(status))
 					goto func_end;
 				pa_curr += page_size[i];
@@ -570,7 +571,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 				    hio_mgr->intf_fxns->
 				    pfn_brd_mem_map(hio_mgr->hwmd_context,
 						    pa_curr, va_curr,
-						    page_size[i], map_attrs);
+						    page_size[i], map_attrs,
+						    NULL);
 				dev_dbg(bridge,
 					"shm MMU PTE entry PA %x"
 					" VA %x DSP_VA %x Size %x\n",
@@ -639,7 +641,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 				     hio_mgr->ext_proc_info.ty_tlb[i].
 				     ul_gpp_phys,
 				     hio_mgr->ext_proc_info.ty_tlb[i].
-				     ul_dsp_virt, 0x100000, map_attrs);
+				     ul_dsp_virt, 0x100000, map_attrs, NULL);
 			}
 		}
 		if (DSP_FAILED(status))
@@ -658,7 +660,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		status = hio_mgr->intf_fxns->pfn_brd_mem_map
 		    (hio_mgr->hwmd_context, l4_peripheral_table[i].phys_addr,
 		     l4_peripheral_table[i].dsp_virt_addr, HW_PAGE_SIZE4KB,
-		     map_attrs);
+		     map_attrs, NULL);
 		if (DSP_FAILED(status))
 			goto func_end;
 		i++;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 0c6cf2f..720c0c0 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -107,7 +107,8 @@ static dsp_status bridge_brd_mem_write(struct wmd_dev_context *dev_context,
 				    u32 ul_num_bytes, u32 ulMemType);
 static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
-				  u32 ul_num_bytes, u32 ul_map_attr);
+				  u32 ul_num_bytes, u32 ul_map_attr,
+				  struct page **mapped_pages);
 static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
 				     u32 ulVirtAddr, u32 ul_num_bytes);
 static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
@@ -948,6 +949,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
+
 	status = cfg_get_host_resources((struct cfg_devnode *)
 					drv_get_first_dev_extension(),
 					&resources);
@@ -1276,7 +1278,8 @@ static dsp_status bridge_brd_mem_write(struct wmd_dev_context *hDevContext,
  */
 static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
-				  u32 ul_num_bytes, u32 ul_map_attr)
+				  u32 ul_num_bytes, u32 ul_map_attr,
+				  struct page **mapped_pages)
 {
 	u32 attrs;
 	dsp_status status = DSP_SOK;
@@ -1438,12 +1441,16 @@ static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
 					bad_page_dump(page_to_phys(mapped_page),
 						      mapped_page);
 				}
+
 				status = pte_set(dev_context->pt_attrs,
 						 page_to_phys(mapped_page), va,
 						 HW_PAGE_SIZE4KB, &hw_attrs);
 				if (DSP_FAILED(status))
 					break;
 
+				if (mapped_pages)
+					mapped_pages[pg_i] = mapped_page;
+
 				va += HW_PAGE_SIZE4KB;
 				ul_mpu_addr += HW_PAGE_SIZE4KB;
 			} else {
-- 
1.6.3.3

