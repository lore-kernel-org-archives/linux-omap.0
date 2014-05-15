From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] Doc/DT: Add binding doc for lgphilips,lb035q02.txt
Date: Thu, 15 May 2014 13:10:37 +0300
Message-ID: <1400148637-17726-4-git-send-email-tomi.valkeinen@ti.com>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46074 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbaEOKLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 06:11:22 -0400
In-Reply-To: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add DT bindings documentation for LG.Philips LB035Q02 LCD panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/video/lgphilips,lb035q02.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt

diff --git a/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
new file mode 100644
index 000000000000..1a1e653e5407
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
@@ -0,0 +1,33 @@
+LG.Philips LB035Q02 Panel
+=========================
+
+Required properties:
+- compatible: "lgphilips,lb035q02"
+- enable-gpios: panel enable gpio
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
+	compatible = "lgphilips,lb035q02";
+	reg = <0>;
+	spi-max-frequency = <100000>;
+	spi-cpol;
+	spi-cpha;
+
+	label = "lcd";
+
+	enable-gpios = <&gpio7 7 0>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
-- 
1.9.1

