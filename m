From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/4] ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
Date: Mon, 4 Jul 2016 15:25:11 +0530
Message-ID: <1467626113-15705-3-git-send-email-j-keerthy@ti.com>
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
 arch/arm/boot/dts/am437x-sk-evm.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 3af92b6..cd2222e 100644
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
@@ -463,7 +460,6 @@
 		};
 
 		dcdc4: regulator-dcdc4 {
-			compatible = "ti,tps65218-dcdc4";
 			regulator-name = "v3_3d";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
@@ -496,7 +492,6 @@
 		};
 
 		ldo1: regulator-ldo1 {
-			compatible = "ti,tps65218-ldo1";
 			regulator-name = "v1_8d";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
-- 
1.9.1
