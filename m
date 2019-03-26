From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for am330x and am43xx
Date: Tue, 26 Mar 2019 11:13:21 -0700
Message-ID: <20190326181324.32140-2-tony@atomide.com>
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
 .../omap_hwmod_33xx_43xx_common_data.h        |  6 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c  | 24 ------
 .../omap_hwmod_33xx_43xx_ipblock_data.c       | 77 -------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  3 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |  3 -
 5 files changed, 113 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -45,9 +45,6 @@ extern struct omap_hwmod_ocp_if am33xx_l4_per__mailbox;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0;
-extern struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1;
-extern struct omap_hwmod_ocp_if am33xx_l3_s__mmc2;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer2;
@@ -103,9 +100,6 @@ extern struct omap_hwmod am33xx_i2c3_hwmod;
 extern struct omap_hwmod am33xx_mailbox_hwmod;
 extern struct omap_hwmod am33xx_mcasp0_hwmod;
 extern struct omap_hwmod am33xx_mcasp1_hwmod;
-extern struct omap_hwmod am33xx_mmc0_hwmod;
-extern struct omap_hwmod am33xx_mmc1_hwmod;
-extern struct omap_hwmod am33xx_mmc2_hwmod;
 extern struct omap_hwmod am33xx_rtc_hwmod;
 extern struct omap_hwmod am33xx_spi0_hwmod;
 extern struct omap_hwmod am33xx_spi1_hwmod;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -235,30 +235,6 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 ls -> mmc0 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mmc0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mmc1 */
-struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mmc1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 s -> mmc2 */
-struct omap_hwmod_ocp_if am33xx_l3_s__mmc2 = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_mmc2_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 ls -> mcspi0 */
 struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0 = {
 	.master		= &am33xx_l4_ls_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -16,7 +16,6 @@
 
 #include <linux/types.h>
 
-#include <linux/platform_data/hsmmc-omap.h>
 #include "omap_hwmod.h"
 #include "i2c.h"
 #include "wd_timer.h"
@@ -760,76 +759,6 @@ struct omap_hwmod am33xx_mcasp1_hwmod = {
 	},
 };
 
-/* 'mmc' class */
-static struct omap_hwmod_class_sysconfig am33xx_mmc_sysc = {
-	.rev_offs	= 0x2fc,
-	.sysc_offs	= 0x110,
-	.syss_offs	= 0x114,
-	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
-			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			  SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class am33xx_mmc_hwmod_class = {
-	.name		= "mmc",
-	.sysc		= &am33xx_mmc_sysc,
-};
-
-/* mmc0 */
-static struct omap_hsmmc_dev_attr am33xx_mmc0_dev_attr = {
-	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-
-struct omap_hwmod am33xx_mmc0_hwmod = {
-	.name		= "mmc1",
-	.class		= &am33xx_mmc_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "mmc_clk",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &am33xx_mmc0_dev_attr,
-};
-
-/* mmc1 */
-static struct omap_hsmmc_dev_attr am33xx_mmc1_dev_attr = {
-	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-
-struct omap_hwmod am33xx_mmc1_hwmod = {
-	.name		= "mmc2",
-	.class		= &am33xx_mmc_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "mmc_clk",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &am33xx_mmc1_dev_attr,
-};
-
-/* mmc2 */
-static struct omap_hsmmc_dev_attr am33xx_mmc2_dev_attr = {
-	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
-};
-struct omap_hwmod am33xx_mmc2_hwmod = {
-	.name		= "mmc3",
-	.class		= &am33xx_mmc_hwmod_class,
-	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "mmc_clk",
-	.prcm		= {
-		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &am33xx_mmc2_dev_attr,
-};
-
 /*
  * 'rtc' class
  * rtc subsystem
@@ -1282,8 +1211,6 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_mailbox_hwmod, AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp0_hwmod, AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp1_hwmod, AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc0_hwmod, AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc1_hwmod, AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spi0_hwmod, AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spi1_hwmod, AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spinlock_hwmod, AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
@@ -1303,7 +1230,6 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
 	PRCM_FLAGS(am33xx_rtc_hwmod, HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc2_hwmod, AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpmc_hwmod, AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_l4_ls_hwmod, AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_l4_wkup_hwmod, AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
@@ -1357,8 +1283,6 @@ static void omap_hwmod_am43xx_clkctrl(void)
 	CLKCTRL(am33xx_mailbox_hwmod, AM43XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp0_hwmod, AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mcasp1_hwmod, AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc0_hwmod, AM43XX_CM_PER_MMC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc1_hwmod, AM43XX_CM_PER_MMC1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spi0_hwmod, AM43XX_CM_PER_SPI0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spi1_hwmod, AM43XX_CM_PER_SPI1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_spinlock_hwmod, AM43XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
@@ -1377,7 +1301,6 @@ static void omap_hwmod_am43xx_clkctrl(void)
 	CLKCTRL(am33xx_i2c1_hwmod, AM43XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM43XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc2_hwmod, AM43XX_CM_PER_MMC2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpmc_hwmod, AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_l4_ls_hwmod, AM43XX_CM_PER_L4LS_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_l4_wkup_hwmod, AM43XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -497,9 +497,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_per__mailbox,
 	&am33xx_l4_ls__mcasp0,
 	&am33xx_l4_ls__mcasp1,
-	&am33xx_l4_ls__mmc0,
-	&am33xx_l4_ls__mmc1,
-	&am33xx_l3_s__mmc2,
 	&am33xx_l4_ls__timer2,
 	&am33xx_l4_ls__timer3,
 	&am33xx_l4_ls__timer4,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -945,9 +945,6 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_per__rng,
 	&am33xx_l4_ls__mcasp0,
 	&am33xx_l4_ls__mcasp1,
-	&am33xx_l4_ls__mmc0,
-	&am33xx_l4_ls__mmc1,
-	&am33xx_l3_s__mmc2,
 	&am33xx_l4_ls__timer2,
 	&am33xx_l4_ls__timer3,
 	&am33xx_l4_ls__timer4,
-- 
2.21.0
