From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 09/10] OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
Date: Tue, 21 Dec 2010 13:10:29 +0530
Message-ID: <1292917231-13800-9-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757853Ab0LUHmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:03 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
to be disabled before starting the sidetone. Also SYSCONFIG
register has to be set with smart idle or no idle depending on the
dma op mode (threshold or element sync). For doing these operations
dynamically at runtime, omap_device APIs are used to modify SYSCONFIG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   66 ++++++++++++++++++++++---------------------
 1 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0adffea..9a0f76a 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,6 +27,7 @@
 
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
+#include <plat/omap_device.h>
 
 #include "../mach-omap2/cm-regbits-34xx.h"
 
@@ -226,9 +227,19 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 EXPORT_SYMBOL(omap_mcbsp_config);
 
 #ifdef CONFIG_ARCH_OMAP3
+static struct omap_device *find_omap_device_by_dev(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
+	return container_of(pdev, struct omap_device, pdev);
+}
+
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
+	struct omap_device *od;
+
+	od = find_omap_device_by_dev(mcbsp->dev);
 
 	/*
 	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
@@ -242,8 +253,7 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+	omap_device_disable_autoidle(od);
 
 	/* Enable Sidetone from Sidetone Core */
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
@@ -253,12 +263,14 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 static void omap_st_off(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
+	struct omap_device *od;
+
+	od = find_omap_device_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 	MCBSP_ST_WRITE(mcbsp, SSELCR, w & ~(ST_SIDETONEEN));
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
+	omap_device_enable_autoidle(od);
 
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
@@ -271,9 +283,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 {
 	u16 val, i;
+	struct omap_device *od;
 
-	val = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, val & ~(ST_AUTOIDLE));
+	od = find_omap_device_by_dev(mcbsp->dev);
+
+	omap_device_disable_autoidle(od);
 
 	val = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -301,9 +315,11 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 {
 	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	struct omap_device *od;
+
+	od = find_omap_device_by_dev(mcbsp->dev);
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+	omap_device_disable_autoidle(od);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -646,49 +662,35 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
+	struct omap_device *od;
+
+	od = find_omap_device_by_dev(mcbsp->dev);
 	/*
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
 	 */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		u16 syscon;
-
-		syscon = MCBSP_READ(mcbsp, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
-
-		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
-			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
-					CLOCKACTIVITY(0x02));
-			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-		} else {
-			syscon |= SIDLEMODE(0x01);
-		}
-
-		MCBSP_WRITE(mcbsp, SYSCON, syscon);
+		if (mcbsp->dma_op_mode != MCBSP_DMA_MODE_THRESHOLD)
+			omap_device_noidle(od);
 	}
 }
 
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
+	struct omap_device *od;
+
+	od = find_omap_device_by_dev(mcbsp->dev);
+
 	/*
 	 * Disable wakup behavior, smart idle and all wakeups
 	 */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		u16 syscon;
-
-		syscon = MCBSP_READ(mcbsp, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		/*
 		 * HW bug workaround - If no_idle mode is taken, we need to
 		 * go to smart_idle before going to always_idle, or the
 		 * device will not hit retention anymore.
 		 */
-		syscon |= SIDLEMODE(0x02);
-		MCBSP_WRITE(mcbsp, SYSCON, syscon);
-
-		syscon &= ~(SIDLEMODE(0x03));
-		MCBSP_WRITE(mcbsp, SYSCON, syscon);
-
+		omap_device_default_idle(od);
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 	}
 }
-- 
1.7.0.4

