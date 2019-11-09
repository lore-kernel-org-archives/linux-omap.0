From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v6 net-next 06/13] dt-bindings: net: ti: add new cpsw switch driver bindings
Date: Sat, 9 Nov 2019 17:15:18 +0200
Message-ID: <20191109151525.18651-7-grygorii.strashko@ti.com>
References: <20191109151525.18651-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109151525.18651-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add bindings for the new TI CPSW switch driver. Comparing to the legacy
bindings (net/cpsw.txt):
- ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
marked as "disabled" if not physically wired.
- all deprecated properties dropped;
- all legacy propertiies dropped which represent constant HW cpapbilities
(cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
active_slave)
- TI CPTS DT properties are reused as is, but grouped in "cpts" sub-node
- TI Davinci MDIO DT bindings are reused as is, because Davinci MDIO is
reused.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../bindings/net/ti,cpsw-switch.yaml          | 245 ++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
new file mode 100644
index 000000000000..afeb6a4f1ada
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
@@ -0,0 +1,245 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,cpsw-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SoC Ethernet Switch Controller (CPSW) Device Tree Bindings
+
+maintainers:
+  - Grygorii Strashko <grygorii.strashko@ti.com>
+  - Sekhar Nori <nsekhar@ti.com>
+
+description:
+  The 3-port switch gigabit ethernet subsystem provides ethernet packet
+  communication and can be configured as an ethernet switch. It provides the
+  gigabit media independent interface (GMII),reduced gigabit media
+  independent interface (RGMII), reduced media independent interface (RMII),
+  the management data input output (MDIO) for physical layer device (PHY)
+  management.
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,cpsw-switch
+      - items:
+         - const: ti,am335x-cpsw-switch
+         - const: ti,cpsw-switch
+      - items:
+        - const: ti,am4372-cpsw-switch
+        - const: ti,cpsw-switch
+      - items:
+        - const: ti,dra7-cpsw-switch
+        - const: ti,cpsw-switch
+
+  reg:
+    maxItems: 1
+    description:
+       The physical base address and size of full the CPSW module IO range
+
+  ranges: true
+
+  clocks:
+    maxItems: 1
+    description: CPSW functional clock
+
+  clock-names:
+    maxItems: 1
+    items:
+      - const: fck
+
+  interrupts:
+    maxItems: 4
+    items:
+      - description: RX_THRESH interrupt
+      - description: RX interrupt
+      - description: TX interrupt
+      - description: MISC interrupt
+
+  interrupt-names:
+    maxItems: 4
+    items:
+      - const: "rx_thresh"
+      - const: "rx"
+      - const: "tx"
+      - const: "misc"
+
+  pinctrl-names: true
+
+  syscon:
+    $ref: /schemas/types.yaml#definitions/phandle
+    maxItems: 1
+    description:
+      Phandle to the system control device node which provides access to
+      efuse IO range with MAC addresses
+
+
+  ethernet-ports:
+    type: object
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-9]+$":
+          type: object
+          minItems: 1
+          maxItems: 2
+          description: CPSW external ports
+
+          allOf:
+            - $ref: ethernet-controller.yaml#
+
+          properties:
+            reg:
+              maxItems: 1
+              enum: [1, 2]
+              description: CPSW port number
+
+            phys:
+              $ref: /schemas/types.yaml#definitions/phandle-array
+              maxItems: 1
+              description:  phandle on phy-gmii-sel PHY
+
+            label:
+              $ref: /schemas/types.yaml#/definitions/string-array
+              maxItems: 1
+              description: label associated with this port
+
+            ti,dual-emac-pvid:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              maxItems: 1
+              minimum: 1
+              maximum: 1024
+              description:
+                Specifies default PORT VID to be used to segregate
+                ports. Default value - CPSW port number.
+
+          required:
+            - reg
+            - phys
+
+  mdio:
+    type: object
+    allOf:
+      - $ref: "ti,davinci-mdio.yaml#"
+    description:
+      CPSW MDIO bus.
+
+  cpts:
+    type: object
+    description:
+      The Common Platform Time Sync (CPTS) module
+
+    properties:
+      clocks:
+        maxItems: 1
+        description: CPTS reference clock
+
+      clock-names:
+        maxItems: 1
+        items:
+          - const: cpts
+
+      cpts_clock_mult:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
+        description:
+          Numerator to convert input clock ticks into ns
+
+      cpts_clock_shift:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
+        description:
+          Denominator to convert input clock ticks into ns.
+          Mult and shift will be calculated basing on CPTS rftclk frequency if
+          both cpts_clock_shift and cpts_clock_mult properties are not provided.
+
+    required:
+      - clocks
+      - clock-names
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/dra7.h>
+
+    mac_sw: switch@0 {
+        compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
+        reg = <0x0 0x4000>;
+        ranges = <0 0 0x4000>;
+        clocks = <&gmac_main_clk>;
+        clock-names = "fck";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        syscon = <&scm_conf>;
+        inctrl-names = "default", "sleep";
+
+        interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "rx_thresh", "rx", "tx", "misc";
+
+        ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                cpsw_port1: port@1 {
+                        reg = <1>;
+                        label = "port1";
+                        mac-address = [ 00 00 00 00 00 00 ];
+                        phys = <&phy_gmii_sel 1>;
+                        phy-handle = <&ethphy0_sw>;
+                        phy-mode = "rgmii";
+                        ti,dual_emac_pvid = <1>;
+                };
+
+                cpsw_port2: port@2 {
+                        reg = <2>;
+                        label = "wan";
+                        mac-address = [ 00 00 00 00 00 00 ];
+                        phys = <&phy_gmii_sel 2>;
+                        phy-handle = <&ethphy1_sw>;
+                        phy-mode = "rgmii";
+                        ti,dual_emac_pvid = <2>;
+                };
+        };
+
+        davinci_mdio_sw: mdio@1000 {
+                compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+                reg = <0x1000 0x100>;
+                clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 0>;
+                clock-names = "fck";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                bus_freq = <1000000>;
+
+                ethphy0_sw: ethernet-phy@0 {
+                        reg = <0>;
+                };
+
+                ethphy1_sw: ethernet-phy@1 {
+                        reg = <41>;
+                };
+        };
+
+        cpts {
+                clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 25>;
+                clock-names = "cpts";
+        };
+    };
-- 
2.17.1
