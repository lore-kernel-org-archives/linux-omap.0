From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/8] OMAP: Fix sparse warnings in l3 error handler.
Date: Thu, 8 Sep 2011 10:52:04 +0530
Message-ID: <1315459327-3285-6-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab1IHFWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 01:22:34 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

From: sricharan <r.sricharan@ti.com>

Fix below sparse warnings from the l3-noc and l3-smx error handlers
files.

arch/arm/mach-omap2/omap_l3_smx.h:209:22: warning: symbol 'omap3_l3_app_bases' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_smx.h:308:22: warning: symbol 'omap3_l3_debug_bases' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_smx.h:325:2: warning: incorrect type in initializer (different address spaces)
arch/arm/mach-omap2/omap_l3_smx.h:325:2:    expected unsigned int [usertype] *
arch/arm/mach-omap2/omap_l3_smx.h:325:2:    got unsigned int [noderef] [toplevel] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_smx.h:326:2: warning: incorrect type in initializer (different address spaces)
arch/arm/mach-omap2/omap_l3_smx.h:326:2:    expected unsigned int [usertype] *
arch/arm/mach-omap2/omap_l3_smx.h:326:2:    got unsigned int [noderef] [toplevel] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_smx.h:324:5: warning: symbol 'omap3_l3_bases' was not declared. Should it be static?
  CC      arch/arm/mach-omap2/omap_l3_smx.o
  CHECK   arch/arm/mach-omap2/omap_l3_noc.c
arch/arm/mach-omap2/omap_l3_noc.c:73:13: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/omap_l3_noc.c:73:13: originally declared here
arch/arm/mach-omap2/omap_l3_noc.c:83:20: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/omap_l3_noc.c:83:20: originally declared here
arch/arm/mach-omap2/omap_l3_noc.c:90:5: warning: symbol '__v' shadows an earlier one
arch/arm/mach-omap2/omap_l3_noc.c:90:5: originally declared here
arch/arm/mach-omap2/omap_l3_noc.h:39:5: warning: symbol 'l3_flagmux' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.h:46:5: warning: symbol 'l3_targ_inst_clk1' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.h:54:5: warning: symbol 'l3_targ_inst_clk2' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.h:75:5: warning: symbol 'l3_targ_inst_clk3' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.h:79:6: warning: symbol 'l3_targ_inst_name' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.h:112:5: warning: symbol 'l3_targ' was not declared. Should it be static?
arch/arm/mach-omap2/omap_l3_noc.c:72:11: warning: cast removes address space of expression
arch/arm/mach-omap2/omap_l3_noc.c:73:13: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap2/omap_l3_noc.c:73:13:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_noc.c:73:13:    got unsigned int
arch/arm/mach-omap2/omap_l3_noc.c:83:20: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap2/omap_l3_noc.c:83:20:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_noc.c:83:20:    got unsigned int
arch/arm/mach-omap2/omap_l3_noc.c:90:5: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap2/omap_l3_noc.c:90:5:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_noc.c:90:5:    got unsigned int
arch/arm/mach-omap2/omap_l3_noc.c:96:5: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap2/omap_l3_noc.c:96:5:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_noc.c:96:5:    got unsigned int
arch/arm/mach-omap2/omap_l3_noc.c:108:5: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-omap2/omap_l3_noc.c:108:5:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/omap_l3_noc.c:108:5:    got unsigned int

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   11 ++++++-----
 arch/arm/mach-omap2/omap_l3_noc.h |   12 ++++++------
 arch/arm/mach-omap2/omap_l3_smx.h |    6 +++---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 1f68e95..8f18357 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -58,7 +58,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	struct omap4_l3 *l3 = _l3;
 	int inttype, i;
 	int err_src = 0;
-	u32 std_err_main, err_reg, clear, base, l3_targ_base;
+	u32 std_err_main, err_reg, clear;
+	void __iomem *base, *l3_targ_base;
 	char *source_name;
 
 	/* Get the Type of interrupt */
@@ -69,8 +70,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		 * Read the regerr register of the clock domain
 		 * to determine the source
 		 */
