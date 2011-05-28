From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] OMAP: L3 interconnect: Error reporting cleanups
Date: Fri, 27 May 2011 20:24:08 -0700
Message-ID: <20110528032408.GA24868@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:36254 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1E1DYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 23:24:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

* Make variables static.

* Define L3 TARG instance offsets, and read/write STDERRLOG registers
  relative to those offsets, rather than defining STDERRLOG_MAIN
  instance offsets and accessing other registers via offsets from
  that register.

* Use ffs() to find error source from the L3_FLAGMUX_REGERRn
  register.

* Remove extra l3_base[] entry.

* Modify L3 custom error message for consistency with standard
  error message.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---

V2 updated for feedback from Santosh (thanks!).

 arch/arm/mach-omap2/omap_l3_noc.c |   38 +++++++++---------
 arch/arm/mach-omap2/omap_l3_noc.h |   82 ++++++++++++++++++------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 7b9f190..3593279 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -29,6 +29,7 @@
 
 #include "omap_l3_noc.h"
 
+
 /*
  * Interrupt Handler for L3 error detection.
  *	1) Identify the L3 clockdomain partition to which the error belongs to.
@@ -56,10 +57,10 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 {
 
 	struct omap4_l3		*l3 = _l3;
-	int inttype, i, j;
+	int inttype, i;
 	int err_src = 0;
-	u32 std_err_main_addr, std_err_main, err_reg;
-	u32 base, slave_addr, clear;
+	u32 l3_targ_base, std_err_main, err_reg;
+	u32 base, clear;
 	char *source_name;
 
 	/* Get the Type of interrupt */
@@ -76,37 +77,36 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
 			/* Identify the source from control status register */
-			for (j = 0; !(err_reg & (1 << j)); j++)
-									;
-
-			err_src = j;
+			err_src = __ffs(err_reg);
 			/* Read the stderrlog_main_source from clk domain */
-			std_err_main_addr = base + *(l3_targ[i] + err_src);
-			std_err_main = readl(std_err_main_addr);
+			l3_targ_base = base + (*(l3_targ[i] + err_src));
+			std_err_main =  readl(l3_targ_base +
+					      L3_TARG_STDERRLOG_MAIN);
 
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
+				     source_name,
+				     readl(l3_targ_base +
+					   L3_TARG_STDERRLOG_SLVOFSLSB));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, std_err_main_addr);
+				writel(clear, l3_targ_base +
+				       L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			case CUSTOM_ERROR:
 				source_name =
-				l3_targ_stderrlog_main_name[i][err_src];
+					l3_targ_inst_name[i][err_src];
 
-				WARN(true, "CUSTOM SRESP error with SOURCE:%s\n",
-							source_name);
+				WARN(true, "L3 custom error: SOURCE:%s\n",
+				     source_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, std_err_main_addr);
+				writel(clear, l3_targ_base +
+				       L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			default:
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 359b833..b553fa7 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -23,63 +23,63 @@
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
 
-u32 l3_flagmux[L3_MODULES] = {
+/*
+ * L3 TARG register offsets
+ */
+#define L3_TARG_STDERRLOG_MAIN		0x48
+#define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
+
+static u32 l3_flagmux[L3_MODULES] = {
 	0x50C,
 	0x100C,
 	0X020C
 };
 
 /*
- * L3 Target standard Error register offsets
+ * L3 Target instances
  */
-u32 l3_targ_stderrlog_main_clk1[] = {
-	0x148, /* DMM1 */
-	0x248, /* DMM2 */
-	0x348, /* ABE */
-	0x448, /* L4CFG */
-	0x648  /* CLK2 PWR DISC */
+static u32 l3_targ_inst_clk1[] = {
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
+static u32 l3_targ_inst_clk2[] = {
+	0x500,		/* CORTEX M3 */
+	0x300,		/* DSS */
+	0x100,		/* GPMC */
+	0x400,		/* ISS */
+	0x700,		/* IVAHD */
+	0xD00,		/* missing in TRM  corresponds to AES1*/
+	0x900,		/* L4 PER0*/
+	0x200,		/* OCMRAM */
+	0x100,		/* missing in TRM corresponds to GPMC sERROR*/
+	0x600,		/* SGX */
+	0x800,		/* SL2 */
+	0x1600,		/* C2C */
+	0x1100,		/* missing in TRM corresponds PWR DISC CLK1*/
+	0xF00,		/* missing in TRM corrsponds to SHA1*/
+	0xE00,		/* missing in TRM corresponds to AES2*/
+	0xC00,		/* L4 PER3 */
+	0xA00,		/* L4 PER1*/
+	0xB00		/* L4 PER2*/
 };
 
-u32 l3_targ_stderrlog_main_clk3[] = {
-	0x0148	/* EMUSS */
+static u32 l3_targ_inst_clk3[] = {
+	0x0100	/* EMUSS */
 };
 
-char *l3_targ_stderrlog_main_name[L3_MODULES][18] = {
+static char *l3_targ_inst_name[L3_MODULES][18] = {
 	{
 	"DMM1",
 	"DMM2",
@@ -112,10 +112,10 @@ char *l3_targ_stderrlog_main_name[L3_MODULES][18] = {
 	},
 };
 
-u32 *l3_targ[L3_MODULES] = {
-	l3_targ_stderrlog_main_clk1,
-	l3_targ_stderrlog_main_clk2,
-	l3_targ_stderrlog_main_clk3,
+static u32 *l3_targ[L3_MODULES] = {
+	l3_targ_inst_clk1,
+	l3_targ_inst_clk2,
+	l3_targ_inst_clk3,
 };
 
 struct omap4_l3 {
@@ -123,7 +123,7 @@ struct omap4_l3 {
 	struct clk	*ick;
 
 	/* memory base */
-	void __iomem *l3_base[4];
+	void __iomem *l3_base[L3_MODULES];
 
 	int		debug_irq;
 	int		app_irq;
-- 
1.7.3.1

