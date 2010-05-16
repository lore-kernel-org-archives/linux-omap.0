From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] dspbridge: remove _tiomap_mmu.h
Date: Sun, 16 May 2010 18:45:01 +0300
Message-ID: <1274024702-20961-4-git-send-email-felipe.contreras@gmail.com>
References: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:23898 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0EPPpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:45:20 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178279fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:45:18 -0700 (PDT)
In-Reply-To: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Not used, only in bridge_brd_start(), so refactor that code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/_tiomap_mmu.h |   41 ----------------
 drivers/dsp/bridge/core/mmu_fault.c   |    1 -
 drivers/dsp/bridge/core/tiomap3430.c  |   84 ++++++++++-----------------------
 drivers/dsp/bridge/core/ue_deh.c      |    1 -
 4 files changed, 25 insertions(+), 102 deletions(-)
 delete mode 100644 drivers/dsp/bridge/core/_tiomap_mmu.h

diff --git a/drivers/dsp/bridge/core/_tiomap_mmu.h b/drivers/dsp/bridge/core/_tiomap_mmu.h
deleted file mode 100644
index 66c1249..0000000
--- a/drivers/dsp/bridge/core/_tiomap_mmu.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * _tiomap_mmu.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Definitions and types for the DSP MMU modules.
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
-#ifndef _TIOMAP_MMU_
-#define _TIOMAP_MMU_
-
-#include "_tiomap.h"
-
-/*
- *  ======== configure_dsp_mmu ========
- *
- *  Make DSP MMu page table entries.
- *  Note: Not utilizing Coarse / Fine page tables.
- *  SECTION = 1MB, LARGE_PAGE = 64KB, SMALL_PAGE = 4KB, TINY_PAGE = 1KB.
- *  DSP Byte address 0x40_0000 is word addr 0x20_0000.
- */
-extern void configure_dsp_mmu(struct bridge_dev_context *dev_context,
-			      u32 dataBasePhys,
-			      u32 dspBaseVirt,
-			      u32 sizeInBytes,
-			      s32 nEntryStart,
-			      enum hw_endianism_t endianism,
-			      enum hw_element_size_t elem_size,
-			      enum hw_mmu_mixed_size_t mixed_size);
-
-#endif /* _TIOMAP_MMU_ */
diff --git a/drivers/dsp/bridge/core/mmu_fault.c b/drivers/dsp/bridge/core/mmu_fault.c
index 883f45d..7cd78c6 100644
--- a/drivers/dsp/bridge/core/mmu_fault.c
+++ b/drivers/dsp/bridge/core/mmu_fault.c
@@ -38,7 +38,6 @@
 /*  ----------------------------------- This */
 #include "_deh.h"
 #include <dspbridge/cfg.h>
-#include "_tiomap_mmu.h"
 #include "_tiomap.h"
 #include "mmu_fault.h"
 
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index c7b0d83..3b571aa 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -57,7 +57,6 @@
 /*  ----------------------------------- Local */
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
-#include "_tiomap_mmu.h"
 #include "_tiomap_util.h"
 #include "tiomap_io.h"
 
@@ -457,41 +456,32 @@ static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
 		/* Only make TLB entry if both addresses are non-zero */
 		for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB;
 		     entry_ndx++) {
-			if ((dev_context->atlb_entry[entry_ndx].ul_gpp_pa != 0)
-			    && (dev_context->atlb_entry[entry_ndx].ul_dsp_va !=
-				0)) {
-				dev_dbg(bridge,
-					"(proc) MMU %d GppPa:"
-					" 0x%x DspVa 0x%x Size 0x%x\n",
+			struct bridge_ioctl_extproc *e = &dev_context->atlb_entry[entry_ndx];
+			struct hw_mmu_map_attrs_t map_attrs = {
+				.endianism = e->endianism,
+				.element_size = e->elem_size,
+				.mixed_size = e->mixed_mode,
+			};
+
+			if (!e->ul_gpp_pa || !e->ul_dsp_va)
+				continue;
+
+			dev_dbg(bridge,
+					"MMU %d, pa: 0x%x, va: 0x%x, size: 0x%x",
 					itmp_entry_ndx,
-					dev_context->atlb_entry[entry_ndx].
-					ul_gpp_pa,
-					dev_context->atlb_entry[entry_ndx].
-					ul_dsp_va,
-					dev_context->atlb_entry[entry_ndx].
-					ul_size);
-				configure_dsp_mmu(dev_context,
-						  dev_context->
-						  atlb_entry[entry_ndx].
-						  ul_gpp_pa,
-						  dev_context->
-						  atlb_entry[entry_ndx].
-						  ul_dsp_va * DSPWORDSIZE,
-						  dev_context->
-						  atlb_entry[entry_ndx].ul_size,
-						  itmp_entry_ndx,
-						  dev_context->
-						  atlb_entry[entry_ndx].
-						  endianism,
-						  dev_context->
-						  atlb_entry[entry_ndx].
-						  elem_size,
-						  dev_context->
-						  atlb_entry[entry_ndx].
-						  mixed_mode);
-				itmp_entry_ndx++;
-			}
-		}		/* end for */
+					e->ul_gpp_pa,
+					e->ul_dsp_va,
+					e->ul_size);
+
+			hw_mmu_tlb_add(dev_context->dw_dsp_mmu_base,
+					e->ul_gpp_pa,
+					e->ul_dsp_va,
+					e->ul_size,
+					itmp_entry_ndx,
+					&map_attrs, 1, 1);
+
+			itmp_entry_ndx++;
+		}
 	}
 
 	/* Lock the above TLB entries and get the BIOS and load monitor timer
@@ -1870,30 +1860,6 @@ static dsp_status mem_map_vmalloc(struct bridge_dev_context *dev_context,
 }
 
 /*
- *  ======== configure_dsp_mmu ========
- *      Make DSP MMU page table entries.
- */
-void configure_dsp_mmu(struct bridge_dev_context *dev_context, u32 dataBasePhys,
-		       u32 dspBaseVirt, u32 sizeInBytes, s32 nEntryStart,
-		       enum hw_endianism_t endianism,
-		       enum hw_element_size_t elem_size,
-		       enum hw_mmu_mixed_size_t mixed_size)
-{
-	struct hw_mmu_map_attrs_t map_attrs = { endianism, elem_size,
-						mixed_size };
-
-	DBC_REQUIRE(sizeInBytes > 0);
-	dev_dbg(bridge, "%s: entry %x pa %x, va %x, bytes %x endianism %x, "
-		"elem_size %x, mixed_size %x", __func__, nEntryStart,
-		dataBasePhys, dspBaseVirt, sizeInBytes, endianism,
-		elem_size, mixed_size);
-
-	hw_mmu_tlb_add(dev_context->dw_dsp_mmu_base, dataBasePhys,
-		       dspBaseVirt, sizeInBytes, nEntryStart,
-		       &map_attrs, HW_SET, HW_SET);
-}
-
-/*
  *  ======== wait_for_start ========
  *      Wait for the singal from DSP that it has started, or time out.
  */
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 605f312..10486b4 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -49,7 +49,6 @@
 #include "mmu_fault.h"
 #include "_tiomap.h"
 #include "_deh.h"
-#include "_tiomap_mmu.h"
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
-- 
1.7.1

