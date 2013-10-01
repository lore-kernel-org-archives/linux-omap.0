From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 08/11] ARM: OMAP2+: hwmod: AM43x support
Date: Tue, 1 Oct 2013 12:38:09 +0530
Message-ID: <268a93ef4fda845d59b323ca76821a363f661e75.1380608720.git.afzal@ti.com>
References: <cover.1380608719.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab3JAHIi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 03:08:38 -0400
In-Reply-To: <cover.1380608719.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Add hwmod support for IP's that are present in AM43x, but not in AM335x.
AM43x additional ones added here are,
1. synctimer
2. timer8-11
3. ehrpwm3-5
4. spi2-4
5. gpio4-5

AM43x pruss interconnect which is different as compared to AM335x, has
been taken care.

And register offsets for same hwmod's shared with AM335x is different,
AM43x register offsets are updated appropriately.

ocp clock of those in l4_wkup is fed from "sys_clkin_ck" instead of
"dpll_core_m4_div2_ck", so "ocpif" for those in AM43x l4_wkup has been
added seperately.

hwmod's has been added for those that have main clock (wkup_m3, control,
gpio0) and clock domain (l4_hs) different from AM335x. debugss and
adc_tsc that have different clocks and clockdomains repectively has not
been added due to the reasons mentioned below.

AM43x also has IP's like qspi, hdq1w, vpfe, des, rng, usb, dss, debugss,
adc_tsc. These are not handled here due to both/either of following
reasons,
1. To avoid churn; most of them don't have DT bindings, which would
   necessitate adding address space in hwmod, which any way would have
   to be removed once DT bindings happen with driver support.
2. patches would come in from sources other than the author

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h                   |   1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  74 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 622 +++++++++++++++++++++
 4 files changed, 698 insertions(+)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_43xx_data.c

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index d02acf9..0f97d63 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -752,6 +752,7 @@ extern int omap44xx_hwmod_init(void);
 extern int omap54xx_hwmod_init(void);
 extern int am33xx_hwmod_init(void);
 extern int dra7xx_hwmod_init(void);
+int am43xx_hwmod_init(void);
 
 extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index a9a7902..130332c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -158,5 +158,6 @@ extern struct omap_gpio_dev_attr gpio_dev_attr;
 extern struct omap2_mcspi_dev_attr mcspi_attrib;
 
 void omap_hwmod_am33xx_reg(void);
+void omap_hwmod_am43xx_reg(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 598f813..d080bef 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -23,6 +23,7 @@
 #include "cm33xx.h"
 #include "prm33xx.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
+#include "prcm43xx.h"
 
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
 #define RSTCTRL(oh, rstctrl) ((oh).prcm.omap4.rstctrl_offs = (rstctrl))
@@ -1380,3 +1381,76 @@ void omap_hwmod_am33xx_reg(void)
 	omap_hwmod_am33xx_clkctrl();
 	omap_hwmod_am33xx_rst();
 }
