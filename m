From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 1/5] dt-bindings: media: ti-vpe: Document VPE driver
Date: Mon, 4 Nov 2019 14:38:37 -0600
Message-ID: <20191104203841.3628-2-bparrot@ti.com>
References: <20191104203841.3628-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104203841.3628-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Device Tree bindings for the Video Processing Engine (VPE).

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../devicetree/bindings/media/ti,vpe.yaml     | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti,vpe.yaml

diff --git a/Documentation/devicetree/bindings/media/ti,vpe.yaml b/Documentation/devicetree/bindings/media/ti,vpe.yaml
new file mode 100644
index 000000000000..eb9f3e1b7f5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,vpe.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/ti,vpe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DRA7x Video Processing Engine (VPE) Device Tree Bindings
+
+maintainers:
+  - Benoit Parrot <bparrot@ti.com>
+
+description: |-
+  The Video Processing Engine (VPE) is a key component for image post
+  processing applications. VPE consist of a single memory to memory
+  path which can perform chroma up/down sampling, deinterlacing,
+  scaling and color space conversion.
+
+properties:
+  compatible:
+      const: ti,dra7-vpe
+
+  reg:
+    items:
+      - description: The VPE main register region
+      - description: Scaler (SC) register region
+      - description: Color Space Conversion (CSC) register region
+      - description: Video Port Direct Memory Access (VPDMA) register region
+
+  reg-names:
+    items:
+      - const: vpe_top
+      - const: sc
+      - const: csc
+      - const: vpdma
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    vpe: vpe@489d0000 {
+        compatible = "ti,dra7-vpe";
+        reg = <0x489d0000 0x120>,
+              <0x489d0700 0x80>,
+              <0x489d5700 0x18>,
+              <0x489dd000 0x400>;
+        reg-names = "vpe_top",
+                    "sc",
+                    "csc",
+                    "vpdma";
+        interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d360df48f9f2..baf3aac1ab7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16316,6 +16316,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/platform/ti-vpe/
 F:	Documentation/devicetree/bindings/media/ti,cal.yaml
+F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
-- 
2.17.1
