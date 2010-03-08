From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 2/3] OMAP3: PM: Smartreflex IP update changes for OMAP3630
Date: Mon,  8 Mar 2010 22:50:50 +0530
Message-ID: <1268068851-30022-3-git-send-email-thara@ti.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab0CHRVG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 12:21:06 -0500
In-Reply-To: <1268068851-30022-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

OMAP3430 uses the 65nm version of the smartreflex IP where as
OMAP3630 and OMAP4430 uses the 45nm updated IP.

This patch adds support for the updated smartreflex IP used
in OMAP3630 and OMAP4 in the smartreflex driver.

Major changes between the two versions of IP involve:
1. Change in offset position for ERRCONFIG and SENERROR registers
2. Change in bit positions for VP bound interrupt enable and status
   in ERRCONFIG register.
3. Change in bit positions and width of SENNENABLE and SENPENABLE
   bits in SRCONFIG registers.
4. Introduction of separate irq registers for MCU bound interrupts.
5. Removal of clockactivity bits in ERRCONFIG and introduction of
  idlemode and wakeupenable bits in ERRCONFIG.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |  218 ++++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/smartreflex.h |   51 +++++++--
 2 files changed, 208 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7aa84ab..2b1c529 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -58,6 +58,18 @@ static struct omap_smartreflex_class_data *sr_class;
 
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
+static inline int sr_type(void)
+{
+	if (cpu_is_omap3630())
+		return SR_TYPE_V2;
+	else if (cpu_is_omap343x())
+		return SR_TYPE_V1;
+	else {
+		pr_err("Trying to enable SR for Chip not support SR! \n");
+		return 0;
+	}
+}
+
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
 	__raw_writel(value, SR_REGADDR(offset));
