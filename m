From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/26] ARM: omap3-beagle.dts: add display information
Date: Wed, 4 Dec 2013 14:28:45 +0200
Message-ID: <1386160133-24026-19-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293Ab3LDMa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 07:30:28 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fa532aaacc68..1ca1932d02aa 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -178,3 +178,70 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+&venc {
+	vdda_dac-supply = <&vdac>;
+
+	venc_out: endpoint {
+		remote-endpoint = <&tv_connector_in>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+		display1 = &tv0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio5 10 0>;	/* 170, power-down */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@1 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi_connector";
+		i2c-bus = <&i2c3>;
+
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
+
+	tv0: connector@1 {
+		compatible = "ti,svideo_connector";
+
+		tv_connector_in: endpoint {
+			remote-endpoint = <&venc_out>;
+		};
+	};
+};
-- 
1.8.3.2

