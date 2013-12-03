From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] ARM: dts: AM437x: Add TPS65218 device tree nodes
Date: Tue, 3 Dec 2013 12:13:25 +0530
Message-ID: <1386053006-6480-5-git-send-email-j-keerthy@ti.com>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: j-keerthy@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add TPS65218 device tree nodes. This patch is tested on am43x-epos-evm board.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..ad7000a 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -156,6 +156,47 @@
 		reg = <0x50>;
 	};
 
+	tps65218: tps65218@24 {
+		reg = <0x24>;
+		compatible = "ti,tps65218";
+		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		dcdc1: regulator-dcdc1 {
+			compatible = "ti,tps65218-dcdc1";
+			/* VDD_CORE voltage limits min of OPP50 and max of OPP100 */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <1144000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc2: regulator-dcdc2 {
+			compatible = "ti,tps65218-dcdc2";
+			/* VDD_MPU voltage limits min of OPP50 and max of OPP_NITRO */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <1378000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc3: regulator-dcdc3 {
+			compatible = "ti,tps65218-dcdc3";
+		};
+
+		ldo1: regulator-ldo1 {
+			compatible = "ti,tps65218-ldo1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+
 	pixcir_ts@5c {
 		compatible = "pixcir,pixcir_ts";
 		reg = <0x5c>;
-- 
1.7.9.5

