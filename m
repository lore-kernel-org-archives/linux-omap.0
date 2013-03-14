From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/8] ARM: dts: OMAP446x: move CPU OPP tables to device tree
Date: Thu, 14 Mar 2013 15:58:13 -0500
Message-ID: <1363294695-658-7-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47559 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3CNU7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 16:59:10 -0400
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

OMAP4430 and 4460 have different OPP definitions. So, create an SoC
variant dtsi file for 4460 and move the OPP definitions to it.
Add DT OPP table for OMAP446x family of devices. This data is
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
 arch/arm/boot/dts/omap4-panda-es.dts |    2 +-
 arch/arm/boot/dts/omap446x.dtsi      |   27 ++++++++++++++++++++++++++=
+
 arch/arm/mach-omap2/opp4xxx_data.c   |   15 ---------------
 3 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap446x.dtsi

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/o=
map4-panda-es.dts
index 6422d7c..c52455b 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap4.dtsi"
+/include/ "omap446x.dtsi"
 /include/ "omap4-panda-common.dtsi"
=20
 /* Audio routing is differnet between PandaBoard4430 and PandaBoardES =
*/
diff --git a/arch/arm/boot/dts/omap446x.dtsi b/arch/arm/boot/dts/omap44=
6x.dtsi
new file mode 100644
index 0000000..8f7a080
--- /dev/null
+++ b/arch/arm/boot/dts/omap446x.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for OMAP446x SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *
+ * This file is licensed under the terms of the GNU General Public Lic=
ense
+ * version 2.  This program is licensed "as is" without any warranty o=
f any
+ * kind, whether express or implied.
+ */
+
+/include/ "omap4.dtsi"
+
+/ {
+	cpus {
+		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
+		cpu@0 {
+			operating-points =3D <
+				/* kHz    uV */
+				350000   975000
+				700000  1075000
+				920000  1200000
+			>;
+			clock-latency =3D <300000>; /* From omap-cpufreq driver */
+			voltage-tolerance =3D <2>; /* 2 % */
+		};
+	};
+};
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/o=
pp4xxx_data.c
index 478e2ee..4c5c038 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -116,21 +116,6 @@ struct omap_volt_data omap446x_vdd_core_volt_data[=
] =3D {
 };
=20
 static struct omap_opp_def __initdata omap446x_opp_def_list[] =3D {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 350000000, OMAP4460_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 700000000, OMAP4460_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", true, 920000000, OMAP4460_VDD_MPU_OPPTURBO_UV)=
,
-	/*
-	 * MPU OPP4 - OPP-Nitro + Disabled as the reference schematics
-	 * recommends TPS623631 - confirm and enable the opp in board file
-	 * XXX: May be we should enable these based on mpu capability and
-	 * Exception board files disable it...
-	 */
-	OPP_INITIALIZER("mpu", false, 1200000000, OMAP4460_VDD_MPU_OPPNITRO_U=
V),
-	/* MPU OPP4 - OPP-Nitro SpeedBin */
-	OPP_INITIALIZER("mpu", false, 1500000000, OMAP4460_VDD_MPU_OPPNITRO_U=
V),
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4460_VDD_CORE_OPP50=
_UV),
 	/* L3 OPP2 - OPP100 */
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