@@ -67,9 +79,11 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 					u32 value)
 {
 	u32 reg_val;
+	u32 errconfig_offs, errconfig_mask;
 
 	reg_val = __raw_readl(SR_REGADDR(offset));
 	reg_val &= ~mask;
+
 	/*
 	 * Smartreflex error config register is special as it contains
 	 * certain status bits which if written a 1 into means a clear
@@ -78,8 +92,16 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 	 * value. Now if there is an actual reguest to write to these bits
 	 * they will be set in the nex step.
 	 */
-	if (offset == ERRCONFIG)
-		reg_val &= ~ERRCONFIG_STATUS_MASK;
+	if (sr_type() == SR_TYPE_V1) {
+		errconfig_offs = ERRCONFIG_V1;
+		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
+	} else if (sr_type() == SR_TYPE_V2) {
+		errconfig_offs = ERRCONFIG_V2;
+		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
+	}
+
+	if (offset == errconfig_offs)
+		reg_val &= ~errconfig_mask;
 
 	reg_val |= value;
 	__raw_writel(reg_val, SR_REGADDR(offset));
@@ -135,13 +157,21 @@ static void sr_clk_disable(struct omap_sr *sr)
 static irqreturn_t sr_omap_isr(int irq, void *data)
 {
 	struct omap_sr *sr_info = (struct omap_sr *)data;
-	u32 status;
+	u32 status = 0;
 
-	/* Read the status bits */
-	status = sr_read_reg(sr_info, ERRCONFIG);
+	if (sr_type() == SR_TYPE_V1) {
+		/* Read the status bits */
+		status = sr_read_reg(sr_info, ERRCONFIG_V1);
 
-	/* Clear them by writing back */
-	sr_write_reg(sr_info, ERRCONFIG, status);
+		/* Clear them by writing back */
+		sr_write_reg(sr_info, ERRCONFIG_V1, status);
+	} else if (sr_type() == SR_TYPE_V2) {
+		/* Read the status bits */
+		sr_read_reg(sr_info, IRQSTATUS);
+
+		/* Clear them by writing back */
+		sr_write_reg(sr_info, IRQSTATUS, status);
+	}
 
 	/* Call the class driver notify function if registered*/
 	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
@@ -208,6 +238,7 @@ static void sr_configure(struct omap_sr *sr)
 {
 	u32 sr_config;
 	u32 senp_en , senn_en;
+	u8 senp_shift, senn_shift;
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
 	/* Common settings for SR Class3 and SR Class2 */
@@ -218,8 +249,16 @@ static void sr_configure(struct omap_sr *sr)
 	senn_en = pdata->senn_mod;
 
 	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE | (senn_en << SRCONFIG_SENNENABLE_SHIFT) |
-		(senp_en << SRCONFIG_SENPENABLE_SHIFT) | SRCONFIG_DELAYCTRL;
+		SRCONFIG_SENENABLE;
+	if (sr_type() == SR_TYPE_V1) {
+		sr_config |= SRCONFIG_DELAYCTRL;
+		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
+	} else if (sr_type() == SR_TYPE_V2) {
+		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
+	}
+	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
 	sr_write_reg(sr, SRCONFIG, sr_config);
 
 	if ((sr_class->class_type == SR_CLASS3) || (sr_class->class_type ==
@@ -230,20 +269,30 @@ static void sr_configure(struct omap_sr *sr)
 		 * SR CLASS 2 can choose between ERROR module and MINMAXAVG
 		 * module.
 		 */
-		u32 sr_errconfig;
+		u32 sr_errconfig, errconfig_offs;
+		u32 vpboundint_en, vpboundint_st;
+
+		if (sr_type() == SR_TYPE_V1) {
+			errconfig_offs = ERRCONFIG_V1;
+			vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
+			vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
+		} else if (sr_type() == SR_TYPE_V2) {
+			errconfig_offs = ERRCONFIG_V2;
+			vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
+			vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
+		}
 
 		sr_modify_reg(sr, SRCONFIG, SRCONFIG_ERRGEN_EN,
 			SRCONFIG_ERRGEN_EN);
 		sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
 			(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
 			(sr->err_minlimit <<  ERRCONFIG_ERRMiNLIMIT_SHIFT);
-		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
+		sr_modify_reg(sr, errconfig_offs, (SR_ERRWEIGHT_MASK |
 			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
 			sr_errconfig);
 		/* Enabling the interrupts if the ERROR module is used */
-		sr_modify_reg(sr, ERRCONFIG,
-			(ERRCONFIG_VPBOUNDINTEN),
-			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+		sr_modify_reg(sr, errconfig_offs,
+			vpboundint_en, (vpboundint_en | vpboundint_st));
 	} else if ((sr_class->class_type == SR_CLASS2) &&
 			(sr_class->mod_use == SR_USE_ERROR_MOD)) {
 		/*
@@ -263,12 +312,27 @@ static void sr_configure(struct omap_sr *sr)
 		 * Enabling the interrupts if MINMAXAVG module is used.
 		 * TODO: check if all the interrupts are mandatory
 		 */
-		sr_modify_reg(sr, ERRCONFIG,
-			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
-			ERRCONFIG_MCUBOUNDINTEN),
-			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
-			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
-			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
+		if (sr_type() == SR_TYPE_V1) {
+			sr_modify_reg(sr, ERRCONFIG_V1,
+				(ERRCONFIG_MCUACCUMINTEN |
+				 ERRCONFIG_MCUVALIDINTEN |
+				 ERRCONFIG_MCUBOUNDINTEN),
+				(ERRCONFIG_MCUACCUMINTEN |
+				 ERRCONFIG_MCUACCUMINTST |
+				 ERRCONFIG_MCUVALIDINTEN |
+				 ERRCONFIG_MCUVALIDINTST |
+				 ERRCONFIG_MCUBOUNDINTEN |
+				 ERRCONFIG_MCUBOUNDINTST));
+		} else if (sr_type() == SR_TYPE_V2) {
+			sr_write_reg(sr, IRQSTATUS,
+				IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
+				IRQSTATUS_MCBOUNDSINT |
+				IRQSTATUS_MCUDISABLEACKINT);
+			sr_write_reg(sr, IRQENABLE_SET,
+				IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
+				IRQENABLE_MCUBOUNDSINT |
+				IRQENABLE_MCUDISABLEACKINT);
+		}
 	}
 }
 
@@ -318,6 +382,81 @@ static void sr_stop_vddautocomap(int srid)
 
 }
 
+static void sr_v1_disable(struct omap_sr *sr)
+{
+	int timeout = 0;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_modify_reg(sr, ERRCONFIG_V1,
+			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
+
+	/* SRCONFIG - disable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
+
+	/* Disable all other SR interrupts and clear the status */
+	sr_modify_reg(sr, ERRCONFIG_V1,
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
+			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
+			ERRCONFIG_MCUBOUNDINTST |
+			ERRCONFIG_VPBOUNDINTST_V1));
+
+	/* Wait for SR to be disabled.
+	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	while ((timeout < SR_DISABLE_TIMEOUT) &&
+		(!(sr_read_reg(sr, ERRCONFIG_V1) &
+		ERRCONFIG_MCUDISACKINTST))) {
+		udelay(1);
+		timeout++;
+	}
+
+	if (timeout == SR_DISABLE_TIMEOUT)
+		pr_warning("SR%d disable timedout\n", sr->srid);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
+	sr_modify_reg(sr, ERRCONFIG_V1, ERRCONFIG_MCUDISACKINTEN,
+			ERRCONFIG_MCUDISACKINTST);
+}
+
+static void sr_v2_disable(struct omap_sr *sr)
+{
+	int timeout = 0;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_write_reg(sr, IRQENABLE_SET, IRQENABLE_MCUDISABLEACKINT);
+
+	/* SRCONFIG - disable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
+
+	/* Disable all other SR interrupts and clear the status */
+	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+			ERRCONFIG_VPBOUNDINTST_V2);
+	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
+			IRQENABLE_MCUVALIDINT |
+			IRQENABLE_MCUBOUNDSINT));
+	sr_write_reg(sr, IRQSTATUS, (IRQSTATUS_MCUACCUMINT |
+			IRQSTATUS_MCVALIDINT |
+			IRQSTATUS_MCBOUNDSINT));
+
+	/* Wait for SR to be disabled.
+	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	while ((timeout < SR_DISABLE_TIMEOUT) &&
+		(!(sr_read_reg(sr, IRQSTATUS) &
+		IRQSTATUS_MCUDISABLEACKINT))) {
+		udelay(1);
+		timeout++;
+	}
+
+	if (timeout == SR_DISABLE_TIMEOUT)
+		pr_warning("SR%d disable timedout\n", sr->srid);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
+	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
+	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
+}
+
 /* Public Functions */
 
 /**
@@ -373,6 +512,7 @@ int sr_enable(int srid, u32 target_opp_no)
 	sr_configure(sr);
 
 	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
+
 	if (nvalue_reciprocal == 0) {
 		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
@@ -395,44 +535,18 @@ int sr_enable(int srid, u32 target_opp_no)
 void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
-	int timeout = 0;
 
 	/* Check if SR is already disabled. If yes do nothing */
 	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
 		return;
 
-	/* Enable MCUDisableAcknowledge interrupt */
-	sr_modify_reg(sr, ERRCONFIG,
-			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
+	if (sr_type() == SR_TYPE_V1)
+		sr_v1_disable(sr);
 
-	/* SRCONFIG - disable SR */
-	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
-
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG,
-			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
-			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN),
-			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
-			ERRCONFIG_MCUBOUNDINTST | ERRCONFIG_VPBOUNDINTST));
-
-	/* Wait for SR to be disabled.
-	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
-	 */
-	while ((timeout < SR_DISABLE_TIMEOUT) &&
-		(!(sr_read_reg(sr, ERRCONFIG) & ERRCONFIG_MCUDISACKINTST))) {
-
-		udelay(1);
-		timeout++;
-	}
-
-	if (timeout == SR_DISABLE_TIMEOUT)
-		pr_warning("SR%d disable timedout\n", srid);
-
-	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt
-	 * Also enable VPBOUND interrrupt
-	 */
-	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
-			ERRCONFIG_MCUDISACKINTST);
+	else if (sr_type() == SR_TYPE_V2)
+		sr_v2_disable(sr);
+	else
+		return;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index ae8d5db..4373cfb 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -22,6 +22,14 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR1		1
 #define SR2		2
 
