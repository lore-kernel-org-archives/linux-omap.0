From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 10/16] OMAP3: PM: Cleaning up of smartreflex header file.
Date: Wed, 24 Feb 2010 14:59:11 +0530
Message-ID: <1267003757-22456-11-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
 <1267003757-22456-9-git-send-email-thara@ti.com>
 <1267003757-22456-10-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43658 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab0BXJ3c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:32 -0500
In-Reply-To: <1267003757-22456-10-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch cleans up smartreflex.h removing all unnecessary and
duplicate definitions.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.h |   99 +++++++++++++++++++++---------------
 1 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 986f4df..7a1f0c7 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -18,20 +18,6 @@
 
 extern struct dentry *pm_dbg_main_dir;
 
-#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
-
-/* SMART REFLEX REG ADDRESS OFFSET */
-#define SRCONFIG	0x00
-#define SRSTATUS	0x04
-#define SENVAL		0x08
-#define SENMIN		0x0C
-#define SENMAX		0x10
-#define SENAVG		0x14
-#define AVGWEIGHT	0x18
-#define NVALUERECIPROCAL	0x1C
-#define SENERROR	0x20
-#define ERRCONFIG	0x24
-
 /* SR Modules */
 #define SR1		1
 #define SR2		2
@@ -39,37 +25,38 @@ extern struct dentry *pm_dbg_main_dir;
 #define GAIN_MAXLIMIT	16
 #define R_MAXLIMIT	256
 
-#define SR1_CLK_ENABLE	BIT(6)
-#define SR2_CLK_ENABLE	BIT(7)
+/* SMART REFLEX REG ADDRESS OFFSET */
+#define SRCONFIG		0x00
+#define SRSTATUS		0x04
+#define SENVAL			0x08
+#define SENMIN			0x0C
+#define SENMAX			0x10
+#define SENAVG			0x14
+#define AVGWEIGHT		0x18
+#define NVALUERECIPROCAL	0x1C
+#define SENERROR		0x20
+#define ERRCONFIG		0x24
 
-/* SRCONFIG */
-#define SR1_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
-#define SR2_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
-
-#define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
-#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
-#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
-#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
-#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
+/* Bit/Shift Positions */
 
+/* SRCONFIG */
+#define SRCONFIG_ACCUMDATA_SHIFT	22
 #define SRCONFIG_SRCLKLENGTH_SHIFT	12
 #define SRCONFIG_SENNENABLE_SHIFT	5
 #define SRCONFIG_SENPENABLE_SHIFT	3
+#define SRCONFIG_CLKCTRL_SHIFT		0
+
+#define SRCONFIG_ACCUMDATA_MASK		(0x3FF << 22)
 
 #define SRCONFIG_SRENABLE		BIT(11)
 #define SRCONFIG_SENENABLE		BIT(10)
 #define SRCONFIG_ERRGEN_EN		BIT(9)
 #define SRCONFIG_MINMAXAVG_EN		BIT(8)
-
 #define SRCONFIG_DELAYCTRL		BIT(2)
-#define SRCONFIG_CLKCTRL		(0x00 << 0)
 
 /* AVGWEIGHT */
-#define SR1_AVGWEIGHT_SENPAVGWEIGHT	(0x03 << 2)
-#define SR1_AVGWEIGHT_SENNAVGWEIGHT	(0x03 << 0)
-
-#define SR2_AVGWEIGHT_SENPAVGWEIGHT	BIT(2)
-#define SR2_AVGWEIGHT_SENNAVGWEIGHT	BIT(0)
+#define AVGWEIGHT_SENPAVGWEIGHT_SHIFT	2
+#define AVGWEIGHT_SENNAVGWEIGHT_SHIFT	0
 
 /* NVALUERECIPROCAL */
 #define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
@@ -78,25 +65,55 @@ extern struct dentry *pm_dbg_main_dir;
 #define NVALUERECIPROCAL_RNSENN_SHIFT	0
 
 /* ERRCONFIG */
-#define SR_CLKACTIVITY_MASK		(0x03 << 20)
+#define ERRCONFIG_ERRWEIGHT_SHIFT	16
+#define ERRCONFIG_ERRMAXLIMIT_SHIFT	8
+#define ERRCONFIG_ERRMiNLIMIT_SHIFT	0
+
 #define SR_ERRWEIGHT_MASK		(0x07 << 16)
 #define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
 #define SR_ERRMINLIMIT_MASK		(0xFF << 0)
 
 #define ERRCONFIG_VPBOUNDINTEN		BIT(31)
 #define ERRCONFIG_VPBOUNDINTST		BIT(30)
+#define	ERRCONFIG_MCUACCUMINTEN		BIT(29)
+#define ERRCONFIG_MCUACCUMINTST		BIT(28)
+#define	ERRCONFIG_MCUVALIDINTEN		BIT(27)
+#define ERRCONFIG_MCUVALIDINTST		BIT(26)
+#define ERRCONFIG_MCUBOUNDINTEN		BIT(25)
+#define	ERRCONFIG_MCUBOUNDINTST		BIT(24)
+#define	ERRCONFIG_MCUDISACKINTEN	BIT(23)
+#define ERRCONFIG_MCUDISACKINTST	BIT(22)
 
-#define SR1_ERRWEIGHT			(0x07 << 16)
-#define SR1_ERRMAXLIMIT			(0x02 << 8)
-#define SR1_ERRMINLIMIT			(0xFA << 0)
+/* Common Bit values */
 
-#define SR2_ERRWEIGHT			(0x07 << 16)
-#define SR2_ERRMAXLIMIT			(0x02 << 8)
-#define SR2_ERRMINLIMIT			(0xF9 << 0)
+#define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
+#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
+#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
+#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
+#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
 
-/* Vmode control */
-#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
+/*
+ * 3430 specific values. Maybe these should be passed from board file or
+ * pmic structures.
+ */
+#define OMAP3430_SR_ACCUMDATA		0x1F4
+
+#define OMAP3430_SR1_SENPAVGWEIGHT	0x03
+#define OMAP3430_SR1_SENNAVGWEIGHT	0x03
+
+#define OMAP3430_SR2_SENPAVGWEIGHT	0x01
+#define OMAP3430_SR2_SENNAVGWEIGHT	0x01
 
+#define OMAP3430_SR_ERRWEIGHT		0x07
+#define OMAP3430_SR_ERRMAXLIMIT		0x02
+#define OMAP3430_SR1_ERRMINLIMIT	0xFA
+#define OMAP3430_SR2_ERRMINLIMIT	0xF9
+
+/* TODO:3630/OMAP4 values if it has to come from this file */
+
+/* Info for enabling SR in T2/gaia. ToDo: Move it to twl4030_power.c */
+#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
+#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
 /* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
 #define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
 
-- 
1.7.0.rc1.33.g07cf0f

