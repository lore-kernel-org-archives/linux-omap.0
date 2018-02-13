From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/9] ARM: OMAP2+: Cleanup omap_gpio_dev_attr usage
Date: Mon, 12 Feb 2018 19:32:37 -0600
Message-ID: <20180213013243.8378-4-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The omap_gpio_dev_attr data was used to supply instance-specific
data for legacy non-DT devices. The GPIO legacy device support has
been cleaned up in commit 14944934f8ac ("ARM: OMAP2+: Remove legacy
gpio code") a while ago and this data is therefore no longer needed.
So, cleanup the structure and all the associated data in various
hwmod data files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c              |  1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 11 -----------
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  1 -
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  9 ---------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c              |  2 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 13 -------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c              |  4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 13 -------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c              | 15 ---------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c               | 15 ---------------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c              |  8 --------
 arch/arm/mach-omap2/omap_hwmod_common_data.h            |  1 -
 include/linux/platform_data/gpio-omap.h                 |  5 -----
 13 files changed, 98 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 013b26b305d2..1f696bec9962 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -134,7 +134,6 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* dma attributes */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 4b094cb384cb..a6b2875b3e7c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -9,7 +9,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/omap-dma.h>
 #include <plat/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -568,12 +567,6 @@ struct omap_hwmod omap2xxx_dss_venc_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-/* gpio dev_attr */
-struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = false,
-};
-
 /* gpio1 */
 struct omap_hwmod omap2xxx_gpio1_hwmod = {
 	.name		= "gpio1",
@@ -587,7 +580,6 @@ struct omap_hwmod omap2xxx_gpio1_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -603,7 +595,6 @@ struct omap_hwmod omap2xxx_gpio2_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -619,7 +610,6 @@ struct omap_hwmod omap2xxx_gpio3_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* gpio4 */
@@ -635,7 +625,6 @@ struct omap_hwmod omap2xxx_gpio4_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* mcspi1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index 434bd1a77229..bbda6887388b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -139,7 +139,6 @@ extern struct omap_hwmod_class am33xx_epwmss_hwmod_class;
 extern struct omap_hwmod_class am33xx_ehrpwm_hwmod_class;
 extern struct omap_hwmod_class am33xx_spi_hwmod_class;
 
-extern struct omap_gpio_dev_attr gpio_dev_attr;
 extern struct omap2_mcspi_dev_attr mcspi_attrib;
 
 void omap_hwmod_am33xx_reg(void);
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 4bcf9f3e1544..b710b6d984cc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -14,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include "omap_hwmod.h"
@@ -537,11 +536,6 @@ struct omap_hwmod_class am33xx_gpio_hwmod_class = {
 	.rev		= 2,
 };
 
-struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width	= 32,
-	.dbck_flag	= true,
-};
-
 /* gpio1 */
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
@@ -560,7 +554,6 @@ struct omap_hwmod am33xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -581,7 +574,6 @@ struct omap_hwmod am33xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -602,7 +594,6 @@ struct omap_hwmod am33xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpmc */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 4d16b15bb0cf..232d03045c6d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -17,7 +17,6 @@
 #include <linux/i2c-omap.h>
 
 #include "omap_hwmod.h"
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod_common_data.h"
@@ -252,7 +251,6 @@ static struct omap_hwmod am33xx_gpio0_hwmod = {
 	},
 	.opt_clks	= gpio0_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* lcdc */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1a2f2242e31b..c7ff7560f47a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,7 +17,6 @@
 
 #include <linux/i2c-omap.h>
 #include <linux/power/smartreflex.h>
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 
 #include <linux/omap-dma.h>
@@ -769,12 +768,6 @@ static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
 	.rev = 1,
 };
 
-/* gpio_dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = true,
-};
-
 /* gpio1 */
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbck", },
@@ -794,7 +787,6 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -816,7 +808,6 @@ static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -838,7 +829,6 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio4 */
@@ -860,7 +850,6 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio5 */
@@ -883,7 +872,6 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio6 */
@@ -906,7 +894,6 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* dma attributes */
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index afbce1f6f641..4f31ce899869 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -14,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include "omap_hwmod.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
@@ -107,7 +106,6 @@ static struct omap_hwmod am43xx_gpio0_hwmod = {
 	},
 	.opt_clks	= gpio0_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
