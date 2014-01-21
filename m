From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 37/41] Doc/DT: Add DT binding documentation for MIPI DPI Panel
Date: Tue, 21 Jan 2014 12:57:09 +0200
Message-ID: <1390301833-24944-38-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578AbaAULB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:26 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT binding documentation for MIPI DPI Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/panel-dpi.txt        | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
new file mode 100644
index 000000000000..72636c6f1c67
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
@@ -0,0 +1,43 @@
+Generic MIPI DPI Panel
+======================
+
+Required properties:
+- compatible: "panel-dpi"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel enable gpio and backlight enable gpio
+
+Required nodes:
+- "panel-timing" containing video timings
+  (Documentation/devicetree/bindings/video/display-timing.txt)
+- Video port for DPI input
+
+Example
+-------
+
+lcd0: display@0 {
+        compatible = "samsung,lte430wq-f0c", "panel-dpi";
+        label = "lcd";
+
+        lcd_in: endpoint {
+                remote-endpoint = <&dpi_out>;
+        };
+
+        panel-timing {
+                clock-frequency = <9200000>;
+                hactive = <480>;
+                vactive = <272>;
+                hfront-porch = <8>;
+                hback-porch = <4>;
+                hsync-len = <41>;
+                vback-porch = <2>;
+                vfront-porch = <4>;
+                vsync-len = <10>;
+
+                hsync-active = <0>;
+                vsync-active = <0>;
+                de-active = <1>;
+                pixelclk-active = <1>;
+        };
+};
-- 
1.8.3.2

