From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 10/13] DSPBRIDGE: Cleanup custom error code
 (COD_E_OPENFAILED -> -EBADF)
Date: Fri, 16 Apr 2010 02:48:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FE2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55927 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223Ab0DOVSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:18:05 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLI2bh019428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:18:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLI25u011150
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:48:02 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From beb1254acdd2d91aef4624f72783f298cb5187cd Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:39:04 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (COD_E_OPENFAILED -> -EBADF)

This patch replaces COD_E_OPENFAILED with -EBADF.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cod.h     |    6 +++---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/proc.c                 |    2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 381291c..f9d0aef 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -286,7 +286,7 @@ extern bool cod_init(void);
  *      envp:       array of environment strings for DSP exec.
  *  Returns:
  *      DSP_SOK:                   Success.
- *      COD_E_OPENFAILED:       Failed to open target code.
+ *      -EBADF:       Failed to open target code.
  *      COD_E_LOADFAILED:       Failed to load code onto target.
  *  Requires:
  *      COD module initialized.
@@ -315,7 +315,7 @@ extern dsp_status cod_load_base(struct cod_manager *cod_mgr_obj,
  *                      and cod_get_section.
  *  Returns:
  *      S_OK:                   Success.
- *      COD_E_OPENFAILED:       Failed to open target code.
+ *      -EBADF:       Failed to open target code.
  *  Requires:
  *      COD module initialized.
  *      hmgr is valid.
@@ -337,7 +337,7 @@ extern dsp_status cod_open(struct cod_manager *hmgr,
  *      flags:          Specifies whether to load symbols.
  *  Returns:
  *      DSP_SOK:            Success.
- *      COD_E_OPENFAILED:   Failed to open target code.
+ *      -EBADF:   Failed to open target code.
  *  Requires:
  *      COD module initialized.
  *      hmgr is valid.
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index dec4b34..679bb59 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -240,9 +240,6 @@
 /* Unable to initialize the ZL COFF parsing module. */
 #define COD_E_ZLCREATEFAILED        (COD_EBASE + 0x03)
 
-/* Unable to open DSP executable COFF file. */
-#define COD_E_OPENFAILED            (COD_EBASE + 0x04)
-
 /* Unable to parse DSP executable COFF file. */
 #define COD_E_LOADFAILED            (COD_EBASE + 0x05)
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bdd11a1..1199053 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -966,7 +966,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 				       dev_brd_write_fxn,
 				       p_proc_object->hdev_obj, NULL);
 		if (DSP_FAILED(status)) {
-			if (status == COD_E_OPENFAILED) {
+			if (status == -EBADF) {
 				dev_dbg(bridge, "%s: Failure to Load the EXE\n",
 					__func__);
 			}
-- 
1.6.0.4

