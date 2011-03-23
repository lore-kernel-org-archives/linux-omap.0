From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/8] staging: tidspbridge: send mbox PM command directly
Date: Wed, 23 Mar 2011 12:49:49 -0600
Message-ID: <1300906193-1732-5-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932628Ab1CWTBN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:13 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Instead of using sm_interrupt_dsp and checking for the power states,
send the sleep command directly since we are transitioning to sleep
anyway.

Also remove redundant calls to save_ctx in these cases.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index 9595abc..dd035af 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -156,6 +156,7 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 #endif /* CONFIG_TIDSPBRIDGE_NTFY_PWRERR */
 	u8 t;
 	unsigned long v;
+	u32 mbx_msg;
 	u32 pwr_state, target_pwr_state;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
@@ -166,21 +167,19 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 
 	switch (dev_context->brd_state) {
 	case BRD_RUNNING:
-		omap_mbox_save_ctx(dev_context->mbox);
 		if (dsp_test_sleepstate == PWRDM_POWER_OFF) {
-			sm_interrupt_dsp(dev_context, MBX_PM_DSPHIBERNATE);
+			mbx_msg = MBX_PM_DSPHIBERNATE;
 			dev_dbg(bridge, "PM: %s - sent hibernate cmd to DSP\n",
 				__func__);
 			target_pwr_state = PWRDM_POWER_OFF;
 		} else {
-			sm_interrupt_dsp(dev_context, MBX_PM_DSPRETENTION);
+			mbx_msg = MBX_PM_DSPRETENTION;
 			target_pwr_state = PWRDM_POWER_RET;
 		}
 		break;
 	case BRD_RETENTION:
-		omap_mbox_save_ctx(dev_context->mbox);
 		if (dsp_test_sleepstate == PWRDM_POWER_OFF) {
-			sm_interrupt_dsp(dev_context, MBX_PM_DSPHIBERNATE);
+			mbx_msg = MBX_PM_DSPHIBERNATE;
 			target_pwr_state = PWRDM_POWER_OFF;
 		} else
 			return 0;
@@ -199,6 +198,12 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 		return -EPERM;
 	}
 
+	omap_mbox_save_ctx(dev_context->mbox);
+
+	status = omap_mbox_msg_send(dev_context->mbox, mbx_msg);
+	if (status)
+		return status;
+
 	/* Wait for DSP to move into target power state */
 	v = msecs_to_jiffies(PWRSTST_TIMEOUT) + jiffies;
 	do {
-- 
1.7.1

