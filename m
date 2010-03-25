From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 15/19] DSPBRIDGE: Cleanup custom error code (DSP_EUUID
 -> ENOKEY)
Date: Fri, 26 Mar 2010 01:36:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB2B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 917e18ce17d1c2a31fd0a3b14610b0ca584f2022 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 12:47:45 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(DSP_EUUID -> ENOKEY).

This patch replaces DSP_EUUID with ENOKEY.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h    |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c                |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index dedca5d..7e2f0b6 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -122,9 +122,6 @@
  * found in the COFF file. */
 #define DSP_ESYMBOL                 (DSP_EBASE + 0x1c)
 
-/* UUID not found in registry. */
-#define DSP_EUUID                   (DSP_EBASE + 0x1d)
-
 /* Unable to read content of DCD data section ; this is typically caused by
  * improperly configured nodes. */
 #define DSP_EDCDREADSECT            (DSP_EBASE + 0x1e)
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index cc9a89c..f2e72df 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -40,7 +40,7 @@
  *  Returns:
  *      DSP_SOK:            Success.
  *      ENOMEM:        Insufficient memory on GPP.
- *      DSP_EUUID:          Node UUID has not been registered.
+ *      ENOKEY:          Node UUID has not been registered.
  *      DSP_ESYMBOL:        iAlg functions not found for a DAIS node.
  *      EDOM:         attr_in != NULL and attr_in->prio out of
  *                          range.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 23961f9..43ea1ec 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -441,7 +441,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 		    reg_get_value(sz_reg_key, (u8 *) sz_reg_data, &dw_buf_size);
 
 	if (DSP_FAILED(status)) {
-		status = DSP_EUUID;
+		status = ENOKEY;
 		goto func_end;
 	}
 
-- 
1.6.0.4

