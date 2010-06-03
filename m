From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 24/40] DSPBRIDGE: err code replace DSP_ENOSECT with ENXIO
Date: Thu,  3 Jun 2010 00:47:37 -0500
Message-ID: <1275544073-20418-25-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0FCF4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:21 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_ENOSECT with ENXIO

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    8 ++++----
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 18a862f..e780e87 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -299,7 +299,7 @@ typedef bool(*dbll_get_c_addr_fxn) (struct dbll_library_obj *lib, char *name,
  *      psize           - Location to store section size on output.
  *  Returns:
  *      0:        Success.
- *      DSP_ENOSECT:    Section not found.
+ *      -ENXIO:    Section not found.
  *  Requires:
  *      DBL initialized.
  *      Valid lib.
@@ -359,7 +359,7 @@ typedef dsp_status(*dbll_load_fxn) (struct dbll_library_obj *lib,
  *      attrs           - Contains write function and handle to pass to it.
  *  Returns:
  *      0:        Success.
- *      DSP_ENOSECT:    Section not found.
+ *      -ENXIO:    Section not found.
  *      DSP_EFWRITE:    Write function failed.
  *      -ENOSYS:   Function not implemented.
  *  Requires:
@@ -412,7 +412,7 @@ typedef dsp_status(*dbll_open_fxn) (struct dbll_tar_obj *target, char *file,
  *      size            - Buffer size
  *  Returns:
  *      0:        Success.
- *      DSP_ENOSECT:    Named section does not exists.
+ *      -ENXIO:    Named section does not exists.
  *  Requires:
  *      DBL initialized.
  *      Valid lib.
@@ -465,7 +465,7 @@ typedef void (*dbll_unload_fxn) (struct dbll_library_obj *library,
  *      attrs           - Contains free() function and handle to pass to it.
  *  Returns:
  *      0:        Success.
- *      DSP_ENOSECT:    Named section not found.
+ *      -ENXIO:    Named section not found.
  *      -ENOSYS
  *  Requires:
  *      DBL initialized.
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 6a01f56..8e76bf6 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -419,7 +419,7 @@ dsp_status dbll_get_sect(struct dbll_library_obj *lib, char *name, u32 *paddr,
 			/* Align size */
 			*psize = DOFF_ALIGN(*psize);
 		} else {
-			status = DSP_ENOSECT;
+			status = -ENXIO;
 		}
 	}
 	if (opened_doff) {
@@ -764,7 +764,7 @@ dsp_status dbll_read_sect(struct dbll_library_obj *lib, char *name,
 
 	byte_size = 1;
 	if (!dload_get_section_info(zl_lib->desc, name, &sect)) {
-		status = DSP_ENOSECT;
+		status = -ENXIO;
 		goto func_cont;
 	}
 	/*
-- 
1.7.1

