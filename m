From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/3] ARM: dts: logicpd-torpedo-baseboard: Fix missing video
Date: Wed, 28 Aug 2019 13:33:50 -0500
Message-ID: <20190828183351.822-2-aford173@gmail.com>
References: <20190828183351.822-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828183351.822-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

A previous commit removed the panel-dpi driver, which made the
Torpedo video stop working because it relied on the dpi driver
for setting video timings.  Now that the simple-panel driver is
available in omap2plus, this patch migrates the Torpedo dev kits
to use a similar panel and remove the manual timing requirements.

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index 642e809e757a..449cc7616da6 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -108,7 +108,6 @@
 &dss {
 	status = "ok";
 	vdds_dsi-supply = <&vpll2>;
-	vdda_video-supply = <&video_reg>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_dpi_pins1>;
 	port {
@@ -124,44 +123,20 @@
 		display0 = &lcd0;
 	};
 
-	video_reg: video_reg {
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_pwr_pins>;
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd INI */
-	};
-
 	lcd0: display {
-		compatible = "panel-dpi";
+		/* This isn't the exact LCD, but the timings meet spec */
+		/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
+		compatible = "newhaven,nhd-4.3-480272ef-atxl";
 		label = "15";
-		status = "okay";
-		/* default-on; */
 		pinctrl-names = "default";
-
+		pinctrl-0 = <&panel_pwr_pins>;
+		backlight = <&bl>;
+		enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
 		port {
 			lcd_in: endpoint {
 				remote-endpoint = <&dpi_out>;
 			};
 		};
-
-		panel-timing {
-			clock-frequency = <9000000>;
-			hactive = <480>;
-			vactive = <272>;
-			hfront-porch = <3>;
-			hback-porch = <2>;
-			hsync-len = <42>;
-			vback-porch = <3>;
-			vfront-porch = <4>;
-			vsync-len = <11>;
-			hsync-active = <0>;
-			vsync-active = <0>;
-			de-active = <1>;
-			pixelclk-active = <1>;
-		};
 	};
 
 	bl: backlight {
-- 
2.17.1
