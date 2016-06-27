From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 5/8] ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
Date: Mon, 27 Jun 2016 16:31:42 +0530
Message-ID: <1467025305-13464-6-git-send-email-j-keerthy@ti.com>
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
 arch/arm/boot/dts/am437x-gp-evm.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 8889be1..67329e0 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -513,7 +513,6 @@
 		#interrupt-cells = <2>;
 
 		dcdc1: regulator-dcdc1 {
-			compatible = "ti,tps65218-dcdc1";
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1144000>;
@@ -522,7 +521,6 @@
 		};
 
 		dcdc2: regulator-dcdc2 {
-			compatible = "ti,tps65218-dcdc2";
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1378000>;
@@ -531,7 +529,6 @@
 		};
 
 		dcdc3: regulator-dcdc3 {
-			compatible = "ti,tps65218-dcdc3";
 			regulator-name = "vdcdc3";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
@@ -539,7 +536,6 @@
 			regulator-always-on;
 		};
 		dcdc5: regulator-dcdc5 {
-			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
@@ -548,7 +544,6 @@
 		};
 
 		dcdc6: regulator-dcdc6 {
-			compatible = "ti,tps65218-dcdc6";
 			regulator-name = "v1_8bat";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -557,7 +552,6 @@
 		};
 
 		ldo1: regulator-ldo1 {
-			compatible = "ti,tps65218-ldo1";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
-- 
1.9.1