@@ -288,7 +286,6 @@ static struct omap_hwmod am43xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
@@ -309,7 +306,6 @@ static struct omap_hwmod am43xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 static struct omap_hwmod_class am43xx_ocp2scp_hwmod_class = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index a1901c22a0f0..3afb7333b800 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -21,7 +21,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
@@ -1083,12 +1082,6 @@ static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width	= 32,
-	.dbck_flag	= true,
-};
-
 /* gpio1 */
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
@@ -1108,7 +1101,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -1131,7 +1123,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -1154,7 +1145,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio4 */
@@ -1177,7 +1167,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio5 */
@@ -1200,7 +1189,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio6 */
@@ -1223,7 +1211,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	},
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 988e7eaa1330..593b4bc92d99 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
@@ -627,12 +626,6 @@ static struct omap_hwmod_class omap54xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width	= 32,
-	.dbck_flag	= true,
-};
-
 /* gpio1 */
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
@@ -652,7 +645,6 @@ static struct omap_hwmod omap54xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -675,7 +667,6 @@ static struct omap_hwmod omap54xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -698,7 +689,6 @@ static struct omap_hwmod omap54xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio4 */
@@ -721,7 +711,6 @@ static struct omap_hwmod omap54xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio5 */
@@ -744,7 +733,6 @@ static struct omap_hwmod omap54xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio6 */
@@ -767,7 +755,6 @@ static struct omap_hwmod omap54xx_gpio6_hwmod = {
 	},
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio7 */
@@ -790,7 +777,6 @@ static struct omap_hwmod omap54xx_gpio7_hwmod = {
 	},
 	.opt_clks	= gpio7_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio7_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio8 */
@@ -813,7 +799,6 @@ static struct omap_hwmod omap54xx_gpio8_hwmod = {
 	},
 	.opt_clks	= gpio8_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 4c2a05b1bd19..523e89498fd3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/io.h>
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
@@ -818,12 +817,6 @@ static struct omap_hwmod_class dra7xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width	= 32,
-	.dbck_flag	= true,
-};
-
 /* gpio1 */
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
@@ -844,7 +837,6 @@ static struct omap_hwmod dra7xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
@@ -867,7 +859,6 @@ static struct omap_hwmod dra7xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
@@ -890,7 +881,6 @@ static struct omap_hwmod dra7xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio4 */
@@ -913,7 +903,6 @@ static struct omap_hwmod dra7xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio5 */
@@ -936,7 +925,6 @@ static struct omap_hwmod dra7xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio6 */
@@ -959,7 +947,6 @@ static struct omap_hwmod dra7xx_gpio6_hwmod = {
 	},
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio7 */
@@ -982,7 +969,6 @@ static struct omap_hwmod dra7xx_gpio7_hwmod = {
 	},
 	.opt_clks	= gpio7_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio7_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio8 */
@@ -1005,7 +991,6 @@ static struct omap_hwmod dra7xx_gpio8_hwmod = {
 	},
 	.opt_clks	= gpio8_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 84f118280a0e..90fd06682ef5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -15,7 +15,6 @@
  *
  */
 
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dmtimer.h>
@@ -488,11 +487,6 @@ static struct omap_hwmod_class dm81xx_gpio_hwmod_class = {
 	.rev	= 2,
 };
 
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width	= 32,
-	.dbck_flag	= true,
-};
-
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "sysclk18_ck" },
 };
@@ -510,7 +504,6 @@ static struct omap_hwmod dm81xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio1 = {
@@ -537,7 +530,6 @@ static struct omap_hwmod dm81xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 29a52df2de26..56dbaca9a728 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -19,7 +19,6 @@
 #include "display.h"
 
 /* Common IP block data across OMAP2xxx */
-extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
 extern struct omap_hwmod omap2xxx_l3_main_hwmod;
 extern struct omap_hwmod omap2xxx_l4_core_hwmod;
 extern struct omap_hwmod omap2xxx_l4_wkup_hwmod;
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index cb2618147c34..8612855691b2 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -157,11 +157,6 @@
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
-struct omap_gpio_dev_attr {
-	int bank_width;		/* GPIO bank width */
-	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
-};
-
 struct omap_gpio_reg_offs {
 	u16 revision;
 	u16 direction;
-- 
2.15.1
