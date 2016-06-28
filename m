From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 07/10] ARM: dts: AM437X-GP-EVM: Remove redundant regulator
 compatibles
Date: Tue, 28 Jun 2016 11:36:17 +0530
Message-ID: <1467093980-11458-8-git-send-email-j-keerthy@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the device tree parsing using the regulator framework
there is a no longer a need for separate compatibles for
individual regulator nodes. Hence removing them all.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84832bf..dd974c7 100644
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
