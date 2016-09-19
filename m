From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 2/5] Documentation: regulator: tps65218: Update examples
Date: Mon, 19 Sep 2016 13:09:03 +0530
Message-ID: <1474270746-11568-3-git-send-email-j-keerthy@ti.com>
References: <1474270746-11568-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474270746-11568-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: j-keerthy-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This updates the Device Tree according to the preferred way of parsing
the nodes using the regulator framework.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
