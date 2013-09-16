From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC v3 04/12] ARM: OMAP2+: hwmod: AM335x: runtime register update
Date: Mon, 16 Sep 2013 19:17:54 +0530
Message-ID: <c41a08f1c919dfcf9deb456f13b6fb99100cbfe3.1379337301.git.afzal@ti.com>
References: <cover.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37948 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab3IPNsZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 09:48:25 -0400
In-Reply-To: <cover.1379337301.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Most of IP's in AM335x is present on AM43x and so in those cases both
will use same hwmod database (except for a few cases where clock related
details differ), but there is difference w.r.t register offset between
these. Update register offsets at runtime based on the SoC detected to
help in sharing otherwise same hwmod.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h  |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 78 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  1 +
 3 files changed, 81 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
index 0a1983e..254a4e5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
@@ -152,3 +152,5 @@ extern struct omap_hwmod_class am33xx_spi_hwmod_class;
 
 extern struct omap_gpio_dev_attr gpio_dev_attr;
 extern struct omap2_mcspi_dev_attr mcspi_attrib;
+
+extern void omap_hwmod_am33xx_reg(void);
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index f7ae9bd..47e0c0b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -31,6 +31,10 @@
 #include "wd_timer.h"
 #include "omap_hwmod_33xx_43xx_common.h"
 
+#define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
+#define RSTCTRL(oh, rstctrl) ((oh).prcm.omap4.rstctrl_offs = (rstctrl))
+#define RSTST(oh, rstst) ((oh).prcm.omap4.rstst_offs = (rstst))
+
 /*
  * 'l3' class
  * instance(s): l3_main, l3_s, l3_instr
@@ -1370,3 +1374,77 @@ struct omap_hwmod am33xx_wd_timer1_hwmod = {
 		},
 	},
 };
+
+static void omap_hwmod_am33xx_clkctrl(void)
+{
+	CLKCTRL(am33xx_uart2_hwmod, AM33XX_CM_PER_UART1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart3_hwmod, AM33XX_CM_PER_UART2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart4_hwmod, AM33XX_CM_PER_UART3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart5_hwmod, AM33XX_CM_PER_UART4_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_uart6_hwmod, AM33XX_CM_PER_UART5_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_dcan0_hwmod, AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_dcan1_hwmod, AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_elm_hwmod, AM33XX_CM_PER_ELM_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss0_hwmod, AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss1_hwmod, AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_epwmss2_hwmod, AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio1_hwmod, AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio2_hwmod, AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpio3_hwmod, AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_i2c2_hwmod, AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_i2c3_hwmod, AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mailbox_hwmod, AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mcasp0_hwmod, AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mcasp1_hwmod, AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc0_hwmod, AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc1_hwmod, AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spi0_hwmod, AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spi1_hwmod, AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_spinlock_hwmod, AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer2_hwmod, AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer3_hwmod, AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer4_hwmod, AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer5_hwmod, AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer6_hwmod, AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_timer7_hwmod, AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_smartreflex0_hwmod,
+		AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_smartreflex1_hwmod,
+		AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mmc2_hwmod, AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gpmc_hwmod, AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l4_ls_hwmod, AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l4_wkup_hwmod, AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l3_main_hwmod, AM33XX_CM_PER_L3_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tpcc_hwmod, AM33XX_CM_PER_TPCC_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc0_hwmod, AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc1_hwmod, AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_tptc2_hwmod, AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_gfx_hwmod, AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_cpgmac0_hwmod, AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_pruss_hwmod, AM33XX_CM_PER_PRUSS_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_mpu_hwmod , AM33XX_CM_MPU_MPU_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_l3_instr_hwmod , AM33XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_ocmcram_hwmod , AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_sha0_hwmod , AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_aes0_hwmod , AM33XX_CM_PER_AES0_CLKCTRL_OFFSET);
+}
+
+static void omap_hwmod_am33xx_rstctrl(void)
+{
+	RSTCTRL(am33xx_pruss_hwmod, AM33XX_RM_PER_RSTCTRL_OFFSET);
+	RSTCTRL(am33xx_gfx_hwmod, AM33XX_RM_GFX_RSTCTRL_OFFSET);
+}
+
+static void omap_hwmod_am33xx_rstst(void)
+{
+	RSTST(am33xx_gfx_hwmod, AM33XX_RM_GFX_RSTST_OFFSET);
+}
+
+void omap_hwmod_am33xx_reg(void)
+{
+	omap_hwmod_am33xx_clkctrl();
+	omap_hwmod_am33xx_rstctrl();
+	omap_hwmod_am33xx_rstst();
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 6ce1bbe..52bbcf7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -598,6 +598,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 
 int __init am33xx_hwmod_init(void)
 {
+	omap_hwmod_am33xx_reg();
 	omap_hwmod_init();
 	return omap_hwmod_register_links(am33xx_hwmod_ocp_ifs);
 }
-- 
1.8.3.4

