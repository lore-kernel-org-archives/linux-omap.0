From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 7/8] ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
Date: Mon, 27 Jun 2016 16:31:44 +0530
Message-ID: <1467025305-13464-8-git-send-email-j-keerthy@ti.com>
References: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

With the device tree parsing using the regulator framework
there is a no longer a need for separate compatibles for
individual regulator nodes. Hence removing them all.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 9551c47..9e92d48 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -209,7 +209,6 @@
 		#interrupt-cells = <2>;
 
 		dcdc1: regulator-dcdc1 {
-			compatible = "ti,tps65218-dcdc1";
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1144000>;
@@ -218,7 +217,6 @@
 		};
 
 		dcdc2: regulator-dcdc2 {
-			compatible = "ti,tps65218-dcdc2";
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1378000>;
@@ -227,7 +225,6 @@
 		};
 
 		dcdc3: regulator-dcdc3 {
-			compatible = "ti,tps65218-dcdc3";
 			regulator-name = "vdcdc3";
 			regulator-suspend-enable;
 			regulator-min-microvolt = <1500000>;
@@ -237,7 +234,6 @@
 		};
 
 		dcdc5: regulator-dcdc5 {
-			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
@@ -246,7 +242,6 @@
 		};
 
 		dcdc6: regulator-dcdc6 {
-			compatible = "ti,tps65218-dcdc6";
 			regulator-name = "v1_8bat";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -255,7 +250,6 @@
 		};
 
 		ldo1: regulator-ldo1 {
-			compatible = "ti,tps65218-ldo1";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
-- 
1.9.1
