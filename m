From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 13/22] ARM: omap4-sdp.dts: add display information
Date: Fri, 9 Aug 2013 11:38:58 +0300
Message-ID: <1376037547-10859-14-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030674Ab3HIIj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 04:39:58 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..49f98b1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -532,3 +532,73 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&dsi1 {
+	vdds_dsi-supply = <&vcxio>;
+};
+
+&dsi2 {
+	vdds_dsi-supply = <&vcxio>;
+};
+
+&hdmi {
+	vdda_hdmi_dac-supply = <&vdac>;
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+		display1 = &lcd1;
+		display2 = &hdmi0;
+	};
+
+	lcd0: display@0 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		video-source = <&dsi1>;
+
+		lanes = <
+			0       /* clk + */
+			1       /* clk - */
+			2       /* data1 + */
+			3       /* data1 - */
+			4       /* data2 + */
+			5       /* data2 - */
+		>;
+
+		gpios = <&gpio4 6 0>;	/* 102, reset */
+	};
+
+	lcd1: display@1 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		video-source = <&dsi2>;
+
+		lanes = <
+			0       /* clk + */
+			1       /* clk - */
+			2       /* data1 + */
+			3       /* data1 - */
+			4       /* data2 + */
+			5       /* data2 - */
+		>;
+
+		gpios = <&gpio4 8 0>;	/* 104, reset */
+	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		video-source = <&hdmi>;
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+	};
+
+	hdmi0: connector@0 {
+		compatible = "ti,hdmi_connector";
+
+		video-source = <&tpd12s015>;
+	};
+};
-- 
1.8.1.2