-		base = (u32)l3->l3_base[i];
-		err_reg = readl(base + l3_flagmux[i] +
+		base = l3->l3_base[i];
+		err_reg = __raw_readl(base + l3_flagmux[i] +
 					+ L3_FLAGMUX_REGERR0 + (inttype << 3));
 
 		/* Get the corresponding error and analyse */
@@ -80,7 +81,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 			/* Read the stderrlog_main_source from clk domain */
 			l3_targ_base = base + *(l3_targ[i] + err_src);
-			std_err_main =  readl(l3_targ_base +
+			std_err_main =  __raw_readl(l3_targ_base +
 					L3_TARG_STDERRLOG_MAIN);
 
 			switch (std_err_main & CUSTOM_ERROR) {
@@ -89,7 +90,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					l3_targ_inst_name[i][err_src];
 				WARN(true, "L3 standard error: SOURCE:%s at address 0x%x\n",
 					source_name,
-					readl(l3_targ_base +
+					__raw_readl(l3_targ_base +
 						L3_TARG_STDERRLOG_SLVOFSLSB));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 9120e70..74c1643 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -36,14 +36,14 @@
 #define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
 #define L3_FLAGMUX_REGERR0		0xc
 
-u32 l3_flagmux[L3_MODULES] = {
+static u32 l3_flagmux[L3_MODULES] = {
 	0x500,
 	0x1000,
 	0X0200
 };
 
 /* L3 Target standard Error register offsets */
-u32 l3_targ_inst_clk1[] = {
+static u32 l3_targ_inst_clk1[] = {
 	0x100, /* DMM1 */
 	0x200, /* DMM2 */
 	0x300, /* ABE */
@@ -51,7 +51,7 @@ u32 l3_targ_inst_clk1[] = {
 	0x600  /* CLK2 PWR DISC */
 };
 
-u32 l3_targ_inst_clk2[] = {
+static u32 l3_targ_inst_clk2[] = {
 	0x500, /* CORTEX M3 */
 	0x300, /* DSS */
 	0x100, /* GPMC */
@@ -72,11 +72,11 @@ u32 l3_targ_inst_clk2[] = {
 	0xB00 /* L4 PER2*/
 };
 
-u32 l3_targ_inst_clk3[] = {
+static u32 l3_targ_inst_clk3[] = {
 	0x0100	/* EMUSS */
 };
 
-char *l3_targ_inst_name[L3_MODULES][18] = {
+static char *l3_targ_inst_name[L3_MODULES][18] = {
 	{
 		"DMM1",
 		"DMM2",
@@ -109,7 +109,7 @@ char *l3_targ_inst_name[L3_MODULES][18] = {
 	},
 };
 
-u32 *l3_targ[L3_MODULES] = {
+static u32 *l3_targ[L3_MODULES] = {
 	l3_targ_inst_clk1,
 	l3_targ_inst_clk2,
 	l3_targ_inst_clk3,
diff --git a/arch/arm/mach-omap2/omap_l3_smx.h b/arch/arm/mach-omap2/omap_l3_smx.h
index 18e5ec2..4f3cebc 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.h
+++ b/arch/arm/mach-omap2/omap_l3_smx.h
@@ -206,7 +206,7 @@ struct omap3_l3 {
 };
 
 /* offsets for l3 agents in order with the Flag status register */
-unsigned int __iomem omap3_l3_app_bases[] = {
+static unsigned int omap3_l3_app_bases[] = {
 	/* MPU IA */
 	0x1400,
 	0x1400,
@@ -305,7 +305,7 @@ unsigned int __iomem omap3_l3_app_bases[] = {
 	0,
 };
 
-unsigned int __iomem omap3_l3_debug_bases[] = {
+static unsigned int omap3_l3_debug_bases[] = {
 	/* MPU DATA IA */
 	0x1400,
 	/* RESERVED */
@@ -321,7 +321,7 @@ unsigned int __iomem omap3_l3_debug_bases[] = {
 	/* REST RESERVED */
 };
 
-u32 *omap3_l3_bases[] = {
+static u32 *omap3_l3_bases[] = {
 	omap3_l3_app_bases,
 	omap3_l3_debug_bases,
 };
-- 
1.7.4.1

