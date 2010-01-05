From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/10] OMAP2 clockdomain: modem clockdomain is only present on
	OMAP2430
Date: Tue, 05 Jan 2010 15:54:50 -0700
Message-ID: <20100105225448.16474.88330.stgit@localhost.localdomain>
References: <20100105225217.16474.44114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49853 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab0AEW6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 17:58:22 -0500
In-Reply-To: <20100105225217.16474.44114.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For some reason, previously, we included the MDM clockdomain on all 24xx,
but the stacked die-on-die modem configuration (chassis mode) is only
available on OMAP2430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains.h |   49 ++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 894973c..1df12c7 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -110,10 +110,10 @@ static struct clkdm_dep dsp_24xx_wkdeps[] = {
 };
 
 /*
- * 2420/2430 PM_WKDEP_MDM: CORE, MPU, WKUP
- * XXX This is probably 2430-only; 2420 did not have a stacked modem config.
+ * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2430 adds MDM
  */
-static struct clkdm_dep mdm_24xx_wkdeps[] = {
+static struct clkdm_dep mpu_24xx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
@@ -123,31 +123,35 @@ static struct clkdm_dep mdm_24xx_wkdeps[] = {
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
-		.clkdm_name = "mpu_clkdm",
+		.clkdm_name = "dsp_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
+	{
+		.clkdm_name = "mdm_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
 	{ NULL },
 };
 
 /*
- * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
  * 2430 adds MDM
  */
-static struct clkdm_dep mpu_24xx_wkdeps[] = {
+static struct clkdm_dep core_24xx_wkdeps[] = {
 	{
-		.clkdm_name = "core_l3_clkdm",
+		.clkdm_name = "dsp_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
-		.clkdm_name = "core_l4_clkdm",
+		.clkdm_name = "gfx_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
-		.clkdm_name = "dsp_clkdm",
+		.clkdm_name = "mpu_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
@@ -161,17 +165,21 @@ static struct clkdm_dep mpu_24xx_wkdeps[] = {
 	{ NULL },
 };
 
-/*
- * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
- * 2430 adds MDM
- */
-static struct clkdm_dep core_24xx_wkdeps[] = {
+#endif
+
+
+/* 2430-specific possible wakeup dependencies */
+
+#ifdef CONFIG_ARCH_OMAP2430
+
+/* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
+static struct clkdm_dep mdm_2430_wkdeps[] = {
 	{
-		.clkdm_name = "dsp_clkdm",
+		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
-		.clkdm_name = "gfx_clkdm",
+		.clkdm_name = "core_l4_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
 	{
@@ -182,14 +190,11 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 		.clkdm_name = "wkup_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
 	},
-	{
-		.clkdm_name = "mdm_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
 	{ NULL },
 };
 
-#endif
+#endif /* CONFIG_ARCH_OMAP2430 */
+
 
 /* 34XX-specific possible dependencies */
 
@@ -549,7 +554,7 @@ static struct clockdomain mdm_clkdm = {
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-	.wkdep_srcs	= mdm_24xx_wkdeps,
+	.wkdep_srcs	= mdm_2430_wkdeps,
 	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };


