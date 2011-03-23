From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/8] staging: tidspbridge: remove redundant code from PM routines
Date: Wed, 23 Mar 2011 12:49:51 -0600
Message-ID: <1300906193-1732-7-git-send-email-omar.ramirez@ti.com>
References: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60774 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932643Ab1CWTBP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 15:01:15 -0400
In-Reply-To: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Trivial cleanup to remove redundant code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index 93c441c..cb2a873 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -103,8 +103,7 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 
 	if (!t) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
-		status = -ETIMEDOUT;
-		return status;
+		return -ETIMEDOUT;
 	} else {
 
 		/* Save mailbox settings */
@@ -122,10 +121,8 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 			status =
 			    dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
-			if (!hio_mgr) {
-				status = DSP_EHANDLE;
-				return status;
-			}
+			if (!hio_mgr)
+				return -EINVAL;
 			io_sh_msetting(hio_mgr, SHM_GETOPP, &opplevel);
 
 			/*
@@ -134,7 +131,6 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 			 */
 			if (pdata->dsp_set_min_opp)
 				(*pdata->dsp_set_min_opp) (VDD1_OPP1);
-			status = 0;
 #endif /* CONFIG_TIDSPBRIDGE_DVFS */
 		}
 	}
-- 
1.7.1

