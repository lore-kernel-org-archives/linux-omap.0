From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for omap4
Date: Tue, 26 Mar 2019 11:09:55 -0700
Message-ID: <20190326180958.31677-2-tony@atomide.com>
References: <20190326180958.31677-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326180958.31677-1-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 160 ---------------------
 1 file changed, 160 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -21,7 +21,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/i2c-omap.h>
 
@@ -1902,102 +1901,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
  * multimedia card high-speed/sd/sdio (mmc/sd/sdio) host controller
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc = {
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
-static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
-	.name	= "mmc",
-	.sysc	= &omap44xx_mmc_sysc,
-};
-
-/* mmc1 */
-static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
-	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-
-static struct omap_hwmod omap44xx_mmc1_hwmod = {
-	.name		= "mmc1",
-	.class		= &omap44xx_mmc_hwmod_class,
-	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "hsmmc1_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &mmc1_dev_attr,
-};
-
-/* mmc2 */
-static struct omap_hwmod omap44xx_mmc2_hwmod = {
-	.name		= "mmc2",
-	.class		= &omap44xx_mmc_hwmod_class,
-	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "hsmmc2_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc3 */
-static struct omap_hwmod omap44xx_mmc3_hwmod = {
-	.name		= "mmc3",
-	.class		= &omap44xx_mmc_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_MMCSD3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc4 */
-static struct omap_hwmod omap44xx_mmc4_hwmod = {
-	.name		= "mmc4",
-	.class		= &omap44xx_mmc_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_MMCSD4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* mmc5 */
-static struct omap_hwmod omap44xx_mmc5_hwmod = {
-	.name		= "mmc5",
-	.class		= &omap44xx_mmc_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_MMCSD5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
 
 /*
  * 'mmu' class
@@ -3079,22 +2982,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* mmc1 -> l3_main_1 */
-static struct omap_hwmod_ocp_if omap44xx_mmc1__l3_main_1 = {
-	.master		= &omap44xx_mmc1_hwmod,
-	.slave		= &omap44xx_l3_main_1_hwmod,
-	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* mmc2 -> l3_main_1 */
-static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_main_1 = {
-	.master		= &omap44xx_mmc2_hwmod,
-	.slave		= &omap44xx_l3_main_1_hwmod,
-	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.master		= &omap44xx_mpu_hwmod,
@@ -3799,46 +3686,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per -> mmc1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc1 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_mmc1_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc2 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_mmc2_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc3 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_mmc3_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc4 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc4 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_mmc4_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> mmc5 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_mmc5_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_2 -> ocmc_ram */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ocmc_ram = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -4161,8 +4008,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_dss__l3_main_1,
 	&omap44xx_l3_main_2__l3_main_1,
 	&omap44xx_l4_cfg__l3_main_1,
-	&omap44xx_mmc1__l3_main_1,
-	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_debugss__l3_main_2,
 	&omap44xx_dma_system__l3_main_2,
@@ -4250,11 +4095,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mcspi2,
 	&omap44xx_l4_per__mcspi3,
 	&omap44xx_l4_per__mcspi4,
-	&omap44xx_l4_per__mmc1,
-	&omap44xx_l4_per__mmc2,
-	&omap44xx_l4_per__mmc3,
-	&omap44xx_l4_per__mmc4,
-	&omap44xx_l4_per__mmc5,
 	&omap44xx_l3_main_2__mmu_ipu,
 	&omap44xx_l4_cfg__mmu_dsp,
 	&omap44xx_l3_main_2__ocmc_ram,
-- 
2.21.0
