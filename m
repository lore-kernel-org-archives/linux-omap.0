From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v16 03/12] OMAP2+: dmtimer: convert to platform devices
Date: Tue, 20 Sep 2011 17:00:18 +0530
Message-ID: <1316518227-28116-4-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab1ITLau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 07:30:50 -0400
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add routines to converts dmtimers to platform devices. The device data
is obtained from hwmod database of respective platform and is registered
to device model after successful binding to driver.
In addition, capability attribute of each of the timers is added in
hwmod database.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 +++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   22 +++++
 arch/arm/mach-omap2/timer.c                |  136 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h  |   12 +++-
 6 files changed, 240 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b6ea69a..6d72062 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -269,6 +269,16 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_iva_masters),
 };
 
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability       = OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap2420_timer1_hwmod;
 
@@ -309,6 +319,7 @@ static struct omap_hwmod omap2420_timer1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer1_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -345,6 +356,7 @@ static struct omap_hwmod omap2420_timer2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer2_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -381,6 +393,7 @@ static struct omap_hwmod omap2420_timer3_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer3_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -417,6 +430,7 @@ static struct omap_hwmod omap2420_timer4_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer4_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -453,6 +467,7 @@ static struct omap_hwmod omap2420_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer5_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -490,6 +505,7 @@ static struct omap_hwmod omap2420_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer6_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -526,6 +542,7 @@ static struct omap_hwmod omap2420_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer7_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -562,6 +579,7 @@ static struct omap_hwmod omap2420_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer8_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -598,6 +616,7 @@ static struct omap_hwmod omap2420_timer9_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer9_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -634,6 +653,7 @@ static struct omap_hwmod omap2420_timer10_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer10_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -670,6 +690,7 @@ static struct omap_hwmod omap2420_timer11_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer11_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -706,6 +727,7 @@ static struct omap_hwmod omap2420_timer12_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer12_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 56de8d6..a2580d0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -343,6 +343,16 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_iva_masters),
 };
 
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability       = OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap2430_timer1_hwmod;
 
@@ -383,6 +393,7 @@ static struct omap_hwmod omap2430_timer1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer1_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -419,6 +430,7 @@ static struct omap_hwmod omap2430_timer2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer2_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -455,6 +467,7 @@ static struct omap_hwmod omap2430_timer3_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer3_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -491,6 +504,7 @@ static struct omap_hwmod omap2430_timer4_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer4_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -527,6 +541,7 @@ static struct omap_hwmod omap2430_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer5_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -563,6 +578,7 @@ static struct omap_hwmod omap2430_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer6_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -599,6 +615,7 @@ static struct omap_hwmod omap2430_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer7_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -635,6 +652,7 @@ static struct omap_hwmod omap2430_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer8_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -671,6 +689,7 @@ static struct omap_hwmod omap2430_timer9_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer9_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -707,6 +726,7 @@ static struct omap_hwmod omap2430_timer10_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer10_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -743,6 +763,7 @@ static struct omap_hwmod omap2430_timer11_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer11_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
@@ -779,6 +800,7 @@ static struct omap_hwmod omap2430_timer12_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer12_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ab35acb..2e4852d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -564,6 +564,21 @@ static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
 	.rev =  OMAP_TIMER_IP_VERSION_1,
 };
 
+/* secure timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_secure_dev_attr = {
+	.timer_capability       = OMAP_TIMER_SECURE,
+};
+
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability       = OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod;
 
@@ -604,6 +619,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer1_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -649,6 +665,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer2_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -694,6 +711,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer3_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -739,6 +757,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer4_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -784,6 +803,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer5_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -829,6 +849,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer6_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -874,6 +895,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer7_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -919,6 +941,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer8_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -964,6 +987,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer9_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1000,6 +1024,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer10_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -1036,6 +1061,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer11_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1085,6 +1111,7 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_secure_dev_attr,
 	.slaves		= omap3xxx_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer12_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index caaf409..393afac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,6 +29,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
+#include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -4201,6 +4202,16 @@ static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.sysc	= &omap44xx_timer_sysc,
 };
 
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability	= OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
+	.timer_capability	= OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap44xx_timer1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
@@ -4244,6 +4255,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
 };
@@ -4291,6 +4303,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
 };
@@ -4338,6 +4351,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
 };
@@ -4385,6 +4399,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
 };
@@ -4451,6 +4466,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer5_slaves),
 };
@@ -4518,6 +4534,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer6_slaves),
 };
@@ -4584,6 +4601,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer7_slaves),
 };
@@ -4650,6 +4668,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer8_slaves),
 };
@@ -4697,6 +4716,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
 };
@@ -4744,6 +4764,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
 };
@@ -4791,6 +4812,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
 };
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 21d34fb..2b6632c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/slab.h>
 
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
@@ -42,6 +43,7 @@
 #include <asm/sched_clock.h>
 #include <plat/common.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 /* Parent clocks, eventually these will come from the clock framework */
 
