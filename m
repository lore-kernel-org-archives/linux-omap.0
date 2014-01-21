From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 41/41] Doc/DT: Add DT binding documentation for tpd12s015 encoder
Date: Tue, 21 Jan 2014 12:57:13 +0200
Message-ID: <1390301833-24944-42-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbaAULBp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:45 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT binding documentation for tpd12s015 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
new file mode 100644
index 000000000000..26e6d32e3f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
@@ -0,0 +1,44 @@
+TPD12S015 HDMI level shifter and ESD protection chip
+====================================================
+
+Required properties:
+- compatible: "ti,tpd12s015"
+
+Optional properties:
+- gpios: CT CP HPD, LS OE and HPD gpios
+
+Required nodes:
+- Video port 0 for HDMI input
+- Video port 1 for HDMI output
+
+Example
+-------
+
+tpd12s015: encoder@1 {
+	compatible = "ti,tpd12s015";
+
+	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tpd12s015_in: endpoint@0 {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			tpd12s015_out: endpoint@0 {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2

