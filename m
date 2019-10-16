From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V5 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Wed, 16 Oct 2019 08:51:46 -0500
Message-ID: <20191016135147.7743-2-aford173@gmail.com>
References: <20191016135147.7743-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016135147.7743-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds documentation of device tree bindings for the WVGA panel
Logic PD Type 28 display.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V5:  Replace GPIO_ACTIVE_HIGH with 0 to fix make dt_binding_check -k
V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
V3:  Correct build errors from 'make dt_binding_check'
V2:  Use YAML instead of TXT for binding

diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
new file mode 100644
index 000000000000..2834287b8d88
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
+
+maintainers:
+  - Adam Ford <aford173@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: logicpd,type28
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    lcd0: display {
+      compatible = "logicpd,type28";
+      enable-gpios = <&gpio5 27 0>;
+      backlight = <&backlight>;
+      port {
+        lcd_in: endpoint {
+          remote-endpoint = <&dpi_out>;
+        };
+      };
+    };
+
+...
-- 
2.17.1
