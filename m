From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 2/6] Documentation: regulator: tps65218: Update examples
Date: Tue, 28 Jun 2016 18:00:50 +0530
Message-ID: <1467117054-12943-3-git-send-email-j-keerthy@ti.com>
References: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This updates the Device Tree according to the preferred way of parsing
the nodes using the regulator framework.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
Changes in v4:

  * Formatted and corrected typos in few lines.
  * Used relative path names for the file names.

 .../devicetree/bindings/regulator/tps65218.txt     | 87 ++++++++++++++++++----
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index fccc1d2..02f0e9b 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -1,23 +1,78 @@
 TPS65218 family of regulators
 
 Required properties:
-For tps65218 regulators/LDOs
-- compatible:
-  - "ti,tps65218-dcdc1" for DCDC1
-  - "ti,tps65218-dcdc2" for DCDC2
-  - "ti,tps65218-dcdc3" for DCDC3
-  - "ti,tps65218-dcdc4" for DCDC4
-  - "ti,tps65218-dcdc5" for DCDC5
-  - "ti,tps65218-dcdc6" for DCDC6
-  - "ti,tps65218-ldo1" for LDO1
-
-Optional properties:
-- Any optional property defined in bindings/regulator/regulator.txt
+- compatible: "ti,tps65218"
+- reg: I2C slave address
+
+- List of regulators provided by this controller, must be named
+  after their hardware counterparts: dcdc[1-6] and ldo1
+- This is the list of child nodes that specify the regulator
+  initialization data for defined regulators. Not all regulators for the given
+  device need to be present. The definition for each of these nodes is defined
+  using the standard binding for regulators found at ./regulator.txt.
+
+  The valid names for regulators are:
+  tps65217: regulator-dcdc1, regulator-dcdc2, regulator-dcdc3, regulator-dcdc4,
+  regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
+  Each regulator is defined using the standard binding for regulators.
 
 Example:
+tps65218: tps65218@24 {
+	reg = <0x24>;
+	compatible = "ti,tps65218";
+	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	dcdc1: regulator-dcdc1 {
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <912000>;
+		regulator-max-microvolt = <1144000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc2: regulator-dcdc2 {
+		regulator-name = "vdd_mpu";
+		regulator-min-microvolt = <912000>;
+		regulator-max-microvolt = <1378000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc3: regulator-dcdc3 {
+		regulator-name = "vdcdc3";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc5: regulator-dcdc5 {
+		regulator-name = "v1_0bat";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	dcdc6: regulator-dcdc6 {
+		regulator-name = "v1_8bat";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ldo1: regulator-ldo1 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 
-	xyz: regulator@0 {
-		compatible = "ti,tps65218-dcdc1";
-		regulator-min-microvolt  = <1000000>;
-		regulator-max-microvolt  = <3000000>;
+	ls3: regulator-ls3 {
+		regulator-min-microvolt = <100000>;
+		regulator-max-microvolt = <1000000>;
 	};
+};
-- 
1.9.1