+
+static void omap_hwmod_am43xx_clkctrl(void)
+{
+	CLKCTRL(am33xx_uart2_hwmod, AM43XX_CM_PER_UART1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart3_hwmod, AM43XX_CM_PER_UART2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart4_hwmod, AM43XX_CM_PER_UART3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart5_hwmod, AM43XX_CM_PER_UART4_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart6_hwmod, AM43XX_CM_PER_UART5_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_dcan0_hwmod, AM43XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_dcan1_hwmod, AM43XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_elm_hwmod, AM43XX_CM_PER_ELM_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss0_hwmod, AM43XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss1_hwmod, AM43XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss2_hwmod, AM43XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio1_hwmod, AM43XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio2_hwmod, AM43XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio3_hwmod, AM43XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_i2c2_hwmod, AM43XX_CM_PER_I2C1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_i2c3_hwmod, AM43XX_CM_PER_I2C2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mailbox_hwmod, AM43XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mcasp0_hwmod, AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mcasp1_hwmod, AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc0_hwmod, AM43XX_CM_PER_MMC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc1_hwmod, AM43XX_CM_PER_MMC1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spi0_hwmod, AM43XX_CM_PER_SPI0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spi1_hwmod, AM43XX_CM_PER_SPI1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spinlock_hwmod, AM43XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer2_hwmod, AM43XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer3_hwmod, AM43XX_CM_PER_TIMER3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer4_hwmod, AM43XX_CM_PER_TIMER4_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer5_hwmod, AM43XX_CM_PER_TIMER5_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer6_hwmod, AM43XX_CM_PER_TIMER6_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer7_hwmod, AM43XX_CM_PER_TIMER7_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_smartreflex0_hwmod,
+		AM43XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_smartreflex1_hwmod,
+		AM43XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart1_hwmod, AM43XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer1_hwmod, AM43XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_i2c1_hwmod, AM43XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_wd_timer1_hwmod, AM43XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_rtc_hwmod, AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc2_hwmod, AM43XX_CM_PER_MMC2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpmc_hwmod, AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l4_ls_hwmod, AM43XX_CM_PER_L4LS_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l4_wkup_hwmod, AM43XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l3_main_hwmod, AM43XX_CM_PER_L3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tpcc_hwmod, AM43XX_CM_PER_TPCC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc0_hwmod, AM43XX_CM_PER_TPTC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc1_hwmod, AM43XX_CM_PER_TPTC1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc2_hwmod, AM43XX_CM_PER_TPTC2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gfx_hwmod, AM43XX_CM_GFX_GFX_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_cpgmac0_hwmod, AM43XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_pruss_hwmod, AM43XX_CM_PER_PRUSS_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mpu_hwmod , AM43XX_CM_MPU_MPU_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l3_instr_hwmod , AM43XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_ocmcram_hwmod , AM43XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_sha0_hwmod , AM43XX_CM_PER_SHA0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_aes0_hwmod , AM43XX_CM_PER_AES0_CLKCTRL_OFFSET);
+}
+
+static void omap_hwmod_am43xx_rst(void)
+{
+	RSTCTRL(am33xx_pruss_hwmod, AM43XX_RM_PER_RSTCTRL_OFFSET);
+	RSTCTRL(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTCTRL_OFFSET);
+	RSTST(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTST_OFFSET);
+}
+
+void omap_hwmod_am43xx_reg(void)
+{
+	omap_hwmod_am43xx_clkctrl();
+	omap_hwmod_am43xx_rst();
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
new file mode 100644
index 0000000..176a6df
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -0,0 +1,622 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated
+ *
+ * Hwmod present only in AM43x and those that differ other than register
+ * offsets as compared to AM335x.
+ *
+ * This file is automatically generated from the AM33XX hardware databases.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+#include "omap_hwmod.h"
+#include "omap_hwmod_33xx_43xx_common_data.h"
+#include "prcm43xx.h"
+
+/* IP blocks */
+static struct omap_hwmod am43xx_l4_hs_hwmod = {
+	.name		= "l4_hs",
+	.class		= &am33xx_l4_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.main_clk	= "l4hs_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_L4HS_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
+	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
+};
+
+static struct omap_hwmod am43xx_wkup_m3_hwmod = {
+	.name		= "wkup_m3",
+	.class		= &am33xx_wkup_m3_hwmod_class,
+	.clkdm_name	= "l4_wkup_aon_clkdm",
+	/* Keep hardreset asserted */
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
+	.main_clk	= "sys_clkin_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
+			.rstctrl_offs	= AM43XX_RM_WKUP_RSTCTRL_OFFSET,
+			.rstst_offs	= AM43XX_RM_WKUP_RSTST_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+	.rst_lines	= am33xx_wkup_m3_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
+};
+
+static struct omap_hwmod am43xx_control_hwmod = {
+	.name		= "control",
+	.class		= &am33xx_control_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.main_clk	= "sys_clkin_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_opt_clk gpio0_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio0_dbclk" },
+};
+
+static struct omap_hwmod am43xx_gpio0_hwmod = {
+	.name		= "gpio1",
+	.class		= &am33xx_gpio_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.main_clk	= "sys_clkin_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= gpio0_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x4,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_synctimer_hwmod_class = {
+	.name	= "synctimer",
+	.sysc	= &am43xx_synctimer_sysc,
+};
+
+static struct omap_hwmod am43xx_synctimer_hwmod = {
+	.name		= "counter_32k",
+	.class		= &am43xx_synctimer_hwmod_class,
+	.clkdm_name	= "l4_wkup_aon_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.main_clk	= "synctimer_32kclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_timer8_hwmod = {
+	.name		= "timer8",
+	.class		= &am33xx_timer_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "timer8_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_TIMER8_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_timer9_hwmod = {
+	.name		= "timer9",
+	.class		= &am33xx_timer_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "timer9_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_TIMER9_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_timer10_hwmod = {
+	.name		= "timer10",
+	.class		= &am33xx_timer_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "timer10_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_TIMER10_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_timer11_hwmod = {
+	.name		= "timer11",
+	.class		= &am33xx_timer_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "timer11_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_TIMER11_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_epwmss3_hwmod = {
+	.name		= "epwmss3",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_EPWMSS3_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_ehrpwm3_hwmod = {
+	.name		= "ehrpwm3",
+	.class		= &am33xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+};
+
+static struct omap_hwmod am43xx_epwmss4_hwmod = {
+	.name		= "epwmss4",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_EPWMSS4_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_ehrpwm4_hwmod = {
+	.name		= "ehrpwm4",
+	.class		= &am33xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+};
+
+static struct omap_hwmod am43xx_epwmss5_hwmod = {
+	.name		= "epwmss5",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_EPWMSS5_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_ehrpwm5_hwmod = {
+	.name		= "ehrpwm5",
+	.class		= &am33xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+};
+
+static struct omap_hwmod am43xx_spi2_hwmod = {
+	.name		= "spi2",
+	.class		= &am33xx_spi_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "dpll_per_m2_div4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_SPI2_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mcspi_attrib,
+};
+
+static struct omap_hwmod am43xx_spi3_hwmod = {
+	.name		= "spi3",
+	.class		= &am33xx_spi_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "dpll_per_m2_div4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_SPI3_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mcspi_attrib,
+};
+
+static struct omap_hwmod am43xx_spi4_hwmod = {
+	.name		= "spi4",
+	.class		= &am33xx_spi_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "dpll_per_m2_div4_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_SPI4_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mcspi_attrib,
+};
+
+static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio4_dbclk" },
+};
+
+static struct omap_hwmod am43xx_gpio4_hwmod = {
+	.name		= "gpio5",
+	.class		= &am33xx_gpio_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_GPIO4_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= gpio4_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+};
+
+static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio5_dbclk" },
+};
+
+static struct omap_hwmod am43xx_gpio5_hwmod = {
+	.name		= "gpio6",
+	.class		= &am33xx_gpio_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= gpio5_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+};
+
+/* Interfaces */
+static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am43xx_l4_hs_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_wkup_m3__l4_wkup = {
+	.master		= &am43xx_wkup_m3_hwmod,
+	.slave		= &am33xx_l4_wkup_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__wkup_m3 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am43xx_wkup_m3_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l3_main__pruss = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_pruss_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__smartreflex0 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_smartreflex0_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__smartreflex1 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_smartreflex1_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__control = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am43xx_control_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__i2c1 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_i2c1_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__gpio0 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am43xx_gpio0_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_hs__cpgmac0 = {
+	.master		= &am43xx_l4_hs_hwmod,
+	.slave		= &am33xx_cpgmac0_hwmod,
+	.clk		= "cpsw_125mhz_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__timer1 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_timer1_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__uart1 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_uart1_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_wkup__wd_timer1 = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_wd_timer1_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_wkup__synctimer = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am43xx_synctimer_hwmod,
+	.clk		= "sys_clkin_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__timer8 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_timer8_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__timer9 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_timer9_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__timer10 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_timer10_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__timer11 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_timer11_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_epwmss3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_epwmss3__ehrpwm3 = {
+	.master		= &am43xx_epwmss3_hwmod,
+	.slave		= &am43xx_ehrpwm3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss4 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_epwmss4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_epwmss4__ehrpwm4 = {
+	.master		= &am43xx_epwmss4_hwmod,
+	.slave		= &am43xx_ehrpwm4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss5 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_epwmss5_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_epwmss5__ehrpwm5 = {
+	.master		= &am43xx_epwmss5_hwmod,
+	.slave		= &am43xx_ehrpwm5_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_spi2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_spi3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi4 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_spi4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio4 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_gpio4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio5 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_gpio5_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
+	&am33xx_l4_wkup__synctimer,
+	&am43xx_l4_ls__timer8,
+	&am43xx_l4_ls__timer9,
+	&am43xx_l4_ls__timer10,
+	&am43xx_l4_ls__timer11,
+	&am43xx_l4_ls__epwmss3,
+	&am43xx_epwmss3__ehrpwm3,
+	&am43xx_l4_ls__epwmss4,
+	&am43xx_epwmss4__ehrpwm4,
+	&am43xx_l4_ls__epwmss5,
+	&am43xx_epwmss5__ehrpwm5,
+	&am43xx_l4_ls__mcspi2,
+	&am43xx_l4_ls__mcspi3,
+	&am43xx_l4_ls__mcspi4,
+	&am43xx_l4_ls__gpio4,
+	&am43xx_l4_ls__gpio5,
+	&am43xx_l3_main__pruss,
+	&am33xx_mpu__l3_main,
+	&am33xx_mpu__prcm,
+	&am33xx_l3_s__l4_ls,
+	&am33xx_l3_s__l4_wkup,
+	&am43xx_l3_main__l4_hs,
+	&am33xx_l3_main__l3_s,
+	&am33xx_l3_main__l3_instr,
+	&am33xx_l3_main__gfx,
+	&am33xx_l3_s__l3_main,
+	&am33xx_pruss__l3_main,
+	&am43xx_wkup_m3__l4_wkup,
+	&am33xx_gfx__l3_main,
+	&am43xx_l4_wkup__wkup_m3,
+	&am43xx_l4_wkup__control,
+	&am43xx_l4_wkup__smartreflex0,
+	&am43xx_l4_wkup__smartreflex1,
+	&am43xx_l4_wkup__uart1,
+	&am43xx_l4_wkup__timer1,
+	&am33xx_l4_wkup__rtc,
+	&am43xx_l4_wkup__i2c1,
+	&am43xx_l4_wkup__gpio0,
+	&am43xx_l4_wkup__wd_timer1,
+	&am33xx_l4_per__dcan0,
+	&am33xx_l4_per__dcan1,
+	&am33xx_l4_per__gpio1,
+	&am33xx_l4_per__gpio2,
+	&am33xx_l4_per__gpio3,
+	&am33xx_l4_per__i2c2,
+	&am33xx_l4_per__i2c3,
+	&am33xx_l4_per__mailbox,
+	&am33xx_l4_ls__mcasp0,
+	&am33xx_l4_ls__mcasp1,
+	&am33xx_l4_ls__mmc0,
+	&am33xx_l4_ls__mmc1,
+	&am33xx_l3_s__mmc2,
+	&am33xx_l4_ls__timer2,
+	&am33xx_l4_ls__timer3,
+	&am33xx_l4_ls__timer4,
+	&am33xx_l4_ls__timer5,
+	&am33xx_l4_ls__timer6,
+	&am33xx_l4_ls__timer7,
+	&am33xx_l3_main__tpcc,
+	&am33xx_l4_ls__uart2,
+	&am33xx_l4_ls__uart3,
+	&am33xx_l4_ls__uart4,
+	&am33xx_l4_ls__uart5,
+	&am33xx_l4_ls__uart6,
+	&am33xx_l4_ls__spinlock,
+	&am33xx_l4_ls__elm,
+	&am33xx_l4_ls__epwmss0,
+	&am33xx_epwmss0__ecap0,
+	&am33xx_epwmss0__eqep0,
+	&am33xx_epwmss0__ehrpwm0,
+	&am33xx_l4_ls__epwmss1,
+	&am33xx_epwmss1__ecap1,
+	&am33xx_epwmss1__eqep1,
+	&am33xx_epwmss1__ehrpwm1,
+	&am33xx_l4_ls__epwmss2,
+	&am33xx_epwmss2__ecap2,
+	&am33xx_epwmss2__eqep2,
+	&am33xx_epwmss2__ehrpwm2,
+	&am33xx_l3_s__gpmc,
+	&am33xx_l4_ls__mcspi0,
+	&am33xx_l4_ls__mcspi1,
+	&am33xx_l3_main__tptc0,
+	&am33xx_l3_main__tptc1,
+	&am33xx_l3_main__tptc2,
+	&am33xx_l3_main__ocmc,
+	&am43xx_l4_hs__cpgmac0,
+	&am33xx_cpgmac0__mdio,
+	&am33xx_l3_main__sha0,
+	&am33xx_l3_main__aes0,
+	NULL,
+};
+
+int __init am43xx_hwmod_init(void)
+{
+	omap_hwmod_am43xx_reg();
+	omap_hwmod_init();
+	return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
+}
-- 
1.8.3.4

