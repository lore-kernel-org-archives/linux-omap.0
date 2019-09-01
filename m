From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 2/6] dt-bindings: counter: new bindings for TI eQEP
Date: Sun,  1 Sep 2019 17:58:23 -0500
Message-ID: <20190901225827.12301-3-david@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This documents device tree binding for the Texas Instruments Enhanced
Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
- fixed style issues
- fixed generic node name
- (was suggested to drop descriptions since there is only one interrupt and one
  clock, but I opted to keep them anyway)
v2 changes:
- convert to .yaml format
- rename clock to "sysclkout"

 .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
new file mode 100644
index 000000000000..85f1ff83afe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/ti-eqep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
+
+maintainers:
+  - David Lechner <david@lechnology.com>
+
+properties:
+  compatible:
+    const: ti,am3352-eqep
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: The eQEP event interrupt
+    maxItems: 1
+
+  clocks:
+    description: The clock that determines the SYSCLKOUT rate for the eQEP
+      peripheral.
+    maxItems: 1
+
+  clock-names:
+    const: sysclkout
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    eqep0: counter@180 {
+        compatible = "ti,am3352-eqep";
+        reg = <0x180 0x80>;
+        clocks = <&l4ls_gclk>;
+        clock-names = "sysclkout";
+        interrupts = <79>;
+    };
+
+...
-- 
2.17.1
