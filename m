From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification for MCBSP
Date: Tue,  5 Oct 2010 22:07:41 +0530
Message-ID: <1286296662-7639-6-git-send-email-kishon@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0JEQkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 12:40:04 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o95Ge0aQ030602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 11:40:03 -0500
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nskamat@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
autoidle to be disabled before starting the sidetone. Also SYSCONFIG
register has to be set with smart idle or no idle depending on the
dma op mode (threshold or element sync). For doing these operations
dynamically at runtime, hwmod API'S are used to modify SYSCONFIG register
directly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Partha Basak <p-basak2@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   69 ++++++++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index c7c6a83..6b705e1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -228,10 +228,21 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 EXPORT_SYMBOL(omap_mcbsp_config);
 
 #ifdef CONFIG_ARCH_OMAP3
+static struct omap_hwmod **find_hwmods_by_dev(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct omap_device *od;
+	pdev = container_of(dev, struct platform_device, dev);
+	od = container_of(pdev, struct omap_device, pdev);
+	return od->hwmods;
+}
+
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
+	struct omap_hwmod **oh;
 
+	oh = find_hwmods_by_dev(mcbsp->dev);
 	/*
 	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
 	 * are enabled or sidetones start sounding ugly.
@@ -244,8 +255,7 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+	omap_hwmod_set_module_autoidle(oh[1], 0);
 
 	/* Enable Sidetone from Sidetone Core */
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
@@ -255,12 +265,14 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 static void omap_st_off(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
+	struct omap_hwmod **oh;
+
+	oh = find_hwmods_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 	MCBSP_ST_WRITE(mcbsp, SSELCR, w & ~(ST_SIDETONEEN));
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
+	omap_hwmod_set_module_autoidle(oh[1], 1);
 
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
@@ -273,9 +285,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 {
 	u16 val, i;
+	struct omap_hwmod **oh;
 
-	val = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, val & ~(ST_AUTOIDLE));
+	oh = find_hwmods_by_dev(mcbsp->dev);
+
+	omap_hwmod_set_module_autoidle(oh[1], 0);
 
 	val = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -303,9 +317,11 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 {
 	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	struct omap_hwmod **oh;
+
+	oh = find_hwmods_by_dev(mcbsp->dev);
 
-	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
-	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+	omap_hwmod_set_module_autoidle(oh[1], 0);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -648,49 +664,46 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
+	struct omap_hwmod **oh;
+
+	oh = find_hwmods_by_dev(mcbsp->dev);
 	/*
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
 	 */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		u16 syscon;
-
-		syscon = MCBSP_READ(mcbsp, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
-			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
-					CLOCKACTIVITY(0x02));
-			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
+			omap_hwmod_enable_wakeup(oh[0]);
+			omap_hwmod_set_slave_idlemode(oh[0],
+						HWMOD_IDLEMODE_SMART);
 		} else {
-			syscon |= SIDLEMODE(0x01);
+			omap_hwmod_disable_wakeup(oh[0]);
+			omap_hwmod_set_slave_idlemode(oh[0],
+						HWMOD_IDLEMODE_NO);
 		}
-
-		MCBSP_WRITE(mcbsp, SYSCON, syscon);
 	}
 }
 
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
+	struct omap_hwmod **oh;
+
+	oh = find_hwmods_by_dev(mcbsp->dev);
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
+		omap_hwmod_disable_wakeup(oh[0]);
+		omap_hwmod_set_slave_idlemode(oh[0],
+					HWMOD_IDLEMODE_SMART);
+		omap_hwmod_set_slave_idlemode(oh[0],
+					HWMOD_IDLEMODE_FORCE);
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 	}
 }
-- 
1.7.0.4

