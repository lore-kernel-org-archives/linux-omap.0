From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/8] OMAP: Print Initiator name for l3 custom error.
Date: Thu, 8 Sep 2011 10:52:05 +0530
Message-ID: <1315459327-3285-7-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab1IHFWd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 01:22:33 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: sricharan <r.sricharan@ti.com>

The initiator id gets logged in the l3 target registers for custom error.
So print it to aid debugging.

Based on a internal patch by Devaraj Rangasamy <dev@ti.com>

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   26 ++++++++++++++++----------
 arch/arm/mach-omap2/omap_l3_noc.h |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 8f18357..07a3d3e 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -56,11 +56,11 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 {
 
 	struct omap4_l3 *l3 = _l3;
-	int inttype, i;
+	int inttype, i, k;
 	int err_src = 0;
-	u32 std_err_main, err_reg, clear;
+	u32 std_err_main, err_reg, clear, masterid;
 	void __iomem *base, *l3_targ_base;
-	char *source_name;
+	char *target_name, *master_name = "UN IDENTIFIED";
 
 	/* Get the Type of interrupt */
 	inttype = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
@@ -83,13 +83,15 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			l3_targ_base = base + *(l3_targ[i] + err_src);
 			std_err_main =  __raw_readl(l3_targ_base +
 					L3_TARG_STDERRLOG_MAIN);
+			masterid = __raw_readl(l3_targ_base +
+					L3_TARG_STDERRLOG_MSTADDR);
 
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
-				source_name =
+				target_name =
 					l3_targ_inst_name[i][err_src];
-				WARN(true, "L3 standard error: SOURCE:%s at address 0x%x\n",
-					source_name,
+				WARN(true, "L3 standard error: TARGET:%s at address 0x%x\n",
+					target_name,
 					__raw_readl(l3_targ_base +
 						L3_TARG_STDERRLOG_SLVOFSLSB));
 				/* clear the std error log*/
@@ -99,11 +101,15 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 				break;
 
 			case CUSTOM_ERROR:
-				source_name =
+				target_name =
 					l3_targ_inst_name[i][err_src];
-
-				WARN(true, "L3 custom error: SOURCE:%s\n",
-					source_name);
+				for (k = 0; k < NUM_OF_L3_MASTERS; k++) {
+					if (masterid == l3_masters[k].id)
+						master_name =
+							l3_masters[k].name;
+				}
+				WARN(true, "L3 custom error: MASTER:%s TARGET:%s\n",
+					master_name, target_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
 				writel(clear, l3_targ_base +
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 74c1643..90b5098 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -34,8 +34,11 @@
 /* L3 TARG register offsets */
 #define L3_TARG_STDERRLOG_MAIN		0x48
 #define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
+#define L3_TARG_STDERRLOG_MSTADDR	0x68
 #define L3_FLAGMUX_REGERR0		0xc
 
+#define NUM_OF_L3_MASTERS	(sizeof(l3_masters)/sizeof(l3_masters[0]))
+
 static u32 l3_flagmux[L3_MODULES] = {
 	0x500,
 	0x1000,
@@ -76,6 +79,37 @@ static u32 l3_targ_inst_clk3[] = {
 	0x0100	/* EMUSS */
 };
 
+static struct l3_masters_data {
+	u32 id;
+	char name[10];
+} l3_masters[] = {
+	{ 0x0 , "MPU"},
+	{ 0x10, "CS_ADP"},
+	{ 0x14, "xxx"},
+	{ 0x20, "DSP"},
+	{ 0x30, "IVAHD"},
+	{ 0x40, "ISS"},
+	{ 0x44, "DucatiM3"},
+	{ 0x48, "FaceDetect"},
+	{ 0x50, "SDMA_Rd"},
+	{ 0x54, "SDMA_Wr"},
+	{ 0x58, "xxx"},
+	{ 0x5C, "xxx"},
+	{ 0x60, "SGX"},
+	{ 0x70, "DSS"},
+	{ 0x80, "C2C"},
+	{ 0x88, "xxx"},
+	{ 0x8C, "xxx"},
+	{ 0x90, "HSI"},
+	{ 0xA0, "MMC1"},
+	{ 0xA4, "MMC2"},
+	{ 0xA8, "MMC6"},
+	{ 0xB0, "UNIPRO1"},
+	{ 0xC0, "USBHOSTHS"},
+	{ 0xC4, "USBOTGHS"},
+	{ 0xC8, "USBHOSTFS"}
+};
+
 static char *l3_targ_inst_name[L3_MODULES][18] = {
 	{
 		"DMM1",
-- 
1.7.4.1

