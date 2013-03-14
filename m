From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/8] ARM: dts: OMAP3: use twl4030 vdd1 regulator for CPU
Date: Thu, 14 Mar 2013 15:58:10 -0500
Message-ID: <1363294695-658-4-git-send-email-nm@ti.com>
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

Define VDD1 regulator in twl4030 DT and mark it as the supply for the
various OMAP3 platforms.

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
 arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ++++++
 arch/arm/boot/dts/omap3-beagle.dts    |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts       |    6 ++++++
 arch/arm/boot/dts/twl4030.dtsi        |    6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/=
omap3-beagle-xm.dts
index 3705a81..7152746 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -13,6 +13,12 @@
 	model =3D "TI OMAP3 BeagleBoard xM";
 	compatible =3D "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
=20
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&vcc>;
+		};
+	};
+
 	memory {
 		device_type =3D "memory";
 		reg =3D <0x80000000 0x20000000>; /* 512 MB */
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/oma=
p3-beagle.dts
index f624dc8..8886617 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -13,6 +13,12 @@
 	model =3D "TI OMAP3 BeagleBoard";
 	compatible =3D "ti,omap3-beagle", "ti,omap3";
=20
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&vcc>;
+		};
+	};
+
 	memory {
 		device_type =3D "memory";
 		reg =3D <0x80000000 0x10000000>; /* 256 MB */
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-=
evm.dts
index e8ba1c2..d36d19f 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -13,6 +13,12 @@
 	model =3D "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
 	compatible =3D "ti,omap3-evm", "ti,omap3";
=20
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&vcc>;
+		};
+	};
+
 	memory {
 		device_type =3D "memory";
 		reg =3D <0x80000000 0x10000000>; /* 256 MB */
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030=
=2Edtsi
index ed0bc95..608f2e6 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -23,6 +23,12 @@
 		compatible =3D "ti,twl4030-wdt";
 	};
=20
+	vcc: regulator-vdd1 {
+		compatible =3D "ti,twl4030-vdd1";
+		regulator-min-microvolt =3D <600000>;
+		regulator-max-microvolt =3D <1450000>;
+	};
+
 	vdac: regulator-vdac {
 		compatible =3D "ti,twl4030-vdac";
 		regulator-min-microvolt =3D <1800000>;
--=20
1.7.9.5

