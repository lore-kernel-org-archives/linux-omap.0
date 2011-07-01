From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address with offset macros
Date: Fri, 1 Jul 2011 23:09:08 +0200
Message-ID: <1309554558-19819-4-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59301 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756444Ab1GAVJl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:09:41 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

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
---
 arch/arm/mach-omap2/cm44xx.h                 |    3 +-
 arch/arm/mach-omap2/cminst44xx.c             |   23 +++-
 arch/arm/mach-omap2/cminst44xx.h             |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   10 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  182 ++++++++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 6 files changed, 145 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 0b87ec8..cdda756 100644
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
@@ -26,7 +26,6 @@
 /* Function prototypes */
 # ifndef __ASSEMBLER__
 
-extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
 
 # endif
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index a482bfa..1df740e 100644
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
+int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
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
index 2b32c18..9d39c70 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -17,6 +17,8 @@ extern void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 
+extern int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
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
index 9b6b8c6..83eb528 100644
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
@@ -1016,7 +1016,13 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 						 oh->prcm.omap2.idlest_reg_id,
 						 oh->prcm.omap2.idlest_idle_bit);
 	} else if (cpu_is_omap44xx()) {
-		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.clkctrl_reg);
+		if (!oh->clkdm)
+			return -EINVAL;
+
+		ret = omap4_cm_wait_module_ready(oh->clkdm->prcm_partition,
+						 oh->clkdm->cm_inst,
+						 oh->clkdm->clkdm_offs,
+						 oh->prcm.omap4.clkctrl_offs);
 	} else {
 		BUG();
 	};
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 64f11de..59233c7 100644
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -305,6 +320,11 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_1_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
+		},
+	},
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
 	.mpu_irqs	= omap44xx_l3_main_1_irqs,
@@ -403,6 +423,11 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -454,6 +479,11 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -512,6 +542,11 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -535,6 +570,11 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -558,6 +598,11 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -581,6 +626,11 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
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
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -756,7 +806,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.main_clk	= "aess_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_AESS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_aess_slaves,
@@ -786,7 +836,7 @@ static struct omap_hwmod omap44xx_bandgap_hwmod = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= bandgap_opt_clks,
@@ -846,7 +896,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_SYNCTIMER_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_counter_32k_slaves,
@@ -930,7 +980,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &dma_dev_attr,
@@ -1024,7 +1074,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.main_clk	= "dmic_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dmic_slaves,
@@ -1108,7 +1158,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.main_clk	= "dsp_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_TESLA_RSTCTRL,
 		},
 	},
@@ -1198,7 +1248,7 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -1304,7 +1354,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_dispc_opt_clks,
@@ -1403,7 +1453,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_dsi1_opt_clks,
@@ -1481,7 +1531,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_dsi2_opt_clks,
@@ -1579,7 +1629,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
@@ -1670,7 +1720,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
@@ -1744,7 +1794,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= dss_venc_opt_clks,
@@ -1825,7 +1875,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.main_clk	= "gpio1_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -1879,7 +1929,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.main_clk	= "gpio2_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -1933,7 +1983,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.main_clk	= "gpio3_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -1987,7 +2037,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.main_clk	= "gpio4_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -2041,7 +2091,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.main_clk	= "gpio5_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -2095,7 +2145,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.main_clk	= "gpio6_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -2174,7 +2224,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.main_clk	= "hsi_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_HSI_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_hsi_slaves,
@@ -2251,7 +2301,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.main_clk	= "i2c1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c1_slaves,
@@ -2305,7 +2355,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.main_clk	= "i2c2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c2_slaves,
@@ -2359,7 +2409,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.main_clk	= "i2c3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c3_slaves,
@@ -2413,7 +2463,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.main_clk	= "i2c4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c4_slaves,
@@ -2508,7 +2558,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.main_clk	= "ipu_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
 	},
@@ -2595,7 +2645,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.main_clk	= "iss_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_CAM_ISS_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= iss_opt_clks,
@@ -2708,7 +2758,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.main_clk	= "iva_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
 			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
 		},
 	},
@@ -2779,7 +2829,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.main_clk	= "kbd_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_kbd_slaves,
@@ -2844,7 +2894,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mailbox_slaves,
@@ -2937,7 +2987,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.main_clk	= "mcbsp1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
@@ -3011,7 +3061,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.main_clk	= "mcbsp2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
@@ -3085,7 +3135,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.main_clk	= "mcbsp3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
@@ -3138,7 +3188,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.main_clk	= "mcbsp4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
@@ -3231,7 +3281,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.main_clk	= "mcpdm_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_PDM_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
@@ -3317,7 +3367,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.main_clk	= "mcspi1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -3378,7 +3428,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.main_clk	= "mcspi2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -3439,7 +3489,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.main_clk	= "mcspi3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -3498,7 +3548,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.main_clk	= "mcspi4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -3583,7 +3633,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.main_clk	= "mmc1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &mmc1_dev_attr,
@@ -3643,7 +3693,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.main_clk	= "mmc2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc2_slaves,
@@ -3698,7 +3748,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.main_clk	= "mmc3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc3_slaves,
@@ -3751,7 +3801,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.main_clk	= "mmc4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc4_slaves,
@@ -3804,7 +3854,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.main_clk	= "mmc5_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc5_slaves,
@@ -3845,7 +3895,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_MPU_MPU_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET,
 		},
 	},
 	.masters	= omap44xx_mpu_masters,
@@ -3918,7 +3968,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.vdd_name	= "core",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
@@ -3965,7 +4015,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.vdd_name	= "iva",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
@@ -4012,7 +4062,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.vdd_name	= "mpu",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
@@ -4074,7 +4124,7 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	.clkdm_name	= "l4_cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4CFG_HW_SEM_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_spinlock_slaves,
@@ -4158,7 +4208,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.main_clk	= "timer1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer1_slaves,
@@ -4204,7 +4254,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.main_clk	= "timer2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer2_slaves,
@@ -4250,7 +4300,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.main_clk	= "timer3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer3_slaves,
@@ -4296,7 +4346,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.main_clk	= "timer4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer4_slaves,
@@ -4361,7 +4411,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.main_clk	= "timer5_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer5_slaves,
@@ -4426,7 +4476,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.main_clk	= "timer6_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer6_slaves,
@@ -4491,7 +4541,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.main_clk	= "timer7_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer7_slaves,
@@ -4556,7 +4606,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.main_clk	= "timer8_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer8_slaves,
@@ -4602,7 +4652,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.main_clk	= "timer9_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer9_slaves,
@@ -4648,7 +4698,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.main_clk	= "timer10_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer10_slaves,
@@ -4694,7 +4744,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.main_clk	= "timer11_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer11_slaves,
@@ -4769,7 +4819,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.main_clk	= "uart1_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART1_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart1_slaves,
@@ -4822,7 +4872,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.main_clk	= "uart2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart2_slaves,
@@ -4876,7 +4926,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.main_clk	= "uart3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart3_slaves,
@@ -4929,7 +4979,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.main_clk	= "uart4_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_UART4_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart4_slaves,
@@ -5008,7 +5058,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
@@ -5081,7 +5131,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.main_clk	= "wd_timer2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
@@ -5146,7 +5196,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.main_clk	= "wd_timer3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
+			.clkctrl_offs = OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 28ea1c8..22864fd 100644
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
1.7.0.4

