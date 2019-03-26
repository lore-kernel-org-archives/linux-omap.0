From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP2+: Drop gpio platform data for omap5
Date: Tue, 26 Mar 2019 11:30:53 -0700
Message-ID: <20190326183054.7598-4-tony@atomide.com>
References: <20190326183054.7598-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326183054.7598-1-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 269 ---------------------
 1 file changed, 269 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -597,203 +597,6 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	},
 };
 
-/*
- * 'gpio' class
- * general purpose io module
- */
-
-static struct omap_hwmod_class_sysconfig omap54xx_gpio_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0114,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap54xx_gpio_hwmod_class = {
-	.name	= "gpio",
-	.sysc	= &omap54xx_gpio_sysc,
-};
-
-/* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio1_hwmod = {
-	.name		= "gpio1",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_WKUPAON_GPIO1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-};
-
-/* gpio2 */
-static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio2_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio2_hwmod = {
-	.name		= "gpio2",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-};
-
-/* gpio3 */
-static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio3_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio3_hwmod = {
-	.name		= "gpio3",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
-};
-
-/* gpio4 */
-static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio4_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio4_hwmod = {
-	.name		= "gpio4",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-};
-
-/* gpio5 */
-static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio5_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio5_hwmod = {
-	.name		= "gpio5",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio5_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-};
-
-/* gpio6 */
-static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio6_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio6_hwmod = {
-	.name		= "gpio6",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio6_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
-};
-
-/* gpio7 */
-static struct omap_hwmod_opt_clk gpio7_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio7_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio7_hwmod = {
-	.name		= "gpio7",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio7_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio7_opt_clks),
-};
-
-/* gpio8 */
-static struct omap_hwmod_opt_clk gpio8_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio8_dbclk" },
-};
-
-static struct omap_hwmod omap54xx_gpio8_hwmod = {
-	.name		= "gpio8",
-	.class		= &omap54xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_GPIO8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio8_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
-};
-
 /*
  * 'kbd' class
  * keyboard controller
@@ -2057,70 +1860,6 @@ static struct omap_hwmod_ocp_if omap54xx_mpu__emif2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_wkup -> gpio1 */
-static struct omap_hwmod_ocp_if omap54xx_l4_wkup__gpio1 = {
-	.master		= &omap54xx_l4_wkup_hwmod,
-	.slave		= &omap54xx_gpio1_hwmod,
-	.clk		= "wkupaon_iclk_mux",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio2 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio2 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio3 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio3 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio3_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio4 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio4 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio4_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio5 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio5 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio5_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio6 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio6 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio6_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio7 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio7 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio7_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> gpio8 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio8 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_gpio8_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> kbd */
 static struct omap_hwmod_ocp_if omap54xx_l4_wkup__kbd = {
 	.master		= &omap54xx_l4_wkup_hwmod,
@@ -2422,14 +2161,6 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l3_main_2__dss_rfbi,
 	&omap54xx_mpu__emif1,
 	&omap54xx_mpu__emif2,
-	&omap54xx_l4_wkup__gpio1,
-	&omap54xx_l4_per__gpio2,
-	&omap54xx_l4_per__gpio3,
-	&omap54xx_l4_per__gpio4,
-	&omap54xx_l4_per__gpio5,
-	&omap54xx_l4_per__gpio6,
-	&omap54xx_l4_per__gpio7,
-	&omap54xx_l4_per__gpio8,
 	&omap54xx_l3_main_2__mmu_ipu,
 	&omap54xx_l4_wkup__kbd,
 	&omap54xx_l4_cfg__mailbox,
-- 
2.21.0
