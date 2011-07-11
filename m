From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 04/12] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 11 Jul 2011 16:59:11 +0530
Message-ID: <1310383759-19059-5-git-send-email-tarun.kanti@ti.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042Ab1GKMtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 08:49:17 -0400
In-Reply-To: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add routines to converts dmtimers to platform devices. The device data
is obtained from hwmod database of respective platform and is registered
to device model after successful binding to driver.
In addition, capability attribute of each of the timers is added in
hwmod database.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 +++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 +++++
 arch/arm/mach-omap2/timer.c                |  136 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h  |   10 ++-
 6 files changed, 237 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c4d0ae8..f9594c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -358,6 +358,16 @@ static struct omap_hwmod_class omap2420_timer_hwmod_class = {
 	.rev = OMAP_TIMER_IP_VERSION_1,
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
 static struct omap_hwmod_irq_info omap2420_timer1_mpu_irqs[] = {
@@ -402,6 +412,7 @@ static struct omap_hwmod omap2420_timer1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer1_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -452,6 +463,7 @@ static struct omap_hwmod omap2420_timer2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer2_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -502,6 +514,7 @@ static struct omap_hwmod omap2420_timer3_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer3_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -552,6 +565,7 @@ static struct omap_hwmod omap2420_timer4_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer4_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -602,6 +616,7 @@ static struct omap_hwmod omap2420_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer5_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -653,6 +668,7 @@ static struct omap_hwmod omap2420_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer6_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -703,6 +719,7 @@ static struct omap_hwmod omap2420_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer7_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -753,6 +770,7 @@ static struct omap_hwmod omap2420_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2420_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer8_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -803,6 +821,7 @@ static struct omap_hwmod omap2420_timer9_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer9_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -853,6 +872,7 @@ static struct omap_hwmod omap2420_timer10_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer10_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -903,6 +923,7 @@ static struct omap_hwmod omap2420_timer11_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer11_slaves),
 	.class		= &omap2420_timer_hwmod_class,
@@ -953,6 +974,7 @@ static struct omap_hwmod omap2420_timer12_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2420_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer12_slaves),
 	.class		= &omap2420_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9682dd5..99167a1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -459,6 +459,16 @@ static struct omap_hwmod_class omap2430_timer_hwmod_class = {
 	.rev = OMAP_TIMER_IP_VERSION_1,
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
 static struct omap_hwmod_irq_info omap2430_timer1_mpu_irqs[] = {
@@ -503,6 +513,7 @@ static struct omap_hwmod omap2430_timer1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer1_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -553,6 +564,7 @@ static struct omap_hwmod omap2430_timer2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer2_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -603,6 +615,7 @@ static struct omap_hwmod omap2430_timer3_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer3_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -653,6 +666,7 @@ static struct omap_hwmod omap2430_timer4_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer4_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -703,6 +717,7 @@ static struct omap_hwmod omap2430_timer5_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer5_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -753,6 +768,7 @@ static struct omap_hwmod omap2430_timer6_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer6_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -803,6 +819,7 @@ static struct omap_hwmod omap2430_timer7_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer7_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -853,6 +870,7 @@ static struct omap_hwmod omap2430_timer8_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap2430_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer8_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -903,6 +921,7 @@ static struct omap_hwmod omap2430_timer9_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer9_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -953,6 +972,7 @@ static struct omap_hwmod omap2430_timer10_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer10_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -1003,6 +1023,7 @@ static struct omap_hwmod omap2430_timer11_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer11_slaves),
 	.class		= &omap2430_timer_hwmod_class,
@@ -1053,6 +1074,7 @@ static struct omap_hwmod omap2430_timer12_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap2430_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer12_slaves),
 	.class		= &omap2430_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 909a84d..7e621dd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -609,6 +609,21 @@ static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
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
 static struct omap_hwmod_irq_info omap3xxx_timer1_mpu_irqs[] = {
@@ -653,6 +668,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer1_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -703,6 +719,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer2_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -753,6 +770,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT3_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer3_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -803,6 +821,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT4_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer4_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -853,6 +872,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer5_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -903,6 +923,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer6_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -953,6 +974,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap3xxx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer7_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1003,6 +1025,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT8_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer8_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1053,6 +1076,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT9_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer9_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1103,6 +1127,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT10_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer10_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
@@ -1153,6 +1178,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT11_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap3xxx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer11_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
@@ -1203,6 +1229,7 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT12_SHIFT,
 		},
 	},
+	.dev_attr	= &capability_secure_dev_attr,
 	.slaves		= omap3xxx_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer12_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index be8ef2c..cbfa1b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4014,6 +4014,16 @@ static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.rev    = OMAP_TIMER_IP_VERSION_2,
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
@@ -4054,6 +4064,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4099,6 +4110,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4144,6 +4156,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4189,6 +4202,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4253,6 +4267,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer5_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4317,6 +4332,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer6_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4381,6 +4397,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_alwon_dev_attr,
 	.slaves		= omap44xx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer7_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4445,6 +4462,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer8_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4490,6 +4508,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4535,6 +4554,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4580,6 +4600,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
 		},
 	},
+	.dev_attr	= &capability_pwm_dev_attr,
 	.slaves		= omap44xx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e964072..1a06029 100644
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
 
@@ -340,3 +342,137 @@ static void __init omap4_timer_init(void)
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
+		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
+			parent_name = "alt_ck";
+			break;
+		}
+		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
+			__func__, __LINE__);
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
+	pdata->timer_ip_type = oh->class->rev;
+	pdata->needs_manual_reset = 0;
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
index e5d4b4f..400fe3c 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/dmtimer.h
+ * arch/arm/plat-omap/include/plat/dmtimer.h
  *
  * OMAP Dual-Mode Timers
  *
@@ -61,6 +61,14 @@
 #define OMAP_TIMER_IP_VERSION_1			0x1
 #define OMAP_TIMER_IP_VERSION_2			0x2
 
+/* timer capabilities used in hwmod database */
+#define OMAP_TIMER_SECURE				0x80000000
+#define OMAP_TIMER_ALWON				0x40000000
+#define OMAP_TIMER_HAS_PWM				0x20000000
+
+struct omap_timer_capability_dev_attr {
+	u32 timer_capability;
+};
 struct omap_dm_timer;
 struct clk;
 
-- 
1.6.0.4

