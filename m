From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/8] ARM: dts: OMAP443x: move CPU OPP tables to device tree
Date: Thu, 14 Mar 2013 15:58:11 -0500
Message-ID: <1363294695-658-5-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add DT OPP table for OMAP443x family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

This is in preparation to use generic cpu0-cpufreq driver.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi       |   10 ++++++++++
 arch/arm/mach-omap2/opp4xxx_data.c |    8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 739bb79..08983a3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -31,6 +31,16 @@
 		cpu@0 {
 			compatible =3D "arm,cortex-a9";
 			next-level-cache =3D <&L2>;
+			/* OMAP4430 variants OPP50-OPPNT */
+			operating-points =3D <
+				/* kHz    uV */
+				300000  1025000
+				600000  1200000
+				800000  1313000
+				1008000 1375000
+			>;
+			clock-latency =3D <300000>; /* From omap-cpufreq driver */
+			voltage-tolerance =3D <2>; /* 2 % */
 		};
 		cpu@1 {
 			compatible =3D "arm,cortex-a9";
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/o=
pp4xxx_data.c
index 1ef7a3e..478e2ee 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -65,14 +65,6 @@ struct omap_volt_data omap443x_vdd_core_volt_data[] =
=3D {
=20
=20
 static struct omap_opp_def __initdata omap443x_opp_def_list[] =3D {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV)=
,
-	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV=
),
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50=
_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
--=20
1.7.9.5

