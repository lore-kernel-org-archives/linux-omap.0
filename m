From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 1/8] dt-bindings: add img,pvrsgx.yaml for Imagination GPUs
Date: Tue, 17 Dec 2019 19:01:59 +0100
Message-ID: <aedc895985d966cf709d153d5b0bed07f59bdcfd.1576605726.git.hns@goldelico.com>
References: <cover.1576605726.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1576605726.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The Imagination PVR/SGX GPU is part of several SoC from
multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
and others.

With this binding, we describe how the SGX processor is
interfaced to the SoC (registers, interrupt etc.).

In most cases, Clock, Reset and power management is handled
by a parent node or elsewhere.

Tested by make dt_binding_check dtbs_check

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml

diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
new file mode 100644
index 000000000000..44799774e34d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/img,pvrsgx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination PVR/SGX GPU
+
+maintainers:
+  - H. Nikolaus Schaller <hns@goldelico.com>
+
+description: |+
+  This binding describes the Imagination SGX5 series of 3D accelerators which
+  are found in several different SoC like TI OMAP, Sitara, Ingenic JZ4780,
+  Allwinner A83, and Intel Poulsbo and CedarView and more.
+
+  For an almost complete list see: https://en.wikipedia.org/wiki/PowerVR#Implementations
+  
+  Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently covered by
+  this binding but the extension of the pattern is straightforward.
+  
+  The SGX node is usually a child node of some DT node belonging to the SoC
+  which handles clocks, reset and general address space mapping of the SGX
+  register area.
+
+properties:
+  compatible:
+    enum:
+    # Example: BeagleBoard A/B/C, OpenPandora 600MHz
+      - ti,omap3-sgx530-121, img,sgx530-121, img,sgx530
+    # Example: BeagleBoard XM, GTA04, OpenPandora 1GHz
+      - ti,omap3-sgx530-125, img,sgx530-125, img,sgx530
+    # Example: BeagleBone Black
+      - ti,am3352-sgx530-125, img,sgx530-125, img,sgx530
+    # Example: Pandaboard, Pandaboard ES
+      - ti,omap4-sgx540-120, img,sgx540-120, img,sgx540
+      - ti,omap4-sgx544-112, img,sgx544-112, img,sgx544
+    # Example: OMAP5 UEVM, Pyra Handheld
+      - ti,omap5-sgx544-116, img,sgx544-116, img,sgx544
+      - ti,dra7-sgx544-116, img,sgx544-116, img,sgx544
+    # Example: CI20
+      - ingenic,jz4780-sgx540-120, img,sgx540-120, img,sgx540
+    # the following entries are not validated with real hardware
+    # more TI SoC
+      - ti,am3517-sgx530-125, img,sgx530-125, img,sgx530
+      - ti,am4-sgx530-125, img,sgx530-125, img,sgx530
+      - ti,ti81xx-sgx530-125, img,sgx530-125, img,sgx530
+    # Example: Banana-Pi-M3 (Allwinner A83T)
+      - allwinner,sun8i-a83t-sgx544-116, img,sgx544-116, img,sgx544
+    # Example: Atom Z5xx
+      - intel,poulsbo-gma500-sgx535, img,sgx535-116, img,sgx535
+    # Example: Atom Z24xx
+      - intel,medfield-gma-sgx540, img,sgx540-116, img,sgx540
+    # Example: Atom N2600, D2500
+      - intel,cedarview-gma3600-sgx545, img,sgx545-116, img,sgx545
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@fe00 {
+      compatible = "ti,omap-omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5";
+      reg = <0xfe00 0x200>;
+      interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
-- 
2.23.0
