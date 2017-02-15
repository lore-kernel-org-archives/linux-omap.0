From: yegorslists@googlemail.com
Subject: [PATCH v3 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Wed, 15 Feb 2017 15:48:44 +0100
Message-ID: <1487170125-10815-3-git-send-email-yegorslists@googlemail.com>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, tony@atomide.com, mkl@pengutronix.de, andrej.skvortzov@gmail.com, hs@denx.de, anton.a.glukhov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

DT binding documentation for TI High End CAN Controller

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .../devicetree/bindings/net/can/ti_hecc.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
new file mode 100644
index 0000000..8257428
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
@@ -0,0 +1,32 @@
+Texas Instruments High End CAN Controller (HECC)
+================================================
+
+This file provides information, what the device node
+for the hecc interface contains.
+
+Required properties:
+- compatible: "ti,am3517-hecc"
+- reg: addresses and lengths of the register spaces for 'hecc', 'hecc-ram'
+       and 'mbx'
+- reg-names :"hecc", "hecc-ram", "mbx"
+- interrupts: interrupt mapping for the hecc interrupts sources
+- clocks: clock phandles (see clock bindings for details)
+
+Optional properties:
+- ti,use-hecc1int: if provided configures HECC to produce all interrupts
+		   on HECC1INT interrupt line. By default HECC0INT interrupt
+		   line will be used.
+
+Example:
+
+For am3517evm board:
+	hecc: can@0x5c050000 {
+		compatible = "ti,am3517-hecc";
+		status = "disabled";
+		reg = <0x5c050000 0x80>,
+		      <0x5c053000 0x180>,
+		      <0x5c052000 0x200>;
+		reg-names = "hecc", "hecc-ram", "mbx";
+		interrupts = <24>;
+		clocks = <&hecc_ck>;
+	};
-- 
2.1.4

