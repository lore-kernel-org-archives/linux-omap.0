From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/26] ARM: omap3-tobi.dts: add lcd (TEST)
Date: Wed, 4 Dec 2013 14:28:44 +0200
Message-ID: <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292Ab3LDMa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:26 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
it as a test.

Not to be merged.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-tobi.dts | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 7e4ad2aec37a..49c6f3f17804 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -81,3 +81,43 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <24>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display@0 {
+		compatible = "samsung,lte430wq-f0c", "panel-dpi";
+
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+
+		panel-timing {
+			clock-frequency = <9200000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <8>;
+			hback-porch = <4>;
+			hsync-len = <41>;
+			vback-porch = <2>;
+			vfront-porch = <4>;
+			vsync-len = <10>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
-- 
1.8.3.2

