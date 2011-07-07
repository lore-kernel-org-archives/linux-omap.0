From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address
 with offset macros
Date: Thu, 7 Jul 2011 02:25:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab1GGIZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 04:25:24 -0400
In-Reply-To: <1309554558-19819-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The CLKCTRL register was accessed using an absolute address.
> The usage of hardcoded macros to calculate virtual address from physical
> one should be avoided as much as possible.
> The usage of a offset will allow future improvement like migration from
> the current architecture code toward a module driver.
> 
> Update cm_xxx accessor, move definition to the proper header file and
> update copyrights.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This patch was updated to use '_cminst_' in the function names that are in 
the cminst44xx.c file, rather than '_cm_', to preserve consistency with 
the rest of the file.  Updated patch below.


- Paul


>From d6ef52f331c0c4c0583f9945a01d6f9660b5311a Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 1 Jul 2011 23:09:08 +0200
Subject: [PATCH] OMAP4: hwmod: Replace CLKCTRL absolute address with offset
 macros

The CLKCTRL register was accessed using an absolute address.
The usage of hardcoded macros to calculate virtual address from physical
one should be avoided as much as possible.
The usage of a offset will allow future improvement like migration from
the current architecture code toward a module driver.

Update cm_xxx accessor, move definition to the proper header file and
update copyrights.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: renamed 'omap4_cm_' fns to 'omap4_cminst_'; removed empty
 fn prototype section from cm44xx.h]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm44xx.h                 |    8 +-
 arch/arm/mach-omap2/cminst44xx.c             |   23 +++-
 arch/arm/mach-omap2/cminst44xx.h             |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   12 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  182 ++++++++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 6 files changed, 146 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 0b87ec8..3380bee 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -1,7 +1,7 @@
 /*
  * OMAP4 Clock Management (CM) definitions
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -23,10 +23,4 @@
 #define OMAP4_CM_CLKSTCTRL				0x0000
 #define OMAP4_CM_STATICDEP				0x0004
 
-/* Function prototypes */
-# ifndef __ASSEMBLER__
-
-extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
-
-# endif
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index a482bfa..3f65ce0 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -2,6 +2,7 @@
  * OMAP4 CM instance functions
  *
  * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
@@ -199,9 +200,20 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
  *
  */
 
+static u32 _clkctrl_idlest(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+{
+	u32 v = omap4_cminst_read_inst_reg(part, inst, clkctrl_offs);
+	v &= OMAP4430_IDLEST_MASK;
+	v >>= OMAP4430_IDLEST_SHIFT;
+	return v;
+}
+
 /**
  * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
- * @clkctrl_reg: CLKCTRL module address
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Wait for the module IDLEST to be functional. If the idle state is in any
  * the non functional state (trans, idle or disabled), module and thus the
@@ -217,17 +229,16 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
  *   0x3 disabled: Module is disabled and cannot be accessed
  *
  */
-int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
+int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 {
 	int i = 0;
 
-	if (!clkctrl_reg)
+	if (!clkctrl_offs)
 		return 0;
 
 	omap_test_timeout((
-		((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) == 0) ||
-		 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
-		  OMAP4430_IDLEST_SHIFT) == 0x2)),
+		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0 ||
+		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x2),
 		MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 2b32c18..8eba2ae 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -17,6 +17,8 @@ extern void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 
+extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
+
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
@@ -32,6 +34,4 @@ extern u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst,
 extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
 					   u32 mask);
 
-extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
-
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ae48d3f..39c8831 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -145,7 +145,7 @@
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
-#include "cm44xx.h"
+#include "cminst44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "mux.h"
@@ -971,7 +971,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
  * Wait for a module @oh to leave slave idle.  Returns 0 if the module
  * does not have an IDLEST bit or if the module successfully leaves
  * slave idle; otherwise, pass along the return value of the
- * appropriate *_cm_wait_module_ready() function.
+ * appropriate *_cm*_wait_module_ready() function.
  */
 static int _wait_target_ready(struct omap_hwmod *oh)
 {
@@ -998,7 +998,13 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 						 oh->prcm.omap2.idlest_reg_id,
 						 oh->prcm.omap2.idlest_idle_bit);
 	} else if (cpu_is_omap44xx()) {
-		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.clkctrl_reg);
+		if (!oh->clkdm)
+			return -EINVAL;
+
+		ret = omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
+						     oh->clkdm->cm_inst,
+						     oh->clkdm->clkdm_offs,
+						     oh->prcm.omap4.clkctrl_offs);
 	} else {
 		BUG();
 	};
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0710c10..07a66880 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -121,6 +121,11 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.name		= "dmm",
 	.class		= &omap44xx_dmm_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_dmm_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmm_slaves),
 	.mpu_irqs	= omap44xx_dmm_irqs,
@@ -173,6 +178,11 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
 	.name		= "emif_fw",
 	.class		= &omap44xx_emif_fw_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_FW_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_emif_fw_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_emif_fw_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -213,6 +223,11 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.name		= "l3_instr",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_instr_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l3_instr_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_instr_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -308,6 +323,11 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.clkdm_name	= "l3_1_clkdm",
 	.mpu_irqs	= omap44xx_l3_targ_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_targ_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -404,6 +424,11 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.name		= "l3_main_2",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_2_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_2_L3_2_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l3_main_2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -455,6 +480,11 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	.name		= "l3_main_3",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_instr_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l3_main_3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -513,6 +543,11 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.name		= "l4_abe",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l4_abe_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_abe_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -536,6 +571,11 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.name		= "l4_cfg",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l4_cfg_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_cfg_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -559,6 +599,11 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.name		= "l4_per",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4PER_L4PER_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_per_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -582,6 +627,11 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_wkup_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -754,7 +804,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.main_clk	= "aess_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_AESS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_aess_slaves,
