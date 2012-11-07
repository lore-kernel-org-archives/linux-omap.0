From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 07/14] ARM: OMAP2+: Don't use __omap_dm_timer_reset()
Date: Wed, 7 Nov 2012 13:01:23 -0600
Message-ID: <1352314890-22224-8-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36390 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278Ab2KGTBw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:52 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently OMAP2+ devices are using the function __omap_dm_timer_reset() to
configure the clock-activity, idle, wakeup-enable and auto-idle fields in the
timer OCP_CFG register. The name of the function is mis-leading because this
function does not actually perform a reset of the timer.

For OMAP2+ devices, HWMOD is responsible for reseting and configuring the
timer OCP_CFG register. Therefore, do not use __omap_dm_timer_reset() for
OMAP2+ devices and rely on HWMOD. Furthermore, some timer instances do not
have the fields clock-activity, wakeup-enable and auto-idle and so this
function could configure the OCP_CFG register incorrectly.

Currently HWMOD is not configuring the clock-activity field in the OCP_CFG
register for timers that have this field. Commit 0f0d080 (ARM: OMAP: DMTimer:
Use posted mode) configures the clock-activity field to keep the f-clk enabled
so that the wake-up capability is enabled. Therefore, add the appropriate flags
to the timer HWMOD structures to configure this field in the same way.

For OMAP2/3 devices all dmtimers have the clock-activity field, where as for
OMAP4 devices, only dmtimer 1, 2 and 10 have the clock-activity field.

Verified on OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda that HWMOD is
configuring the dmtimer OCP_CFG register as expected for clock-events timer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 ++++
 arch/arm/mach-omap2/timer.c                        |    1 -
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 8c3b3f0..043b952 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -60,6 +60,7 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact       = CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -268,6 +269,7 @@ struct omap_hwmod omap2xxx_timer1_hwmod = {
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer2 */
@@ -286,6 +288,7 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer3 */
@@ -304,6 +307,7 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer4 */
@@ -322,6 +326,7 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer5 */
@@ -341,6 +346,7 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer6 */
@@ -360,6 +366,7 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer7 */
@@ -379,6 +386,7 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer8 */
@@ -398,6 +406,7 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer9 */
@@ -417,6 +426,7 @@ struct omap_hwmod omap2xxx_timer9_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer10 */
@@ -436,6 +446,7 @@ struct omap_hwmod omap2xxx_timer10_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer11 */
@@ -455,6 +466,7 @@ struct omap_hwmod omap2xxx_timer11_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
@@ -474,6 +486,7 @@ struct omap_hwmod omap2xxx_timer12_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 306c627..9cdbd3c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -158,6 +158,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -207,6 +208,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer2 */
@@ -224,6 +226,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer3 */
@@ -241,6 +244,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer4 */
@@ -258,6 +262,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer5 */
@@ -276,6 +281,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer6 */
@@ -294,6 +300,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer7 */
@@ -312,6 +319,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer8 */
@@ -330,6 +338,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	},
 	.dev_attr	= &capability_dsp_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer9 */
@@ -348,6 +357,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer10 */
@@ -366,6 +376,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer11 */
@@ -384,6 +395,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
@@ -407,6 +419,7 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	},
 	.dev_attr	= &capability_secure_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..e1f652f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3066,6 +3066,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -3119,6 +3120,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.main_clk	= "timer1_fck",
 	.prcm = {
@@ -3141,6 +3143,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer2_irqs,
 	.main_clk	= "timer2_fck",
 	.prcm = {
@@ -3315,6 +3318,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer10_irqs,
 	.main_clk	= "timer10_fck",
 	.prcm = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8b0068c..b9b6f21 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -327,7 +327,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 	__omap_dm_timer_init_regs(timer);
-	__omap_dm_timer_reset(timer, 1, 1);
 
 	if (posted)
 		omap_dm_timer_enable_posted(timer);
-- 
1.7.9.5

