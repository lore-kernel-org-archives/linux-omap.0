From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/8] OMAP: Fix indentation issues in l3 error handler.
Date: Thu, 8 Sep 2011 10:52:03 +0530
Message-ID: <1315459327-3285-5-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38750 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1IHFWa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 01:22:30 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

From: sricharan <r.sricharan@ti.com>

The indentation problems in the l3 noc and smx
error handler files are fixed.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   58 +++++++-------
 arch/arm/mach-omap2/omap_l3_noc.h |  106 +++++++++++++-------------
 arch/arm/mach-omap2/omap_l3_smx.c |   86 ++++++++++----------
 arch/arm/mach-omap2/omap_l3_smx.h |  156 ++++++++++++++++++------------------
 4 files changed, 202 insertions(+), 204 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index cf237dd..1f68e95 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -1,25 +1,25 @@
 /*
-  * OMAP4XXX L3 Interconnect error handling driver
-  *
-  * Copyright (C) 2011 Texas Corporation
-  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
-  *	Sricharan <r.sricharan@ti.com>
-  *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License as published by
-  * the Free Software Foundation; either version 2 of the License, or
-  * (at your option) any later version.
-  *
-  * This program is distributed in the hope that it will be useful,
-  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  * GNU General Public License for more details.
-  *
-  * You should have received a copy of the GNU General Public License
-  * along with this program; if not, write to the Free Software
-  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-  * USA
-  */
+ * OMAP4XXX L3 Interconnect error handling driver
+ *
+ * Copyright (C) 2011 Texas Corporation
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	Sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ */
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -55,7 +55,7 @@
 static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 {
 
-	struct omap4_l3		*l3 = _l3;
+	struct omap4_l3 *l3 = _l3;
 	int inttype, i;
 	int err_src = 0;
 	u32 std_err_main, err_reg, clear, base, l3_targ_base;
@@ -122,7 +122,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 static int __init omap4_l3_probe(struct platform_device *pdev)
 {
-	static struct omap4_l3		*l3;
+	static struct omap4_l3 *l3;
 	struct resource	*res;
 	int ret;
 
@@ -182,7 +182,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-					 OMAP44XX_IRQ_L3_DBG);
+						OMAP44XX_IRQ_L3_DBG);
 		goto err3;
 	}
 
@@ -192,7 +192,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 			IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
-					 OMAP44XX_IRQ_L3_APP);
+						OMAP44XX_IRQ_L3_APP);
 		goto err4;
 	}
 
