From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 40/41] Doc/DT: Add DT binding documentation for TFP410 encoder
Date: Tue, 21 Jan 2014 12:57:12 +0200
Message-ID: <1390301833-24944-41-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38895 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbaAULBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:47 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT binding documentation for TFP410 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/ti,tfp410.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tfp410.txt b/Documentation/devicetree/bindings/video/ti,tfp410.txt
new file mode 100644
index 000000000000..6a5a04627584
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tfp410.txt
@@ -0,0 +1,41 @@
+TFP410 DPI to DVI encoder
+=========================
+
+Required properties:
+- compatible: "ti,tfp410"
+
+Optional properties:
+- gpios: power-down gpio
+
+Required nodes:
+- Video port 0 for DPI input
+- Video port 1 for DVI output
+
+Example
+-------
+
+tfp410: encoder@0 {
+	compatible = "ti,tfp410";
+	gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tfp410_in: endpoint@0 {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			tfp410_out: endpoint@0 {
+				remote-endpoint = <&dvi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2

