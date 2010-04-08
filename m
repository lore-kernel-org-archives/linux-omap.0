From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or
 __vmalloc()
Date: Thu, 8 Apr 2010 18:43:42 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59031 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933912Ab0DHXnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 19:43:49 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 0306e1ff7c9160dbc5eb9fffcd789a40bea0debb Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Fri, 19 Mar 2010 16:43:26 -0600
Subject: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or __vmalloc()

This is needed because the file drivers/dsp/bridge/services/mem.c
is going to be deleted. The changes should be as follows:

mem_calloc(x, MEM_PAGED) ==> kzalloc(x, GFP_KERNEL)
mem_calloc(x, MEM_NONPAGED) ==> kzalloc(x, GFP_KERNEL)
mem_calloc(x, MEM_MEM_LARGEVIRTMEM) ==>
__vmalloc(x, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);

If running in atomic context, then the GFP_KERNEL argument
is changed to GFP_ATOMIC.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
 drivers/dsp/bridge/gen/gs.c                |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c              |   17 ++++-----
 drivers/dsp/bridge/pmgr/cod.c              |    4 +-
 drivers/dsp/bridge/pmgr/dbll.c             |   15 ++++----
 drivers/dsp/bridge/pmgr/dev.c              |    4 +-
 drivers/dsp/bridge/pmgr/dmm.c              |    5 ++-
 drivers/dsp/bridge/pmgr/wcd.c              |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c            |   18 +++++-----
 drivers/dsp/bridge/rmgr/disp.c             |    2 +-
 drivers/dsp/bridge/rmgr/drv.c              |   21 +++++------
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c             |   32 ++++++++--------
 drivers/dsp/bridge/rmgr/node.c             |   55 +++++++++++++---------------
 drivers/dsp/bridge/rmgr/proc.c             |    6 ++--
 drivers/dsp/bridge/rmgr/rmm.c              |   19 +++++-----
 drivers/dsp/bridge/services/regsup.c       |    4 +-
 drivers/dsp/bridge/wmd/chnl_sm.c           |   11 ++----
 drivers/dsp/bridge/wmd/io_sm.c             |    6 ++--
 drivers/dsp/bridge/wmd/msg_sm.c            |   21 +++++------
 drivers/dsp/bridge/wmd/tiomap3430.c        |    9 ++---
 drivers/dsp/bridge/wmd/ue_deh.c            |    4 +-
 22 files changed, 122 insertions(+), 139 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 087f69f..47f32dd 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -62,7 +62,7 @@ extern void *mem_alloc(IN u32 byte_size, IN enum mem_poolattrs type);
  */
 #define MEM_ALLOC_OBJECT(pObj, Obj, Signature)           \
 {                                                       \
-    pObj = mem_calloc(sizeof(Obj), MEM_NONPAGED);       \
+    pObj = kzalloc(sizeof(Obj), GFP_KERNEL);       \
     if (pObj) {                                         \
        pObj->dw_signature = Signature;                  \
     }                                                   \
diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 3b0f3a7..1a43fd5 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -38,7 +38,7 @@ void *gs_alloc(u32 size)
 {
        void *p;

-       p = mem_calloc(size, MEM_PAGED);
+       p = kzalloc(size, GFP_KERNEL);
        if (p == NULL)
                return NULL;
        cumsize += size;
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 7523361..5c093c9 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -287,8 +287,8 @@ dsp_status cmm_create(OUT struct cmm_object **ph_cmm_mgr,
                if (DSP_SUCCEEDED(status)) {
                        /* create node free list */
                        cmm_obj->node_free_list_head =
-                                       mem_calloc(sizeof(struct lst_list),
-                                                  MEM_NONPAGED);
+                                       kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                        if (cmm_obj->node_free_list_head == NULL)
                                status = DSP_EMEMORY;
                        else
@@ -609,9 +609,8 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                        /* return the actual segment identifier */
                        *pulSegId = (u32) slot_seg + 1;
                        /* create memory free list */
-                       psma->free_list_head = mem_calloc(sizeof(struct
-                                                                lst_list),
-                                                         MEM_NONPAGED);
+                       psma->free_list_head = kzalloc(sizeof(struct lst_list),
+                                                               GFP_KERNEL);
                        if (psma->free_list_head == NULL) {
                                status = DSP_EMEMORY;
                                goto func_end;
@@ -620,9 +619,8 @@ dsp_status cmm_register_gppsm_seg(struct cmm_object *hcmm_mgr,
                }
                if (DSP_SUCCEEDED(status)) {
                        /* create memory in-use list */
-                       psma->in_use_list_head = mem_calloc(sizeof(struct
-                                                                  lst_list),
-                                                           MEM_NONPAGED);
+                       psma->in_use_list_head = kzalloc(sizeof(struct
+                                                       lst_list), GFP_KERNEL);
                        if (psma->in_use_list_head == NULL) {
                                status = DSP_EMEMORY;
                                goto func_end;
@@ -795,8 +793,7 @@ static struct cmm_mnode *get_node(struct cmm_object *cmm_mgr_obj, u32 dw_pa,
        DBC_REQUIRE(ul_size != 0);
        /* Check cmm mgr's node freelist */
        if (LST_IS_EMPTY(cmm_mgr_obj->node_free_list_head)) {
-               pnode = (struct cmm_mnode *)mem_calloc(sizeof(struct cmm_mnode),
-                                                      MEM_PAGED);
+               pnode = kzalloc(sizeof(struct cmm_mnode), GFP_KERNEL);
        } else {
                /* surely a valid element */
                pnode = (struct cmm_mnode *)
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 548f1eb..5810563 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -234,7 +234,7 @@ dsp_status cod_create(OUT struct cod_manager **phMgr, char *pstrDummyFile,
        if (attrs != NULL)
                return DSP_ENOTIMPL;

-       mgr_new = mem_calloc(sizeof(struct cod_manager), MEM_NONPAGED);
+       mgr_new = kzalloc(sizeof(struct cod_manager), GFP_KERNEL);
        if (mgr_new == NULL)
                return DSP_EMEMORY;

@@ -566,7 +566,7 @@ dsp_status cod_open(struct cod_manager *hmgr, IN char *pszCoffPath,

        *pLib = NULL;

-       lib = mem_calloc(sizeof(struct cod_libraryobj), MEM_NONPAGED);
+       lib = kzalloc(sizeof(struct cod_libraryobj), GFP_KERNEL);
        if (lib == NULL)
                status = DSP_EMEMORY;

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 0e7c4a4..0bf96c7 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -631,8 +631,8 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
                        zl_lib->open_ref++;
                        zl_lib->target_obj = zl_target;
                        /* Keep a copy of the file name */
-                       zl_lib->file_name = mem_calloc(strlen(file) + 1,
-                                                      MEM_PAGED);
+                       zl_lib->file_name = kzalloc(strlen(file) + 1,
+                                                       GFP_KERNEL);
                        if (zl_lib->file_name == NULL) {
                                status = DSP_EMEMORY;
                        } else {
@@ -1136,8 +1136,7 @@ static struct dynload_symbol *dbll_add_to_symbol_table(struct dynamic_loader_sym
                }
        }
        /* Allocate string to copy symbol name */
-       symbol.name = (char *)mem_calloc(strlen((char *const)name) + 1,
-                                        MEM_PAGED);
+       symbol.name = kzalloc(strlen((char *const)name) + 1, GFP_KERNEL);
        if (symbol.name == NULL)
                return NULL;

@@ -1191,7 +1190,7 @@ static void *allocate(struct dynamic_loader_sym *this, unsigned memsize)
        lib = ldr_sym->lib;
        DBC_REQUIRE(MEM_IS_VALID_HANDLE(lib, DBLL_LIBSIGNATURE));

-       buf = mem_calloc(memsize, MEM_PAGED);
+       buf = kzalloc(memsize, GFP_KERNEL);

        return buf;
 }
@@ -1269,9 +1268,9 @@ static int dbll_rmm_alloc(struct dynamic_loader_allocate *this,
        DBC_REQUIRE(info->name);
        token_len = strlen((char *)(info->name)) + 1;

-       sz_sect_name = mem_calloc(token_len, MEM_PAGED);
-       sz_last_token = mem_calloc(token_len, MEM_PAGED);
-       sz_sec_last_token = mem_calloc(token_len, MEM_PAGED);
+       sz_sect_name = kzalloc(token_len, GFP_KERNEL);
+       sz_last_token = kzalloc(token_len, GFP_KERNEL);
+       sz_sec_last_token = kzalloc(token_len, GFP_KERNEL);

        if (sz_sect_name == NULL || sz_sec_last_token == NULL ||
            sz_last_token == NULL) {
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5bc16e9..196d108 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -247,8 +247,8 @@ dsp_status dev_create_device(OUT struct dev_object **phDevObject,
        }
        /* Create the Processor List */
        if (DSP_SUCCEEDED(status)) {
-               dev_obj->proc_list = mem_calloc(sizeof(struct lst_list),
-                                               MEM_NONPAGED);
+               dev_obj->proc_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                if (!(dev_obj->proc_list))
                        status = DSP_EFAIL;
                else
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index be84c1e..dd40e44 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -101,8 +101,9 @@ dsp_status dmm_create_tables(struct dmm_object *dmm_mgr, u32 addr, u32 size)
                dyn_mem_map_beg = addr;
                table_size = PG_ALIGN_HIGH(size, PG_SIZE4K) / PG_SIZE4K;
                /*  Create the free list */
-               virtual_mapping_table = (struct map_page *)mem_calloc
-                   (table_size * sizeof(struct map_page), MEM_LARGEVIRTMEM);
+               virtual_mapping_table = __vmalloc(table_size *
+                               sizeof(struct map_page), GFP_KERNEL |
+                               __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
                if (virtual_mapping_table == NULL)
                        status = DSP_EMEMORY;
                else {
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 15a05a6..1b9c76f 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -767,7 +767,7 @@ u32 procwrap_get_trace(union Trapped_Args *args, void *pr_ctxt)
        if (args->args_proc_gettrace.max_size > MAX_TRACEBUFLEN)
                return DSP_ESIZE;

-       pbuf = mem_calloc(args->args_proc_gettrace.max_size, MEM_NONPAGED);
+       pbuf = kzalloc(args->args_proc_gettrace.max_size, GFP_KERNEL);
        if (pbuf != NULL) {
                status = proc_get_trace(args->args_proc_gettrace.hprocessor,
                                        pbuf,
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index fd90c99..923f9dc 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -387,7 +387,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
        DBC_REQUIRE(pObjDef != NULL);
        DBC_REQUIRE(pObjUuid != NULL);

-       sz_uuid = (char *)mem_calloc(MAXUUIDLEN, MEM_PAGED);
+       sz_uuid = kzalloc(MAXUUIDLEN, GFP_KERNEL);
        if (!sz_uuid) {
                status = DSP_EMEMORY;
                goto func_end;
@@ -469,7 +469,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
        }

        /* Allocate zeroed buffer. */
-       psz_coff_buf = mem_calloc(ul_len + 4, MEM_PAGED);
+       psz_coff_buf = kzalloc(ul_len + 4, GFP_KERNEL);
 #ifdef _DB_TIOMAP
        if (strstr(sz_reg_data, "iva") == NULL) {
                /* Locate section by objectID and read its content. */
@@ -553,7 +553,7 @@ dsp_status dcd_get_objects(IN struct dcd_manager *hdcd_mgr,
        }

        /* Allocate zeroed buffer. */
-       psz_coff_buf = mem_calloc(ul_len + 4, MEM_PAGED);
+       psz_coff_buf = kzalloc(ul_len + 4, GFP_KERNEL);
 #ifdef _DB_TIOMAP
        if (strstr(pszCoffPath, "iva") == NULL) {
                /* Locate section by objectID and read its content. */
@@ -1055,7 +1055,7 @@ static dsp_status get_attrs_from_buf(char *psz_buf, u32 ul_buf_size,
                DBC_REQUIRE(token);
                token_len = strlen(token);
                pGenObj->obj_data.node_obj.pstr_create_phase_fxn =
-                   mem_calloc(token_len + 1, MEM_PAGED);
+                                       kzalloc(token_len + 1, GFP_KERNEL);
                strncpy(pGenObj->obj_data.node_obj.pstr_create_phase_fxn,
                        token, token_len);
                pGenObj->obj_data.node_obj.pstr_create_phase_fxn[token_len] =
@@ -1066,7 +1066,7 @@ static dsp_status get_attrs_from_buf(char *psz_buf, u32 ul_buf_size,
                DBC_REQUIRE(token);
                token_len = strlen(token);
                pGenObj->obj_data.node_obj.pstr_execute_phase_fxn =
-                   mem_calloc(token_len + 1, MEM_PAGED);
+                                       kzalloc(token_len + 1, GFP_KERNEL);
                strncpy(pGenObj->obj_data.node_obj.pstr_execute_phase_fxn,
                        token, token_len);
                pGenObj->obj_data.node_obj.pstr_execute_phase_fxn[token_len] =
@@ -1077,7 +1077,7 @@ static dsp_status get_attrs_from_buf(char *psz_buf, u32 ul_buf_size,
                DBC_REQUIRE(token);
                token_len = strlen(token);
                pGenObj->obj_data.node_obj.pstr_delete_phase_fxn =
-                   mem_calloc(token_len + 1, MEM_PAGED);
+                                       kzalloc(token_len + 1, GFP_KERNEL);
                strncpy(pGenObj->obj_data.node_obj.pstr_delete_phase_fxn,
                        token, token_len);
                pGenObj->obj_data.node_obj.pstr_delete_phase_fxn[token_len] =
@@ -1096,7 +1096,7 @@ static dsp_status get_attrs_from_buf(char *psz_buf, u32 ul_buf_size,
                if (token) {
                        token_len = strlen(token);
                        pGenObj->obj_data.node_obj.pstr_i_alg_name =
-                           mem_calloc(token_len + 1, MEM_PAGED);
+                                       kzalloc(token_len + 1, GFP_KERNEL);
                        strncpy(pGenObj->obj_data.node_obj.pstr_i_alg_name,
                                token, token_len);
                        pGenObj->obj_data.node_obj.pstr_i_alg_name[token_len] =
@@ -1320,7 +1320,7 @@ static dsp_status get_dep_lib_info(IN struct dcd_manager *hdcd_mgr,
        }

        /* Allocate a buffer for file name */
-       psz_file_name = mem_calloc(dw_data_size, MEM_PAGED);
+       psz_file_name = kzalloc(dw_data_size, GFP_KERNEL);
        if (psz_file_name == NULL) {
                status = DSP_EMEMORY;
        } else {
@@ -1349,7 +1349,7 @@ static dsp_status get_dep_lib_info(IN struct dcd_manager *hdcd_mgr,
                goto func_cont;

        /* Allocate zeroed buffer. */
-       psz_coff_buf = mem_calloc(ul_len + 4, MEM_PAGED);
+       psz_coff_buf = kzalloc(ul_len + 4, GFP_KERNEL);
        if (psz_coff_buf == NULL)
                status = DSP_EMEMORY;

diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 8a3b9d5..fa0ed46 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -164,7 +164,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
                /* Allocate buffer for commands, replies */
                disp_obj->ul_bufsize = pDispAttrs->ul_chnl_buf_size;
                disp_obj->ul_bufsize_rms = RMS_COMMANDBUFSIZE;
-               disp_obj->pbuf = mem_calloc(disp_obj->ul_bufsize, MEM_PAGED);
+               disp_obj->pbuf = kzalloc(disp_obj->ul_bufsize, GFP_KERNEL);
                if (disp_obj->pbuf == NULL)
                        status = DSP_EMEMORY;
        }
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 3ab2e3c..6070944 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -85,8 +85,7 @@ dsp_status drv_insert_node_res_element(bhandle hnode, bhandle hNodeRes,
        dsp_status status = DSP_SOK;
        struct node_res_object *temp_node_res = NULL;

-       *node_res_obj = (struct node_res_object *)mem_calloc
-           (1 * sizeof(struct node_res_object), MEM_PAGED);
+       *node_res_obj = kzalloc(sizeof(struct node_res_object), GFP_KERNEL);
        if (*node_res_obj == NULL)
                status = DSP_EHANDLE;

@@ -283,8 +282,7 @@ dsp_status drv_proc_insert_strm_res_element(bhandle hStreamHandle,
        dsp_status status = DSP_SOK;
        struct strm_res_object *temp_strm_res = NULL;

-       *pstrm_res = (struct strm_res_object *)
-           mem_calloc(1 * sizeof(struct strm_res_object), MEM_PAGED);
+       *pstrm_res = kzalloc(sizeof(struct strm_res_object), GFP_KERNEL);
        if (*pstrm_res == NULL)
                status = DSP_EHANDLE;

@@ -439,13 +437,12 @@ dsp_status drv_create(OUT struct drv_object **phDRVObject)
        MEM_ALLOC_OBJECT(pdrv_object, struct drv_object, SIGNATURE);
        if (pdrv_object) {
                /* Create and Initialize List of device objects */
-               pdrv_object->dev_list = mem_calloc(sizeof(struct lst_list),
-                                                  MEM_NONPAGED);
+               pdrv_object->dev_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                if (pdrv_object->dev_list) {
                        /* Create and Initialize List of device Extension */
                        pdrv_object->dev_node_string =
-                                       mem_calloc(sizeof(struct lst_list),
-                                                  MEM_NONPAGED);
+                               kzalloc(sizeof(struct lst_list), GFP_KERNEL);
                        if (!(pdrv_object->dev_node_string)) {
                                status = DSP_EFAIL;
                        } else {
@@ -755,7 +752,7 @@ dsp_status drv_request_resources(u32 dw_context, u32 *pDevNodeString)

        status = cfg_get_object((u32 *) &pdrv_object, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(status)) {
-               pszdev_node = mem_calloc(sizeof(struct drv_ext), MEM_NONPAGED);
+               pszdev_node = kzalloc(sizeof(struct drv_ext), GFP_KERNEL);
                if (pszdev_node) {
                        lst_init_elem(&pszdev_node->link);
                        strncpy(pszdev_node->sz_string,
@@ -863,7 +860,7 @@ static dsp_status request_bridge_resources(u32 dw_context, s32 bRequest)
                driver_ext = (struct drv_ext *)dw_context;
                /* Releasing resources by deleting the registry key */
                dw_buff_size = sizeof(struct cfg_hostres);
-               host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);
+               host_res = kzalloc(dw_buff_size, GFP_KERNEL);
                if (host_res != NULL) {
                        if (DSP_FAILED(reg_get_value(CURRENTCONFIG,
                                                     (u8 *) host_res,
@@ -929,7 +926,7 @@ static dsp_status request_bridge_resources(u32 dw_context, s32 bRequest)
                return status;
        }
        dw_buff_size = sizeof(struct cfg_hostres);
-       host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);
+       host_res = kzalloc(dw_buff_size, GFP_KERNEL);
        if (host_res != NULL) {
                /* num_mem_windows must not be more than CFG_MAXMEMREGISTERS */
                host_res->num_mem_windows = 2;
@@ -985,7 +982,7 @@ static dsp_status request_bridge_resources_dsp(u32 dw_context, s32 bRequest)

        dw_buff_size = sizeof(struct cfg_hostres);

-       host_res = mem_calloc(dw_buff_size, MEM_NONPAGED);
+       host_res = kzalloc(dw_buff_size, GFP_KERNEL);

        if (host_res != NULL) {
                if (DSP_FAILED(cfg_get_host_resources((struct cfg_devnode *)
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 20b6dcd..f53e02d 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -481,7 +481,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
                        return -EBUSY;
        }
 #endif
-       pr_ctxt = mem_calloc(sizeof(struct process_context), MEM_PAGED);
+       pr_ctxt = kzalloc(sizeof(struct process_context), GFP_KERNEL);
        if (pr_ctxt) {
                pr_ctxt->res_state = PROC_RES_ALLOCATED;
                spin_lock_init(&pr_ctxt->dmm_map_lock);
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index c23deda..924ac84 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -498,8 +498,8 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
                                                    &ul_len);
                if (DSP_SUCCEEDED(status)) {
                        psz_coff_buf =
-                           mem_calloc(ul_len * nldr_obj->us_dsp_mau_size,
-                                      MEM_PAGED);
+                               kzalloc(ul_len * nldr_obj->us_dsp_mau_size,
+                                                               GFP_KERNEL);
                        if (!psz_coff_buf)
                                status = DSP_EMEMORY;
                } else {
@@ -525,10 +525,10 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
        }
        /* Parse dynamic load memory segments */
        if (DSP_SUCCEEDED(status) && dload_segs > 0) {
-               rmm_segs = mem_calloc(sizeof(struct rmm_segment) * dload_segs,
-                                     MEM_PAGED);
+               rmm_segs = kzalloc(sizeof(struct rmm_segment) * dload_segs,
+                                                               GFP_KERNEL);
                nldr_obj->seg_table =
-                   mem_calloc(sizeof(u32) * dload_segs, MEM_PAGED);
+                               kzalloc(sizeof(u32) * dload_segs, GFP_KERNEL);
                if (rmm_segs == NULL || nldr_obj->seg_table == NULL) {
                        status = DSP_EMEMORY;
                } else {
@@ -583,8 +583,8 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
                if (DSP_SUCCEEDED(status) && nldr_obj->ovly_nodes > 0) {
                        /* Allocate table for overlay nodes */
                        nldr_obj->ovly_table =
-                           mem_calloc(sizeof(struct ovly_node) *
-                                      nldr_obj->ovly_nodes, MEM_PAGED);
+                                       kzalloc(sizeof(struct ovly_node) *
+                                       nldr_obj->ovly_nodes, GFP_KERNEL);
                        /* Put overlay nodes in the table */
                        nldr_obj->ovly_nid = 0;
                        status = dcd_get_objects(nldr_obj->hdcd_mgr, sz_zl_file,
@@ -1055,7 +1055,7 @@ static dsp_status add_ovly_node(struct dsp_uuid *uuid_obj,
                        len =
                            strlen(obj_def.obj_data.node_obj.ndb_props.ac_name);
                        node_name = obj_def.obj_data.node_obj.ndb_props.ac_name;
-                       pbuf = mem_calloc(len + 1, MEM_PAGED);
+                       pbuf = kzalloc(len + 1, GFP_KERNEL);
                        if (pbuf == NULL) {
                                status = DSP_EMEMORY;
                        } else {
@@ -1110,7 +1110,7 @@ static dsp_status add_ovly_sect(struct nldr_object *nldr_obj,

        if (!ovly_section) {
                /* New section */
-               new_sect = mem_calloc(sizeof(struct ovly_sect), MEM_PAGED);
+               new_sect = kzalloc(sizeof(struct ovly_sect), GFP_KERNEL);
                if (new_sect == NULL) {
                        status = DSP_EMEMORY;
                } else {
@@ -1281,7 +1281,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
        }
        root->lib = NULL;
        /* Allocate a buffer for library file name of size DBL_MAXPATHLENGTH */
-       psz_file_name = mem_calloc(DBLL_MAXPATHLENGTH, MEM_PAGED);
+       psz_file_name = kzalloc(DBLL_MAXPATHLENGTH, GFP_KERNEL);
        if (psz_file_name == NULL)
                status = DSP_EMEMORY;

@@ -1348,19 +1348,19 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
                /* nd_libs = #of dependent libraries */
                root->dep_libs = nd_libs - np_libs;
                if (nd_libs > 0) {
-                       dep_lib_uui_ds = mem_calloc(sizeof(struct dsp_uuid) *
-                                                   nd_libs, MEM_PAGED);
+                       dep_lib_uui_ds = kzalloc(sizeof(struct dsp_uuid) *
+                                                       nd_libs, GFP_KERNEL);
                        persistent_dep_libs =
-                           mem_calloc(sizeof(bool) * nd_libs, MEM_PAGED);
+                               kzalloc(sizeof(bool) * nd_libs, GFP_KERNEL);
                        if (!dep_lib_uui_ds || !persistent_dep_libs)
                                status = DSP_EMEMORY;

                        if (root->dep_libs > 0) {
                                /* Allocate arrays for dependent lib UUIDs,
                                 * lib nodes */
-                               root->dep_libs_tree = mem_calloc
-                                   (sizeof(struct lib_node) *
-                                    (root->dep_libs), MEM_PAGED);
+                               root->dep_libs_tree = kzalloc
+                                               (sizeof(struct lib_node) *
+                                               (root->dep_libs), GFP_KERNEL);
                                if (!(root->dep_libs_tree))
                                        status = DSP_EMEMORY;

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 32df890..fd2a284 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -486,9 +486,9 @@ func_cont:
                 *  dais socket nodes. */
                if (node_type != NODE_MESSAGE) {
                        num_streams = MAX_INPUTS(pnode) + MAX_OUTPUTS(pnode);
-                       pnode->stream_connect = mem_calloc(num_streams *
+                       pnode->stream_connect = kzalloc(num_streams *
                                        sizeof(struct dsp_streamconnect),
-                                       MEM_PAGED);
+                                       GFP_KERNEL);
                        if (num_streams > 0 && pnode->stream_connect == NULL)
                                status = DSP_EMEMORY;

@@ -496,19 +496,17 @@ func_cont:
                if (DSP_SUCCEEDED(status) && (node_type == NODE_TASK ||
                                              node_type == NODE_DAISSOCKET)) {
                        /* Allocate arrays for maintainig stream connections */
-                       pnode->inputs =
-                           mem_calloc(MAX_INPUTS(pnode) *
-                                      sizeof(struct stream_chnl), MEM_PAGED);
-                       pnode->outputs =
-                           mem_calloc(MAX_OUTPUTS(pnode) *
-                                      sizeof(struct stream_chnl), MEM_PAGED);
+                       pnode->inputs = kzalloc(MAX_INPUTS(pnode) *
+                                       sizeof(struct stream_chnl), GFP_KERNEL);
+                       pnode->outputs = kzalloc(MAX_OUTPUTS(pnode) *
+                                       sizeof(struct stream_chnl), GFP_KERNEL);
                        ptask_args = &(pnode->create_args.asa.task_arg_obj);
-                       ptask_args->strm_in_def =
-                           mem_calloc(MAX_INPUTS(pnode) *
-                                      sizeof(struct node_strmdef), MEM_PAGED);
-                       ptask_args->strm_out_def =
-                           mem_calloc(MAX_OUTPUTS(pnode) *
-                                      sizeof(struct node_strmdef), MEM_PAGED);
+                       ptask_args->strm_in_def = kzalloc(MAX_INPUTS(pnode) *
+                                               sizeof(struct node_strmdef),
+                                               GFP_KERNEL);
+                       ptask_args->strm_out_def = kzalloc(MAX_OUTPUTS(pnode) *
+                                               sizeof(struct node_strmdef),
+                                               GFP_KERNEL);
                        if ((MAX_INPUTS(pnode) > 0 && (pnode->inputs == NULL ||
                                                       ptask_args->strm_in_def
                                                       == NULL))
@@ -543,8 +541,8 @@ func_cont:
                        if ((pargs != NULL) && (pargs->cb_data > 0)) {
                                pmsg_args =
                                    &(pnode->create_args.asa.node_msg_args);
-                               pmsg_args->pdata =
-                                   mem_calloc(pargs->cb_data, MEM_PAGED);
+                               pmsg_args->pdata = kzalloc(pargs->cb_data,
+                                                               GFP_KERNEL);
                                if (pmsg_args->pdata == NULL) {
                                        status = DSP_EMEMORY;
                                } else {
@@ -961,10 +959,9 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
                        hNode2->inputs[uStream2].type = NODECONNECT;
                        hNode1->outputs[uStream1].dev_id = pipe_id;
                        hNode2->inputs[uStream2].dev_id = pipe_id;
-                       output->sz_device = mem_calloc(PIPENAMELEN + 1,
-                                                      MEM_PAGED);
-                       input->sz_device = mem_calloc(PIPENAMELEN + 1,
-                                                     MEM_PAGED);
+                       output->sz_device = kzalloc(PIPENAMELEN + 1,
+                                                       GFP_KERNEL);
+                       input->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
                        if (output->sz_device == NULL ||
                            input->sz_device == NULL) {
                                /* Undo the connection */
@@ -1030,7 +1027,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
                        status = DSP_ENOMORECONNECTIONS;
                        goto func_cont2;
                }
-               pstr_dev_name = mem_calloc(HOSTNAMELEN + 1, MEM_PAGED);
+               pstr_dev_name = kzalloc(HOSTNAMELEN + 1, GFP_KERNEL);
                if (pstr_dev_name != NULL)
                        goto func_cont2;

@@ -1084,12 +1081,12 @@ func_cont2:
                pstream->type = DEVICECONNECT;
                dw_length = strlen(dev_node_obj->pstr_dev_name);
                if (conn_param != NULL) {
-                       pstrm_def->sz_device = mem_calloc(dw_length + 1 + (u32)
-                                                         conn_param->cb_data,
-                                                         MEM_PAGED);
+                       pstrm_def->sz_device = kzalloc(dw_length + 1 +
+                                                       conn_param->cb_data,
+                                                       GFP_KERNEL);
                } else {
-                       pstrm_def->sz_device = mem_calloc(dw_length + 1,
-                                                         MEM_PAGED);
+                       pstrm_def->sz_device = kzalloc(dw_length + 1,
+                                                       GFP_KERNEL);
                }
                if (pstrm_def->sz_device == NULL) {
                        status = DSP_EMEMORY;
@@ -1323,8 +1320,8 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
        MEM_ALLOC_OBJECT(node_mgr_obj, struct node_mgr, NODEMGR_SIGNATURE);
        if (node_mgr_obj) {
                node_mgr_obj->hdev_obj = hdev_obj;
-               node_mgr_obj->node_list = mem_calloc(sizeof(struct lst_list),
-                                                    MEM_NONPAGED);
+               node_mgr_obj->node_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                node_mgr_obj->pipe_map = gb_create(MAXPIPES);
                node_mgr_obj->pipe_done_map = gb_create(MAXPIPES);
                if (node_mgr_obj->node_list == NULL
@@ -2940,7 +2937,7 @@ static dsp_status get_node_props(struct dcd_manager *hdcd_mgr,
                        DBC_REQUIRE(pndb_props->ac_name);
                        len = strlen(pndb_props->ac_name);
                        DBC_ASSERT(len < MAXDEVNAMELEN);
-                       hnode->pstr_dev_name = mem_calloc(len + 1, MEM_PAGED);
+                       hnode->pstr_dev_name = kzalloc(len + 1, GFP_KERNEL);
                        if (hnode->pstr_dev_name == NULL) {
                                status = DSP_EMEMORY;
                        } else {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f6c67cf..975cd6e 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -865,7 +865,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
        /*Prepend "PROC_ID=<nproc_id>"to envp array for target. */
        envp_elems = get_envp_count((char **)user_envp);
        cnew_envp = (envp_elems ? (envp_elems + 1) : (envp_elems + 2));
-       new_envp = mem_calloc(cnew_envp * sizeof(char **), MEM_PAGED);
+       new_envp = kzalloc(cnew_envp * sizeof(char **), GFP_KERNEL);
        if (new_envp) {
                status = snprintf(sz_proc_id, MAXPROCIDLEN, PROC_ENVPROCID,
                                  nproc_id);
@@ -930,8 +930,8 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
                                           NULL);
                                /* Allocate memory for pszLastCoff */
                                p_proc_object->psz_last_coff =
-                                   mem_calloc((strlen((char *)user_args[0]) +
-                                               1), MEM_PAGED);
+                                               kzalloc((strlen(user_args[0]) +
+                                               1), GFP_KERNEL);
                                /* If memory allocated, save COFF file name */
                                if (p_proc_object->psz_last_coff) {
                                        strncpy(p_proc_object->psz_last_coff,
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index d5a8bfb..861ab15 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -145,7 +145,7 @@ dsp_status rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
        }
        if (DSP_SUCCEEDED(status)) {
                /* No overlap - allocate list element for new section. */
-               new_sect = mem_calloc(sizeof(struct rmm_ovly_sect), MEM_PAGED);
+               new_sect = kzalloc(sizeof(struct rmm_ovly_sect), GFP_KERNEL);
                if (new_sect == NULL) {
                        status = DSP_EMEMORY;
                } else {
@@ -198,24 +198,23 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
                goto func_cont;

        /* Allocate the memory for freelist from host's memory */
-       target->free_list = mem_calloc(num_segs * sizeof(struct rmm_header *),
-                                      MEM_PAGED);
+       target->free_list = kzalloc(num_segs * sizeof(struct rmm_header *),
+                                                       GFP_KERNEL);
        if (target->free_list == NULL) {
                status = DSP_EMEMORY;
        } else {
                /* Allocate headers for each element on the free list */
                for (i = 0; i < (s32) num_segs; i++) {
                        target->free_list[i] =
-                           mem_calloc(sizeof(struct rmm_header), MEM_PAGED);
+                               kzalloc(sizeof(struct rmm_header), GFP_KERNEL);
                        if (target->free_list[i] == NULL) {
                                status = DSP_EMEMORY;
                                break;
                        }
                }
                /* Allocate memory for initial segment table */
-               target->seg_tab = mem_calloc(num_segs *
-                                            sizeof(struct rmm_segment),
-                                            MEM_PAGED);
+               target->seg_tab = kzalloc(num_segs * sizeof(struct rmm_segment),
+                                                               GFP_KERNEL);
                if (target->seg_tab == NULL) {
                        status = DSP_EMEMORY;
                } else {
@@ -236,8 +235,8 @@ dsp_status rmm_create(struct rmm_target_obj **target_obj,
 func_cont:
        /* Initialize overlay memory list */
        if (DSP_SUCCEEDED(status)) {
-               target->ovly_list = mem_calloc(sizeof(struct lst_list),
-                                              MEM_NONPAGED);
+               target->ovly_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                if (target->ovly_list == NULL)
                        status = DSP_EMEMORY;
                else
@@ -495,7 +494,7 @@ static bool free_block(struct rmm_target_obj *target, u32 segid, u32 addr,
        bool ret = true;

        /* Create a memory header to hold the newly free'd block. */
-       rhead = mem_calloc(sizeof(struct rmm_header), MEM_PAGED);
+       rhead = kzalloc(sizeof(struct rmm_header), GFP_KERNEL);
        if (rhead == NULL) {
                ret = false;
        } else {
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 275d91c..542ce62 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -145,8 +145,8 @@ dsp_status regsup_set_value(char *valName, void *pbuf, u32 data_size)
        /*  See if we found a match or if this is a new entry */
        if (!rv) {
                /*  No match, need to make a new entry */
-               struct reg_value *new = mem_calloc(sizeof(struct reg_value),
-                                                  MEM_NONPAGED);
+               struct reg_value *new = kzalloc(sizeof(struct reg_value),
+                                                       GFP_KERNEL);

                strncat(new->name, valName, MAXREGPATHLENGTH - 1);
                new->pdata = mem_alloc(data_size, MEM_NONPAGED);
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index a2f98e9..b6a1a22 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -413,9 +413,8 @@ dsp_status bridge_chnl_create(OUT struct chnl_mgr **phChnlMgr,
                DBC_ASSERT(pMgrAttrs->max_channels == CHNL_MAXCHANNELS);
                max_channels = CHNL_MAXCHANNELS + CHNL_MAXCHANNELS * CHNL_PCPY;
                /* Create array of channels */
-               chnl_mgr_obj->ap_channel =
-                   mem_calloc(sizeof(struct chnl_object *) * max_channels,
-                              MEM_NONPAGED);
+               chnl_mgr_obj->ap_channel = kzalloc(sizeof(struct chnl_object *)
+                                               * max_channels, GFP_KERNEL);
                if (chnl_mgr_obj->ap_channel) {
                        /* Initialize chnl_mgr object */
                        chnl_mgr_obj->dw_type = CHNL_TYPESM;
@@ -950,7 +949,7 @@ static struct lst_list *create_chirp_list(u32 uChirps)
        struct chnl_irp *chnl_packet_obj;
        u32 i;

-       chirp_list = mem_calloc(sizeof(struct lst_list), MEM_NONPAGED);
+       chirp_list = kzalloc(sizeof(struct lst_list), GFP_KERNEL);

        if (chirp_list) {
                INIT_LIST_HEAD(&chirp_list->head);
@@ -994,9 +993,7 @@ static struct chnl_irp *make_new_chirp(void)
 {
        struct chnl_irp *chnl_packet_obj;

-       chnl_packet_obj =
-           (struct chnl_irp *)mem_calloc(sizeof(struct chnl_irp),
-                                         MEM_NONPAGED);
+       chnl_packet_obj = kzalloc(sizeof(struct chnl_irp), GFP_KERNEL);
        if (chnl_packet_obj != NULL) {
                /* lst_init_elem only resets the list's member values. */
                lst_init_elem(&chnl_packet_obj->link);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 545cca0..7516e7e 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1894,7 +1894,7 @@ static dsp_status pack_trace_buffer(char *lpBuf, u32 bytes, u32 ul_num_words)
        char this_char;

        /* Tmp workspace, 1 KB longer than input buf */
-       lp_tmp_buf = mem_calloc((bytes + ul_num_words), MEM_PAGED);
+       lp_tmp_buf = kzalloc((bytes + ul_num_words), GFP_ATOMIC);
        if (lp_tmp_buf == NULL)
                status = DSP_EMEMORY;

@@ -1988,8 +1988,8 @@ dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
        }

        if (DSP_SUCCEEDED(status)) {
-               psz_buf = mem_calloc(max_size, MEM_NONPAGED);
-               lpsz_buf = mem_calloc(ul_num_bytes * 2, MEM_NONPAGED);
+               psz_buf = kzalloc(max_size, GFP_ATOMIC);
+               lpsz_buf = kzalloc(ul_num_bytes * 2, GFP_ATOMIC);
                if (psz_buf != NULL) {
                        /* Read bytes from the DSP trace buffer... */
                        status = (*intf_fxns->pfn_brd_read) (hwmd_context,
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index dae6e67..b055e98 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -78,15 +78,15 @@ dsp_status bridge_msg_create(OUT struct msg_mgr **phMsgMgr,
                msg_mgr_obj->on_exit = msgCallback;
                msg_mgr_obj->hio_mgr = hio_mgr;
                /* List of MSG_QUEUEs */
-               msg_mgr_obj->queue_list = mem_calloc(sizeof(struct lst_list),
-                                                    MEM_NONPAGED);
+               msg_mgr_obj->queue_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                /*  Queues of message frames for messages to the DSP. Message
                 * frames will only be added to the free queue when a
                 * msg_queue object is created. */
-               msg_mgr_obj->msg_free_list = mem_calloc(sizeof(struct lst_list),
-                                                       MEM_NONPAGED);
-               msg_mgr_obj->msg_used_list = mem_calloc(sizeof(struct lst_list),
-                                                       MEM_NONPAGED);
+               msg_mgr_obj->msg_free_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
+               msg_mgr_obj->msg_used_list = kzalloc(sizeof(struct lst_list),
+                                                       GFP_KERNEL);
                if (msg_mgr_obj->queue_list == NULL ||
                    msg_mgr_obj->msg_free_list == NULL ||
                    msg_mgr_obj->msg_used_list == NULL) {
@@ -152,10 +152,8 @@ dsp_status bridge_msg_create_queue(struct msg_mgr *hmsg_mgr,
        msg_q->arg = arg;       /* Node handle */
        msg_q->msgq_id = msgq_id;       /* Node env (not valid yet) */
        /* Queues of Message frames for messages from the DSP */
-       msg_q->msg_free_list =
-           mem_calloc(sizeof(struct lst_list), MEM_NONPAGED);
-       msg_q->msg_used_list =
-           mem_calloc(sizeof(struct lst_list), MEM_NONPAGED);
+       msg_q->msg_free_list = kzalloc(sizeof(struct lst_list), GFP_KERNEL);
+       msg_q->msg_used_list = kzalloc(sizeof(struct lst_list), GFP_KERNEL);
        if (msg_q->msg_free_list == NULL || msg_q->msg_used_list == NULL)
                status = DSP_EMEMORY;
        else {
@@ -568,8 +566,7 @@ static dsp_status add_new_msg(struct lst_list *msgList)
        struct msg_frame *pmsg;
        dsp_status status = DSP_SOK;

-       pmsg = (struct msg_frame *)mem_calloc(sizeof(struct msg_frame),
-                                             MEM_PAGED);
+       pmsg = kzalloc(sizeof(struct msg_frame), GFP_ATOMIC);
        if (pmsg != NULL) {
                lst_init_elem((struct list_head *)pmsg);
                lst_put_tail(msgList, (struct list_head *)pmsg);
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 356e16e..a3f2bdc 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -896,7 +896,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,

        /* Allocate and initialize a data structure to contain the mini driver
         *  state, which becomes the context for later calls into this WMD. */
-       dev_context = mem_calloc(sizeof(struct wmd_dev_context), MEM_NONPAGED);
+       dev_context = kzalloc(sizeof(struct wmd_dev_context), GFP_KERNEL);
        if (!dev_context) {
                status = DSP_EMEMORY;
                goto func_end;
@@ -930,7 +930,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
        if (!dev_context->dw_dsp_base_addr)
                status = DSP_EFAIL;

-       pt_attrs = mem_calloc(sizeof(struct pg_table_attrs), MEM_NONPAGED);
+       pt_attrs = kzalloc(sizeof(struct pg_table_attrs), GFP_KERNEL);
        if (pt_attrs != NULL) {
                /* Assuming that we use only DSP's memory map
                 * until 0x4000:0000 , we would need only 1024
@@ -993,9 +993,8 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
                        memset((u8 *) pt_attrs->l2_base_va, 0x00,
                               pt_attrs->l2_size);

-               pt_attrs->pg_info = mem_calloc(pt_attrs->l2_num_pages *
-                                              sizeof(struct page_info),
-                                              MEM_NONPAGED);
+               pt_attrs->pg_info = kzalloc(pt_attrs->l2_num_pages *
+                                       sizeof(struct page_info), GFP_KERNEL);
                dev_dbg(bridge,
                        "L1 pa %x, va %x, size %x\n L2 pa %x, va "
                        "%x, size %x\n", pt_attrs->l1_base_pa,
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 75a62b0..6c1b318 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -239,8 +239,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
                        printk(KERN_INFO
                               "bridge_deh_notify: DSP_MMUFAULT, fault "
                               "address = 0x%x\n", (unsigned int)fault_addr);
-                       dummy_va_addr =
-                           (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+                       dummy_va_addr = (u32) kzalloc(sizeof(char) * 0x1000,
+                                                               GFP_ATOMIC);
                        mem_physical =
                            VIRT_TO_PHYS(PG_ALIGN_LOW
                                         ((u32) dummy_va_addr, PG_SIZE4K));
--
1.7.0.3

