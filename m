From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v13 04/11] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 25 Apr 2011 15:08:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037AD277AD@dbde02.ent.ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
 <1302969063-8231-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277ADdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144Ab1DYJii (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Apr 2011 05:38:38 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3P9cZqJ007460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 04:38:37 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p3P9cXLv013174
	for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 15:08:34 +0530 (IST)
In-Reply-To: <1302969063-8231-5-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>

--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277ADdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add routines to converts dmtimers to platform devices. The device data
is obtained from hwmod database of respective platform and is registered
to device model after successful binding to driver.
In addition, capability attribute of each of the timers is added in
hwmod database.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
Missed adding capability attribute to timer11.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 +++++
 arch/arm/mach-omap2/timer.c                |  158 ++++++++++++++++++++++++=
+++-
 arch/arm/plat-omap/dmtimer.c               |   17 ---
 arch/arm/plat-omap/include/plat/dmtimer.h  |   13 ++-
 7 files changed, 266 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index 8eb3ce1..1f7cb36 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -358,6 +358,16 @@ static struct omap_hwmod_class omap2420_timer_hwmod_cl=
ass =3D {
        .rev =3D OMAP_TIMER_IP_VERSION_1,
 };

+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr =3D=
 {
+       .timer_capability       =3D OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D {
+       .timer_capability       =3D OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap2420_timer1_hwmod;
 static struct omap_hwmod_irq_info omap2420_timer1_mpu_irqs[] =3D {
@@ -402,6 +412,7 @@ static struct omap_hwmod omap2420_timer1_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT1_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer1_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer1_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -452,6 +463,7 @@ static struct omap_hwmod omap2420_timer2_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT2_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer2_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer2_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -502,6 +514,7 @@ static struct omap_hwmod omap2420_timer3_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT3_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer3_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer3_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -552,6 +565,7 @@ static struct omap_hwmod omap2420_timer4_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT4_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer4_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer4_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -602,6 +616,7 @@ static struct omap_hwmod omap2420_timer5_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT5_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer5_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer5_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -653,6 +668,7 @@ static struct omap_hwmod omap2420_timer6_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT6_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer6_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer6_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -703,6 +719,7 @@ static struct omap_hwmod omap2420_timer7_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT7_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer7_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer7_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -753,6 +770,7 @@ static struct omap_hwmod omap2420_timer8_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT8_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2420_timer8_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer8_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -803,6 +821,7 @@ static struct omap_hwmod omap2420_timer9_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT9_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2420_timer9_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer9_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -853,6 +872,7 @@ static struct omap_hwmod omap2420_timer10_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT10_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2420_timer10_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer10_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -903,6 +923,7 @@ static struct omap_hwmod omap2420_timer11_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT11_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2420_timer11_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer11_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
@@ -953,6 +974,7 @@ static struct omap_hwmod omap2420_timer12_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT12_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2420_timer12_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2420_timer12_slaves),
        .class          =3D &omap2420_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2430_data.c
index a860fb5..d7c6487 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -459,6 +459,16 @@ static struct omap_hwmod_class omap2430_timer_hwmod_cl=
ass =3D {
        .rev =3D OMAP_TIMER_IP_VERSION_1,
 };

+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr =3D=
 {
+       .timer_capability       =3D OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D {
+       .timer_capability       =3D OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap2430_timer1_hwmod;
 static struct omap_hwmod_irq_info omap2430_timer1_mpu_irqs[] =3D {
@@ -503,6 +513,7 @@ static struct omap_hwmod omap2430_timer1_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT1_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer1_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer1_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -553,6 +564,7 @@ static struct omap_hwmod omap2430_timer2_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT2_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer2_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer2_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -603,6 +615,7 @@ static struct omap_hwmod omap2430_timer3_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT3_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer3_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer3_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -653,6 +666,7 @@ static struct omap_hwmod omap2430_timer4_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT4_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer4_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer4_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -703,6 +717,7 @@ static struct omap_hwmod omap2430_timer5_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT5_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer5_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer5_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -753,6 +768,7 @@ static struct omap_hwmod omap2430_timer6_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT6_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer6_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer6_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -803,6 +819,7 @@ static struct omap_hwmod omap2430_timer7_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT7_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer7_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer7_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -853,6 +870,7 @@ static struct omap_hwmod omap2430_timer8_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT8_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap2430_timer8_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer8_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -903,6 +921,7 @@ static struct omap_hwmod omap2430_timer9_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT9_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2430_timer9_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer9_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -953,6 +972,7 @@ static struct omap_hwmod omap2430_timer10_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT10_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2430_timer10_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer10_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -1003,6 +1023,7 @@ static struct omap_hwmod omap2430_timer11_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT11_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2430_timer11_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer11_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
@@ -1053,6 +1074,7 @@ static struct omap_hwmod omap2430_timer12_hwmod =3D {
                        .idlest_idle_bit =3D OMAP24XX_ST_GPT12_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap2430_timer12_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap2430_timer12_slaves),
        .class          =3D &omap2430_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index b98e2df..7fb2ecc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -609,6 +609,21 @@ static struct omap_hwmod_class omap3xxx_timer_hwmod_cl=
ass =3D {
        .rev =3D  OMAP_TIMER_IP_VERSION_1,
 };

+/* secure timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_secure_dev_attr =
=3D {
+       .timer_capability       =3D OMAP_TIMER_SECURE,
+};
+
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr =3D=
 {
+       .timer_capability       =3D OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D {
+       .timer_capability       =3D OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod;
 static struct omap_hwmod_irq_info omap3xxx_timer1_mpu_irqs[] =3D {
@@ -653,6 +668,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT1_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer1_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer1_slaves),
        .class          =3D &omap3xxx_timer_1ms_hwmod_class,
@@ -703,6 +719,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT2_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer2_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer2_slaves),
        .class          =3D &omap3xxx_timer_1ms_hwmod_class,
@@ -753,6 +770,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT3_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer3_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer3_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -803,6 +821,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT4_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer4_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer4_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -853,6 +872,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT5_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer5_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer5_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -903,6 +923,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT6_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer6_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer6_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -953,6 +974,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT7_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap3xxx_timer7_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer7_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -1003,6 +1025,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT8_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap3xxx_timer8_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer8_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -1053,6 +1076,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT9_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap3xxx_timer9_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer9_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -1103,6 +1127,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT10_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap3xxx_timer10_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer10_slaves),
        .class          =3D &omap3xxx_timer_1ms_hwmod_class,
@@ -1153,6 +1178,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT11_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap3xxx_timer11_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer11_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
@@ -1203,6 +1229,7 @@ static struct omap_hwmod omap3xxx_timer12_hwmod =3D {
                        .idlest_idle_bit =3D OMAP3430_ST_GPT12_SHIFT,
                },
        },
+       .dev_attr       =3D &capability_secure_dev_attr,
        .slaves         =3D omap3xxx_timer12_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap3xxx_timer12_slaves),
        .class          =3D &omap3xxx_timer_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 6485c90..38d5848 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4014,6 +4014,21 @@ static struct omap_hwmod_class omap44xx_timer_hwmod_=
class =3D {
        .rev    =3D OMAP_TIMER_IP_VERSION_2,
 };

+/* secure timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_secure_dev_attr =
=3D {
+       .timer_capability       =3D OMAP_TIMER_SECURE,
+};
+
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr =3D=
 {
+       .timer_capability       =3D OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr =3D {
+       .timer_capability       =3D OMAP_TIMER_HAS_PWM,
+};
+
 /* timer1 */
 static struct omap_hwmod omap44xx_timer1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] =3D {
@@ -4054,6 +4069,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer1_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer1_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4099,6 +4115,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL=
,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer2_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer2_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4144,6 +4161,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL=
,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer3_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer3_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4189,6 +4207,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL=
,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer4_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer4_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4253,6 +4272,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer5_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer5_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4317,6 +4337,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer6_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer6_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4381,6 +4402,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
                },
        },
+       .dev_attr       =3D &capability_alwon_dev_attr,
        .slaves         =3D omap44xx_timer7_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer7_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4445,6 +4467,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap44xx_timer8_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer8_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4490,6 +4513,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL=
,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap44xx_timer9_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer9_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4535,6 +4559,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER10_CLKCTR=
L,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap44xx_timer10_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer10_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -4580,6 +4605,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod =3D {
                        .clkctrl_reg =3D OMAP4430_CM_L4PER_DMTIMER11_CLKCTR=
L,
                },
        },
+       .dev_attr       =3D &capability_pwm_dev_attr,
        .slaves         =3D omap44xx_timer11_slaves,
        .slaves_cnt     =3D ARRAY_SIZE(omap44xx_timer11_slaves),
        .omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2edeb1a..1c80337 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/timer-gp.c
+ * linux/arch/arm/mach-omap2/timer.c
  *
  * OMAP2 GP timer support.
  *
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

@@ -129,6 +131,23 @@ static struct clock_event_device clockevent_gpt =3D {
        .set_mode       =3D omap2_gp_timer_set_mode,
 };

+int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
+{
+       int ret;
+
+       clk_disable(timer_fck);
+       ret =3D clk_set_parent(timer_fck, parent);
+       clk_enable(timer_fck);
+
+       /*
+        * When the functional clock disappears, too quick writes seem
+        * to cause an abort. XXX Is this still necessary?
+        */
+       __delay(300000);
+
+       return ret;
+}
+
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
                                                int gptimer_id,
                                                const char *fck_source)
@@ -359,3 +378,140 @@ struct sys_timer omap4_timer =3D {
        .init   =3D omap4_timer_init,
 };
 #endif
+
+/**
+ * omap2_dm_timer_set_src - change the timer input clock source
+ * @pdev:      timer platform device pointer
+ * @source:    array index of parent clock source
+ */
+static int omap2_dm_timer_set_src(struct platform_device *pdev, int source=
)
+{
+       int ret;
+       struct dmtimer_platform_data *pdata =3D pdev->dev.platform_data;
+       struct clk *fclk, *new_fclk;
+       char *new_fclk_name =3D NULL;
+
+       fclk =3D clk_get(&pdev->dev, "fck");
+       if (IS_ERR_OR_NULL(fclk)) {
+               dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
+                               __func__, __LINE__);
+               return -EINVAL;
+       }
+
+       switch (source) {
+       case OMAP_TIMER_SRC_SYS_CLK:
+               new_fclk_name =3D "sys_ck";
+               break;
+
+       case OMAP_TIMER_SRC_32_KHZ:
+               if (unlikely(cpu_is_omap2420()))
+                       new_fclk_name =3D "func_32k_ck";
+               else
+                       new_fclk_name =3D "32k_ck";
+               break;
+
+       case OMAP_TIMER_SRC_EXT_CLK:
+               if (pdata->timer_ip_type =3D=3D OMAP_TIMER_IP_VERSION_1) {
+                       new_fclk_name =3D "alt_ck";
+                       break;
+               }
+               dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
+                       __func__, __LINE__);
+               return -EINVAL;
+       }
+
+       new_fclk =3D clk_get(&pdev->dev, new_fclk_name);
+       if (IS_ERR_OR_NULL(new_fclk)) {
+               dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
+                       __func__, __LINE__, new_fclk_name);
+               clk_put(fclk);
+               return -EINVAL;
+       }
+
+       ret =3D clk_set_parent(fclk, new_fclk);
+       if (IS_ERR_VALUE(ret)) {
+               dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
+                       __func__, new_fclk_name);
+               ret =3D -EINVAL;
+       }
+
+       clk_put(new_fclk);
+       clk_put(fclk);
+
+       return ret;
+}
+
+struct omap_device_pm_latency omap2_dmtimer_latency[] =3D {
+       {
+               .deactivate_func =3D omap_device_idle_hwmods,
+               .activate_func   =3D omap_device_enable_hwmods,
+               .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+       },
+};
+
+/**
+ * omap_timer_init - build and register timer device with an
+ * associated timer hwmod
+ * @oh:        timer hwmod pointer to be used to build timer device
+ * @user:      parameter that can be passed from calling hwmod API
+ *
+ * Called by omap_hwmod_for_each_by_class to register each of the timer
+ * devices present in the system. The number of timer devices is known
+ * by parsing through the hwmod database for a given class name. At the
+ * end of function call memory is allocated for timer device and it is
+ * registered to the framework ready to be proved by the driver.
+ */
+static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
+{
+       int id;
+       int ret =3D 0;
+       char *name =3D "omap_timer";
+       struct dmtimer_platform_data *pdata;
+       struct omap_device *od;
+       struct omap_timer_capability_dev_attr *timer_dev_attr;
+
+       pr_debug("%s: %s\n", __func__, oh->name);
+
+       /* on secure device, do not register secure timer */
+       timer_dev_attr =3D oh->dev_attr;
+       if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP && timer_dev_attr)
+               if (timer_dev_attr->timer_capability =3D=3D OMAP_TIMER_SECU=
RE)
+                       return ret;
+
+       pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
+       if (!pdata) {
+               pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+               return -ENOMEM;
+       }
+
+       /*
+        * Extract the IDs from name field in hwmod database
+        * and use the same for constructing ids' for the
+        * timer devices. In a way, we are avoiding usage of
+        * static variable witin the function to do the same.
+        * CAUTION: We have to be careful and make sure the
+        * name in hwmod database does not change in which case
+        * we might either make corresponding change here or
+        * switch back static variable mechanism.
+        */
+       sscanf(oh->name, "timer%2d", &id);
+
+       pdata->set_timer_src =3D omap2_dm_timer_set_src;
+       pdata->timer_ip_type =3D oh->class->rev;
+       pdata->needs_manual_reset =3D 0;
+
+       od =3D omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+                       omap2_dmtimer_latency,
+                       ARRAY_SIZE(omap2_dmtimer_latency),
+                       0);
+
+       if (IS_ERR(od)) {
+               pr_err("%s: Can't build omap_device for %s: %s.\n",
+                       __func__, name, oh->name);
+               ret =3D -EINVAL;
+       }
+
+       kfree(pdata);
+
+       return ret;
+}
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a88fcdd..0f3e9c9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -427,23 +427,6 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);

