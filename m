From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 35/41] Doc/DT: Add DT binding documentation for DVI Connector
Date: Tue, 21 Jan 2014 12:57:07 +0200
Message-ID: <1390301833-24944-36-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39204 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbaAULB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:27 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT binding documentation for DVI Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt

diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
new file mode 100644
index 000000000000..6a0aff866c78
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
@@ -0,0 +1,26 @@
+DVI Connector
+==============
+
+Required properties:
+- compatible: "dvi-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+
+Required nodes:
+- Video port for DVI input
+
+Example
+-------
+
+dvi0: connector@0 {
+	compatible = "dvi-connector";
+	label = "dvi";
+
+	i2c-bus = <&i2c3>;
+
+	dvi_connector_in: endpoint {
+		remote-endpoint = <&tfp410_out>;
+	};
+};
-- 
1.8.3.2

