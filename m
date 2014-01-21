From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 39/41] Doc/DT: Add DT binding documentation for Sony acx565akm panel
Date: Tue, 21 Jan 2014 12:57:11 +0200
Message-ID: <1390301833-24944-40-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbaAULBk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:40 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT binding documentation for Sony acx565akm panel

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/sony,acx565akm.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt

diff --git a/Documentation/devicetree/bindings/video/sony,acx565akm.txt b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
new file mode 100644
index 000000000000..cd9cfdf7e3fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
@@ -0,0 +1,28 @@
+Sony ACX565AKM SDI Panel
+========================
+
+Required properties:
+- compatible: "sony,acx565akm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel reset gpio
+
+Required nodes:
+- Video port for SDI input
+
+Example
+-------
+
+acx565akm@2 {
+	compatible = "sony,acx565akm";
+	spi-max-frequency = <6000000>;
+	reg = <2>;
+
+	label = "lcd";
+	gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
+	lcd_in: endpoint {
+		remote-endpoint = <&sdi_out>;
+	};
+};
-- 
1.8.3.2

