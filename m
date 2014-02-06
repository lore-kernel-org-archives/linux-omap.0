From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/4] mfd: DT bindings for TPS65218 PMIC
Date: Thu, 6 Feb 2014 11:20:11 +0530
Message-ID: <1391665814-18814-2-git-send-email-j-keerthy@ti.com>
References: <1391665814-18814-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1391665814-18814-1-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: j-keerthy@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add DT bindings for TPS65218 PMIC.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/mfd/tps65218.txt |   58 ++++++++++++++++++++
 .../devicetree/bindings/regulator/tps65218.txt     |   22 ++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65218.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.txt

diff --git a/Documentation/devicetree/bindings/mfd/tps65218.txt b/Documentation/devicetree/bindings/mfd/tps65218.txt
new file mode 100644
index 0000000..5845df7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/tps65218.txt
@@ -0,0 +1,58 @@
+The TPS65218 Integrated Power Management Chips.
+These chips are connected to an I2C bus.
+
+Required properties:
+- compatible : Must be "ti,tps65218";
+- interrupts : This I2C device has an IRQ line connected to the main SoC
+- interrupt-controller : Since the tps65218 supports several interrupts
+  internally, it is considered as an interrupt controller cascaded to the SoC.
+- #interrupt-cells = <2>;
+- interrupt-parent : The parent interrupt controller GIC.
+
+Optional nodes:
+- TPS65218 chip has sub modules. Mainly the DCDCs and regulators.
+
+Example:
+/*
+ * Integrated Power Management Chip
+ */
+tps65218: tps65218@24 {
+	reg = <0x24>;
+	compatible = "ti,tps65218";
+	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
+	interrupt-parent = <&gic>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	dcdc1: regulator-dcdc1 {
+		compatible = "ti,tps65218-dcdc1";
+		/* VDD_CORE voltage limits min of OPP50 and max of OPP100 */
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <912000>;
+		regulator-max-microvolt = <1144000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc2: regulator-dcdc2 {
+		compatible = "ti,tps65218-dcdc2";
+		/* VDD_MPU voltage limits min of OPP50 and max of OPP_NITRO */
+		regulator-name = "vdd_mpu";
+		regulator-min-microvolt = <912000>;
+		regulator-max-microvolt = <1378000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc3: regulator-dcdc3 {
+		compatible = "ti,tps65218-dcdc3";
+	};
+
+	ldo1: regulator-ldo1 {
+		compatible = "ti,tps65218-ldo1";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
new file mode 100644
index 0000000..17d200a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -0,0 +1,22 @@
+TPS65218 family of regulators
+
+Required properties:
+For tps65218 regulators/LDOs
+- compatible:
+  - "ti,tps65218-dcdc1" for DCDC1
+  - "ti,tps65218-dcdc2" for DCDC2
+  - "ti,tps65218-dcdc3" for DCDC3
+  - "ti,tps65218-dcdc4" for DCDC4
+  - "ti,tps65218-dcdc5" for DCDC5
+  - "ti,tps65218-dcdc6" for DCDC6
+  - "ti,tps65218-ldo1" for LDO1 LDO
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+	xyz: regulator-dcdc1 {
+		compatible = "ti,tps65218-dcdc1";
+		regulator-min-microvolt  = <1000000>;
+		regulator-max-microvolt  = <3000000>;
+	};
-- 
1.7.9.5

