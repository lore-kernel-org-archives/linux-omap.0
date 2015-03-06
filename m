From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 7/7] ARM: dts: am335x-boneblack: Use new binding for HDMI
Date: Fri, 6 Mar 2015 17:36:35 +0200
Message-ID: <e68f9647bff12fda5c70b3f068d3feb3911bca91.1425656120.git.jsarha@ti.com>
References: <cover.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbbCFPhR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 10:37:17 -0500
In-Reply-To: <cover.1425656120.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

Use new binding for the external tda19988 HDMI encoder.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 5c42d25..eadbba3 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -68,16 +68,26 @@
 
 &lcdc {
 	status = "okay";
+	port {
+		lcdc_0: endpoint@0 {
+			remote-endpoint = <&hdmi_0>;
+		};
+	};
 };
 
-/ {
-	hdmi {
-		compatible = "ti,tilcdc,slave";
-		i2c = <&i2c0>;
+&i2c0 {
+	tda19988 {
+		compatible = "nxp,tda998x";
+		reg = <0x70>;
 		pinctrl-names = "default", "off";
 		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
-		status = "okay";
+
+		port {
+			hdmi_0: endpoint@0 {
+				remote-endpoint = <&lcdc_0>;
+			};
+		};
 	};
 };
 
-- 
1.9.1

