From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 3/7] regulator: Add DT bindings for tps65218 PMIC regulators.
Date: Wed, 9 Jul 2014 11:06:29 +0530
Message-ID: <1404884193-20580-4-git-send-email-j-keerthy@ti.com>
References: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com, broonie@kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DT bindings for tps65218 PMIC regulators.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 .../devicetree/bindings/regulator/tps65218.txt     |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.txt

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
new file mode 100644
index 0000000..fccc1d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -0,0 +1,23 @@
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
+  - "ti,tps65218-ldo1" for LDO1
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+	xyz: regulator@0 {
+		compatible = "ti,tps65218-dcdc1";
+		regulator-min-microvolt  = <1000000>;
+		regulator-max-microvolt  = <3000000>;
+	};
-- 
1.7.9.5
