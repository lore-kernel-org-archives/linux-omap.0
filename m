From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/13] staging: ti dspbridge: move mmufault to deh
Date: Sun,  4 Jul 2010 16:34:37 +0300
Message-ID: <1278250479-16982-12-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56879 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781Ab0GDNfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:35:05 -0400
Received: by bwz1 with SMTP id 1so2295391bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:35:04 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/Makefile         |    2 +-
 drivers/staging/tidspbridge/core/mmu_fault.c |   98 --------------------------
 drivers/staging/tidspbridge/core/mmu_fault.h |   34 ---------
 drivers/staging/tidspbridge/core/ue_deh.c    |   50 +++++++++++++-
 4 files changed, 50 insertions(+), 134 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/core/mmu_fault.c
 delete mode 100644 drivers/staging/tidspbridge/core/mmu_fault.h

diff --git a/drivers/staging/tidspbridge/Makefile b/drivers/staging/tidspbridge/Makefile
index 6082ef0..6567172 100644
--- a/drivers/staging/tidspbridge/Makefile
+++ b/drivers/staging/tidspbridge/Makefile
@@ -5,7 +5,7 @@ libservices = services/sync.o services/cfg.o \
 		services/ntfy.o services/services.o
 libcore = core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3430.o \
 		core/tiomap3430_pwr.o core/tiomap_io.o \
-		core/mmu_fault.o core/ue_deh.o core/wdt.o core/dsp-clock.o
+		core/ue_deh.o core/wdt.o core/dsp-clock.o
 libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/dspapi.o \
 		pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
diff --git a/drivers/staging/tidspbridge/core/mmu_fault.c b/drivers/staging/tidspbridge/core/mmu_fault.c
deleted file mode 100644
index dadfbf5..0000000
--- a/drivers/staging/tidspbridge/core/mmu_fault.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * mmu_fault.c
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Implements DSP MMU fault handling functions.
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
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dspbridge/std.h>
-#include <dspbridge/dbdefs.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dspbridge/host_os.h>
-#include <dspbridge/dbc.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/drv.h>
-
-/*  ----------------------------------- Link Driver */
-#include <dspbridge/dspdeh.h>
-
-/* ------------------------------------ Hardware Abstraction Layer */
-#include <hw_defs.h>
-#include <hw_mmu.h>
-
-/*  ----------------------------------- This */
-#include "_deh.h"
-#include <dspbridge/cfg.h>
-#include "_tiomap.h"
-#include "mmu_fault.h"
-
-/*
- *  ======== mmu_fault_dpc ========
- *      Deferred procedure call to handle DSP MMU fault.
- */
-void mmu_fault_dpc(IN unsigned long pRefData)
-{
-	struct deh_mgr *hdeh_mgr = (struct deh_mgr *)pRefData;
-
-	if (!hdeh_mgr)
-		return;
-
-	bridge_deh_notify(hdeh_mgr, DSP_MMUFAULT, 0L);
-}
-
-/*
- *  ======== mmu_fault_isr ========
- *      ISR to be triggered by a DSP MMU fault interrupt.
- */
-irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
-{
-	struct deh_mgr *deh_mgr_obj = pRefData;
-	struct cfg_hostres *resources;
-	u32 dmmu_event_mask;
-
-	if (!deh_mgr_obj)
-		return IRQ_HANDLED;
-
-	resources = deh_mgr_obj->hbridge_context->resources;
-	if (!resources) {
-		dev_dbg(bridge, "%s: Failed to get Host Resources\n",
-				__func__);
-		return IRQ_HANDLED;
-	}
-
-	hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
-	if (dmmu_event_mask == HW_MMU_TRANSLATION_FAULT) {
-		hw_mmu_fault_addr_read(resources->dw_dmmu_base, &deh_mgr_obj->fault_addr);
-		dev_info(bridge, "%s: status=0x%x, fault_addr=0x%x\n", __func__,
-				dmmu_event_mask, deh_mgr_obj->fault_addr);
-		/*
-		 * Schedule a DPC directly. In the future, it may be
-		 * necessary to check if DSP MMU fault is intended for
-		 * Bridge.
-		 */
-		tasklet_schedule(&deh_mgr_obj->dpc_tasklet);
-
-		/* Disable the MMU events, else once we clear it will
-		 * start to raise INTs again */
-		hw_mmu_event_disable(resources->dw_dmmu_base,
-				HW_MMU_TRANSLATION_FAULT);
-	} else {
-		hw_mmu_event_disable(resources->dw_dmmu_base,
-				HW_MMU_ALL_INTERRUPTS);
-	}
-	return IRQ_HANDLED;
-}
diff --git a/drivers/staging/tidspbridge/core/mmu_fault.h b/drivers/staging/tidspbridge/core/mmu_fault.h
deleted file mode 100644
index 537e6e7..0000000
--- a/drivers/staging/tidspbridge/core/mmu_fault.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * mmu_fault.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Defines DSP MMU fault handling functions.
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
-#ifndef MMU_FAULT_
-#define MMU_FAULT_
-
-/*
- *  ======== mmu_fault_dpc ========
- *      Deferred procedure call to handle DSP MMU fault.
- */
-void mmu_fault_dpc(IN unsigned long pRefData);
-
-/*
- *  ======== mmu_fault_isr ========
- *      ISR to be triggered by a DSP MMU fault interrupt.
- */
-irqreturn_t mmu_fault_isr(int irq, IN void *pRefData);
-
-#endif /* MMU_FAULT_ */
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 904b837..26aec91 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -45,13 +45,61 @@
 #include <hw_mmu.h>
 
 /*  ----------------------------------- This */
