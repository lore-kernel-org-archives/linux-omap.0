From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function.
Date: Wed, 2 May 2012 15:18:13 +0530
Message-ID: <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49958 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2EBJsh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:37 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, R Sricharan <r.sricharan@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Instead of statically defining seperate arrays for every OMAP4+ archs,
have a generic init function to populate the arrays. This avoids the
need for creating new array for every arch added in the future that
reuses the prm and cm registers read/write code.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c  |   28 ++++++++++++++++++----------
 arch/arm/mach-omap2/common.c      |    1 +
 arch/arm/mach-omap2/common.h      |    1 +
 arch/arm/mach-omap2/prcm-common.h |   13 +++++++++++++
 arch/arm/mach-omap2/prcm.c        |    8 ++++++++
 arch/arm/mach-omap2/prminst44xx.c |   27 ++++++++++++++++-----------
 6 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index bd8810c..8c86d29 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -32,6 +32,7 @@
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
+#include "prcm-common.h"
 
 /*
  * CLKCTRL_IDLEST_*: possible values for the CM_*_CLKCTRL.IDLEST bitfield:
@@ -49,14 +50,21 @@
 #define CLKCTRL_IDLEST_INTERFACE_IDLE		0x2
 #define CLKCTRL_IDLEST_DISABLED			0x3
 
-static u32 _cm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
-	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
-	[OMAP4430_CM1_PARTITION]		= OMAP4430_CM1_BASE,
-	[OMAP4430_CM2_PARTITION]		= OMAP4430_CM2_BASE,
-	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
-};
+static void __iomem *_cm_bases[OMAP4_MAX_PRCM_PARTITIONS];
+
+/**
+ * omap_cm_base_init - Populates the cm partitions
+ *
+ * Populates the base addresses of the _cm_bases
+ * array used for read/write of cm module registers.
+ */
+void omap_cm_base_init(void)
+{
+	_cm_bases[OMAP4430_PRM_PARTITION] = prm_base;
+	_cm_bases[OMAP4430_CM1_PARTITION] = cm_base;
+	_cm_bases[OMAP4430_CM2_PARTITION] = cm2_base;
+	_cm_bases[OMAP4430_PRCM_MPU_PARTITION] = prcm_mpu_base;
+}
 
 /* Private functions */
 
@@ -106,7 +114,7 @@ u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+	return __raw_readl(_cm_bases[part] + inst + idx);
 }
 
 /* Write into a register in a CM instance */
@@ -115,7 +123,7 @@ void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+	__raw_writel(val, _cm_bases[part] + inst + idx);
 }
 
 /* Read-modify-write a register in CM1. Caller must lock */
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 1549c11..8a6953a 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -166,6 +166,7 @@ static struct omap_globals omap4_globals = {
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
+	.prcm_mpu	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..0672fc5 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -111,6 +111,7 @@ struct omap_globals {
 	void __iomem	*prm;            /* Power and Reset Management */
 	void __iomem	*cm;             /* Clock Management */
 	void __iomem	*cm2;
+	void __iomem	*prcm_mpu;
 };
 
 void omap2_set_globals_242x(void);
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 5aa5435..0b42143 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -410,6 +410,19 @@
 extern void __iomem *prm_base;
 extern void __iomem *cm_base;
 extern void __iomem *cm2_base;
+extern void __iomem *prcm_mpu_base;
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
+extern void omap_prm_base_init(void);
+extern void omap_cm_base_init(void);
+#else
+static inline void omap_prm_base_init(void)
+{
+}
+static inline void omap_cm_base_init(void)
+{
+}
+#endif
 
 /**
  * struct omap_prcm_irq - describes a PRCM interrupt bit
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 626acfa..480f40a 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -42,6 +42,7 @@
 void __iomem *prm_base;
 void __iomem *cm_base;
 void __iomem *cm2_base;
+void __iomem *prcm_mpu_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
@@ -155,4 +156,11 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		cm_base = omap2_globals->cm;
 	if (omap2_globals->cm2)
 		cm2_base = omap2_globals->cm2;
+	if (omap2_globals->prcm_mpu)
+		prcm_mpu_base = omap2_globals->prcm_mpu;
+
+	if (cpu_is_omap44xx()) {
+		omap_prm_base_init();
+		omap_cm_base_init();
+	}
 }
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 9b3898a..c12320c 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -18,20 +18,26 @@
 
 #include "iomap.h"
 #include "common.h"
+#include "prcm-common.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
 
-static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
-	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
-	[OMAP4430_CM1_PARTITION]		= 0,
-	[OMAP4430_CM2_PARTITION]		= 0,
-	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
-};
+static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
+
+/**
+ * omap_prm_base_init - Populates the prm partitions
+ *
+ * Populates the base addresses of the _prm_bases
+ * array used for read/write of prm module registers.
+ */
+void omap_prm_base_init(void)
+{
+	_prm_bases[OMAP4430_PRM_PARTITION] = prm_base;
+	_prm_bases[OMAP4430_PRCM_MPU_PARTITION] = prcm_mpu_base;
+}
 
 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
@@ -39,8 +45,7 @@ u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst +
-					       idx));
+	return __raw_readl(_prm_bases[part] + inst + idx);
 }
 
 /* Write into a register in a PRM instance */
@@ -49,7 +54,7 @@ void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst + idx));
+	__raw_writel(val, _prm_bases[part] + inst + idx);
 }
 
 /* Read-modify-write a register in PRM. Caller must lock */
-- 
1.7.5.4

