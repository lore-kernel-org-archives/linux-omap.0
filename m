From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 6/9] ARM: OMAP2+: Cleanup omap2_spi_dev_attr and other legacy
 data
Date: Mon, 12 Feb 2018 19:32:40 -0600
Message-ID: <20180213013243.8378-7-s-anna@ti.com>
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

The omap2_spi_dev_attr data was used to supply instance-specific
data for legacy non-DT devices. The SPI legacy device support
including the usage of the hwmod class revision data has been
dropped in commit 6f3ab009a178 ("ARM: OMAP2+: Remove unused legacy
code for device init") and this data is therefore no longer needed.
So, cleanup the structure and all the associated data in various
hwmod data files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  6 -----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 12 ----------
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 --
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  7 ------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  2 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 26 ----------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 22 ------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 26 ----------------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 26 ----------------------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  7 ------
 include/linux/platform_data/spi-omap2-mcspi.h      |  8 -------
 13 files changed, 149 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 9f16b1b8d882..fe66cf247874 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/i2c-omap.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 409f0e634707..cdbd09b21168 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -16,7 +16,6 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/hsmmc-omap.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
@@ -157,10 +156,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 };
 
 /* mcspi3 */
-static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
-	.num_chipselect = 2,
-};
-
 static struct omap_hwmod omap2430_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.main_clk	= "mcspi3_fck",
@@ -172,7 +167,6 @@ static struct omap_hwmod omap2430_mcspi3_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi3_dev_attr,
 };
 
 /* usbhsotg */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index a6c2fa96628c..3f2e5c933825 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/omap-dma.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
@@ -157,7 +156,6 @@ static struct omap_hwmod_class_sysconfig omap2xxx_mcspi_sysc = {
 struct omap_hwmod_class omap2xxx_mcspi_class = {
 	.name	= "mcspi",
 	.sysc	= &omap2xxx_mcspi_sysc,
-	.rev	= OMAP2_MCSPI_REV,
 };
 
 /*
@@ -591,10 +589,6 @@ struct omap_hwmod omap2xxx_gpio4_hwmod = {
 };
 
 /* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
-	.num_chipselect = 4,
-};
-
 struct omap_hwmod omap2xxx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.main_clk	= "mcspi1_fck",
@@ -606,14 +600,9 @@ struct omap_hwmod omap2xxx_mcspi1_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi1_dev_attr,
 };
 
 /* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
-	.num_chipselect = 2,
-};
-
 struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.main_clk	= "mcspi2_fck",
@@ -625,7 +614,6 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi2_dev_attr,
 };
 
 static struct omap_hwmod_class omap2xxx_counter_hwmod_class = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index bbda6887388b..6f81d7a4fec1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -139,8 +139,6 @@ extern struct omap_hwmod_class am33xx_epwmss_hwmod_class;
 extern struct omap_hwmod_class am33xx_ehrpwm_hwmod_class;
 extern struct omap_hwmod_class am33xx_spi_hwmod_class;
 
-extern struct omap2_mcspi_dev_attr mcspi_attrib;
-
 void omap_hwmod_am33xx_reg(void);
 void omap_hwmod_am43xx_reg(void);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 641b94f8ddb4..9843179b0217 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/platform_data/hsmmc-omap.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include "omap_hwmod.h"
 #include "i2c.h"
 #include "wd_timer.h"
@@ -877,13 +876,9 @@ static struct omap_hwmod_class_sysconfig am33xx_mcspi_sysc = {
 struct omap_hwmod_class am33xx_spi_hwmod_class = {
 	.name		= "mcspi",
 	.sysc		= &am33xx_mcspi_sysc,
-	.rev		= OMAP4_MCSPI_REV,
 };
 
 /* spi0 */
-struct omap2_mcspi_dev_attr mcspi_attrib = {
-	.num_chipselect	= 2,
-};
 struct omap_hwmod am33xx_spi0_hwmod = {
 	.name		= "spi0",
 	.class		= &am33xx_spi_hwmod_class,
@@ -894,7 +889,6 @@ struct omap_hwmod am33xx_spi0_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi_attrib,
 };
 
 /* spi1 */
@@ -908,7 +902,6 @@ struct omap_hwmod am33xx_spi1_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi_attrib,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 232d03045c6d..53e1ac3724f2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -17,8 +17,6 @@
 #include <linux/i2c-omap.h>
 
 #include "omap_hwmod.h"
-#include <linux/platform_data/spi-omap2-mcspi.h>
-
 #include "omap_hwmod_common_data.h"
 
 #include "control.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7515119cab64..23008cb35140 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -23,7 +23,6 @@
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
@@ -1189,14 +1188,9 @@ static struct omap_hwmod_class_sysconfig omap34xx_mcspi_sysc = {
 static struct omap_hwmod_class omap34xx_mcspi_class = {
 	.name = "mcspi",
 	.sysc = &omap34xx_mcspi_sysc,
-	.rev = OMAP3_MCSPI_REV,
 };
 
 /* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
-	.num_chipselect = 4,
-};
-
 static struct omap_hwmod omap34xx_mcspi1 = {
 	.name		= "mcspi1",
 	.main_clk	= "mcspi1_fck",
@@ -1208,14 +1202,9 @@ static struct omap_hwmod omap34xx_mcspi1 = {
 		},
 	},
 	.class		= &omap34xx_mcspi_class,
-	.dev_attr       = &omap_mcspi1_dev_attr,
 };
 
 /* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
-	.num_chipselect = 2,
-};
-
 static struct omap_hwmod omap34xx_mcspi2 = {
 	.name		= "mcspi2",
 	.main_clk	= "mcspi2_fck",
@@ -1227,16 +1216,9 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 		},
 	},
 	.class		= &omap34xx_mcspi_class,
-	.dev_attr       = &omap_mcspi2_dev_attr,
 };
 
 /* mcspi3 */
-
-
-static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
-	.num_chipselect = 2,
-};
-
 static struct omap_hwmod omap34xx_mcspi3 = {
 	.name		= "mcspi3",
 	.main_clk	= "mcspi3_fck",
@@ -1248,16 +1230,9 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 		},
 	},
 	.class		= &omap34xx_mcspi_class,
