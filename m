From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Drop i2c platform data for am33xx and am43xx
Date: Tue, 26 Mar 2019 11:13:22 -0700
Message-ID: <20190326181324.32140-3-tony@atomide.com>
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
 .../omap_hwmod_33xx_43xx_common_data.h        |  5 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  | 15 ----
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 68 -------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    | 14 ----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    | 10 ---
 5 files changed, 112 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -39,8 +39,6 @@ extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2;
 extern struct omap_hwmod_ocp_if am33xx_l3_s__gpmc;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c2;
-extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c3;
 extern struct omap_hwmod_ocp_if am33xx_l4_per__mailbox;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0;
@@ -94,9 +92,6 @@ extern struct omap_hwmod am33xx_gpio1_hwmod;
 extern struct omap_hwmod am33xx_gpio2_hwmod;
 extern struct omap_hwmod am33xx_gpio3_hwmod;
 extern struct omap_hwmod am33xx_gpmc_hwmod;
-extern struct omap_hwmod am33xx_i2c1_hwmod;
-extern struct omap_hwmod am33xx_i2c2_hwmod;
-extern struct omap_hwmod am33xx_i2c3_hwmod;
 extern struct omap_hwmod am33xx_mailbox_hwmod;
 extern struct omap_hwmod am33xx_mcasp0_hwmod;
 extern struct omap_hwmod am33xx_mcasp1_hwmod;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -188,21 +188,6 @@ struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
 	.user		= OCP_USER_MPU,
 };
 
-/* i2c2 */
-struct omap_hwmod_ocp_if am33xx_l4_per__i2c2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_i2c2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_i2c3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 ls -> mailbox */
 struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
 	.master		= &am33xx_l4_ls_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 
 #include "omap_hwmod.h"
-#include "i2c.h"
 #include "wd_timer.h"
 #include "cm33xx.h"
 #include "prm33xx.h"
@@ -625,67 +624,6 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 	},
 };
 
-/* 'i2c' class */
-static struct omap_hwmod_class_sysconfig am33xx_i2c_sysc = {
-	.rev_offs	= 0,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0090,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			  SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			  SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class i2c_class = {
-	.name		= "i2c",
-	.sysc		= &am33xx_i2c_sysc,
-	.reset		= &omap_i2c_reset,
-};
-
-/* i2c1 */
-struct omap_hwmod am33xx_i2c1_hwmod = {
-	.name		= "i2c1",
-	.class		= &i2c_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c1 */
-struct omap_hwmod am33xx_i2c2_hwmod = {
-	.name		= "i2c2",
-	.class		= &i2c_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4 = {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* i2c3 */
-struct omap_hwmod am33xx_i2c3_hwmod = {
-	.name		= "i2c3",
-	.class		= &i2c_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'mailbox' class
  * mailbox module allowing communication between the on-chip processors using a
@@ -1206,8 +1144,6 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_gpio1_hwmod, AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpio2_hwmod, AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpio3_hwmod, AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c2_hwmod, AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c3_hwmod, AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mailbox_hwmod, AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp0_hwmod, AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp1_hwmod, AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
@@ -1226,7 +1162,6 @@ static void omap_hwmod_am33xx_clkctrl(void)
 		AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_uart1_hwmod, AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer1_hwmod, AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c1_hwmod, AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
 	PRCM_FLAGS(am33xx_rtc_hwmod, HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET);
@@ -1278,8 +1213,6 @@ static void omap_hwmod_am43xx_clkctrl(void)
 	CLKCTRL(am33xx_gpio1_hwmod, AM43XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpio2_hwmod, AM43XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpio3_hwmod, AM43XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c2_hwmod, AM43XX_CM_PER_I2C1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c3_hwmod, AM43XX_CM_PER_I2C2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mailbox_hwmod, AM43XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp0_hwmod, AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp1_hwmod, AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
@@ -1298,7 +1231,6 @@ static void omap_hwmod_am43xx_clkctrl(void)
 		AM43XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_uart1_hwmod, AM43XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_timer1_hwmod, AM43XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c1_hwmod, AM43XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM43XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpmc_hwmod, AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET);
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -14,8 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/platform_data/i2c-omap.h>
-
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
 
@@ -23,7 +21,6 @@
 #include "cm33xx.h"
 #include "prm33xx.h"
 #include "prm-regbits-33xx.h"
-#include "i2c.h"
 #include "wd_timer.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 
@@ -388,14 +385,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__control = {
 	.user		= OCP_USER_MPU,
 };
 
-/* L4 WKUP -> I2C1 */
-static struct omap_hwmod_ocp_if am33xx_l4_wkup__i2c1 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_i2c1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
-	.user		= OCP_USER_MPU,
-};
-
 /* L4 WKUP -> GPIO1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__gpio0 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -482,7 +471,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__uart1,
 	&am33xx_l4_wkup__timer1,
 	&am33xx_l4_wkup__rtc,
-	&am33xx_l4_wkup__i2c1,
 	&am33xx_l4_wkup__gpio0,
 	&am33xx_l4_wkup__adc_tsc,
 	&am33xx_l4_wkup__wd_timer1,
@@ -492,8 +480,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_per__gpio1,
 	&am33xx_l4_per__gpio2,
 	&am33xx_l4_per__gpio3,
-	&am33xx_l4_per__i2c2,
-	&am33xx_l4_per__i2c3,
 	&am33xx_l4_per__mailbox,
 	&am33xx_l4_ls__mcasp0,
 	&am33xx_l4_ls__mcasp1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -650,13 +650,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_wkup__control = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_l4_wkup__i2c1 = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_i2c1_hwmod,
-	.clk		= "sys_clkin_ck",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_wkup__gpio0 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am43xx_gpio0_hwmod,
@@ -929,7 +922,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__smartreflex1,
 	&am43xx_l4_wkup__uart1,
 	&am43xx_l4_wkup__timer1,
-	&am43xx_l4_wkup__i2c1,
 	&am43xx_l4_wkup__gpio0,
 	&am43xx_l4_wkup__wd_timer1,
 	&am43xx_l4_wkup__adc_tsc,
@@ -939,8 +931,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_per__gpio1,
 	&am33xx_l4_per__gpio2,
 	&am33xx_l4_per__gpio3,
-	&am33xx_l4_per__i2c2,
-	&am33xx_l4_per__i2c3,
 	&am33xx_l4_per__mailbox,
 	&am33xx_l4_per__rng,
 	&am33xx_l4_ls__mcasp0,
-- 
2.21.0
