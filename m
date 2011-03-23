From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/8] staging: tidspbridge: make wake_dsp to handle PM code
Date: Wed, 23 Mar 2011 12:49:46 -0600
Message-ID: <1300906193-1732-2-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44774 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab1CWTBJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:09 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Instead of being a wrapper around sm_interrupt_dsp, make wake_dsp
to be the one actually waking up the dsp and handling clock
configurations. No impact for sm_interrupt_dsp since it now calls
wake_dsp and that function decides what to do based on internal
states.

This should help in encapsulating code capable of sleep/wake the
dsp into a single place.

While at it, change 'if' blocks to a 'switch'; and use
omap_mbox_msg_send to send the wake up command to the dsp.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   72 ++++++++++++++++++--
 drivers/staging/tidspbridge/core/tiomap_io.c      |   58 +---------------
 2 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index 02dd439..d5245a3 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -256,20 +256,76 @@ int wake_dsp(struct bridge_dev_context *dev_context, void *pargs)
 {
 	int status = 0;
 #ifdef CONFIG_PM
+#ifdef CONFIG_TIDSPBRIDGE_DVFS
+	u32 opplevel = 0;
+#endif
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
+	struct cfg_hostres *resources = dev_context->resources;
 
-	/* Check the board state, if it is not 'SLEEP' then return */
-	if (dev_context->brd_state == BRD_RUNNING ||
-	    dev_context->brd_state == BRD_STOPPED) {
-		/* The Device is in 'RET' or 'OFF' state and Bridge state is not
-		 * 'SLEEP', this means state inconsistency, so return */
+	if (!dev_context->mbox || !resources)
+		return -EPERM;
+
+	switch (dev_context->brd_state) {
+	case BRD_STOPPED:
+	case BRD_RUNNING:
 		return 0;
+	case BRD_RETENTION:
+		/* Restart the peripheral clocks */
+		dsp_clock_enable_all(dev_context->dsp_per_clks);
+
+		break;
+	case BRD_HIBERNATION:
+	case BRD_DSP_HIBERNATION:
+#ifdef CONFIG_TIDSPBRIDGE_DVFS
+		if (pdata->dsp_get_opp)
+			opplevel = (*pdata->dsp_get_opp) ();
+		if (opplevel == VDD1_OPP1) {
+			if (pdata->dsp_set_min_opp)
+				(*pdata->dsp_set_min_opp) (VDD1_OPP2);
+		}
+#endif
+		/* Restart the peripheral clocks */
+		dsp_clock_enable_all(dev_context->dsp_per_clks);
+
+		dsp_wdt_enable(true);
+
+		/*
+		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
+		 *     in CM_AUTOIDLE_PLL_IVA2 register
+		 */
+		(*pdata->dsp_cm_write)(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
+				OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+
+		/*
+		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
+		 *     0.75 MHz - 1.0 MHz
+		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
+		 */
+		(*pdata->dsp_cm_rmw_bits)(OMAP3430_IVA2_DPLL_FREQSEL_MASK |
+				OMAP3430_EN_IVA2_DPLL_MASK,
+				0x3 << OMAP3430_IVA2_DPLL_FREQSEL_SHIFT |
+				0x7 << OMAP3430_EN_IVA2_DPLL_SHIFT,
+				OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL);
+
+		/* Restore mailbox settings */
+		omap_mbox_restore_ctx(dev_context->mbox);
+
+		/* Access MMU SYS CONFIG register to generate a short wakeup */
+		readl(resources->dmmu_base + 0x10);
+
+		dev_context->brd_state = BRD_RUNNING;
+
+		break;
+	default:
+		pr_err("%s: unexpected state %x\n", __func__,
+						dev_context->brd_state);
+		return -EINVAL;
 	}
 
 	/* Send a wakeup message to DSP */
-	sm_interrupt_dsp(dev_context, MBX_PM_DSPWAKEUP);
+	status = omap_mbox_msg_send(dev_context->mbox, MBX_PM_DSPWAKEUP);
 
-	/* Set the device state to RUNNIG */
-	dev_context->brd_state = BRD_RUNNING;
 #endif /* CONFIG_PM */
 	return status;
 }
diff --git a/drivers/staging/tidspbridge/core/tiomap_io.c b/drivers/staging/tidspbridge/core/tiomap_io.c
index dfb356e..ff350e5 100644
--- a/drivers/staging/tidspbridge/core/tiomap_io.c
+++ b/drivers/staging/tidspbridge/core/tiomap_io.c
@@ -386,64 +386,14 @@ int write_ext_dsp_data(struct bridge_dev_context *dev_context,
 
 int sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val)
 {
-#ifdef CONFIG_TIDSPBRIDGE_DVFS
-	u32 opplevel = 0;
-#endif
-	struct omap_dsp_platform_data *pdata =
-		omap_dspbridge_dev->dev.platform_data;
-	struct cfg_hostres *resources = dev_context->resources;
-	int status = 0;
-	u32 temp;
+	int status;
 
 	if (!dev_context->mbox)
 		return 0;
 
-	if (!resources)
-		return -EPERM;
-
-	if (dev_context->brd_state == BRD_DSP_HIBERNATION ||
-	    dev_context->brd_state == BRD_HIBERNATION) {
-#ifdef CONFIG_TIDSPBRIDGE_DVFS
-		if (pdata->dsp_get_opp)
-			opplevel = (*pdata->dsp_get_opp) ();
-		if (opplevel == VDD1_OPP1) {
-			if (pdata->dsp_set_min_opp)
-				(*pdata->dsp_set_min_opp) (VDD1_OPP2);
-		}
-#endif
-		/* Restart the peripheral clocks */
-		dsp_clock_enable_all(dev_context->dsp_per_clks);
-		dsp_wdt_enable(true);
-
-		/*
-		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
-		 *     in CM_AUTOIDLE_PLL_IVA2 register
-		 */
-		(*pdata->dsp_cm_write)(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
-				OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL);
-
-		/*
-		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
-		 *     0.75 MHz - 1.0 MHz
-		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
-		 */
-		(*pdata->dsp_cm_rmw_bits)(OMAP3430_IVA2_DPLL_FREQSEL_MASK |
-				OMAP3430_EN_IVA2_DPLL_MASK,
-				0x3 << OMAP3430_IVA2_DPLL_FREQSEL_SHIFT |
-				0x7 << OMAP3430_EN_IVA2_DPLL_SHIFT,
-				OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL);
-
-		/* Restore mailbox settings */
-		omap_mbox_restore_ctx(dev_context->mbox);
-
-		/* Access MMU SYS CONFIG register to generate a short wakeup */
-		temp = readl(resources->dmmu_base + 0x10);
-
-		dev_context->brd_state = BRD_RUNNING;
-	} else if (dev_context->brd_state == BRD_RETENTION) {
-		/* Restart the peripheral clocks */
-		dsp_clock_enable_all(dev_context->dsp_per_clks);
-	}
+	status = wake_dsp(dev_context, NULL);
+	if (status)
+		return status;
 
 	status = omap_mbox_msg_send(dev_context->mbox, mb_val);
 
-- 
1.7.1

