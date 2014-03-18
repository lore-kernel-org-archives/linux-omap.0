From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 2/2] ARM: DTS: AM43x: Add sii9022 dt information
Date: Tue, 18 Mar 2014 15:37:57 +0530
Message-ID: <1395137278-5065-3-git-send-email-sathyap@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56246 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbaCRKIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:08:19 -0400
In-Reply-To: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

AM43x-epos and AM437x-gp device use external sii9022
DPI to HDMI encoder.
Sii9022 use i2c for communication.
Sii9022 dt entries are added to corresponding dts.

Signed-off-by: Sathya prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  |   58 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/am43x-epos-evm.dts |   59 ++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index a178e8d..c4225b1 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -51,6 +51,41 @@
 			remote-endpoint = <&dpi_out>;
 		};
 	};
+
+	sii9022: encoder@0 {
+		compatible = "sii,sii9022";
+		reset-gpio = <&gpio5 8 GPIO_ACTIVE_LOW>;/* 'SelLCDorHDMI' Gpio, LOW to select HDMI */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint@0 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&sil9022_out>;
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -119,6 +154,9 @@
         status = "okay";
         pinctrl-names = "default";
         pinctrl-0 = <&i2c1_pins>;
+	&sii9022 {
+		reg = <0x3b>;
+	}
 };
 
 &epwmss0 {
@@ -141,8 +179,22 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_pinctrl>;
 
-	dpi_out: endpoint@0 {
-		remote-endpoint = <&lcd_in>;
-		data-lines = <24>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dpi_out: endpoint@0 {
+				remote-endpoint = <&lcd_in>;
+				data-lines = <24>;
+			};
+
+			dpi_out:endpoint@1 {
+				remote-endpoint = <&sii9022_in>;
+				data-lines = <24>;
+
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 3f9643b..22bfa5e 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -29,6 +29,7 @@
 
 	aliases {
 		display0 = &lcd0;
+		display1 = &hdmi0;
 	};
 
 	lcd0: display {
@@ -54,6 +55,41 @@
 		};
 	};
 
+	sii9022: encoder@0 {
+		compatible = "sii,sii9022";
+		reset-gpio = <&gpio2 1 GPIO_ACTIVE_LOW>;/* 65'SelLCDorHDMI' Gpio, LOW to select HDMI */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint@0 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&sil9022_out>;
+		};
+	};
+
 	am43xx_pinmux: pinmux@44e10800 {
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
@@ -284,6 +320,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
+	&sii9022 {
+		reg = <0x3b>;
+	}
 };
 
 &gpio0 {
@@ -347,8 +386,22 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_pinctrl>;
 
-	dpi_out: endpoint@0 {
-		remote-endpoint = <&lcd_in>;
-		data-lines = <24>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dpi_out: endpoint@0 {
+				remote-endpoint = <&lcd_in>;
+				data-lines = <24>;
+			};
+
+			dpi_out:endpoint@1 {
+				remote-endpoint = <&sii9022_in>;
+				data-lines = <24>;
+
+			};
+		};
 	};
 };
-- 
1.7.9.5

