From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 15/22] ARM: omap3-beagle.dts: add display information
Date: Fri, 9 Aug 2013 11:39:00 +0300
Message-ID: <1376037547-10859-16-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57757 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030675Ab3HIIj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 04:39:59 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index dfd8310..17cb9b0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -180,3 +180,32 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio1_pins>;
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
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
+		video-source = <&dpi>;
+		data-lines = <24>;
+		gpios = <&gpio5 10 0>;	/* 170, power-down */
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi_connector";
+		video-source = <&tfp410>;
+		i2c-bus = <&i2c3>;
+	};
+
+	tv0: connector@1 {
+		compatible = "ti,svideo_connector";
+		video-source = <&venc>;
+	};
+};
-- 
1.8.1.2

