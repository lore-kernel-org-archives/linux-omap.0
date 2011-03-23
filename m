From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 7/8] staging: tidspbridge: remove redundant indentation in PM routines
Date: Wed, 23 Mar 2011 12:49:52 -0600
Message-ID: <1300906193-1732-8-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47142 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657Ab1CWTBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Mar 2011 15:01:16 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Trivial cleaunp to remove redundant indentation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   87 ++++++++++-----------
 1 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index cb2a873..95089ef 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -104,36 +104,31 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 	if (!t) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
 		return -ETIMEDOUT;
-	} else {
+	}
 
-		/* Save mailbox settings */
-		omap_mbox_save_ctx(dev_context->mbox);
+	/* Save mailbox settings */
+	omap_mbox_save_ctx(dev_context->mbox);
 
-		/* Turn off DSP Peripheral clocks and DSP Load monitor timer */
-		status = dsp_clock_disable_all(dev_context->dsp_per_clks);
+	/* Turn off DSP Peripheral clocks and DSP Load monitor timer */
+	status = dsp_clock_disable_all(dev_context->dsp_per_clks);
+	if (status)
+		return status;
 
-		/* Disable wdt on hibernation. */
-		dsp_wdt_enable(false);
+	/* Disable wdt on hibernation. */
+	dsp_wdt_enable(false);
 
-		if (!status) {
-			/* Update the Bridger Driver state */
-			dev_context->brd_state = BRD_DSP_HIBERNATION;
+	/* Update the Bridger Driver state */
+	dev_context->brd_state = BRD_DSP_HIBERNATION;
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
-			status =
-			    dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
-			if (!hio_mgr)
-				return -EINVAL;
-			io_sh_msetting(hio_mgr, SHM_GETOPP, &opplevel);
-
-			/*
-			 * Set the OPP to low level before moving to OFF
-			 * mode
-			 */
-			if (pdata->dsp_set_min_opp)
-				(*pdata->dsp_set_min_opp) (VDD1_OPP1);
+	status = dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
+	if (!hio_mgr)
+		return -EINVAL;
+	io_sh_msetting(hio_mgr, SHM_GETOPP, &opplevel);
+
+	/* Set the OPP to low level before moving to OFF mode */
+	if (pdata->dsp_set_min_opp)
+		(*pdata->dsp_set_min_opp) (VDD1_OPP1);
 #endif /* CONFIG_TIDSPBRIDGE_DVFS */
-		}
-	}
 #endif
 	return status;
 }
@@ -218,30 +213,30 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 		bridge_deh_notify(hdeh_mgr, DSP_PWRERROR, 0);
 #endif /* CONFIG_TIDSPBRIDGE_NTFY_PWRERR */
 		return -ETIMEDOUT;
-	} else {
-		/* Update the Bridger Driver state */
-		if (dsp_test_sleepstate == PWRDM_POWER_OFF)
-			dev_context->brd_state = BRD_HIBERNATION;
-		else
-			dev_context->brd_state = BRD_RETENTION;
-
-		/* Disable wdt on hibernation. */
-		dsp_wdt_enable(false);
-
-		/* Turn off DSP Peripheral clocks */
-		status = dsp_clock_disable_all(dev_context->dsp_per_clks);
-		if (status)
-			return status;
+	}
+
+	/* Update the Bridger Driver state */
+	if (dsp_test_sleepstate == PWRDM_POWER_OFF)
+		dev_context->brd_state = BRD_HIBERNATION;
+	else
+		dev_context->brd_state = BRD_RETENTION;
+
+	/* Disable wdt on hibernation. */
+	dsp_wdt_enable(false);
+
+	/* Turn off DSP Peripheral clocks */
+	status = dsp_clock_disable_all(dev_context->dsp_per_clks);
+	if (status)
+		return status;
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
-		else if (target_pwr_state == PWRDM_POWER_OFF) {
-			/*
-			 * Set the OPP to low level before moving to OFF mode
-			 */
-			if (pdata->dsp_set_min_opp)
-				(*pdata->dsp_set_min_opp) (VDD1_OPP1);
-		}
-#endif /* CONFIG_TIDSPBRIDGE_DVFS */
+	if (target_pwr_state == PWRDM_POWER_OFF) {
+		/*
+		 * Set the OPP to low level before moving to OFF mode
+		 */
+		if (pdata->dsp_set_min_opp)
+			(*pdata->dsp_set_min_opp) (VDD1_OPP1);
 	}
+#endif /* CONFIG_TIDSPBRIDGE_DVFS */
 #endif /* CONFIG_PM */
 	return status;
 }
-- 
1.7.1