-int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
-{
-       int ret;
-
-       clk_disable(timer_fck);
-       ret =3D clk_set_parent(timer_fck, parent);
-       clk_enable(timer_fck);
-
-       /*
-        * When the functional clock disappears, too quick writes seem
-        * to cause an abort. XXX Is this still necessary?
-        */
-       __delay(300000);
-
-       return ret;
-}
-
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
        if (source < 0 || source >=3D 3)
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap=
/include/plat/dmtimer.h
index 1b76450..00e1a4f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/dmtimer.h
+ * arch/arm/plat-omap/include/plat/dmtimer.h
  *
  * OMAP Dual-Mode Timers
  *
@@ -35,6 +35,8 @@
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H

+#include <linux/platform_device.h>
+
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK                 0x00
 #define OMAP_TIMER_SRC_32_KHZ                  0x01
@@ -57,6 +59,15 @@
 #define OMAP_TIMER_IP_VERSION_1                        0x1
 #define OMAP_TIMER_IP_VERSION_2                        0x2

+/* timer capabilities used in hwmod database */
+#define OMAP_TIMER_SECURE                              0x80000000
+#define OMAP_TIMER_ALWON                               0x40000000
+#define OMAP_TIMER_HAS_PWM                             0x20000000
+
+struct omap_timer_capability_dev_attr {
+       u32 timer_capability;
+};
+
 extern struct omap_dm_timer *gptimer_wakeup;
 struct clk;

--
1.6.0.4


--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277ADdbde02enttico_
Content-Type: application/octet-stream;
	name="0004-OMAP2-dmtimer-convert-to-platform-devices.patch"
Content-Description: 0004-OMAP2-dmtimer-convert-to-platform-devices.patch
Content-Disposition: attachment;
	filename="0004-OMAP2-dmtimer-convert-to-platform-devices.patch"; size=26152;
	creation-date="Mon, 18 Apr 2011 15:35:12 GMT";
	modification-date="Mon, 18 Apr 2011 15:35:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNjIxNDM5NjFiZTNlMTYyMzQwMDMyZWE3MTRkZmE2N2E1M2RlNjg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYXJ1biBLYW50aSBEZWJCYXJtYSA8dGFydW4ua2FudGlAdGku
