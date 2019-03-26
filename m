From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Drop i2c platform data for omap5
Date: Tue, 26 Mar 2019 11:30:52 -0700
Message-ID: <20190326183054.7598-3-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 150 ---------------------
 1 file changed, 150 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -19,7 +19,6 @@
 
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
-#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
@@ -28,7 +27,6 @@
 #include "cm1_54xx.h"
 #include "cm2_54xx.h"
 #include "prm54xx.h"
-#include "i2c.h"
 #include "wd_timer.h"
 
 /* Base offset for all OMAP5 interrupts external to MPUSS */
@@ -796,109 +794,6 @@ static struct omap_hwmod omap54xx_gpio8_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
 };
 
-/*
- * 'i2c' class
- * multimaster high-speed i2c controller
- */
-
-static struct omap_hwmod_class_sysconfig omap54xx_i2c_sysc = {
-	.rev_offs	= 0,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0090,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap54xx_i2c_hwmod_class = {
-	.name	= "i2c",
-	.sysc	= &omap54xx_i2c_sysc,
-	.reset	= &omap_i2c_reset,
-};
-
-/* i2c1 */
-static struct omap_hwmod omap54xx_i2c1_hwmod = {
-	.name		= "i2c1",
-	.class		= &omap54xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c2 */
-static struct omap_hwmod omap54xx_i2c2_hwmod = {
-	.name		= "i2c2",
-	.class		= &omap54xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c3 */
-static struct omap_hwmod omap54xx_i2c3_hwmod = {
-	.name		= "i2c3",
-	.class		= &omap54xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c4 */
-static struct omap_hwmod omap54xx_i2c4_hwmod = {
-	.name		= "i2c4",
-	.class		= &omap54xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c5 */
-static struct omap_hwmod omap54xx_i2c5_hwmod = {
-	.name		= "i2c5",
-	.class		= &omap54xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C5_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_I2C5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'kbd' class
  * keyboard controller
@@ -2226,46 +2121,6 @@ static struct omap_hwmod_ocp_if omap54xx_l4_per__gpio8 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per -> i2c1 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__i2c1 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_i2c1_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c2 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__i2c2 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_i2c2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c3 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__i2c3 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_i2c3_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c4 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__i2c4 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_i2c4_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c5 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__i2c5 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_i2c5_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> kbd */
 static struct omap_hwmod_ocp_if omap54xx_l4_wkup__kbd = {
 	.master		= &omap54xx_l4_wkup_hwmod,
@@ -2575,11 +2430,6 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__gpio6,
 	&omap54xx_l4_per__gpio7,
 	&omap54xx_l4_per__gpio8,
-	&omap54xx_l4_per__i2c1,
-	&omap54xx_l4_per__i2c2,
-	&omap54xx_l4_per__i2c3,
-	&omap54xx_l4_per__i2c4,
-	&omap54xx_l4_per__i2c5,
 	&omap54xx_l3_main_2__mmu_ipu,
 	&omap54xx_l4_wkup__kbd,
 	&omap54xx_l4_cfg__mailbox,
-- 
2.21.0