+/*
+ * Different Smartreflex IPs version. The v1 is the 65nm version used in
+ * OMAP3430. The v2 is the update for the 45nm version of the IP
+ * used in OMAP3630 and OMAP4430
+ */
+#define SR_TYPE_V1	1
+#define SR_TYPE_V2	2
+
 #define GAIN_MAXLIMIT	16
 #define R_MAXLIMIT	256
 
@@ -34,16 +42,25 @@ extern struct dentry *pm_dbg_main_dir;
 #define SENAVG			0x14
 #define AVGWEIGHT		0x18
 #define NVALUERECIPROCAL	0x1C
-#define SENERROR		0x20
-#define ERRCONFIG		0x24
+#define SENERROR_V1		0x20
+#define ERRCONFIG_V1		0x24
+#define IRQ_EOI			0x20
+#define IRQSTATUS_RAW		0x24
+#define IRQSTATUS		0x28
+#define IRQENABLE_SET		0x2C
+#define IRQENABLE_CLR		0x30
+#define SENERROR_V2		0x34
+#define ERRCONFIG_V2		0x38
 
 /* Bit/Shift Positions */
 
 /* SRCONFIG */
 #define SRCONFIG_ACCUMDATA_SHIFT	22
 #define SRCONFIG_SRCLKLENGTH_SHIFT	12
