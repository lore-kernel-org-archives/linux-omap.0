From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 08/14] DTS: TWL4030: Add missing regulators
Date: Wed, 23 Oct 2013 00:49:37 +0200
Message-ID: <1382482183-14426-9-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

The twl4030.dtsi is missing some regulators. This patch adds
the missing ones and orders the regulators alphabetically.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 44 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ae6a17a..cb5afcd 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -23,6 +23,22 @@
 		compatible = "ti,twl4030-wdt";
 	};
 
+	vaux1: regulator-vaux1 {
+		compatible = "ti,twl4030-vaux1";
+	};
+
+	vaux2: regulator-vaux2 {
+		compatible = "ti,twl4030-vaux2";
+	};
+
+	vaux3: regulator-vaux3 {
+		compatible = "ti,twl4030-vaux3";
+	};
+
+	vaux4: regulator-vaux4 {
+		compatible = "ti,twl4030-vaux4";
+	};
+
 	vcc: regulator-vdd1 {
 		compatible = "ti,twl4030-vdd1";
 		regulator-min-microvolt = <600000>;
@@ -35,10 +51,20 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
-	vpll2: regulator-vpll2 {
-		compatible = "ti,twl4030-vpll2";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+	vio: regulator-vio {
+		compatible = "ti,twl4030-vio";
+	};
+
+	vintana1: regulator-vintana1 {
+		compatible = "ti,twl4030-vintana1";
+	};
+
+	vintana2: regulator-vintana2 {
+		compatible = "ti,twl4030-vintana2";
+	};
+
+	vintdig: regulator-vintdig {
+		compatible = "ti,twl4030-vintdig";
 	};
 
 	vmmc1: regulator-vmmc1 {
@@ -65,6 +91,16 @@
 		compatible = "ti,twl4030-vusb3v1";
 	};
 
+	vpll1: regulator-vpll1 {
+		compatible = "ti,twl4030-vpll1";
+	};
+
+	vpll2: regulator-vpll2 {
+		compatible = "ti,twl4030-vpll2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vsim: regulator-vsim {
 		compatible = "ti,twl4030-vsim";
 		regulator-min-microvolt = <1800000>;
-- 
1.8.4.rc3
