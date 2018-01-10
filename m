From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v7 7/8] dt-bindings: can: m_can: Document new can transceiver binding
Date: Wed, 10 Jan 2018 16:25:24 +0530
Message-ID: <1515581725-29242-8-git-send-email-faiz_abbas@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add information regarding can-transceiver binding. This is especially
important for MCAN since the IP allows CAN FD mode to run significantly
faster than what most transceivers are capable of.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/net/can/m_can.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
index 63e9042..ed61438 100644
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
@@ -43,6 +43,11 @@ Required properties:
 			  Please refer to 2.4.1 Message RAM Configuration in
 			  Bosch M_CAN user manual for details.
 
+Optional Subnode:
+- can-transceiver	: Can-transceiver subnode describing maximum speed
+			  that can be used for CAN/CAN-FD modes. See
+			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
+			  for details.
 Example:
 SoC dtsi:
 m_can1: can@20e8000 {
@@ -63,4 +68,8 @@ Board dts:
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_m_can1>;
 	status = "enabled";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
 };
-- 
2.7.4
