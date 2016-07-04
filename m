From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles
Date: Mon, 4 Jul 2016 15:25:13 +0530
Message-ID: <1467626113-15705-5-git-send-email-j-keerthy@ti.com>
References: <1467626113-15705-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467626113-15705-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lee.jones@linaro.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

With the device tree parsing using the regulator framework
there is a no longer a need for separate compatibles for
individual regulator nodes. Hence removing them all.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ad32e55..1c11e9f 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -421,7 +421,6 @@
 		#interrupt-cells = <2>;
 
 		dcdc1: regulator-dcdc1 {
-			compatible = "ti,tps65218-dcdc1";
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1144000>;
@@ -430,7 +429,6 @@
 		};
 
 		dcdc2: regulator-dcdc2 {
-			compatible = "ti,tps65218-dcdc2";
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <1378000>;
@@ -439,7 +437,6 @@
 		};
 
 		dcdc3: regulator-dcdc3 {
-			compatible = "ti,tps65218-dcdc3";
 			regulator-name = "vdcdc3";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
@@ -448,7 +445,6 @@
 		};
 
 		dcdc4: regulator-dcdc4 {
-			compatible = "ti,tps65218-dcdc4";
 			regulator-name = "vdcdc4";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
@@ -457,21 +453,18 @@
 		};
 
 		dcdc5: regulator-dcdc5 {
-			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
 
 		dcdc6: regulator-dcdc6 {
-			compatible = "ti,tps65218-dcdc6";
 			regulator-name = "v1_8bat";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
 
 		ldo1: regulator-ldo1 {
-			compatible = "ti,tps65218-ldo1";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
-- 
1.9.1
