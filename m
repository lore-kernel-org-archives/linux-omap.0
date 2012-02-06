From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 1/4] staging: tidspbridge: remove DBC_ENSURE and DBC_REQUIRED
Date: Tue,  7 Feb 2012 00:39:34 +0100
Message-ID: <0fac3485821ac47601ac9b840b93211a4498d069.1328563908.git.vjaquez@igalia.com>
References: <cover.1328563908.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:51604 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2BFXkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 18:40:01 -0500
In-Reply-To: <cover.1328563908.git.vjaquez@igalia.com>
In-Reply-To: <cover.1328563908.git.vjaquez@igalia.com>
References: <cover.1328563908.git.vjaquez@igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>

The kernel does not use a "Design by Contract" approach, and it is only
activated in the module if CONFIG_TIDSPBRDIGE_DEBUG is enabled, so they=
 are
executed rarely. It is better to remove them: less code to maintain.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/core/chnl_sm.c         |   19 +---
 drivers/staging/tidspbridge/core/tiomap3430.c      |    3 -
 drivers/staging/tidspbridge/gen/uuidutil.c         |    4 -
 .../staging/tidspbridge/include/dspbridge/dbc.h    |    7 -
 drivers/staging/tidspbridge/pmgr/chnl.c            |   16 ---
 drivers/staging/tidspbridge/pmgr/cmm.c             |   59 ----------
 drivers/staging/tidspbridge/pmgr/cod.c             |   71 -----------
 drivers/staging/tidspbridge/pmgr/dbll.c            |  108 +-----------=
------
 drivers/staging/tidspbridge/pmgr/dev.c             |  123 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dmm.c             |   11 --
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    4 -
 drivers/staging/tidspbridge/pmgr/io.c              |   14 ---
 drivers/staging/tidspbridge/pmgr/msg.c             |   14 ---
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |   80 ------------=
-
 drivers/staging/tidspbridge/rmgr/disp.c            |   38 ------
 drivers/staging/tidspbridge/rmgr/drv.c             |   38 ------
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    1 -
 drivers/staging/tidspbridge/rmgr/dspdrv.c          |    2 -
 drivers/staging/tidspbridge/rmgr/mgr.c             |   31 -----
 drivers/staging/tidspbridge/rmgr/nldr.c            |   47 --------
 drivers/staging/tidspbridge/rmgr/node.c            |   84 ------------=
-
 drivers/staging/tidspbridge/rmgr/proc.c            |   73 ------------
 drivers/staging/tidspbridge/rmgr/rmm.c             |   30 -----
 drivers/staging/tidspbridge/rmgr/strm.c            |   72 +-----------
 24 files changed, 3 insertions(+), 946 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/chnl_sm.c b/drivers/stagi=
ng/tidspbridge/core/chnl_sm.c
index 6d66e7d..91daf25 100644
--- a/drivers/staging/tidspbridge/core/chnl_sm.c
+++ b/drivers/staging/tidspbridge/core/chnl_sm.c
@@ -358,13 +358,6 @@ int bridge_chnl_create(struct chnl_mgr **channel_m=
gr,
 	struct chnl_mgr *chnl_mgr_obj =3D NULL;
 	u8 max_channels;
=20
-	/* Check DBC requirements: */
-	DBC_REQUIRE(channel_mgr !=3D NULL);
-	DBC_REQUIRE(mgr_attrts !=3D NULL);
-	DBC_REQUIRE(mgr_attrts->max_channels > 0);
-	DBC_REQUIRE(mgr_attrts->max_channels <=3D CHNL_MAXCHANNELS);
-	DBC_REQUIRE(mgr_attrts->word_size !=3D 0);
-
 	/* Allocate channel manager object */
 	chnl_mgr_obj =3D kzalloc(sizeof(struct chnl_mgr), GFP_KERNEL);
 	if (chnl_mgr_obj) {
@@ -491,7 +484,6 @@ int bridge_chnl_flush_io(struct chnl_object *chnl_o=
bj, u32 timeout)
 			pchnl->state &=3D ~CHNL_STATECANCEL;
 		}
 	}
-	DBC_ENSURE(status || list_empty(&pchnl->io_requests));
 	return status;
 }
