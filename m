From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 04/13] omap: mcbsp: Make wakeup control generic
Date: Mon, 26 Sep 2011 10:45:40 +0300
Message-ID: <1317023150-6730-5-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49007 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab1IZHqY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 03:46:24 -0400
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Currently wakeup control code is compiled only when CONFIG_ARCH_OMAP3 is
set even it should be available for CONFIG_ARCH_OMAP4 only builds also.

Fix this by making wakeup control generic so that it is executed whenever
new feature flag has_wakeup in platform data is set. Currently flag is set
for McBSP config types 3 and 4.

Remove also old comments about idle mode settings and HW bug workarounds
that were not updated during hwmod conversion.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap2/mcbsp.c             |    3 ++
 arch/arm/plat-omap/include/plat/mcbsp.h |    3 ++
 arch/arm/plat-omap/mcbsp.c              |   43 ++++++------------------------
 3 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 43b9ccf..de3457d 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -141,6 +141,9 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 			pdata->buffer_size = 0x80;
 	}
 
+	if (oh->class->rev >= MCBSP_CONFIG_TYPE3)
+		pdata->has_wakeup = true;
+
 	oh_device[0] = oh;
 
 	if (oh->dev_attr) {
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 14bc1cb..ac48d83 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -317,6 +317,9 @@ struct omap_mcbsp_platform_data {
 	u16 buffer_size;
 	u8 reg_size;
 	u8 reg_step;
+
+	/* McBSP platform and instance specific features */
+	bool has_wakeup; /* Wakeup capability */
 };
 
 struct omap_mcbsp_st_data {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 623f2c1..0338ad0 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -659,35 +659,7 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
-static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
-{
-	/*
-	 * Enable wakup behavior, smart idle and all wakeups
-	 * REVISIT: some wakeups may be unnecessary
-	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-	}
-}
-
-static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
-{
-	/*
-	 * Disable wakup behavior, smart idle and all wakeups
-	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
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
@@ -726,8 +698,9 @@ int omap_mcbsp_request(unsigned int id)
 
 	pm_runtime_get_sync(mcbsp->dev);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_request(mcbsp);
+	/* Enable wakeup behavior */
+	if (mcbsp->pdata->has_wakeup)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
@@ -764,8 +737,9 @@ err_clk_disable:
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_free(mcbsp);
+	/* Disable wakeup behavior */
+	if (mcbsp->pdata->has_wakeup)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
 	pm_runtime_put_sync(mcbsp->dev);
 
@@ -794,8 +768,9 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	/* Do procedure specific to omap34xx arch, if applicable */
-	omap34xx_mcbsp_free(mcbsp);
+	/* Disable wakeup behavior */
+	if (mcbsp->pdata->has_wakeup)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
 	pm_runtime_put_sync(mcbsp->dev);
 
-- 
1.7.6.3

