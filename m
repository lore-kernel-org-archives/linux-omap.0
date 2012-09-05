From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 05/10] ARM: OMAP2+: Don't use __omap_dm_timer_reset()
Date: Wed, 5 Sep 2012 14:04:27 -0500
Message-ID: <1346871872-24413-6-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005Ab2IETEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:53 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
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
index d094285..e64df71 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -62,6 +62,7 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact       = CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -239,6 +240,7 @@ struct omap_hwmod omap2xxx_timer1_hwmod = {
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer2 */
@@ -257,6 +259,7 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer3 */
@@ -275,6 +278,7 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer4 */
@@ -293,6 +297,7 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer5 */
@@ -311,6 +316,7 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer6 */
@@ -329,6 +335,7 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer7 */
@@ -347,6 +354,7 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer8 */
@@ -365,6 +373,7 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer9 */
@@ -384,6 +393,7 @@ struct omap_hwmod omap2xxx_timer9_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer10 */
@@ -403,6 +413,7 @@ struct omap_hwmod omap2xxx_timer10_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer11 */
@@ -422,6 +433,7 @@ struct omap_hwmod omap2xxx_timer11_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
@@ -441,6 +453,7 @@ struct omap_hwmod omap2xxx_timer12_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap2xxx_timer_hwmod_class,
+	.flags          = HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5f0b2ee..4b02440 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -124,6 +124,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -163,6 +164,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer2 */
@@ -180,6 +182,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer3 */
@@ -197,6 +200,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer4 */
@@ -214,6 +218,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer5 */
@@ -231,6 +236,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer6 */
@@ -248,6 +254,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer7 */
@@ -265,6 +272,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 		},
 	},
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer8 */
@@ -283,6 +291,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer9 */
@@ -301,6 +310,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer10 */
@@ -319,6 +329,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer11 */
@@ -337,6 +348,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /* timer12 */
@@ -360,6 +372,7 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	},
 	.dev_attr	= &capability_secure_dev_attr,
 	.class		= &omap3xxx_timer_hwmod_class,
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..e486ebd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2869,6 +2869,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -2912,6 +2913,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.main_clk	= "timer1_fck",
 	.prcm = {
@@ -2934,6 +2936,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer2_irqs,
 	.main_clk	= "timer2_fck",
 	.prcm = {
@@ -3105,6 +3108,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer10_irqs,
 	.main_clk	= "timer10_fck",
 	.prcm = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e24ee0f..1ee67a3 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -193,7 +193,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		}
 	}
 	__omap_dm_timer_init_regs(timer);
-	__omap_dm_timer_reset(timer, 1, 1);
 	__omap_dm_timer_enable_posted(timer);
 
 	timer->rate = clk_get_rate(timer->fclk);
-- 
1.7.9.5

