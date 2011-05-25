From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] ARM: OMAP: L3 interconnect: Error reporting cleanups
Date: Tue, 24 May 2011 19:50:21 -0700
Message-ID: <20110525025021.GA8460@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:37233 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1EYCuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 22:50:35 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

* Move variable declarations from header file and make these static
  (the entire header file should probably go away).

* Define L3 TARG instance offsets, and read/write STDERRLOG registers
  relative to those offsets, rather than defining STDERRLOG_MAIN
  instance offsets and accessing other registers via offsets from
  that register.

* Use ffs() to find error source from the L3_FLAGMUX_REGERRn
  register.

* Remove extra l3_base[] entry.

* Modify L3 custom error message for consistency with standard
  error message.

* Fixup indentation in one spot.

---
 arch/arm/mach-omap2/omap_l3_noc.c |  122 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/omap_l3_noc.h |   88 +-------------------------
 2 files changed, 106 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 82632c2..7e81e4c 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -29,6 +29,88 @@
 
 #include "omap_l3_noc.h"
 
+static u32 l3_flagmux[L3_MODULES] = {
+	0x50C,
+	0x100C,
+	0X020C
+};
+
+/*
+ * L3 Target instances
+ */
+static u32 l3_targ_inst_clk1[] = {
+	0x100, /* DMM1 */
+	0x200, /* DMM2 */
+	0x300, /* ABE */
+	0x400, /* L4CFG */
+	0x600  /* CLK2 PWR DISC */
+};
+
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
+};
+
+static u32 l3_targ_inst_clk3[] = {
+	0x0100	/* EMUSS */
+};
+
+static char *l3_targ_inst_name[L3_MODULES][18] = {
+	{
+	"DMM1",
+	"DMM2",
+	"ABE",
+	"L4CFG",
+	"CLK2 PWR DISC",
+	},
+	{
+	"CORTEX M3" ,
+	"DSS ",
+	"GPMC ",
+	"ISS ",
+	"IVAHD ",
+	"AES1",
+	"L4 PER0",
+	"OCMRAM ",
+	"GPMC sERROR",
+	"SGX ",
+	"SL2 ",
+	"C2C ",
+	"PWR DISC CLK1",
+	"SHA1",
+	"AES2",
+	"L4 PER3",
+	"L4 PER1",
+	"L4 PER2",
+	},
+	{
+	"EMUSS",
+	},
+};
+
+static u32 *l3_targ[L3_MODULES] = {
+	l3_targ_inst_clk1,
+	l3_targ_inst_clk2,
+	l3_targ_inst_clk3,
+};
+
+
 /*
  * Interrupt Handler for L3 error detection.
  *	1) Identify the L3 clockdomain partition to which the error belongs to.
@@ -56,10 +138,10 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
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
@@ -79,45 +161,45 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
 			/* Identify the source from control status register */
-			for (j = 0; !(err_reg & (1 << j)); j++)
-									;
-
-			err_src = j;
+			err_src = ffs(err_reg) - 1;
 			/* Read the stderrlog_main_source from clk domain */
-			std_err_main_addr = base + (*(l3_targ[i] + err_src));
-			std_err_main =  readl(std_err_main_addr);
+			l3_targ_base = base + (*(l3_targ[i] + err_src));
+			std_err_main =  readl(l3_targ_base +
+					      L3_TARG_STDERRLOG_MAIN);
 
 			switch ((std_err_main & CUSTOM_ERROR)) {
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
+					      L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			case CUSTOM_ERROR:
 				source_name =
-				l3_targ_stderrlog_main_name[i][err_src];
+					l3_targ_inst_name[i][err_src];
 
-				WARN(true, "CUSTOM SRESP error with SOURCE:%s\n",
+				WARN(true, "L3 custom error: SOURCE:%s\n",
 							source_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, std_err_main_addr);
+				writel(clear, l3_targ_base +
+					      L3_TARG_STDERRLOG_MAIN);
 				break;
 
 			default:
 				/* Nothing to be handled here as of now */
 				break;
 			}
-		/* Error found so break the for loop */
-		break;
+
+			/* Error found so break the for loop */
+			break;
 		}
 	}
 	return IRQ_HANDLED;
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 359b833..e2bdb4d 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -23,107 +23,27 @@
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
-	0x50C,
-	0x100C,
-	0X020C
-};
-
 /*
- * L3 Target standard Error register offsets
+ * L3 TARG register offsets
  */
-u32 l3_targ_stderrlog_main_clk1[] = {
-	0x148, /* DMM1 */
-	0x248, /* DMM2 */
-	0x348, /* ABE */
-	0x448, /* L4CFG */
-	0x648  /* CLK2 PWR DISC */
-};
-
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
-};
-
-u32 l3_targ_stderrlog_main_clk3[] = {
-	0x0148	/* EMUSS */
-};
+#define L3_TARG_STDERRLOG_MAIN		0x48
+#define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
 
-char *l3_targ_stderrlog_main_name[L3_MODULES][18] = {
-	{
-	"DMM1",
-	"DMM2",
-	"ABE",
-	"L4CFG",
-	"CLK2 PWR DISC",
-	},
-	{
-	"CORTEX M3" ,
-	"DSS ",
-	"GPMC ",
-	"ISS ",
-	"IVAHD ",
-	"AES1",
-	"L4 PER0",
-	"OCMRAM ",
-	"GPMC sERROR",
-	"SGX ",
-	"SL2 ",
-	"C2C ",
-	"PWR DISC CLK1",
-	"SHA1",
-	"AES2",
-	"L4 PER3",
-	"L4 PER1",
-	"L4 PER2",
-	},
-	{
-	"EMUSS",
-	},
-};
-
-u32 *l3_targ[L3_MODULES] = {
-	l3_targ_stderrlog_main_clk1,
-	l3_targ_stderrlog_main_clk2,
-	l3_targ_stderrlog_main_clk3,
-};
 
 struct omap4_l3 {
 	struct device	*dev;
 	struct clk	*ick;
 
 	/* memory base */
-	void __iomem *l3_base[4];
+	void __iomem *l3_base[L3_MODULES];
 
 	int		debug_irq;
 	int		app_irq;
-- 
1.7.3.1

