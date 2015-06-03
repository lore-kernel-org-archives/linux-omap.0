From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] ARM: OMAP2: Add minimal dm814x hwmod support
Date: Wed,  3 Jun 2015 09:23:16 -0700
Message-ID: <1433348601-8966-8-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13387 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757780AbbFCQXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:54 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Walmsley <paul@pwsan.com>

Let's add minimal set of dm814x hwmods to have a bootable system.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c                   |   4 +-
 arch/arm/mach-omap2/omap_hwmod.c           |   3 +-
 arch/arm/mach-omap2/omap_hwmod.h           |   3 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 163 ++++++++++++++++++++++++++++-
 4 files changed, 168 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 596af73..056a0e6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -555,7 +555,7 @@ void __init ti814x_init_early(void)
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	ti814x_clockdomains_init();
-	ti81xx_hwmod_init();
+	dm814x_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = dm814x_dt_clk_init;
@@ -572,7 +572,7 @@ void __init ti816x_init_early(void)
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	ti816x_clockdomains_init();
-	ti81xx_hwmod_init();
+	dm816x_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = dm816x_dt_clk_init;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 752969f..0f59688 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3876,7 +3876,8 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
-	} else if (cpu_is_ti816x() || soc_is_am33xx() || soc_is_am43xx()) {
+	} else if (cpu_is_ti814x() || cpu_is_ti816x() || soc_is_am33xx() ||
+		   soc_is_am43xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9611c91..cf4a919 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -749,7 +749,8 @@ extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
 extern int omap54xx_hwmod_init(void);
 extern int am33xx_hwmod_init(void);
-extern int ti81xx_hwmod_init(void);
+extern int dm814x_hwmod_init(void);
+extern int dm816x_hwmod_init(void);
 extern int dra7xx_hwmod_init(void);
 int am43xx_hwmod_init(void);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 67a3d50..7771f3e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -172,6 +172,33 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__l4_hs = {
 };
 
 /* MPU */
+static struct omap_hwmod dm814x_mpu_hwmod = {
+	.name		= "mpu",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &mpu_hwmod_class,
+	.flags		= HWMOD_INIT_NO_IDLE,
+	.main_clk	= "mpu_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM814X_CM_ALWON_MPU_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if dm814x_mpu__alwon_l3_slow = {
+	.master		= &dm814x_mpu_hwmod,
+	.slave		= &dm81xx_alwon_l3_slow_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+/* L3 med peripheral interface running at 200MHz */
+static struct omap_hwmod_ocp_if dm814x_mpu__alwon_l3_med = {
+	.master	= &dm814x_mpu_hwmod,
+	.slave	= &dm81xx_alwon_l3_med_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
 static struct omap_hwmod dm816x_mpu_hwmod = {
 	.name		= "mpu",
 	.clkdm_name	= "alwon_mpu_clkdm",
@@ -565,6 +592,22 @@ static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
 	.timer_capability	= OMAP_TIMER_ALWON,
 };
 
+static struct omap_hwmod dm814x_timer1_hwmod = {
+	.name		= "timer1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer_sys_ck",
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod_ocp_if dm814x_l4_ls__timer1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm814x_timer1_hwmod,
+	.clk		= "timer_sys_ck",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod dm816x_timer1_hwmod = {
 	.name		= "timer1",
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -586,6 +629,22 @@ static struct omap_hwmod_ocp_if dm816x_l4_ls__timer1 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod dm814x_timer2_hwmod = {
+	.name		= "timer2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.main_clk	= "timer_sys_ck",
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &dm816x_timer_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod_ocp_if dm814x_l4_ls__timer2 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm814x_timer2_hwmod,
+	.clk		= "timer_sys_ck",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod dm816x_timer2_hwmod = {
 	.name		= "timer2",
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -712,6 +771,62 @@ static struct omap_hwmod_ocp_if dm816x_l4_ls__timer7 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* CPSW on dm814x */
+static struct omap_hwmod_class_sysconfig dm814x_cpgmac_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x8,
+	.syss_offs	= 0x4,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			  SYSS_HAS_RESET_STATUS,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
+			  MSTANDBY_NO,
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dm814x_cpgmac0_hwmod_class = {
+	.name		= "cpgmac0",
+	.sysc		= &dm814x_cpgmac_sysc,
+};
+
+struct omap_hwmod dm814x_cpgmac0_hwmod = {
+	.name		= "cpgmac0",
+	.class		= &dm814x_cpgmac0_hwmod_class,
+	.clkdm_name	= "alwon_ethernet_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.main_clk	= "cpsw_125mhz_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = DM81XX_CM_ALWON_ETHERNET_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class dm814x_mdio_hwmod_class = {
+	.name		= "davinci_mdio",
+};
+
+struct omap_hwmod dm814x_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &dm814x_mdio_hwmod_class,
+	.clkdm_name	= "alwon_ethernet_clkdm",
+	.main_clk	= "cpsw_125mhz_gclk",
+};
+
+static struct omap_hwmod_ocp_if dm814x_l4_hs__cpgmac0 = {
+	.master		= &dm81xx_l4_hs_hwmod,
+	.slave		= &dm814x_cpgmac0_hwmod,
+	.clk		= "cpsw_125mhz_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dm814x_cpgmac0__mdio = {
+	.master		= &dm814x_cpgmac0_hwmod,
+	.slave		= &dm814x_mdio_hwmod,
+	.user		= OCP_USER_MPU,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* EMAC Ethernet */
 static struct omap_hwmod_class_sysconfig dm816x_emac_sysc = {
 	.rev_offs	= 0x0,
@@ -1108,6 +1223,52 @@ struct omap_hwmod_ocp_if dm81xx_tptc3__alwon_l3_fast = {
 	.user		= OCP_USER_MPU,
 };
 
+/*
+ * REVISIT: Test and enable the following once clocks work:
+ * dm81xx_l4_ls__gpio1
+ * dm81xx_l4_ls__gpio2
+ * dm81xx_l4_ls__mailbox
+ * dm81xx_alwon_l3_slow__gpmc
+ * dm81xx_default_l3_slow__usbss
+ *
+ * Also note that some devices share a single clkctrl_offs..
+ * For example, i2c1 and 3 share one, and i2c2 and 4 share one.
+ */
+static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
+	&dm814x_mpu__alwon_l3_slow,
+	&dm814x_mpu__alwon_l3_med,
+	&dm81xx_alwon_l3_slow__l4_ls,
+	&dm81xx_alwon_l3_slow__l4_hs,
+	&dm81xx_l4_ls__uart1,
+	&dm81xx_l4_ls__uart2,
+	&dm81xx_l4_ls__uart3,
+	&dm81xx_l4_ls__wd_timer1,
+	&dm81xx_l4_ls__i2c1,
+	&dm81xx_l4_ls__i2c2,
+	&dm81xx_l4_ls__elm,
+	&dm81xx_l4_ls__mcspi1,
+	&dm81xx_alwon_l3_fast__tpcc,
+	&dm81xx_alwon_l3_fast__tptc0,
+	&dm81xx_alwon_l3_fast__tptc1,
+	&dm81xx_alwon_l3_fast__tptc2,
+	&dm81xx_alwon_l3_fast__tptc3,
+	&dm81xx_tptc0__alwon_l3_fast,
+	&dm81xx_tptc1__alwon_l3_fast,
+	&dm81xx_tptc2__alwon_l3_fast,
+	&dm81xx_tptc3__alwon_l3_fast,
+	&dm814x_l4_ls__timer1,
+	&dm814x_l4_ls__timer2,
+	&dm814x_l4_hs__cpgmac0,
+	&dm814x_cpgmac0__mdio,
+	NULL,
+};
+
+int __init dm814x_hwmod_init(void)
+{
+	omap_hwmod_init();
+	return omap_hwmod_register_links(dm814x_hwmod_ocp_ifs);
+}
+
 static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_mpu__alwon_l3_slow,
 	&dm816x_mpu__alwon_l3_med,
@@ -1149,7 +1310,7 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
-int __init ti81xx_hwmod_init(void)
+int __init dm816x_hwmod_init(void)
 {
 	omap_hwmod_init();
 	return omap_hwmod_register_links(dm816x_hwmod_ocp_ifs);
-- 
2.1.4

