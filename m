From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V2 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Mon, 23 Sep 2019 08:44:48 -0500
Message-ID: <20190923134449.22326-2-aford173@gmail.com>
References: <20190923134449.22326-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923134449.22326-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds documentation of device tree bindings for the WVGA panel
Logic PD Type 28 display.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Use YAML instead of TXT for binding

diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
new file mode 100644
index 000000000000..707e2a17c8c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ronbo,rb070d30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
+
+properties:
+  compatible:
+    const: logicpd,type28
+
+  power-supply:
+    description: Regulator to provide the supply voltage
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO pin to enable or disable the panel
+    maxItems: 1
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+	lcd0: display {
+		compatible = "logicpd,type28";
+		enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
-- 
2.17.1
