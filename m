From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v7 8/8] dt-bindings: can: can-transceiver: Document new binding
Date: Wed, 10 Jan 2018 16:25:25 +0530
Message-ID: <1515581725-29242-9-git-send-email-faiz_abbas@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add documentation to describe usage of the new can-transceiver binding.
This new binding is applicable for any CAN device therefore it exists as
its own document.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../bindings/net/can/can-transceiver.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.txt b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
new file mode 100644
index 0000000..0011f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
@@ -0,0 +1,24 @@
+Generic CAN transceiver Device Tree binding
+------------------------------
+
+CAN transceiver typically limits the max speed in standard CAN and CAN FD
+modes. Typically these limitations are static and the transceivers themselves
+provide no way to detect this limitation at runtime. For this situation,
+the "can-transceiver" node can be used.
+
+Required Properties:
+ max-bitrate:	a positive non 0 value that determines the max
+		speed that CAN/CAN-FD can run. Any other value
+		will be ignored.
+
+Examples:
+
+Based on Texas Instrument's TCAN1042HGV CAN Transceiver
+
+m_can0 {
+	....
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+	...
+};
-- 
2.7.4
