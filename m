From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for dra7
Date: Tue, 26 Mar 2019 11:35:32 -0700
Message-ID: <20190326183535.20798-2-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 149 ----------------------
 1 file changed, 149 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/i2c-omap.h>
 
@@ -1627,118 +1626,6 @@ static struct omap_hwmod dra7xx_mcasp8_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(mcasp8_opt_clks),
 };
 
-/*
- * 'mmc' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_mmc_sysc = {
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
-static struct omap_hwmod_class dra7xx_mmc_hwmod_class = {
-	.name	= "mmc",
-	.sysc	= &dra7xx_mmc_sysc,
-};
-
-/* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc1_clk32k" },
-};
-
-/* mmc1 dev_attr */
-static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
-	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-
-static struct omap_hwmod dra7xx_mmc1_hwmod = {
-	.name		= "mmc1",
-	.class		= &dra7xx_mmc_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
-	.dev_attr	= &mmc1_dev_attr,
-};
-
-/* mmc2 */
-static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc2_clk32k" },
-};
-
-static struct omap_hwmod dra7xx_mmc2_hwmod = {
-	.name		= "mmc2",
-	.class		= &dra7xx_mmc_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= mmc2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
-};
-
-/* mmc3 */
-static struct omap_hwmod_opt_clk mmc3_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc3_clk32k" },
-};
-
-static struct omap_hwmod dra7xx_mmc3_hwmod = {
-	.name		= "mmc3",
-	.class		= &dra7xx_mmc_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc3_gfclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_MMC3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= mmc3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc3_opt_clks),
-};
-
-/* mmc4 */
-static struct omap_hwmod_opt_clk mmc4_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc4_clk32k" },
-};
-
-static struct omap_hwmod dra7xx_mmc4_hwmod = {
-	.name		= "mmc4",
-	.class		= &dra7xx_mmc_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc4_gfclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_MMC4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.opt_clks	= mmc4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc4_opt_clks),
-};
-
 /*
  * 'mpu' class
  *
@@ -3364,38 +3251,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__mcspi4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per1 -> mmc1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__mmc1 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_mmc1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> mmc2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__mmc2 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_mmc2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> mmc3 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__mmc3 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_mmc3_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> mmc4 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__mmc4 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_mmc4_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> mpu */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
 	.master		= &dra7xx_l4_cfg_hwmod,
@@ -3893,10 +3748,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__mcspi2,
 	&dra7xx_l4_per1__mcspi3,
 	&dra7xx_l4_per1__mcspi4,
-	&dra7xx_l4_per1__mmc1,
-	&dra7xx_l4_per1__mmc2,
-	&dra7xx_l4_per1__mmc3,
-	&dra7xx_l4_per1__mmc4,
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
 	&dra7xx_l4_cfg__ocp2scp3,
-- 
2.21.0
