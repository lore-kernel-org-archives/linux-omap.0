From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/3] dt-bindings: mfd: lp87565: Add lp87561 configuration
Date: Wed, 15 May 2019 15:38:46 +0530
Message-ID: <20190515100848.19560-2-j-keerthy@ti.com>
References: <20190515100848.19560-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515100848.19560-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

lp87561 is a single output 4-phase regulator configuration.
Add support for the same.

Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../devicetree/bindings/mfd/lp87565.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
index a48df7c08ab0..41671e0dc26b 100644
--- a/Documentation/devicetree/bindings/mfd/lp87565.txt
+++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
@@ -41,3 +41,39 @@ lp87565_pmic: pmic@60 {
 		};
 	};
 };
+
+TI LP87561 PMIC:
+
+This is a single output 4-phase regulator configuration
+
+Required properties:
+  - compatible:	"ti,lp87561-q1"
+  - reg:		I2C slave address.
+  - gpio-controller:	Marks the device node as a GPIO Controller.
+  - #gpio-cells:	Should be two.  The first cell is the pin number and
+			the second cell is used to specify flags.
+			See ../gpio/gpio.txt for more information.
+  - xxx-in-supply:	Phandle to parent supply node of each regulator
+			populated under regulators node. xxx should match
+			the supply_name populated in driver.
+Example:
+
+lp87561_pmic: pmic@62 {
+	compatible = "ti,lp87561-q1";
+	reg = <0x62>;
+	gpio-controller;
+	#gpio-cells = <2>;
+
+	buck3210-in-supply = <&vsys_3v3>;
+
+	regulators: regulators {
+		buck3210_reg: buck3210 {
+			/* VDD_CORE */
+			regulator-name = "buck3210";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
-- 
2.17.1
