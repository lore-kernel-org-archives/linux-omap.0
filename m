From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 13/13] ARM: OMAP2+: hwmod: AM43x: new w.r.t AM335x
Date: Thu, 11 Jul 2013 12:07:09 +0530
Message-ID: <0bb1eb7339ac9fd78c8251f71082ac3b3add3ad2.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab3GKGhg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 02:37:36 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>

AM43x has a few IP's that are not present in AM335x,
1. qspi
2. hdq1w
3. vpfe (two instances)
4. pka
5. des
6. rng
7. synctimer

In addition it has a few new instances of existing IP's,
1. timer8-11
2. ehrpwm3-5
3. spi2-4

Also a different pruss interconnect.

Update hwmod with the above details and register 'ocpif' if platform
being run is AM43x.

TODO:
1. usb
2. dss

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 525 ++++++++++++++++++++++++++++-
 1 file changed, 523 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 7897fec..319780e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -30,6 +30,7 @@
 #include "i2c.h"
 #include "mmc.h"
 #include "wd_timer.h"
+#include "hdq1w.h"
 #include "soc.h"
 
 /*
@@ -1595,6 +1596,346 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
 	},
 };
 
+static struct omap_hwmod_class_sysconfig am43xx_qspi_sysc = {
+	.sysc_offs	= 0x10,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_qspi_hwmod_class = {
+	.name		= "qspi",
+	.sysc		= &am43xx_qspi_sysc,
+};
+
+static struct omap_hwmod am43xx_qspi_hwmod = {
+	.name		= "qspi",
+	.class		= &am43xx_qspi_hwmod_class,
+	.clkdm_name	= "l3s_clkdm",
+	.main_clk	= "dpll_per_m2_div4_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_hdq1w_sysc = {
+	.sysc_offs	= 0x14,
+	.syss_offs	= 0x18,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_hdq1w_hwmod_class = {
+	.name	= "hdq1w",
+	.sysc	= &am43xx_hdq1w_sysc,
+	.reset	= &omap_hdq1w_reset,
+};
+
+static struct omap_hwmod am43xx_hdq1w_hwmod = {
+	.name		= "hdq1w",
+	.class		= &am43xx_hdq1w_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "func_12m_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_vpfe_sysc = {
+	.sysc_offs	= 0x104,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_vpfe_hwmod_class = {
+	.name	= "vpfe",
+	.sysc	= &am43xx_vpfe_sysc,
+};
+
+static struct omap_hwmod am43xx_vpfe0_hwmod = {
+	.name		= "vpfe0",
+	.class		= &am43xx_vpfe_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.main_clk	= "sysclk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_vpfe1_hwmod = {
+	.name		= "vpfe1",
+	.class		= &am43xx_vpfe_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.main_clk	= "sysclk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_pka_sysc = {
+	.rev_offs	= 0x1fe0,
+	.sysc_offs	= 0x1ff0,
+	.syss_offs	= 0x1ff4,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type4,
+};
+
+static struct omap_hwmod_class am43xx_pka_hwmod_class = {
+	.name		= "pka",
+	.sysc		= &am43xx_pka_sysc,
+};
+
+static struct omap_hwmod am43xx_pka_hwmod = {
+	.name		= "pka",
+	.class		= &am43xx_pka_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_PKA_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_des_sysc = {
+	.rev_offs	= 0x30,
+	.sysc_offs	= 0x34,
+	.syss_offs	= 0x38,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class am43xx_des_hwmod_class = {
+	.name		= "des",
+	.sysc		= &am43xx_des_sysc,
+};
+
+static struct omap_hwmod am43xx_des_hwmod = {
+	.name		= "des",
+	.class		= &am43xx_des_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.main_clk	= "l3_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_DES_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class am43xx_rng_hwmod_class = {
+	.name		= "rng",
+};
+
+static struct omap_hwmod am43xx_rng_hwmod = {
+	.name		= "rng",
+	.class		= &am43xx_rng_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_RNG_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
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
+	.main_clk	= "synctimer_32kclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
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
 
 /*
  * Interfaces
@@ -2379,6 +2720,160 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am43xx_qspi_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__hdq1w = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_hdq1w_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__vpfe0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_vpfe0_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__vpfe1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_vpfe1_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__pka = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_pka_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__rng = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_rng_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l3_main__des = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am43xx_des_hwmod,
+	.clk		= "l3_gclk",
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
+static struct omap_hwmod_ocp_if am33xx_l4_wkup__synctimer = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am43xx_synctimer_hwmod,
+	.clk		= "sys_clkin_ck",
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
+static struct omap_hwmod_ocp_if am43xx_l3_main__pruss = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_pruss_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.user		= OCP_USER_MPU,
+};
+
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
 
 static void am43xx_hwmod_clkctrl(void)
@@ -2591,6 +3086,32 @@ static void am33xx_hwmod_ocpif_clk(void)
 	am33xx_gpio0_hwmod.main_clk = AM33XX_L4_WKUP_OCPIF_CLK;
 }
 
+static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
+	&am43xx_l3_s__qspi,
+	&am43xx_l4_ls__hdq1w,
+	&am43xx_l4_ls__vpfe0,
+	&am43xx_l4_ls__vpfe1,
+	&am43xx_l4_ls__pka,
+	&am43xx_l4_ls__rng,
+	&am43xx_l3_main__des,
+	&am43xx_l4_ls__timer8,
+	&am43xx_l4_ls__timer9,
+	&am43xx_l4_ls__timer10,
+	&am43xx_l4_ls__timer11,
+	&am33xx_l4_wkup__synctimer,
+	&am43xx_l4_ls__epwmss3,
+	&am43xx_epwmss3__ehrpwm3,
+	&am43xx_l4_ls__epwmss4,
+	&am43xx_epwmss4__ehrpwm4,
+	&am43xx_l4_ls__epwmss5,
+	&am43xx_epwmss5__ehrpwm5,
+	&am43xx_l4_ls__mcspi2,
+	&am43xx_l4_ls__mcspi3,
+	&am43xx_l4_ls__mcspi4,
+	&am43xx_l3_main__pruss,
+	NULL,
+};
+
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__emif,
 	&am33xx_l4_hs__pruss,
@@ -2702,6 +3223,6 @@ int __init am33xx_hwmod_init(void)
 
 	if (soc_is_am33xx())
 		return omap_hwmod_register_links(am33xx_hwmod_ocp_ifs);
-
-	return 0;
+	else
+		return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
 }
-- 
1.8.3.1

