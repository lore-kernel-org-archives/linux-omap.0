From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 09/13] OMAP: McBSP: use omap_device APIs to modify SYSCONFIG
Date: Mon, 31 Jan 2011 20:20:33 +0530
Message-ID: <1296485437-12806-10-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40385 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab1AaO4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 09:56:25 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
to be disabled before starting the sidetone. Also SYSCONFIG
register has to be set with smart idle or no idle depending on the
dma op mode (threshold or element sync). For doing these operations
dynamically at runtime, omap_device APIs are used to modify SYSCONFIG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   66 +++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 275a37a..9bc2c73 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,6 +27,7 @@
 
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
+#include <plat/omap_device.h>
 
 /* XXX These "sideways" includes are a sign that something is wrong */
 #include "../mach-omap2/cm2xxx_3xxx.h"
@@ -228,9 +229,19 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
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
@@ -244,8 +255,7 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+	omap_device_disable_autoidle(od);
 
 	/* Enable Sidetone from Sidetone Core */
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
@@ -255,12 +265,14 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
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
@@ -273,9 +285,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
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
 
@@ -303,9 +317,11 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
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
 
@@ -648,49 +664,37 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
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
+		if (mcbsp->dma_op_mode != MCBSP_DMA_MODE_THRESHOLD)
+			omap_device_noidle(od);
+		else
 			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-		} else {
-			syscon |= SIDLEMODE(0x01);
-		}
-
-		MCBSP_WRITE(mcbsp, SYSCON, syscon);
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

