From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP2+: Drop uart platform data for am33xx and am43xx
Date: Tue, 26 Mar 2019 11:13:24 -0700
Message-ID: <20190326181324.32140-5-tony@atomide.com>
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
 .../omap_hwmod_33xx_43xx_common_data.h        |  11 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  |  40 -------
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 108 ------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  14 ---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |  13 ---
 5 files changed, 186 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -52,11 +52,6 @@ extern struct omap_hwmod_ocp_if am33xx_l3_main__tpcc;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc0;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc1;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc2;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart2;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart3;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart4;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart5;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart6;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__ocmc;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__sha0;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__aes0;
@@ -104,12 +99,6 @@ extern struct omap_hwmod am33xx_tpcc_hwmod;
 extern struct omap_hwmod am33xx_tptc0_hwmod;
 extern struct omap_hwmod am33xx_tptc1_hwmod;
 extern struct omap_hwmod am33xx_tptc2_hwmod;
-extern struct omap_hwmod am33xx_uart1_hwmod;
-extern struct omap_hwmod am33xx_uart2_hwmod;
-extern struct omap_hwmod am33xx_uart3_hwmod;
-extern struct omap_hwmod am33xx_uart4_hwmod;
-extern struct omap_hwmod am33xx_uart5_hwmod;
-extern struct omap_hwmod am33xx_uart6_hwmod;
 extern struct omap_hwmod am33xx_wd_timer1_hwmod;
 
 extern struct omap_hwmod_class am33xx_emif_hwmod_class;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -292,46 +292,6 @@ struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 ls -> uart2 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__uart2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart3 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__uart3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart4 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__uart4 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart4_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart5 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__uart5 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart5_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart6 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__uart6 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart6_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l3 main -> ocmc */
 struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
 	.master		= &am33xx_l3_main_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -997,102 +997,6 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 	},
 };
 
-/* 'uart' class */
-static struct omap_hwmod_class_sysconfig uart_sysc = {
-	.rev_offs	= 0x50,
-	.sysc_offs	= 0x54,
-	.syss_offs	= 0x58,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
-			  SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			  SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class uart_class = {
-	.name		= "uart",
-	.sysc		= &uart_sysc,
-};
-
-struct omap_hwmod am33xx_uart1_hwmod = {
-	.name		= "uart1",
-	.class		= &uart_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= DEBUG_AM33XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-struct omap_hwmod am33xx_uart2_hwmod = {
-	.name		= "uart2",
-	.class		= &uart_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart3 */
-struct omap_hwmod am33xx_uart3_hwmod = {
-	.name		= "uart3",
-	.class		= &uart_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-struct omap_hwmod am33xx_uart4_hwmod = {
-	.name		= "uart4",
-	.class		= &uart_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-struct omap_hwmod am33xx_uart5_hwmod = {
-	.name		= "uart5",
-	.class		= &uart_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-struct omap_hwmod am33xx_uart6_hwmod = {
-	.name		= "uart6",
-	.class		= &uart_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /* 'wd_timer' class */
 static struct omap_hwmod_class_sysconfig wdt_sysc = {
 	.rev_offs	= 0x0,
@@ -1130,11 +1034,6 @@ struct omap_hwmod am33xx_wd_timer1_hwmod = {
 
 static void omap_hwmod_am33xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_uart2_hwmod, AM33XX_CM_PER_UART1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart3_hwmod, AM33XX_CM_PER_UART2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart4_hwmod, AM33XX_CM_PER_UART3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart5_hwmod, AM33XX_CM_PER_UART4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart6_hwmod, AM33XX_CM_PER_UART5_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_dcan0_hwmod, AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_dcan1_hwmod, AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_elm_hwmod, AM33XX_CM_PER_ELM_CLKCTRL_OFFSET);
@@ -1160,7 +1059,6 @@ static void omap_hwmod_am33xx_clkctrl(void)
 		AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_smartreflex1_hwmod,
 		AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart1_hwmod, AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer1_hwmod, AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
@@ -1199,11 +1097,6 @@ void omap_hwmod_am33xx_reg(void)
 
 static void omap_hwmod_am43xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_uart2_hwmod, AM43XX_CM_PER_UART1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart3_hwmod, AM43XX_CM_PER_UART2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart4_hwmod, AM43XX_CM_PER_UART3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart5_hwmod, AM43XX_CM_PER_UART4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart6_hwmod, AM43XX_CM_PER_UART5_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_dcan0_hwmod, AM43XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_dcan1_hwmod, AM43XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_elm_hwmod, AM43XX_CM_PER_ELM_CLKCTRL_OFFSET);
@@ -1229,7 +1122,6 @@ static void omap_hwmod_am43xx_clkctrl(void)
 		AM43XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_smartreflex1_hwmod,
 		AM43XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart1_hwmod, AM43XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer1_hwmod, AM43XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM43XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET);
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -394,14 +394,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__timer1 = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 wkup -> uart1 */
-static struct omap_hwmod_ocp_if am33xx_l4_wkup__uart1 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_uart1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 wkup -> wd_timer1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__wd_timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -439,7 +431,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__control,
 	&am33xx_l4_wkup__smartreflex0,
 	&am33xx_l4_wkup__smartreflex1,
-	&am33xx_l4_wkup__uart1,
 	&am33xx_l4_wkup__timer1,
 	&am33xx_l4_wkup__rtc,
 	&am33xx_l4_wkup__adc_tsc,
@@ -457,11 +448,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__timer6,
 	&am33xx_l4_ls__timer7,
 	&am33xx_l3_main__tpcc,
-	&am33xx_l4_ls__uart2,
-	&am33xx_l4_ls__uart3,
-	&am33xx_l4_ls__uart4,
-	&am33xx_l4_ls__uart5,
-	&am33xx_l4_ls__uart6,
 	&am33xx_l4_ls__spinlock,
 	&am33xx_l4_ls__elm,
 	&am33xx_l4_ls__epwmss0,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -611,13 +611,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_wkup__timer1 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_l4_wkup__uart1 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_uart1_hwmod,
-	.clk		= "sys_clkin_ck",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_wkup__wd_timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_wd_timer1_hwmod,
@@ -837,7 +830,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__control,
 	&am43xx_l4_wkup__smartreflex0,
 	&am43xx_l4_wkup__smartreflex1,
-	&am43xx_l4_wkup__uart1,
 	&am43xx_l4_wkup__timer1,
 	&am43xx_l4_wkup__wd_timer1,
 	&am43xx_l4_wkup__adc_tsc,
@@ -855,11 +847,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__timer6,
 	&am33xx_l4_ls__timer7,
 	&am33xx_l3_main__tpcc,
-	&am33xx_l4_ls__uart2,
-	&am33xx_l4_ls__uart3,
-	&am33xx_l4_ls__uart4,
-	&am33xx_l4_ls__uart5,
-	&am33xx_l4_ls__uart6,
 	&am33xx_l4_ls__spinlock,
 	&am33xx_l4_ls__elm,
 	&am33xx_l4_ls__epwmss0,
-- 
2.21.0