@@ -342,3 +344,137 @@ static void __init omap4_timer_init(void)
 }
 OMAP_SYS_TIMER(4)
 #endif
+
+/**
+ * omap2_dm_timer_set_src - change the timer input clock source
+ * @pdev:	timer platform device pointer
+ * @source:	array index of parent clock source
+ */
+static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
+{
+	int ret;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	struct clk *fclk, *parent;
+	char *parent_name = NULL;
+
+	fclk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR_OR_NULL(fclk)) {
+		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
+				__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		parent_name = "sys_ck";
+		break;
+
+	case OMAP_TIMER_SRC_32_KHZ:
+		parent_name = "32k_ck";
+		break;
+
+	case OMAP_TIMER_SRC_EXT_CLK:
+		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
+			parent_name = "alt_ck";
+			break;
+		}
+		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
+			__func__, __LINE__);
+		clk_put(fclk);
+		return -EINVAL;
+	}
+
+	parent = clk_get(&pdev->dev, parent_name);
+	if (IS_ERR_OR_NULL(parent)) {
+		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
+			__func__, __LINE__, parent_name);
+		clk_put(fclk);
+		return -EINVAL;
+	}
+
+	ret = clk_set_parent(fclk, parent);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
+			__func__, parent_name);
+		ret = -EINVAL;
+	}
+
+	clk_put(parent);
+	clk_put(fclk);
+
+	return ret;
+}
+
+struct omap_device_pm_latency omap2_dmtimer_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+/**
+ * omap_timer_init - build and register timer device with an
+ * associated timer hwmod
+ * @oh:	timer hwmod pointer to be used to build timer device
+ * @user:	parameter that can be passed from calling hwmod API
+ *
+ * Called by omap_hwmod_for_each_by_class to register each of the timer
+ * devices present in the system. The number of timer devices is known
+ * by parsing through the hwmod database for a given class name. At the
+ * end of function call memory is allocated for timer device and it is
+ * registered to the framework ready to be proved by the driver.
+ */
+static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
+{
+	int id;
+	int ret = 0;
+	char *name = "omap_timer";
+	struct dmtimer_platform_data *pdata;
+	struct omap_device *od;
+	struct omap_timer_capability_dev_attr *timer_dev_attr;
+
+	pr_debug("%s: %s\n", __func__, oh->name);
+
+	/* on secure device, do not register secure timer */
+	timer_dev_attr = oh->dev_attr;
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP && timer_dev_attr)
+		if (timer_dev_attr->timer_capability == OMAP_TIMER_SECURE)
+			return ret;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Extract the IDs from name field in hwmod database
+	 * and use the same for constructing ids' for the
+	 * timer devices. In a way, we are avoiding usage of
+	 * static variable witin the function to do the same.
+	 * CAUTION: We have to be careful and make sure the
+	 * name in hwmod database does not change in which case
+	 * we might either make corresponding change here or
+	 * switch back static variable mechanism.
+	 */
+	sscanf(oh->name, "timer%2d", &id);
+
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+	pdata->timer_ip_version = oh->class->rev;
+
+	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency),
+			0);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Can't build omap_device for %s: %s.\n",
+			__func__, name, oh->name);
+		ret = -EINVAL;
+	}
+
+	kfree(pdata);
+
+	return ret;
+}
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 30381b5..514d4a2 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/dmtimer.h
+ * arch/arm/plat-omap/include/plat/dmtimer.h
  *
  * OMAP Dual-Mode Timers
  *
@@ -60,6 +60,16 @@
  * in OMAP4 can be distinguished.
  */
 #define OMAP_TIMER_IP_VERSION_1                        0x1
+
+/* timer capabilities used in hwmod database */
+#define OMAP_TIMER_SECURE				0x80000000
+#define OMAP_TIMER_ALWON				0x40000000
+#define OMAP_TIMER_HAS_PWM				0x20000000
+
+struct omap_timer_capability_dev_attr {
+	u32 timer_capability;
+};
+
 struct omap_dm_timer;
 struct clk;
 
-- 
1.7.0.4

