From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v3 02/12] staging: tidspbridge: remove utildefs
Date: Sun, 21 Nov 2010 12:46:20 +0200
Message-ID: <1290336390-2581-3-git-send-email-ionut.nicu@mindbit.ro>
References: <1290336390-2581-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63930 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0KUKq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Nov 2010 05:46:56 -0500
Received: by mail-fx0-f46.google.com with SMTP id 13so1867548fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 02:46:55 -0800 (PST)
In-Reply-To: <1290336390-2581-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Remove a header file that was not very useful to
the dspbridge driver.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 .../tidspbridge/include/dspbridge/utildefs.h       |   39 --------------------
 drivers/staging/tidspbridge/pmgr/cmm.c             |    9 +----
 2 files changed, 1 insertions(+), 47 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/utildefs.h

diff --git a/drivers/staging/tidspbridge/include/dspbridge/utildefs.h b/drivers/staging/tidspbridge/include/dspbridge/utildefs.h
deleted file mode 100644
index 8fe5414..0000000
--- a/drivers/staging/tidspbridge/include/dspbridge/utildefs.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * utildefs.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Global UTIL constants and types, shared between DSP API and DSPSYS.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef UTILDEFS_
-#define UTILDEFS_
-
-/* constants taken from configmg.h */
-#define UTIL_MAXMEMREGS     9
-#define UTIL_MAXIOPORTS     20
-#define UTIL_MAXIRQS        7
-#define UTIL_MAXDMACHNLS    7
-
-/* misc. constants */
-#define UTIL_MAXARGVS       10
-
-/* Platform specific important info */
-struct util_sysinfo {
-	/* Granularity of page protection; usually 1k or 4k */
-	u32 dw_page_size;
-	u32 dw_allocation_granularity;	/* VM granularity, usually 64K */
-	u32 dw_number_of_processors;	/* Used as sanity check */
-};
-
-#endif /* UTILDEFS_ */
diff --git a/drivers/staging/tidspbridge/pmgr/cmm.c b/drivers/staging/tidspbridge/pmgr/cmm.c
index 93a7c4f..8dbdd20 100644
--- a/drivers/staging/tidspbridge/pmgr/cmm.c
+++ b/drivers/staging/tidspbridge/pmgr/cmm.c
@@ -40,7 +40,6 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/list.h>
 #include <dspbridge/sync.h>
-#include <dspbridge/utildefs.h>
 
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
@@ -245,7 +244,6 @@ int cmm_create(struct cmm_object **ph_cmm_mgr,
 {
 	struct cmm_object *cmm_obj = NULL;
 	int status = 0;
-	struct util_sysinfo sys_info;
 
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(ph_cmm_mgr != NULL);
@@ -261,12 +259,7 @@ int cmm_create(struct cmm_object **ph_cmm_mgr,
 		DBC_ASSERT(mgr_attrts->ul_min_block_size >= 4);
 		/* save away smallest block allocation for this cmm mgr */
 		cmm_obj->ul_min_block_size = mgr_attrts->ul_min_block_size;
-		/* save away the systems memory page size */
-		sys_info.dw_page_size = PAGE_SIZE;
-		sys_info.dw_allocation_granularity = PAGE_SIZE;
-		sys_info.dw_number_of_processors = 1;
-
-		cmm_obj->dw_page_size = sys_info.dw_page_size;
+		cmm_obj->dw_page_size = PAGE_SIZE;
 
 		/* Note: DSP SM seg table(aDSPSMSegTab[]) zero'd by
 		 * MEM_ALLOC_OBJECT */
-- 
1.7.3.2