@@ -784,7 +834,7 @@ static struct omap_hwmod omap44xx_bandgap_hwmod = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= bandgap_opt_clks,
@@ -844,7 +894,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.main_clk	= "sys_32k_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_SYNCTIMER_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_counter_32k_slaves,
@@ -928,7 +978,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &dma_dev_attr,
@@ -1022,7 +1072,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.main_clk	= "dmic_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dmic_slaves,
@@ -1106,7 +1156,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.main_clk	= "dsp_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_TESLA_RSTCTRL,
 		},
 	},
@@ -1195,7 +1245,7 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -1293,7 +1343,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dispc_slaves,
@@ -1385,7 +1435,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dsi1_slaves,
@@ -1456,7 +1506,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dsi2_slaves,
@@ -1547,7 +1597,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_hdmi_slaves,
@@ -1632,7 +1682,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_rfbi_slaves,
@@ -1700,7 +1750,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_venc_slaves,
@@ -1779,7 +1829,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.main_clk	= "gpio1_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -1833,7 +1883,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.main_clk	= "gpio2_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -1887,7 +1937,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.main_clk	= "gpio3_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -1941,7 +1991,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.main_clk	= "gpio4_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -1995,7 +2045,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.main_clk	= "gpio5_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -2049,7 +2099,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.main_clk	= "gpio6_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -2128,7 +2178,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.main_clk	= "hsi_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_HSI_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_hsi_slaves,
@@ -2205,7 +2255,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.main_clk	= "i2c1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c1_slaves,
@@ -2259,7 +2309,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.main_clk	= "i2c2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c2_slaves,
@@ -2313,7 +2363,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.main_clk	= "i2c3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c3_slaves,
@@ -2367,7 +2417,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.main_clk	= "i2c4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c4_slaves,
@@ -2462,7 +2512,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.main_clk	= "ipu_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
 	},
@@ -2549,7 +2599,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.main_clk	= "iss_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_CAM_ISS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= iss_opt_clks,
@@ -2662,7 +2712,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.main_clk	= "iva_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
 		},
 	},
@@ -2733,7 +2783,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.main_clk	= "kbd_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_kbd_slaves,
@@ -2798,7 +2848,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mailbox_slaves,
@@ -2891,7 +2941,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.main_clk	= "mcbsp1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
@@ -2965,7 +3015,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.main_clk	= "mcbsp2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
@@ -3039,7 +3089,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.main_clk	= "mcbsp3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
@@ -3092,7 +3142,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.main_clk	= "mcbsp4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
@@ -3185,7 +3235,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.main_clk	= "mcpdm_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_PDM_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
@@ -3271,7 +3321,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.main_clk	= "mcspi1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -3332,7 +3382,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.main_clk	= "mcspi2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -3393,7 +3443,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.main_clk	= "mcspi3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -3452,7 +3502,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.main_clk	= "mcspi4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -3538,7 +3588,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.main_clk	= "mmc1_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mmc1_dev_attr,
@@ -3598,7 +3648,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.main_clk	= "mmc2_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc2_slaves,
@@ -3653,7 +3703,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.main_clk	= "mmc3_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc3_slaves,
@@ -3706,7 +3756,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.main_clk	= "mmc4_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc4_slaves,
@@ -3759,7 +3809,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.main_clk	= "mmc5_fck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc5_slaves,
@@ -3800,7 +3850,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_MPU_MPU_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET,
 		},
 	},
 	.masters	= omap44xx_mpu_masters,
@@ -3873,7 +3923,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.vdd_name	= "core",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
@@ -3920,7 +3970,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.vdd_name	= "iva",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
@@ -3967,7 +4017,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.vdd_name	= "mpu",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
@@ -4029,7 +4079,7 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	.clkdm_name	= "l4_cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4CFG_HW_SEM_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_spinlock_slaves,
@@ -4113,7 +4163,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.main_clk	= "timer1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer1_slaves,
@@ -4159,7 +4209,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.main_clk	= "timer2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer2_slaves,
@@ -4205,7 +4255,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.main_clk	= "timer3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer3_slaves,
@@ -4251,7 +4301,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.main_clk	= "timer4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer4_slaves,
@@ -4316,7 +4366,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.main_clk	= "timer5_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer5_slaves,
@@ -4381,7 +4431,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.main_clk	= "timer6_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer6_slaves,
@@ -4446,7 +4496,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.main_clk	= "timer7_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer7_slaves,
@@ -4511,7 +4561,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.main_clk	= "timer8_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer8_slaves,
@@ -4557,7 +4607,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.main_clk	= "timer9_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer9_slaves,
@@ -4603,7 +4653,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.main_clk	= "timer10_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer10_slaves,
@@ -4649,7 +4699,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.main_clk	= "timer11_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer11_slaves,
@@ -4724,7 +4774,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.main_clk	= "uart1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart1_slaves,
@@ -4777,7 +4827,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.main_clk	= "uart2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart2_slaves,
@@ -4831,7 +4881,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.main_clk	= "uart3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart3_slaves,
@@ -4884,7 +4934,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.main_clk	= "uart4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart4_slaves,
@@ -4963,7 +5013,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
@@ -5036,7 +5086,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.main_clk	= "wd_timer2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
@@ -5101,7 +5151,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.main_clk	= "wd_timer3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6cfc76b..507e65a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -362,7 +362,7 @@ struct omap_hwmod_omap2_prcm {
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
-	void __iomem	*clkctrl_reg;
+	u16		clkctrl_offs;
 	void __iomem	*rstctrl_reg;
 	u8		submodule_wkdep_bit;
 };
-- 
1.7.5.4

