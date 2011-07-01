From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 09/12] omap: mcbsp: Move OMAP3+ wakeup enable/disable to omap_mcbsp_request/_free
Date: Fri,  1 Jul 2011 11:52:33 +0300
Message-ID: <1309510356-27147-10-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab1GAIxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:11 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:10 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

There are only enable/disable wakeup behavior code left in
omap34xx_mcbsp_request/_free after hwmod conversion so it can be well moved
to generic omap_mcbsp_request/_free.

Remove also old comments about idle mode settings and HW bug workarounds
that were not updated during hwmod conversion.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |   43 +++++++++----------------------------------
 1 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 7511287..202292a 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -667,35 +667,7 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
-static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
-{
-	/*
-	 * Enable wakup behavior, smart idle and all wakeups
-	 * REVISIT: some wakeups may be unnecessary
-	 */
-	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3) {
-		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-	}
-}
-
-static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
-{
-	/*
-	 * Disable wakup behavior, smart idle and all wakeups
-	 */
-	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3) {
-		/*
-		 * HW bug workaround - If no_idle mode is taken, we need to
-		 * go to smart_idle before going to always_idle, or the
-		 * device will not hit retention anymore.
-		 */
-
-		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
-	}
-}
 #else
-static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp) {}
-static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp) {}
 static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
 static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
 #endif
@@ -734,8 +706,9 @@ int omap_mcbsp_request(unsigned int id)
 
 	pm_runtime_get_sync(mcbsp->dev);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_request(mcbsp);
+	/* Enable wakup behavior */
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
@@ -772,8 +745,9 @@ err_clk_disable:
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_free(mcbsp);
+	/* Disable wakup behavior */
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
 	pm_runtime_put_sync(mcbsp->dev);
 
@@ -802,8 +776,9 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_free(mcbsp);
+	/* Disable wakup behavior */
+	if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
 	pm_runtime_put_sync(mcbsp->dev);
 
-- 
1.7.0.4

