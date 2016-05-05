From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] Documentation: mfd/regulator: LP873X: Add information for the mfd and regulator drivers
Date: Thu, 5 May 2016 10:40:38 +0530
Message-ID: <1462425040-18566-2-git-send-email-j-keerthy@ti.com>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462425040-18566-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add information for the mfd and regulator drivers.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/lp873x.txt   | 56 +++++++++++++
 .../devicetree/bindings/regulator/lp873x.txt       | 98 ++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/lp873x.txt

diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
new file mode 100644
index 0000000..050d822
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
@@ -0,0 +1,56 @@
+TI LP3943 MFD driver
+
+Required properties:
+  - compatible: "ti,lp873x", "ti,lp8732", "ti,lp8733"
+  - reg: I2C slave address.
+
+For the lp873x regulator properties please refer to:
+Documentation/devicetree/bindings/regulator/lp873x.txt
+
+Example:
+
+lp8733: lp8733@60 {
+	compatible = "ti,lp8733";
+	reg = <0x60>;
+
+	regulators {
+		compatible = "ti,lp8733-regulators";
+		buck0 {
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
+		buck1 {
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
+		ldo0 {
+			regulator-name = "lp8733-ldo0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1 {
+			regulator-name = "lp8733-ldo1";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/regulator/lp873x.txt b/Documentation/devicetree/bindings/regulator/lp873x.txt
new file mode 100644
index 0000000..079d8a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/lp873x.txt
@@ -0,0 +1,98 @@
+LP873X family of regulators
+
+Required properties:
+For lp873x Bucks/LDOs
+- compatible:
+  - "ti,lp8733-regulators" for lp8733 PMIC
+  - "ti,lp8732-regulators" for lp8732 PMIC
+  - "ti,lp873x-regulators" for lp8732 PMIC
+
+Examples:
+
+1) LP8733 Regulators:
+
+regulators {
+	compatible = "ti,lp8733-regulators";
+
+	buck0 {
+		regulator-name = "lp8733-buck0";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-min-microamp = <1500000>;
+		regulator-max-microamp = <4000000>;
+		regulator-ramp-delay = <10000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	buck1 {
+		regulator-name = "lp8733-buck1";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-min-microamp = <1500000>;
+		regulator-max-microamp = <4000000>;
+		regulator-ramp-delay = <10000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ldo0 {
+		regulator-name = "lp8733-ldo0";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ldo1 {
+		regulator-name = "lp8733-ldo1";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+1) LP8732 Regulators:
+
+regulators {
+	compatible = "ti,lp8732-regulators";
+
+	buck0 {
+		regulator-name = "lp8732-buck0";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-min-microamp = <1500000>;
+		regulator-max-microamp = <4000000>;
+		regulator-ramp-delay = <10000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	buck1 {
+		regulator-name = "lp8732-buck1";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-min-microamp = <1500000>;
+		regulator-max-microamp = <4000000>;
+		regulator-ramp-delay = <10000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ldo0 {
+		regulator-name = "lp8732-ldo0";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ldo1 {
+		regulator-name = "lp8732-ldo1";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
