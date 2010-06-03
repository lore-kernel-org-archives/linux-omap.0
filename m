From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 19/40] DSPBRIDGE: err code replace COD_E_NOSYMBOLSLOADED with ESPIPE
Date: Thu,  3 Jun 2010 00:47:32 -0500
Message-ID: <1275544073-20418-20-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56430 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932406Ab0FCF4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:17 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace COD_E_NOSYMBOLSLOADED with ESPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dev.h |    2 +-
 drivers/dsp/bridge/pmgr/cod.c              |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 76b6ae9..8a4919e 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -212,7 +212,7 @@ extern dsp_status cod_get_loader(struct cod_manager *cod_mgr_obj,
  *      puLen:      Location to store length.
  *  Returns:
  *      0:                Success
- *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
+ *      -ESPIPE:  Symbols have not been loaded onto the board.
  *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      COD module initialized.
@@ -242,7 +242,7 @@ extern dsp_status cod_get_section(struct cod_libraryobj *lib,
  *      value:      value of the symbol
  *  Returns:
  *      0:                Success.
- *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
+ *      -ESPIPE:  Symbols have not been loaded onto the board.
  *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      COD module initialized.
@@ -355,7 +355,7 @@ extern dsp_status cod_open_base(struct cod_manager *hmgr, IN char *pszCoffPath,
  *      pstrContent - buffer to store content of the section.
  *  Returns:
  *      0: on success, error code on failure
- *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
+ *      -ESPIPE:  Symbols have not been loaded onto the board.
  *      COD_E_READFAILED: Failed to read content of code section.
  *  Requires:
  *      COD module initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index e75a141..cf48c07 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -492,7 +492,7 @@ extern dsp_status dev_get_node_manager(struct dev_object
  *  Returns:
  *      0:        Success.
  *      -EFAULT:    Invalid hdev_obj.
- *      COD_E_NOSYMBOLSLOADED:  Symbols have not been loaded onto the board.
+ *      -ESPIPE:  Symbols have not been loaded onto the board.
  *      -ESPIPE:   The symbol could not be found.
  *  Requires:
  *      pstrSym != NULL.
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 5a18853..342c1b3 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -417,7 +417,7 @@ dsp_status cod_get_section(struct cod_libraryobj *lib, IN char *pstrSect,
 		status = cod_mgr_obj->fxns.get_sect_fxn(lib->dbll_lib, pstrSect,
 							puAddr, puLen);
 	} else {
-		status = COD_E_NOSYMBOLSLOADED;
+		status = -ESPIPE;
 	}
 
 	DBC_ENSURE(DSP_SUCCEEDED(status) || ((*puAddr == 0) && (*puLen == 0)));
@@ -453,7 +453,7 @@ dsp_status cod_get_sym_value(struct cod_manager *hmgr, char *pstrSym,
 				return -ESPIPE;
 		}
 	} else {
-		return COD_E_NOSYMBOLSLOADED;
+		return -ESPIPE;
 	}
 
 	*pul_value = dbll_sym->value;
@@ -642,7 +642,7 @@ dsp_status cod_read_section(struct cod_libraryobj *lib, IN char *pstrSect,
 		    lib->cod_mgr->fxns.read_sect_fxn(lib->dbll_lib, pstrSect,
 						     pstrContent, cContentSize);
 	else
-		status = COD_E_NOSYMBOLSLOADED;
+		status = -ESPIPE;
 
 	return status;
 }
-- 
1.7.1

