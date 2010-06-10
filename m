From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: reorganize gpt8 overflow handling
Date: Thu, 10 Jun 2010 07:14:05 -0500
Message-ID: <1276172045-17267-2-git-send-email-omar.ramirez@ti.com>
References: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44205 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab0FJMVW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 08:21:22 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5ACLM7H003982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Jun 2010 07:21:22 -0500
In-Reply-To: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ernesto Ramos Falcon <ernesto@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

New function to encapsulate previous code to configure gpt overflow,
this prevents accessing dmtimer framework outside dsp-clock interface
or exposing clock handles to other bridge modules.

Besides that: duplicated and unused defines were removed, conditional
test for cnt was replaced for a time after jiffes macro.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Signed-off-by: Ernesto Ramos Falcon <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    2 +
 drivers/dsp/bridge/core/dsp-clock.c        |   38 ++++++++++++++++++
 drivers/dsp/bridge/core/ue_deh.c           |   59 ++-------------------------
 3 files changed, 45 insertions(+), 54 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 0814e92..61474bc 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -62,6 +62,8 @@ extern void dsp_clk_exit(void);
  */
 extern void dsp_clk_init(void);
 
+void dsp_gpt_wait_overflow(short int clk_id, unsigned int load);
+
 /*
  *  ======== dsp_clk_enable ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/core/dsp-clock.c b/drivers/dsp/bridge/core/dsp-clock.c
index dba0535..dde63bd 100644
--- a/drivers/dsp/bridge/core/dsp-clock.c
+++ b/drivers/dsp/bridge/core/dsp-clock.c
@@ -192,6 +192,44 @@ static void mcbsp_clk_prepare(bool flag, u8 id)
 	}
 }
 
+/**
+ * dsp_gpt_wait_overflow - set gpt overflow and wait for fixed timeout
+ * @clk_id:      GP Timer clock id.
+ * @load:        Overflow value.
+ *
+ * Sets an overflow interrupt for the desired GPT waiting for a timeout
+ * of 5 msecs for the interrupt to occur.
+ */
+void dsp_gpt_wait_overflow(short int clk_id, unsigned int load)
+{
+	struct omap_dm_timer *gpt = timer[clk_id - 1];
+	unsigned long timeout;
+
+	if (!gpt)
+		return;
+
+	/* Enable overflow interrupt */
+	omap_dm_timer_set_int_enable(gpt, OMAP_TIMER_INT_OVERFLOW);
+
+	/*
+	 * Set counter value to overflow counter after
+	 * one tick and start timer.
+	 */
+	omap_dm_timer_set_load_start(gpt, 0, load);
+
+	/* Wait 80us for timer to overflow */
+	udelay(80);
+
+	timeout = msecs_to_jiffies(5);
+	/* Check interrupt status and wait for interrupt */
+	while (!(omap_dm_timer_read_status(gpt) & OMAP_TIMER_INT_OVERFLOW)) {
+		if (time_is_after_jiffies(timeout)) {
+			pr_err("%s: GPTimer interrupt failed\n", __func__);
+			break;
+		}
+	}
+}
+
 /*
  *  ======== dsp_clk_enable ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index fa0cc71..cf084cf 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -18,7 +18,6 @@
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
-#include <plat/dmtimer.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -29,6 +28,7 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/cfg.h>
+#include <dspbridge/clk.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/drv.h>
 
@@ -54,13 +54,6 @@
 
 #define ALIGN_DOWN(x, a)  ((x)&(~((a)-1)))
 
-/* GP Timer number to trigger interrupt for MMU-fault ISR on DSP */
-#define GPTIMER_FOR_DSP_MMU_FAULT      8
-/* Bit mask to enable overflow interrupt */
-#define GPTIMER_IRQ_OVERFLOW           2
-/* Max time to check for GP Timer IRQ */
-#define GPTIMER_IRQ_WAIT_MAX_CNT       1000
-
 static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
 	HW_ELEM_SIZE16BIT,
 	HW_MMU_CPUES
@@ -123,17 +116,7 @@ err:
 		/* If create failed, cleanup */
 		bridge_deh_destroy(deh_mgr);
 		deh_mgr = NULL;
-	} else {
-		timer = omap_dm_timer_request_specific(
-					GPTIMER_FOR_DSP_MMU_FAULT);
-		if (timer) {
-			omap_dm_timer_disable(timer);
-		} else {
-			pr_err("%s: GPTimer not available\n", __func__);
-			return -ENODEV;
-		}
 	}
-
 leave:
 	*ret_deh_mgr = deh_mgr;
 
@@ -161,10 +144,6 @@ int bridge_deh_destroy(struct deh_mgr *deh_mgr)
 	/* Deallocate the DEH manager object */
 	kfree(deh_mgr);
 
-	/* The GPTimer is no longer needed */
-	omap_dm_timer_free(timer);
-	timer = NULL;
-
 	return 0;
 }
 
@@ -194,7 +173,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	u32 hw_mmu_max_tlb_count = 31;
 	struct cfg_hostres *resources;
 	hw_status hw_status_obj;
-	u32 cnt = 0;
 
 	if (!deh_mgr)
 		return;
@@ -253,42 +231,15 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 						&map_attrs, HW_SET, HW_SET);
 		}
 
-		/*
-		 * Send a GP Timer interrupt to DSP.
-		 * The DSP expects a GP timer interrupt after an
-		 * MMU-Fault Request GPTimer.
-		 */
-		if (timer) {
-			omap_dm_timer_enable(timer);
-			/* Enable overflow interrupt */
-			omap_dm_timer_set_int_enable(timer,
-						     GPTIMER_IRQ_OVERFLOW);
-			/*
-			 * Set counter value to overflow counter after
-			 * one tick and start timer.
-			 */
-			omap_dm_timer_set_load_start(timer, 0, 0xfffffffe);
-
-			/* Wait 80us for timer to overflow */
-			udelay(80);
-
-			/* Check interrupt status and wait for interrupt */
-			cnt = 0;
-			while (!(omap_dm_timer_read_status(timer) &
-				GPTIMER_IRQ_OVERFLOW)) {
-				if (cnt++ >= GPTIMER_IRQ_WAIT_MAX_CNT) {
-					pr_err("%s: GPTimer interrupt failed\n",
-								__func__);
-					break;
-				}
-			}
-		}
+		dsp_clk_enable(DSP_CLK_GPT8);
+
+		dsp_gpt_wait_overflow(DSP_CLK_GPT8, 0xfffffffe);
 
 		/* Clear MMU interrupt */
 		hw_mmu_event_ack(resources->dw_dmmu_base,
 				HW_MMU_TRANSLATION_FAULT);
 		dump_dsp_stack(deh_mgr->hbridge_context);
-		omap_dm_timer_disable(timer);
+		dsp_clk_disable(DSP_CLK_GPT8);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
-- 
1.7.1

