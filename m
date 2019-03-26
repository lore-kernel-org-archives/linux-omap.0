From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for omap5
Date: Tue, 26 Mar 2019 11:30:51 -0700
Message-ID: <20190326183054.7598-2-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 155 ---------------------
 1 file changed, 155 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/i2c-omap.h>
 
@@ -1182,115 +1181,6 @@ static struct omap_hwmod omap54xx_mcspi4_hwmod = {
 	},
 };
 
-/*
- * 'mmc' class
- * multimedia card high-speed/sd/sdio (mmc/sd/sdio) host controller
- */
-
-static struct omap_hwmod_class_sysconfig omap54xx_mmc_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class omap54xx_mmc_hwmod_class = {
-	.name	= "mmc",
-	.sysc	= &omap54xx_mmc_sysc,
-};
-
-/* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "32khz_clk", .clk = "mmc1_32khz_clk" },
-};
-
-/* mmc1 dev_attr */
-static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
-	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-
-static struct omap_hwmod omap54xx_mmc1_hwmod = {
-	.name		= "mmc1",
-	.class		= &omap54xx_mmc_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
-	.dev_attr	= &mmc1_dev_attr,
-};
-
-/* mmc2 */
-static struct omap_hwmod omap54xx_mmc2_hwmod = {
-	.name		= "mmc2",
-	.class		= &omap54xx_mmc_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc3 */
-static struct omap_hwmod omap54xx_mmc3_hwmod = {
-	.name		= "mmc3",
-	.class		= &omap54xx_mmc_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_MMC3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc4 */
-static struct omap_hwmod omap54xx_mmc4_hwmod = {
-	.name		= "mmc4",
-	.class		= &omap54xx_mmc_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_MMC4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc5 */
-static struct omap_hwmod omap54xx_mmc5_hwmod = {
-	.name		= "mmc5",
-	.class		= &omap54xx_mmc_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC5_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_MMC5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'mmu' class
  * The memory management unit performs virtual to physical address translation
@@ -2456,46 +2346,6 @@ static struct omap_hwmod_ocp_if omap54xx_l4_per__mcspi4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per -> mmc1 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__mmc1 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_mmc1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc2 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__mmc2 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_mmc2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc3 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__mmc3 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_mmc3_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc4 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__mmc4 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_mmc4_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc5 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__mmc5 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_mmc5_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> mpu */
 static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mpu = {
 	.master		= &omap54xx_l4_cfg_hwmod,
@@ -2741,11 +2591,6 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__mcspi2,
 	&omap54xx_l4_per__mcspi3,
 	&omap54xx_l4_per__mcspi4,
-	&omap54xx_l4_per__mmc1,
-	&omap54xx_l4_per__mmc2,
-	&omap54xx_l4_per__mmc3,
-	&omap54xx_l4_per__mmc4,
-	&omap54xx_l4_per__mmc5,
 	&omap54xx_l4_cfg__mpu,
 	&omap54xx_l4_cfg__spinlock,
 	&omap54xx_l4_cfg__ocp2scp1,
-- 
2.21.0
