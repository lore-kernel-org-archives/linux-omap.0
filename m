From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 8/8] staging: tidspbridge: protect critical sections on PM routines
Date: Wed, 23 Mar 2011 12:49:53 -0600
Message-ID: <1300906193-1732-9-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44791 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659Ab1CWTBR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:17 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

To fix some race conditions which:

- Wake the dsp, through the GFLUSH register, while tidspbridge has
  initiated a power off transition but hasn't disabled the peripheral
  clocks nor set the brd_state to HIB or self HIB. This cancels dsp
  transition but cuts off the clocks.

- Wake the dsp, through sm_interrupt_dsp, same as above.

- Wake the domain only, if the peripheral clocks have been cut, the
  IVA domain is woken but no response recieved until the peripheral
  clocks are reenabled. This triggers another race; when waking the
  dsp, clocks are reenabled and dsp starts its resume sequence,
  however dmtimer framework also resets the GPT clocks as part of
  its 'request' routine, which leaves the dsp without tick and unable
  to transition between power states.

It fixes the following future races, if IVA clock is enabled/disabled
in PM routines:

- Depending on timing it can cause an abort while accessing MMU
  registers from mpu side.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   32 +++++++++++++++++++--
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index 95089ef..fdbf4eb 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -49,6 +49,8 @@
 
 #define PWRSTST_TIMEOUT          200
 
+DEFINE_SPINLOCK(pwr_lock);
+
 /*
  *  ======== handle_constraints_set ========
  *  	Sets new DSP constraint
@@ -91,6 +93,8 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
+	spin_lock_bh(&pwr_lock);
+
 	/* Wait for DSP to move into OFF state */
 	v = msecs_to_jiffies(PWRSTST_TIMEOUT) + jiffies;
 	do {
@@ -103,6 +107,7 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 
 	if (!t) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
+		spin_unlock_bh(&pwr_lock);
 		return -ETIMEDOUT;
 	}
 
@@ -111,14 +116,19 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 
 	/* Turn off DSP Peripheral clocks and DSP Load monitor timer */
 	status = dsp_clock_disable_all(dev_context->dsp_per_clks);
-	if (status)
+	if (status) {
+		spin_unlock_bh(&pwr_lock);
 		return status;
+	}
 
 	/* Disable wdt on hibernation. */
 	dsp_wdt_enable(false);
 
 	/* Update the Bridger Driver state */
 	dev_context->brd_state = BRD_DSP_HIBERNATION;
+
+	spin_unlock_bh(&pwr_lock);
+
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	status = dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
 	if (!hio_mgr)
@@ -189,11 +199,15 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 		return -EPERM;
 	}
 
+	spin_lock_bh(&pwr_lock);
+
 	omap_mbox_save_ctx(dev_context->mbox);
 
 	status = omap_mbox_msg_send(dev_context->mbox, mbx_msg);
-	if (status)
+	if (status) {
+		spin_unlock_bh(&pwr_lock);
 		return status;
+	}
 
 	/* Wait for DSP to move into target power state */
 	v = msecs_to_jiffies(PWRSTST_TIMEOUT) + jiffies;
@@ -212,6 +226,7 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 		dev_get_deh_mgr(dev_context->dev_obj, &hdeh_mgr);
 		bridge_deh_notify(hdeh_mgr, DSP_PWRERROR, 0);
 #endif /* CONFIG_TIDSPBRIDGE_NTFY_PWRERR */
+		spin_unlock_bh(&pwr_lock);
 		return -ETIMEDOUT;
 	}
 
@@ -226,8 +241,13 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 
 	/* Turn off DSP Peripheral clocks */
 	status = dsp_clock_disable_all(dev_context->dsp_per_clks);
-	if (status)
+	if (status) {
+		spin_unlock_bh(&pwr_lock);
 		return status;
+	}
+
+	spin_unlock_bh(&pwr_lock);
+
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	if (target_pwr_state == PWRDM_POWER_OFF) {
 		/*
@@ -259,8 +279,11 @@ int wake_dsp(struct bridge_dev_context *dev_context, void *pargs)
 	if (!dev_context->mbox || !resources)
 		return -EPERM;
 
+	spin_lock_bh(&pwr_lock);
+
 	switch (dev_context->brd_state) {
 	case BRD_STOPPED:
+		spin_unlock_bh(&pwr_lock);
 		return 0;
 	case BRD_RUNNING:
 		break;
@@ -318,12 +341,15 @@ int wake_dsp(struct bridge_dev_context *dev_context, void *pargs)
 	default:
 		pr_err("%s: unexpected state %x\n", __func__,
 						dev_context->brd_state);
+		spin_unlock_bh(&pwr_lock);
 		return -EINVAL;
 	}
 
 	/* Send a wakeup message to DSP */
 	status = omap_mbox_msg_send(dev_context->mbox, MBX_PM_DSPWAKEUP);
 
+	spin_unlock_bh(&pwr_lock);
+
 #endif /* CONFIG_PM */
 	return status;
 }
-- 
1.7.1

