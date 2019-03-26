From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP2+: Drop gpio platform data for dra7
Date: Tue, 26 Mar 2019 11:35:34 -0700
Message-ID: <20190326183535.20798-4-tony@atomide.com>
References: <20190326183535.20798-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326183535.20798-1-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 270 ----------------------
 1 file changed, 270 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -786,204 +786,6 @@ static struct omap_hwmod dra7xx_elm_hwmod = {
 	},
 };
 
-/*
- * 'gpio' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_gpio_sysc = {
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
-static struct omap_hwmod_class dra7xx_gpio_hwmod_class = {
-	.name	= "gpio",
-	.sysc	= &dra7xx_gpio_sysc,
-};
-
-/* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
-static struct omap_hwmod dra7xx_gpio1_hwmod = {
-	.name		= "gpio1",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "wkupaon_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "wkupaon_iclk_mux",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_WKUPAON_GPIO1_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio2_hwmod = {
-	.name		= "gpio2",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO2_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio3_hwmod = {
-	.name		= "gpio3",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO3_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio4_hwmod = {
-	.name		= "gpio4",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO4_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio5_hwmod = {
-	.name		= "gpio5",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO5_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio6_hwmod = {
-	.name		= "gpio6",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO6_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio7_hwmod = {
-	.name		= "gpio7",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO7_CONTEXT_OFFSET,
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
-static struct omap_hwmod dra7xx_gpio8_hwmod = {
-	.name		= "gpio8",
-	.class		= &dra7xx_gpio_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_GPIO8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-	.opt_clks	= gpio8_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
-};
-
 /*
  * 'gpmc' class
  *
@@ -2890,70 +2692,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_wkup -> gpio1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_wkup__gpio1 = {
-	.master		= &dra7xx_l4_wkup_hwmod,
-	.slave		= &dra7xx_gpio1_hwmod,
-	.clk		= "wkupaon_iclk_mux",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio2 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio3 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio3 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio3_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio4 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio4 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio4_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio5 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio5 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio5_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio6 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio6 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio6_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio7 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio7 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio7_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> gpio8 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio8 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_gpio8_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> gpmc */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__gpmc = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -3571,14 +3309,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__aes2,
 	&dra7xx_l3_main_1__sha0,
 	&dra7xx_l4_per1__elm,
-	&dra7xx_l4_wkup__gpio1,
-	&dra7xx_l4_per1__gpio2,
-	&dra7xx_l4_per1__gpio3,
-	&dra7xx_l4_per1__gpio4,
-	&dra7xx_l4_per1__gpio5,
-	&dra7xx_l4_per1__gpio6,
-	&dra7xx_l4_per1__gpio7,
-	&dra7xx_l4_per1__gpio8,
 	&dra7xx_l3_main_1__gpmc,
 	&dra7xx_l4_per1__hdq1w,
 	&dra7xx_l4_cfg__mailbox1,
-- 
2.21.0