Y29tPgpEYXRlOiBNb24sIDE4IEFwciAyMDExIDE1OjMzOjU5ICswNTMwClN1YmplY3Q6IFtQQVRD
SCB2MTQgMDQvMTJdIE9NQVAyKzogZG10aW1lcjogY29udmVydCB0byBwbGF0Zm9ybSBkZXZpY2Vz
CgpBZGQgcm91dGluZXMgdG8gY29udmVydHMgZG10aW1lcnMgdG8gcGxhdGZvcm0gZGV2aWNlcy4g
VGhlIGRldmljZSBkYXRhCmlzIG9idGFpbmVkIGZyb20gaHdtb2QgZGF0YWJhc2Ugb2YgcmVzcGVj
dGl2ZSBwbGF0Zm9ybSBhbmQgaXMgcmVnaXN0ZXJlZAp0byBkZXZpY2UgbW9kZWwgYWZ0ZXIgc3Vj
Y2Vzc2Z1bCBiaW5kaW5nIHRvIGRyaXZlci4KSW4gYWRkaXRpb24sIGNhcGFiaWxpdHkgYXR0cmli
dXRlIG9mIGVhY2ggb2YgdGhlIHRpbWVycyBpcyBhZGRlZCBpbgpod21vZCBkYXRhYmFzZS4KClNp
Z25lZC1vZmYtYnk6IFRhcnVuIEthbnRpIERlYkJhcm1hIDx0YXJ1bi5rYW50aUB0aS5jb20+ClNp
Z25lZC1vZmYtYnk6IFRoYXJhIEdvcGluYXRoIDx0aGFyYUB0aS5jb20+CkFja2VkLWJ5OiBDb3Vz
c29uLCBCZW5vaXQgPGItY291c3NvbkB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9v
bWFwX2h3bW9kXzI0MjBfZGF0YS5jIHwgICAyMiArKysrCiBhcmNoL2FybS9tYWNoLW9tYXAyL29t
YXBfaHdtb2RfMjQzMF9kYXRhLmMgfCAgIDIyICsrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvb21h
cF9od21vZF8zeHh4X2RhdGEuYyB8ICAgMjcgKysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvb21h
cF9od21vZF80NHh4X2RhdGEuYyB8ICAgMjYgKysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvdGlt
ZXIuYyAgICAgICAgICAgICAgICB8ICAxNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrLQog
YXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYyAgICAgICAgICAgICAgIHwgICAxNyAtLS0KIGFy
Y2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvZG10aW1lci5oICB8ICAgMTMgKystCiA3IGZp
bGVzIGNoYW5nZWQsIDI2NiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfMjQyMF9kYXRhLmMgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfMjQyMF9kYXRhLmMKaW5kZXggOGViM2NlMS4uMWY3Y2Iz
NiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzI0MjBfZGF0YS5j
CisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF8yNDIwX2RhdGEuYwpAQCAtMzU4
LDYgKzM1OCwxNiBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2RfY2xhc3Mgb21hcDI0MjBfdGlt
ZXJfaHdtb2RfY2xhc3MgPSB7CiAJLnJldiA9IE9NQVBfVElNRVJfSVBfVkVSU0lPTl8xLAogfTsK
IAorLyogYWx3YXlzLW9uIHRpbWVycyBkZXYgYXR0cmlidXRlICovCitzdGF0aWMgc3RydWN0IG9t
YXBfdGltZXJfY2FwYWJpbGl0eV9kZXZfYXR0ciBjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyID0g
eworCS50aW1lcl9jYXBhYmlsaXR5ICAgICAgID0gT01BUF9USU1FUl9BTFdPTiwKK307CisKKy8q
IHB3bSB0aW1lcnMgZGV2IGF0dHJpYnV0ZSAqLworc3RhdGljIHN0cnVjdCBvbWFwX3RpbWVyX2Nh
cGFiaWxpdHlfZGV2X2F0dHIgY2FwYWJpbGl0eV9wd21fZGV2X2F0dHIgPSB7CisJLnRpbWVyX2Nh
cGFiaWxpdHkgICAgICAgPSBPTUFQX1RJTUVSX0hBU19QV00sCit9OworCiAvKiB0aW1lcjEgKi8K
IHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwMjQyMF90aW1lcjFfaHdtb2Q7CiBzdGF0aWMg
c3RydWN0IG9tYXBfaHdtb2RfaXJxX2luZm8gb21hcDI0MjBfdGltZXIxX21wdV9pcnFzW10gPSB7
CkBAIC00MDIsNiArNDEyLDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAyNDIwX3Rp
bWVyMV9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9TVF9HUFQxX1NI
SUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyICAgICAgID0gJmNhcGFiaWxpdHlfYWx3b25fZGV2
X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwMjQyMF90aW1lcjFfc2xhdmVzLAogCS5zbGF2ZXNfY250
CT0gQVJSQVlfU0laRShvbWFwMjQyMF90aW1lcjFfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAy
NDIwX3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtNDUyLDYgKzQ2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
b21hcF9od21vZCBvbWFwMjQyMF90aW1lcjJfaHdtb2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVfYml0
ID0gT01BUDI0WFhfU1RfR1BUMl9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0ciAgICAgICA9
ICZjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MjBfdGltZXIy
X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDI0MjBfdGltZXIyX3NsYXZl
cyksCiAJLmNsYXNzCQk9ICZvbWFwMjQyMF90aW1lcl9od21vZF9jbGFzcywKQEAgLTUwMiw2ICs1
MTQsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MjBfdGltZXIzX2h3bW9kID0g
ewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDNfU0hJRlQsCiAJCX0sCiAJ
fSwKKwkuZGV2X2F0dHIgICAgICAgPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xh
dmVzCQk9IG9tYXAyNDIwX3RpbWVyM19zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpF
KG9tYXAyNDIwX3RpbWVyM19zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDI0MjBfdGltZXJfaHdt
b2RfY2xhc3MsCkBAIC01NTIsNiArNTY1LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9t
YXAyNDIwX3RpbWVyNF9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9T
VF9HUFQ0X1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyICAgICAgID0gJmNhcGFiaWxpdHlf
YWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwMjQyMF90aW1lcjRfc2xhdmVzLAogCS5z
bGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwMjQyMF90aW1lcjRfc2xhdmVzKSwKIAkuY2xhc3MJ
CT0gJm9tYXAyNDIwX3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtNjAyLDYgKzYxNiw3IEBAIHN0YXRp
YyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwMjQyMF90aW1lcjVfaHdtb2QgPSB7CiAJCQkuaWRsZXN0
X2lkbGVfYml0ID0gT01BUDI0WFhfU1RfR1BUNV9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0
ciAgICAgICA9ICZjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0
MjBfdGltZXI1X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDI0MjBfdGlt
ZXI1X3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwMjQyMF90aW1lcl9od21vZF9jbGFzcywKQEAg
LTY1Myw2ICs2NjgsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MjBfdGltZXI2
X2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDZfU0hJRlQs
CiAJCX0sCiAJfSwKKwkuZGV2X2F0dHIgICAgICAgPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0
ciwKIAkuc2xhdmVzCQk9IG9tYXAyNDIwX3RpbWVyNl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBB
UlJBWV9TSVpFKG9tYXAyNDIwX3RpbWVyNl9zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDI0MjBf
dGltZXJfaHdtb2RfY2xhc3MsCkBAIC03MDMsNiArNzE5LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFw
X2h3bW9kIG9tYXAyNDIwX3RpbWVyN19od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBP
TUFQMjRYWF9TVF9HUFQ3X1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyICAgICAgID0gJmNh
cGFiaWxpdHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwMjQyMF90aW1lcjdfc2xh
dmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwMjQyMF90aW1lcjdfc2xhdmVzKSwK
IAkuY2xhc3MJCT0gJm9tYXAyNDIwX3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtNzUzLDYgKzc3MCw3
IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwMjQyMF90aW1lcjhfaHdtb2QgPSB7CiAJ
CQkuaWRsZXN0X2lkbGVfYml0ID0gT01BUDI0WFhfU1RfR1BUOF9TSElGVCwKIAkJfSwKIAl9LAor
CS5kZXZfYXR0ciAgICAgICA9ICZjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJ
CT0gb21hcDI0MjBfdGltZXI4X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21h
cDI0MjBfdGltZXI4X3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwMjQyMF90aW1lcl9od21vZF9j
bGFzcywKQEAgLTgwMyw2ICs4MjEsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0
MjBfdGltZXI5X2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQ
VDlfU0hJRlQsCiAJCX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9wd21fZGV2X2F0
dHIsCiAJLnNsYXZlcwkJPSBvbWFwMjQyMF90aW1lcjlfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0g
QVJSQVlfU0laRShvbWFwMjQyMF90aW1lcjlfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDIw
X3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtODUzLDYgKzg3Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21h
cF9od21vZCBvbWFwMjQyMF90aW1lcjEwX2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9
IE9NQVAyNFhYX1NUX0dQVDEwX1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFi
aWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MjBfdGltZXIxMF9zbGF2ZXMs
CiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDIwX3RpbWVyMTBfc2xhdmVzKSwKIAku
Y2xhc3MJCT0gJm9tYXAyNDIwX3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtOTAzLDYgKzkyMyw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwMjQyMF90aW1lcjExX2h3bW9kID0gewogCQkJ
LmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDExX1NISUZULAogCQl9LAogCX0sCisJ
LmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0
MjBfdGltZXIxMV9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDIwX3Rp
bWVyMTFfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDIwX3RpbWVyX2h3bW9kX2NsYXNzLApA
QCAtOTUzLDYgKzk3NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwMjQyMF90aW1l
cjEyX2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDEyX1NI
SUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAog
CS5zbGF2ZXMJCT0gb21hcDI0MjBfdGltZXIxMl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJB
WV9TSVpFKG9tYXAyNDIwX3RpbWVyMTJfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDIwX3Rp
bWVyX2h3bW9kX2NsYXNzLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3
bW9kXzI0MzBfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzI0MzBfZGF0
YS5jCmluZGV4IGE4NjBmYjUuLmQ3YzY0ODcgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21h
cDIvb21hcF9od21vZF8yNDMwX2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBf
aHdtb2RfMjQzMF9kYXRhLmMKQEAgLTQ1OSw2ICs0NTksMTYgQEAgc3RhdGljIHN0cnVjdCBvbWFw
X2h3bW9kX2NsYXNzIG9tYXAyNDMwX3RpbWVyX2h3bW9kX2NsYXNzID0gewogCS5yZXYgPSBPTUFQ
X1RJTUVSX0lQX1ZFUlNJT05fMSwKIH07CiAKKy8qIGFsd2F5cy1vbiB0aW1lcnMgZGV2IGF0dHJp
YnV0ZSAqLworc3RhdGljIHN0cnVjdCBvbWFwX3RpbWVyX2NhcGFiaWxpdHlfZGV2X2F0dHIgY2Fw
YWJpbGl0eV9hbHdvbl9kZXZfYXR0ciA9IHsKKwkudGltZXJfY2FwYWJpbGl0eSAgICAgICA9IE9N
QVBfVElNRVJfQUxXT04sCit9OworCisvKiBwd20gdGltZXJzIGRldiBhdHRyaWJ1dGUgKi8KK3N0
YXRpYyBzdHJ1Y3Qgb21hcF90aW1lcl9jYXBhYmlsaXR5X2Rldl9hdHRyIGNhcGFiaWxpdHlfcHdt
X2Rldl9hdHRyID0geworCS50aW1lcl9jYXBhYmlsaXR5ICAgICAgID0gT01BUF9USU1FUl9IQVNf
UFdNLAorfTsKKwogLyogdGltZXIxICovCiBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0
MzBfdGltZXIxX2h3bW9kOwogc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kX2lycV9pbmZvIG9tYXAy
NDMwX3RpbWVyMV9tcHVfaXJxc1tdID0gewpAQCAtNTAzLDYgKzUxMyw3IEBAIHN0YXRpYyBzdHJ1
Y3Qgb21hcF9od21vZCBvbWFwMjQzMF90aW1lcjFfaHdtb2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVf
Yml0ID0gT01BUDI0WFhfU1RfR1BUMV9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZj
YXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MzBfdGltZXIxX3Ns
YXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDI0MzBfdGltZXIxX3NsYXZlcyks
CiAJLmNsYXNzCQk9ICZvbWFwMjQzMF90aW1lcl9od21vZF9jbGFzcywKQEAgLTU1Myw2ICs1NjQs
NyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MzBfdGltZXIyX2h3bW9kID0gewog
CQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDJfU0hJRlQsCiAJCX0sCiAJfSwK
KwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9t
YXAyNDMwX3RpbWVyMl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDMw
X3RpbWVyMl9zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDI0MzBfdGltZXJfaHdtb2RfY2xhc3Ms
CkBAIC02MDMsNiArNjE1LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAyNDMwX3Rp
bWVyM19od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9TVF9HUFQzX1NI
SUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25fZGV2X2F0dHIs
CiAJLnNsYXZlcwkJPSBvbWFwMjQzMF90aW1lcjNfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJS
QVlfU0laRShvbWFwMjQzMF90aW1lcjNfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDMwX3Rp
bWVyX2h3bW9kX2NsYXNzLApAQCAtNjUzLDYgKzY2Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9o
d21vZCBvbWFwMjQzMF90aW1lcjRfaHdtb2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVfYml0ID0gT01B
UDI0WFhfU1RfR1BUNF9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5
X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MzBfdGltZXI0X3NsYXZlcywKIAku
c2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDI0MzBfdGltZXI0X3NsYXZlcyksCiAJLmNsYXNz
CQk9ICZvbWFwMjQzMF90aW1lcl9od21vZF9jbGFzcywKQEAgLTcwMyw2ICs3MTcsNyBAQCBzdGF0
aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MzBfdGltZXI1X2h3bW9kID0gewogCQkJLmlkbGVz
dF9pZGxlX2JpdCA9IE9NQVAyNFhYX1NUX0dQVDVfU0hJRlQsCiAJCX0sCiAJfSwKKwkuZGV2X2F0
dHIJPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9tYXAyNDMwX3Rp
bWVyNV9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDMwX3RpbWVyNV9z
bGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDI0MzBfdGltZXJfaHdtb2RfY2xhc3MsCkBAIC03NTMs
NiArNzY4LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAyNDMwX3RpbWVyNl9od21v
ZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9TVF9HUFQ2X1NISUZULAogCQl9
LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZl
cwkJPSBvbWFwMjQzMF90aW1lcjZfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShv
bWFwMjQzMF90aW1lcjZfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDMwX3RpbWVyX2h3bW9k
X2NsYXNzLApAQCAtODAzLDYgKzgxOSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFw
MjQzMF90aW1lcjdfaHdtb2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVfYml0ID0gT01BUDI0WFhfU1Rf
R1BUN19TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5X2Fsd29uX2Rl
dl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MzBfdGltZXI3X3NsYXZlcywKIAkuc2xhdmVzX2Nu
dAk9IEFSUkFZX1NJWkUob21hcDI0MzBfdGltZXI3X3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFw
MjQzMF90aW1lcl9od21vZF9jbGFzcywKQEAgLTg1Myw2ICs4NzAsNyBAQCBzdGF0aWMgc3RydWN0
IG9tYXBfaHdtb2Qgb21hcDI0MzBfdGltZXI4X2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2Jp
dCA9IE9NQVAyNFhYX1NUX0dQVDhfU0hJRlQsCiAJCX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2Fw
YWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9tYXAyNDMwX3RpbWVyOF9zbGF2
ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDMwX3RpbWVyOF9zbGF2ZXMpLAog
CS5jbGFzcwkJPSAmb21hcDI0MzBfdGltZXJfaHdtb2RfY2xhc3MsCkBAIC05MDMsNiArOTIxLDcg
QEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAyNDMwX3RpbWVyOV9od21vZCA9IHsKIAkJ
CS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9TVF9HUFQ5X1NISUZULAogCQl9LAogCX0sCisJ
LmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0
MzBfdGltZXI5X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDI0MzBfdGlt
ZXI5X3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwMjQzMF90aW1lcl9od21vZF9jbGFzcywKQEAg
LTk1Myw2ICs5NzIsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDI0MzBfdGltZXIx
MF9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMjRYWF9TVF9HUFQxMF9TSElG
VCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0ciAgICAgICA9ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0
ciwKIAkuc2xhdmVzCQk9IG9tYXAyNDMwX3RpbWVyMTBfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0g
QVJSQVlfU0laRShvbWFwMjQzMF90aW1lcjEwX3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwMjQz
MF90aW1lcl9od21vZF9jbGFzcywKQEAgLTEwMDMsNiArMTAyMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
b21hcF9od21vZCBvbWFwMjQzMF90aW1lcjExX2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2Jp
dCA9IE9NQVAyNFhYX1NUX0dQVDExX1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyICAgICAg
ID0gJmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDI0MzBfdGltZXIx
MV9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAyNDMwX3RpbWVyMTFfc2xh
dmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAyNDMwX3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtMTA1Myw2
ICsxMDc0LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAyNDMwX3RpbWVyMTJfaHdt
b2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVfYml0ID0gT01BUDI0WFhfU1RfR1BUMTJfU0hJRlQsCiAJ
CX0sCiAJfSwKKwkuZGV2X2F0dHIgICAgICAgPSAmY2FwYWJpbGl0eV9wd21fZGV2X2F0dHIsCiAJ
LnNsYXZlcwkJPSBvbWFwMjQzMF90aW1lcjEyX3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZ
X1NJWkUob21hcDI0MzBfdGltZXIxMl9zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDI0MzBfdGlt
ZXJfaHdtb2RfY2xhc3MsCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdt
b2RfM3h4eF9kYXRhLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfM3h4eF9kYXRh
LmMKaW5kZXggYjk4ZTJkZi4uN2ZiMmVjYyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9vbWFwX2h3bW9kXzN4eHhfZGF0YS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9o
d21vZF8zeHh4X2RhdGEuYwpAQCAtNjA5LDYgKzYwOSwyMSBAQCBzdGF0aWMgc3RydWN0IG9tYXBf
aHdtb2RfY2xhc3Mgb21hcDN4eHhfdGltZXJfaHdtb2RfY2xhc3MgPSB7CiAJLnJldiA9ICBPTUFQ
X1RJTUVSX0lQX1ZFUlNJT05fMSwKIH07CiAKKy8qIHNlY3VyZSB0aW1lcnMgZGV2IGF0dHJpYnV0
ZSAqLworc3RhdGljIHN0cnVjdCBvbWFwX3RpbWVyX2NhcGFiaWxpdHlfZGV2X2F0dHIgY2FwYWJp
bGl0eV9zZWN1cmVfZGV2X2F0dHIgPSB7CisJLnRpbWVyX2NhcGFiaWxpdHkgICAgICAgPSBPTUFQ
X1RJTUVSX1NFQ1VSRSwKK307CisKKy8qIGFsd2F5cy1vbiB0aW1lcnMgZGV2IGF0dHJpYnV0ZSAq
Lworc3RhdGljIHN0cnVjdCBvbWFwX3RpbWVyX2NhcGFiaWxpdHlfZGV2X2F0dHIgY2FwYWJpbGl0
eV9hbHdvbl9kZXZfYXR0ciA9IHsKKwkudGltZXJfY2FwYWJpbGl0eSAgICAgICA9IE9NQVBfVElN
RVJfQUxXT04sCit9OworCisvKiBwd20gdGltZXJzIGRldiBhdHRyaWJ1dGUgKi8KK3N0YXRpYyBz
dHJ1Y3Qgb21hcF90aW1lcl9jYXBhYmlsaXR5X2Rldl9hdHRyIGNhcGFiaWxpdHlfcHdtX2Rldl9h
dHRyID0geworCS50aW1lcl9jYXBhYmlsaXR5ICAgICAgID0gT01BUF9USU1FUl9IQVNfUFdNLAor
fTsKKwogLyogdGltZXIxICovCiBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDN4eHhfdGlt
ZXIxX2h3bW9kOwogc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kX2lycV9pbmZvIG9tYXAzeHh4X3Rp
bWVyMV9tcHVfaXJxc1tdID0gewpAQCAtNjUzLDYgKzY2OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21h
cF9od21vZCBvbWFwM3h4eF90aW1lcjFfaHdtb2QgPSB7CiAJCQkuaWRsZXN0X2lkbGVfYml0ID0g
T01BUDM0MzBfU1RfR1BUMV9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmls
aXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDN4eHhfdGltZXIxX3NsYXZlcywK
IAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDN4eHhfdGltZXIxX3NsYXZlcyksCiAJLmNs
YXNzCQk9ICZvbWFwM3h4eF90aW1lcl8xbXNfaHdtb2RfY2xhc3MsCkBAIC03MDMsNiArNzE5LDcg
QEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXAzeHh4X3RpbWVyMl9od21vZCA9IHsKIAkJ
CS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMzQzMF9TVF9HUFQyX1NISUZULAogCQl9LAogCX0sCisJ
LmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFw
M3h4eF90aW1lcjJfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwM3h4eF90
aW1lcjJfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAzeHh4X3RpbWVyXzFtc19od21vZF9jbGFz
cywKQEAgLTc1Myw2ICs3NzAsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDN4eHhf
dGltZXIzX2h3bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAzNDMwX1NUX0dQVDNf
U0hJRlQsCiAJCX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0
ciwKIAkuc2xhdmVzCQk9IG9tYXAzeHh4X3RpbWVyM19zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBB
UlJBWV9TSVpFKG9tYXAzeHh4X3RpbWVyM19zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDN4eHhf
dGltZXJfaHdtb2RfY2xhc3MsCkBAIC04MDMsNiArODIxLDcgQEAgc3RhdGljIHN0cnVjdCBvbWFw
X2h3bW9kIG9tYXAzeHh4X3RpbWVyNF9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBP
TUFQMzQzMF9TVF9HUFQ0X1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxp
dHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwM3h4eF90aW1lcjRfc2xhdmVzLAog
CS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwM3h4eF90aW1lcjRfc2xhdmVzKSwKIAkuY2xh
c3MJCT0gJm9tYXAzeHh4X3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtODUzLDYgKzg3Miw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwM3h4eF90aW1lcjVfaHdtb2QgPSB7CiAJCQkuaWRs
ZXN0X2lkbGVfYml0ID0gT01BUDM0MzBfU1RfR1BUNV9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZf
YXR0cgk9ICZjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDN4eHhf
dGltZXI1X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDN4eHhfdGltZXI1
X3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwM3h4eF90aW1lcl9od21vZF9jbGFzcywKQEAgLTkw
Myw2ICs5MjMsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDN4eHhfdGltZXI2X2h3
bW9kID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAzNDMwX1NUX0dQVDZfU0hJRlQsCiAJ
CX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xh
dmVzCQk9IG9tYXAzeHh4X3RpbWVyNl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpF
KG9tYXAzeHh4X3RpbWVyNl9zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDN4eHhfdGltZXJfaHdt
b2RfY2xhc3MsCkBAIC05NTMsNiArOTc0LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9t
YXAzeHh4X3RpbWVyN19od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMzQzMF9T
VF9HUFQ3X1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25f
ZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwM3h4eF90aW1lcjdfc2xhdmVzLAogCS5zbGF2ZXNf
Y250CT0gQVJSQVlfU0laRShvbWFwM3h4eF90aW1lcjdfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9t
YXAzeHh4X3RpbWVyX2h3bW9kX2NsYXNzLApAQCAtMTAwMyw2ICsxMDI1LDcgQEAgc3RhdGljIHN0
cnVjdCBvbWFwX2h3bW9kIG9tYXAzeHh4X3RpbWVyOF9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRs
ZV9iaXQgPSBPTUFQMzQzMF9TVF9HUFQ4X1NISUZULAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0g
JmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDN4eHhfdGltZXI4X3Ns
YXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDN4eHhfdGltZXI4X3NsYXZlcyks
CiAJLmNsYXNzCQk9ICZvbWFwM3h4eF90aW1lcl9od21vZF9jbGFzcywKQEAgLTEwNTMsNiArMTA3
Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwM3h4eF90aW1lcjlfaHdtb2QgPSB7
CiAJCQkuaWRsZXN0X2lkbGVfYml0ID0gT01BUDM0MzBfU1RfR1BUOV9TSElGVCwKIAkJfSwKIAl9
LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9t
YXAzeHh4X3RpbWVyOV9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpFKG9tYXAzeHh4
X3RpbWVyOV9zbGF2ZXMpLAogCS5jbGFzcwkJPSAmb21hcDN4eHhfdGltZXJfaHdtb2RfY2xhc3Ms
CkBAIC0xMTAzLDYgKzExMjcsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDN4eHhf
dGltZXIxMF9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRsZV9iaXQgPSBPTUFQMzQzMF9TVF9HUFQx
MF9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0
ciwKIAkuc2xhdmVzCQk9IG9tYXAzeHh4X3RpbWVyMTBfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0g
QVJSQVlfU0laRShvbWFwM3h4eF90aW1lcjEwX3NsYXZlcyksCiAJLmNsYXNzCQk9ICZvbWFwM3h4
eF90aW1lcl8xbXNfaHdtb2RfY2xhc3MsCkBAIC0xMTUzLDYgKzExNzgsNyBAQCBzdGF0aWMgc3Ry
dWN0IG9tYXBfaHdtb2Qgb21hcDN4eHhfdGltZXIxMV9od21vZCA9IHsKIAkJCS5pZGxlc3RfaWRs
ZV9iaXQgPSBPTUFQMzQzMF9TVF9HUFQxMV9TSElGVCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9
ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9tYXAzeHh4X3RpbWVyMTFf
c2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwM3h4eF90aW1lcjExX3NsYXZl
cyksCiAJLmNsYXNzCQk9ICZvbWFwM3h4eF90aW1lcl9od21vZF9jbGFzcywKQEAgLTEyMDMsNiAr
MTIyOSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwM3h4eF90aW1lcjEyX2h3bW9k
ID0gewogCQkJLmlkbGVzdF9pZGxlX2JpdCA9IE9NQVAzNDMwX1NUX0dQVDEyX1NISUZULAogCQl9
LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfc2VjdXJlX2Rldl9hdHRyLAogCS5zbGF2
ZXMJCT0gb21hcDN4eHhfdGltZXIxMl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpF
KG9tYXAzeHh4X3RpbWVyMTJfc2xhdmVzKSwKIAkuY2xhc3MJCT0gJm9tYXAzeHh4X3RpbWVyX2h3
bW9kX2NsYXNzLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0
eHhfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jCmlu
ZGV4IDY0ODVjOTAuLjM4ZDU4NDggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21h
cF9od21vZF80NHh4X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2Rf
NDR4eF9kYXRhLmMKQEAgLTQwMTQsNiArNDAxNCwyMSBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdt
b2RfY2xhc3Mgb21hcDQ0eHhfdGltZXJfaHdtb2RfY2xhc3MgPSB7CiAJLnJldgk9IE9NQVBfVElN
RVJfSVBfVkVSU0lPTl8yLAogfTsKIAorLyogc2VjdXJlIHRpbWVycyBkZXYgYXR0cmlidXRlICov
CitzdGF0aWMgc3RydWN0IG9tYXBfdGltZXJfY2FwYWJpbGl0eV9kZXZfYXR0ciBjYXBhYmlsaXR5
X3NlY3VyZV9kZXZfYXR0ciA9IHsKKwkudGltZXJfY2FwYWJpbGl0eQk9IE9NQVBfVElNRVJfU0VD
VVJFLAorfTsKKworLyogYWx3YXlzLW9uIHRpbWVycyBkZXYgYXR0cmlidXRlICovCitzdGF0aWMg
c3RydWN0IG9tYXBfdGltZXJfY2FwYWJpbGl0eV9kZXZfYXR0ciBjYXBhYmlsaXR5X2Fsd29uX2Rl
dl9hdHRyID0geworCS50aW1lcl9jYXBhYmlsaXR5CT0gT01BUF9USU1FUl9BTFdPTiwKK307CisK
Ky8qIHB3bSB0aW1lcnMgZGV2IGF0dHJpYnV0ZSAqLworc3RhdGljIHN0cnVjdCBvbWFwX3RpbWVy
X2NhcGFiaWxpdHlfZGV2X2F0dHIgY2FwYWJpbGl0eV9wd21fZGV2X2F0dHIgPSB7CisJLnRpbWVy
X2NhcGFiaWxpdHkJPSBPTUFQX1RJTUVSX0hBU19QV00sCit9OworCiAvKiB0aW1lcjEgKi8KIHN0
YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwNDR4eF90aW1lcjFfaHdtb2Q7CiBzdGF0aWMgc3Ry
dWN0IG9tYXBfaHdtb2RfaXJxX2luZm8gb21hcDQ0eHhfdGltZXIxX2lycXNbXSA9IHsKQEAgLTQw
NTQsNiArNDA2OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwNDR4eF90aW1lcjFf
aHdtb2QgPSB7CiAJCQkuY2xrY3RybF9yZWcgPSBPTUFQNDQzMF9DTV9XS1VQX1RJTUVSMV9DTEtD
VFJMLAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25fZGV2X2F0dHIs
CiAJLnNsYXZlcwkJPSBvbWFwNDR4eF90aW1lcjFfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJS
QVlfU0laRShvbWFwNDR4eF90aW1lcjFfc2xhdmVzKSwKIAkub21hcF9jaGlwCT0gT01BUF9DSElQ
X0lOSVQoQ0hJUF9JU19PTUFQNDQzMCksCkBAIC00MDk5LDYgKzQxMTUsNyBAQCBzdGF0aWMgc3Ry
dWN0IG9tYXBfaHdtb2Qgb21hcDQ0eHhfdGltZXIyX2h3bW9kID0gewogCQkJLmNsa2N0cmxfcmVn
ID0gT01BUDQ0MzBfQ01fTDRQRVJfRE1USU1FUjJfQ0xLQ1RSTCwKIAkJfSwKIAl9LAorCS5kZXZf
YXR0cgk9ICZjYXBhYmlsaXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDQ0eHhf
dGltZXIyX3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDQ0eHhfdGltZXIy
X3NsYXZlcyksCiAJLm9tYXBfY2hpcAk9IE9NQVBfQ0hJUF9JTklUKENISVBfSVNfT01BUDQ0MzAp
LApAQCAtNDE0NCw2ICs0MTYxLDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXA0NHh4
X3RpbWVyM19od21vZCA9IHsKIAkJCS5jbGtjdHJsX3JlZyA9IE9NQVA0NDMwX0NNX0w0UEVSX0RN
VElNRVIzX0NMS0NUUkwsCiAJCX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9hbHdv
bl9kZXZfYXR0ciwKIAkuc2xhdmVzCQk9IG9tYXA0NHh4X3RpbWVyM19zbGF2ZXMsCiAJLnNsYXZl
c19jbnQJPSBBUlJBWV9TSVpFKG9tYXA0NHh4X3RpbWVyM19zbGF2ZXMpLAogCS5vbWFwX2NoaXAJ
PSBPTUFQX0NISVBfSU5JVChDSElQX0lTX09NQVA0NDMwKSwKQEAgLTQxODksNiArNDIwNyw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgb21hcF9od21vZCBvbWFwNDR4eF90aW1lcjRfaHdtb2QgPSB7CiAJCQku
Y2xrY3RybF9yZWcgPSBPTUFQNDQzMF9DTV9MNFBFUl9ETVRJTUVSNF9DTEtDVFJMLAogCQl9LAog
CX0sCisJLmRldl9hdHRyCT0gJmNhcGFiaWxpdHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJ
PSBvbWFwNDR4eF90aW1lcjRfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFw
NDR4eF90aW1lcjRfc2xhdmVzKSwKIAkub21hcF9jaGlwCT0gT01BUF9DSElQX0lOSVQoQ0hJUF9J
U19PTUFQNDQzMCksCkBAIC00MjUzLDYgKzQyNzIsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdt
b2Qgb21hcDQ0eHhfdGltZXI1X2h3bW9kID0gewogCQkJLmNsa2N0cmxfcmVnID0gT01BUDQ0MzBf
Q00xX0FCRV9USU1FUjVfQ0xLQ1RSTCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmls
aXR5X2Fsd29uX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDQ0eHhfdGltZXI1X3NsYXZlcywK
IAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDQ0eHhfdGltZXI1X3NsYXZlcyksCiAJLm9t
YXBfY2hpcAk9IE9NQVBfQ0hJUF9JTklUKENISVBfSVNfT01BUDQ0MzApLApAQCAtNDMxNyw2ICs0
MzM3LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXA0NHh4X3RpbWVyNl9od21vZCA9
IHsKIAkJCS5jbGtjdHJsX3JlZyA9IE9NQVA0NDMwX0NNMV9BQkVfVElNRVI2X0NMS0NUUkwsCiAJ
CX0sCiAJfSwKKwkuZGV2X2F0dHIJPSAmY2FwYWJpbGl0eV9hbHdvbl9kZXZfYXR0ciwKIAkuc2xh
dmVzCQk9IG9tYXA0NHh4X3RpbWVyNl9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9TSVpF
KG9tYXA0NHh4X3RpbWVyNl9zbGF2ZXMpLAogCS5vbWFwX2NoaXAJPSBPTUFQX0NISVBfSU5JVChD
SElQX0lTX09NQVA0NDMwKSwKQEAgLTQzODEsNiArNDQwMiw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb21h
cF9od21vZCBvbWFwNDR4eF90aW1lcjdfaHdtb2QgPSB7CiAJCQkuY2xrY3RybF9yZWcgPSBPTUFQ
NDQzMF9DTTFfQUJFX1RJTUVSN19DTEtDVFJMLAogCQl9LAogCX0sCisJLmRldl9hdHRyCT0gJmNh
cGFiaWxpdHlfYWx3b25fZGV2X2F0dHIsCiAJLnNsYXZlcwkJPSBvbWFwNDR4eF90aW1lcjdfc2xh
dmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShvbWFwNDR4eF90aW1lcjdfc2xhdmVzKSwK
IAkub21hcF9jaGlwCT0gT01BUF9DSElQX0lOSVQoQ0hJUF9JU19PTUFQNDQzMCksCkBAIC00NDQ1
LDYgKzQ0NjcsNyBAQCBzdGF0aWMgc3RydWN0IG9tYXBfaHdtb2Qgb21hcDQ0eHhfdGltZXI4X2h3
bW9kID0gewogCQkJLmNsa2N0cmxfcmVnID0gT01BUDQ0MzBfQ00xX0FCRV9USU1FUjhfQ0xLQ1RS
TCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0ciwKIAku
c2xhdmVzCQk9IG9tYXA0NHh4X3RpbWVyOF9zbGF2ZXMsCiAJLnNsYXZlc19jbnQJPSBBUlJBWV9T
SVpFKG9tYXA0NHh4X3RpbWVyOF9zbGF2ZXMpLAogCS5vbWFwX2NoaXAJPSBPTUFQX0NISVBfSU5J
VChDSElQX0lTX09NQVA0NDMwKSwKQEAgLTQ0OTAsNiArNDUxMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
b21hcF9od21vZCBvbWFwNDR4eF90aW1lcjlfaHdtb2QgPSB7CiAJCQkuY2xrY3RybF9yZWcgPSBP
TUFQNDQzMF9DTV9MNFBFUl9ETVRJTUVSOV9DTEtDVFJMLAogCQl9LAogCX0sCisJLmRldl9hdHRy
CT0gJmNhcGFiaWxpdHlfcHdtX2Rldl9hdHRyLAogCS5zbGF2ZXMJCT0gb21hcDQ0eHhfdGltZXI5
X3NsYXZlcywKIAkuc2xhdmVzX2NudAk9IEFSUkFZX1NJWkUob21hcDQ0eHhfdGltZXI5X3NsYXZl
cyksCiAJLm9tYXBfY2hpcAk9IE9NQVBfQ0hJUF9JTklUKENISVBfSVNfT01BUDQ0MzApLApAQCAt
NDUzNSw2ICs0NTU5LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXA0NHh4X3RpbWVy
MTBfaHdtb2QgPSB7CiAJCQkuY2xrY3RybF9yZWcgPSBPTUFQNDQzMF9DTV9MNFBFUl9ETVRJTUVS
MTBfQ0xLQ1RSTCwKIAkJfSwKIAl9LAorCS5kZXZfYXR0cgk9ICZjYXBhYmlsaXR5X3B3bV9kZXZf
YXR0ciwKIAkuc2xhdmVzCQk9IG9tYXA0NHh4X3RpbWVyMTBfc2xhdmVzLAogCS5zbGF2ZXNfY250
CT0gQVJSQVlfU0laRShvbWFwNDR4eF90aW1lcjEwX3NsYXZlcyksCiAJLm9tYXBfY2hpcAk9IE9N
QVBfQ0hJUF9JTklUKENISVBfSVNfT01BUDQ0MzApLApAQCAtNDU4MCw2ICs0NjA1LDcgQEAgc3Rh
dGljIHN0cnVjdCBvbWFwX2h3bW9kIG9tYXA0NHh4X3RpbWVyMTFfaHdtb2QgPSB7CiAJCQkuY2xr
Y3RybF9yZWcgPSBPTUFQNDQzMF9DTV9MNFBFUl9ETVRJTUVSMTFfQ0xLQ1RSTCwKIAkJfSwKIAl9
LAorCS5kZXZfYXR0ciAgICAgICA9ICZjYXBhYmlsaXR5X3B3bV9kZXZfYXR0ciwKIAkuc2xhdmVz
CQk9IG9tYXA0NHh4X3RpbWVyMTFfc2xhdmVzLAogCS5zbGF2ZXNfY250CT0gQVJSQVlfU0laRShv
bWFwNDR4eF90aW1lcjExX3NsYXZlcyksCiAJLm9tYXBfY2hpcAk9IE9NQVBfQ0hJUF9JTklUKENI
SVBfSVNfT01BUDQ0MzApLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci5j
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci5jCmluZGV4IDJlZGViMWEuLjFjODAzMzcgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXIuYworKysgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL3RpbWVyLmMKQEAgLTEsNSArMSw1IEBACiAvKgotICogbGludXgvYXJjaC9hcm0vbWFj
aC1vbWFwMi90aW1lci1ncC5jCisgKiBsaW51eC9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMK
ICAqCiAgKiBPTUFQMiBHUCB0aW1lciBzdXBwb3J0LgogICoKQEAgLTM1LDYgKzM1LDcgQEAKICNp
bmNsdWRlIDxsaW51eC9pcnEuaD4KICNpbmNsdWRlIDxsaW51eC9jbG9ja3NvdXJjZS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2Nsb2NrY2hpcHMuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAKICNp
bmNsdWRlIDxhc20vbWFjaC90aW1lLmg+CiAjaW5jbHVkZSA8cGxhdC9kbXRpbWVyLmg+CkBAIC00
Miw2ICs0Myw3IEBACiAjaW5jbHVkZSA8YXNtL3NjaGVkX2Nsb2NrLmg+CiAjaW5jbHVkZSA8cGxh
dC9jb21tb24uaD4KICNpbmNsdWRlIDxwbGF0L29tYXBfaHdtb2QuaD4KKyNpbmNsdWRlIDxwbGF0
L29tYXBfZGV2aWNlLmg+CiAKIC8qIFBhcmVudCBjbG9ja3MsIGV2ZW50dWFsbHkgdGhlc2Ugd2ls
bCBjb21lIGZyb20gdGhlIGNsb2NrIGZyYW1ld29yayAqLwogCkBAIC0xMjksNiArMTMxLDIzIEBA
IHN0YXRpYyBzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlIGNsb2NrZXZlbnRfZ3B0ID0gewogCS5z
ZXRfbW9kZQk9IG9tYXAyX2dwX3RpbWVyX3NldF9tb2RlLAogfTsKIAoraW50IF9fb21hcF9kbV90
aW1lcl9zZXRfc291cmNlKHN0cnVjdCBjbGsgKnRpbWVyX2Zjaywgc3RydWN0IGNsayAqcGFyZW50
KQoreworCWludCByZXQ7CisKKwljbGtfZGlzYWJsZSh0aW1lcl9mY2spOworCXJldCA9IGNsa19z
ZXRfcGFyZW50KHRpbWVyX2ZjaywgcGFyZW50KTsKKwljbGtfZW5hYmxlKHRpbWVyX2Zjayk7CisK
KwkvKgorCSAqIFdoZW4gdGhlIGZ1bmN0aW9uYWwgY2xvY2sgZGlzYXBwZWFycywgdG9vIHF1aWNr
IHdyaXRlcyBzZWVtCisJICogdG8gY2F1c2UgYW4gYWJvcnQuIFhYWCBJcyB0aGlzIHN0aWxsIG5l
Y2Vzc2FyeT8KKwkgKi8KKwlfX2RlbGF5KDMwMDAwMCk7CisKKwlyZXR1cm4gcmV0OworfQorCiBz
dGF0aWMgaW50IF9faW5pdCBvbWFwX2RtX3RpbWVyX2luaXRfb25lKHN0cnVjdCBvbWFwX2RtX3Rp
bWVyICp0aW1lciwKIAkJCQkJCWludCBncHRpbWVyX2lkLAogCQkJCQkJY29uc3QgY2hhciAqZmNr
X3NvdXJjZSkKQEAgLTM1OSwzICszNzgsMTQwIEBAIHN0cnVjdCBzeXNfdGltZXIgb21hcDRfdGlt
ZXIgPSB7CiAJLmluaXQJPSBvbWFwNF90aW1lcl9pbml0LAogfTsKICNlbmRpZgorCisvKioKKyAq
IG9tYXAyX2RtX3RpbWVyX3NldF9zcmMgLSBjaGFuZ2UgdGhlIHRpbWVyIGlucHV0IGNsb2NrIHNv
dXJjZQorICogQHBkZXY6CXRpbWVyIHBsYXRmb3JtIGRldmljZSBwb2ludGVyCisgKiBAc291cmNl
OglhcnJheSBpbmRleCBvZiBwYXJlbnQgY2xvY2sgc291cmNlCisgKi8KK3N0YXRpYyBpbnQgb21h
cDJfZG1fdGltZXJfc2V0X3NyYyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQgc291
cmNlKQoreworCWludCByZXQ7CisJc3RydWN0IGRtdGltZXJfcGxhdGZvcm1fZGF0YSAqcGRhdGEg
PSBwZGV2LT5kZXYucGxhdGZvcm1fZGF0YTsKKwlzdHJ1Y3QgY2xrICpmY2xrLCAqbmV3X2ZjbGs7
CisJY2hhciAqbmV3X2ZjbGtfbmFtZSA9IE5VTEw7CisKKwlmY2xrID0gY2xrX2dldCgmcGRldi0+
ZGV2LCAiZmNrIik7CisJaWYgKElTX0VSUl9PUl9OVUxMKGZjbGspKSB7CisJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIiVzOiAlZDogY2xrX2dldCgpIEZBSUxFRFxuIiwKKwkJCQlfX2Z1bmNfXywgX19M
SU5FX18pOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlzd2l0Y2ggKHNvdXJjZSkgeworCWNh
c2UgT01BUF9USU1FUl9TUkNfU1lTX0NMSzoKKwkJbmV3X2ZjbGtfbmFtZSA9ICJzeXNfY2siOwor
CQlicmVhazsKKworCWNhc2UgT01BUF9USU1FUl9TUkNfMzJfS0haOgorCQlpZiAodW5saWtlbHko
Y3B1X2lzX29tYXAyNDIwKCkpKQorCQkJbmV3X2ZjbGtfbmFtZSA9ICJmdW5jXzMya19jayI7CisJ
CWVsc2UKKwkJCW5ld19mY2xrX25hbWUgPSAiMzJrX2NrIjsKKwkJYnJlYWs7CisKKwljYXNlIE9N
QVBfVElNRVJfU1JDX0VYVF9DTEs6CisJCWlmIChwZGF0YS0+dGltZXJfaXBfdHlwZSA9PSBPTUFQ
X1RJTUVSX0lQX1ZFUlNJT05fMSkgeworCQkJbmV3X2ZjbGtfbmFtZSA9ICJhbHRfY2siOworCQkJ
YnJlYWs7CisJCX0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiJXM6ICVkOiBpbnZhbGlkIGNsayBz
cmMuXG4iLAorCQkJX19mdW5jX18sIF9fTElORV9fKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQor
CisJbmV3X2ZjbGsgPSBjbGtfZ2V0KCZwZGV2LT5kZXYsIG5ld19mY2xrX25hbWUpOworCWlmIChJ
U19FUlJfT1JfTlVMTChuZXdfZmNsaykpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiJXM6ICVk
OiBjbGtfZ2V0KCkgJXMgRkFJTEVEXG4iLAorCQkJX19mdW5jX18sIF9fTElORV9fLCBuZXdfZmNs
a19uYW1lKTsKKwkJY2xrX3B1dChmY2xrKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJcmV0
ID0gY2xrX3NldF9wYXJlbnQoZmNsaywgbmV3X2ZjbGspOworCWlmIChJU19FUlJfVkFMVUUocmV0
KSkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICIlczogY2xrX3NldF9wYXJlbnQoKSB0byAlcyBG
QUlMRURcbiIsCisJCQlfX2Z1bmNfXywgbmV3X2ZjbGtfbmFtZSk7CisJCXJldCA9IC1FSU5WQUw7
CisJfQorCisJY2xrX3B1dChuZXdfZmNsayk7CisJY2xrX3B1dChmY2xrKTsKKworCXJldHVybiBy
ZXQ7Cit9CisKK3N0cnVjdCBvbWFwX2RldmljZV9wbV9sYXRlbmN5IG9tYXAyX2RtdGltZXJfbGF0
ZW5jeVtdID0geworCXsKKwkJLmRlYWN0aXZhdGVfZnVuYyA9IG9tYXBfZGV2aWNlX2lkbGVfaHdt
b2RzLAorCQkuYWN0aXZhdGVfZnVuYyAgID0gb21hcF9kZXZpY2VfZW5hYmxlX2h3bW9kcywKKwkJ
LmZsYWdzID0gT01BUF9ERVZJQ0VfTEFURU5DWV9BVVRPX0FESlVTVCwKKwl9LAorfTsKKworLyoq
CisgKiBvbWFwX3RpbWVyX2luaXQgLSBidWlsZCBhbmQgcmVnaXN0ZXIgdGltZXIgZGV2aWNlIHdp
dGggYW4KKyAqIGFzc29jaWF0ZWQgdGltZXIgaHdtb2QKKyAqIEBvaDoJdGltZXIgaHdtb2QgcG9p
bnRlciB0byBiZSB1c2VkIHRvIGJ1aWxkIHRpbWVyIGRldmljZQorICogQHVzZXI6CXBhcmFtZXRl
ciB0aGF0IGNhbiBiZSBwYXNzZWQgZnJvbSBjYWxsaW5nIGh3bW9kIEFQSQorICoKKyAqIENhbGxl
ZCBieSBvbWFwX2h3bW9kX2Zvcl9lYWNoX2J5X2NsYXNzIHRvIHJlZ2lzdGVyIGVhY2ggb2YgdGhl
IHRpbWVyCisgKiBkZXZpY2VzIHByZXNlbnQgaW4gdGhlIHN5c3RlbS4gVGhlIG51bWJlciBvZiB0
aW1lciBkZXZpY2VzIGlzIGtub3duCisgKiBieSBwYXJzaW5nIHRocm91Z2ggdGhlIGh3bW9kIGRh
dGFiYXNlIGZvciBhIGdpdmVuIGNsYXNzIG5hbWUuIEF0IHRoZQorICogZW5kIG9mIGZ1bmN0aW9u
IGNhbGwgbWVtb3J5IGlzIGFsbG9jYXRlZCBmb3IgdGltZXIgZGV2aWNlIGFuZCBpdCBpcworICog
cmVnaXN0ZXJlZCB0byB0aGUgZnJhbWV3b3JrIHJlYWR5IHRvIGJlIHByb3ZlZCBieSB0aGUgZHJp
dmVyLgorICovCitzdGF0aWMgaW50IF9faW5pdCBvbWFwX3RpbWVyX2luaXQoc3RydWN0IG9tYXBf
aHdtb2QgKm9oLCB2b2lkICp1bnVzZWQpCit7CisJaW50IGlkOworCWludCByZXQgPSAwOworCWNo
YXIgKm5hbWUgPSAib21hcF90aW1lciI7CisJc3RydWN0IGRtdGltZXJfcGxhdGZvcm1fZGF0YSAq
cGRhdGE7CisJc3RydWN0IG9tYXBfZGV2aWNlICpvZDsKKwlzdHJ1Y3Qgb21hcF90aW1lcl9jYXBh
YmlsaXR5X2Rldl9hdHRyICp0aW1lcl9kZXZfYXR0cjsKKworCXByX2RlYnVnKCIlczogJXNcbiIs
IF9fZnVuY19fLCBvaC0+bmFtZSk7CisKKwkvKiBvbiBzZWN1cmUgZGV2aWNlLCBkbyBub3QgcmVn
aXN0ZXIgc2VjdXJlIHRpbWVyICovCisJdGltZXJfZGV2X2F0dHIgPSBvaC0+ZGV2X2F0dHI7CisJ
aWYgKG9tYXBfdHlwZSgpICE9IE9NQVAyX0RFVklDRV9UWVBFX0dQICYmIHRpbWVyX2Rldl9hdHRy
KQorCQlpZiAodGltZXJfZGV2X2F0dHItPnRpbWVyX2NhcGFiaWxpdHkgPT0gT01BUF9USU1FUl9T
RUNVUkUpCisJCQlyZXR1cm4gcmV0OworCisJcGRhdGEgPSBremFsbG9jKHNpemVvZigqcGRhdGEp
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBkYXRhKSB7CisJCXByX2VycigiJXM6IE5vIG1lbW9yeSBm
b3IgWyVzXVxuIiwgX19mdW5jX18sIG9oLT5uYW1lKTsKKwkJcmV0dXJuIC1FTk9NRU07CisJfQor
CisJLyoKKwkgKiBFeHRyYWN0IHRoZSBJRHMgZnJvbSBuYW1lIGZpZWxkIGluIGh3bW9kIGRhdGFi
YXNlCisJICogYW5kIHVzZSB0aGUgc2FtZSBmb3IgY29uc3RydWN0aW5nIGlkcycgZm9yIHRoZQor
CSAqIHRpbWVyIGRldmljZXMuIEluIGEgd2F5LCB3ZSBhcmUgYXZvaWRpbmcgdXNhZ2Ugb2YKKwkg
KiBzdGF0aWMgdmFyaWFibGUgd2l0aW4gdGhlIGZ1bmN0aW9uIHRvIGRvIHRoZSBzYW1lLgorCSAq
IENBVVRJT046IFdlIGhhdmUgdG8gYmUgY2FyZWZ1bCBhbmQgbWFrZSBzdXJlIHRoZQorCSAqIG5h
bWUgaW4gaHdtb2QgZGF0YWJhc2UgZG9lcyBub3QgY2hhbmdlIGluIHdoaWNoIGNhc2UKKwkgKiB3
ZSBtaWdodCBlaXRoZXIgbWFrZSBjb3JyZXNwb25kaW5nIGNoYW5nZSBoZXJlIG9yCisJICogc3dp
dGNoIGJhY2sgc3RhdGljIHZhcmlhYmxlIG1lY2hhbmlzbS4KKwkgKi8KKwlzc2NhbmYob2gtPm5h
bWUsICJ0aW1lciUyZCIsICZpZCk7CisKKwlwZGF0YS0+c2V0X3RpbWVyX3NyYyA9IG9tYXAyX2Rt
X3RpbWVyX3NldF9zcmM7CisJcGRhdGEtPnRpbWVyX2lwX3R5cGUgPSBvaC0+Y2xhc3MtPnJldjsK
KwlwZGF0YS0+bmVlZHNfbWFudWFsX3Jlc2V0ID0gMDsKKworCW9kID0gb21hcF9kZXZpY2VfYnVp
bGQobmFtZSwgaWQsIG9oLCBwZGF0YSwgc2l6ZW9mKCpwZGF0YSksCisJCQlvbWFwMl9kbXRpbWVy
X2xhdGVuY3ksCisJCQlBUlJBWV9TSVpFKG9tYXAyX2RtdGltZXJfbGF0ZW5jeSksCisJCQkwKTsK
KworCWlmIChJU19FUlIob2QpKSB7CisJCXByX2VycigiJXM6IENhbid0IGJ1aWxkIG9tYXBfZGV2
aWNlIGZvciAlczogJXMuXG4iLAorCQkJX19mdW5jX18sIG5hbWUsIG9oLT5uYW1lKTsKKwkJcmV0
ID0gLUVJTlZBTDsKKwl9CisKKwlrZnJlZShwZGF0YSk7CisKKwlyZXR1cm4gcmV0OworfQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYyBiL2FyY2gvYXJtL3BsYXQtb21h
cC9kbXRpbWVyLmMKaW5kZXggYTg4ZmNkZC4uMGYzZTljOSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
cGxhdC1vbWFwL2RtdGltZXIuYworKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCkBA
IC00MjcsMjMgKzQyNyw2IEBAIHZvaWQgb21hcF9kbV90aW1lcl9zdG9wKHN0cnVjdCBvbWFwX2Rt
X3RpbWVyICp0aW1lcikKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG9tYXBfZG1fdGltZXJfc3RvcCk7
CiAKLWludCBfX29tYXBfZG1fdGltZXJfc2V0X3NvdXJjZShzdHJ1Y3QgY2xrICp0aW1lcl9mY2ss
IHN0cnVjdCBjbGsgKnBhcmVudCkKLXsKLQlpbnQgcmV0OwotCi0JY2xrX2Rpc2FibGUodGltZXJf
ZmNrKTsKLQlyZXQgPSBjbGtfc2V0X3BhcmVudCh0aW1lcl9mY2ssIHBhcmVudCk7Ci0JY2xrX2Vu
YWJsZSh0aW1lcl9mY2spOwotCi0JLyoKLQkgKiBXaGVuIHRoZSBmdW5jdGlvbmFsIGNsb2NrIGRp
c2FwcGVhcnMsIHRvbyBxdWljayB3cml0ZXMgc2VlbQotCSAqIHRvIGNhdXNlIGFuIGFib3J0LiBY
WFggSXMgdGhpcyBzdGlsbCBuZWNlc3Nhcnk/Ci0JICovCi0JX19kZWxheSgzMDAwMDApOwotCi0J
cmV0dXJuIHJldDsKLX0KLQogaW50IG9tYXBfZG1fdGltZXJfc2V0X3NvdXJjZShzdHJ1Y3Qgb21h
cF9kbV90aW1lciAqdGltZXIsIGludCBzb3VyY2UpCiB7CiAJaWYgKHNvdXJjZSA8IDAgfHwgc291
cmNlID49IDMpCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2Rt
dGltZXIuaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvZG10aW1lci5oCmluZGV4
IDFiNzY0NTAuLjAwZTFhNGYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRl
L3BsYXQvZG10aW1lci5oCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvZG10
aW1lci5oCkBAIC0xLDUgKzEsNSBAQAogLyoKLSAqIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRl
L21hY2gvZG10aW1lci5oCisgKiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2RtdGlt
ZXIuaAogICoKICAqIE9NQVAgRHVhbC1Nb2RlIFRpbWVycwogICoKQEAgLTM1LDYgKzM1LDggQEAK
ICNpZm5kZWYgX19BU01fQVJDSF9ETVRJTUVSX0gKICNkZWZpbmUgX19BU01fQVJDSF9ETVRJTUVS
X0gKIAorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorCiAvKiBjbG9jayBzb3Vy
Y2VzICovCiAjZGVmaW5lIE9NQVBfVElNRVJfU1JDX1NZU19DTEsJCQkweDAwCiAjZGVmaW5lIE9N
QVBfVElNRVJfU1JDXzMyX0tIWgkJCTB4MDEKQEAgLTU3LDYgKzU5LDE1IEBACiAjZGVmaW5lIE9N
QVBfVElNRVJfSVBfVkVSU0lPTl8xCQkJMHgxCiAjZGVmaW5lIE9NQVBfVElNRVJfSVBfVkVSU0lP
Tl8yCQkJMHgyCiAKKy8qIHRpbWVyIGNhcGFiaWxpdGllcyB1c2VkIGluIGh3bW9kIGRhdGFiYXNl
ICovCisjZGVmaW5lIE9NQVBfVElNRVJfU0VDVVJFCQkJCTB4ODAwMDAwMDAKKyNkZWZpbmUgT01B
UF9USU1FUl9BTFdPTgkJCQkweDQwMDAwMDAwCisjZGVmaW5lIE9NQVBfVElNRVJfSEFTX1BXTQkJ
CQkweDIwMDAwMDAwCisKK3N0cnVjdCBvbWFwX3RpbWVyX2NhcGFiaWxpdHlfZGV2X2F0dHIgewor
CXUzMiB0aW1lcl9jYXBhYmlsaXR5OworfTsKKwogZXh0ZXJuIHN0cnVjdCBvbWFwX2RtX3RpbWVy
ICpncHRpbWVyX3dha2V1cDsKIHN0cnVjdCBjbGs7CiAKLS0gCjEuNi4wLjQKCg==

--_002_5A47E75E594F054BAF48C5E4FC4B92AB037AD277ADdbde02enttico_--
