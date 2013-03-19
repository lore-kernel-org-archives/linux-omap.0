From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/8] ARM: dts: OMAP34xx/35xx: Add CPU OPP table
Date: Tue, 19 Mar 2013 12:53:03 -0500
Message-ID: <1363715590-5131-2-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add DT OPP table for OMAP34xx/35xx family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

OPP data here is based on existing opp3xxx_data.c

Since the omap36xx OPP tables would be different from OMAP34xx/35xx,
introduce an new omap34xx.dtsi for 34xx/35xx specific entries and use
existing omap3.dtsi as the common dtsi file for all OMAP3 platforms.

This is in preparation to use generic cpufreq-cpu0 driver for device
tree enabled boot. Legacy non device tree enabled boot continues to
use omap-cpufreq.c and opp3xxx_data.c.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>
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
Changes in V2:
	- introduce omap34xx.dtsi
	- donot delete the OPP table entries in omap3xxx_data.c
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273571/

 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 arch/arm/boot/dts/omap3-beagle.dts      |    2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts  |    2 +-
 arch/arm/boot/dts/omap3-evm.dts         |    2 +-
 arch/arm/boot/dts/omap3-igep.dtsi       |    2 +-
 arch/arm/boot/dts/omap3-overo.dtsi      |    2 +-
 arch/arm/boot/dts/omap3430-sdp.dts      |    2 +-
 arch/arm/boot/dts/omap34xx.dtsi         |   28 +++++++++++++++++++++++=
+++++
 9 files changed, 36 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap34xx.dtsi

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am351=
7-evm.dts
index 474f760..e9b5bda 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	model =3D "TI AM3517 EVM (AM3517/05)";
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dt=
s/am3517_mt_ventoux.dts
index 5eb26d7..5568683 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	model =3D "TeeJet Mt.Ventoux";
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/oma=
p3-beagle.dts
index f624dc8..418550c 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	model =3D "TI OMAP3 BeagleBoard";
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts=
/omap3-devkit8000.dts
index 54d3da7..8a5cdcc 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
 / {
 	model =3D "TimLL OMAP3 Devkit8000";
 	compatible =3D "timll,omap3-devkit8000", "ti,omap3";
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-=
evm.dts
index 6e6f80d..f14370e 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	model =3D "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap=
3-igep.dtsi
index dd01c46..f8fe3b7 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -10,7 +10,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	memory {
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/oma=
p3-overo.dtsi
index 2d93a08..d4a7280 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -11,7 +11,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	pwmleds {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/oma=
p3430-sdp.dts
index 535a6f9..05cd8ba 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap3.dtsi"
+/include/ "omap34xx.dtsi"
=20
 / {
 	model =3D "TI OMAP3430 SDP";
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34=
xx.dtsi
new file mode 100644
index 0000000..75ed4ae
--- /dev/null
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device Tree Source for OMAP34xx/OMAP35xx SoC
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
+/include/ "omap3.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			/* OMAP343x/OMAP35xx variants OPP1-5 */
+			operating-points =3D <
+				/* kHz    uV */
+				125000   975000
+				250000  1075000
+				500000  1200000
+				550000  1270000
+				600000  1350000
+			>;
+			clock-latency =3D <300000>; /* From legacy driver */
+		};
+	};
+};
--=20
1.7.9.5

