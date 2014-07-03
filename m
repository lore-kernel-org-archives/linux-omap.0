From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/4] Doc/DT: Add SiI9022 binding documentation
Date: Thu, 3 Jul 2014 16:39:58 +0300
Message-ID: <1404394800-18138-3-git-send-email-tomi.valkeinen@ti.com>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417AbaGCNkg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 09:40:36 -0400
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add DT binding documentation for Silicon Image SiI9022 HDMI encoder.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/video/sil,sii9022.txt      | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sil,sii9022.txt

diff --git a/Documentation/devicetree/bindings/video/sil,sii9022.txt b/Documentation/devicetree/bindings/video/sil,sii9022.txt
new file mode 100644
index 000000000000..0cd926636998
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sil,sii9022.txt
@@ -0,0 +1,53 @@
+Silicon Image SiI9022 HDMI Encoder
+==================================
+
+Silicon Image SiI9022 is an HDMI encoder that encodes parallel RGB
+signal to HDMI signal. The SiI9022 is controlled with i2c command, and
+it has a single reset pin and single interrupt pin.
+
+Required properties:
+- compatible: "sil,sii9022"
+
+Optional properties:
+- reset-gpio: reset gpio
+- interrupts: interrupt line
+
+Required nodes:
+- Video port 0 for parallel video input
+- Video port 1 for HDMI output
+
+Example
+-------
+
+&i2c2 {
+	sii9022: sii9022@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		reset-gpio = <&gpio2 1 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
-- 
1.9.1

