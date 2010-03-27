From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 15/19] DSPBRIDGE: Cleanup custom error code
 (DSP_EUUID -> -ENOKEY)
Date: Sat, 27 Mar 2010 07:58:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE15@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab0C0C25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:28:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2SrIW006279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:28:56 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2SrPu026676
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:58:53 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 67e5343bec9a3f262a02b65fa92c98a1170100f2 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 12:47:45 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EUUID -> -ENOKEY)

This patch replaces DSP_EUUID with -ENOKEY.

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
index 00affd0..073991b 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -40,7 +40,7 @@
  *  Returns:
  *      DSP_SOK:            Success.
  *      -ENOMEM:        Insufficient memory on GPP.
- *      DSP_EUUID:          Node UUID has not been registered.
+ *      -ENOKEY:          Node UUID has not been registered.
  *      DSP_ESYMBOL:        iAlg functions not found for a DAIS node.
  *      -EDOM:         attr_in != NULL and attr_in->prio out of
  *                          range.
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index f3a2ebf..21333fc 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -441,7 +441,7 @@ dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
 		    reg_get_value(sz_reg_key, (u8 *) sz_reg_data, &dw_buf_size);
 
 	if (DSP_FAILED(status)) {
-		status = DSP_EUUID;
+		status = -ENOKEY;
 		goto func_end;
 	}
 
-- 
1.6.0.4

