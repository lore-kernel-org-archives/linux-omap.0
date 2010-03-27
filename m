From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 9/19] DSPBRIDGE: Cleanup custom error code
 (DSP_EFOPEN ->- EBADF)
Date: Sat, 27 Mar 2010 07:58:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE0F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab0C0C2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:28:15 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2SCsP011897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:28:15 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2SCH6026619
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:58:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 3bf9c85d6d0794e790491334dca1dde8d0ada863 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 13:24:31 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EFOPEN ->- EBADF)

This patch replaces DSP_EFOPEN with -EBADF

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 ---
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index fce35ab..527d47e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -385,7 +385,7 @@ typedef dsp_status(*dbll_load_sect_fxn) (struct dbll_library_obj *lib,
  *  Returns:
  *      DSP_SOK:            Success.
  *      -ENOMEM:        Memory allocation failure.
- *      DSP_EFOPEN:         File open failure.
+ *      -EBADF:         File open failure.
  *      DSP_EFREAD:         File read failure.
  *      DSP_ECORRUPTFILE:   Unable to determine target type.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 09ae0c6..aa848c8 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -192,9 +192,6 @@
 /* Unable to find a named section in DSP executable */
 #define DSP_ENOSECT                 (DSP_EBASE + 0x32)
 
-/* Unable to open file */
-#define DSP_EFOPEN                  (DSP_EBASE + 0x33)
-
 /* Unable to read file */
 #define DSP_EFREAD                  (DSP_EBASE + 0x34)
 
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 8d6f9ea..5544029 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -915,10 +915,10 @@ static dsp_status dof_open(struct dbll_library_obj *zl_lib)
 		if (zl_lib->desc == NULL) {
 			(zl_lib->target_obj->attrs.fclose) (zl_lib->fp);
 			zl_lib->fp = NULL;
-			status = DSP_EFOPEN;
+			status = -EBADF;
 		}
 	} else {
-		status = DSP_EFOPEN;
+		status = -EBADF;
 	}
 
 	return status;
-- 
1.6.0.4

