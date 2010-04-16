From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 1/2] OMAP3: PM: Smartreflex IP update changes for OMAP3630
Date: Fri, 16 Apr 2010 15:49:55 +0530
Message-ID: <1271413196-6087-2-git-send-email-thara@ti.com>
References: <1271413196-6087-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab0DPKUG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 06:20:06 -0400
In-Reply-To: <1271413196-6087-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

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
 arch/arm/mach-omap2/smartreflex.c |  215 +++++++++++++++++++++++++++----------
 arch/arm/mach-omap2/smartreflex.h |   44 +++++++--
 2 files changed, 194 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 4dccfd1..b81f9f3 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -43,6 +43,7 @@ struct omap_sr {
 	int			srid;
 	int			is_sr_enable;
 	int			is_autocomp_active;
+	int			sr_ip_type;
 	u32			clk_length;
 	u32			err_weight;
 	u32			err_minlimit;
@@ -71,6 +72,7 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 {
 	struct omap_device *odev = to_omap_device(sr->pdev);
 	u32 reg_val;
+	u32 errconfig_offs, errconfig_mask;
 
 	reg_val = omap_hwmod_readl(odev->hwmods[0], offset);
 	reg_val &= ~mask;
@@ -82,8 +84,15 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 	 * value. Now if there is an actual reguest to write to these bits
 	 * they will be set in the nex step.
 	 */
-	if (offset == ERRCONFIG)
-		reg_val &= ~ERRCONFIG_STATUS_MASK;
+	if (sr->sr_ip_type == SR_TYPE_V1) {
+		errconfig_offs = ERRCONFIG_V1;
+		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
+	} else if (sr->sr_ip_type == SR_TYPE_V2) {
+		errconfig_offs = ERRCONFIG_V2;
+		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
+	}
+	if (offset == errconfig_offs)
+		reg_val &= ~errconfig_mask;
 
 	reg_val |= value;
 
@@ -114,13 +123,19 @@ static struct omap_sr *_sr_lookup(int srid)
 static irqreturn_t sr_omap_isr(int irq, void *data)
 {
 	struct omap_sr *sr_info = (struct omap_sr *)data;
-	u32 status;
-
-	/* Read the status bits */
-	status = sr_read_reg(sr_info, ERRCONFIG);
-
-	/* Clear them by writing back */
-	sr_write_reg(sr_info, ERRCONFIG, status);
+	u32 status = 0;
+
+	if (sr_info->sr_ip_type == SR_TYPE_V1) {
+		/* Read the status bits */
+		status = sr_read_reg(sr_info, ERRCONFIG_V1);
+		/* Clear them by writing back */
+		sr_write_reg(sr_info, ERRCONFIG_V1, status);
+	} else if (sr_info->sr_ip_type == SR_TYPE_V2) {
+		/* Read the status bits */
+		sr_read_reg(sr_info, IRQSTATUS);
+		/* Clear them by writing back */
+		sr_write_reg(sr_info, IRQSTATUS, status);
+	}
 
 	/* Call the class driver notify function if registered*/
 	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
@@ -243,6 +258,77 @@ static int sr_late_init(struct omap_sr *sr_info)
 	return ret;
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
+	/*
+	 * Wait for SR to be disabled.
+	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
+			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
+			timeout);
+
+	if (timeout >= SR_DISABLE_TIMEOUT)
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
+	/*
+	 * Wait for SR to be disabled.
+	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
+			IRQSTATUS_MCUDISABLEACKINT), SR_DISABLE_TIMEOUT,
+			timeout);
+
+	if (timeout >= SR_DISABLE_TIMEOUT)
+		pr_warning("SR%d disable timedout\n", sr->srid);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
+	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
+	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
+}
+
 /* Public Functions */
 
 /**
@@ -259,8 +345,9 @@ static int sr_late_init(struct omap_sr *sr_info)
  */
 void sr_configure_errgen(int srid)
 {
-	u32 sr_config, sr_errconfig;
-	u32 senp_en , senn_en;
+	u32 sr_config, sr_errconfig, errconfig_offs, vpboundint_en;
+	u32 vpboundint_st, senp_en , senn_en;
+	u8 senp_shift, senn_shift;
 	struct omap_sr *sr = _sr_lookup(srid);
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
@@ -276,20 +363,36 @@ void sr_configure_errgen(int srid)
 	senp_en = pdata->senp_mod;
 	senn_en = pdata->senn_mod;
 	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
-		(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
-		(senp_en << SRCONFIG_SENPENABLE_SHIFT) | SRCONFIG_DELAYCTRL;
+		SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN;
+	if (sr->sr_ip_type == SR_TYPE_V1) {
+		sr_config |= SRCONFIG_DELAYCTRL;
+		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
+		errconfig_offs = ERRCONFIG_V1;
+		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
+		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
+	} else if (sr->sr_ip_type == SR_TYPE_V2) {
+		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
+		errconfig_offs = ERRCONFIG_V2;
+		vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
+		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
+	} else {
+		pr_err("Trying to Configure smartreflex module without \
+				specifying the ip\n");
+		return;
+	}
+	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
 	sr_write_reg(sr, SRCONFIG, sr_config);
 	sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
 		(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
 		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
-	sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
+	sr_modify_reg(sr, errconfig_offs, (SR_ERRWEIGHT_MASK |
 		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
 		sr_errconfig);
 	/* Enabling the interrupts if the ERROR module is used */
-	sr_modify_reg(sr, ERRCONFIG,
-		(ERRCONFIG_VPBOUNDINTEN),
-		(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+	sr_modify_reg(sr, errconfig_offs,
+		vpboundint_en, (vpboundint_en | vpboundint_st));
 }
 
 /**
@@ -308,6 +411,7 @@ void sr_configure_minmax(int srid)
 {
 	u32 sr_config, sr_avgwt;
 	u32 senp_en , senn_en;
+	u8 senp_shift, senn_shift;
 	struct omap_sr *sr = _sr_lookup(srid);
 	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
 
@@ -323,10 +427,21 @@ void sr_configure_minmax(int srid)
 	senp_en = pdata->senp_mod;
 	senn_en = pdata->senn_mod;
 	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE | (senn_en << SRCONFIG_SENNENABLE_SHIFT) |
-		(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
-		(sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT) |
-		SRCONFIG_DELAYCTRL;
+		SRCONFIG_SENENABLE |
+		(sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
+	if (sr->sr_ip_type == SR_TYPE_V1) {
+		sr_config |= SRCONFIG_DELAYCTRL;
+		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
+	} else if (sr->sr_ip_type == SR_TYPE_V2) {
+		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
+		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
+	} else {
+		pr_err("Trying to Configure smartreflex module without \
+				specifying the ip\n");
+		return;
+	}
+	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
 	sr_write_reg(sr, SRCONFIG, sr_config);
 	sr_avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
 		(sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
@@ -335,12 +450,21 @@ void sr_configure_minmax(int srid)
 	 * Enabling the interrupts if MINMAXAVG module is used.
 	 * TODO: check if all the interrupts are mandatory
 	 */
-	sr_modify_reg(sr, ERRCONFIG,
-		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
-		ERRCONFIG_MCUBOUNDINTEN),
-		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
-		 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
-		 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
+	if (sr->sr_ip_type == SR_TYPE_V1) {
+		sr_modify_reg(sr, ERRCONFIG_V1,
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+			ERRCONFIG_MCUBOUNDINTEN),
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
+			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
+			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
+	} else if (sr->sr_ip_type == SR_TYPE_V2) {
+		sr_write_reg(sr, IRQSTATUS,
+			IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
+			IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
+		sr_write_reg(sr, IRQENABLE_SET,
+			IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
+			IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
+	}
 }
 
 /**
@@ -418,7 +542,6 @@ void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 	struct omap_smartreflex_data *pdata;
-	int timeout = 0;
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
@@ -434,35 +557,10 @@ void sr_disable(int srid)
 	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
 		goto disable_clocks;
 
-	/* Enable MCUDisableAcknowledge interrupt */
-	sr_modify_reg(sr, ERRCONFIG,
-			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
-
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
-	omap_test_timeout((sr_read_reg(sr, ERRCONFIG) &
-			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
-			timeout);
-
-	if (timeout >= SR_DISABLE_TIMEOUT)
-		pr_warning("SR%d disable timedout\n", srid);
-
-	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt
-	 * Also enable VPBOUND interrrupt
-	 */
-	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
-			ERRCONFIG_MCUDISACKINTST);
+	if (sr->sr_ip_type == SR_TYPE_V1)
+		sr_v1_disable(sr);
+	else if (sr->sr_ip_type == SR_TYPE_V2)
+		sr_v2_disable(sr);
 
 disable_clocks:
 	pdata = sr->pdev->dev.platform_data;
@@ -619,6 +717,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	sr_info->srid = pdev->id;
 	sr_info->is_autocomp_active = 0;
 	sr_info->clk_length = 0;
+	sr_info->sr_ip_type = odev->hwmods[0]->class->rev;
 	if (odev->hwmods[0]->mpu_irqs)
 		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
 	sr_set_clk_length(sr_info);
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 476a3b6..d12c093 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -18,6 +18,14 @@
 
 extern struct dentry *pm_dbg_main_dir;
 
+/*
+ * Different Smartreflex IPs version. The v1 is the 65nm version used in
+ * OMAP3430. The v2 is the update for the 45nm version of the IP
+ * used in OMAP3630 and OMAP4430
+ */
+#define SR_TYPE_V1	1
+#define SR_TYPE_V2	2
+
 /* SMART REFLEX REG ADDRESS OFFSET */
 #define SRCONFIG		0x00
 #define SRSTATUS		0x04
@@ -27,16 +35,25 @@ extern struct dentry *pm_dbg_main_dir;
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
@@ -66,8 +83,8 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
 #define SR_ERRMINLIMIT_MASK		(0xFF << 0)
 
-#define ERRCONFIG_VPBOUNDINTEN		BIT(31)
-#define ERRCONFIG_VPBOUNDINTST		BIT(30)
+#define ERRCONFIG_VPBOUNDINTEN_V1	BIT(31)
+#define ERRCONFIG_VPBOUNDINTST_V1	BIT(30)
 #define	ERRCONFIG_MCUACCUMINTEN		BIT(29)
 #define ERRCONFIG_MCUACCUMINTST		BIT(28)
 #define	ERRCONFIG_MCUVALIDINTEN		BIT(27)
@@ -75,13 +92,26 @@ extern struct dentry *pm_dbg_main_dir;
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
 
-- 
1.7.0.rc1.33.g07cf0f

