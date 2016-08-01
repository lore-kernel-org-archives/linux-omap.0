From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 04/10] ARM: dts: am335x/am437x: remove unneeded unit name for fixed regulators
Date: Mon,  1 Aug 2016 12:46:58 -0400
Message-ID: <1470070024-30281-5-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /fixedregulator@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-baltos.dtsi      | 4 ++--
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts      | 4 ++--
 arch/arm/boot/dts/am335x-evm.dts          | 6 +++---
 arch/arm/boot/dts/am335x-evmsk.dts        | 8 ++++----
 arch/arm/boot/dts/am335x-icev2.dts        | 4 ++--
 arch/arm/boot/dts/am335x-igep0033.dtsi    | 4 ++--
 arch/arm/boot/dts/am335x-lxm.dts          | 4 ++--
 arch/arm/boot/dts/am335x-pepper.dts       | 6 +++---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 arch/arm/boot/dts/am335x-shc.dts          | 2 +-
 arch/arm/boot/dts/am335x-sl50.dts         | 2 +-
 arch/arm/boot/dts/am335x-wega.dtsi        | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts      | 2 +-
 14 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index c8609d8d2c55..5e5447637a60 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -29,7 +29,7 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -37,7 +37,7 @@
 		regulator-boot-on;
 	};
 
-	wl12xx_vmmc: fixedregulator@2 {
+	wl12xx_vmmc: fixedregulator2 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wl12xx_gpio>;
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e247c15e5176..d4890149dac4 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -57,7 +57,7 @@
 		};
 	};
 
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 817b1dec0683..1dbc70de1070 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -34,7 +34,7 @@
 	};
 
 	/* regulator for mmc */
-	vmmc_fixed: fixedregulator@0 {
+	vmmc_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc_fixed";
 		regulator-min-microvolt = <3300000>;
@@ -42,7 +42,7 @@
 	};
 
 	/* Regulator for WiFi */
-	vwlan_fixed: fixedregulator@2 {
+	vwlan_fixed: fixedregulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vwlan_fixed";
 		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>; /* gpio0_20 */
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d5e6da5a782a..63124f898186 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -25,7 +25,7 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -33,13 +33,13 @@
 		regulator-boot-on;
 	};
 
-	lis3_reg: fixedregulator@1 {
+	lis3_reg: fixedregulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
 
-	wlan_en_reg: fixedregulator@2 {
+	wlan_en_reg: fixedregulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan-en-regulator";
 		regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 09308d66645b..c96c42cb84f6 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -40,13 +40,13 @@
 		regulator-boot-on;
 	};
 
-	lis3_reg: fixedregulator@1 {
+	lis3_reg: fixedregulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
 
-	wl12xx_vmmc: fixedregulator@2 {
+	wl12xx_vmmc: fixedregulator2 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wl12xx_gpio>;
 		compatible = "regulator-fixed";
@@ -58,7 +58,7 @@
 		enable-active-high;
 	};
 
-	vtt_fixed: fixedregulator@3 {
+	vtt_fixed: fixedregulator3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt";
 		regulator-min-microvolt = <1500000>;
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 7d8b8fefdf08..859e801f7627 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -24,7 +24,7 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -32,7 +32,7 @@
 		regulator-boot-on;
 	};
 
-	vtt_fixed: fixedregulator@1 {
+	vtt_fixed: fixedregulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt";
 		regulator-min-microvolt = <1500000>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index df63484ef9b3..639bb9748942 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -38,7 +38,7 @@
 		};
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -46,7 +46,7 @@
 		regulator-boot-on;
 	};
 
-	vmmc: fixedregulator@0 {
+	vmmc: fixedregulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index d97b0efa43f3..6594ce7449f3 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -25,7 +25,7 @@
 	};
 
 	/* Power supply provides a fixed 5V @2A */
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
@@ -34,7 +34,7 @@
 	};
 
 	/* Power supply provides a fixed 3.3V @3A */
-	vmmcsd_fixed: fixedregulator@1 {
+	vmmcsd_fixed: fixedregulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 8867aaaec54d..5fe52a3a7f47 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -41,15 +41,15 @@
 		compatible = "ti,da830-evm-audio";
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 	};
 
-	v3v3c_reg: fixedregulator@1 {
+	v3v3c_reg: fixedregulator1 {
 		compatible = "regulator-fixed";
 	};
 
-	vdd5_reg: fixedregulator@2 {
+	vdd5_reg: fixedregulator2 {
 		compatible = "regulator-fixed";
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 86f773165d5c..0eb26ab5e5f5 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -33,7 +33,7 @@
 	regulators {
 		compatible = "simple-bus";
 
-		vcc5v: fixedregulator@0 {
+		vcc5v: fixedregulator0 {
 			compatible = "regulator-fixed";
 			regulator-name = "vcc5v";
 			regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 837d5b80ea1d..41b1b1206c31 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -107,7 +107,7 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index a6efbe6eda3b..560ebfcddcc5 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -103,7 +103,7 @@
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 	};
 
-	vmmcsd_fixed: fixedregulator@0 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 282f6d4b27bc..d5fdf6244af8 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -14,7 +14,7 @@
 	regulators {
 		compatible = "simple-bus";
 
-		vcc3v3: fixedregulator@1 {
+		vcc3v3: fixedregulator1 {
 			compatible = "regulator-fixed";
 			regulator-name = "vcc3v3";
 			regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 3ce23f2920e6..a44580248571 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -32,7 +32,7 @@
 		enable-active-high;
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
-- 
2.5.5
