From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 4/7] ARM: OMAP: Add a timer attribute for timers that can interrupt the DSP
Date: Thu, 13 Sep 2012 18:31:28 -0500
Message-ID: <1347579091-3794-5-git-send-email-jon-hunter@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759018Ab2IMXb6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 19:31:58 -0400
In-Reply-To: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Some instances of the DMTIMER peripheral on OMAP devices have the ability
to interrupt the on-chip DSP in addition to the ARM CPU. Add a DMTIMER
attribute to indicate which timers can interrupt the DSP. By using the
omap_dm_timer_request_by_cap() API, driver will now be able to allocate
a DMTIMER that can interrupt the DSP based upon this attribute and not require
the driver to know which instance has this capability.

DMTIMERs that have the ability to interrupt the DSP on OMAP devices are as
follows ...

- OMAP1 (OMAP5912/16xx/17xx) devices	- All 8 DMTIMERs
- OMAP2/3/4 devices			- DMTIMERs 5-8

Please note that for OMAP3+, timer8 has the ability to interrupt the DSP and
generate a PWM output.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap1/timer.c                        |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   15 ++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index aa81593..cdeb9d3 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -141,7 +141,7 @@ static int __init omap1_dm_timer_init(void)
 
 		pdata->set_timer_src = omap1_dm_timer_set_src;
 		pdata->timer_capability = OMAP_TIMER_ALWON |
-				OMAP_TIMER_NEEDS_RESET;
+				OMAP_TIMER_NEEDS_RESET | OMAP_TIMER_HAS_DSP_IRQ;
 
 		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret) {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..efd0004 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -222,6 +222,11 @@ static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
 	.timer_capability       = OMAP_TIMER_HAS_PWM,
 };
 
+/* timers with DSP interrupt dev attribute */
+static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
+};
+
 /* timer1 */
 
 struct omap_hwmod omap2xxx_timer1_hwmod = {
@@ -310,6 +315,7 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -328,6 +334,7 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -346,6 +353,7 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
@@ -364,6 +372,7 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9e3820..88a4cea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -161,6 +161,16 @@ static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
 	.timer_capability	= OMAP_TIMER_HAS_PWM,
 };
 
+/* timers with DSP interrupt dev attribute */
+static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
+};
+
+/* pwm timers with DSP interrupt dev attribute */
+static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ | OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.name		= "timer1",
@@ -244,6 +254,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -261,6 +272,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -278,6 +290,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
@@ -295,7 +308,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT8_SHIFT,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
+	.dev_attr	= &capability_dsp_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..09683bb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2902,6 +2902,16 @@ static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
 	.timer_capability	= OMAP_TIMER_HAS_PWM,
 };
 
+/* timers with DSP interrupt dev attribute */
+static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ,
+};
+
+/* pwm timers with DSP interrupt dev attribute */
+static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ | OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
 	{ .irq = 37 + OMAP44XX_IRQ_GIC_START },
@@ -3006,6 +3016,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer6 */
@@ -3028,6 +3039,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer7 */
@@ -3049,6 +3061,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.dev_attr	= &capability_dsp_dev_attr,
 };
 
 /* timer8 */
@@ -3070,7 +3083,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &capability_pwm_dev_attr,
+	.dev_attr	= &capability_dsp_pwm_dev_attr,
 };
 
 /* timer9 */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 19e7fa5..85868e9 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -60,6 +60,7 @@
 #define OMAP_TIMER_ALWON				0x40000000
 #define OMAP_TIMER_HAS_PWM				0x20000000
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
+#define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
 
 struct omap_timer_capability_dev_attr {
 	u32 timer_capability;
-- 
1.7.9.5

