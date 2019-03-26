From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Drop i2c platform data for omap4
Date: Tue, 26 Mar 2019 11:09:56 -0700
Message-ID: <20190326180958.31677-3-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 119 ---------------------
 1 file changed, 119 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,7 +22,6 @@
 
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
-#include <linux/platform_data/i2c-omap.h>
 
 #include <linux/omap-dma.h>
 
@@ -32,7 +31,6 @@
 #include "cm2_44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "i2c.h"
 #include "wd_timer.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
@@ -1357,87 +1355,6 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
  * multimaster high-speed i2c controller
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
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
-static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
-	.name	= "i2c",
-	.sysc	= &omap44xx_i2c_sysc,
-	.reset	= &omap_i2c_reset,
-};
-
-/* i2c1 */
-static struct omap_hwmod omap44xx_i2c1_hwmod = {
-	.name		= "i2c1",
-	.class		= &omap44xx_i2c_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c2 */
-static struct omap_hwmod omap44xx_i2c2_hwmod = {
-	.name		= "i2c2",
-	.class		= &omap44xx_i2c_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c3 */
-static struct omap_hwmod omap44xx_i2c3_hwmod = {
-	.name		= "i2c3",
-	.class		= &omap44xx_i2c_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c4 */
-static struct omap_hwmod omap44xx_i2c4_hwmod = {
-	.name		= "i2c4",
-	.class		= &omap44xx_i2c_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
 
 /*
  * 'ipu' class
@@ -3518,38 +3435,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__hsi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per -> i2c1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_i2c1_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_i2c2_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_i2c3_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> i2c4 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_i2c4_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_2 -> ipu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -4074,10 +3959,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_2__gpu,
 	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
-	&omap44xx_l4_per__i2c1,
-	&omap44xx_l4_per__i2c2,
-	&omap44xx_l4_per__i2c3,
-	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
 	/* &omap44xx_iva__sl2if, */
-- 
2.21.0
