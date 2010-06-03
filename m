From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 17/40] DSPBRIDGE: err code replace COD_E_ZLCREATEFAILED with ESPIPE
Date: Thu,  3 Jun 2010 00:47:30 -0500
Message-ID: <1275544073-20418-18-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44876 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab0FCF4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:19 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace COD_E_ZLCREATEFAILED with ESPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dev.h |    4 ++--
 drivers/dsp/bridge/pmgr/cod.c              |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 3ee2eb9..56df6d8 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -84,7 +84,7 @@ extern void cod_close(struct cod_libraryobj *lib);
  *  Returns:
  *      0:                Success.
  *      COD_E_NOZLFUNCTIONS:    Could not initialize ZL functions.
- *      COD_E_ZLCREATEFAILED:   ZL_Create failed.
+ *      -ESPIPE:   ZL_Create failed.
  *      -ENOSYS:           attrs was not NULL.  We don't yet support
  *                              non default values of attrs.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 75e795e..8652f52 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -84,7 +84,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *      LDR_E_NOMEMORY:         PELDR is out of resources.
  *      -EPERM:              Unable to find WMD entry point function.
  *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
- *      COD_E_ZLCREATEFAILED:   Unable to load ZL DLL.
+ *      -ESPIPE:   Unable to load ZL DLL.
  *  Requires:
  *      DEV Initialized.
  *      phDevObject != NULL.
@@ -126,7 +126,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *      LDR_E_NOMEMORY:         PELDR is out of resources.
  *      -EPERM:              Unable to find WMD entry point function.
  *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
- *      COD_E_ZLCREATEFAILED:   Unable to load ZL DLL.
+ *      -ESPIPE:   Unable to load ZL DLL.
  *  Requires:
  *      DEV Initialized.
  *      phDevObject != NULL.
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 552a03f..65acd6f 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -268,7 +268,7 @@ dsp_status cod_create(OUT struct cod_manager **phMgr, char *pstrDummyFile,
 
 	if (DSP_FAILED(status)) {
 		cod_delete(mgr_new);
-		return COD_E_ZLCREATEFAILED;
+		return -ESPIPE;
 	}
 
 	/* return the new manager */
-- 
1.7.1

