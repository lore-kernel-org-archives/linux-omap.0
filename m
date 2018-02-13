From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 5/9] ARM: OMAP2+: Cleanup omap_timer_capability_dev_attr usage
Date: Mon, 12 Feb 2018 19:32:39 -0600
Message-ID: <20180213013243.8378-6-s-anna@ti.com>
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

The omap_timer_capability_dev_attr data was used to supply instance
specific capabilities (like always-on, PWM functionality or ability
to interrupt DSP cores) for legacy non-DT devices. These capabilities
are now provided through device-tree properties. The legacy device
support has been cleaned up in commit 8d39ff3d1696 ("ARM: OMAP2+:
Remove unused legacy code for timer") and this data is therefore
no longer needed. So, cleanup the structure and all the associated
data in various hwmod data files.

While at this, remove the stale header in hwmod data files that
already do not have any timer capability data.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 37 ----------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 36 ---------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 29 -----------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  1 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  1 -
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 14 --------
 arch/arm/plat-omap/include/plat/dmtimer.h          |  4 ---
 9 files changed, 124 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1fdfd4568899..9f16b1b8d882 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,7 +16,6 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9b5a18b35ff6..409f0e634707 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,7 +18,6 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index a6b2875b3e7c..a6c2fa96628c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod.h"
@@ -219,23 +218,7 @@ struct omap_hwmod omap2xxx_iva_hwmod = {
 	.class		= &iva_hwmod_class,
 };
 
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability       = OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_PWM,
-};
-
-/* timers with DSP interrupt dev attribute */
-static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
-};
-
 /* timer1 */
-
 struct omap_hwmod omap2xxx_timer1_hwmod = {
 	.name		= "timer1",
 	.main_clk	= "gpt1_fck",
@@ -246,13 +229,11 @@ struct omap_hwmod omap2xxx_timer1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer2 */
-
 struct omap_hwmod omap2xxx_timer2_hwmod = {
 	.name		= "timer2",
 	.main_clk	= "gpt2_fck",
@@ -268,7 +249,6 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 };
 
 /* timer3 */
-
 struct omap_hwmod omap2xxx_timer3_hwmod = {
 	.name		= "timer3",
 	.main_clk	= "gpt3_fck",
@@ -284,7 +264,6 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 };
 
 /* timer4 */
-
 struct omap_hwmod omap2xxx_timer4_hwmod = {
 	.name		= "timer4",
 	.main_clk	= "gpt4_fck",
@@ -300,7 +279,6 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 };
 
 /* timer5 */
-
 struct omap_hwmod omap2xxx_timer5_hwmod = {
 	.name		= "timer5",
 	.main_clk	= "gpt5_fck",
@@ -311,13 +289,11 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer6 */
-
 struct omap_hwmod omap2xxx_timer6_hwmod = {
 	.name		= "timer6",
 	.main_clk	= "gpt6_fck",
@@ -328,13 +304,11 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer7 */
-
 struct omap_hwmod omap2xxx_timer7_hwmod = {
 	.name		= "timer7",
 	.main_clk	= "gpt7_fck",
@@ -345,13 +319,11 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer8 */
-
 struct omap_hwmod omap2xxx_timer8_hwmod = {
 	.name		= "timer8",
 	.main_clk	= "gpt8_fck",
@@ -362,13 +334,11 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer9 */
-
 struct omap_hwmod omap2xxx_timer9_hwmod = {
 	.name		= "timer9",
 	.main_clk	= "gpt9_fck",
@@ -379,13 +349,11 @@ struct omap_hwmod omap2xxx_timer9_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer10 */
-
 struct omap_hwmod omap2xxx_timer10_hwmod = {
 	.name		= "timer10",
 	.main_clk	= "gpt10_fck",
@@ -396,13 +364,11 @@ struct omap_hwmod omap2xxx_timer10_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer11 */
-
 struct omap_hwmod omap2xxx_timer11_hwmod = {
 	.name		= "timer11",
 	.main_clk	= "gpt11_fck",
@@ -413,13 +379,11 @@ struct omap_hwmod omap2xxx_timer11_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
-
 struct omap_hwmod omap2xxx_timer12_hwmod = {
 	.name		= "timer12",
 	.main_clk	= "gpt12_fck",
@@ -430,7 +394,6 @@ struct omap_hwmod omap2xxx_timer12_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1bb33d8bd2ac..7515119cab64 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -24,7 +24,6 @@
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
@@ -154,31 +153,6 @@ static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
 	.sysc = &omap3xxx_timer_sysc,
 };
 
-/* secure timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_secure_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON | OMAP_TIMER_SECURE,
-};
-
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
-	.timer_capability	= OMAP_TIMER_HAS_PWM,
-};
-
-/* timers with DSP interrupt dev attribute */
-static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
-};
-
-/* pwm timers with DSP interrupt dev attribute */
-static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ | OMAP_TIMER_HAS_PWM,
-};
-
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.name		= "timer1",
@@ -190,7 +164,6 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -251,7 +224,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -267,7 +239,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -283,7 +254,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -299,7 +269,6 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT8_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_dsp_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -315,7 +284,6 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT9_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -331,7 +299,6 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT10_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
@@ -347,13 +314,11 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT11_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
-
 static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	.name		= "timer12",
 	.main_clk	= "gpt12_fck",
@@ -364,7 +329,6 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT12_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_secure_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index cb39901d611b..70eb826d5f65 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,7 +29,6 @@
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
@@ -2526,26 +2525,6 @@ static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.sysc	= &omap44xx_timer_sysc,
 };
 
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
-	.timer_capability	= OMAP_TIMER_HAS_PWM,
-};
-
-/* timers with DSP interrupt dev attribute */
-static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
-};
-
-/* pwm timers with DSP interrupt dev attribute */
-static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
-	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ | OMAP_TIMER_HAS_PWM,
-};
-
 /* timer1 */
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
@@ -2560,7 +2539,6 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer2 */
@@ -2622,7 +2600,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer6 */
@@ -2638,7 +2615,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer7 */
@@ -2654,7 +2630,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer8 */
@@ -2670,7 +2645,6 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_dsp_pwm_dev_attr,
 };
 
 /* timer9 */
@@ -2686,7 +2660,6 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 };
 
 /* timer10 */
