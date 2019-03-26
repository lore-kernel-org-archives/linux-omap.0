From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP2+: Drop gpio platform data for am33xx and am43xx
Date: Tue, 26 Mar 2019 11:13:23 -0700
Message-ID: <20190326181324.32140-4-tony@atomide.com>
References: <20190326181324.32140-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326181324.32140-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can now drop legacy platform data one interconnect target module at
a time in favor of the device tree based data that has been added earlier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../omap_hwmod_33xx_43xx_common_data.h        |  7 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  | 24 -----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    | 33 -------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    | 87 -------------------
 4 files changed, 151 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -30,9 +30,6 @@ extern struct omap_hwmod_ocp_if am33xx_l3_main__gfx;
 extern struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc;
 extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan0;
 extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan1;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio1;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio2;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio3;
 extern struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__elm;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0;
@@ -88,9 +85,6 @@ extern struct omap_hwmod am33xx_elm_hwmod;
 extern struct omap_hwmod am33xx_epwmss0_hwmod;
 extern struct omap_hwmod am33xx_epwmss1_hwmod;
 extern struct omap_hwmod am33xx_epwmss2_hwmod;
-extern struct omap_hwmod am33xx_gpio1_hwmod;
-extern struct omap_hwmod am33xx_gpio2_hwmod;
-extern struct omap_hwmod am33xx_gpio3_hwmod;
 extern struct omap_hwmod am33xx_gpmc_hwmod;
 extern struct omap_hwmod am33xx_mailbox_hwmod;
 extern struct omap_hwmod am33xx_mcasp0_hwmod;
@@ -122,7 +116,6 @@ extern struct omap_hwmod_class am33xx_emif_hwmod_class;
 extern struct omap_hwmod_class am33xx_l4_hwmod_class;
 extern struct omap_hwmod_class am33xx_wkup_m3_hwmod_class;
 extern struct omap_hwmod_class am33xx_control_hwmod_class;
-extern struct omap_hwmod_class am33xx_gpio_hwmod_class;
 extern struct omap_hwmod_class am33xx_timer_hwmod_class;
 extern struct omap_hwmod_class am33xx_epwmss_hwmod_class;
 extern struct omap_hwmod_class am33xx_ehrpwm_hwmod_class;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -122,30 +122,6 @@ struct omap_hwmod_ocp_if am33xx_l4_per__dcan1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4 per/ls -> GPIO2 */
-struct omap_hwmod_ocp_if am33xx_l4_per__gpio1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> gpio3 */
-struct omap_hwmod_ocp_if am33xx_l4_per__gpio2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> gpio4 */
-struct omap_hwmod_ocp_if am33xx_l4_per__gpio3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
 	.master		= &am33xx_cpgmac0_hwmod,
 	.slave		= &am33xx_mdio_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -227,27 +227,6 @@ static struct omap_hwmod am33xx_control_hwmod = {
 	},
 };
 
-/* gpio0 */
-static struct omap_hwmod_opt_clk gpio0_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio0_dbclk" },
-};
-
-static struct omap_hwmod am33xx_gpio0_hwmod = {
-	.name		= "gpio1",
-	.class		= &am33xx_gpio_hwmod_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "dpll_core_m4_div2_ck",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= gpio0_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
-};
-
 /* lcdc */
 static struct omap_hwmod_class_sysconfig lcdc_sysc = {
 	.rev_offs	= 0x0,
@@ -385,14 +364,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__control = {
 	.user		= OCP_USER_MPU,
 };
 
-/* L4 WKUP -> GPIO1 */
-static struct omap_hwmod_ocp_if am33xx_l4_wkup__gpio0 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_gpio0_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* L4 WKUP -> ADC_TSC */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__adc_tsc = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -471,15 +442,11 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__uart1,
 	&am33xx_l4_wkup__timer1,
 	&am33xx_l4_wkup__rtc,
-	&am33xx_l4_wkup__gpio0,
 	&am33xx_l4_wkup__adc_tsc,
 	&am33xx_l4_wkup__wd_timer1,
 	&am33xx_l4_hs__pruss,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
-	&am33xx_l4_per__gpio1,
-	&am33xx_l4_per__gpio2,
-	&am33xx_l4_per__gpio3,
 	&am33xx_l4_per__mailbox,
 	&am33xx_l4_ls__mcasp0,
 	&am33xx_l4_ls__mcasp1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -87,26 +87,6 @@ static struct omap_hwmod am43xx_control_hwmod = {
 	},
 };
 
-static struct omap_hwmod_opt_clk gpio0_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio0_dbclk" },
-};
-
-static struct omap_hwmod am43xx_gpio0_hwmod = {
-	.name		= "gpio1",
-	.class		= &am33xx_gpio_hwmod_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "sys_clkin_ck",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= gpio0_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
-};
-
 static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x4,
@@ -264,46 +244,6 @@ static struct omap_hwmod am43xx_spi4_hwmod = {
 	},
 };
 
-static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio4_dbclk" },
-};
-
-static struct omap_hwmod am43xx_gpio4_hwmod = {
-	.name		= "gpio5",
-	.class		= &am33xx_gpio_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_GPIO4_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= gpio4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-};
-
-static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio5_dbclk" },
-};
-
-static struct omap_hwmod am43xx_gpio5_hwmod = {
-	.name		= "gpio6",
-	.class		= &am33xx_gpio_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= gpio5_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-};
-
 static struct omap_hwmod_class am43xx_ocp2scp_hwmod_class = {
 	.name	= "ocp2scp",
 };
@@ -650,13 +590,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_wkup__control = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_l4_wkup__gpio0 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am43xx_gpio0_hwmod,
-	.clk		= "sys_clkin_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_wkup__adc_tsc = {
 	.master         = &am33xx_l4_wkup_hwmod,
 	.slave          = &am43xx_adc_tsc_hwmod,
@@ -769,20 +702,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi4 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio4 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am43xx_gpio4_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio5 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am43xx_gpio5_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_ls__ocp2scp0 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am43xx_ocp2scp0_hwmod,
@@ -900,8 +819,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__mcspi2,
 	&am43xx_l4_ls__mcspi3,
 	&am43xx_l4_ls__mcspi4,
-	&am43xx_l4_ls__gpio4,
-	&am43xx_l4_ls__gpio5,
 	&am43xx_l3_main__pruss,
 	&am33xx_mpu__l3_main,
 	&am33xx_mpu__prcm,
@@ -922,15 +839,11 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__smartreflex1,
 	&am43xx_l4_wkup__uart1,
 	&am43xx_l4_wkup__timer1,
-	&am43xx_l4_wkup__gpio0,
 	&am43xx_l4_wkup__wd_timer1,
 	&am43xx_l4_wkup__adc_tsc,
 	&am43xx_l3_s__qspi,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
-	&am33xx_l4_per__gpio1,
-	&am33xx_l4_per__gpio2,
-	&am33xx_l4_per__gpio3,
 	&am33xx_l4_per__mailbox,
 	&am33xx_l4_per__rng,
 	&am33xx_l4_ls__mcasp0,
-- 
2.21.0
