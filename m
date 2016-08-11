From: Keerthy <j-keerthy@ti.com>
Subject: [RESEND PATCH 1/3] ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6 enable during suspend
Date: Thu, 11 Aug 2016 10:57:48 +0530
Message-ID: <1470893270-5042-2-git-send-email-j-keerthy@ti.com>
References: <1470893270-5042-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470893270-5042-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

dcdc3, dcdc5, dcdc6 supply ddr and rtc respectively. These
are required to be on during suspend. Hence set the state accordingly.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 10 ++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 14677d5..fba26c9 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -537,7 +537,11 @@
 			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
+
 		dcdc5: regulator-dcdc5 {
 			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
@@ -545,6 +549,9 @@
 			regulator-max-microvolt = <1000000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		dcdc6: regulator-dcdc6 {
@@ -554,6 +561,9 @@
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		ldo1: regulator-ldo1 {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 5687d6b..b5e84e6 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -454,6 +454,9 @@
 			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		dcdc4: regulator-dcdc4 {
@@ -465,6 +468,30 @@
 			regulator-always-on;
 		};
 
+		dcdc5: regulator-dcdc5 {
+			compatible = "ti,tps65218-dcdc5";
+			regulator-name = "v1_0bat";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+
+		dcdc6: regulator-dcdc6 {
+			compatible = "ti,tps65218-dcdc6";
+			regulator-name = "v1_8bat";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+
 		ldo1: regulator-ldo1 {
 			compatible = "ti,tps65218-ldo1";
 			regulator-name = "v1_8d";
-- 
1.9.1