@@ -2703,7 +2676,6 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 };
 
 /* timer11 */
@@ -2719,7 +2691,6 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 250524fed202..2275789854dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -25,7 +25,6 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index a78f9285cbe8..d0f1fd65d01f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -25,7 +25,6 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 90fd06682ef5..58ce27366d9e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -17,7 +17,6 @@
 
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 #include "cm81xx.h"
@@ -646,15 +645,10 @@ static struct omap_hwmod_class dm816x_timer_hwmod_class = {
 	.sysc = &dm816x_timer_sysc,
 };
 
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON,
-};
-
 static struct omap_hwmod dm814x_timer1_hwmod = {
 	.name		= "timer1",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "timer1_fck",
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -676,7 +670,6 @@ static struct omap_hwmod dm816x_timer1_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -691,7 +684,6 @@ static struct omap_hwmod dm814x_timer2_hwmod = {
 	.name		= "timer2",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "timer2_fck",
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -713,7 +705,6 @@ static struct omap_hwmod dm816x_timer2_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -734,7 +725,6 @@ static struct omap_hwmod dm816x_timer3_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -755,7 +745,6 @@ static struct omap_hwmod dm816x_timer4_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -776,7 +765,6 @@ static struct omap_hwmod dm816x_timer5_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -797,7 +785,6 @@ static struct omap_hwmod dm816x_timer6_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
@@ -818,7 +805,6 @@ static struct omap_hwmod dm816x_timer7_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dd79f3005cdf..8b7d8a6e02cc 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -75,10 +75,6 @@
  */
 #define OMAP_TIMER_ERRATA_I103_I767			0x80000000
 
-struct omap_timer_capability_dev_attr {
-	u32 timer_capability;
-};
-
 struct timer_regs {
 	u32 tidr;
 	u32 tier;
-- 
2.15.1
