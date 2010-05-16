From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] dspbridge: remove _tiomap_util.h
Date: Sun, 16 May 2010 18:45:02 +0300
Message-ID: <1274024702-20961-5-git-send-email-felipe.contreras@gmail.com>
References: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:38885 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab0EPPpV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:45:21 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178289fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:45:20 -0700 (PDT)
In-Reply-To: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/_tiomap_util.h   |   43 ------------------------------
 drivers/dsp/bridge/core/tiomap3430.c     |    5 +++-
 drivers/dsp/bridge/core/tiomap3430_pwr.c |    3 +-
 3 files changed, 6 insertions(+), 45 deletions(-)
 delete mode 100644 drivers/dsp/bridge/core/_tiomap_util.h

diff --git a/drivers/dsp/bridge/core/_tiomap_util.h b/drivers/dsp/bridge/core/_tiomap_util.h
deleted file mode 100644
index ccdd678..0000000
--- a/drivers/dsp/bridge/core/_tiomap_util.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * _tiomap_util.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Definitions and types for the utility routines.
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
-#ifndef _TIOMAP_UTIL_
-#define _TIOMAP_UTIL_
-
-/* Time out Values in uSeconds */
-#define TIHELEN_ACKTIMEOUT  10000
-
-/*
- * Time out for power state transition (in msecs), due to system
- * latencies and HZ resolution this timer can vary.
- */
-#define PWRSTST_TIMEOUT		200
-
-/*  Time delay for HOM->SAM transition. */
-#define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
-
-/*
- *  ======== wait_for_start ========
- *  Wait for the singal from DSP that it has started, or time out.
- *  The argument dw_sync_addr is set to 1 before releasing the DSP.
- *  If the DSP starts running, it will clear this location.
- */
-extern bool wait_for_start(struct bridge_dev_context *dev_context,
-			   u32 dw_sync_addr);
-
-#endif /* _TIOMAP_UTIL_ */
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 3b571aa..ca61797 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -57,7 +57,6 @@
 /*  ----------------------------------- Local */
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
-#include "_tiomap_util.h"
 #include "tiomap_io.h"
 
 /* Offset in shared mem to write to in order to synchronize start with DSP */
@@ -65,6 +64,8 @@
 
 #define BUFFERSIZE 1024
 
+#define TIHELEN_ACKTIMEOUT  10000
+
 #define MMU_SECTION_ADDR_MASK    0xFFF00000
 #define MMU_SSECTION_ADDR_MASK   0xFF000000
 #define MMU_LARGE_PAGE_MASK      0xFFFF0000
@@ -121,6 +122,8 @@ static dsp_status mem_map_vmalloc(struct bridge_dev_context *hDevContext,
 				  u32 ul_num_bytes,
 				  struct hw_mmu_map_attrs_t *hw_attrs);
 
+bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr);
+
 /*  ----------------------------------- Globals */
 
 /* Attributes of L2 page tables for DSP MMU */
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index 1897c50..97fcaaa 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -41,10 +41,11 @@
 /*  ----------------------------------- specific to this file */
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
-#include "_tiomap_util.h"
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
 
+#define PWRSTST_TIMEOUT          200
+
 /*
  *  ======== handle_constraints_set ========
  *  	Sets new DSP constraint
-- 
1.7.1

