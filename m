From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 6/8] ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
Date: Wed, 11 May 2016 11:18:09 +0530
Message-ID: <1462945691-904-7-git-send-email-j-keerthy@ti.com>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikita@compulab.co.il, nm@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

With the device tree parsing using the regulator framework
there is a no longer a need for separate compatibles for
individual regulator nodes. Hence removing them all.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index d82dd6e..1b404fd 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -428,7 +428,6 @@
 		#interrupt-cells = <2>;
 
 		dcdc1: regulator-dcdc1 {
-			compatible = "ti,tps65218-dcdc1";
 			/* VDD_CORE limits min of OPP50 and max of OPP100 */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <912000>;
@@ -438,7 +437,6 @@
 		};
 
 		dcdc2: regulator-dcdc2 {
-			compatible = "ti,tps65218-dcdc2";
 			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <912000>;
@@ -448,7 +446,6 @@
 		};
 
 		dcdc3: regulator-dcdc3 {
-			compatible = "ti,tps65218-dcdc3";
 			regulator-name = "vdds_ddr";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
@@ -457,7 +454,6 @@
 		};
 
 		dcdc4: regulator-dcdc4 {
-			compatible = "ti,tps65218-dcdc4";
 			regulator-name = "v3_3d";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
@@ -466,7 +462,6 @@
 		};
 
 		ldo1: regulator-ldo1 {
-			compatible = "ti,tps65218-ldo1";
 			regulator-name = "v1_8d";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
-- 
1.9.1
