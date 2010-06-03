From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 18/40] DSPBRIDGE: err code replace COD_E_SYMBOLNOTFOUND with ESPIPE
Date: Thu,  3 Jun 2010 00:47:31 -0500
Message-ID: <1275544073-20418-19-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56435 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067Ab0FCF4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:19 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace COD_E_SYMBOLNOTFOUND with ESPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/dev.h |    2 +-
 drivers/dsp/bridge/pmgr/cod.c              |    2 +-
 drivers/dsp/bridge/rmgr/node.c             |    2 +-
 drivers/dsp/bridge/rmgr/proc.c             |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 56df6d8..76b6ae9 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -213,7 +213,7 @@ extern dsp_status cod_get_loader(struct cod_manager *cod_mgr_obj,
  *  Returns:
  *      0:                Success
  *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
- *      COD_E_SYMBOLNOTFOUND:   The symbol could not be found.
+ *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      COD module initialized.
  *      valid cod_mgr_obj.
@@ -243,7 +243,7 @@ extern dsp_status cod_get_section(struct cod_libraryobj *lib,
  *  Returns:
  *      0:                Success.
  *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
- *      COD_E_SYMBOLNOTFOUND:   The symbol could not be found.
+ *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      COD module initialized.
  *      Valid cod_mgr_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 8652f52..e75a141 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -493,7 +493,7 @@ extern dsp_status dev_get_node_manager(struct dev_object
  *      0:        Success.
  *      -EFAULT:    Invalid hdev_obj.
  *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
- *      COD_E_SYMBOLNOTFOUND:   The symbol could not be found.
+ *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      pstrSym != NULL.
  *      pul_value != NULL.
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 65acd6f..5a18853 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -450,7 +450,7 @@ dsp_status cod_get_sym_value(struct cod_manager *hmgr, char *pstrSym,
 		    get_addr_fxn(hmgr->base_lib, pstrSym, &dbll_sym)) {
 			if (!hmgr->fxns.
 			    get_c_addr_fxn(hmgr->base_lib, pstrSym, &dbll_sym))
-				return COD_E_SYMBOLNOTFOUND;
+				return -ESPIPE;
 		}
 	} else {
 		return COD_E_NOSYMBOLSLOADED;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index e087238..159ea2b 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3098,7 +3098,7 @@ static dsp_status get_rms_fxns(struct node_mgr *hnode_mgr)
 		status = dev_get_symbol(dev_obj, psz_fxns[i],
 					&(hnode_mgr->ul_fxn_addrs[i]));
 		if (DSP_FAILED(status)) {
-			if (status == COD_E_SYMBOLNOTFOUND) {
+			if (status == -ESPIPE) {
 				/*
 				 *  May be loaded dynamically (in the future),
 				 *  but return an error for now.
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f3a9b2b..1f46f66 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -970,7 +970,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 				dev_dbg(bridge, "%s: Failure to Load the EXE\n",
 					__func__);
 			}
-			if (status == COD_E_SYMBOLNOTFOUND) {
+			if (status == -ESPIPE) {
 				pr_err("%s: Couldn't parse the file\n",
 				       __func__);
 			}
-- 
1.7.1

