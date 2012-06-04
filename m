From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 05/12] ARM: OMAP2+: HWMOD: Correct timer device attributes
Date: Mon, 4 Jun 2012 14:41:42 -0500
Message-ID: <1338838909-25356-6-git-send-email-jon-hunter@ti.com>
References: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab2FDTmF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 15:42:05 -0400
In-Reply-To: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

Fix the following issues with the timer device attributes for OMAP2+ devices:

1. For OMAP24xx devices, timers 2-8 have the ALWAYS-ON attribute indicating
   that these timers are in an ALWAYS-ON power domain. This is not the case
   only timer1 is in an ALWAYS-ON power domain.
2. For OMAP3xxx devices, timers 2-7 have the ALWAYS-ON attribute indicating
   that these timers are in an ALWAYS-ON power domain. This is not the case
   only timer1 and timer12 are in an ALWAYS-ON power domain.
3. For OMAP3xxx devices, timer12 does not have the ALWAYS-ON attribute but
   is in an always-on power domain.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    7 -------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    8 +-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 83eafd9..7814e83 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -257,7 +257,6 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -276,7 +275,6 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -295,7 +293,6 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -314,7 +311,6 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -333,7 +329,6 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -352,7 +347,6 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -371,7 +365,6 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b26d3c9..7b33094 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -150,7 +150,7 @@ static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
 
 /* secure timers dev attribute */
 static struct omap_timer_capability_dev_attr capability_secure_dev_attr = {
-	.timer_capability	= OMAP_TIMER_SECURE,
+	.timer_capability	= OMAP_TIMER_ALWON | OMAP_TIMER_SECURE,
 };
 
 /* always-on timers dev attribute */
@@ -195,7 +195,6 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
 };
 
@@ -213,7 +212,6 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT3_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -231,7 +229,6 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT4_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -249,7 +246,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -267,7 +263,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -285,7 +280,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..ebf9657 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2943,7 +2943,6 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer3 */
@@ -2965,7 +2964,6 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer4 */
@@ -2987,7 +2985,6 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer5 */
@@ -3009,7 +3006,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer6 */
@@ -3032,7 +3028,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer7 */
@@ -3054,7 +3049,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_alwon_dev_attr,
 };
 
 /* timer8 */
-- 
1.7.9.5