-#include "mmu_fault.h"
 #include "_tiomap.h"
 #include "_deh.h"
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
 
+static void mmu_fault_dpc(unsigned long data)
+{
+	struct deh_mgr *hdeh_mgr = (void *)data;
+
+	if (!hdeh_mgr)
+		return;
+
+	bridge_deh_notify(hdeh_mgr, DSP_MMUFAULT, 0);
+}
+
+static irqreturn_t mmu_fault_isr(int irq, void *data)
+{
+	struct deh_mgr *deh_mgr_obj = data;
+	struct cfg_hostres *resources;
+	u32 dmmu_event_mask;
+
+	if (!deh_mgr_obj)
+		return IRQ_HANDLED;
+
+	resources = deh_mgr_obj->hbridge_context->resources;
+	if (!resources) {
+		dev_dbg(bridge, "%s: Failed to get Host Resources\n",
+				__func__);
+		return IRQ_HANDLED;
+	}
+
+	hw_mmu_event_status(resources->dw_dmmu_base, &dmmu_event_mask);
+	if (dmmu_event_mask == HW_MMU_TRANSLATION_FAULT) {
+		hw_mmu_fault_addr_read(resources->dw_dmmu_base, &deh_mgr_obj->fault_addr);
+		dev_info(bridge, "%s: status=0x%x, fault_addr=0x%x\n", __func__,
+				dmmu_event_mask, deh_mgr_obj->fault_addr);
+		/*
+		 * Schedule a DPC directly. In the future, it may be
+		 * necessary to check if DSP MMU fault is intended for
+		 * Bridge.
+		 */
+		tasklet_schedule(&deh_mgr_obj->dpc_tasklet);
+
+		/* Disable the MMU events, else once we clear it will
+		 * start to raise INTs again */
+		hw_mmu_event_disable(resources->dw_dmmu_base,
+				HW_MMU_TRANSLATION_FAULT);
+	} else {
+		hw_mmu_event_disable(resources->dw_dmmu_base,
+				HW_MMU_ALL_INTERRUPTS);
+	}
+	return IRQ_HANDLED;
+}
+
 int bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
-- 
1.7.1