-	.dev_attr       = &omap_mcspi3_dev_attr,
 };
 
 /* mcspi4 */
-
-
-static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
-	.num_chipselect = 1,
-};
-
 static struct omap_hwmod omap34xx_mcspi4 = {
 	.name		= "mcspi4",
 	.main_clk	= "mcspi4_fck",
@@ -1269,7 +1244,6 @@ static struct omap_hwmod omap34xx_mcspi4 = {
 		},
 	},
 	.class		= &omap34xx_mcspi_class,
-	.dev_attr       = &omap_mcspi4_dev_attr,
 };
 
 /* usbhsotg */
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 4f31ce899869..5f73b730d4fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -14,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include "omap_hwmod.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
@@ -237,7 +236,6 @@ static struct omap_hwmod am43xx_spi2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi_attrib,
 };
 
 static struct omap_hwmod am43xx_spi3_hwmod = {
@@ -251,7 +249,6 @@ static struct omap_hwmod am43xx_spi3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi_attrib,
 };
 
 static struct omap_hwmod am43xx_spi4_hwmod = {
@@ -265,7 +262,6 @@ static struct omap_hwmod am43xx_spi4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi_attrib,
 };
 
 static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 70eb826d5f65..5a313483b3b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,7 +27,6 @@
 
 #include <linux/omap-dma.h>
 
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap_hwmod.h"
@@ -1838,14 +1837,9 @@ static struct omap_hwmod_class_sysconfig omap44xx_mcspi_sysc = {
 static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
 	.name	= "mcspi",
 	.sysc	= &omap44xx_mcspi_sysc,
-	.rev	= OMAP4_MCSPI_REV,
 };
 
 /* mcspi1 */
-static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
-	.num_chipselect	= 4,
-};
-
 static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
@@ -1858,14 +1852,9 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi1_dev_attr,
 };
 
 /* mcspi2 */
-static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
@@ -1878,14 +1867,9 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi2_dev_attr,
 };
 
 /* mcspi3 */
-static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
@@ -1898,14 +1882,9 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi3_dev_attr,
 };
 
 /* mcspi4 */
-static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
-	.num_chipselect	= 1,
-};
-
 static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
