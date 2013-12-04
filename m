From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/26] ARM: omap4-sdp.dts: add display information
Date: Wed, 4 Dec 2013 14:28:43 +0200
Message-ID: <1386160133-24026-17-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285Ab3LDMaY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:24 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 91 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5fc3f43c5a81..e3048f849612 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -550,3 +550,94 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&dsi1 {
+	vdds_dsi-supply = <&vcxio>;
+
+	dsi1_out_ep: endpoint {
+		remote-endpoint = <&lcd0_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd0: display@0 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		gpios = <&gpio4 6 0>;	/* 102, reset */
+
+		lcd0_in: endpoint {
+			remote-endpoint = <&dsi1_out_ep>;
+		};
+	};
+};
+
+&dsi2 {
+	vdds_dsi-supply = <&vcxio>;
+
+	dsi2_out_ep: endpoint {
+		remote-endpoint = <&lcd1_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd1: display@1 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		gpios = <&gpio4 8 0>;	/* 104, reset */
+
+		lcd1_in: endpoint {
+			remote-endpoint = <&dsi2_out_ep>;
+		};
+	};
+};
+
+&hdmi {
+	vdda_hdmi_dac-supply = <&vdac>;
+
+	hdmi_out: endpoint {
+		remote-endpoint = <&tpd12s015_in>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+		display1 = &lcd1;
+		display2 = &hdmi0;
+	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint@0 {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint@1 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "ti,hdmi-connector";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&tpd12s015_out>;
+		};
+	};
+};
-- 
1.8.3.2