-#define SRCONFIG_SENNENABLE_SHIFT	5
-#define SRCONFIG_SENPENABLE_SHIFT	3
+#define SRCONFIG_SENNENABLE_V1_SHIFT	5
+#define SRCONFIG_SENPENABLE_V1_SHIFT	3
+#define SRCONFIG_SENNENABLE_V2_SHIFT	1
+#define SRCONFIG_SENPENABLE_V2_SHIFT	0
 #define SRCONFIG_CLKCTRL_SHIFT		0
 
 #define SRCONFIG_ACCUMDATA_MASK		(0x3FF << 22)
@@ -73,8 +90,8 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
 #define SR_ERRMINLIMIT_MASK		(0xFF << 0)
 
-#define ERRCONFIG_VPBOUNDINTEN		BIT(31)
-#define ERRCONFIG_VPBOUNDINTST		BIT(30)
+#define ERRCONFIG_VPBOUNDINTEN_V1	BIT(31)
+#define ERRCONFIG_VPBOUNDINTST_V1	BIT(30)
 #define	ERRCONFIG_MCUACCUMINTEN		BIT(29)
 #define ERRCONFIG_MCUACCUMINTST		BIT(28)
 #define	ERRCONFIG_MCUVALIDINTEN		BIT(27)
@@ -82,13 +99,26 @@ extern struct dentry *pm_dbg_main_dir;
 #define ERRCONFIG_MCUBOUNDINTEN		BIT(25)
 #define	ERRCONFIG_MCUBOUNDINTST		BIT(24)
 #define	ERRCONFIG_MCUDISACKINTEN	BIT(23)
+#define ERRCONFIG_VPBOUNDINTST_V2	BIT(23)
 #define ERRCONFIG_MCUDISACKINTST	BIT(22)
+#define ERRCONFIG_VPBOUNDINTEN_V2	BIT(22)
 
-#define ERRCONFIG_STATUS_MASK		(ERRCONFIG_VPBOUNDINTST | \
+#define ERRCONFIG_STATUS_V1_MASK	(ERRCONFIG_VPBOUNDINTST_V1 | \
 					ERRCONFIG_MCUACCUMINTST | \
 					ERRCONFIG_MCUVALIDINTST | \
 					ERRCONFIG_MCUBOUNDINTST | \
 					ERRCONFIG_MCUDISACKINTST)
+/* IRQSTATUS */
+#define IRQSTATUS_MCUACCUMINT		BIT(3)
+#define IRQSTATUS_MCVALIDINT		BIT(2)
+#define IRQSTATUS_MCBOUNDSINT		BIT(1)
+#define IRQSTATUS_MCUDISABLEACKINT	BIT(0)
+
+/* IRQENABLE_SET and IRQENABLE_CLEAR */
+#define IRQENABLE_MCUACCUMINT		BIT(3)
+#define IRQENABLE_MCUVALIDINT		BIT(2)
+#define IRQENABLE_MCUBOUNDSINT		BIT(1)
+#define IRQENABLE_MCUDISABLEACKINT	BIT(0)
 
 /* Common Bit values */
 
@@ -99,7 +129,7 @@ extern struct dentry *pm_dbg_main_dir;
 #define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
 
 /*
- * 3430 specific values. Maybe these should be passed from board file or
+ * OMAP3 specific values. Maybe these should be passed from board file or
  * pmic structures.
  */
 #define OMAP3430_SR_ACCUMDATA		0x1F4
@@ -115,7 +145,10 @@ extern struct dentry *pm_dbg_main_dir;
 #define OMAP3430_SR_ERRMINLIMIT_HIGHOPP	0xF9
 #define OMAP3430_SR_ERRMINLIMIT_LOWOPP	0xF4
 
-/* TODO:3630/OMAP4 values if it has to come from this file */
+/* OMAP3630 specific values */
+#define OMAP3630_SR_ERRMINLIMIT_OPPTM	0xFA
+
+/* TODO:OMAP4 values */
 
 /* Info for enabling SR in T2/gaia. ToDo: Move it to twl4030_power.c */
 #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
-- 
1.7.0.rc1.33.g07cf0f