@@ -1918,7 +1897,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi4_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 2275789854dc..f901b17bd73a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -23,7 +23,6 @@
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap_hwmod.h"
@@ -1123,15 +1122,9 @@ static struct omap_hwmod_class_sysconfig omap54xx_mcspi_sysc = {
 static struct omap_hwmod_class omap54xx_mcspi_hwmod_class = {
 	.name	= "mcspi",
 	.sysc	= &omap54xx_mcspi_sysc,
-	.rev	= OMAP4_MCSPI_REV,
 };
 
 /* mcspi1 */
-/* mcspi1 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
-	.num_chipselect	= 4,
-};
-
 static struct omap_hwmod omap54xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap54xx_mcspi_hwmod_class,
@@ -1144,15 +1137,9 @@ static struct omap_hwmod omap54xx_mcspi1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi1_dev_attr,
 };
 
 /* mcspi2 */
-/* mcspi2 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod omap54xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap54xx_mcspi_hwmod_class,
@@ -1165,15 +1152,9 @@ static struct omap_hwmod omap54xx_mcspi2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi2_dev_attr,
 };
 
 /* mcspi3 */
-/* mcspi3 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod omap54xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap54xx_mcspi_hwmod_class,
@@ -1186,15 +1167,9 @@ static struct omap_hwmod omap54xx_mcspi3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi3_dev_attr,
 };
 
 /* mcspi4 */
-/* mcspi4 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
-	.num_chipselect	= 1,
-};
-
 static struct omap_hwmod omap54xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap54xx_mcspi_hwmod_class,
@@ -1207,7 +1182,6 @@ static struct omap_hwmod omap54xx_mcspi4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi4_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d0f1fd65d01f..d66dc806425d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -23,7 +23,6 @@
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap_hwmod.h"
@@ -1375,15 +1374,9 @@ static struct omap_hwmod_class_sysconfig dra7xx_mcspi_sysc = {
 static struct omap_hwmod_class dra7xx_mcspi_hwmod_class = {
 	.name	= "mcspi",
 	.sysc	= &dra7xx_mcspi_sysc,
-	.rev	= OMAP4_MCSPI_REV,
 };
 
 /* mcspi1 */
-/* mcspi1 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
-	.num_chipselect	= 4,
-};
-
 static struct omap_hwmod dra7xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &dra7xx_mcspi_hwmod_class,
@@ -1396,15 +1389,9 @@ static struct omap_hwmod dra7xx_mcspi1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi1_dev_attr,
 };
 
 /* mcspi2 */
-/* mcspi2 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod dra7xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &dra7xx_mcspi_hwmod_class,
@@ -1417,15 +1404,9 @@ static struct omap_hwmod dra7xx_mcspi2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi2_dev_attr,
 };
 
 /* mcspi3 */
-/* mcspi3 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
-	.num_chipselect	= 2,
-};
-
 static struct omap_hwmod dra7xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &dra7xx_mcspi_hwmod_class,
@@ -1438,15 +1419,9 @@ static struct omap_hwmod dra7xx_mcspi3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi3_dev_attr,
 };
 
 /* mcspi4 */
-/* mcspi4 dev_attr */
-static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
-	.num_chipselect	= 1,
-};
-
 static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &dra7xx_mcspi_hwmod_class,
@@ -1459,7 +1434,6 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mcspi4_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 58ce27366d9e..0b290de13da1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/platform_data/hsmmc-omap.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 #include "cm81xx.h"
@@ -1116,11 +1115,6 @@ static struct omap_hwmod_class_sysconfig dm816x_mcspi_sysc = {
 static struct omap_hwmod_class dm816x_mcspi_class = {
 	.name = "mcspi",
 	.sysc = &dm816x_mcspi_sysc,
-	.rev = OMAP3_MCSPI_REV,
-};
-
-static struct omap2_mcspi_dev_attr dm816x_mcspi1_dev_attr = {
-	.num_chipselect = 4,
 };
 
 static struct omap_hwmod dm81xx_mcspi1_hwmod = {
@@ -1134,7 +1128,6 @@ static struct omap_hwmod dm81xx_mcspi1_hwmod = {
 		},
 	},
 	.class		= &dm816x_mcspi_class,
-	.dev_attr	= &dm816x_mcspi1_dev_attr,
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__mcspi1 = {
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index 13c83a25958a..0bf9fddb8306 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -2,10 +2,6 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H
 
-#define OMAP2_MCSPI_REV 0
-#define OMAP3_MCSPI_REV 1
-#define OMAP4_MCSPI_REV 2
-
 #define OMAP4_MCSPI_REG_OFFSET 0x100
 
 #define MCSPI_PINDIR_D0_IN_D1_OUT	0
@@ -17,10 +13,6 @@ struct omap2_mcspi_platform_config {
 	unsigned int pin_dir:1;
 };
 
-struct omap2_mcspi_dev_attr {
-	unsigned short num_chipselect;
-};
-
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
 
-- 
2.15.1
