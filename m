From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] dt-bindings: mfd: motmdm: Add binding for motorola-mdm
Date: Sun,  9 Feb 2020 20:01:05 -0800
Message-ID: <20200210040107.10306-4-tony@atomide.com>
References: <20200210040107.10306-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210040107.10306-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add a binding document for Motorola modems controllable by
TS 27.010 UART line discipline using serdev drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../mfd/motorola,mapphone-mdm6600.yaml        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml

diff --git a/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml b/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/motorola,mapphone-mdm6600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola Mapphone MDM6600 Modem
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+allOf:
+  - $ref: "motorola,mapphone-mdm6600.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: motorola,mapphone-mdm6600-serial
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb
+
+required:
+  - compatible
+  - phys
+  - phy-names
+
+examples:
+  - |
+    modem {
+        compatible = "motorola,mapphone-mdm6600-serial";
+        phys = <&fsusb1_phy>;
+        phy-names = "usb";
+    };
-- 
2.25.0
