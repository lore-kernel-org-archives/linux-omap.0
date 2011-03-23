From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/8] staging: tidspbridge: remove msleep for dsp transition wait
Date: Wed, 23 Mar 2011 12:49:48 -0600
Message-ID: <1300906193-1732-4-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562Ab1CWTBM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:12 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Remove msleep from the waiting loop used to the dsp
transition into a lower power state. Instead use jiffies
as the timeout count and do not sleep, otherwise when
protecting this functions through spin_lock_bh it will
cause a nasty BUG message to appear.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   41 ++++++++++-----------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index 69cc2c4..9595abc 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -81,7 +81,8 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 {
 	int status = 0;
 #ifdef CONFIG_PM
-	u16 timeout = PWRSTST_TIMEOUT / 10;
+	u8 t;
+	unsigned long v;
 	u32 pwr_state;
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	u32 opplevel;
@@ -90,18 +91,17 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
-	pwr_state = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD, OMAP2_PM_PWSTST) &
-						OMAP_POWERSTATEST_MASK;
 	/* Wait for DSP to move into OFF state */
-	while ((pwr_state != PWRDM_POWER_OFF) && --timeout) {
-		if (msleep_interruptible(10)) {
-			pr_err("Waiting for DSP OFF mode interrupted\n");
-			return -EPERM;
-		}
+	v = msecs_to_jiffies(PWRSTST_TIMEOUT) + jiffies;
+	do {
+		t = time_is_after_jiffies(v);
 		pwr_state = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD,
 					OMAP2_PM_PWSTST) & OMAP_POWERSTATEST_MASK;
-	}
-	if (timeout == 0) {
+		if (pwr_state == PWRDM_POWER_OFF)
+			break;
+	} while (t);
+
+	if (!t) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
 		status = -ETIMEDOUT;
 		return status;
@@ -154,7 +154,8 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 #ifdef CONFIG_TIDSPBRIDGE_NTFY_PWRERR
 	struct deh_mgr *hdeh_mgr;
 #endif /* CONFIG_TIDSPBRIDGE_NTFY_PWRERR */
-	u16 timeout = PWRSTST_TIMEOUT / 10;
+	u8 t;
+	unsigned long v;
 	u32 pwr_state, target_pwr_state;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
@@ -198,21 +199,17 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 		return -EPERM;
 	}
 
-	/* Get the PRCM DSP power domain status */
-	pwr_state = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD, OMAP2_PM_PWSTST) &
-						OMAP_POWERSTATEST_MASK;
-
 	/* Wait for DSP to move into target power state */
-	while ((pwr_state != target_pwr_state) && --timeout) {
-		if (msleep_interruptible(10)) {
-			pr_err("Waiting for DSP to Suspend interrupted\n");
-			return -EPERM;
-		}
+	v = msecs_to_jiffies(PWRSTST_TIMEOUT) + jiffies;
+	do {
+		t = time_is_after_jiffies(v);
 		pwr_state = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD,
 					OMAP2_PM_PWSTST) & OMAP_POWERSTATEST_MASK;
-	}
+		if (pwr_state == target_pwr_state)
+			break;
+	} while (t);
 
-	if (!timeout) {
+	if (!t) {
 		pr_err("%s: Timed out waiting for DSP off mode, state %x\n",
 		       __func__, pwr_state);
 #ifdef CONFIG_TIDSPBRIDGE_NTFY_PWRERR
-- 
1.7.1

