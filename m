From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] omap3: Add cpuidle parameters table for omap3430
Date: Mon, 15 Feb 2016 19:02:08 +0100
Message-ID: <1455559328-19783-1-git-send-email-pali.rohar@gmail.com>
References: <20160215152542.GS19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160215152542.GS19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Based on CPU type choose generic omap3 or omap3430 specific cpuidle
parameters. Parameters for omap3430 were measured on Nokia N900 device =
and
added by commit 5a1b1d3a9efa ("OMAP3: RX-51: Pass cpu idle parameters")
which were later removed by commit 231900afba52 ("ARM: OMAP3: cpuidle -
remove rx51 cpuidle parameters table") due to huge code complexity.

This patch brings cpuidle parameters for omap3430 devices again, but us=
es
simple condition based on CPU type.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
=46ixes: 231900afba52d6faddfb480cde4132d4edc089bc
---
 arch/arm/mach-omap2/cpuidle34xx.c |   69 +++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cp=
uidle34xx.c
index aa7b379..2a3db0b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -34,6 +34,7 @@
 #include "pm.h"
 #include "control.h"
 #include "common.h"
+#include "soc.h"
=20
 /* Mach specific information to be recorded in the C-state driver_data=
 */
 struct omap3_idle_statedata {
@@ -315,6 +316,69 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
 	.safe_state_index =3D 0,
 };
=20
+/*
+ * Numbers based on measurements made in October 2009 for PM optimized=
 kernel
+ * with CPU freq enabled on device Nokia N900. Assumes OPP2 (main idle=
 OPP,
+ * and worst case latencies).
+ */
+static struct cpuidle_driver omap3430_idle_driver =3D {
+	.name             =3D "omap3430_idle",
+	.owner            =3D THIS_MODULE,
+	.states =3D {
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 110 + 162,
+			.target_residency =3D 5,
+			.name		  =3D "C1",
+			.desc		  =3D "MPU ON + CORE ON",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 106 + 180,
+			.target_residency =3D 309,
+			.name		  =3D "C2",
+			.desc		  =3D "MPU ON + CORE ON",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 107 + 410,
+			.target_residency =3D 46057,
+			.name		  =3D "C3",
+			.desc		  =3D "MPU RET + CORE ON",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 121 + 3374,
+			.target_residency =3D 46057,
+			.name		  =3D "C4",
+			.desc		  =3D "MPU OFF + CORE ON",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 855 + 1146,
+			.target_residency =3D 46057,
+			.name		  =3D "C5",
+			.desc		  =3D "MPU RET + CORE RET",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 7580 + 4134,
+			.target_residency =3D 484329,
+			.name		  =3D "C6",
+			.desc		  =3D "MPU OFF + CORE RET",
+		},
+		{
+			.enter		  =3D omap3_enter_idle_bm,
+			.exit_latency	  =3D 7505 + 15274,
+			.target_residency =3D 484329,
+			.name		  =3D "C7",
+			.desc		  =3D "MPU OFF + CORE OFF",
+		},
+	},
+	.state_count =3D ARRAY_SIZE(omap3_idle_data),
+	.safe_state_index =3D 0,
+};
+
 /* Public functions */
=20
 /**
@@ -333,5 +397,8 @@ int __init omap3_idle_init(void)
 	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
 		return -ENODEV;
=20
-	return cpuidle_register(&omap3_idle_driver, NULL);
+	if (cpu_is_omap3430())
+		return cpuidle_register(&omap3430_idle_driver, NULL);
+	else
+		return cpuidle_register(&omap3_idle_driver, NULL);
 }
--=20
1.7.9.5
