From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 21/40] DSPBRIDGE: err code replace DSP_EDYNLOAD with EILSEQ
Date: Thu,  3 Jun 2010 00:47:34 -0500
Message-ID: <1275544073-20418-22-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932463Ab0FCF4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:17 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EDYNLOAD with EILSEQ

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    8 ++++----
 drivers/dsp/bridge/rmgr/nldr.c                  |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 0e7e3c4..18a862f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -339,7 +339,7 @@ typedef bool(*dbll_init_fxn) (void);
  *      0:        Success.
  *      -EBADF:     File read failed.
  *      DSP_EFWRITE:    Write to target failed.
- *      DSP_EDYNLOAD:   Failure in dynamic loader library.
+ *      -EILSEQ:   Failure in dynamic loader library.
  *  Requires:
  *      DBL initialized.
  *      Valid lib.
diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index 008e12c..b93671b 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -249,7 +249,7 @@ typedef bool(*nldr_initfxn) (void);
  *      -ENOMEM:            Insufficient memory on GPP.
  *      DSP_EOVERLAYMEMORY:     Can't overlay phase because overlay memory
  *                              is already in use.
- *      DSP_EDYNLOAD:           Failure in dynamic loader library.
+ *      -EILSEQ:           Failure in dynamic loader library.
  *      DSP_EFWRITE:            Failed to write phase's code or date to target.
  *  Requires:
  *      nldr_init(void) called.
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 7e126a7..6a01f56 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -544,12 +544,12 @@ dsp_status dbll_load(struct dbll_library_obj *lib, dbll_flags flags,
 						  &zl_lib->dload_mod_obj);
 
 			if (err != 0) {
-				status = DSP_EDYNLOAD;
+				status = -EILSEQ;
 			} else if (redefined_symbol) {
 				zl_lib->load_ref++;
 				dbll_unload(zl_lib, (struct dbll_attrs *)attrs);
 				redefined_symbol = false;
-				status = DSP_EDYNLOAD;
+				status = -EILSEQ;
 			} else {
 				*pEntry = zl_lib->entry;
 			}
@@ -684,7 +684,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
 					  &zl_lib->init.dl_init, 0,
 					  &zl_lib->dload_mod_obj);
 		if (err != 0) {
-			status = DSP_EDYNLOAD;
+			status = -EILSEQ;
 		} else {
 			/* Now that we have the symbol table, we can unload */
 			err = dynamic_unload_module(zl_lib->dload_mod_obj,
@@ -692,7 +692,7 @@ dsp_status dbll_open(struct dbll_tar_obj *target, char *file, dbll_flags flags,
 						    &zl_lib->allocate.dl_alloc,
 						    &zl_lib->init.dl_init);
 			if (err != 0)
-				status = DSP_EDYNLOAD;
+				status = -EILSEQ;
 
 			zl_lib->dload_mod_obj = NULL;
 		}
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 8257a83..b6044e0 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1314,7 +1314,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
 			if (root->lib == lib_path[i]) {
 				/* This condition could be checked by a
 				 * tool at build time. */
-				status = DSP_EDYNLOAD;
+				status = -EILSEQ;
 			}
 		}
 	}
@@ -1376,7 +1376,7 @@ static dsp_status load_lib(struct nldr_nodeobject *nldr_node_obj,
 			if (!rootPersistent && persistent_dep_libs[i] &&
 			    *nldr_node_obj->pf_phase_split) {
 				if ((nldr_node_obj->pers_libs) > MAXLIBS) {
-					status = DSP_EDYNLOAD;
+					status = -EILSEQ;
 					break;
 				}
 
-- 
1.7.1

