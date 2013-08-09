From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 12/22] ARM: omap4-panda.dts: add display information
Date: Fri, 9 Aug 2013 11:38:57 +0300
Message-ID: <1376037547-10859-13-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030590Ab3HIIkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:40:07 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..fa65b19 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -357,3 +357,51 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
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
+		display0 = &dvi0;
+		display1 = &hdmi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		video-source = <&dpi>;
+		data-lines = <24>;
+		gpios = <&gpio1 0 0>;	/* 0, power-down */
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi_connector";
+		video-source = <&tfp410>;
+		i2c-bus = <&i2c3>;
+	};
+
+	tpd12s015: encoder@1 {
+		compatible = "ti,tpd12s015";
+
+		video-source = <&hdmi>;
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+	};
+
+	hdmi0: connector@1 {
+		compatible = "ti,hdmi_connector";
+
+		video-source = <&tpd12s015>;
+	};
+};
-- 
1.8.1.2

