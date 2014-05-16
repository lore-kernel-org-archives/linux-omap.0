From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] Doc/DT: Add DT binding documentation for TPO td043mtea1 panel
Date: Fri, 16 May 2014 12:55:11 +0300
Message-ID: <1400234112-29306-2-git-send-email-tomi.valkeinen@ti.com>
References: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45540 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979AbaEPJz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 05:55:27 -0400
In-Reply-To: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Add DT binding documentation for TPO td043mtea1 panel

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>
---
 .../devicetree/bindings/video/tpo,td043mtea1.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/tpo,td043mtea1.txt

diff --git a/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt b/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt
new file mode 100644
index 000000000000..ec6d62975162
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt
@@ -0,0 +1,33 @@
+TPO TD043MTEA1 Panel
+====================
+
+Required properties:
+- compatible: "tpo,td043mtea1"
+- reset-gpios: panel reset gpio
+
+Optional properties:
+- label: a symbolic name for the panel
+
+Required nodes:
+- Video port for DPI input
+
+Example
+-------
+
+lcd-panel: panel@0 {
+	compatible = "tpo,td043mtea1";
+	reg = <0>;
+	spi-max-frequency = <100000>;
+	spi-cpol;
+	spi-cpha;
+
+	label = "lcd";
+
+	reset-gpios = <&gpio7 7 0>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
-- 
1.9.1

