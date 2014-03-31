From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/55] ARM: OMAP4+: PRM: add prm_dev_inst offset as a global parameter
Date: Mon, 31 Mar 2014 18:15:48 +0300
Message-ID: <1396278994-12624-10-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54660 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbaCaPR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:29 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is different for OMAP4, OMAP5 and DRA7, and is currently checked
runtime with a cpu_is_X check. Replace this with an init time setting.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h         |    1 +
 arch/arm/mach-omap2/prm44xx.c     |   20 +++++++++++++++++---
 arch/arm/mach-omap2/prm_common.c  |    1 +
 arch/arm/mach-omap2/prminst44xx.c |   22 ++++++----------------
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 8d40a5d..8caa7af 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -17,6 +17,7 @@
 
 # ifndef __ASSEMBLER__
 extern void __iomem *prm_base;
+extern u16 prm_dev_inst;
 extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int of_prcm_init(void);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index fb05abc..206dcd9 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -24,6 +24,8 @@
 #include "common.h"
 #include "vp.h"
 #include "prm44xx.h"
+#include "prm54xx.h"
+#include "prm7xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx_private.h"
@@ -664,10 +666,22 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(u16 cpu_type)
 {
-	if (cpu_type != PRM_DRA7)
+	switch (cpu_type) {
+	case PRM_OMAP4:
+		prm_features |= PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE;
+		prm_dev_inst = OMAP4430_PRM_DEVICE_INST;
+		break;
+	case PRM_OMAP5:
 		prm_features |= PRM_HAS_VOLTAGE;
-	if (cpu_type == PRM_OMAP4)
-		prm_features |= PRM_HAS_IO_WAKEUP;
+		prm_dev_inst = OMAP54XX_PRM_DEVICE_INST;
+		break;
+	case PRM_DRA7:
+		prm_dev_inst = DRA7XX_PRM_DEVICE_INST;
+		break;
+	default:
+		pr_err("%s: unsupported cpu type: %d\n", __func__, cpu_type);
+		return -EINVAL;
+	}
 
 	return prm_register(&omap44xx_prm_ll_data);
 }
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 76ca320..5d5d564 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -63,6 +63,7 @@ static struct omap_prcm_irq_setup *prcm_irq_setup;
 void __iomem *prm_base;
 
 u16 prm_features;
+u16 prm_dev_inst;
 
 /*
  * prm_ll_data: function pointers to SoC-specific implementations of
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 00b69d1..d4a7919 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -168,28 +168,18 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 void omap4_prminst_global_warm_sw_reset(void)
 {
 	u32 v;
-	s16 dev_inst;
-
-	if (cpu_is_omap44xx())
-		dev_inst = OMAP4430_PRM_DEVICE_INST;
-	else if (soc_is_omap54xx())
-		dev_inst = OMAP54XX_PRM_DEVICE_INST;
-	else if (soc_is_dra7xx())
-		dev_inst = DRA7XX_PRM_DEVICE_INST;
-	else
-		return;
-
-	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, dev_inst,
+
+	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, prm_dev_inst,
 					OMAP4_PRM_RSTCTRL_OFFSET);
 	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
 	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 OMAP4430_PRM_DEVICE_INST,
-				 OMAP4_PRM_RSTCTRL_OFFSET);
+				     prm_dev_inst,
+				     OMAP4_PRM_RSTCTRL_OFFSET);
 
 	/* OCP barrier */
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    OMAP4430_PRM_DEVICE_INST,
-				    OMAP4_PRM_RSTCTRL_OFFSET);
+					prm_dev_inst,
+					OMAP4_PRM_RSTCTRL_OFFSET);
 }
 
 void omap4_prminst_mpuss_clear_prev_logic_pwrst(void)
-- 
1.7.9.5

