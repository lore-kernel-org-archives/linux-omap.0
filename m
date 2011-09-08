From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/8] OMAP: Improve register access in L3 Error handler.
Date: Thu, 8 Sep 2011 10:52:01 +0530
Message-ID: <1315459327-3285-3-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35597 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab1IHFWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 01:22:32 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Todd Poynor <toddpoynor@google.com>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Todd Poynor <toddpoynor@google.com>

* Changed the way of accessing L3 target
  registers from standard base rather
  than relative to STDERRLOG_MAIN.

* Use ffs() to find error source from
  the L3_FLAGMUX_REGERRn register.

* Remove extra l3_base[] entry.

* Modified L3 custom error message.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   43 +++++++++---------
 arch/arm/mach-omap2/omap_l3_noc.h |   86 +++++++++++++++++-------------------
 arch/arm/mach-omap2/omap_l3_smx.c |    5 +-
 arch/arm/mach-omap2/omap_l3_smx.h |    2 +-
 4 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 7b9f190..d560c88 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -56,10 +56,9 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 {
 
 	struct omap4_l3		*l3 = _l3;
-	int inttype, i, j;
+	int inttype, i;
 	int err_src = 0;
-	u32 std_err_main_addr, std_err_main, err_reg;
-	u32 base, slave_addr, clear;
+	u32 std_err_main, err_reg, clear, base, l3_targ_base;
 	char *source_name;
 
 	/* Get the Type of interrupt */
@@ -71,42 +70,43 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		 * to determine the source
 		 */
 		base = (u32)l3->l3_base[i];
-		err_reg =  readl(base + l3_flagmux[i] + (inttype << 3));
+		err_reg = readl(base + l3_flagmux[i] +
+					+ L3_FLAGMUX_REGERR0 + (inttype << 3));
 
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
 			/* Identify the source from control status register */
-			for (j = 0; !(err_reg & (1 << j)); j++)
-									;
+			err_src = __ffs(err_reg);
 
-			err_src = j;
 			/* Read the stderrlog_main_source from clk domain */
-			std_err_main_addr = base + *(l3_targ[i] + err_src);
-			std_err_main = readl(std_err_main_addr);
+			l3_targ_base = base + *(l3_targ[i] + err_src);
+			std_err_main =  readl(l3_targ_base +
+					L3_TARG_STDERRLOG_MAIN);
 
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
 				source_name =
-				l3_targ_stderrlog_main_name[i][err_src];
-
-				slave_addr = std_err_main_addr +
-						L3_SLAVE_ADDRESS_OFFSET;
+					l3_targ_inst_name[i][err_src];
 				WARN(true, "L3 standard error: SOURCE:%s at address 0x%x\n",
-					source_name, readl(slave_addr));
+					source_name,
+					readl(l3_targ_base +
+						L3_TARG_STDERRLOG_SLVOFSLSB));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, std_err_main_addr);
+				writel(clear, l3_targ_base +
+					L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			case CUSTOM_ERROR:
 				source_name =
-				l3_targ_stderrlog_main_name[i][err_src];
+					l3_targ_inst_name[i][err_src];
 
-				WARN(true, "CUSTOM SRESP error with SOURCE:%s\n",
-							source_name);
+				WARN(true, "L3 custom error: SOURCE:%s\n",
+					source_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, std_err_main_addr);
+				writel(clear, l3_targ_base +
+					L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			default:
@@ -123,9 +123,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 static int __init omap4_l3_probe(struct platform_device *pdev)
 {
 	static struct omap4_l3		*l3;
-	struct resource		*res;
-	int			ret;
-	int			irq;
+	struct resource	*res;
+	int ret, irq;
 
 	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
 	if (!l3)
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 359b833..22c0d57 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -23,63 +23,60 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 #define __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 
-/*
- * L3 register offsets
- */
 #define L3_MODULES			3
 #define CLEAR_STDERR_LOG		(1 << 31)
 #define CUSTOM_ERROR			0x2
 #define STANDARD_ERROR			0x0
 #define INBAND_ERROR			0x0
-#define EMIF_KERRLOG_OFFSET		0x10
-#define L3_SLAVE_ADDRESS_OFFSET		0x14
-#define LOGICAL_ADDR_ERRORLOG		0x4
 #define L3_APPLICATION_ERROR		0x0
 #define L3_DEBUG_ERROR			0x1
 
+/* L3 TARG register offsets */
+#define L3_TARG_STDERRLOG_MAIN         0x48
+#define L3_TARG_STDERRLOG_SLVOFSLSB    0x5c
+#define L3_FLAGMUX_REGERR0	       0xc
+
 u32 l3_flagmux[L3_MODULES] = {
-	0x50C,
-	0x100C,
-	0X020C
+	0x500,
+	0x1000,
+	0X0200
 };
 
-/*
- * L3 Target standard Error register offsets
- */
-u32 l3_targ_stderrlog_main_clk1[] = {
-	0x148, /* DMM1 */
-	0x248, /* DMM2 */
-	0x348, /* ABE */
-	0x448, /* L4CFG */
-	0x648  /* CLK2 PWR DISC */
+/* L3 Target standard Error register offsets */
+u32 l3_targ_inst_clk1[] = {
+	0x100, /* DMM1 */
+	0x200, /* DMM2 */
+	0x300, /* ABE */
+	0x400, /* L4CFG */
+	0x600  /* CLK2 PWR DISC */
 };
 
-u32 l3_targ_stderrlog_main_clk2[] = {
-	0x548,		/* CORTEX M3 */
-	0x348,		/* DSS */
-	0x148,		/* GPMC */
-	0x448,		/* ISS */
-	0x748,		/* IVAHD */
-	0xD48,		/* missing in TRM  corresponds to AES1*/
-	0x948,		/* L4 PER0*/
-	0x248,		/* OCMRAM */
-	0x148,		/* missing in TRM corresponds to GPMC sERROR*/
-	0x648,		/* SGX */
-	0x848,		/* SL2 */
-	0x1648,		/* C2C */
-	0x1148,		/* missing in TRM corresponds PWR DISC CLK1*/
-	0xF48,		/* missing in TRM corrsponds to SHA1*/
-	0xE48,		/* missing in TRM corresponds to AES2*/
-	0xC48,		/* L4 PER3 */
-	0xA48,		/* L4 PER1*/
-	0xB48		/* L4 PER2*/
+u32 l3_targ_inst_clk2[] = {
+	0x500, /* CORTEX M3 */
+	0x300, /* DSS */
+	0x100, /* GPMC */
+	0x400, /* ISS */
+	0x700, /* IVAHD */
+	0xD00, /* missing in TRM  corresponds to AES1*/
+	0x900, /* L4 PER0*/
+	0x200, /* OCMRAM */
+	0x100, /* missing in TRM corresponds to GPMC sERROR*/
+	0x600, /* SGX */
+	0x800, /* SL2 */
+	0x1600, /* C2C */
+	0x1100,	/* missing in TRM corresponds PWR DISC CLK1*/
+	0xF00, /* missing in TRM corrsponds to SHA1*/
+	0xE00, /* missing in TRM corresponds to AES2*/
+	0xC00, /* L4 PER3 */
+	0xA00, /* L4 PER1*/
+	0xB00 /* L4 PER2*/
 };
 
-u32 l3_targ_stderrlog_main_clk3[] = {
-	0x0148	/* EMUSS */
+u32 l3_targ_inst_clk3[] = {
+	0x0100	/* EMUSS */
 };
 
-char *l3_targ_stderrlog_main_name[L3_MODULES][18] = {
+char *l3_targ_inst_name[L3_MODULES][18] = {
 	{
 	"DMM1",
 	"DMM2",
@@ -113,9 +110,9 @@ char *l3_targ_stderrlog_main_name[L3_MODULES][18] = {
 };
 
 u32 *l3_targ[L3_MODULES] = {
-	l3_targ_stderrlog_main_clk1,
-	l3_targ_stderrlog_main_clk2,
-	l3_targ_stderrlog_main_clk3,
+	l3_targ_inst_clk1,
+	l3_targ_inst_clk2,
+	l3_targ_inst_clk3,
 };
 
 struct omap4_l3 {
@@ -123,10 +120,9 @@ struct omap4_l3 {
 	struct clk	*ick;
 
 	/* memory base */
-	void __iomem *l3_base[4];
+	void __iomem *l3_base[L3_MODULES];
 
 	int		debug_irq;
 	int		app_irq;
 };
-
 #endif
diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 873c0e3..fa07edf 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -191,10 +191,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 	}
 
 	/* identify the error source */
-	for (err_source = 0; !(status & (1 << err_source)); err_source++)
-									;
+	err_source = __ffs(status);
 
-	base = l3->rt + *(omap3_l3_bases[int_type] + err_source);
+	base = l3->rt + omap3_l3_bases[int_type][err_source];
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
 	if (error) {
 		error_addr = omap3_l3_readll(base, L3_ERROR_LOG_ADDR);
diff --git a/arch/arm/mach-omap2/omap_l3_smx.h b/arch/arm/mach-omap2/omap_l3_smx.h
index ba2ed9a..185d77a 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.h
+++ b/arch/arm/mach-omap2/omap_l3_smx.h
@@ -40,7 +40,7 @@
 #define L3_SI_CONTROL			0x020
 #define L3_SI_FLAG_STATUS_0		0x510
 
-const u64 shift = 1;
+static const u64 shift = 1;
 
 #define L3_STATUS_0_MPUIA_BRST		(shift << 0)
 #define L3_STATUS_0_MPUIA_RSP		(shift << 1)
-- 
1.7.4.1