=20
@@ -705,8 +697,6 @@ int bridge_chnl_idle(struct chnl_object *chnl_obj, =
u32 timeout,
 	struct chnl_mgr *chnl_mgr_obj;
 	int status =3D 0;
=20
-	DBC_REQUIRE(chnl_obj);
-
 	chnl_mode =3D chnl_obj->chnl_mode;
 	chnl_mgr_obj =3D chnl_obj->chnl_mgr_obj;
=20
@@ -736,10 +726,7 @@ int bridge_chnl_open(struct chnl_object **chnl,
 	struct chnl_mgr *chnl_mgr_obj =3D hchnl_mgr;
 	struct chnl_object *pchnl =3D NULL;
 	struct sync_object *sync_event =3D NULL;
-	/* Ensure DBC requirements: */
-	DBC_REQUIRE(chnl !=3D NULL);
-	DBC_REQUIRE(pattrs !=3D NULL);
-	DBC_REQUIRE(hchnl_mgr !=3D NULL);
+
 	*chnl =3D NULL;
=20
 	/* Validate Args: */
@@ -906,8 +893,6 @@ static void free_chirp_list(struct list_head *chirp=
_list)
 {
 	struct chnl_irp *chirp, *tmp;
=20
-	DBC_REQUIRE(chirp_list !=3D NULL);
-
 	list_for_each_entry_safe(chirp, tmp, chirp_list, link) {
 		list_del(&chirp->link);
 		kfree(chirp);
@@ -924,8 +909,6 @@ static int search_free_channel(struct chnl_mgr *chn=
l_mgr_obj,
 	int status =3D -ENOSR;
 	u32 i;
=20
-	DBC_REQUIRE(chnl_mgr_obj);
-
 	for (i =3D 0; i < chnl_mgr_obj->max_channels; i++) {
 		if (chnl_mgr_obj->channels[i] =3D=3D NULL) {
 			status =3D 0;
diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/st=
aging/tidspbridge/core/tiomap3430.c
index e1c4492a..212cbc9 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -256,9 +256,6 @@ static void bad_page_dump(u32 pa, struct page *pg)
 void bridge_drv_entry(struct bridge_drv_interface **drv_intf,
 		   const char *driver_file_name)
 {
-
-	DBC_REQUIRE(driver_file_name !=3D NULL);
-
 	if (strcmp(driver_file_name, "UMA") =3D=3D 0)
 		*drv_intf =3D &drv_interface_fxns;
 	else
diff --git a/drivers/staging/tidspbridge/gen/uuidutil.c b/drivers/stagi=
ng/tidspbridge/gen/uuidutil.c
index ff6ebad..5797fb5 100644
--- a/drivers/staging/tidspbridge/gen/uuidutil.c
+++ b/drivers/staging/tidspbridge/gen/uuidutil.c
@@ -41,8 +41,6 @@ void uuid_uuid_to_string(struct dsp_uuid *uuid_obj, c=
har *sz_uuid,
 {
 	s32 i;			/* return result from snprintf. */
=20
-	DBC_REQUIRE(uuid_obj && sz_uuid);
-
 	i =3D snprintf(sz_uuid, size,
 		     "%.8X_%.4X_%.4X_%.2X%.2X_%.2X%.2X%.2X%.2X%.2X%.2X",
 		     uuid_obj->data1, uuid_obj->data2, uuid_obj->data3,
@@ -50,8 +48,6 @@ void uuid_uuid_to_string(struct dsp_uuid *uuid_obj, c=
har *sz_uuid,
 		     uuid_obj->data6[0], uuid_obj->data6[1],
 		     uuid_obj->data6[2], uuid_obj->data6[3],
 		     uuid_obj->data6[4], uuid_obj->data6[5]);
-
-	DBC_ENSURE(i !=3D -1);
 }
=20
 static s32 uuid_hex_to_bin(char *buf, s32 len)
diff --git a/drivers/staging/tidspbridge/include/dspbridge/dbc.h b/driv=
ers/staging/tidspbridge/include/dspbridge/dbc.h
index 463760f..dc88f34 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dbc.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dbc.h
@@ -32,15 +32,8 @@
     if (!(exp)) \
 	pr_err("%s, line %d: Assertion (" #exp ") failed.\n", \
 	__FILE__, __LINE__)
-#define DBC_REQUIRE DBC_ASSERT	/* Function Precondition. */
-#define DBC_ENSURE  DBC_ASSERT	/* Function Postcondition. */
-
 #else
-
 #define DBC_ASSERT(exp) {}
-#define DBC_REQUIRE(exp) {}
-#define DBC_ENSURE(exp) {}
-
 #endif /* DEBUG */
=20
 #endif /* DBC_ */
diff --git a/drivers/staging/tidspbridge/pmgr/chnl.c b/drivers/staging/=
tidspbridge/pmgr/chnl.c
index 245de82..61ee0f0 100644
--- a/drivers/staging/tidspbridge/pmgr/chnl.c
+++ b/drivers/staging/tidspbridge/pmgr/chnl.c
@@ -58,10 +58,6 @@ int chnl_create(struct chnl_mgr **channel_mgr,
 	struct chnl_mgr *hchnl_mgr;
 	struct chnl_mgr_ *chnl_mgr_obj =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(channel_mgr !=3D NULL);
-	DBC_REQUIRE(mgr_attrts !=3D NULL);
-
 	*channel_mgr =3D NULL;
=20
 	/* Validate args: */
@@ -99,8 +95,6 @@ int chnl_create(struct chnl_mgr **channel_mgr,
 		}
 	}
=20
-	DBC_ENSURE(status || chnl_mgr_obj);
-
 	return status;
 }
=20
@@ -115,8 +109,6 @@ int chnl_destroy(struct chnl_mgr *hchnl_mgr)
 	struct bridge_drv_interface *intf_fxns;
 	int status;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (chnl_mgr_obj) {
 		intf_fxns =3D chnl_mgr_obj->intf_fxns;
 		/* Let Bridge channel module destroy the chnl_mgr: */
@@ -135,11 +127,7 @@ int chnl_destroy(struct chnl_mgr *hchnl_mgr)
  */
 void chnl_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -151,12 +139,8 @@ bool chnl_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
diff --git a/drivers/staging/tidspbridge/pmgr/cmm.c b/drivers/staging/t=
idspbridge/pmgr/cmm.c
index e6b2c89..2eeb5370 100644
--- a/drivers/staging/tidspbridge/pmgr/cmm.c
+++ b/drivers/staging/tidspbridge/pmgr/cmm.c
@@ -244,9 +244,6 @@ int cmm_create(struct cmm_object **ph_cmm_mgr,
 	struct cmm_object *cmm_obj =3D NULL;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(ph_cmm_mgr !=3D NULL);
-
 	*ph_cmm_mgr =3D NULL;
 	/* create, zero, and tag a cmm mgr object */
 	cmm_obj =3D kzalloc(sizeof(struct cmm_object), GFP_KERNEL);
@@ -283,7 +280,6 @@ int cmm_destroy(struct cmm_object *hcmm_mgr, bool f=
orce)
 	s32 slot_seg;
 	struct cmm_mnode *node, *tmp;
=20
-	DBC_REQUIRE(refs > 0);
 	if (!hcmm_mgr) {
 		status =3D -EFAULT;
 		return status;
@@ -333,8 +329,6 @@ int cmm_destroy(struct cmm_object *hcmm_mgr, bool f=
orce)
  */
 void cmm_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
 }
=20
@@ -351,9 +345,6 @@ int cmm_free_buf(struct cmm_object *hcmm_mgr, void =
*buf_pa, u32 ul_seg_id)
 	struct cmm_allocator *allocator;
 	struct cmm_attrs *pattrs;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(buf_pa !=3D NULL);
-
 	if (ul_seg_id =3D=3D 0) {
 		pattrs =3D &cmm_dfltalctattrs;
 		ul_seg_id =3D pattrs->seg_id;
@@ -392,8 +383,6 @@ int cmm_get_handle(void *hprocessor, struct cmm_obj=
ect ** ph_cmm_mgr)
 	int status =3D 0;
 	struct dev_object *hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(ph_cmm_mgr !=3D NULL);
 	if (hprocessor !=3D NULL)
 		status =3D proc_get_dev_object(hprocessor, &hdev_obj);
 	else
@@ -419,8 +408,6 @@ int cmm_get_info(struct cmm_object *hcmm_mgr,
 	struct cmm_allocator *altr;
 	struct cmm_mnode *curr;
=20
-	DBC_REQUIRE(cmm_info_obj !=3D NULL);
-
 	if (!hcmm_mgr) {
 		status =3D -EFAULT;
 		return status;
@@ -472,12 +459,9 @@ bool cmm_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -499,13 +483,6 @@ int cmm_register_gppsm_seg(struct cmm_object *hcmm=
_mgr,
 	struct cmm_mnode *new_node;
 	s32 slot_seg;
=20
-	DBC_REQUIRE(ul_size > 0);
-	DBC_REQUIRE(sgmt_id !=3D NULL);
-	DBC_REQUIRE(dw_gpp_base_pa !=3D 0);
-	DBC_REQUIRE(gpp_base_va !=3D 0);
-	DBC_REQUIRE((c_factor <=3D CMM_ADDTODSPPA) &&
-			(c_factor >=3D CMM_SUBFROMDSPPA));
-
 	dev_dbg(bridge, "%s: dw_gpp_base_pa %x ul_size %x dsp_addr_offset %x =
"
 			"dw_dsp_base %x ul_dsp_size %x gpp_base_va %x\n",
 			__func__, dw_gpp_base_pa, ul_size, dsp_addr_offset,
@@ -589,7 +566,6 @@ int cmm_un_register_gppsm_seg(struct cmm_object *hc=
mm_mgr,
 	struct cmm_allocator *psma;
 	u32 ul_id =3D ul_seg_id;
=20
-	DBC_REQUIRE(ul_seg_id > 0);
 	if (!hcmm_mgr)
 		return -EFAULT;
=20
@@ -635,8 +611,6 @@ static void un_register_gppsm_seg(struct cmm_alloca=
tor *psma)
 {
 	struct cmm_mnode *curr, *tmp;
=20
-	DBC_REQUIRE(psma !=3D NULL);
-
 	/* free nodes on free list */
 	list_for_each_entry_safe(curr, tmp, &psma->free_list, link) {
 		list_del(&curr->link);
@@ -664,7 +638,6 @@ static void un_register_gppsm_seg(struct cmm_alloca=
tor *psma)
 static s32 get_slot(struct cmm_object *cmm_mgr_obj)
 {
 	s32 slot_seg =3D -1;	/* neg on failure */
-	DBC_REQUIRE(cmm_mgr_obj !=3D NULL);
 	/* get first available slot in cmm mgr SMSegTab[] */
 	for (slot_seg =3D 0; slot_seg < CMM_MAXGPPSEGS; slot_seg++) {
 		if (cmm_mgr_obj->pa_gppsm_seg_tab[slot_seg] =3D=3D NULL)
@@ -687,11 +660,6 @@ static struct cmm_mnode *get_node(struct cmm_objec=
t *cmm_mgr_obj, u32 dw_pa,
 {
 	struct cmm_mnode *pnode;
=20
-	DBC_REQUIRE(cmm_mgr_obj !=3D NULL);
-	DBC_REQUIRE(dw_pa !=3D 0);
-	DBC_REQUIRE(dw_va !=3D 0);
-	DBC_REQUIRE(ul_size !=3D 0);
-
 	/* Check cmm mgr's node freelist */
 	if (list_empty(&cmm_mgr_obj->node_free_list)) {
 		pnode =3D kzalloc(sizeof(struct cmm_mnode), GFP_KERNEL);
@@ -719,7 +687,6 @@ static struct cmm_mnode *get_node(struct cmm_object=
 *cmm_mgr_obj, u32 dw_pa,
  */
 static void delete_node(struct cmm_object *cmm_mgr_obj, struct cmm_mno=
de *pnode)
 {
-	DBC_REQUIRE(pnode !=3D NULL);
 	list_add_tail(&pnode->link, &cmm_mgr_obj->node_free_list);
 }
=20
@@ -794,9 +761,6 @@ static void add_to_free_list(struct cmm_allocator *=
allocator,
 static struct cmm_allocator *get_allocator(struct cmm_object *cmm_mgr_=
obj,
 					   u32 ul_seg_id)
 {
-	DBC_REQUIRE(cmm_mgr_obj !=3D NULL);
-	DBC_REQUIRE((ul_seg_id > 0) && (ul_seg_id <=3D CMM_MAXGPPSEGS));
-
 	return cmm_mgr_obj->pa_gppsm_seg_tab[ul_seg_id - 1];
 }
=20
@@ -818,10 +782,6 @@ int cmm_xlator_create(struct cmm_xlatorobject **xl=
ator,
 	struct cmm_xlator *xlator_object =3D NULL;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(xlator !=3D NULL);
-	DBC_REQUIRE(hcmm_mgr !=3D NULL);
-
 	*xlator =3D NULL;
 	if (xlator_attrs =3D=3D NULL)
 		xlator_attrs =3D &cmm_dfltxlatorattrs;	/* set defaults */
@@ -851,13 +811,6 @@ void *cmm_xlator_alloc_buf(struct cmm_xlatorobject=
 *xlator, void *va_buf,
 	void *tmp_va_buff;
 	struct cmm_attrs attrs;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(xlator !=3D NULL);
-	DBC_REQUIRE(xlator_obj->cmm_mgr !=3D NULL);
-	DBC_REQUIRE(va_buf !=3D NULL);
-	DBC_REQUIRE(pa_size > 0);
-	DBC_REQUIRE(xlator_obj->seg_id > 0);
-
 	if (xlator_obj) {
 		attrs.seg_id =3D xlator_obj->seg_id;
 		__raw_writel(0, va_buf);
@@ -887,10 +840,6 @@ int cmm_xlator_free_buf(struct cmm_xlatorobject *x=
lator, void *buf_va)
 	int status =3D -EPERM;
 	void *buf_pa =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(buf_va !=3D NULL);
-	DBC_REQUIRE(xlator_obj->seg_id > 0);
-
 	if (xlator_obj) {
 		/* convert Va to Pa so we can free it. */
 		buf_pa =3D cmm_xlator_translate(xlator, buf_va, CMM_VA2PA);
@@ -918,10 +867,6 @@ int cmm_xlator_info(struct cmm_xlatorobject *xlato=
r, u8 ** paddr,
 	struct cmm_xlator *xlator_obj =3D (struct cmm_xlator *)xlator;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(paddr !=3D NULL);
-	DBC_REQUIRE((segm_id > 0) && (segm_id <=3D CMM_MAXGPPSEGS));
-
 	if (xlator_obj) {
 		if (set_info) {
 			/* set translators virtual address range */
@@ -948,10 +893,6 @@ void *cmm_xlator_translate(struct cmm_xlatorobject=
 *xlator, void *paddr,
 	struct cmm_allocator *allocator =3D NULL;
 	u32 dw_offset =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(paddr !=3D NULL);
-	DBC_REQUIRE((xtype >=3D CMM_VA2PA) && (xtype <=3D CMM_DSPPA2PA));
-
 	if (!xlator_obj)
 		goto loop_cont;
=20
diff --git a/drivers/staging/tidspbridge/pmgr/cod.c b/drivers/staging/t=
idspbridge/pmgr/cod.c
index 1a29264..be7c777 100644
--- a/drivers/staging/tidspbridge/pmgr/cod.c
+++ b/drivers/staging/tidspbridge/pmgr/cod.c
@@ -183,10 +183,6 @@ void cod_close(struct cod_libraryobj *lib)
 {
 	struct cod_manager *hmgr;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(lib !=3D NULL);
-	DBC_REQUIRE(lib->cod_mgr);
-
 	hmgr =3D lib->cod_mgr;
 	hmgr->fxns.close_fxn(lib->dbll_lib);
=20
@@ -208,9 +204,6 @@ int cod_create(struct cod_manager **mgr, char *str_=
zl_file)
 	struct dbll_attrs zl_attrs;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(mgr !=3D NULL);
-
 	/* assume failure */
 	*mgr =3D NULL;
=20
@@ -263,9 +256,6 @@ int cod_create(struct cod_manager **mgr, char *str_=
zl_file)
  */
 void cod_delete(struct cod_manager *cod_mgr_obj)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-
 	if (cod_mgr_obj->base_lib) {
 		if (cod_mgr_obj->loaded)
 			cod_mgr_obj->fxns.unload_fxn(cod_mgr_obj->base_lib,
@@ -288,11 +278,7 @@ void cod_delete(struct cod_manager *cod_mgr_obj)
  */
 void cod_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -305,10 +291,6 @@ int cod_get_base_lib(struct cod_manager *cod_mgr_o=
bj,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(plib !=3D NULL);
-
 	*plib =3D (struct dbll_library_obj *)cod_mgr_obj->base_lib;
=20
 	return status;
@@ -322,10 +304,6 @@ int cod_get_base_name(struct cod_manager *cod_mgr_=
obj, char *sz_name,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(sz_name !=3D NULL);
-
 	if (usize <=3D COD_MAXPATHLENGTH)
 		strncpy(sz_name, cod_mgr_obj->sz_zl_file, usize);
 	else
@@ -342,10 +320,6 @@ int cod_get_base_name(struct cod_manager *cod_mgr_=
obj, char *sz_name,
  */
 int cod_get_entry(struct cod_manager *cod_mgr_obj, u32 *entry_pt)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(entry_pt !=3D NULL);
-
 	*entry_pt =3D cod_mgr_obj->entry;
=20
 	return 0;
@@ -361,10 +335,6 @@ int cod_get_loader(struct cod_manager *cod_mgr_obj=
,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(loader !=3D NULL);
-
 	*loader =3D (struct dbll_tar_obj *)cod_mgr_obj->target;
=20
 	return status;
@@ -382,13 +352,6 @@ int cod_get_section(struct cod_libraryobj *lib, ch=
ar *str_sect,
 	struct cod_manager *cod_mgr_obj;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(lib !=3D NULL);
-	DBC_REQUIRE(lib->cod_mgr);
-	DBC_REQUIRE(str_sect !=3D NULL);
-	DBC_REQUIRE(addr !=3D NULL);
-	DBC_REQUIRE(len !=3D NULL);
-
 	*addr =3D 0;
 	*len =3D 0;
 	if (lib !=3D NULL) {
@@ -399,8 +362,6 @@ int cod_get_section(struct cod_libraryobj *lib, cha=
r *str_sect,
 		status =3D -ESPIPE;
 	}
=20
-	DBC_ENSURE(!status || ((*addr =3D=3D 0) && (*len =3D=3D 0)));
-
 	return status;
 }
=20
@@ -417,11 +378,6 @@ int cod_get_sym_value(struct cod_manager *cod_mgr_=
obj, char *str_sym,
 {
 	struct dbll_sym_val *dbll_sym;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(str_sym !=3D NULL);
-	DBC_REQUIRE(pul_value !=3D NULL);
-
 	dev_dbg(bridge, "%s: cod_mgr_obj: %p str_sym: %s pul_value: %p\n",
 		__func__, cod_mgr_obj, str_sym, pul_value);
 	if (cod_mgr_obj->base_lib) {
@@ -451,12 +407,9 @@ bool cod_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && refs > 0) || (!ret && refs >=3D 0));
 	return ret;
 }
=20
@@ -482,14 +435,6 @@ int cod_load_base(struct cod_manager *cod_mgr_obj,=
 u32 num_argc, char *args[],
 	int status;
 	u32 i;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr_obj);
-	DBC_REQUIRE(num_argc > 0);
-	DBC_REQUIRE(args !=3D NULL);
-	DBC_REQUIRE(args[0] !=3D NULL);
-	DBC_REQUIRE(pfn_write !=3D NULL);
-	DBC_REQUIRE(cod_mgr_obj->base_lib !=3D NULL);
-
 	/*
 	 *  Make sure every argv[] stated in argc has a value, or change argc=
 to
 	 *  reflect true number in NULL terminated argv array.
@@ -538,12 +483,6 @@ int cod_open(struct cod_manager *hmgr, char *sz_co=
ff_path,
 	int status =3D 0;
 	struct cod_libraryobj *lib =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hmgr);
-	DBC_REQUIRE(sz_coff_path !=3D NULL);
-	DBC_REQUIRE(flags =3D=3D COD_NOLOAD || flags =3D=3D COD_SYMB);
-	DBC_REQUIRE(lib_obj !=3D NULL);
-
 	*lib_obj =3D NULL;
=20
 	lib =3D kzalloc(sizeof(struct cod_libraryobj), GFP_KERNEL);
@@ -575,10 +514,6 @@ int cod_open_base(struct cod_manager *hmgr, char *=
sz_coff_path,
 	int status =3D 0;
 	struct dbll_library_obj *lib;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hmgr);
-	DBC_REQUIRE(sz_coff_path !=3D NULL);
-
 	/* if we previously opened a base image, close it now */
 	if (hmgr->base_lib) {
 		if (hmgr->loaded) {
@@ -612,12 +547,6 @@ int cod_read_section(struct cod_libraryobj *lib, c=
har *str_sect,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(lib !=3D NULL);
-	DBC_REQUIRE(lib->cod_mgr);
-	DBC_REQUIRE(str_sect !=3D NULL);
-	DBC_REQUIRE(str_content !=3D NULL);
-
 	if (lib !=3D NULL)
 		status =3D
 		    lib->cod_mgr->fxns.read_sect_fxn(lib->dbll_lib, str_sect,
diff --git a/drivers/staging/tidspbridge/pmgr/dbll.c b/drivers/staging/=
tidspbridge/pmgr/dbll.c
index 31da62b..db1af79 100644
--- a/drivers/staging/tidspbridge/pmgr/dbll.c
+++ b/drivers/staging/tidspbridge/pmgr/dbll.c
@@ -202,9 +202,6 @@ void dbll_close(struct dbll_library_obj *zl_lib)
 {
 	struct dbll_tar_obj *zl_target;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(zl_lib->open_ref > 0);
 	zl_target =3D zl_lib->target_obj;
 	zl_lib->open_ref--;
 	if (zl_lib->open_ref =3D=3D 0) {
@@ -241,10 +238,6 @@ int dbll_create(struct dbll_tar_obj **target_obj,
 	struct dbll_tar_obj *pzl_target;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pattrs !=3D NULL);
-	DBC_REQUIRE(target_obj !=3D NULL);
-
 	/* Allocate DBL target object */
 	pzl_target =3D kzalloc(sizeof(struct dbll_tar_obj), GFP_KERNEL);
 	if (target_obj !=3D NULL) {
@@ -255,8 +248,6 @@ int dbll_create(struct dbll_tar_obj **target_obj,
 			pzl_target->attrs =3D *pattrs;
 			*target_obj =3D (struct dbll_tar_obj *)pzl_target;
 		}
-		DBC_ENSURE((!status && *target_obj) ||
-				(status && *target_obj =3D=3D NULL));
 	}
=20
 	return status;
@@ -269,9 +260,6 @@ void dbll_delete(struct dbll_tar_obj *target)
 {
 	struct dbll_tar_obj *zl_target =3D (struct dbll_tar_obj *)target;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_target);
-
 	kfree(zl_target);
=20
 }
@@ -282,14 +270,10 @@ void dbll_delete(struct dbll_tar_obj *target)
  */
 void dbll_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
=20
 	if (refs =3D=3D 0)
 		gh_exit();
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -302,12 +286,6 @@ bool dbll_get_addr(struct dbll_library_obj *zl_lib=
, char *name,
 	struct dbll_symbol *sym;
 	bool status =3D false;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(name !=3D NULL);
-	DBC_REQUIRE(sym_val !=3D NULL);
-	DBC_REQUIRE(zl_lib->sym_tab !=3D NULL);
-
 	sym =3D (struct dbll_symbol *)gh_find(zl_lib->sym_tab, name);
 	if (sym !=3D NULL) {
 		*sym_val =3D &sym->value;
@@ -327,10 +305,6 @@ void dbll_get_attrs(struct dbll_tar_obj *target, s=
truct dbll_attrs *pattrs)
 {
 	struct dbll_tar_obj *zl_target =3D (struct dbll_tar_obj *)target;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_target);
-	DBC_REQUIRE(pattrs !=3D NULL);
-
 	if ((pattrs !=3D NULL) && (zl_target !=3D NULL))
 		*pattrs =3D zl_target->attrs;
=20
@@ -347,12 +321,6 @@ bool dbll_get_c_addr(struct dbll_library_obj *zl_l=
ib, char *name,
 	char cname[MAXEXPR + 1];
 	bool status =3D false;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(sym_val !=3D NULL);
-	DBC_REQUIRE(zl_lib->sym_tab !=3D NULL);
-	DBC_REQUIRE(name !=3D NULL);
-
 	cname[0] =3D '_';
=20
 	strncpy(cname + 1, name, sizeof(cname) - 2);
@@ -382,12 +350,6 @@ int dbll_get_sect(struct dbll_library_obj *lib, ch=
ar *name, u32 *paddr,
 	struct dbll_library_obj *zl_lib =3D (struct dbll_library_obj *)lib;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(name !=3D NULL);
-	DBC_REQUIRE(paddr !=3D NULL);
-	DBC_REQUIRE(psize !=3D NULL);
-	DBC_REQUIRE(zl_lib);
-
 	/* If DOFF file is not open, we open it. */
 	if (zl_lib !=3D NULL) {
 		if (zl_lib->fp =3D=3D NULL) {
@@ -434,8 +396,6 @@ int dbll_get_sect(struct dbll_library_obj *lib, cha=
r *name, u32 *paddr,
  */
 bool dbll_init(void)
 {
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (refs =3D=3D 0)
 		gh_init();
=20
@@ -456,10 +416,6 @@ int dbll_load(struct dbll_library_obj *lib, dbll_f=
lags flags,
 	s32 err;
 	int status =3D 0;
 	bool opened_doff =3D false;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(entry !=3D NULL);
-	DBC_REQUIRE(attrs !=3D NULL);
=20
 	/*
 	 *  Load if not already loaded.
@@ -558,8 +514,6 @@ int dbll_load(struct dbll_library_obj *lib, dbll_fl=
ags flags,
 	if (opened_doff)
 		dof_close(zl_lib);
=20
-	DBC_ENSURE(status || zl_lib->load_ref > 0);
-
 	dev_dbg(bridge, "%s: lib: %p flags: 0x%x entry: %p, status 0x%x\n",
 		__func__, lib, flags, entry, status);
=20
@@ -577,12 +531,6 @@ int dbll_open(struct dbll_tar_obj *target, char *f=
ile, dbll_flags flags,
 	s32 err;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_target);
-	DBC_REQUIRE(zl_target->attrs.fopen !=3D NULL);
-	DBC_REQUIRE(file !=3D NULL);
-	DBC_REQUIRE(lib_obj !=3D NULL);
-
 	zl_lib =3D zl_target->head;
 	while (zl_lib !=3D NULL) {
 		if (strcmp(zl_lib->file_name, file) =3D=3D 0) {
@@ -699,8 +647,6 @@ func_cont:
 			dbll_close((struct dbll_library_obj *)zl_lib);
=20
 	}
-	DBC_ENSURE((!status && (zl_lib->open_ref > 0) && *lib_obj)
-				|| (status && *lib_obj =3D=3D NULL));
=20
 	dev_dbg(bridge, "%s: target: %p file: %s lib_obj: %p, status 0x%x\n",
 		__func__, target, file, lib_obj, status);
@@ -722,12 +668,6 @@ int dbll_read_sect(struct dbll_library_obj *lib, c=
har *name,
 	const struct ldr_section_info *sect =3D NULL;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(name !=3D NULL);
-	DBC_REQUIRE(buf !=3D NULL);
-	DBC_REQUIRE(size !=3D 0);
-
 	/* If DOFF file is not open, we open it. */
 	if (zl_lib !=3D NULL) {
 		if (zl_lib->fp =3D=3D NULL) {
@@ -788,14 +728,11 @@ void dbll_unload(struct dbll_library_obj *lib, st=
ruct dbll_attrs *attrs)
 	struct dbll_library_obj *zl_lib =3D (struct dbll_library_obj *)lib;
 	s32 err =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(zl_lib);
-	DBC_REQUIRE(zl_lib->load_ref > 0);
 	dev_dbg(bridge, "%s: lib: %p\n", __func__, lib);
 	zl_lib->load_ref--;
 	/* Unload only if reference count is 0 */
 	if (zl_lib->load_ref !=3D 0)
-		goto func_end;
+		return;
=20
 	zl_lib->target_obj->attrs =3D *attrs;
 	if (zl_lib->dload_mod_obj) {
@@ -814,8 +751,6 @@ void dbll_unload(struct dbll_library_obj *lib, stru=
ct dbll_attrs *attrs)
 	/* delete DOFF desc since it holds *lots* of host OS
 	 * resources */
 	dof_close(zl_lib);
-func_end:
-	DBC_ENSURE(zl_lib->load_ref >=3D 0);
 }
=20
 /*
@@ -874,8 +809,6 @@ static u16 name_hash(void *key, u16 max_bucket)
 	u16 hash;
 	char *name =3D (char *)key;
=20
-	DBC_REQUIRE(name !=3D NULL);
-
 	hash =3D 0;
=20
 	while (*name) {
@@ -893,9 +826,6 @@ static u16 name_hash(void *key, u16 max_bucket)
  */
 static bool name_match(void *key, void *sp)
 {
-	DBC_REQUIRE(key !=3D NULL);
-	DBC_REQUIRE(sp !=3D NULL);
-
 	if ((key !=3D NULL) && (sp !=3D NULL)) {
 		if (strcmp((char *)key, ((struct dbll_symbol *)sp)->name) =3D=3D
 		    0)
@@ -938,10 +868,7 @@ static int dbll_read_buffer(struct dynamic_loader_=
stream *this, void *buffer,
 	struct dbll_library_obj *lib;
 	int bytes_read =3D 0;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D pstream->lib;
-	DBC_REQUIRE(lib);
-
 	if (lib !=3D NULL) {
 		bytes_read =3D
 		    (*(lib->target_obj->attrs.fread)) (buffer, 1, bufsize,
@@ -960,10 +887,7 @@ static int dbll_set_file_posn(struct dynamic_loade=
r_stream *this,
 	struct dbll_library_obj *lib;
 	int status =3D 0;		/* Success */
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D pstream->lib;
-	DBC_REQUIRE(lib);
-
 	if (lib !=3D NULL) {
 		status =3D (*(lib->target_obj->attrs.fseek)) (lib->fp, (long)pos,
 							    SEEK_SET);
@@ -986,10 +910,7 @@ static struct dynload_symbol *dbll_find_symbol(str=
uct dynamic_loader_sym *this,
 	struct dbll_sym_val *dbll_sym =3D NULL;
 	bool status =3D false;	/* Symbol not found yet */
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
-
 	if (lib !=3D NULL) {
 		if (lib->target_obj->attrs.sym_lookup) {
 			/* Check current lib + base lib + dep lib +
@@ -1034,11 +955,7 @@ static struct dynload_symbol *find_in_symbol_tabl=
e(struct dynamic_loader_sym
 	struct dbll_library_obj *lib;
 	struct dbll_symbol *sym;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
-	DBC_REQUIRE(lib->sym_tab !=3D NULL);
-
 	sym =3D (struct dbll_symbol *)gh_find(lib->sym_tab, (char *)name);
=20
 	ret_sym =3D (struct dynload_symbol *)&sym->value;
@@ -1059,10 +976,7 @@ static struct dynload_symbol *dbll_add_to_symbol_=
table(struct dynamic_loader_sym
 	struct dbll_library_obj *lib;
 	struct dynload_symbol *ret;
=20
-	DBC_REQUIRE(this !=3D NULL);
-	DBC_REQUIRE(name);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
=20
 	/* Check to see if symbol is already defined in symbol table */
 	if (!(lib->target_obj->attrs.base_image)) {
@@ -1111,10 +1025,7 @@ static void dbll_purge_symbol_table(struct dynam=
ic_loader_sym *this,
 	struct ldr_symbol *ldr_sym =3D (struct ldr_symbol *)this;
 	struct dbll_library_obj *lib;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
-
 	/* May not need to do anything */
 }
=20
@@ -1127,9 +1038,7 @@ static void *allocate(struct dynamic_loader_sym *=
this, unsigned memsize)
 	struct dbll_library_obj *lib;
 	void *buf;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
=20
 	buf =3D kzalloc(memsize, GFP_KERNEL);
=20
@@ -1144,9 +1053,7 @@ static void deallocate(struct dynamic_loader_sym =
*this, void *mem_ptr)
 	struct ldr_symbol *ldr_sym =3D (struct ldr_symbol *)this;
 	struct dbll_library_obj *lib;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
=20
 	kfree(mem_ptr);
 }
@@ -1161,9 +1068,7 @@ static void dbll_err_report(struct dynamic_loader=
_sym *this, const char *errstr,
 	struct dbll_library_obj *lib;
 	char temp_buf[MAXEXPR];
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D ldr_sym->lib;
-	DBC_REQUIRE(lib);
 	vsnprintf((char *)temp_buf, MAXEXPR, (char *)errstr, args);
 	dev_dbg(bridge, "%s\n", temp_buf);
 }
@@ -1195,9 +1100,7 @@ static int dbll_rmm_alloc(struct dynamic_loader_a=
llocate *this,
 	u32 alloc_size =3D 0;
 	u32 run_addr_flag =3D 0;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D dbll_alloc_obj->lib;
-	DBC_REQUIRE(lib);
=20
 	mem_sect_type =3D
 	    (stype =3D=3D DLOAD_TEXT) ? DBLL_CODE : (stype =3D=3D
@@ -1206,7 +1109,6 @@ static int dbll_rmm_alloc(struct dynamic_loader_a=
llocate *this,
=20
 	/* Attempt to extract the segment ID and requirement information from
 	   the name of the section */
-	DBC_REQUIRE(info->name);
 	token_len =3D strlen((char *)(info->name)) + 1;
=20
 	sz_sect_name =3D kzalloc(token_len, GFP_KERNEL);
@@ -1307,9 +1209,7 @@ static void rmm_dealloc(struct dynamic_loader_all=
ocate *this,
 	    (stype =3D=3D DLOAD_TEXT) ? DBLL_CODE : (stype =3D=3D
 						 DLOAD_BSS) ? DBLL_BSS :
 	    DBLL_DATA;
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D dbll_alloc_obj->lib;
-	DBC_REQUIRE(lib);
 	/* segid was set by alloc function */
 	segid =3D (u32) info->context;
 	if (mem_sect_type =3D=3D DBLL_CODE)
@@ -1347,9 +1247,7 @@ static int read_mem(struct dynamic_loader_initial=
ize *this, void *buf,
 	struct dbll_library_obj *lib;
 	int bytes_read =3D 0;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D init_obj->lib;
-	DBC_REQUIRE(lib);
 	/* Need bridge_brd_read function */
 	return bytes_read;
 }
@@ -1368,7 +1266,6 @@ static int write_mem(struct dynamic_loader_initia=
lize *this, void *buf,
 	u32 mem_sect_type;
 	bool ret =3D true;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D init_obj->lib;
 	if (!lib)
 		return false;
@@ -1415,7 +1312,6 @@ static int fill_mem(struct dynamic_loader_initial=
ize *this, ldr_addr addr,
 	struct dbll_library_obj *lib;
 	struct dbll_init_obj *init_obj =3D (struct dbll_init_obj *)this;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D init_obj->lib;
 	pbuf =3D NULL;
 	/* Pass the NULL pointer to write_mem to get the start address of Sha=
red
@@ -1439,9 +1335,7 @@ static int execute(struct dynamic_loader_initiali=
ze *this, ldr_addr start)
 	struct dbll_library_obj *lib;
 	bool ret =3D true;
=20
-	DBC_REQUIRE(this !=3D NULL);
 	lib =3D init_obj->lib;
-	DBC_REQUIRE(lib);
 	/* Save entry point */
 	if (lib !=3D NULL)
 		lib->entry =3D (u32) start;
diff --git a/drivers/staging/tidspbridge/pmgr/dev.c b/drivers/staging/t=
idspbridge/pmgr/dev.c
index 522810b..e4257fd 100644
--- a/drivers/staging/tidspbridge/pmgr/dev.c
+++ b/drivers/staging/tidspbridge/pmgr/dev.c
@@ -106,8 +106,6 @@ u32 dev_brd_write_fxn(void *arb, u32 dsp_add, void =
*host_buf,
 	u32 ul_written =3D 0;
 	int status;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(host_buf !=3D NULL);	/* Required of BrdWrite(). */
 	if (dev_obj) {
 		/* Require of BrdWrite() */
 		DBC_ASSERT(dev_obj->bridge_context !=3D NULL);
@@ -143,9 +141,6 @@ int dev_create_device(struct dev_object **device_ob=
j,
 	struct drv_object *hdrv_obj =3D NULL;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
 	int status =3D 0;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(device_obj !=3D NULL);
-	DBC_REQUIRE(driver_file_name !=3D NULL);
=20
 	status =3D drv_request_bridge_res_dsp((void *)&host_res);
=20
@@ -271,7 +266,6 @@ leave:
 		*device_obj =3D NULL;
 	}
=20
-	DBC_ENSURE((!status && *device_obj) || (status && !*device_obj));
 	return status;
 }
=20
@@ -287,17 +281,12 @@ int dev_create2(struct dev_object *hdev_obj)
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdev_obj);
-
 	/* There can be only one Node Manager per DEV object */
 	DBC_ASSERT(!dev_obj->node_mgr);
 	status =3D node_create_mgr(&dev_obj->node_mgr, hdev_obj);
 	if (status)
 		dev_obj->node_mgr =3D NULL;
=20
-	DBC_ENSURE((!status && dev_obj->node_mgr !=3D NULL)
-		   || (status && dev_obj->node_mgr =3D=3D NULL));
 	return status;
 }
=20
@@ -311,9 +300,6 @@ int dev_destroy2(struct dev_object *hdev_obj)
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdev_obj);
-
 	if (dev_obj->node_mgr) {
 		if (node_delete_mgr(dev_obj->node_mgr))
 			status =3D -EPERM;
@@ -322,7 +308,6 @@ int dev_destroy2(struct dev_object *hdev_obj)
=20
 	}
=20
-	DBC_ENSURE((!status && dev_obj->node_mgr =3D=3D NULL) || status);
 	return status;
 }
=20
@@ -337,8 +322,6 @@ int dev_destroy_device(struct dev_object *hdev_obj)
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (hdev_obj) {
 		if (dev_obj->cod_mgr) {
 			cod_delete(dev_obj->cod_mgr);
@@ -415,9 +398,6 @@ int dev_get_chnl_mgr(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(mgr !=3D NULL);
-
 	if (hdev_obj) {
 		*mgr =3D dev_obj->chnl_mgr;
 	} else {
@@ -425,7 +405,6 @@ int dev_get_chnl_mgr(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (mgr !=3D NULL && *mgr =3D=3D NULL));
 	return status;
 }
=20
@@ -441,9 +420,6 @@ int dev_get_cmm_mgr(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(mgr !=3D NULL);
-
 	if (hdev_obj) {
 		*mgr =3D dev_obj->cmm_mgr;
 	} else {
@@ -451,7 +427,6 @@ int dev_get_cmm_mgr(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (mgr !=3D NULL && *mgr =3D=3D NULL));
 	return status;
 }
=20
@@ -467,9 +442,6 @@ int dev_get_dmm_mgr(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(mgr !=3D NULL);
-
 	if (hdev_obj) {
 		*mgr =3D dev_obj->dmm_mgr;
 	} else {
@@ -477,7 +449,6 @@ int dev_get_dmm_mgr(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (mgr !=3D NULL && *mgr =3D=3D NULL));
 	return status;
 }
=20
@@ -492,9 +463,6 @@ int dev_get_cod_mgr(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(cod_mgr !=3D NULL);
-
 	if (hdev_obj) {
 		*cod_mgr =3D dev_obj->cod_mgr;
 	} else {
@@ -502,7 +470,6 @@ int dev_get_cod_mgr(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (cod_mgr !=3D NULL && *cod_mgr =3D=3D NULL));
 	return status;
 }
=20
@@ -514,9 +481,6 @@ int dev_get_deh_mgr(struct dev_object *hdev_obj,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(deh_manager !=3D NULL);
-	DBC_REQUIRE(hdev_obj);
 	if (hdev_obj) {
 		*deh_manager =3D hdev_obj->deh_mgr;
 	} else {
@@ -537,9 +501,6 @@ int dev_get_dev_node(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dev_nde !=3D NULL);
-
 	if (hdev_obj) {
 		*dev_nde =3D dev_obj->dev_node_obj;
 	} else {
@@ -547,7 +508,6 @@ int dev_get_dev_node(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (dev_nde !=3D NULL && *dev_nde =3D=3D NULL));
 	return status;
 }
=20
@@ -578,9 +538,6 @@ int dev_get_intf_fxns(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(if_fxns !=3D NULL);
-
 	if (hdev_obj) {
 		*if_fxns =3D &dev_obj->bridge_interface;
 	} else {
@@ -588,7 +545,6 @@ int dev_get_intf_fxns(struct dev_object *hdev_obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || ((if_fxns !=3D NULL) && (*if_fxns =3D=3D NULL))=
);
 	return status;
 }
=20
@@ -600,10 +556,6 @@ int dev_get_io_mgr(struct dev_object *hdev_obj,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(io_man !=3D NULL);
-	DBC_REQUIRE(hdev_obj);
-
 	if (hdev_obj) {
 		*io_man =3D hdev_obj->iomgr;
 	} else {
@@ -638,10 +590,6 @@ struct dev_object *dev_get_next(struct dev_object =
*hdev_obj)
  */
 void dev_get_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr **msg=
_man)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(msg_man !=3D NULL);
-	DBC_REQUIRE(hdev_obj);
-
 	*msg_man =3D hdev_obj->msg_mgr;
 }
=20
@@ -656,9 +604,6 @@ int dev_get_node_manager(struct dev_object *hdev_ob=
j,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(node_man !=3D NULL);
-
 	if (hdev_obj) {
 		*node_man =3D dev_obj->node_mgr;
 	} else {
@@ -666,7 +611,6 @@ int dev_get_node_manager(struct dev_object *hdev_ob=
j,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (node_man !=3D NULL && *node_man =3D=3D NULL));
 	return status;
 }
=20
@@ -679,9 +623,6 @@ int dev_get_symbol(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct cod_manager *cod_mgr;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(str_sym !=3D NULL && pul_value !=3D NULL);
-
 	if (hdev_obj) {
 		status =3D dev_get_cod_mgr(hdev_obj, &cod_mgr);
 		if (cod_mgr)
@@ -706,9 +647,6 @@ int dev_get_bridge_context(struct dev_object *hdev_=
obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(phbridge_context !=3D NULL);
-
 	if (hdev_obj) {
 		*phbridge_context =3D dev_obj->bridge_context;
 	} else {
@@ -716,8 +654,6 @@ int dev_get_bridge_context(struct dev_object *hdev_=
obj,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || ((phbridge_context !=3D NULL) &&
-					     (*phbridge_context =3D=3D NULL)));
 	return status;
 }
=20
@@ -729,16 +665,12 @@ int dev_get_bridge_context(struct dev_object *hde=
v_obj,
  */
 void dev_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
=20
 	if (refs =3D=3D 0) {
 		cmm_exit();
 		dmm_exit();
 	}
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -750,8 +682,6 @@ bool dev_init(void)
 {
 	bool cmm_ret, dmm_ret, ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (refs =3D=3D 0) {
 		cmm_ret =3D cmm_init();
 		dmm_ret =3D dmm_init();
@@ -771,8 +701,6 @@ bool dev_init(void)
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -841,14 +769,11 @@ int dev_set_chnl_mgr(struct dev_object *hdev_obj,
 	int status =3D 0;
 	struct dev_object *dev_obj =3D hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (hdev_obj)
 		dev_obj->chnl_mgr =3D hmgr;
 	else
 		status =3D -EFAULT;
=20
-	DBC_ENSURE(status || (dev_obj->chnl_mgr =3D=3D hmgr));
 	return status;
 }
=20
@@ -859,9 +784,6 @@ int dev_set_chnl_mgr(struct dev_object *hdev_obj,
  */
 void dev_set_msg_mgr(struct dev_object *hdev_obj, struct msg_mgr *hmgr=
)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdev_obj);
-
 	hdev_obj->msg_mgr =3D hmgr;
 }
=20
@@ -879,8 +801,6 @@ int dev_start_device(struct cfg_devnode *dev_node_o=
bj)
 	struct mgr_object *hmgr_obj =3D NULL;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(refs > 0);
-
 	/* Given all resources, create a device object. */
 	status =3D dev_create_device(&hdev_obj, bridge_file_name,
 				   dev_node_obj);
@@ -944,9 +864,6 @@ static int init_cod_mgr(struct dev_object *dev_obj)
 	int status =3D 0;
 	char *sz_dummy_file =3D "dummy";
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(!dev_obj || (dev_obj->cod_mgr =3D=3D NULL));
-
 	status =3D cod_create(&dev_obj->cod_mgr, sz_dummy_file);
=20
 	return status;
@@ -976,10 +893,6 @@ int dev_insert_proc_object(struct dev_object *hdev=
_obj,
 {
 	struct dev_object *dev_obj =3D (struct dev_object *)hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dev_obj);
-	DBC_REQUIRE(proc_obj !=3D 0);
-	DBC_REQUIRE(already_attached !=3D NULL);
 	if (!list_empty(&dev_obj->proc_list))
 		*already_attached =3D true;
=20
@@ -1017,10 +930,6 @@ int dev_remove_proc_object(struct dev_object *hde=
v_obj, u32 proc_obj)
 	struct list_head *cur_elem;
 	struct dev_object *dev_obj =3D (struct dev_object *)hdev_obj;
=20
-	DBC_REQUIRE(dev_obj);
-	DBC_REQUIRE(proc_obj !=3D 0);
-	DBC_REQUIRE(!list_empty(&dev_obj->proc_list));
-
 	/* Search list for dev_obj: */
 	list_for_each(cur_elem, &dev_obj->proc_list) {
 		if ((u32) cur_elem =3D=3D proc_obj) {
@@ -1069,10 +978,6 @@ static void store_interface_fxns(struct bridge_dr=
v_interface *drv_fxns,
     (intf_fxns->pfn =3D ((drv_fxns->pfn !=3D NULL) ? drv_fxns->pfn : \
     (cast)fxn_not_implemented))
=20
-	DBC_REQUIRE(intf_fxns !=3D NULL);
-	DBC_REQUIRE(drv_fxns !=3D NULL);
-	DBC_REQUIRE(MAKEVERSION(drv_fxns->brd_api_major_version,
-			drv_fxns->brd_api_minor_version) <=3D BRD_API_VERSION);
 	bridge_version =3D MAKEVERSION(drv_fxns->brd_api_major_version,
 				     drv_fxns->brd_api_minor_version);
 	intf_fxns->brd_api_major_version =3D drv_fxns->brd_api_major_version;
@@ -1119,33 +1024,5 @@ static void store_interface_fxns(struct bridge_d=
rv_interface *drv_fxns,
 		STORE_FXN(fxn_msg_setqueueid, msg_set_queue_id);
 	}
 	/* Add code for any additional functions in newerBridge versions here=
 */
-	/* Ensure postcondition: */
-	DBC_ENSURE(intf_fxns->dev_create !=3D NULL);
-	DBC_ENSURE(intf_fxns->dev_destroy !=3D NULL);
-	DBC_ENSURE(intf_fxns->dev_cntrl !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_monitor !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_start !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_stop !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_status !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_read !=3D NULL);
-	DBC_ENSURE(intf_fxns->brd_write !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_create !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_destroy !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_open !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_close !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_add_io_req !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_get_ioc !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_cancel_io !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_flush_io !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_get_info !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_get_mgr_info !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_idle !=3D NULL);
-	DBC_ENSURE(intf_fxns->chnl_register_notify !=3D NULL);
-	DBC_ENSURE(intf_fxns->io_create !=3D NULL);
-	DBC_ENSURE(intf_fxns->io_destroy !=3D NULL);
-	DBC_ENSURE(intf_fxns->io_on_loaded !=3D NULL);
-	DBC_ENSURE(intf_fxns->io_get_proc_load !=3D NULL);
-	DBC_ENSURE(intf_fxns->msg_set_queue_id !=3D NULL);
-
 #undef  STORE_FXN
 }
diff --git a/drivers/staging/tidspbridge/pmgr/dmm.c b/drivers/staging/t=
idspbridge/pmgr/dmm.c
index 8685233..cece780 100644
--- a/drivers/staging/tidspbridge/pmgr/dmm.c
+++ b/drivers/staging/tidspbridge/pmgr/dmm.c
@@ -123,8 +123,6 @@ int dmm_create(struct dmm_object **dmm_manager,
 {
 	struct dmm_object *dmm_obj =3D NULL;
 	int status =3D 0;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dmm_manager !=3D NULL);
=20
 	*dmm_manager =3D NULL;
 	/* create, zero, and tag a cmm mgr object */
@@ -149,7 +147,6 @@ int dmm_destroy(struct dmm_object *dmm_mgr)
 	struct dmm_object *dmm_obj =3D (struct dmm_object *)dmm_mgr;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
 	if (dmm_mgr) {
 		status =3D dmm_delete_tables(dmm_obj);
 		if (!status)
@@ -169,7 +166,6 @@ int dmm_delete_tables(struct dmm_object *dmm_mgr)
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
 	/* Delete all DMM tables */
 	if (dmm_mgr)
 		vfree(virtual_mapping_table);
@@ -186,7 +182,6 @@ int dmm_delete_tables(struct dmm_object *dmm_mgr)
  */
 void dmm_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
=20
 	refs--;
 }
@@ -202,8 +197,6 @@ int dmm_get_handle(void *hprocessor, struct dmm_obj=
ect **dmm_manager)
 	int status =3D 0;
 	struct dev_object *hdev_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dmm_manager !=3D NULL);
 	if (hprocessor !=3D NULL)
 		status =3D proc_get_dev_object(hprocessor, &hdev_obj);
 	else
@@ -224,13 +217,9 @@ bool dmm_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	virtual_mapping_table =3D NULL;
 	table_size =3D 0;
=20
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index 767ffe2..27c14a5 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -266,7 +266,6 @@ err:
  */
 void api_exit(void)
 {
-	DBC_REQUIRE(api_c_refs > 0);
 	api_c_refs--;
=20
 	if (api_c_refs =3D=3D 0) {
@@ -284,7 +283,6 @@ void api_exit(void)
 		rmm_exit();
 		drv_exit();
 	}
-	DBC_ENSURE(api_c_refs >=3D 0);
 }
=20
 /*
@@ -382,8 +380,6 @@ int api_init_complete2(void)
 	struct drv_data *drv_datap;
 	u8 dev_type;
=20
-	DBC_REQUIRE(api_c_refs > 0);
-
 	/*  Walk the list of DevObjects, get each devnode, and attempting to
 	 *  autostart the board. Note that this requires COF loading, which
 	 *  requires KFILE. */
diff --git a/drivers/staging/tidspbridge/pmgr/io.c b/drivers/staging/ti=
dspbridge/pmgr/io.c
index 65245f3..bbfe94c 100644
--- a/drivers/staging/tidspbridge/pmgr/io.c
+++ b/drivers/staging/tidspbridge/pmgr/io.c
@@ -50,10 +50,6 @@ int io_create(struct io_mgr **io_man, struct dev_obj=
ect *hdev_obj,
 	struct io_mgr_ *pio_mgr =3D NULL;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(io_man !=3D NULL);
-	DBC_REQUIRE(mgr_attrts !=3D NULL);
-
 	*io_man =3D NULL;
=20
 	/* A memory base of 0 implies no memory base: */
@@ -94,8 +90,6 @@ int io_destroy(struct io_mgr *hio_mgr)
 	struct io_mgr_ *pio_mgr =3D (struct io_mgr_ *)hio_mgr;
 	int status;
=20
-	DBC_REQUIRE(refs > 0);
-
 	intf_fxns =3D pio_mgr->intf_fxns;
=20
 	/* Let Bridge channel module destroy the io_mgr: */
@@ -111,11 +105,7 @@ int io_destroy(struct io_mgr *hio_mgr)
  */
 void io_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -127,12 +117,8 @@ bool io_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
diff --git a/drivers/staging/tidspbridge/pmgr/msg.c b/drivers/staging/t=
idspbridge/pmgr/msg.c
index a691603..150026d 100644
--- a/drivers/staging/tidspbridge/pmgr/msg.c
+++ b/drivers/staging/tidspbridge/pmgr/msg.c
@@ -53,11 +53,6 @@ int msg_create(struct msg_mgr **msg_man,
 	struct msg_mgr *hmsg_mgr;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(msg_man !=3D NULL);
-	DBC_REQUIRE(msg_callback !=3D NULL);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-
 	*msg_man =3D NULL;
=20
 	dev_get_intf_fxns(hdev_obj, &intf_fxns);
@@ -90,8 +85,6 @@ void msg_delete(struct msg_mgr *hmsg_mgr)
 	struct msg_mgr_ *msg_mgr_obj =3D (struct msg_mgr_ *)hmsg_mgr;
 	struct bridge_drv_interface *intf_fxns;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (msg_mgr_obj) {
 		intf_fxns =3D msg_mgr_obj->intf_fxns;
=20
@@ -108,10 +101,7 @@ void msg_delete(struct msg_mgr *hmsg_mgr)
  */
 void msg_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -119,11 +109,7 @@ void msg_exit(void)
  */
 bool msg_mod_init(void)
 {
-	DBC_REQUIRE(refs >=3D 0);
-
 	refs++;
=20
-	DBC_ENSURE(refs >=3D 0);
-
 	return true;
 }
diff --git a/drivers/staging/tidspbridge/rmgr/dbdcd.c b/drivers/staging=
/tidspbridge/rmgr/dbdcd.c
index fda2402..792b443 100644
--- a/drivers/staging/tidspbridge/rmgr/dbdcd.c
+++ b/drivers/staging/tidspbridge/rmgr/dbdcd.c
@@ -85,8 +85,6 @@ int dcd_auto_register(struct dcd_manager *hdcd_mgr,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (hdcd_mgr)
 		status =3D dcd_get_objects(hdcd_mgr, sz_coff_path,
 					 (dcd_registerfxn) dcd_register_object,
@@ -107,8 +105,6 @@ int dcd_auto_unregister(struct dcd_manager *hdcd_mg=
r,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (hdcd_mgr)
 		status =3D dcd_get_objects(hdcd_mgr, sz_coff_path,
 					 (dcd_registerfxn) dcd_register_object,
@@ -131,9 +127,6 @@ int dcd_create_manager(char *sz_zl_dll_name,
 	struct dcd_manager *dcd_mgr_obj =3D NULL;	/* DCD Manager pointer */
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs >=3D 0);
-	DBC_REQUIRE(dcd_mgr);
-
 	status =3D cod_create(&cod_mgr, sz_zl_dll_name);
 	if (status)
 		goto func_end;
@@ -156,9 +149,6 @@ int dcd_create_manager(char *sz_zl_dll_name,
 		cod_delete(cod_mgr);
 	}
=20
-	DBC_ENSURE((!status) ||
-			((dcd_mgr_obj =3D=3D NULL) && (status =3D=3D -ENOMEM)));
-
 func_end:
 	return status;
 }
@@ -173,8 +163,6 @@ int dcd_destroy_manager(struct dcd_manager *hdcd_mg=
r)
 	struct dcd_manager *dcd_mgr_obj =3D hdcd_mgr;
 	int status =3D -EFAULT;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (hdcd_mgr) {
 		/* Delete the COD manager. */
 		cod_delete(dcd_mgr_obj->cod_mgr);
@@ -205,10 +193,6 @@ int dcd_enumerate_object(s32 index, enum dsp_dcdob=
jtype obj_type,
 	struct dcd_key_elem *dcd_key;
 	int len;
=20
-	DBC_REQUIRE(refs >=3D 0);
-	DBC_REQUIRE(index >=3D 0);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-
 	if ((index !=3D 0) && (enum_refs =3D=3D 0)) {
 		/*
 		 * If an enumeration is being performed on an index greater
@@ -294,8 +278,6 @@ int dcd_enumerate_object(s32 index, enum dsp_dcdobj=
type obj_type,
 		}
 	}
=20
-	DBC_ENSURE(uuid_obj || (status =3D=3D -EPERM));
-
 	return status;
 }
=20
@@ -307,7 +289,6 @@ int dcd_enumerate_object(s32 index, enum dsp_dcdobj=
type obj_type,
 void dcd_exit(void)
 {
 	struct dcd_key_elem *rv, *rv_tmp;
-	DBC_REQUIRE(refs > 0);
=20
 	refs--;
 	if (refs =3D=3D 0) {
@@ -319,7 +300,6 @@ void dcd_exit(void)
 		}
 	}
=20
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -333,12 +313,6 @@ int dcd_get_dep_libs(struct dcd_manager *hdcd_mgr,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdcd_mgr);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-	DBC_REQUIRE(dep_lib_uuids !=3D NULL);
-	DBC_REQUIRE(prstnt_dep_libs !=3D NULL);
-
 	status =3D
 	    get_dep_lib_info(hdcd_mgr, uuid_obj, &num_libs, NULL, dep_lib_uui=
ds,
 			     prstnt_dep_libs, phase);
@@ -356,12 +330,6 @@ int dcd_get_num_dep_libs(struct dcd_manager *hdcd_=
mgr,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdcd_mgr);
-	DBC_REQUIRE(num_libs !=3D NULL);
-	DBC_REQUIRE(num_pers_libs !=3D NULL);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-
 	status =3D get_dep_lib_info(hdcd_mgr, uuid_obj, num_libs, num_pers_li=
bs,
 				  NULL, NULL, phase);
=20
@@ -393,10 +361,6 @@ int dcd_get_object_def(struct dcd_manager *hdcd_mg=
r,
 	u32 dw_key_len;		/* Len of REG key. */
 	char sz_obj_type[MAX_INT2CHAR_LENGTH];	/* str. rep. of obj_type. */
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(obj_def !=3D NULL);
-	DBC_REQUIRE(obj_uuid !=3D NULL);
-
 	sz_uuid =3D kzalloc(MAXUUIDLEN, GFP_KERNEL);
 	if (!sz_uuid) {
 		status =3D -ENOMEM;
@@ -553,7 +517,6 @@ int dcd_get_objects(struct dcd_manager *hdcd_mgr,
 	struct dsp_uuid dsp_uuid_obj;
 	s32 object_type;
=20
-	DBC_REQUIRE(refs > 0);
 	if (!hdcd_mgr) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -663,11 +626,6 @@ int dcd_get_library_name(struct dcd_manager *hdcd_=
mgr,
 	int status =3D 0;
 	struct dcd_key_elem *dcd_key =3D NULL;
=20
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-	DBC_REQUIRE(str_lib_name !=3D NULL);
-	DBC_REQUIRE(buff_size !=3D NULL);
-	DBC_REQUIRE(hdcd_mgr);
-
 	dev_dbg(bridge, "%s: hdcd_mgr %p, uuid_obj %p, str_lib_name %p,"
 		" buff_size %p\n", __func__, hdcd_mgr, uuid_obj, str_lib_name,
 		buff_size);
@@ -790,8 +748,6 @@ bool dcd_init(void)
 	bool init_cod;
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (refs =3D=3D 0) {
 		/* Initialize required modules. */
 		init_cod =3D cod_init();
@@ -809,8 +765,6 @@ bool dcd_init(void)
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs =3D=3D 0)));
-
 	return ret;
 }
=20
@@ -832,15 +786,6 @@ int dcd_register_object(struct dsp_uuid *uuid_obj,
 	char sz_obj_type[MAX_INT2CHAR_LENGTH];	/* str. rep. of obj_type. */
 	struct dcd_key_elem *dcd_key =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-	DBC_REQUIRE((obj_type =3D=3D DSP_DCDNODETYPE) ||
-		    (obj_type =3D=3D DSP_DCDPROCESSORTYPE) ||
-		    (obj_type =3D=3D DSP_DCDLIBRARYTYPE) ||
-		    (obj_type =3D=3D DSP_DCDCREATELIBTYPE) ||
-		    (obj_type =3D=3D DSP_DCDEXECUTELIBTYPE) ||
-		    (obj_type =3D=3D DSP_DCDDELETELIBTYPE));
-
 	dev_dbg(bridge, "%s: object UUID %p, obj_type %d, szPathName %s\n",
 		__func__, uuid_obj, obj_type, psz_path_name);
=20
@@ -987,15 +932,6 @@ int dcd_unregister_object(struct dsp_uuid *uuid_ob=
j,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-	DBC_REQUIRE((obj_type =3D=3D DSP_DCDNODETYPE) ||
-		    (obj_type =3D=3D DSP_DCDPROCESSORTYPE) ||
-		    (obj_type =3D=3D DSP_DCDLIBRARYTYPE) ||
-		    (obj_type =3D=3D DSP_DCDCREATELIBTYPE) ||
-		    (obj_type =3D=3D DSP_DCDEXECUTELIBTYPE) ||
-		    (obj_type =3D=3D DSP_DCDDELETELIBTYPE));
-
 	/*
 	 *  When dcd_register_object is called with NULL as pathname,
 	 *  it indicates an unregister object operation.
@@ -1055,12 +991,6 @@ static int get_attrs_from_buf(char *psz_buf, u32 =
ul_buf_size,
 	s32 entry_id;
 #endif
=20
-	DBC_REQUIRE(psz_buf !=3D NULL);
-	DBC_REQUIRE(ul_buf_size !=3D 0);
-	DBC_REQUIRE((obj_type =3D=3D DSP_DCDNODETYPE)
-		    || (obj_type =3D=3D DSP_DCDPROCESSORTYPE));
-	DBC_REQUIRE(gen_obj !=3D NULL);
-
 	switch (obj_type) {
 	case DSP_DCDNODETYPE:
 		/*
@@ -1082,7 +1012,6 @@ static int get_attrs_from_buf(char *psz_buf, u32 =
ul_buf_size,
 		token =3D strsep(&psz_cur, seps);
=20
 		/* ac_name */
-		DBC_REQUIRE(token);
 		token_len =3D strlen(token);
 		if (token_len > DSP_MAXNAMELEN - 1)
 			token_len =3D DSP_MAXNAMELEN - 1;
@@ -1167,7 +1096,6 @@ static int get_attrs_from_buf(char *psz_buf, u32 =
ul_buf_size,
 		token =3D strsep(&psz_cur, seps);
=20
 		/* char *str_create_phase_fxn */
-		DBC_REQUIRE(token);
 		token_len =3D strlen(token);
 		gen_obj->obj_data.node_obj.str_create_phase_fxn =3D
 					kzalloc(token_len + 1, GFP_KERNEL);
@@ -1178,7 +1106,6 @@ static int get_attrs_from_buf(char *psz_buf, u32 =
ul_buf_size,
 		token =3D strsep(&psz_cur, seps);
=20
 		/* char *str_execute_phase_fxn */
-		DBC_REQUIRE(token);
 		token_len =3D strlen(token);
 		gen_obj->obj_data.node_obj.str_execute_phase_fxn =3D
 					kzalloc(token_len + 1, GFP_KERNEL);
@@ -1189,7 +1116,6 @@ static int get_attrs_from_buf(char *psz_buf, u32 =
ul_buf_size,
 		token =3D strsep(&psz_cur, seps);
=20
 		/* char *str_delete_phase_fxn */
-		DBC_REQUIRE(token);
 		token_len =3D strlen(token);
 		gen_obj->obj_data.node_obj.str_delete_phase_fxn =3D
 					kzalloc(token_len + 1, GFP_KERNEL);
@@ -1421,12 +1347,6 @@ static int get_dep_lib_info(struct dcd_manager *=
hdcd_mgr,
 	u16 dep_libs =3D 0;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
-	DBC_REQUIRE(hdcd_mgr);
-	DBC_REQUIRE(num_libs !=3D NULL);
-	DBC_REQUIRE(uuid_obj !=3D NULL);
-
 	/*  Initialize to 0 dependent libraries, if only counting number of
 	 *  dependent libraries */
 	if (!get_uuids) {
diff --git a/drivers/staging/tidspbridge/rmgr/disp.c b/drivers/staging/=
tidspbridge/rmgr/disp.c
index a9aa22f..04c88a7 100644
--- a/drivers/staging/tidspbridge/rmgr/disp.c
+++ b/drivers/staging/tidspbridge/rmgr/disp.c
@@ -96,11 +96,6 @@ int disp_create(struct disp_object **dispatch_obj,
 	int status =3D 0;
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dispatch_obj !=3D NULL);
-	DBC_REQUIRE(disp_attrs !=3D NULL);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-
 	*dispatch_obj =3D NULL;
=20
 	/* Allocate Node Dispatcher object */
@@ -168,8 +163,6 @@ func_cont:
 	else
 		delete_disp(disp_obj);
=20
-	DBC_ENSURE((status && *dispatch_obj =3D=3D NULL) ||
-				(!status && *dispatch_obj));
 	return status;
 }
=20
@@ -179,9 +172,6 @@ func_cont:
  */
 void disp_delete(struct disp_object *disp_obj)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(disp_obj);
-
 	delete_disp(disp_obj);
 }
=20
@@ -191,11 +181,7 @@ void disp_delete(struct disp_object *disp_obj)
  */
 void disp_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -206,12 +192,9 @@ bool disp_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
 	return ret;
 }
=20
@@ -227,10 +210,6 @@ int disp_node_change_priority(struct disp_object *=
disp_obj,
 	struct rms_command *rms_cmd;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(disp_obj);
-	DBC_REQUIRE(hnode !=3D NULL);
-
 	/* Send message to RMS to change priority */
 	rms_cmd =3D (struct rms_command *)(disp_obj->buf);
 	rms_cmd->fxn =3D (rms_word) (rms_fxn);
@@ -276,12 +255,6 @@ int disp_node_create(struct disp_object *disp_obj,
 	struct dsp_nodeinfo node_info;
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(disp_obj);
-	DBC_REQUIRE(hnode !=3D NULL);
-	DBC_REQUIRE(node_get_type(hnode) !=3D NODE_DEVICE);
-	DBC_REQUIRE(node_env !=3D NULL);
-
 	status =3D dev_get_dev_type(disp_obj->dev_obj, &dev_type);
=20
 	if (status)
@@ -292,7 +265,6 @@ int disp_node_create(struct disp_object *disp_obj,
 			__func__, dev_type);
 		goto func_end;
 	}
-	DBC_REQUIRE(pargs !=3D NULL);
 	node_type =3D node_get_type(hnode);
 	node_msg_args =3D pargs->asa.node_msg_args;
 	max =3D disp_obj->bufsize_rms;	/*Max # of RMS words that can be sent =
*/
@@ -480,10 +452,6 @@ int disp_node_delete(struct disp_object *disp_obj,
 	int status =3D 0;
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(disp_obj);
-	DBC_REQUIRE(hnode !=3D NULL);
-
 	status =3D dev_get_dev_type(disp_obj->dev_obj, &dev_type);
=20
 	if (!status) {
@@ -521,9 +489,6 @@ int disp_node_run(struct disp_object *disp_obj,
 	struct rms_command *rms_cmd;
 	int status =3D 0;
 	u8 dev_type;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(disp_obj);
-	DBC_REQUIRE(hnode !=3D NULL);
=20
 	status =3D dev_get_dev_type(disp_obj->dev_obj, &dev_type);
=20
@@ -620,7 +585,6 @@ static int fill_stream_def(rms_word *pdw_buf, u32 *=
ptotal, u32 offset,
 		 *  1 from total.
 		 */
 		total +=3D sizeof(struct rms_strm_def) / sizeof(rms_word) - 1;
-		DBC_REQUIRE(strm_def.sz_device);
 		dw_length =3D strlen(strm_def.sz_device) + 1;
=20
 		/* Number of RMS_WORDS needed to hold device name */
@@ -659,8 +623,6 @@ static int send_message(struct disp_object *disp_ob=
j, u32 timeout,
 	struct chnl_ioc chnl_ioc_obj;
 	int status =3D 0;
=20
-	DBC_REQUIRE(pdw_arg !=3D NULL);
-
 	*pdw_arg =3D (u32) NULL;
 	intf_fxns =3D disp_obj->intf_fxns;
 	chnl_obj =3D disp_obj->chnl_to_dsp;
diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/t=
idspbridge/rmgr/drv.c
index db8215f..f3bff1b 100644
--- a/drivers/staging/tidspbridge/rmgr/drv.c
+++ b/drivers/staging/tidspbridge/rmgr/drv.c
@@ -308,9 +308,6 @@ int drv_create(struct drv_object **drv_obj)
 	struct drv_object *pdrv_object =3D NULL;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(drv_obj !=3D NULL);
-	DBC_REQUIRE(refs > 0);
-
 	pdrv_object =3D kzalloc(sizeof(struct drv_object), GFP_KERNEL);
 	if (pdrv_object) {
 		/* Create and Initialize List of device objects */
@@ -336,7 +333,6 @@ int drv_create(struct drv_object **drv_obj)
 		kfree(pdrv_object);
 	}
=20
-	DBC_ENSURE(status || pdrv_object);
 	return status;
 }
=20
@@ -347,11 +343,7 @@ int drv_create(struct drv_object **drv_obj)
  */
 void drv_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -365,9 +357,6 @@ int drv_destroy(struct drv_object *driver_obj)
 	struct drv_object *pdrv_object =3D (struct drv_object *)driver_obj;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pdrv_object);
-
 	kfree(pdrv_object);
 	/* Update the DRV Object in the driver data */
 	if (drv_datap) {
@@ -395,10 +384,6 @@ int drv_get_dev_object(u32 index, struct drv_objec=
t *hdrv_obj,
 #endif
 	struct dev_object *dev_obj;
 	u32 i;
-	DBC_REQUIRE(pdrv_obj);
-	DBC_REQUIRE(device_obj !=3D NULL);
-	DBC_REQUIRE(index >=3D 0);
-	DBC_REQUIRE(refs > 0);
 	DBC_ASSERT(!(list_empty(&pdrv_obj->dev_list)));
=20
 	dev_obj =3D (struct dev_object *)drv_get_first_dev_object();
@@ -532,13 +517,9 @@ int drv_init(void)
 {
 	s32 ret =3D 1;		/* function return value */
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -552,10 +533,6 @@ int drv_insert_dev_object(struct drv_object *drive=
r_obj,
 {
 	struct drv_object *pdrv_object =3D (struct drv_object *)driver_obj;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-	DBC_REQUIRE(pdrv_object);
-
 	list_add_tail((struct list_head *)hdev_obj, &pdrv_object->dev_list);
=20
 	return 0;
@@ -574,12 +551,6 @@ int drv_remove_dev_object(struct drv_object *drive=
r_obj,
 	struct drv_object *pdrv_object =3D (struct drv_object *)driver_obj;
 	struct list_head *cur_elem;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pdrv_object);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-
-	DBC_REQUIRE(!list_empty(&pdrv_object->dev_list));
-
 	/* Search list for p_proc_object: */
 	list_for_each(cur_elem, &pdrv_object->dev_list) {
 		/* If found, remove it. */
@@ -605,9 +576,6 @@ int drv_request_resources(u32 dw_context, u32 *dev_=
node_strg)
 	struct drv_ext *pszdev_node;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(dw_context !=3D 0);
-	DBC_REQUIRE(dev_node_strg !=3D NULL);
-
 	/*
 	 *  Allocate memory to hold the string. This will live until
 	 *  it is freed in the Release resources. Update the driver object
@@ -639,10 +607,6 @@ int drv_request_resources(u32 dw_context, u32 *dev=
_node_strg)
 		*dev_node_strg =3D 0;
 	}
=20
-	DBC_ENSURE((!status && dev_node_strg !=3D NULL &&
-		    !list_empty(&pdrv_object->dev_node_string)) ||
-		   (status && *dev_node_strg =3D=3D 0));
-
 	return status;
 }
=20
@@ -900,8 +864,6 @@ void *mem_alloc_phys_mem(u32 byte_size, u32 align_m=
ask,
 void mem_free_phys_mem(void *virtual_address, u32 physical_address,
 		       u32 byte_size)
 {
-	DBC_REQUIRE(virtual_address !=3D NULL);
-
 	if (!ext_phys_mem_pool_enabled)
 		dma_free_coherent(NULL, byte_size, virtual_address,
 				  physical_address);
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 93fc862..34730de 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -212,7 +212,6 @@ static long bridge_ioctl(struct file *filp, unsigne=
d int code,
 	u32 retval =3D 0;
 	union trapped_args buf_in;
=20
-	DBC_REQUIRE(filp !=3D NULL);
 #ifdef CONFIG_TIDSPBRIDGE_RECOVERY
 	if (recover) {
 		status =3D -EIO;
diff --git a/drivers/staging/tidspbridge/rmgr/dspdrv.c b/drivers/stagin=
g/tidspbridge/rmgr/dspdrv.c
index 7a6fc73..5d25763 100644
--- a/drivers/staging/tidspbridge/rmgr/dspdrv.c
+++ b/drivers/staging/tidspbridge/rmgr/dspdrv.c
@@ -102,8 +102,6 @@ func_cont:
 	} else {
 		dev_dbg(bridge, "%s: Failed\n", __func__);
 	}			/* End api_init_complete2 */
-	DBC_ENSURE((!status && drv_obj !=3D NULL) ||
-		   (status && drv_obj =3D=3D NULL));
 	*init_status =3D status;
 	/* Return the Driver Object */
 	return (u32) drv_obj;
diff --git a/drivers/staging/tidspbridge/rmgr/mgr.c b/drivers/staging/t=
idspbridge/rmgr/mgr.c
index d635c01..1dca953 100644
--- a/drivers/staging/tidspbridge/rmgr/mgr.c
+++ b/drivers/staging/tidspbridge/rmgr/mgr.c
@@ -62,9 +62,6 @@ int mgr_create(struct mgr_object **mgr_obj,
 	struct mgr_object *pmgr_obj =3D NULL;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(mgr_obj !=3D NULL);
-	DBC_REQUIRE(refs > 0);
-
 	pmgr_obj =3D kzalloc(sizeof(struct mgr_object), GFP_KERNEL);
 	if (pmgr_obj) {
 		status =3D dcd_create_manager(ZLDLLNAME, &pmgr_obj->dcd_mgr);
@@ -92,7 +89,6 @@ int mgr_create(struct mgr_object **mgr_obj,
 		status =3D -ENOMEM;
 	}
=20
-	DBC_ENSURE(status || pmgr_obj);
 	return status;
 }
=20
@@ -106,9 +102,6 @@ int mgr_destroy(struct mgr_object *hmgr_obj)
 	struct mgr_object *pmgr_obj =3D (struct mgr_object *)hmgr_obj;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hmgr_obj);
-
 	/* Free resources */
 	if (hmgr_obj->dcd_mgr)
 		dcd_destroy_manager(hmgr_obj->dcd_mgr);
@@ -140,11 +133,6 @@ int mgr_enum_node_info(u32 node_id, struct dsp_ndb=
props *pndb_props,
 	struct mgr_object *pmgr_obj =3D NULL;
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
=20
-	DBC_REQUIRE(pndb_props !=3D NULL);
-	DBC_REQUIRE(pu_num_nodes !=3D NULL);
-	DBC_REQUIRE(undb_props_size >=3D sizeof(struct dsp_ndbprops));
-	DBC_REQUIRE(refs > 0);
-
 	*pu_num_nodes =3D 0;
 	/* Get the Manager Object from the driver data */
 	if (!drv_datap || !drv_datap->mgr_object) {
@@ -205,11 +193,6 @@ int mgr_enum_processor_info(u32 processor_id,
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
 	bool proc_detect =3D false;
=20
-	DBC_REQUIRE(processor_info !=3D NULL);
-	DBC_REQUIRE(pu_num_procs !=3D NULL);
-	DBC_REQUIRE(processor_info_size >=3D sizeof(struct dsp_processorinfo)=
);
-	DBC_REQUIRE(refs > 0);
-
 	*pu_num_procs =3D 0;
=20
 	/* Retrieve the Object handle from the driver data */
@@ -310,12 +293,9 @@ func_end:
  */
 void mgr_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
 	refs--;
 	if (refs =3D=3D 0)
 		dcd_exit();
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -328,16 +308,11 @@ int mgr_get_dcd_handle(struct mgr_object *mgr_han=
dle,
 	int status =3D -EPERM;
 	struct mgr_object *pmgr_obj =3D (struct mgr_object *)mgr_handle;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dcd_handle !=3D NULL);
-
 	*dcd_handle =3D (u32) NULL;
 	if (pmgr_obj) {
 		*dcd_handle =3D (u32) pmgr_obj->dcd_mgr;
 		status =3D 0;
 	}
-	DBC_ENSURE((!status && *dcd_handle !=3D (u32) NULL) ||
-		   (status && *dcd_handle =3D=3D (u32) NULL));
=20
 	return status;
 }
@@ -351,8 +326,6 @@ bool mgr_init(void)
 	bool ret =3D true;
 	bool init_dcd =3D false;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (refs =3D=3D 0) {
 		init_dcd =3D dcd_init();	/*  DCD Module */
=20
@@ -363,8 +336,6 @@ bool mgr_init(void)
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -380,8 +351,6 @@ int mgr_wait_for_bridge_events(struct dsp_notificat=
ion **anotifications,
 	struct sync_object *sync_events[MAX_EVENTS];
 	u32 i;
=20
-	DBC_REQUIRE(count < MAX_EVENTS);
-
 	for (i =3D 0; i < count; i++)
 		sync_events[i] =3D anotifications[i]->handle;
=20
diff --git a/drivers/staging/tidspbridge/rmgr/nldr.c b/drivers/staging/=
tidspbridge/rmgr/nldr.c
index 0e70cba..6fb19ef 100644
--- a/drivers/staging/tidspbridge/rmgr/nldr.c
+++ b/drivers/staging/tidspbridge/rmgr/nldr.c
@@ -313,11 +313,6 @@ int nldr_allocate(struct nldr_object *nldr_obj, vo=
id *priv_ref,
 	struct nldr_nodeobject *nldr_node_obj =3D NULL;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(node_props !=3D NULL);
-	DBC_REQUIRE(nldr_nodeobj !=3D NULL);
-	DBC_REQUIRE(nldr_obj);
-
 	/* Initialize handle in case of failure */
 	*nldr_nodeobj =3D NULL;
 	/* Allocate node object */
@@ -398,8 +393,6 @@ int nldr_allocate(struct nldr_object *nldr_obj, voi=
d *priv_ref,
 	if (status && nldr_node_obj)
 		kfree(nldr_node_obj);
=20
-	DBC_ENSURE((!status && *nldr_nodeobj)
-		   || (status && *nldr_nodeobj =3D=3D NULL));
 	return status;
 }
=20
@@ -425,12 +418,6 @@ int nldr_create(struct nldr_object **nldr,
 	struct rmm_segment *rmm_segs =3D NULL;
 	u16 i;
 	int status =3D 0;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(nldr !=3D NULL);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-	DBC_REQUIRE(pattrs !=3D NULL);
-	DBC_REQUIRE(pattrs->ovly !=3D NULL);
-	DBC_REQUIRE(pattrs->write !=3D NULL);
=20
 	/* Allocate dynamic loader object */
 	nldr_obj =3D kzalloc(sizeof(struct nldr_object), GFP_KERNEL);
@@ -583,7 +570,6 @@ int nldr_create(struct nldr_object **nldr,
 		*nldr =3D NULL;
 	}
 	/* FIXME:Temp. Fix. Must be removed */
-	DBC_ENSURE((!status && *nldr) || (status && *nldr =3D=3D NULL));
 	return status;
 }
=20
@@ -595,8 +581,6 @@ void nldr_delete(struct nldr_object *nldr_obj)
 	struct ovly_sect *ovly_section;
 	struct ovly_sect *next;
 	u16 i;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(nldr_obj);
=20
 	nldr_obj->ldr_fxns.exit_fxn();
 	if (nldr_obj->rmm)
@@ -649,14 +633,10 @@ void nldr_delete(struct nldr_object *nldr_obj)
  */
 void nldr_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
=20
 	if (refs =3D=3D 0)
 		rmm_exit();
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -671,10 +651,6 @@ int nldr_get_fxn_addr(struct nldr_nodeobject *nldr=
_node_obj,
 	bool status1 =3D false;
 	s32 i =3D 0;
 	struct lib_node root =3D { NULL, 0, NULL };
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(nldr_node_obj);
-	DBC_REQUIRE(addr !=3D NULL);
-	DBC_REQUIRE(str_fxn !=3D NULL);
=20
 	nldr_obj =3D nldr_node_obj->nldr_obj;
 	/* Called from node_create(), node_delete(), or node_run(). */
@@ -760,7 +736,6 @@ int nldr_get_rmm_manager(struct nldr_object *nldr,
 {
 	int status =3D 0;
 	struct nldr_object *nldr_obj =3D nldr;
-	DBC_REQUIRE(rmm_mgr !=3D NULL);
=20
 	if (nldr) {
 		*rmm_mgr =3D nldr_obj->rmm;
@@ -769,8 +744,6 @@ int nldr_get_rmm_manager(struct nldr_object *nldr,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE(!status || (rmm_mgr !=3D NULL && *rmm_mgr =3D=3D NULL));
-
 	return status;
 }
=20
@@ -780,14 +753,11 @@ int nldr_get_rmm_manager(struct nldr_object *nldr=
,
  */
 bool nldr_init(void)
 {
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (refs =3D=3D 0)
 		rmm_init();
=20
 	refs++;
=20
-	DBC_ENSURE(refs > 0);
 	return true;
 }
=20
@@ -801,9 +771,6 @@ int nldr_load(struct nldr_nodeobject *nldr_node_obj=
,
 	struct dsp_uuid lib_uuid;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(nldr_node_obj);
-
 	nldr_obj =3D nldr_node_obj->nldr_obj;
=20
 	if (nldr_node_obj->dynamic) {
@@ -863,9 +830,6 @@ int nldr_unload(struct nldr_nodeobject *nldr_node_o=
bj,
 	struct lib_node *root_lib =3D NULL;
 	s32 i =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(nldr_node_obj);
-
 	if (nldr_node_obj !=3D NULL) {
 		if (nldr_node_obj->dynamic) {
 			if (*nldr_node_obj->phase_split) {
@@ -929,7 +893,6 @@ static int add_ovly_info(void *handle, struct dbll_=
sect_info *sect_info,
 	/* Find the node it belongs to */
 	for (i =3D 0; i < nldr_obj->ovly_nodes; i++) {
 		node_name =3D nldr_obj->ovly_table[i].node_name;
-		DBC_REQUIRE(node_name);
 		if (strncmp(node_name, sect_name + 1, strlen(node_name)) =3D=3D 0) {
 			/* Found the node */
 			break;
@@ -1018,8 +981,6 @@ static int add_ovly_node(struct dsp_uuid *uuid_obj=
,
 			/* Add node to table */
 			nldr_obj->ovly_table[nldr_obj->ovly_nid].uuid =3D
 			    *uuid_obj;
-			DBC_REQUIRE(obj_def.obj_data.node_obj.ndb_props.
-				    ac_name);
 			len =3D
 			    strlen(obj_def.obj_data.node_obj.ndb_props.ac_name);
 			node_name =3D obj_def.obj_data.node_obj.ndb_props.ac_name;
@@ -1623,9 +1584,6 @@ static int remote_alloc(void **ref, u16 mem_sect,=
 u32 size,
 	struct rmm_addr *rmm_addr_obj =3D (struct rmm_addr *)dsp_address;
 	bool mem_load_req =3D false;
 	int status =3D -ENOMEM;	/* Set to fail */
-	DBC_REQUIRE(hnode);
-	DBC_REQUIRE(mem_sect =3D=3D DBLL_CODE || mem_sect =3D=3D DBLL_DATA ||
-		    mem_sect =3D=3D DBLL_BSS);
 	nldr_obj =3D hnode->nldr_obj;
 	rmm =3D nldr_obj->rmm;
 	/* Convert size to DSP words */
@@ -1736,8 +1694,6 @@ static int remote_free(void **ref, u16 space, u32=
 dsp_address,
 	u32 word_size;
 	int status =3D -ENOMEM;	/* Set to fail */
=20
-	DBC_REQUIRE(nldr_obj);
-
 	rmm =3D nldr_obj->rmm;
=20
 	/* Convert size to DSP words */
@@ -1897,9 +1853,6 @@ int nldr_find_addr(struct nldr_nodeobject *nldr_n=
ode, u32 sym_addr,
 	bool status1 =3D false;
 	s32 i =3D 0;
 	struct lib_node root =3D { NULL, 0, NULL };
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(offset_output !=3D NULL);
-	DBC_REQUIRE(sym_name !=3D NULL);
 	pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__, (u32) nldr_no=
de,
 			sym_addr, offset_range, (u32) offset_output, sym_name);
=20
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/=
tidspbridge/rmgr/node.c
index 5dadaa4..d23d1d0 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -326,11 +326,6 @@ int node_allocate(struct proc_object *hprocessor,
=20
 	void *node_res;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hprocessor !=3D NULL);
-	DBC_REQUIRE(noderes !=3D NULL);
-	DBC_REQUIRE(node_uuid !=3D NULL);
-
 	*noderes =3D NULL;
=20
 	status =3D proc_get_processor_id(hprocessor, &proc_id);
@@ -673,7 +668,6 @@ func_cont:
 		drv_proc_node_update_heap_status(node_res, true);
 		drv_proc_node_update_status(node_res, true);
 	}
-	DBC_ENSURE((status && *noderes =3D=3D NULL) || (!status && *noderes))=
;
 func_end:
 	dev_dbg(bridge, "%s: hprocessor: %p pNodeId: %p pargs: %p attr_in: %p=
 "
 		"node_res: %p status: 0x%x\n", __func__, hprocessor,
@@ -696,11 +690,6 @@ DBAPI node_alloc_msg_buf(struct node_object *hnode=
, u32 usize,
 	bool set_info;
 	u32 proc_id;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pbuffer !=3D NULL);
-
-	DBC_REQUIRE(usize > 0);
-
 	if (!pnode)
 		status =3D -EFAULT;
 	else if (node_get_type(pnode) =3D=3D NODE_DEVICE)
@@ -782,8 +771,6 @@ int node_change_priority(struct node_object *hnode,=
 s32 prio)
 	int status =3D 0;
 	u32 proc_id;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!hnode || !hnode->node_mgr) {
 		status =3D -EFAULT;
 	} else {
@@ -854,7 +841,6 @@ int node_connect(struct node_object *node1, u32 str=
eam1,
 	s8 chnl_mode;
 	u32 dw_length;
 	int status =3D 0;
-	DBC_REQUIRE(refs > 0);
=20
 	if (!node1 || !node2)
 		return -EFAULT;
@@ -1139,7 +1125,6 @@ int node_create(struct node_object *hnode)
 	    omap_dspbridge_dev->dev.platform_data;
 #endif
=20
-	DBC_REQUIRE(refs > 0);
 	if (!pnode) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -1291,10 +1276,6 @@ int node_create_mgr(struct node_mgr **node_man,
 	int status =3D 0;
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(node_man !=3D NULL);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-
 	*node_man =3D NULL;
 	/* Allocate Node manager object */
 	node_mgr_obj =3D kzalloc(sizeof(struct node_mgr), GFP_KERNEL);
@@ -1375,8 +1356,6 @@ int node_create_mgr(struct node_mgr **node_man,
=20
 	*node_man =3D node_mgr_obj;
=20
-	DBC_ENSURE((status && *node_man =3D=3D NULL) || (!status && *node_man=
));
-
 	return status;
 out_err:
 	delete_node_mgr(node_mgr_obj);
@@ -1409,7 +1388,6 @@ int node_delete(struct node_res_object *noderes,
 	void *node_res =3D noderes;
=20
 	struct dsp_processorstate proc_state;
-	DBC_REQUIRE(refs > 0);
=20
 	if (!pnode) {
 		status =3D -EFAULT;
@@ -1554,8 +1532,6 @@ func_end:
  */
 int node_delete_mgr(struct node_mgr *hnode_mgr)
 {
-	DBC_REQUIRE(refs > 0);
-
 	if (!hnode_mgr)
 		return -EFAULT;
=20
@@ -1576,10 +1552,6 @@ int node_enum_nodes(struct node_mgr *hnode_mgr, =
void **node_tab,
 	struct node_object *hnode;
 	u32 i =3D 0;
 	int status =3D 0;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(node_tab !=3D NULL || node_tab_size =3D=3D 0);
-	DBC_REQUIRE(pu_num_nodes !=3D NULL);
-	DBC_REQUIRE(pu_allocated !=3D NULL);
=20
 	if (!hnode_mgr) {
 		status =3D -EFAULT;
@@ -1611,11 +1583,7 @@ func_end:
  */
 void node_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -1629,10 +1597,6 @@ int node_free_msg_buf(struct node_object *hnode,=
 u8 * pbuffer,
 	struct node_object *pnode =3D (struct node_object *)hnode;
 	int status =3D 0;
 	u32 proc_id;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pbuffer !=3D NULL);
-	DBC_REQUIRE(pnode !=3D NULL);
-	DBC_REQUIRE(pnode->xlator !=3D NULL);
=20
 	if (!hnode) {
 		status =3D -EFAULT;
@@ -1669,9 +1633,6 @@ int node_get_attr(struct node_object *hnode,
 			 struct dsp_nodeattr *pattr, u32 attr_size)
 {
 	struct node_mgr *hnode_mgr;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pattr !=3D NULL);
-	DBC_REQUIRE(attr_size >=3D sizeof(struct dsp_nodeattr));
=20
 	if (!hnode)
 		return -EFAULT;
@@ -1713,9 +1674,6 @@ int node_get_channel_id(struct node_object *hnode=
, u32 dir, u32 index,
 {
 	enum node_type node_type;
 	int status =3D -EINVAL;
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dir =3D=3D DSP_TONODE || dir =3D=3D DSP_FROMNODE);
-	DBC_REQUIRE(chan_id !=3D NULL);
=20
 	if (!hnode) {
 		status =3D -EFAULT;
@@ -1761,9 +1719,6 @@ int node_get_message(struct node_object *hnode,
 	struct dsp_processorstate proc_state;
 	struct proc_object *hprocessor;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(message !=3D NULL);
-
 	if (!hnode) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -1831,14 +1786,12 @@ int node_get_nldr_obj(struct node_mgr *hnode_mg=
r,
 {
 	int status =3D 0;
 	struct node_mgr *node_mgr_obj =3D hnode_mgr;
-	DBC_REQUIRE(nldr_ovlyobj !=3D NULL);
=20
 	if (!hnode_mgr)
 		status =3D -EFAULT;
 	else
 		*nldr_ovlyobj =3D node_mgr_obj->nldr_obj;
=20
-	DBC_ENSURE(!status || (nldr_ovlyobj !=3D NULL && *nldr_ovlyobj =3D=3D=
 NULL));
 	return status;
 }
=20
@@ -1852,8 +1805,6 @@ int node_get_strm_mgr(struct node_object *hnode,
 {
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!hnode)
 		status =3D -EFAULT;
 	else
@@ -1867,8 +1818,6 @@ int node_get_strm_mgr(struct node_object *hnode,
  */
 enum nldr_loadtype node_get_load_type(struct node_object *hnode)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hnode);
 	if (!hnode) {
 		dev_dbg(bridge, "%s: Failed. hnode: %p\n", __func__, hnode);
 		return -1;
@@ -1884,8 +1833,6 @@ enum nldr_loadtype node_get_load_type(struct node=
_object *hnode)
  */
 u32 node_get_timeout(struct node_object *hnode)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hnode);
 	if (!hnode) {
 		dev_dbg(bridge, "%s: failed. hnode: %p\n", __func__, hnode);
 		return 0;
@@ -1921,8 +1868,6 @@ enum node_type node_get_type(struct node_object *=
hnode)
  */
 bool node_init(void)
 {
-	DBC_REQUIRE(refs >=3D 0);
-
 	refs++;
=20
 	return true;
@@ -1970,8 +1915,6 @@ int node_pause(struct node_object *hnode)
 	struct dsp_processorstate proc_state;
 	struct proc_object *hprocessor;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!hnode) {
 		status =3D -EFAULT;
 	} else {
@@ -2054,9 +1997,6 @@ int node_put_message(struct node_object *hnode,
 	struct dsp_processorstate proc_state;
 	struct proc_object *hprocessor;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pmsg !=3D NULL);
-
 	if (!hnode) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -2146,9 +2086,6 @@ int node_register_notify(struct node_object *hnod=
e, u32 event_mask,
 	struct bridge_drv_interface *intf_fxns;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hnotification !=3D NULL);
-
 	if (!hnode) {
 		status =3D -EFAULT;
 	} else {
@@ -2207,8 +2144,6 @@ int node_run(struct node_object *hnode)
 	struct dsp_processorstate proc_state;
 	struct proc_object *hprocessor;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!hnode) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -2326,9 +2261,6 @@ int node_terminate(struct node_object *hnode, int=
 *pstatus)
 	struct deh_mgr *hdeh_mgr;
 	struct dsp_processorstate proc_state;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pstatus !=3D NULL);
-
 	if (!hnode || !hnode->node_mgr) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -2748,9 +2680,6 @@ static int get_fxn_address(struct node_object *hn=
ode, u32 * fxn_addr,
 	char *pstr_fxn_name =3D NULL;
 	struct node_mgr *hnode_mgr =3D hnode->node_mgr;
 	int status =3D 0;
-	DBC_REQUIRE(node_get_type(hnode) =3D=3D NODE_TASK ||
-		    node_get_type(hnode) =3D=3D NODE_DAISSOCKET ||
-		    node_get_type(hnode) =3D=3D NODE_MESSAGE);
=20
 	switch (phase) {
 	case CREATEPHASE:
@@ -2787,9 +2716,6 @@ void get_node_info(struct node_object *hnode, str=
uct dsp_nodeinfo *node_info)
 {
 	u32 i;
=20
-	DBC_REQUIRE(hnode);
-	DBC_REQUIRE(node_info !=3D NULL);
-
 	node_info->cb_struct =3D sizeof(struct dsp_nodeinfo);
 	node_info->nb_node_database_props =3D
 	    hnode->dcd_props.obj_data.node_obj.ndb_props;
@@ -2848,7 +2774,6 @@ static int get_node_props(struct dcd_manager *hdc=
d_mgr,
 				pmsg_args->max_msgs);
 		} else {
 			/* Copy device name */
-			DBC_REQUIRE(pndb_props->ac_name);
 			len =3D strlen(pndb_props->ac_name);
 			DBC_ASSERT(len < MAXDEVNAMELEN);
 			hnode->str_dev_name =3D kzalloc(len + 1, GFP_KERNEL);
@@ -2938,10 +2863,6 @@ int node_get_uuid_props(void *hprocessor,
 	struct dcd_nodeprops dcd_node_props;
 	struct dsp_processorstate proc_state;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hprocessor !=3D NULL);
-	DBC_REQUIRE(node_uuid !=3D NULL);
-
 	if (hprocessor =3D=3D NULL || node_uuid =3D=3D NULL) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -3063,8 +2984,6 @@ static u32 ovly(void *priv_ref, u32 dsp_run_addr,=
 u32 dsp_load_addr,
 	/* Function interface to Bridge driver*/
 	struct bridge_drv_interface *intf_fxns;
=20
-	DBC_REQUIRE(hnode);
-
 	hnode_mgr =3D hnode->node_mgr;
=20
 	ul_size =3D ul_num_bytes / hnode_mgr->dsp_word_size;
@@ -3106,9 +3025,6 @@ static u32 mem_write(void *priv_ref, u32 dsp_add,=
 void *pbuf,
 	/* Function interface to Bridge driver */
 	struct bridge_drv_interface *intf_fxns;
=20
-	DBC_REQUIRE(hnode);
-	DBC_REQUIRE(mem_space & DBLL_CODE || mem_space & DBLL_DATA);
-
 	hnode_mgr =3D hnode->node_mgr;
=20
 	ul_timeout =3D hnode->timeout;
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/=
tidspbridge/rmgr/proc.c
index 242dd13..4e2f2e4 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -281,9 +281,6 @@ proc_attach(u32 processor_id,
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(ph_processor !=3D NULL);
-
 	if (pr_ctxt->processor) {
 		*ph_processor =3D pr_ctxt->processor;
 		return status;
@@ -382,10 +379,6 @@ proc_attach(u32 processor_id,
 		kfree(p_proc_object);
 	}
 func_end:
-	DBC_ENSURE((status =3D=3D -EPERM && *ph_processor =3D=3D NULL) ||
-		   (!status && p_proc_object) ||
-		   (status =3D=3D 0 && p_proc_object));
-
 	return status;
 }
=20
@@ -445,10 +438,6 @@ int proc_auto_start(struct cfg_devnode *dev_node_o=
bj,
 	struct drv_data *drv_datap =3D dev_get_drvdata(bridge);
 	u8 dev_type;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(dev_node_obj !=3D NULL);
-	DBC_REQUIRE(hdev_obj !=3D NULL);
-
 	/* Create a Dummy PROC Object */
 	if (!drv_datap || !drv_datap->mgr_object) {
 		status =3D -ENODATA;
@@ -516,8 +505,6 @@ int proc_ctrl(void *hprocessor, u32 dw_cmd, struct =
dsp_cbdata * arg)
 	struct proc_object *p_proc_object =3D hprocessor;
 	u32 timeout =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (p_proc_object) {
 		/* intercept PWR deep sleep command */
 		if (dw_cmd =3D=3D BRDIOCTL_DEEPSLEEP) {
@@ -565,8 +552,6 @@ int proc_detach(struct process_context *pr_ctxt)
 	int status =3D 0;
 	struct proc_object *p_proc_object =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-
 	p_proc_object =3D (struct proc_object *)pr_ctxt->processor;
=20
 	if (p_proc_object) {
@@ -607,11 +592,6 @@ int proc_enum_nodes(void *hprocessor, void **node_=
tab,
 	struct proc_object *p_proc_object =3D (struct proc_object *)hprocesso=
r;
 	struct node_mgr *hnode_mgr =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(node_tab !=3D NULL || node_tab_size =3D=3D 0);
-	DBC_REQUIRE(pu_num_nodes !=3D NULL);
-	DBC_REQUIRE(pu_allocated !=3D NULL);
-
 	if (p_proc_object) {
 		if (!(dev_get_node_manager(p_proc_object->dev_obj,
 						       &hnode_mgr))) {
@@ -768,8 +748,6 @@ int proc_begin_dma(void *hprocessor, void *pmpu_add=
r, u32 ul_size,
 	struct process_context *pr_ctxt =3D (struct process_context *) hproce=
ssor;
 	struct dmm_map_object *map_obj;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!pr_ctxt) {
 		status =3D -EFAULT;
 		goto err_out;
@@ -810,8 +788,6 @@ int proc_end_dma(void *hprocessor, void *pmpu_addr,=
 u32 ul_size,
 	struct process_context *pr_ctxt =3D (struct process_context *) hproce=
ssor;
 	struct dmm_map_object *map_obj;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!pr_ctxt) {
 		status =3D -EFAULT;
 		goto err_out;
@@ -884,10 +860,6 @@ int proc_get_resource_info(void *hprocessor, u32 r=
esource_type,
 	struct rmm_target_obj *rmm =3D NULL;
 	struct io_mgr *hio_mgr =3D NULL;	/* IO manager handle */
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(resource_info !=3D NULL);
-	DBC_REQUIRE(resource_info_size >=3D sizeof(struct dsp_resourceinfo));
-
 	if (!p_proc_object) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -947,11 +919,7 @@ func_end:
  */
 void proc_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -966,9 +934,6 @@ int proc_get_dev_object(void *hprocessor,
 	int status =3D -EPERM;
 	struct proc_object *p_proc_object =3D (struct proc_object *)hprocesso=
r;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(device_obj !=3D NULL);
-
 	if (p_proc_object) {
 		*device_obj =3D p_proc_object->dev_obj;
 		status =3D 0;
@@ -977,9 +942,6 @@ int proc_get_dev_object(void *hprocessor,
 		status =3D -EFAULT;
 	}
=20
-	DBC_ENSURE((!status && *device_obj !=3D NULL) ||
-		   (status && *device_obj =3D=3D NULL));
-
 	return status;
 }
=20
@@ -996,10 +958,6 @@ int proc_get_state(void *hprocessor,
 	struct proc_object *p_proc_object =3D (struct proc_object *)hprocesso=
r;
 	int brd_status;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(proc_state_obj !=3D NULL);
-	DBC_REQUIRE(state_info_size >=3D sizeof(struct dsp_processorstate));
-
 	if (p_proc_object) {
 		/* First, retrieve BRD state information */
 		status =3D (*p_proc_object->intf_fxns->brd_status)
@@ -1063,13 +1021,9 @@ bool proc_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -1111,10 +1065,6 @@ int proc_load(void *hprocessor, const s32 argc_i=
ndex,
 	    omap_dspbridge_dev->dev.platform_data;
 #endif
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(argc_index > 0);
-	DBC_REQUIRE(user_args !=3D NULL);
-
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv1);
 #endif
@@ -1331,9 +1281,6 @@ func_end:
 		pr_err("%s: Processor failed to load\n", __func__);
 		proc_stop(p_proc_object);
 	}
-	DBC_ENSURE((!status
-		    && p_proc_object->proc_state =3D=3D PROC_LOADED)
-		   || status);
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv2);
 	if (tv2.tv_usec < tv1.tv_usec) {
@@ -1443,9 +1390,6 @@ int proc_register_notify(void *hprocessor, u32 ev=
ent_mask,
 	struct proc_object *p_proc_object =3D (struct proc_object *)hprocesso=
r;
 	struct deh_mgr *hdeh_mgr;
=20
-	DBC_REQUIRE(hnotification !=3D NULL);
-	DBC_REQUIRE(refs > 0);
-
 	/* Check processor handle */
 	if (!p_proc_object) {
 		status =3D -EFAULT;
@@ -1567,7 +1511,6 @@ int proc_start(void *hprocessor)
 	u32 dw_dsp_addr;	/* Loaded code's entry point. */
 	int brd_state;
=20
-	DBC_REQUIRE(refs > 0);
 	if (!p_proc_object) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -1624,8 +1567,6 @@ func_cont:
 	}
=20
 func_end:
-	DBC_ENSURE((!status && p_proc_object->proc_state =3D=3D
-		    PROC_RUNNING) || status);
 	return status;
 }
=20
@@ -1646,7 +1587,6 @@ int proc_stop(void *hprocessor)
 	u32 nodes_allocated =3D 0;
 	int brd_state;
=20
-	DBC_REQUIRE(refs > 0);
 	if (!p_proc_object) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -1822,9 +1762,6 @@ static int proc_monitor(struct proc_object *proc_=
obj)
 	struct msg_mgr *hmsg_mgr;
 	int brd_state;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(proc_obj);
-
 	/* This is needed only when Device is loaded when it is
 	 * already 'ACTIVE' */
 	/* Destroy the Node Manager, msg_ctrl Manager */
@@ -1845,8 +1782,6 @@ static int proc_monitor(struct proc_object *proc_=
obj)
 			DBC_ASSERT(brd_state =3D=3D BRD_IDLE);
 	}
=20
-	DBC_ENSURE((!status && brd_state =3D=3D BRD_IDLE) ||
-		   status);
 	return status;
 }
=20
@@ -1880,8 +1815,6 @@ static char **prepend_envp(char **new_envp, char =
**envp, s32 envp_elems,
 {
 	char **pp_envp =3D new_envp;
=20
-	DBC_REQUIRE(new_envp);
-
 	/* Prepend new environ var=3Dvalue string */
 	*new_envp++ =3D sz_var;
=20
@@ -1906,9 +1839,6 @@ int proc_notify_clients(void *proc, u32 events)
 	int status =3D 0;
 	struct proc_object *p_proc_object =3D (struct proc_object *)proc;
=20
-	DBC_REQUIRE(p_proc_object);
-	DBC_REQUIRE(is_valid_proc_event(events));
-	DBC_REQUIRE(refs > 0);
 	if (!p_proc_object) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -1930,9 +1860,6 @@ int proc_notify_all_clients(void *proc, u32 event=
s)
 	int status =3D 0;
 	struct proc_object *p_proc_object =3D (struct proc_object *)proc;
=20
-	DBC_REQUIRE(is_valid_proc_event(events));
-	DBC_REQUIRE(refs > 0);
-
 	if (!p_proc_object) {
 		status =3D -EFAULT;
 		goto func_end;
diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/t=
idspbridge/rmgr/rmm.c
index f3dc0dd..6b41049 100644
--- a/drivers/staging/tidspbridge/rmgr/rmm.c
+++ b/drivers/staging/tidspbridge/rmgr/rmm.c
@@ -101,12 +101,6 @@ int rmm_alloc(struct rmm_target_obj *target, u32 s=
egid, u32 size,
 	u32 addr;
 	int status =3D 0;
=20
-	DBC_REQUIRE(target);
-	DBC_REQUIRE(dsp_address !=3D NULL);
-	DBC_REQUIRE(size > 0);
-	DBC_REQUIRE(reserve || (target->num_segs > 0));
-	DBC_REQUIRE(refs > 0);
-
 	if (!reserve) {
 		if (!alloc_block(target, segid, size, align, dsp_address)) {
 			status =3D -ENOMEM;
@@ -170,9 +164,6 @@ int rmm_create(struct rmm_target_obj **target_obj,
 	s32 i;
 	int status =3D 0;
=20
-	DBC_REQUIRE(target_obj !=3D NULL);
-	DBC_REQUIRE(num_segs =3D=3D 0 || seg_tab !=3D NULL);
-
 	/* Allocate DBL target object */
 	target =3D kzalloc(sizeof(struct rmm_target_obj), GFP_KERNEL);
=20
@@ -235,9 +226,6 @@ func_cont:
=20
 	}
=20
-	DBC_ENSURE((!status && *target_obj)
-		   || (status && *target_obj =3D=3D NULL));
-
 	return status;
 }
=20
@@ -251,8 +239,6 @@ void rmm_delete(struct rmm_target_obj *target)
 	struct rmm_header *next;
 	u32 i;
=20
-	DBC_REQUIRE(target);
-
 	kfree(target->seg_tab);
=20
 	list_for_each_entry_safe(sect, tmp, &target->ovly_list, list_elem) {
@@ -281,11 +267,7 @@ void rmm_delete(struct rmm_target_obj *target)
  */
 void rmm_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -297,15 +279,6 @@ bool rmm_free(struct rmm_target_obj *target, u32 s=
egid, u32 dsp_addr, u32 size,
 	struct rmm_ovly_sect *sect, *tmp;
 	bool ret =3D false;
=20
-	DBC_REQUIRE(target);
-
-	DBC_REQUIRE(reserved || segid < target->num_segs);
-	DBC_REQUIRE(reserved || (dsp_addr >=3D target->seg_tab[segid].base &&
-				 (dsp_addr + size) <=3D (target->seg_tab[segid].
-						   base +
-						   target->seg_tab[segid].
-						   length)));
-
 	/*
 	 *  Free or unreserve memory.
 	 */
@@ -335,8 +308,6 @@ bool rmm_free(struct rmm_target_obj *target, u32 se=
gid, u32 dsp_addr, u32 size,
  */
 bool rmm_init(void)
 {
-	DBC_REQUIRE(refs >=3D 0);
-
 	refs++;
=20
 	return true;
@@ -354,7 +325,6 @@ bool rmm_stat(struct rmm_target_obj *target, enum d=
sp_memtype segid,
 	u32 total_free_size =3D 0;
 	u32 free_blocks =3D 0;
=20
-	DBC_REQUIRE(mem_stat_buf !=3D NULL);
 	DBC_ASSERT(target !=3D NULL);
=20
 	if ((u32) segid < target->num_segs) {
diff --git a/drivers/staging/tidspbridge/rmgr/strm.c b/drivers/staging/=
tidspbridge/rmgr/strm.c
index 3fae0e9..8e2d649 100644
--- a/drivers/staging/tidspbridge/rmgr/strm.c
+++ b/drivers/staging/tidspbridge/rmgr/strm.c
@@ -104,9 +104,6 @@ int strm_allocate_buffer(struct strm_res_object *st=
rmres, u32 usize,
 	u32 i;
 	struct strm_object *stream_obj =3D strmres->stream;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(ap_buffer !=3D NULL);
-
 	if (stream_obj) {
 		/*
 		 * Allocate from segment specified at time of stream open.
@@ -156,8 +153,6 @@ int strm_close(struct strm_res_object *strmres,
 	int status =3D 0;
 	struct strm_object *stream_obj =3D strmres->stream;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 	} else {
@@ -180,9 +175,6 @@ int strm_close(struct strm_res_object *strmres,
=20
 	idr_remove(pr_ctxt->stream_id, strmres->id);
 func_end:
-	DBC_ENSURE(status =3D=3D 0 || status =3D=3D -EFAULT ||
-		   status =3D=3D -EPIPE || status =3D=3D -EPERM);
-
 	dev_dbg(bridge, "%s: stream_obj: %p, status 0x%x\n", __func__,
 		stream_obj, status);
 	return status;
@@ -199,10 +191,6 @@ int strm_create(struct strm_mgr **strm_man,
 	struct strm_mgr *strm_mgr_obj;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(strm_man !=3D NULL);
-	DBC_REQUIRE(dev_obj !=3D NULL);
-
 	*strm_man =3D NULL;
 	/* Allocate STRM manager object */
 	strm_mgr_obj =3D kzalloc(sizeof(struct strm_mgr), GFP_KERNEL);
@@ -226,8 +214,6 @@ int strm_create(struct strm_mgr **strm_man,
 	else
 		kfree(strm_mgr_obj);
=20
-	DBC_ENSURE((!status && *strm_man) || (status && *strm_man =3D=3D NULL=
));
-
 	return status;
 }
=20
@@ -238,9 +224,6 @@ int strm_create(struct strm_mgr **strm_man,
  */
 void strm_delete(struct strm_mgr *strm_mgr_obj)
 {
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(strm_mgr_obj);
-
 	kfree(strm_mgr_obj);
 }
=20
@@ -251,11 +234,7 @@ void strm_delete(struct strm_mgr *strm_mgr_obj)
  */
 void strm_exit(void)
 {
-	DBC_REQUIRE(refs > 0);
-
 	refs--;
-
-	DBC_ENSURE(refs >=3D 0);
 }
=20
 /*
@@ -270,9 +249,6 @@ int strm_free_buffer(struct strm_res_object *strmre=
s, u8 ** ap_buffer,
 	u32 i =3D 0;
 	struct strm_object *stream_obj =3D strmres->stream;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(ap_buffer !=3D NULL);
-
 	if (!stream_obj)
 		status =3D -EFAULT;
=20
@@ -306,10 +282,6 @@ int strm_get_info(struct strm_object *stream_obj,
 	int status =3D 0;
 	void *virt_base =3D NULL;	/* NULL if no SM used */
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(stream_info !=3D NULL);
-	DBC_REQUIRE(stream_info_size >=3D sizeof(struct stream_info));
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 	} else {
@@ -370,8 +342,6 @@ int strm_idle(struct strm_object *stream_obj, bool =
flush_data)
 	struct bridge_drv_interface *intf_fxns;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 	} else {
@@ -396,13 +366,9 @@ bool strm_init(void)
 {
 	bool ret =3D true;
=20
-	DBC_REQUIRE(refs >=3D 0);
-
 	if (ret)
 		refs++;
=20
-	DBC_ENSURE((ret && (refs > 0)) || (!ret && (refs >=3D 0)));
-
 	return ret;
 }
=20
@@ -418,9 +384,6 @@ int strm_issue(struct strm_object *stream_obj, u8 *=
pbuf, u32 ul_bytes,
 	int status =3D 0;
 	void *tmp_buf =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(pbuf !=3D NULL);
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 	} else {
@@ -471,9 +434,6 @@ int strm_open(struct node_object *hnode, u32 dir, u=
32 index,
=20
 	void *stream_res;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(strmres !=3D NULL);
-	DBC_REQUIRE(pattr !=3D NULL);
 	*strmres =3D NULL;
 	if (dir !=3D DSP_TONODE && dir !=3D DSP_FROMNODE) {
 		status =3D -EPERM;
@@ -594,12 +554,6 @@ func_cont:
 		(void)delete_strm(strm_obj);
 	}
=20
-	/* ensure we return a documented error code */
-	DBC_ENSURE((!status && strm_obj) ||
-		   (*strmres =3D=3D NULL && (status =3D=3D -EFAULT ||
-					status =3D=3D -EPERM
-					|| status =3D=3D -EINVAL)));
-
 	dev_dbg(bridge, "%s: hnode: %p dir: 0x%x index: 0x%x pattr: %p "
 		"strmres: %p status: 0x%x\n", __func__,
 		hnode, dir, index, pattr, strmres, status);
@@ -619,11 +573,6 @@ int strm_reclaim(struct strm_object *stream_obj, u=
8 ** buf_ptr,
 	int status =3D 0;
 	void *tmp_buf =3D NULL;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(buf_ptr !=3D NULL);
-	DBC_REQUIRE(nbytes !=3D NULL);
-	DBC_REQUIRE(pdw_arg !=3D NULL);
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 		goto func_end;
@@ -679,11 +628,6 @@ int strm_reclaim(struct strm_object *stream_obj, u=
8 ** buf_ptr,
 		*buf_ptr =3D chnl_ioc_obj.buf;
 	}
 func_end:
-	/* ensure we return a documented return code */
-	DBC_ENSURE(!status || status =3D=3D -EFAULT ||
-		   status =3D=3D -ETIME || status =3D=3D -ESRCH ||
-		   status =3D=3D -EPERM);
-
 	dev_dbg(bridge, "%s: stream_obj: %p buf_ptr: %p nbytes: %p "
 		"pdw_arg: %p status 0x%x\n", __func__, stream_obj,
 		buf_ptr, nbytes, pdw_arg, status);
@@ -702,9 +646,6 @@ int strm_register_notify(struct strm_object *stream=
_obj, u32 event_mask,
 	struct bridge_drv_interface *intf_fxns;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(hnotification !=3D NULL);
-
 	if (!stream_obj) {
 		status =3D -EFAULT;
 	} else if ((event_mask & ~((DSP_STREAMIOCOMPLETION) |
@@ -725,10 +666,7 @@ int strm_register_notify(struct strm_object *strea=
m_obj, u32 event_mask,
 							    notify_type,
 							    hnotification);
 	}
-	/* ensure we return a documented return code */
-	DBC_ENSURE(!status || status =3D=3D -EFAULT ||
-		   status =3D=3D -ETIME || status =3D=3D -ESRCH ||
-		   status =3D=3D -ENOSYS || status =3D=3D -EPERM);
+
 	return status;
 }
=20
@@ -747,11 +685,6 @@ int strm_select(struct strm_object **strm_tab, u32=
 strms,
 	u32 i;
 	int status =3D 0;
=20
-	DBC_REQUIRE(refs > 0);
-	DBC_REQUIRE(strm_tab !=3D NULL);
-	DBC_REQUIRE(pmask !=3D NULL);
-	DBC_REQUIRE(strms > 0);
-
 	*pmask =3D 0;
 	for (i =3D 0; i < strms; i++) {
 		if (!strm_tab[i]) {
@@ -811,9 +744,6 @@ int strm_select(struct strm_object **strm_tab, u32 =
strms,
 func_end:
 	kfree(sync_events);
=20
-	DBC_ENSURE((!status && (*pmask !=3D 0 || utimeout =3D=3D 0)) ||
-		   (status && *pmask =3D=3D 0));
-
 	return status;
 }
=20
--=20
1.7.8.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
