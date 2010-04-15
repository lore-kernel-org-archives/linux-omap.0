From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 4/13] DSPPBRIDGE: Cleanup custom error code
 (DSP_EFREAD -> -EBADF)
Date: Fri, 16 Apr 2010 02:47:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55889 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757185Ab0DOVRS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHFqq019344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:17 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHFhR011064
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:15 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 35bb007415ef78a380edfb4b79729626473eff3b Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 10:59:06 -0500
Subject: [PATCH] DSPPBRIDGE: Cleanup custom error code (DSP_EFREAD -> -EBADF)

This patch replaces DSP_EFREAD with -EBADF

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/errbase.h  |    3 ---
 drivers/dsp/bridge/pmgr/cod.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 527d47e..5dd23fb 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -337,7 +337,7 @@ typedef bool(*dbll_init_fxn) (void);
  *      pulEntry        - Location to store program entry on output.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_EFREAD:     File read failed.
+ *      -EBADF:     File read failed.
  *      DSP_EFWRITE:    Write to target failed.
  *      DSP_EDYNLOAD:   Failure in dynamic loader library.
  *  Requires:
@@ -386,7 +386,7 @@ typedef dsp_status(*dbll_load_sect_fxn) (struct dbll_library_obj *lib,
  *      DSP_SOK:            Success.
  *      -ENOMEM:        Memory allocation failure.
  *      -EBADF:         File open failure.
- *      DSP_EFREAD:         File read failure.
+ *      -EBADF:         File read failure.
  *      DSP_ECORRUPTFILE:   Unable to determine target type.
  *  Requires:
  *      DBL initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 3f637dd..c9316ac 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -162,9 +162,6 @@
 /* Unable to find a named section in DSP executable */
 #define DSP_ENOSECT                 (DSP_EBASE + 0x32)
 
-/* Unable to read file */
-#define DSP_EFREAD                  (DSP_EBASE + 0x34)
-
 /* A non-existent memory segment identifier was specified */
 #define DSP_EOVERLAYMEMORY          (DSP_EBASE + 0x37)
 
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index b4b71fc..010e90c 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -149,7 +149,7 @@ static s32 cod_f_read(void __user *pbuffer, s32 size, s32 cCount,
 		set_fs(fs);
 
 		if (!dw_bytes_read)
-			return DSP_EFREAD;
+			return -EBADF;
 
 		return dw_bytes_read / size;
 	}
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 5544029..e692b78 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -795,7 +795,7 @@ dsp_status dbll_read_sect(struct dbll_library_obj *lib, char *name,
 		status = DSP_EFAIL;
 	} else {
 		if (!dload_get_section(zl_lib->desc, sect, pContent))
-			status = DSP_EFREAD;
+			status = -EBADF;
 
 	}
 func_cont:
-- 
1.6.0.4

