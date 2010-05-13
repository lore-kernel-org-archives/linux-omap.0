From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] dspbridge: deh: use GPT8
Date: Fri, 14 May 2010 01:00:26 +0300
Message-ID: <1273788026-11804-1-git-send-email-felipe.contreras@gmail.com>
References: <20100505115802.GE4265@annwn.felipec.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:55652 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab0EMWAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 18:00:40 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1350276fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 15:00:38 -0700 (PDT)
In-Reply-To: <20100505115802.GE4265@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Ernesto Ramos <ernesto@ti.com>

Cleaned up by Felipe Contreras.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   55 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 451ee3c..3678e1d 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -53,8 +53,17 @@
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
+#include <plat/dmtimer.h>
+
 #define ALIGN_DOWN(x, a)  ((x)&(~((a)-1)))
 
+/* GP Timer number to trigger interrupt for MMU-fault ISR on DSP */
+#define GPTIMER_FOR_DSP_MMU_FAULT      8
+/* Bit mask to enable overflow interrupt */
+#define GPTIMER_IRQ_OVERFLOW           2
+/* Max time to check for GP Timer IRQ */
+#define GPTIMER_IRQ_WAIT_MAX_CNT       1000
+
 static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
 	HW_ELEM_SIZE16BIT,
 	HW_MMU_CPUES
@@ -62,6 +71,8 @@ static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
 
 static void *dummy_va_addr;
 
+static struct omap_dm_timer *timer;
+
 dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
@@ -128,6 +139,15 @@ err:
 		bridge_deh_destroy(deh_mgr);
 		deh_mgr = NULL;
 	}
+	else {
+		timer = omap_dm_timer_request_specific(
+					GPTIMER_FOR_DSP_MMU_FAULT);
+		if (!timer) {
+			pr_err("%s: GPTimer not available\n", __func__);
+			return -ENODEV;
+		}
+		omap_dm_timer_disable(timer);
+	}
 
 leave:
 	*ret_deh_mgr = deh_mgr;
@@ -156,6 +176,10 @@ dsp_status bridge_deh_destroy(struct deh_mgr *deh_mgr)
 	/* Deallocate the DEH manager object */
 	MEM_FREE_OBJECT(deh_mgr);
 
+	/* The GPTimer is no longer needed */
+	omap_dm_timer_free(timer);
+	timer = NULL;
+
 	return DSP_SOK;
 }
 
@@ -177,6 +201,31 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 	return status;
 }
 
+static void wait_for_timer()
+{
+	int c;
+
+	omap_dm_timer_enable(timer);
+	/* Enable overflow interrupt */
+	omap_dm_timer_set_int_enable(timer,
+			GPTIMER_IRQ_OVERFLOW);
+	/*
+	 * Set counter value to overflow counter after
+	 * one tick and start timer.
+	 */
+	omap_dm_timer_set_load_start(timer, 0, 0xfffffffe);
+
+	/* Wait 80us for timer to overflow */
+	udelay(80);
+
+	/* Check interrupt status and wait for interrupt */
+	for (c = 0; c < GPTIMER_IRQ_WAIT_MAX_CNT; c++)
+		if ((omap_dm_timer_read_status(timer) & GPTIMER_IRQ_OVERFLOW))
+			return;
+
+	pr_err("%s: GPTimer interrupt failed\n", __func__);
+}
+
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct wmd_dev_context *dev_context;
@@ -241,9 +290,9 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 						HW_PAGE_SIZE4KB, 1,
 						&map_attrs, HW_SET, HW_SET);
 		}
-		/* send an interrupt to DSP */
-		omap_mbox_msg_send(dev_context->mbox,
-				MBX_DEH_CLASS | MBX_DEH_EMMU);
+
+		wait_for_timer();
+
 		/* Clear MMU interrupt */
 		hw_mmu_event_ack(resources.dw_dmmu_base,
 				HW_MMU_TRANSLATION_FAULT);
-- 
1.7.1

