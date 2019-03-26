From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Drop i2c platform data for dra7
Date: Tue, 26 Mar 2019 11:35:33 -0700
Message-ID: <20190326183535.20798-3-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 150 ----------------------
 1 file changed, 150 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -19,7 +19,6 @@
 
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
-#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
@@ -28,7 +27,6 @@
 #include "cm1_7xx.h"
 #include "cm2_7xx.h"
 #include "prm7xx.h"
-#include "i2c.h"
 #include "wd_timer.h"
 #include "soc.h"
 
@@ -1060,109 +1058,6 @@ static struct omap_hwmod dra7xx_hdq1w_hwmod = {
 	},
 };
 
-/*
- * 'i2c' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_i2c_sysc = {
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
-static struct omap_hwmod_class dra7xx_i2c_hwmod_class = {
-	.name	= "i2c",
-	.sysc	= &dra7xx_i2c_sysc,
-	.reset	= &omap_i2c_reset,
-};
-
-/* i2c1 */
-static struct omap_hwmod dra7xx_i2c1_hwmod = {
-	.name		= "i2c1",
-	.class		= &dra7xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c2 */
-static struct omap_hwmod dra7xx_i2c2_hwmod = {
-	.name		= "i2c2",
-	.class		= &dra7xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c3 */
-static struct omap_hwmod dra7xx_i2c3_hwmod = {
-	.name		= "i2c3",
-	.class		= &dra7xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c4 */
-static struct omap_hwmod dra7xx_i2c4_hwmod = {
-	.name		= "i2c4",
-	.class		= &dra7xx_i2c_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c5 */
-static struct omap_hwmod dra7xx_i2c5_hwmod = {
-	.name		= "i2c5",
-	.class		= &dra7xx_i2c_hwmod_class,
-	.clkdm_name	= "ipu_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_I2C5_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_IPU_I2C5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'mailbox' class
  *
@@ -3075,46 +2970,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__hdq1w = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per1 -> i2c1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c1 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_i2c1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> i2c2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c2 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_i2c2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> i2c3 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c3 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_i2c3_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> i2c4 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c4 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_i2c4_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> i2c5 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c5 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_i2c5_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> mailbox1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mailbox1 = {
 	.master		= &dra7xx_l4_cfg_hwmod,
@@ -3726,11 +3581,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__gpio8,
 	&dra7xx_l3_main_1__gpmc,
 	&dra7xx_l4_per1__hdq1w,
-	&dra7xx_l4_per1__i2c1,
-	&dra7xx_l4_per1__i2c2,
-	&dra7xx_l4_per1__i2c3,
-	&dra7xx_l4_per1__i2c4,
-	&dra7xx_l4_per1__i2c5,
 	&dra7xx_l4_cfg__mailbox1,
 	&dra7xx_l4_per3__mailbox2,
 	&dra7xx_l4_per3__mailbox3,
-- 
2.21.0
