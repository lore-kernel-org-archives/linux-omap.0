From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 5/5] Documentation: dt: Document ACX565AKM DT binding
Date: Sat, 23 Nov 2013 21:57:24 +0100
Message-ID: <1385240244-28629-6-git-send-email-sre@debian.org>
References: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56853 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219Ab3KWU6H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:07 -0500
In-Reply-To: <1385240244-28629-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add devicetree binding documentation for ACX565AKM panel.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../devicetree/bindings/video/sony,acx565akm.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt

diff --git a/Documentation/devicetree/bindings/video/sony,acx565akm.txt b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
new file mode 100644
index 0000000..41f2284
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
@@ -0,0 +1,22 @@
+Device-Tree bindings for Sony ACX565AKM panel driver
+
+Required properties:
+- compatible: value should be one among the following:
+ * "sony,acx565akm"
+- reg: integer, chip select id of the panel
+- spi-max-frequency: integer, maximal frequency of spi connection
+- label: string, label for the panel (e.g. "lcd")
+- reset-gpio: phandle + gpio specifier for the reset gpio
+
+Example:
+
+&mcspi1 {
+	mipid@2 {
+		compatible = "sony,acx565akm";
+		spi-max-frequency = <6000000>;
+		reg = <2>;
+
+		label = "lcd";
+		reset-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* gpio 90 */
+	};
+};
-- 
1.8.4.3

