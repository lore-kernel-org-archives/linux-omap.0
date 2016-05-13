From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 1/2] Documentation: mfd: LP873X: Add information for the mfd and regulator drivers
Date: Fri, 13 May 2016 09:18:09 +0530
Message-ID: <1463111290-12377-2-git-send-email-j-keerthy@ti.com>
References: <1463111290-12377-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463111290-12377-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add information for the mfd and regulator drivers.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v3:

  * Changed the example node lable to pmic from lp8733.

 Documentation/devicetree/bindings/mfd/lp873x.txt | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt

diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
new file mode 100644
index 0000000..8f3ef0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
@@ -0,0 +1,55 @@
+TI LP3943 MFD driver
+
+Required properties:
+  - compatible: "ti,lp8732", "ti,lp8733"
+  - reg: I2C slave address.
+
+For the lp873x regulator properties please refer to:
+../bindings/regulator/lp873x.txt
+
+Example:
+
+pmic: lp8733@60 {
+	compatible = "ti,lp8733";
+	reg = <0x60>;
+
+	regulators {
+		lp8733_buck0: buck0 {
+			regulator-name = "lp8733-buck0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-min-microamp = <1500000>;
+			regulator-max-microamp = <4000000>;
+			regulator-ramp-delay = <10000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		lp8733_buck1: buck1 {
+			regulator-name = "lp8733-buck1";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-min-microamp = <1500000>;
+			regulator-max-microamp = <4000000>;
+			regulator-ramp-delay = <10000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		lp8733_ldo0: ldo0 {
+			regulator-name = "lp8733-ldo0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		lp8733_ldo1: ldo1 {
+			regulator-name = "lp8733-ldo1";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
-- 
1.9.1