@@ -213,7 +213,7 @@ err0:
 
 static int __exit omap4_l3_remove(struct platform_device *pdev)
 {
-	struct omap4_l3         *l3 = platform_get_drvdata(pdev);
+	struct omap4_l3 *l3 = platform_get_drvdata(pdev);
 
 	free_irq(l3->app_irq, l3);
 	free_irq(l3->debug_irq, l3);
@@ -226,9 +226,9 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap4_l3_driver = {
-	.remove		= __exit_p(omap4_l3_remove),
-	.driver		= {
-	.name		= "omap_l3_noc",
+	.remove	= __exit_p(omap4_l3_remove),
+	.driver	= {
+	.name = "omap_l3_noc",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/omap_l3_noc.h b/arch/arm/mach-omap2/omap_l3_noc.h
index 22c0d57..9120e70 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.h
+++ b/arch/arm/mach-omap2/omap_l3_noc.h
@@ -1,25 +1,25 @@
- /*
-  * OMAP4XXX L3 Interconnect  error handling driver header
-  *
-  * Copyright (C) 2011 Texas Corporation
-  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
-  *	sricharan <r.sricharan@ti.com>
-  *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License as published by
-  * the Free Software Foundation; either version 2 of the License, or
-  * (at your option) any later version.
-  *
-  * This program is distributed in the hope that it will be useful,
-  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  * GNU General Public License for more details.
-  *
-  * You should have received a copy of the GNU General Public License
-  * along with this program; if not, write to the Free Software
-  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-  * USA
-  */
+/*
+ * OMAP4XXX L3 Interconnect  error handling driver header
+ *
+ * Copyright (C) 2011 Texas Corporation
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ */
 #ifndef __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 #define __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 
@@ -32,9 +32,9 @@
 #define L3_DEBUG_ERROR			0x1
 
 /* L3 TARG register offsets */
-#define L3_TARG_STDERRLOG_MAIN         0x48
-#define L3_TARG_STDERRLOG_SLVOFSLSB    0x5c
-#define L3_FLAGMUX_REGERR0	       0xc
+#define L3_TARG_STDERRLOG_MAIN		0x48
+#define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
+#define L3_FLAGMUX_REGERR0		0xc
 
 u32 l3_flagmux[L3_MODULES] = {
 	0x500,
@@ -78,34 +78,34 @@ u32 l3_targ_inst_clk3[] = {
 
 char *l3_targ_inst_name[L3_MODULES][18] = {
 	{
-	"DMM1",
-	"DMM2",
-	"ABE",
-	"L4CFG",
-	"CLK2 PWR DISC",
+		"DMM1",
+		"DMM2",
+		"ABE",
+		"L4CFG",
+		"CLK2 PWR DISC",
 	},
 	{
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
+		"CORTEX M3" ,
+		"DSS ",
+		"GPMC ",
+		"ISS ",
+		"IVAHD ",
+		"AES1",
+		"L4 PER0",
+		"OCMRAM ",
+		"GPMC sERROR",
+		"SGX ",
+		"SL2 ",
+		"C2C ",
+		"PWR DISC CLK1",
+		"SHA1",
+		"AES2",
+		"L4 PER3",
+		"L4 PER1",
+		"L4 PER2",
 	},
 	{
-	"EMUSS",
+		"EMUSS",
 	},
 };
 
@@ -116,13 +116,13 @@ u32 *l3_targ[L3_MODULES] = {
 };
 
 struct omap4_l3 {
-	struct device	*dev;
-	struct clk	*ick;
+	struct device *dev;
+	struct clk *ick;
 
 	/* memory base */
 	void __iomem *l3_base[L3_MODULES];
 
-	int		debug_irq;
-	int		app_irq;
+	int debug_irq;
+	int app_irq;
 };
 #endif
diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index fa07edf..a05a62f 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -1,26 +1,26 @@
- /*
-  * OMAP3XXX L3 Interconnect Driver
-  *
-  * Copyright (C) 2011 Texas Corporation
-  *	Felipe Balbi <balbi@ti.com>
-  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
-  *	Sricharan <r.sricharan@ti.com>
-  *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License as published by
-  * the Free Software Foundation; either version 2 of the License, or
-  * (at your option) any later version.
-  *
-  * This program is distributed in the hope that it will be useful,
-  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  * GNU General Public License for more details.
-  *
-  * You should have received a copy of the GNU General Public License
-  * along with this program; if not, write to the Free Software
-  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-  * USA
-  */
+/*
+ * OMAP3XXX L3 Interconnect Driver
+ *
+ * Copyright (C) 2011 Texas Corporation
+ *	Felipe Balbi <balbi@ti.com>
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	Sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ */
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -135,7 +135,7 @@ static char *omap3_l3_initiator_string(u8 initid)
 	}
 }
 
-/**
+/*
  * omap3_l3_block_irq - handles a register block's irq
  * @l3: struct omap3_l3 *
  * @base: register block base address
@@ -150,30 +150,29 @@ static char *omap3_l3_initiator_string(u8 initid)
 static irqreturn_t omap3_l3_block_irq(struct omap3_l3 *l3,
 					u64 error, int error_addr)
 {
-	u8                      code = omap3_l3_decode_error_code(error);
-	u8                      initid = omap3_l3_decode_initid(error);
-	u8                      multi = error & L3_ERROR_LOG_MULTI;
-	u32			address = omap3_l3_decode_addr(error_addr);
+	u8 code = omap3_l3_decode_error_code(error);
+	u8 initid = omap3_l3_decode_initid(error);
+	u8 multi = error & L3_ERROR_LOG_MULTI;
+	u32 address = omap3_l3_decode_addr(error_addr);
 
 	WARN(true, "%s seen by %s %s at address %x\n",
-				 omap3_l3_code_string(code),
-			  omap3_l3_initiator_string(initid),
-			     multi ? "Multiple Errors" : "",
-						   address);
+			omap3_l3_code_string(code),
+			omap3_l3_initiator_string(initid),
+			multi ? "Multiple Errors" : "", address);
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 {
-	struct omap3_l3         *l3 = _l3;
-	u64                     status, clear;
-	u64                     error;
-	u64			error_addr;
-	u64			err_source = 0;
-	void			__iomem *base;
-	int			int_type;
-	irqreturn_t             ret = IRQ_NONE;
+	struct omap3_l3 *l3 = _l3;
+	u64 status, clear;
+	u64 error;
+	u64 error_addr;
+	u64 err_source = 0;
+	void __iomem *base;
+	int int_type;
+	irqreturn_t ret = IRQ_NONE;
 
 	int_type = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
 	if (!int_type) {
@@ -197,7 +196,6 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
 	if (error) {
 		error_addr = omap3_l3_readll(base, L3_ERROR_LOG_ADDR);
-
 		ret |= omap3_l3_block_irq(l3, error, error_addr);
 	}
 
@@ -214,9 +212,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 
 static int __init omap3_l3_probe(struct platform_device *pdev)
 {
-	struct omap3_l3         *l3;
-	struct resource         *res;
-	int                     ret;
+	struct omap3_l3 *l3;
+	struct resource *res;
+	int ret;
 
 	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
 	if (!l3)
diff --git a/arch/arm/mach-omap2/omap_l3_smx.h b/arch/arm/mach-omap2/omap_l3_smx.h
index 185d77a..18e5ec2 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.h
+++ b/arch/arm/mach-omap2/omap_l3_smx.h
@@ -1,26 +1,26 @@
- /*
-  * OMAP3XXX L3 Interconnect Driver header
-  *
-  * Copyright (C) 2011 Texas Corporation
-  *	Felipe Balbi <balbi@ti.com>
-  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
-  *	sricharan <r.sricharan@ti.com>
-  *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License as published by
-  * the Free Software Foundation; either version 2 of the License, or
-  * (at your option) any later version.
-  *
-  * This program is distributed in the hope that it will be useful,
-  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  * GNU General Public License for more details.
-  *
-  * You should have received a copy of the GNU General Public License
-  * along with this program; if not, write to the Free Software
-  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-  * USA
-  */
+/*
+ * OMAP3XXX L3 Interconnect Driver header
+ *
+ * Copyright (C) 2011 Texas Corporation
+ *	Felipe Balbi <balbi@ti.com>
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *	sricharan <r.sricharan@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ */
 #ifndef __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 #define __ARCH_ARM_MACH_OMAP2_L3_INTERCONNECT_3XXX_H
 
@@ -78,32 +78,32 @@ static const u64 shift = 1;
 #define L3_STATUS_0_L4EMUTA_REQ		(shift << 60)
 #define L3_STATUS_0_MAD2DTA_REQ		(shift << 61)
 
-#define L3_STATUS_0_TIMEOUT_MASK	(L3_STATUS_0_MPUIA_BRST         \
-					| L3_STATUS_0_MPUIA_RSP         \
-					| L3_STATUS_0_IVAIA_BRST        \
-					| L3_STATUS_0_IVAIA_RSP         \
-					| L3_STATUS_0_SGXIA_BRST        \
-					| L3_STATUS_0_SGXIA_RSP         \
-					| L3_STATUS_0_CAMIA_BRST        \
-					| L3_STATUS_0_CAMIA_RSP         \
-					| L3_STATUS_0_DISPIA_BRST       \
-					| L3_STATUS_0_DISPIA_RSP        \
-					| L3_STATUS_0_DMARDIA_BRST      \
-					| L3_STATUS_0_DMARDIA_RSP       \
-					| L3_STATUS_0_DMAWRIA_BRST      \
-					| L3_STATUS_0_DMAWRIA_RSP       \
-					| L3_STATUS_0_USBOTGIA_BRST     \
-					| L3_STATUS_0_USBOTGIA_RSP      \
-					| L3_STATUS_0_USBHOSTIA_BRST    \
-					| L3_STATUS_0_SMSTA_REQ         \
-					| L3_STATUS_0_GPMCTA_REQ        \
-					| L3_STATUS_0_OCMRAMTA_REQ      \
-					| L3_STATUS_0_OCMROMTA_REQ      \
-					| L3_STATUS_0_IVATA_REQ         \
-					| L3_STATUS_0_SGXTA_REQ         \
-					| L3_STATUS_0_L4CORETA_REQ      \
-					| L3_STATUS_0_L4PERTA_REQ       \
-					| L3_STATUS_0_L4EMUTA_REQ       \
+#define L3_STATUS_0_TIMEOUT_MASK	(L3_STATUS_0_MPUIA_BRST		\
+					| L3_STATUS_0_MPUIA_RSP		\
+					| L3_STATUS_0_IVAIA_BRST	\
+					| L3_STATUS_0_IVAIA_RSP		\
+					| L3_STATUS_0_SGXIA_BRST	\
+					| L3_STATUS_0_SGXIA_RSP		\
+					| L3_STATUS_0_CAMIA_BRST	\
+					| L3_STATUS_0_CAMIA_RSP		\
+					| L3_STATUS_0_DISPIA_BRST	\
+					| L3_STATUS_0_DISPIA_RSP	\
+					| L3_STATUS_0_DMARDIA_BRST	\
+					| L3_STATUS_0_DMARDIA_RSP	\
+					| L3_STATUS_0_DMAWRIA_BRST	\
+					| L3_STATUS_0_DMAWRIA_RSP	\
+					| L3_STATUS_0_USBOTGIA_BRST	\
+					| L3_STATUS_0_USBOTGIA_RSP	\
+					| L3_STATUS_0_USBHOSTIA_BRST	\
+					| L3_STATUS_0_SMSTA_REQ		\
+					| L3_STATUS_0_GPMCTA_REQ	\
+					| L3_STATUS_0_OCMRAMTA_REQ	\
+					| L3_STATUS_0_OCMROMTA_REQ	\
+					| L3_STATUS_0_IVATA_REQ		\
+					| L3_STATUS_0_SGXTA_REQ		\
+					| L3_STATUS_0_L4CORETA_REQ	\
+					| L3_STATUS_0_L4PERTA_REQ	\
+					| L3_STATUS_0_L4EMUTA_REQ	\
 					| L3_STATUS_0_MAD2DTA_REQ)
 
 #define L3_SI_FLAG_STATUS_1		0x530
@@ -137,19 +137,19 @@ static const u64 shift = 1;
 
 enum omap3_l3_initiator_id {
 	/* LCD has 1 ID */
-	OMAP_L3_LCD	        = 29,
+	OMAP_L3_LCD = 29,
 	/* SAD2D has 1 ID */
-	OMAP_L3_SAD2D		= 28,
+	OMAP_L3_SAD2D = 28,
 	/* MPU has 5 IDs */
-	OMAP_L3_IA_MPU_SS_1     = 27,
-	OMAP_L3_IA_MPU_SS_2     = 26,
-	OMAP_L3_IA_MPU_SS_3     = 25,
-	OMAP_L3_IA_MPU_SS_4     = 24,
-	OMAP_L3_IA_MPU_SS_5     = 23,
+	OMAP_L3_IA_MPU_SS_1 = 27,
+	OMAP_L3_IA_MPU_SS_2 = 26,
+	OMAP_L3_IA_MPU_SS_3 = 25,
+	OMAP_L3_IA_MPU_SS_4 = 24,
+	OMAP_L3_IA_MPU_SS_5 = 23,
 	/* IVA2.2 SS has 3 IDs*/
-	OMAP_L3_IA_IVA_SS_1     = 22,
-	OMAP_L3_IA_IVA_SS_2     = 21,
-	OMAP_L3_IA_IVA_SS_3     = 20,
+	OMAP_L3_IA_IVA_SS_1 = 22,
+	OMAP_L3_IA_IVA_SS_2 = 21,
+	OMAP_L3_IA_IVA_SS_3 = 20,
 	/* IVA 2.2 SS DMA has 6 IDS */
 	OMAP_L3_IA_IVA_SS_DMA_1 = 19,
 	OMAP_L3_IA_IVA_SS_DMA_2 = 18,
@@ -158,25 +158,25 @@ enum omap3_l3_initiator_id {
 	OMAP_L3_IA_IVA_SS_DMA_5 = 15,
 	OMAP_L3_IA_IVA_SS_DMA_6 = 14,
 	/* SGX has 1 ID */
-	OMAP_L3_IA_SGX		= 13,
+	OMAP_L3_IA_SGX = 13,
 	/* CAM has 3 ID */
-	OMAP_L3_IA_CAM_1	= 12,
-	OMAP_L3_IA_CAM_2	= 11,
-	OMAP_L3_IA_CAM_3	= 10,
+	OMAP_L3_IA_CAM_1 = 12,
+	OMAP_L3_IA_CAM_2 = 11,
+	OMAP_L3_IA_CAM_3 = 10,
 	/* DAP has 1 ID */
-	OMAP_L3_IA_DAP		= 9,
+	OMAP_L3_IA_DAP = 9,
 	/* SDMA WR has 2 IDs */
-	OMAP_L3_SDMA_WR_1	= 8,
-	OMAP_L3_SDMA_WR_2	= 7,
+	OMAP_L3_SDMA_WR_1 = 8,
+	OMAP_L3_SDMA_WR_2 = 7,
 	/* SDMA RD has 4 IDs */
-	OMAP_L3_SDMA_RD_1	= 6,
-	OMAP_L3_SDMA_RD_2	= 5,
-	OMAP_L3_SDMA_RD_3	= 4,
-	OMAP_L3_SDMA_RD_4	= 3,
+	OMAP_L3_SDMA_RD_1 = 6,
+	OMAP_L3_SDMA_RD_2 = 5,
+	OMAP_L3_SDMA_RD_3 = 4,
+	OMAP_L3_SDMA_RD_4 = 3,
 	/* HSUSB OTG has 1 ID */
-	OMAP_L3_USBOTG		= 2,
+	OMAP_L3_USBOTG = 2,
 	/* HSUSB HOST has 1 ID */
-	OMAP_L3_USBHOST		= 1,
+	OMAP_L3_USBHOST = 1,
 };
 
 enum omap3_l3_code {
@@ -192,17 +192,17 @@ enum omap3_l3_code {
 };
 
 struct omap3_l3 {
-	struct device   *dev;
-	struct clk      *ick;
+	struct device *dev;
+	struct clk *ick;
 
 	/* memory base*/
-	void __iomem    *rt;
+	void __iomem *rt;
 
-	int             debug_irq;
-	int             app_irq;
+	int debug_irq;
+	int app_irq;
 
 	/* true when and inband functional error occurs */
-	unsigned        inband:1;
+	unsigned inband:1;
 };
 
 /* offsets for l3 agents in order with the Flag status register */
-- 
1.7.4.1

