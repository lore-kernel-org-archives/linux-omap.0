From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/8] ARM: dts: OMAP36xx: move CPU OPP tables to device tree
Date: Thu, 14 Mar 2013 15:58:09 -0500
Message-ID: <1363294695-658-3-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38005 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab3CNU7J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 16:59:09 -0400
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Add DT OPP table for OMAP36xx family of devices. This data is
decoded by OF with of_init_opp_table() helper function. This
overrides the default OMAP34xx CPU OPP table definition.

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
 arch/arm/boot/dts/omap36xx.dtsi    |   12 ++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c |    9 ---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36=
xx.dtsi
index 96bf028..743eaa1 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -15,6 +15,18 @@
 		serial3 =3D &uart4;
 	};
=20
+	cpus {
+		/* OMAP3630 'standard device' variants OPP50 to OPP130 */
+		cpu@0 {
+			operating-points =3D <
+				/* kHz    uV */
+				300000   975000
+				600000  1075000
+				800000  1200000
+			>;
+			clock-latency =3D <300000>; /* From omap-cpufreq driver */
+		};
+	};
 	ocp {
 		uart4: serial@49042000 {
 			compatible =3D "ti,omap3-uart";
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/o=
pp3xxx_data.c
index 1de18c2..cf7b3ab 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -114,15 +114,6 @@ static struct omap_opp_def __initdata omap34xx_opp=
_def_list[] =3D {
 };
=20
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] =3D {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true,  300000000, OMAP3630_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true,  600000000, OMAP3630_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, OMAP3630_VDD_MPU_OPP120_UV),
-	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1000000000, OMAP3630_VDD_MPU_OPP1G_UV),
-
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main", true, 100000000, OMAP3630_VDD_CORE_OPP50_U=
V),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
