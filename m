From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 12/14] ARM: omap4-sdp.dts: add display information
Date: Wed, 27 Mar 2013 10:45:19 +0200
Message-ID: <1364373921-7599-13-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47702 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab3C0Iqm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:42 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 43e5258..3bef36e 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -428,3 +428,67 @@
 &twl_usb_comparator {
 	usb-supply = <&vusb>;
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
+	lcd {
+		compatible = "tpo,taal";
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
+	lcd2 {
+		compatible = "tpo,taal";
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
+	tpd12s015: tpd12s015 {
+		compatible = "ti,tpd12s015";
+
+		video-source = <&hdmi>;
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+	};
+
+	hdmi {
+		compatible = "ti,hdmi_connector";
+
+		video-source = <&tpd12s015>;
+	};
+};
-- 
1.7.10.4

